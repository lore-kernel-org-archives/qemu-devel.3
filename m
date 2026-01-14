Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774BED37E27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0Z8-0003xd-1h; Wed, 14 Jan 2026 08:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg0Yt-0003s4-BX
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:05:29 -0500
Received: from p-west1-cluster4-host7-snip4-10.eps.apple.com ([57.103.65.181]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg0Yb-00058E-9e
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:05:23 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 90ADF1800653; Wed, 14 Jan 2026 13:04:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=gNibVEpEv/woE2ACsOSNkoNVqZy6Zb2MY0/JP2Icblg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=azwgA+j/fS4kK+0XknGqHQDA6t7UGEI9uTo0XbjeZoh2j0ciM7uS+2Sajhz/AE3g2Op1z8LLA193vJ1gt9gor3WuU/xnlcvkbkQwt3dPWSy/BZJB8+usImY3XsGJiM+hMc4o1+V+iE8pN9gIvzyb0JR3/yhW2hgCbJvyOsc/qkTfnyc40Yp7WHLPiyuJMM1FiCQ3D4sopeSMyWJkVIFOhsk2dx2bISdzhs9UUZ8yZuf45uYs9tuqSA1HUMrbwo0ovRd96HYd5VfuEaKD8CMMJUDpgIbuXh8W1EXUfo8OBXCNxSYpgvE5UX8dvJCYjE9wRnrQJzvwcM+PIoTTJPfgGg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 4E7871800651; Wed, 14 Jan 2026 13:04:55 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 0/2] arm/hvf: Add SME2 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
Date: Wed, 14 Jan 2026 14:04:43 +0100
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <35D03F6D-9D42-44B4-9D93-F754BB2C3D9A@unpredictable.fr>
References: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: datfttwv8cUg5VfTl4CUjbFbe0H34a2f
X-Proofpoint-GUID: datfttwv8cUg5VfTl4CUjbFbe0H34a2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwOSBTYWx0ZWRfX3K0+4HwXmVLj
 TGafB9xvMr+naJF+6L7LMBMg8AwRETDWSGxqF4/6/oOWwT/wom+z1XuQnXHXNV6S+2X1ahTe1Ef
 wc4CfqOdLWCwHTtBhYnMTiwstOQkg3a0xzjDgOEWV61mf7BcS7zgUgVKh/rq5un0qXhQXZYpgx3
 aKvv+TZjSwwU9dpN6+7LswhWtqmUA5X0Ku2jpLzPpYNfXztj6sBqS9Eebjo+ZF22pG9VdeNw42l
 nj+/PhcTlej6aEM+MwNSA325d32GmljU8+mzSdT0snmtO14PVRY7qhIMv/7XAzeW0Quv1CAM3YB
 oxmrkxvf9t/y3mrEjKR
X-Authority-Info: v=2.4 cv=KNFXzVFo c=1 sm=1 tr=0 ts=6967947c
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8
 a=zAkTo8E5J1WCcoI_fgMA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=730 adultscore=0
 clxscore=1030 malwarescore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140109
X-JNJ: AAAAAAABHp6m4bBJZ7gY+Cp6Z0sATBMLDCq3V58adsmZlQqmMPPdULjsaTKwDM7eBbyg72skVPBWyTVLGyx0k8ThjDyDMfh4XRSBXXFEDOapEkuB4Pg6fMbc7QbhQQNZ/wo3/s4Oufu4hDdIeFgqwG9yKSmtjq5iI0iPNrNZAitdkYwMBub48bw3WbNpjtQ321uuoycKw+yU7UCc/Qrilm2XFjt+7cLO6gf5Pa69BK9o8ZaA5iEkxwaMpfDuz6BpwqBmsk85kQjMGPqgYIPLmfYDIe9THJimt0OZJfNGZhA6/CQMtY/Iqzcy4zij1nbewLmSLLQaG+n0XOo3daau3NYWsZcK844qCXw7sS+Fj+sAxHYySgcfHxfma574rN/1630VuZ2rkirK/7AIDRRhejxPs/m4/r6Gite76Qi66wGwU6Chm8AbM/8Y+qevT6Ar1eIS5Vf+dDJOXg5afPe66SrYuAQhSybuuPg4NBxOQNFFJVHzJPeQhvuHunUc/E/DdTBvLfClrjC9pE5vkASMpCDqnTqBtWAhJinb9myr7JW5CQTxPsNntdVbNAdjFB0aWNk+9Dinv/IH9qEhQnelgxhpA4lKdCrBNX706hwftzGdocOqzAQPMpDgWRwpJL4NlpC2Be6GXa6tmw+v2oQBEehy8nCTBfDNlLv4DOb6l9c2TyisOZRAXDuvrrFPgBk+MeaoC6UPwX6r1MbwJHUL+A==
Received-SPF: pass client-ip=57.103.65.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 14. Jan 2026, at 09:35, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> M4/M5 Macs support SME2, and HVF exposes this functionality in its
> public API.
>=20
> Add support for it in QEMU.
>=20
> This was tested by running an SME2 benchmark from Arm [0]. savevm and
> loadvm during the benchmark's run were used to verify migration works.
>=20
> [0]:
> =
https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-w=
ith-sme2/1-get-started/
>=20
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Manos Pitsidianakis (2):
>      hvf/arm: handle FEAT_SME2 migration
>      hvf/arm: expose FEAT_SME2 to guest if available
>=20
Hello,

For this series:

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Random note: For running on older macOS releases when built with a new =
SDK, you might also need -weak_framework, but not sure meson supports =
that=E2=80=A6

>=20
>  target/arm/cpu.c            |   4 +-
> target/arm/cpu64.c          |  13 +-
> target/arm/hvf/hvf.c        | 318 =
++++++++++++++++++++++++++++++++++++++++++--
> target/arm/hvf/sysreg.c.inc |  10 ++
> target/arm/hvf_arm.h        |  46 +++++++
> target/arm/machine.c        |   2 +-
> 6 files changed, 376 insertions(+), 17 deletions(-)
> ---
> base-commit: cf3e71d8fc8ba681266759bb6cb2e45a45983e3e
> change-id: 20260114-sme2-hvf-105767189521
>=20
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=CE=
=B8=CE=AE=CF=84=CF=89
>=20
>=20


