Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7BEC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzUP-0004Et-Vl; Thu, 05 Feb 2026 08:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzUN-0004Eb-7q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:33:43 -0500
Received: from qs-2003d-snip4-11.eps.apple.com ([57.103.86.43]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzUK-0006Ha-Qe
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:33:42 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 201F81800154; Thu,  5 Feb 2026 13:33:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770298419; x=1772890419;
 bh=NuUwqmD1LwUXLujIVgAF1hke2J9DN+/pBb2k3iXWC4M=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=JCf6ifd/JLBUfQPmsXGkLlU5y+k+5xLmYsRb3kRxqqxa4O46etiKeaHgP4oi+t40j2Ixq+jim/1Qlo/+AipwMQ4S7EkZEMqOp5BJPza0Qhv6CywzQ33JoaP6ojkReLIi3LC/kZZq9sE0cau/GwzbstomNb6UFNxy/DNK0R+VuiQfg36q1dnwayEuqUpaXw6fpGuOGZwlp7Mom0nKJ75jkbMgk1MqFmyOOSialX9cBGaIq8OrTnPYbsB9tjr3WZ2PhxnMGbleHHSjvpWg2IXnV5gmobILwOUD4zb57I3LKd1+RGBeNXWk7Gmrl1WqfyAAKyXWfMERp0CNDEqJdzbQag==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 CFFCA180017F; Thu,  5 Feb 2026 13:33:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <46C8474B-9D50-40DA-9D54-46C26B04BA68@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D725EB73-AECD-4F28-AE5A-3D88AFC30AC5"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v19 00/22] WHPX support for Arm
Date: Thu, 5 Feb 2026 14:33:24 +0100
In-Reply-To: <CAFEAcA-4-nwRQCaa9SRUv28SWveC7k0GG5HmA478FhKGuJb_fA@mail.gmail.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
 <CAFEAcA-4-nwRQCaa9SRUv28SWveC7k0GG5HmA478FhKGuJb_fA@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: -tg4Oms2hwURGsi3jWVZczQ7zPsAwbYX
X-Proofpoint-GUID: -tg4Oms2hwURGsi3jWVZczQ7zPsAwbYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwMSBTYWx0ZWRfX0VvzoIatpHe2
 kWl5QUPPQHVXETLLsYQbqWzkG7NmQkhT/SvxVv3g2wjeSrVAejK6lN7vr+b1kXaEvRqjvzbnLU7
 IVI/asNFeh8+JKMVKbXyRLDPI5zh4E0cNnEdxuVVX/KljBvB5eA8jNZEC2kbrgddh1/yvoU9CZk
 oxBdUJKczLXfpDZ2S/WJ6T9CKcSilUZKKM4gq+dAkLUMxKoseMi8i3cnIqkX+kJUAWxxHfIbwxs
 vH0jbVHBLla356KtxpB+x9AfnDAhAO4eIVpa2u+3d4waqHwgEjf6ZLSTVXTl7a8KbcNtB56ph8L
 f1fodVGv+vZPlDXEwA1fmp7OYEEBhhXo3ub1hwdhH+Qj0pk5zH2OtfrIZG0Bxs=
X-Authority-Info-Out: v=2.4 cv=UM3Q3Sfy c=1 sm=1 tr=0 ts=69849c32
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=gTrZvUQ8vleWZgLE1FEA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=gCBkIiZbhVrsYSpyXHMA:9 a=OK2zlWkB7KHOYUhx:21
 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 clxscore=1030
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050101
X-JNJ: AAAAAAABi+zlUCYij2EE8S4+BmTC0VL5E/e/LnhSl485a8+zZjk7WPO/649ZIoHwuWE8rW27wOw65Ek53/ePonhCMRL/UXC/hogGE5RDH0TOU7povRJiOOxg6F+nvZy0L34SDhLXKHIe5Qdv9fFIcrKfI0w8hBokZSN8+grnyFekE2tyK94QRx2g3yUiA+r97jjV3TpS3OSMB9IyoIqBN3FquMgmqkOalCq7q7RyKT+t2gtEcAuUX7LoWHkFLvVMrO+w34Z+LefjZmwjZj0yxRavxd7Pz+DyeaNpPOS0n3Tg9bU76XTnvuQ+WDnPMxxDuNR3TfLYOhabc2cPM50EaKANHSvYSVK8I7xJwr/UYVmo16wxfgGWOZcvND23TkWrL0mMBVHUVN+W/T225hg1yWzLj09bef+07/ivTTi734amv4EdhE2Zn9Odo+uaOHeIasswVP8H+6nay0HlTYsa2uoPhL9FvyxrdhH+i9PMgg9SVnaWloS54U0PRUygKVdXf0rV8Nttw83K3s3fS9SiOB45eKX9TYyxHRLoZlZ0lr2s2zA4TdrFmKDuZ6+LIi//UTyBPr7s0VhRoXPrxPx+mAxdBRt0oja6fvdNe289d+3H7xAd6ChhRAa3M5wizmUlOvBKWUyKYTzluPef5JnblIxvv2HRYSdPx62iGgcMsbgv3HQ1GLlWlRqmDyEiTsEiJA16Ef3zp3HQwJvOM65om4VHHOAABG+QExI9JhocZFZ+nQGwe22xlr2TPkh/6alXiqUiZnVA+TAEf3JMQPoIgq2hRDc3XbcaCVH2XFnElXfROplMLV7i5HjvAUtuFwgHyyZyHLE0Oat/5kmhWM4s2OUlv1TM0trvdqIRYeQoXySjA6iOi8y3lzdvmBa0o57HO4EMrCAwyXWQG1GTaQ==
Received-SPF: pass client-ip=57.103.86.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_D725EB73-AECD-4F28-AE5A-3D88AFC30AC5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 5. Feb 2026, at 11:20, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Thu, 29 Jan 2026 at 19:20, Mohamed Mediouni =
<mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>> wrote:
>>=20
>> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this =
submission: whpx-v19)
>>=20
>> Missing features:
>> - VM save-restore: interrupt controller state notably
>> - SVE register sync: I didn't have the time to test this on =
pre-release hardware with SVE2 support yet.
>> So SVE2 is currently masked for VMs when running this.
>>=20
>> Known bugs:
>> - U-Boot still doesn't work (hangs when trying to parse firmware) but =
EDK2 does.
>>=20
>> Note:
>>=20
>> "target/arm/kvm: add constants for new PSCI versions" taken from the =
mailing list.
>>=20
>> "accel/system: Introduce hwaccel_enabled() helper" taken from the =
mailing list, added here
>> as part of this series to make it compilable as a whole.
>>=20
>> And another note:
>>=20
>> Seems that unlike HVF there isn't direct correspondence between WHv =
registers and the actual register layout,
>> so didn't do changes there to a sysreg.inc.
>=20
> Hi; this doesn't apply on current master now that the SMMU changes
> have landed, because of a conflict with the ACPI data table
> update patch, but otherwise I think it is good to go. Could you
> rebase it, please?
>=20
> thanks
> =E2=80=94 PMM
Hello,

Patchew seems unhappy but the patches cherry-picks cleanly for me=E2=80=A6=
=20
(for v19, which is rebased on top of the SMMU patches and v20)

It looks to be due to the commit message being parsed as a patch,
will edit the commit messages for the ACPI table change commits and =
re-submit.

Thanks,
-Mohamed=

--Apple-Mail=_D725EB73-AECD-4F28-AE5A-3D88AFC30AC5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 5. Feb 2026, at 11:20, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Thu, 29 Jan 2026 at 19:20, Mohamed =
Mediouni &lt;</span><a href=3D"mailto:mohamed@unpredictable.fr" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">mohamed@unpredictable.fr</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><br>Link to branch: https://github.com/mediouni-m/qemu whpx (tag =
for this submission: whpx-v19)<br><br>Missing features:<br>- VM =
save-restore: interrupt controller state notably<br>- SVE register sync: =
I didn't have the time to test this on pre-release hardware with SVE2 =
support yet.<br>So SVE2 is currently masked for VMs when running =
this.<br><br>Known bugs:<br>- U-Boot still doesn't work (hangs when =
trying to parse firmware) but EDK2 =
does.<br><br>Note:<br><br>"target/arm/kvm: add constants for new PSCI =
versions" taken from the mailing list.<br><br>"accel/system: Introduce =
hwaccel_enabled() helper" taken from the mailing list, added here<br>as =
part of this series to make it compilable as a whole.<br><br>And another =
note:<br><br>Seems that unlike HVF there isn't direct correspondence =
between WHv registers and the actual register layout,<br>so didn't do =
changes there to a sysreg.inc.<br></blockquote><br style=3D"caret-color: =
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
display: inline !important;">Hi; this doesn't apply on current master =
now that the SMMU changes</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">have landed, because of a conflict with the =
ACPI data table</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">update patch, but otherwise I think it is =
good to go. Could you</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">rebase it, please?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">thanks</span><br style=3D"caret-color: =
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
display: inline !important;">=E2=80=94 =
PMM</span></div></blockquote></div>Hello,<div><br></div><div>Patchew =
seems unhappy but the patches cherry-picks cleanly for =
me=E2=80=A6&nbsp;</div><div>(for v19, which is rebased on top of the =
SMMU patches and v20)</div><div><br></div><div>It looks to be due to the =
commit message being parsed as a patch,</div><div>will edit the commit =
messages for the ACPI table change commits and =
re-submit.</div><div><br></div><div>Thanks,</div><div>-Mohamed</div></body=
></html>=

--Apple-Mail=_D725EB73-AECD-4F28-AE5A-3D88AFC30AC5--

