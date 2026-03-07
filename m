Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF96F513ED
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 14:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyt4T-0003Xu-6r; Sat, 07 Mar 2026 09:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyt4R-0003Xb-2A
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 09:55:59 -0500
Received: from p-west1-cluster4-host4-snip4-5.eps.apple.com ([57.103.65.206]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyt4M-0004Ti-C6
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 09:55:58 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 818F718002D9; Sat,  7 Mar 2026 14:55:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772895350; x=1775487350;
 bh=3Hf6qZJJ22jSXTaC5chhQJO6N7YF+sOCtuqZg9zUA50=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=TFVO1nbpAX/FfWEqoIuT1471LP3rg6XnHg/MtYzMBG7HCylNiC/bOSexWkMNdykVJP+nyqywMXMnfUU5UD4IuuNlh4/9t+fRX30B9MTcU4sVJT0vGUKX5kkgp2SkpqIwqd71/L6ANwvgzMo4Leg6pbZgdZ6aV1Ogh4gYiP4QPGtl5IJDkTonMQrJVmyzQ5Rfs8AASA2rOtGvyi04ZZDQm0UdV9CHYq2ot9IFeArNXV8+A/jtIUg6shL3DEdeaV6m23PcNqD0FKOpA/1iMEKlyBuYXBF5smSI3qa9wgoHMESRktMP2bmjzH+i0gg5UG2ouH0Gi5FY4HmjkuCN8qskRA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 E2C7C18000BA; Sat,  7 Mar 2026 14:55:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <F3C46063-02A0-4E07-B49E-12803CC6282F@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_59BEC40E-7027-4C6A-B3A1-F21A6D5C62B8"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] hvf: arm: remove SME2 stub code
Date: Sat, 7 Mar 2026 15:55:34 +0100
In-Reply-To: <20260307105009.67242-1-mohamed@unpredictable.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
To: qemu-devel@nongnu.org
References: <20260307105009.67242-1-mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=T7iBjvKQ c=1 sm=1 tr=0 ts=69ac3c74
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=t-IPkPogAAAA:8 a=uQeOrDm3VYMiYYFw_yAA:9 a=QEXdDO2ut3YA:10
 a=djTnKAExMc7TnttBwCUA:9 a=VakuLFVUEvGx7gpi:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: RGaKYtayY4JtI5eVDwgL6a_f4lM6_bZs
X-Proofpoint-ORIG-GUID: RGaKYtayY4JtI5eVDwgL6a_f4lM6_bZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0MiBTYWx0ZWRfX3a9C5DcHMily
 5Fq0Q7uReXmsc19pgWsE4qlJbJ3jVkFRWo29lp2hy3SGt9IRuPnE7Ab5KWsBV4FfvlE7ETtjM3I
 z02iU+BNLTQXrV+t+YSR1CtMg2GPWD6peDon45ZVqNuQihFHTzDO/fKyiylrFHaLVXEiesurcGS
 5g8ycfhE6WFKiw2/Uc5X7CTJtf3F3igHv+YoGkbsICNSMT2/MoY+y73pnMjSJ4NnWv4bGvqOr3q
 0ci4HHLi73mNoVsXjRWFdmInIBIhwhGk0N9QTZO1IYv307cgwQ1W7HwQFfeqrfjuTZLIJLD0O3Q
 vcGCfmZ6nURaGQHrBnaD77ijMy0wbd0CoYHW64oC3i25oNMs92imr3GO8SaJpk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070142
Received-SPF: pass client-ip=57.103.65.206;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_59BEC40E-7027-4C6A-B3A1-F21A6D5C62B8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 7. Mar 2026, at 11:50, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Releases n and n-1 of macOS are supported. As such, macOS 15.x and =
26.x are currently the baseline.
>=20
> The QEMU CI still uses a newer SDK, just with an older default target =
as it's running on a macOS 14 host.
>=20
> Note that this on its own doesn't prevent running on macOS 14. It just =
means that you have to use a newer SDK in order to do so.
>=20
> Why do this? Because the stub code broke the x86 build... and it =
doesn't make much sense to keep it.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Alright do not merge this with the current QEMU CI, it=E2=80=99ll break =
the build because:

The QEMU CI from the log =
https://gitlab.com/qemu-project/qemu/-/jobs/13389185563 uses:

> C compiler for the host machine: cc (clang 16.0.0 "Apple clang version =
16.0.0 (clang-1600.0.26.4)=E2=80=9D)

Which corresponds to =
https://developer.apple.com/documentation/xcode-release-notes/xcode-16_1-r=
elease-notes

Which has the macOS 15.1 SDK instead of 15.2=E2=80=A6 which is the =
minimum for SME2 availability. But nested virt came with 15.0 so not a =
problem for the series there.

Ugh. Should we attempt to bump the CI version then? Or attempt another =
workaround for this?


--Apple-Mail=_59BEC40E-7027-4C6A-B3A1-F21A6D5C62B8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 7. Mar 2026, at 11:50, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Releases n and n-1 of =
macOS are supported. As such, macOS 15.x and 26.x are currently the =
baseline.<br><br>The QEMU CI still uses a newer SDK, just with an older =
default target as it's running on a macOS 14 host.<br><br>Note that this =
on its own doesn't prevent running on macOS 14. It just means that you =
have to use a newer SDK in order to do so.<br><br>Why do this? Because =
the stub code broke the x86 build... and it doesn't make much sense to =
keep it.<br><br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br></div></div></blockquote><div><br></di=
v>Alright do not merge this with the current QEMU CI, it=E2=80=99ll =
break the build because:</div><div><br></div><div>The QEMU CI from the =
log&nbsp;<a =
href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/13389185563">https://g=
itlab.com/qemu-project/qemu/-/jobs/13389185563</a>&nbsp;uses:</div><div><s=
pan style=3D"white-space: pre-wrap;"><br></span></div><div><span =
style=3D"white-space-collapse: preserve;">&gt; C compiler for the host =
machine: cc (clang 16.0.0 "Apple clang version 16.0.0 =
(clang-1600.0.26.4)=E2=80=9D)</span></div><div><span =
style=3D"white-space-collapse: preserve;"><br></span></div><div><span =
style=3D"white-space-collapse: preserve;">Which corresponds to </span><a =
href=3D"https://developer.apple.com/documentation/xcode-release-notes/xcod=
e-16_1-release-notes">https://developer.apple.com/documentation/xcode-rele=
ase-notes/xcode-16_1-release-notes</a></div><div><br></div><div>Which =
has the macOS 15.1 SDK instead of 15.2=E2=80=A6 which is the minimum for =
SME2 availability. But nested virt came with 15.0 so not a problem for =
the series there.</div><div><br></div><div>Ugh. Should we attempt to =
bump the CI version then? Or attempt another workaround for =
this?</div><div><br></div></body></html>=

--Apple-Mail=_59BEC40E-7027-4C6A-B3A1-F21A6D5C62B8--

