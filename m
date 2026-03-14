Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904E510854B2
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1X74-0002FS-6K; Sat, 14 Mar 2026 18:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1X71-0002Eo-M2
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:05:35 -0400
Received: from p-west3-cluster1-host1-snip4-10.eps.apple.com ([57.103.73.141]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1X6z-0000TL-Vy
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:05:35 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPS id
 CC32E18000A7; Sat, 14 Mar 2026 22:05:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773525930; x=1776117930;
 bh=gOuSMc4Owrr6X1PeVKBpC/W7OBroDQh/ePJjuN/Ym9I=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ANDW1zzJTCVsvJqoxa/PVlCPAx4mC+qyl/eWQgh4y5m92pS8zx/LPbFGXxwaKuhxqk1Lx0qSeVN53E9Pzr1XN12/DyGCUskY9y25zr8NmEdEuJrtjOp/5eQPrZZu3e5zJgP0vCI/+tO+06KluXFIAxJdEl/XQLPqwRapELX6axBRRtGG38wQySWZdKm8C6c5KL0gDKHwygru6Heo0AIWok5hWoAAXVUjYfpG/1lJtFJtAIBFa7arrthqlqCBQEk6ZBmNvpo15QmgQH+CEG9U9PbjpNe/l4J5qGxA1dBF1RF/Fjy2OgfMVACUiIWHAoFZSRRo5zmQin61VFYbHvPRZw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPSA id
 D9B7C18000BC; Sat, 14 Mar 2026 22:05:26 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] whpx: arm: fix ID_AA64MMFR3_EL1 host feature register
 index
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260314215613.141373-1-osama.abdelkader@gmail.com>
Date: Sat, 14 Mar 2026 23:05:13 +0100
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E81FA26F-36B1-4A72-BA5F-9E9B8D393182@unpredictable.fr>
References: <20260314215613.141373-1-osama.abdelkader@gmail.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NCBTYWx0ZWRfXzwhlvbpOxPFs
 iziluRio1qeRYBDyLW8VsPWhS1mNC/Xr0xGhqX1Tf5sOapStDxFtbbbQRN6pNABMNZOPdqz/3Tm
 xuPCA+41eK+/tDK6Jh6HGanBGmSokrxSQes+yP5nbPpFQ4pVV79QlxXSEqxlezgCPfll1JTp6mr
 1LM7tG2StW8pRhn4YlfQBPy+eFsBJM84jhPB6+2TimKTbRsf1doSinN3Cf+QpMDGUjaOGJRnShH
 ae9G8QSEkQIiU/lAyv3wC4dU5dzmStMmNpz25gKTwjBw88aB3q1rYApKh2Bx/GpJtcqodqtRoGD
 1YFPQTGqWSBvXsWrif20XoZMpP5bS0tF7JC9cO69pvkkTOUrD1YugTQHaP88KM=
X-Proofpoint-ORIG-GUID: iJPbm_QpFgDlT_TLYRnRLnRJ5pxKEym-
X-Authority-Info-Out: v=2.4 cv=FLEWBuos c=1 sm=1 tr=0 ts=69b5dba9
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=tw4iIMvr5PT-SM50NLsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: iJPbm_QpFgDlT_TLYRnRLnRJ5pxKEym-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0
 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140174
X-JNJ: AAAAAAABSst/eDqpUzs9D1PJVntLVMP6W7dm4iMnwPEVtZDrInC/7Yx/iOfXxm3htRgvsEdlZUdslHb/kQUrr2/O66kLPLvDTdainZJpOca+8vYMXKro3g/y7F4QPJkHHnPYeWo/rH/rP/3WYA62aqzs1ijqc0fhYYxIDzpOSr7DBjj33VSgwTmtD4QWaIYCRKmEUq5hPz36Cf+MfpTddGevA8bhscMqM44FoHxT/lXDpuD7Z1CSNxP2+RU1NNcLgtGlNtEtX0Pn7VFk829+mYAy8RAMP6mz4svLgf6hsuANfbO7Q2IWxigpo+/T1swXWsJ3EnCWz9IHqcqpdqcJKOcqHxjclGh5egb3sRwC/gKmISSgS1TRcZ6HCSB4t/0UWNXM7i+xTjY6EoAbWaCOQtcpgKs/9r1QguIl84o6/ac4889uysmwxoKgNyxGl558GaMth1Mgu/R7cjFno+WwyDRRhgmo6qLG0emYcynoQvtnuRmphnITbu2O/OJcDl/OulYM3IiB8wtXh139OVC6X2Fq70HqcpZBAgZyDEfTWGH4O0staRbrm/w/jjxvnmZ/e77O14VhRglScQc9orkzNSrPa+sh0diu6f3mkbwUTf6fwQbpgScsORpfj/jHZ6GVyaHIIjn7RLxAy2v1AAvxiLmWMnPiSUw4Sp6+KqF0KNfi9XHUx9pi/V0QlWLdC0rxkTuG
Received-SPF: pass client-ip=57.103.73.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 14. Mar 2026, at 22:56, Osama Abdelkader =
<osama.abdelkader@gmail.com> wrote:
>=20
> IdAa64Mmfr3El1 was stored in idregs[ID_AA64MMFR2_EL1_IDX], overwriting
> MMFR2 and leaving MMFR3 never set. Use ID_AA64MMFR3_EL1_IDX so the =
host
> MMFR3 value is stored in the correct slot.
>=20
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Thank you for this one, dunno how I did this typo :/

Will include this one in the next rev of my small patch series.
> ---
> target/arm/whpx/whpx-all.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 513551bec1..98889426d2 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -683,7 +683,7 @@ static bool =
whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>         { WHvArm64RegisterIdAa64Mmfr0El1, =
&ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
>         { WHvArm64RegisterIdAa64Mmfr1El1, =
&ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
>         { WHvArm64RegisterIdAa64Mmfr2El1, =
&ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
> -        { WHvArm64RegisterIdAa64Mmfr3El1, =
&ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
> +        { WHvArm64RegisterIdAa64Mmfr3El1, =
&ahcf->isar.idregs[ID_AA64MMFR3_EL1_IDX] }
>     };
>=20
>     int i;
> --=20
> 2.43.0
>=20
>=20


