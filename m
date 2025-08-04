Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348D5C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1KC-0001Ob-6P; Mon, 04 Aug 2025 15:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj1In-0000gq-Gt
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:56:59 -0400
Received: from p-east3-cluster7-host8-snip4-5.eps.apple.com ([57.103.84.206]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj1Ik-0002O4-P2
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:56:57 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 3DC5918000B0; Mon,  4 Aug 2025 19:56:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=KVuA7BREn1RZ5n6vSNeH5KcX5g1Svvd2LoIHcQBBN+o=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=Ydgind7SdOGCnkWwKCy1ZlvAZGyTWcNKpQIAbXnwJFZ7UEXkwt9Y2mpvX9G97+IR3BvOv53i9BUIGmTXvn/242sW2w3sLkZ8YqbtkhMBUvNL0S9N/KHSY9Vh6wCmPSvHrdL9m9mn/i3+DqR9OoC1E1cpypXCDpVgMrM6NiQKJEj9eP2R1K8NGkgWsz1QxPQN4/mLAWDQuvDh21gs6c8pUyekhDLvvUVRYfN1H8kmEfy6f5gi4Lflyf7XTWyXxU7vBX6hhNbSBIKYg6hM5tnWJbflvJw29naoORH7ZTITYCmRRR4Od1wowsmMwSAtn6EDSWpxL5KJnZiARrTcqmOuqA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 85AFE1800166; Mon,  4 Aug 2025 19:56:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <2BF73501-00C6-4194-B75C-CD50A8807314@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2D9B25E3-8420-433D-86A9-DEC46D3EC9FF"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Mon, 4 Aug 2025 21:56:32 +0200
In-Reply-To: <a8239e8e-37ad-415c-b13a-4b4ce8fa2a36@linaro.org>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-13-mohamed@unpredictable.fr>
 <a8239e8e-37ad-415c-b13a-4b4ce8fa2a36@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-ORIG-GUID: fwRg9zaQTiJrmbc6xeCp5Rh17lVSaAH1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDExOCBTYWx0ZWRfX1tOgijn+mP66
 jmkfHF5MxyYr1haLwJGHUngoT2xZcOAEFSgVr6G8+/6LznhSBFHFjXCqDPai7CtUOV/REqrvooj
 PMB4SxsqFJfv9ce02GROFrwTwM571sT2hKfloBTSJ2c6GHyXYwwNyzDEdPQAMzc/1EosNu4K+MN
 +oLmHSO9kkBg0nZA6yWIJI54E1+39u5GxKBM84bnCHYuKCWyV4I8oFFsg/2DC8DHf1W8eVLjNVZ
 fBBpqSXhhkxHBAM57tf26HXz01ljJlX4Gko0hcfVvzNZd/NzkeLlw5mK9JskQF8DNLnf9xDdo=
X-Proofpoint-GUID: fwRg9zaQTiJrmbc6xeCp5Rh17lVSaAH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508040118
Received-SPF: pass client-ip=57.103.84.206;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_2D9B25E3-8420-433D-86A9-DEC46D3EC9FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 4. Aug 2025, at 21:50, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
>> Windows Hypervisor Platform's vGIC doesn't support ITS.
>> Deal with this by reporting to the user and not creating the ITS =
device.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/arm/virt.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 98a1c74c42..0039f6a12b 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
>>          return;
>>      }
>>  +    if (whpx_enabled() && vms->tcg_its) {
>> +        /*
>> +         * Signal to the user when ITS is neither supported by the =
host
>> +         * nor emulated by the machine.
>> +         */
>> +        info_report("ITS not supported on WHPX.");
>> +        info_report("To support MSIs, use its=3Doff to enable GICv3 =
+ GICv2m.");
>> +        return;
>> +    }
>> +
>>      dev =3D qdev_new(its_class_name());
>>        object_property_set_link(OBJECT(dev), "parent-gicv3", =
OBJECT(vms->gic),
>=20
> Is it equivalent to simply using its=3Doff, or is there a difference?
> The info_report seems to imply it's not the same.

Not equivalent.

Regular system: GICv3 + ITS
This configuration (for the newest machine version): GICv3 with no MSIs
And its=3Doff explicitly: GICv3 + GICv2m

It became not equivalent since the intro of GICv3 + GICv2m in patch 2 of =
this series.

Thank you,




--Apple-Mail=_2D9B25E3-8420-433D-86A9-DEC46D3EC9FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 4. Aug 2025, at 21:50, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 8/4/25 7:23 AM, Mohamed Mediouni =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Windows Hypervisor Platform's vGIC doesn't =
support ITS.<br>Deal with this by reporting to the user and not creating =
the ITS device.<br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>&nbsp;hw/arm/virt.c | 10 =
++++++++++<br>&nbsp;1 file changed, 10 insertions(+)<br>diff --git =
a/hw/arm/virt.c b/hw/arm/virt.c<br>index 98a1c74c42..0039f6a12b =
100644<br>--- a/hw/arm/virt.c<br>+++ b/hw/arm/virt.c<br>@@ -741,6 =
+741,16 @@ static void create_its(VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;+ &nbsp;&nbsp;&nbsp;if =
(whpx_enabled() &amp;&amp; vms-&gt;tcg_its) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Signal to the user =
when ITS is neither supported by the host<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* nor emulated by the =
machine.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;info_report("ITS not supported =
on WHPX.");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;info_report("To support MSIs, =
use its=3Doff to enable GICv3 + GICv2m.");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev =3D =
qdev_new(its_class_name());<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;o=
bject_property_set_link(OBJECT(dev), "parent-gicv3", =
OBJECT(vms-&gt;gic),<br></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Is it =
equivalent to simply using its=3Doff, or is there a =
difference?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">The info_report seems to =
imply it's not the same.</span></div></blockquote></div><br><div>Not =
equivalent.</div><div><br></div><div>Regular system: GICv3 + =
ITS</div><div>This configuration (for the newest machine version): GICv3 =
with no MSIs</div><div>And its=3Doff explicitly: GICv3 + =
GICv2m</div><div><br></div><div>It became not equivalent since the intro =
of GICv3 + GICv2m in patch 2 of this =
series.</div><div><br></div><div>Thank =
you,</div><div><br></div><div><br></div><div><br></div></body></html>=

--Apple-Mail=_2D9B25E3-8420-433D-86A9-DEC46D3EC9FF--

