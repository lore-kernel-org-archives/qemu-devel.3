Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FFDEB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpuxn-0006yR-FT; Tue, 10 Feb 2026 16:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpuxm-0006yJ-8D
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:08:02 -0500
Received: from p-west1-cluster1-host7-snip4-5.eps.apple.com ([57.103.64.28]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpuxj-000206-6j
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:08:01 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 61EB41800347; Tue, 10 Feb 2026 21:07:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770757675; x=1773349675;
 bh=cxxiD190sElAPiSGgaOttGjH1zwGCnkmHecM0c1qR4g=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=eWVPE01R/7AYn0FqAFx8PgaOWYozohC37RBVKmbFkcHXztkTmI/GI21rS2t4dgEY4qnTMBN34QY+gIqGbc+CooviAGprZeJaa5NZoXMEt73Y4CPsn23/KyDbxf6/1gdkgkkPo7keoHMFacWzgfF5iOBpJaqnbokMnSZvEwSK5A+VRu6MA7LDkG2U/aPiS1FkMDnoMilUCrTnzVmTwWdi1oMAvEs9qwQg2ZWTvV2dCq1klQVkDEFqXqZHqViscaSbzp6vsXG/EADQEL2pMdeGkrVDFxna0IW2RANjQn8OYvXboiSDwHWtF2OcImzK5fIC+Ok9g2PW7w29XUqaBssUNw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 CFACD18007C5; Tue, 10 Feb 2026 21:07:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <A0A23422-F2F7-48B5-8A6F-F9BA15F269C2@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_8A4C9FE8-DB19-4A43-8487-0FCEDD36A0F1"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 1/1] plugins: fix cross-build using LLVM for Windows
 targets
Date: Tue, 10 Feb 2026 22:07:37 +0100
In-Reply-To: <08268821-626a-4a61-b2d0-7b4c6e973ba3@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260210040722.11375-1-mohamed@unpredictable.fr>
 <508e49cd-a37e-4388-827f-9e692c5f9905@linaro.org>
 <C933BE09-BFA4-4F13-87FA-2FD2994CCEE7@unpredictable.fr>
 <08268821-626a-4a61-b2d0-7b4c6e973ba3@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: rcFr4n8UrO38uqDGEi5uzTyBSvQcjYkG
X-Proofpoint-GUID: rcFr4n8UrO38uqDGEi5uzTyBSvQcjYkG
X-Authority-Info-Out: v=2.4 cv=O580fR9W c=1 sm=1 tr=0 ts=698b9e29
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=caOp8uj6GttcOIhbAcwA:9 a=CjuIK1q_8ugA:10
 a=aGHQF8uJNKrbnYVysgUA:9 a=5BFKGXWSHlWlNGAi:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NSBTYWx0ZWRfXxaYaibAmsh8n
 rocE8Cl1TzlSQuzgI2Qg269RffflBcvjyHmOXy+9J+6fxRZH4qZTshOitjnf2azRfn/T4TwZAL8
 bumqA6DNj1rPldxVJvel11jIecLau65ODdJ/vy4bT5WCYfd8r2zcWpUTQjvY0VqrVk9jrrVu096
 FybK8u31ejgQEN6Ah5Ta+t7cqXybbiBSZVchB2ravyMYjHnOjFuTlG5W+6wwOciqw1TfS2og7FZ
 0h8ExaDvOEN3fNjVDXKVduTFmnEGLpwb+pqJw0l2DJhAiNSxtdIkJJgWvJmO0i5ql6pYULgsqR9
 fBb6h5b8cYPJa5UT4VsdqGe7gesUP2rITrYq+Nb58gHhHfVf5QcAY5OCWei3Ac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100175
X-JNJ: AAAAAAABl7M5X7JSlIXMwe83SCfUmJ/xm4xfqxe9595+1pEAhf09dr9AUJOf1QGwiTMoP1cvC0VUiEzAym8oVzamPNu4pjJRo2oFymon9DgxY2sJgaWuhD766RGbI/CdMleBRRq6e9MSA/SJX5SnPfbZ3T/yVQTEKzikGmmlZGqp98IghiFaR5mGhYrtX0tEaqHnAGgCSuO0kyO8kOvbq+NNmouDQNWEHQsgriSdnyEuS1EmQuwECHvJA/dK5QX+f/vUsJJGsP3ydtDa6QWXm16iZwCpalL/ylYg9nGGotYCuMk4D0Lr8HRRFoB6kWXVIx9LcRhF/xFKuj5HRRrobZbiCdAef8TwlPw4NtZ+Eb4YM33HG+3l/ZSA5MIfJQXwMDX70R7gWmPKSDXvCAi23T7c8+44HHR7ffVVzpqQt6hfqanK5AsVyX8FhK0OQIs48vg4uqSV5QJ2msLju2qw+adLyhKhkBw4Lo1EwR6/8dsO7OM5Z+fwCys5vxZrtiXpyVU0lr8ZL5EtGINOBTNmaLTZZ240przM4YpKjyF1a5e90XCeF/yF7zNYdwVT+tIfWJrzDtbRMcNGRAChXP/Fr/q6xH5Mq8UK+Qf0xady2lt9LX+APkILeNNJV8SX6wWy8v5KWcr8I2IUW2UsQ2kwWD0W7vHAPqDpnxbxCRepV2DpOI56m9ZpXc8qKFJoW5xsT32sBQ==
Received-SPF: pass client-ip=57.103.64.28;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_8A4C9FE8-DB19-4A43-8487-0FCEDD36A0F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 10. Feb 2026, at 21:45, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 2/10/26 12:04 AM, Mohamed Mediouni wrote:
>>> On 10. Feb 2026, at 07:39, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>>>=20
>>> On 2/9/26 8:07 PM, Mohamed Mediouni wrote:
>>>> llvm-dlltool assumes that it's by default targeting the host =
architecture
>>>> it's running on. That assumption doesn't hold true when =
cross-compiling.
>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>> ---
>>>>  plugins/meson.build | 9 ++++++++-
>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>> diff --git a/plugins/meson.build b/plugins/meson.build
>>>> index 34643e2cea..9899f166ee 100644
>>>> --- a/plugins/meson.build
>>>> +++ b/plugins/meson.build
>>>> @@ -41,9 +41,16 @@ if host_os =3D=3D 'windows'
>>>>    # to find missing symbols in current program.
>>>>    win32_qemu_plugin_api_link_flags =3D ['-Lplugins', =
'-lqemu_plugin_api']
>>>>    if meson.get_compiler('c').get_id() =3D=3D 'clang'
>>>> +    if host_machine.cpu() =3D=3D 'x86_64'
>>>> +      dlltool_target =3D 'i386:x86-64'
>>>> +    elif host_machine.cpu() =3D=3D 'aarch64'
>>>> +      dlltool_target =3D 'arm64'
>>>> +    else
>>>> +      error('Unknown machine')
>>>> +    endif
>>>>      # With LLVM/lld, delaylib is specified at link time =
(-delayload)
>>>>      dlltool =3D find_program('llvm-dlltool', required: true)
>>>> -    dlltool_cmd =3D [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', =
'-D', 'qemu.exe']
>>>> +    dlltool_cmd =3D [dlltool, '-m', dlltool_target,'-d', =
'@INPUT@', '- l', '@OUTPUT@', '-D', 'qemu.exe']
>>>>      win32_qemu_plugin_api_link_flags +=3D =
['-Wl,-delayload=3Dqemu.exe']
>>>>    else
>>>>      # With gcc/ld, delay lib is built with a specific delay =
parameter.
>>>=20
>>> Interesting, on which setup did you find this?
>>>=20
>>> Regards,
>>> Pierrick
>> Hello,
>> Was found on my macOS arm64 laptop w/ using llvm-mingw and an MXE =
fork to build all the libs QEMU needed.
>> Cross-compiled for arm64 Windows initially from there, and came =
across this when targeting x86_64 from that setup.
>=20
> Ok thanks.
> When I cross compiled windows-arm64 -> windows-x86_64, I don't =
remember having to set it. That said, it does not hurt anyway, and =
everything still builds fine natively with it.
>=20
Hi,

Looking at msys2, that uses a separate toolchain copy for each =
architecture (at /clangarm64 and others)=20
configured to target a single arch. And with separate toolchain packages =
per architecture to correspond to that.

llvm-mingw (at https://github.com/mstorsjo/llvm-mingw) uses a single =
toolset copy for all the target architectures
instead, with platform-specific headers and libraries in a per-arch =
triplet folder.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>=20
> Regards,
> Pierrick
>=20


--Apple-Mail=_8A4C9FE8-DB19-4A43-8487-0FCEDD36A0F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 10. Feb 2026, at 21:45, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On 2/10/26 12:04 AM, =
Mohamed Mediouni wrote:<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">On 10. Feb 2026, at 07:39, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:<br><br>On 2/9/26 8:07 PM, =
Mohamed Mediouni wrote:<br><blockquote type=3D"cite">llvm-dlltool =
assumes that it's by default targeting the host architecture<br>it's =
running on. That assumption doesn't hold true when =
cross-compiling.<br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>&nbsp;plugins/meson.build | 9 =
++++++++-<br>&nbsp;1 file changed, 8 insertions(+), 1 =
deletion(-)<br>diff --git a/plugins/meson.build =
b/plugins/meson.build<br>index 34643e2cea..9899f166ee 100644<br>--- =
a/plugins/meson.build<br>+++ b/plugins/meson.build<br>@@ -41,9 +41,16 @@ =
if host_os =3D=3D 'windows'<br>&nbsp;&nbsp;&nbsp;# to find missing =
symbols in current =
program.<br>&nbsp;&nbsp;&nbsp;win32_qemu_plugin_api_link_flags =3D =
['-Lplugins', '-lqemu_plugin_api']<br>&nbsp;&nbsp;&nbsp;if =
meson.get_compiler('c').get_id() =3D=3D 'clang'<br>+ =
&nbsp;&nbsp;&nbsp;if host_machine.cpu() =3D=3D 'x86_64'<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dlltool_target =3D 'i386:x86-64'<br>+ =
&nbsp;&nbsp;&nbsp;elif host_machine.cpu() =3D=3D 'aarch64'<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dlltool_target =3D 'arm64'<br>+ =
&nbsp;&nbsp;&nbsp;else<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error('Unknown =
machine')<br>+ =
&nbsp;&nbsp;&nbsp;endif<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# With =
LLVM/lld, delaylib is specified at link time =
(-delayload)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dlltool =3D =
find_program('llvm-dlltool', required: true)<br>- =
&nbsp;&nbsp;&nbsp;dlltool_cmd =3D [dlltool, '-d', '@INPUT@', '-l', =
'@OUTPUT@', '-D', 'qemu.exe']<br>+ &nbsp;&nbsp;&nbsp;dlltool_cmd =3D =
[dlltool, '-m', dlltool_target,'-d', '@INPUT@', '- l', '@OUTPUT@', '-D', =
'qemu.exe']<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;win32_qemu_plugin_api_link_fl=
ags +=3D =
['-Wl,-delayload=3Dqemu.exe']<br>&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;# With gcc/ld, delay lib is built with a specific delay =
parameter.<br></blockquote><br>Interesting, on which setup did you find =
this?<br><br>Regards,<br>Pierrick<br></blockquote>Hello,<br>Was found on =
my macOS arm64 laptop w/ using llvm-mingw and an MXE fork to build all =
the libs QEMU needed.<br>Cross-compiled for arm64 Windows initially from =
there, and came across this when targeting x86_64 from that =
setup.<br></blockquote><br>Ok thanks.<br>When I cross compiled =
windows-arm64 -&gt; windows-x86_64, I don't remember having to set it. =
That said, it does not hurt anyway, and everything still builds fine =
natively with =
it.<br><br></div></div></blockquote><div>Hi,</div><div><br></div>Looking =
at msys2, that uses a separate toolchain copy for each architecture (at =
/clangarm64 and others)&nbsp;</div><div>configured to target a single =
arch. And with separate toolchain packages per architecture to =
correspond to that.</div><div><br></div><div>llvm-mingw (at&nbsp;<a =
href=3D"https://github.com/mstorsjo/llvm-mingw">https://github.com/mstorsj=
o/llvm-mingw</a>) uses a single toolset copy for all the target =
architectures</div><div>instead, with platform-specific headers and =
libraries in a per-arch triplet folder.</div><div><br><blockquote =
type=3D"cite"><div><div>Reviewed-by: Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt;<br>Tested-by: Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt;<br><br>Regards,<br>Pierrick<br><br></d=
iv></div></blockquote></div><br></body></html>=

--Apple-Mail=_8A4C9FE8-DB19-4A43-8487-0FCEDD36A0F1--

