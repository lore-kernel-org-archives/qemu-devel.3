Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35B2EA3F13
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpiji-00030v-Qv; Tue, 10 Feb 2026 03:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpijh-00030X-65
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:04:41 -0500
Received: from p-west3-cluster6-host6-snip4-10.eps.apple.com ([57.103.75.123]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpije-0008Uy-EK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:04:40 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 6D7EA180010E; Tue, 10 Feb 2026 08:04:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770710676; x=1773302676;
 bh=Z4sS8E8ZIdEk6OlxeNg1g+Znt7DUJvm0kKF+g6MmumU=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=XG/j6pLdFCH7L5YczREoDrWbxx+PQFQb9i0HXjD5i5wFwVTxT/ydCFPStLYM0SShrHapSQ3Xri5NQXeC2SACzHGJODiHZtnuDB2e+2RIEidm9rz+PIuz2tZZ1EyF4oD8BpBRkndVScgPbDoFl6sDTFDMASeAewn3IpEuVzIk08nko+BTvAIOZhUDpHF5YCnvYfV5OmaSxv4FzjHduUUqbIZDWxgWq0QCj3vENUjqGYMOTcfA8CgMiLwUpG73kciHaryOgaSSkHTtY3HqH4CWMFZtbdNMc2cFhTztmSWIb+58yhjuvy6keLWyZnZ9mf9aUrgbBiMt7/hP/sF1ulcdrw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 B0FE118000BE; Tue, 10 Feb 2026 08:04:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <C933BE09-BFA4-4F13-87FA-2FD2994CCEE7@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_49A92ACC-7662-43A4-B029-5820492421AE"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 1/1] plugins: fix cross-build using LLVM for Windows
 targets
Date: Tue, 10 Feb 2026 09:04:21 +0100
In-Reply-To: <508e49cd-a37e-4388-827f-9e692c5f9905@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260210040722.11375-1-mohamed@unpredictable.fr>
 <508e49cd-a37e-4388-827f-9e692c5f9905@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA2NyBTYWx0ZWRfX3tEmLokMOppO
 p4zgqaBRY+cqlPjeiinmq+U2n02FwIxSGCCSyCJKdAMnMPiYkiyafX7gxvfNffjQMRBm1FAy424
 WLQMyCd2hw5qTGCZpjJ3uKLb1tFP39XGFNpC2+siuze5hGK+2sw7Jdvu37LY9/srpUos3KGi7CU
 o14oHerUgt0RPJdVgL4+0i89EzB7GdE3hmfADKKXAP+Ycl8avpUp/plzLa3pTgrwMIrprsacBIz
 wbD6Ef1Ao5VzxnPSmmdlQ4gwkhIpPh9i7sDTwUY54iZPc4oCPD6kBYC8MRu6xD95iN8tPYULlYT
 a5GRwTHkx1ORRHrn9PsxS0sYWDehkxgSHmfNnkFIhR9HAt1yTd77epDZhAE2So=
X-Authority-Info-Out: v=2.4 cv=N9Uk1m9B c=1 sm=1 tr=0 ts=698ae693
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=UnDhwNk8kEjN3BYE-zAA:9 a=CjuIK1q_8ugA:10
 a=SZZrIOB_cXa7thZNgYcA:9 a=IvuJopzxlzhv5ibf:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hEHRDxuDfA3LsVC21UrDKJ2AgoWwVlhE
X-Proofpoint-GUID: hEHRDxuDfA3LsVC21UrDKJ2AgoWwVlhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100067
X-JNJ: AAAAAAABDsRJn1173U1R9wAc9D61m1wBQ9XM1y3d/MPIl0J2UQ5+K99Uc178uh/LxJDPfSgeIXHaRr3UhdRaIptZcOTIiIW4QzCc+OZAFXr7POsOKx1tFxlyEDs0jRD5gMZ9SwS67n534QLCchIkWoL7bx05WXXde3++3senwluZDCCfk+7CtDdEv32+I8MR6+xh5mw/46Ra8LiBa2kOF/tKHhUB5BqGuuV97bGvfpROpIkCFao+R+5GDYmcAYtdtnvZPkCGwdBSg7w/P6YlSiMj2coZF8U+3/xrWmc5z2wWGK0ufqLeyXDpRO95DyVUqGhWboW2nlRVcGtrKjdzIqe7A75fxRqCk40kagsUL1LUuOHaQHOjIqqPJm2e8JpLDanJ6aGybIoU2bbOznfGOaz66tNsmyUo9UGu9Ghg8SA93ofPLIz+qFNVaWPd/gTUBoSsb2ouGx3XLjzIry/t9hVn3P7QOQ9VCrRM40Sxj8IY1wbOfDp1nlzkOeTyEha5Wc+FNg35lD4VxSO9k+FMDUxW2LmOOcxAoUag+bRQ+zNIrI9GH/H16F5xCVJAygFVFsLO/A8Da1oJMhIRCPw6pW8IKDPCrsPH6sCST+80Zh2nXrAYRxebU/BAuxF568nQ7VWa3WivOZE0vudiXuW87SkWhL4yDFO8Er+7nCDOiQTJeSIu
Received-SPF: pass client-ip=57.103.75.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Apple-Mail=_49A92ACC-7662-43A4-B029-5820492421AE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 10. Feb 2026, at 07:39, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 2/9/26 8:07 PM, Mohamed Mediouni wrote:
>> llvm-dlltool assumes that it's by default targeting the host =
architecture
>> it's running on. That assumption doesn't hold true when =
cross-compiling.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  plugins/meson.build | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>> diff --git a/plugins/meson.build b/plugins/meson.build
>> index 34643e2cea..9899f166ee 100644
>> --- a/plugins/meson.build
>> +++ b/plugins/meson.build
>> @@ -41,9 +41,16 @@ if host_os =3D=3D 'windows'
>>    # to find missing symbols in current program.
>>    win32_qemu_plugin_api_link_flags =3D ['-Lplugins', =
'-lqemu_plugin_api']
>>    if meson.get_compiler('c').get_id() =3D=3D 'clang'
>> +    if host_machine.cpu() =3D=3D 'x86_64'
>> +      dlltool_target =3D 'i386:x86-64'
>> +    elif host_machine.cpu() =3D=3D 'aarch64'
>> +      dlltool_target =3D 'arm64'
>> +    else
>> +      error('Unknown machine')
>> +    endif
>>      # With LLVM/lld, delaylib is specified at link time (-delayload)
>>      dlltool =3D find_program('llvm-dlltool', required: true)
>> -    dlltool_cmd =3D [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', =
'-D', 'qemu.exe']
>> +    dlltool_cmd =3D [dlltool, '-m', dlltool_target,'-d', '@INPUT@', =
'-l', '@OUTPUT@', '-D', 'qemu.exe']
>>      win32_qemu_plugin_api_link_flags +=3D =
['-Wl,-delayload=3Dqemu.exe']
>>    else
>>      # With gcc/ld, delay lib is built with a specific delay =
parameter.
>=20
> Interesting, on which setup did you find this?
>=20
> Regards,
> Pierrick
Hello,

Was found on my macOS arm64 laptop w/ using llvm-mingw and an MXE fork =
to build all the libs QEMU needed.
Cross-compiled for arm64 Windows initially from there, and came across =
this when targeting x86_64 from that setup.



--Apple-Mail=_49A92ACC-7662-43A4-B029-5820492421AE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 10. Feb 2026, at 07:39, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 2/9/26 8:07 PM, Mohamed Mediouni =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;">llvm-dlltool assumes that it's by default targeting the host =
architecture<br>it's running on. That assumption doesn't hold true when =
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
[dlltool, '-m', dlltool_target,'-d', '@INPUT@', '-l', '@OUTPUT@', '-D', =
'qemu.exe']<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;win32_qemu_plugin_api_link_fl=
ags +=3D =
['-Wl,-delayload=3Dqemu.exe']<br>&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;# With gcc/ld, delay lib is built with a specific delay =
parameter.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Interesting, on which setup did you find =
this?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Regards,</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">Pierrick</span></div></blockquote>Hello,</div><div><br></div>=
<div>Was found on my macOS arm64 laptop w/ using llvm-mingw and an MXE =
fork to build all the libs QEMU needed.</div><div>Cross-compiled for =
arm64 Windows initially from there, and came across this when targeting =
x86_64 from that =
setup.</div><div><br></div><div><br></div></body></html>=

--Apple-Mail=_49A92ACC-7662-43A4-B029-5820492421AE--

