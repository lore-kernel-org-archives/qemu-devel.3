Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC175D37E44
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2i4-0000SI-1L; Wed, 14 Jan 2026 10:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2hd-0000Fv-CS
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:38 -0500
Received: from p-east2-cluster4-host1-snip4-1.eps.apple.com ([57.103.78.152]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2hb-000070-1z
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:32 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 927AB1800434; Wed, 14 Jan 2026 15:22:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=LkbJxPsNo7CJa0Ql+vJ4n+aQqh7AhOEhWRjn2Gw2+dI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=IzYZsbvQeHjZsJCnh9SNojO2/zS3L+yGRAl2DnqZhK3g5mrgMMpkYo7+LpqBDF8BkaSRQ5qCz6gleR1yXjl1cnFXsbXjbqT2HyXPZ1+6tD+6iYQ6KNT5eyj6zpd2HnF710pLwn2Aq4x1NsSiFKgvJB9x4mm8PREjp6OylBdknVfvWQYSoopEMKni7uyJ4+S6I9Ch8MBqSsB3l1k1fLi9A37xUBlk+2Keka/qe92hoaOwUDTtp3Id4YZ7c/UN5liRT/9Q3tKPgD5rFzFqC/UFw78sQ0DApzgLXJFoAY5yiLmfsyiFv2fYTN2qxhgGpRehoQfUZOaeB1/QPdZF5KYEyQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 0D5FB1800106; Wed, 14 Jan 2026 15:22:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 0/3] vmapple: making it work on the latest macOS host
 releases
Date: Wed, 14 Jan 2026 16:22:17 +0100
Message-ID: <20260114152220.89640-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOCBTYWx0ZWRfX9FNj/e6ppA2V
 rJuqscIUEWanSFK+B1woWxSBwmVKp7WlC5cARf8DAs6RDI26uqWUSmhqkyZ+M2SSCuCPDklA70u
 dLE4mioDpRumHBAordsouhJly7pnOI66btctpX+Mf1yYogp0H2tICI0aj1PqVCpFj1+E9k+rYHC
 sKYikVo+Y+DwzFvN5mBxfZtLbaEZ8sH3ac102joZ2hmGFXSSRVwRSzBEPhnx/qlSZx4/QLYY2WP
 vMz744Lpkyd2bA8xeT4mKs3odQYTtmUF4KN/24XeWn7d/D5TEcUELaS4Ts4kko44BLJ67u/oE6c
 thc6S/hjboeUYLk7q+Y
X-Proofpoint-GUID: VT1DseWGM34JwN_-daV84bIcRkBVAT0V
X-Authority-Info: v=2.4 cv=K94v3iWI c=1 sm=1 tr=0 ts=6967b4b2
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=PWwuWOSklEzM4Y2Y:21 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=_2RhaUPNESQhlGQwPh0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VT1DseWGM34JwN_-daV84bIcRkBVAT0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 clxscore=1030
 suspectscore=0 bulkscore=0 mlxlogscore=513 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601140128
X-JNJ: AAAAAAABhiHHsl49n7eONuY1BS9rMeWtD9BtF4ccId1POoQIs59G5v4KMiI3zUIltUkN/Dm7bUBm/crcvNfihfcVDMT0NABYaSyxWTf6PHf9kNN9FrvzL8I7B65OZaJFrFartW+7XvOhWei4/Q4qMi/B+e2Mv5E6gannNQaw96Tgd9ibuydZ0hvhn3BdY8iz0BeUbjkl+dKbu2NLNDHGHzABNBNE8dkvJpsTmyoMUBUOZwYFW3FV4oJG5g+Ofino1SImtKwQynO2y6bom9jxqh2QmyerNIm0xAWyf7aaeWBGOrSaoD+FvGxQNb1izxYBoQGtpaJQMUBkmTEIFHBcbqhONlsqXymcocMrjm7p15BuseryW8mmHpl+PldBbXdtlPVozddRe/nt5zndJdbw8ihCqjTFPfVyvtjsWW7PIyrc00j4f5lcU4UXsFej6RmZvuWe1MqSTlBEVyg3n6iuMorSY23mqZEhJ2SS/M7tLkPBKLdSO1ukDUmyWUqUR2dBisnpMrZTHhf3pyw24kWGiwpeOFZiSqftfdqzqTPp9bhQp1z/pMoLXxaVhrj43dIgPu/ZH51Z4eNW7plL9kDQbeYfiq/LrAEKNcFsL0dXXgMxJ22li4lqGmB1u9JdAP0/kAR8YdvYSM3bhmqMvdLzgsw6guOcQTCYJLklpomixcMYhSkAa49F819qeKxTgKh7ujj+OJo=
Received-SPF: pass client-ip=57.103.78.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Support for newer guest OSes isn't part of this series.

v4:
Rebase and resend without the RFC tag as I didn't get feedback.
Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.

v2->v3:
Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
Address comments

v1->v2:
Remove some lines that shouldn't have been present...

Mohamed Mediouni (3):
  vmapple: apple-gfx: make it work on the latest macOS release
  Revert "hw/arm: Do not build VMapple machine by default"
  vmapple: apple-gfx: move legacy memory management APIs away from
    inline

 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 70 ++++++++++++++++-----
 hw/display/apple-gfx.h                      | 13 ++++
 hw/display/apple-gfx.m                      | 47 +++++++++++++-
 4 files changed, 114 insertions(+), 17 deletions(-)

-- 
2.50.1 (Apple Git-155)


