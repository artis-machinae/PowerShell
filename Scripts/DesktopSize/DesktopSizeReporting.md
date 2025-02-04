<#
Copyright 2023 artis-machinae.github.io

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#>

======================================================================
What is this?
======================================================================


For Windows clients; reports the following data to a log located on the network (excluding default OS profiles):
- All user profiles' Desktop folder size 
- Hostname
- Date stamp

Profiles using OneDrive will not report.

Remember to edit the variable amReportLocation to reflect the correct network path for said report.

Network access is recommended; an offline report will be generated if it fails.

Clients will only record this infomration once. If you want to run it periodically, rename the existing report so a new one is generated.


This script is best deployed with a client manager such as CCM. Stagger slightly to avoid file lock conflicts.


It could also be run individually on a system to gather said information if you so choose.

Folders size will be reported in MB. This can be changed to TB in the amDirSize variable.
Rounding will not occur; you can add that if you wish.



======================================================================
Can you make it do something else?
======================================================================

Requests to add different profile folders (Documents, Downloads, include local OneDrive stats, etc.) will be considered; or you can add your own. You can contact me on GitHub

https://artis-machinae.github.io

with the details of what functionality you want, and a haiku.
Otherwise, I have full faith in you to figure it out.
