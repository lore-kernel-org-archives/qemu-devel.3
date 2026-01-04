Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90599C2A069
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 03:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcEbH-0005xh-Np; Sat, 03 Jan 2026 22:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vcEbA-0005sn-Tn
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 22:16:08 -0500
Received: from p-east2-cluster2-host9-snip4-5.eps.apple.com ([57.103.78.68]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vcEb7-00044z-M9
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 22:16:08 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-12 (Postfix) with ESMTPS id
 25440180009D; Sun,  4 Jan 2026 03:15:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+dKkymVULqQ48k0W+JWOHayVLAoO7p5yhA5mS5mRUPM=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=au6dPz6qJcSQ7kaVyleH6OVF7hO0T28zC0bR2JLlHrBnmdu1T9655iGWUqpBJp4OIhLJcyCOD3TNPzjIhMjdII46HxVL5P2XAZ8mDihLZK4/YKV4TxnQULHZ2KnIJrotRjiGkCR6JIlu8/keWfZb8jDuo47mqiRig+EQao074N8UgJPcrjxG0a0ryAFLPHQIAa7bFOKsYcKB1oPDATb8VF9nF7O8+gY1ogShxItX5JedN8EbbJWJRqyEybRL5iMxmO8C86jyYPsUMGmsErR/VdH0eayKGtOeDt8NnP1G/28XlXj+IUoCvsANC6QCsHPqqxktGzdv4e4qra6AmqZAKg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-12 (Postfix) with ESMTPSA id
 4E96318000AE; Sun,  4 Jan 2026 03:15:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <47DF75FA-8539-4748-94E0-74DE080BD71D@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_259E8AA2-64FE-4C96-9328-89BEC282FB95"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v13 07/28] hw: arm: virt: rework MSI-X configuration
Date: Sun, 4 Jan 2026 04:15:45 +0100
In-Reply-To: <c6eafd44-3187-4c63-97b9-bd4bf96595c0@phytium.com.cn>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
References: <c6eafd44-3187-4c63-97b9-bd4bf96595c0@phytium.com.cn>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDAyOCBTYWx0ZWRfXxB1AjAhxEAGX
 17Ysj51+mMYvhazjDtkdCM/jvsREDIzoHghynLTNqCaT5HH1KTCZrMFoqFIcu/KZlKAUH2KG6Vf
 E6Jba4InCMprA36cb6ZNL/ENHKFehXNuBQwMgYEI+FaZmco3rz0hl1daGRfC8fxSCMujBlA8Pzf
 vW83Rau42ftdBAyxhJB6sGgdHh8voVoqwjETc1bI2Yo4lrevS8vAvnRXOXmMjokqX0tpA3sAZ/g
 4qh4T3za12mEXKUv7njdaKfRDRnjms2SiOgjoBZSh0hpUNY27j/Evd3r/7KdcFwGDfcUp+ToOnc
 5NvOJfFVzWqZfVbK7A9
X-Authority-Info: v=2.4 cv=csSWUl4i c=1 sm=1 tr=0 ts=6959db6f cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8
 a=t_0_BxdfAAAA:20 a=fgrLqfBXAAAA:8 a=KKAkSRfTAAAA:8 a=a2Il46PqAXRzGH9R2ewA:9
 a=QEXdDO2ut3YA:10 a=mPuSz27myjgA:10 a=6iWrutSnyxVHwnIEY3sA:9
 a=LQZB4E8K4079zUNo:21 a=_W_S_7VecoQA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=_Ge82aPy-h_wFa7gWU4u:22 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: g_LI9KyDJjfpO1dGgqGCVoExUkXbWDPV
X-Proofpoint-ORIG-GUID: g_LI9KyDJjfpO1dGgqGCVoExUkXbWDPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601040028
X-JNJ: AAAAAAABUNToXuT2hQsGRo2sWt1GM6aN0nxjr93GrjbrEk6DMGbOmX/ZA9MZbZFO19hZJ8AWEPpLS0iHeMgILh0z5MBwz814fNwmps6FeuxdtPEZZzZVSVDARBVpBEm87NxdN4qqFzjVbdpLQ6YunPTk/aiFXgGuIdMhv0acM8dOXtyp3+vUPbX0zokXoFZ/1yvVju1JlkW0syaP8TJG+dGl02u96Wz0Qg2n4QhNZ+HByTThrjkKAF94mqWRz7munflO+wTtUngZ7HQrkORjKKwMEveclgsk5sG3m2/ggyTRkhgK+wHZEK/sNjb2u+yPVIhfMm2RqE68tWRLbAlJRIKXKzkxBlNhatdhitNwX4cxQi7VrKYFk6gqvJ0lKgwJSVE68Rr+EbCn5MSnX7izij0zRVu79+/6og3ybMOOYTaRggkYzgrGO/62Zzkx6Mhag767hxd2YddqguENi2mxSdcRzBNWCq9H5cVDtoL0f/OuKIpPV//13Y4UypgkXY2ft8YF5XL7wb8yaSMZnuZuwazC6b5jMj/nQvyYtJaCBPVF22zvpDtS8h2Vct3wGaKZmibloo8PQr1TDtFl99dzu3fMSr88VoNpYvSRmPBrHh/2lFem0OwE8tP6uL+M3QjIMv73f5SuuaFxl5t195eJrgkosMnJX/psz47XHxQBqDafCnd8yg==
Received-SPF: pass client-ip=57.103.78.68;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_259E8AA2-64FE-4C96-9328-89BEC282FB95
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 3. Jan 2026, at 06:21, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>=20
> Hi all,
>=20
>> Introduce a -M msi=3D argument to be able to control MSI-X support =
independently
>> from ITS, as part of supporting GICv3 + GICv2m platforms.
>>=20
>> Remove vms->its as it's no longer needed after that change.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  hw/arm/virt-acpi-build.c |   3 +-
>>  hw/arm/virt.c            | 110 =
++++++++++++++++++++++++++++++++-------
>>  include/hw/arm/virt.h    |   4 +-
>>  3 files changed, 94 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 86024a1a73..f3adb95cfe 100644
>=20
> I=E2=80=99m trying to clarify the current status of ITS under TCG for =
the virt machine.(may be a stupid question...)
>=20
> The virt documentation states: "Note that ITS is not modeled in TCG =
mode." [1]

Hello,

That=E2=80=99s outdated documentation, ITS emulation was added in Qemu =
6.2 to cover the TCG case.

Was implemented in patchset: =
https://lists.nongnu.org/archive/html/qemu-arm/2021-08/msg00070.html

> However, when looking at hw/arm/virt.c, I don=E2=80=99t immediately =
see a hard prohibition of ITS under TCG; for example, the MSI/ITS logic =
appears to allow ITS depending on machine/version settings, and the =
series also keeps tcg_its.[2] [3]
>=20
>=20
> Could you please confirm the intended behavior today: is ITS expected =
to be modeled under TCG for the latest virt machine?
>=20
>=20
> [1]: =
https://github.com/qemu/qemu/blob/master/docs/system/arm/virt.rst?plain=3D=
1#L46
>=20
> [2]: https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3490
>=20
> [3]: https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3656
>=20
>=20
> Also, Mohamed=E2=80=99s recent work to support "GICv3 + GICv2m" (and =
to control MSI independently from ITS via -M msi=3D) looks like a very =
practical workaround for environments where GICv3 is needed but ITS is =
unavailable.
>=20
>=20
> Best regards,
>=20
> Tao
>=20
>=20


--Apple-Mail=_259E8AA2-64FE-4C96-9328-89BEC282FB95
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 3. Jan 2026, at 06:21, Tao Tang =
&lt;tangtao1634@phytium.com.cn&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Hi all,<br><br><blockquote =
type=3D"cite">Introduce a -M msi=3D argument to be able to control MSI-X =
support independently<br>from ITS, as part of supporting GICv3 + GICv2m =
platforms.<br><br>Remove vms-&gt;its as it's no longer needed after that =
change.<br><br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>Reviewed-by: Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt;<br>---<br> =
&nbsp;hw/arm/virt-acpi-build.c | &nbsp;&nbsp;3 +-<br> =
&nbsp;hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 110 =
++++++++++++++++++++++++++++++++-------<br> &nbsp;include/hw/arm/virt.h =
&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;4 +-<br> &nbsp;3 files changed, 94 =
insertions(+), 23 deletions(-)<br><br>diff --git =
a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c<br>index =
86024a1a73..f3adb95cfe 100644<br></blockquote><br>I=E2=80=99m trying to =
clarify the current status of ITS under TCG for the virt machine.(may be =
a stupid question...)<br><br>The virt documentation states: "Note that =
ITS is not modeled in TCG mode." =
[1]<br></div></div></blockquote><div><br></div><div>Hello,</div><div><br><=
/div><div>That=E2=80=99s outdated documentation, ITS emulation was added =
in Qemu 6.2 to cover the TCG case.</div><div><br></div><div>Was =
implemented in patchset:&nbsp;<a =
href=3D"https://lists.nongnu.org/archive/html/qemu-arm/2021-08/msg00070.ht=
ml">https://lists.nongnu.org/archive/html/qemu-arm/2021-08/msg00070.html</=
a></div><div><br></div><blockquote type=3D"cite"><div><div>However, when =
looking at hw/arm/virt.c, I don=E2=80=99t immediately see a hard =
prohibition of ITS under TCG; for example, the MSI/ITS logic appears to =
allow ITS depending on machine/version settings, and the series also =
keeps tcg_its.[2] [3]<br><br><br>Could you please confirm the intended =
behavior today: is ITS expected to be modeled under TCG for the latest =
virt =
machine?<br><br><br>[1]:&nbsp;https://github.com/qemu/qemu/blob/master/doc=
s/system/arm/virt.rst?plain=3D1#L46<br><br>[2]: =
https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3490<br><br>[3]: =
https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3656<br><br><br>Al=
so, Mohamed=E2=80=99s recent work to support "GICv3 + GICv2m" (and to =
control MSI independently from ITS via -M msi=3D) looks like a very =
practical workaround for environments where GICv3 is needed but ITS is =
unavailable.<br><br><br>Best =
regards,<br><br>Tao<br><br><br></div></div></blockquote></div><br></body><=
/html>=

--Apple-Mail=_259E8AA2-64FE-4C96-9328-89BEC282FB95--

