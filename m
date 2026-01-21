Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E357DC44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWND-0008QP-6o; Wed, 21 Jan 2026 06:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1viWN9-0008FB-F8
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:27:39 -0500
Received: from p-west3-cluster3-host10-snip4-10.eps.apple.com ([57.103.72.251]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1viWN7-00086B-OK
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:27:39 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-1 (Postfix) with ESMTPS id
 466531800117; Wed, 21 Jan 2026 11:27:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1768994854; x=1771586854; bh=XYnN3TMBqCZi25J7XUjHswZ9Muo8zXeD2eTqauA7WR8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R6IhFiWk+FgPSVEmfYX39izc+VnYM90YhwbHUVaximKcvTVrDVXAp2L5ICpMXmMbdXBQCIIbIvlP2eXtenHeNo4VDCR6bA3d6BmZcbL40uv2O44C9yq9DGIESQein8gdASgGTiCxYzdOAIGdwhWx7os/WCfl3Yr2dLqnyOJ6QS7cZFblDCskFJZRI0j1z9XxrQjvngVbureyee25gH4E9NOIgqlspADRkTY8n315ZkvZcDyVdzjxShQgxdyK2yYVVWB82FfsORaHIbyXlZDd90vkFjqchdEaC0HFeu6ZoCs+Q+lnY17vj3b5fw3XDN3ioTrBqWG1P5NJI5ncEDz31w==
mail-alias-created-date: 1632407063367
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-1 (Postfix) with ESMTPSA id
 6D1AD18000BF; Wed, 21 Jan 2026 11:27:31 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] MAINTAINERS: remove myself as reviewer
Date: Wed, 21 Jan 2026 12:27:25 +0100
Message-ID: <20260121112725.40060-1-mads@ynddal.dk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j87oYJeAnf30oVjahl_drXb0bypCX2qn
X-Proofpoint-ORIG-GUID: j87oYJeAnf30oVjahl_drXb0bypCX2qn
X-Authority-Info-Out: v=2.4 cv=XPU9iAhE c=1 sm=1 tr=0 ts=6970b825
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ID6ng7r3AAAA:8 a=t-IPkPogAAAA:8 a=lB0dNpNiAAAA:8
 a=2ORJyF7xAAAA:8 a=20KFwNOVAAAA:8 a=55ukL3awT7V5O3jWUYcA:9
 a=AkheI1RvQwOzcTXhi5f4:22 a=c-ZiYqmG3AbHTdtsH08C:22 a=4vzVo7jydstbtNDrrb0h:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NiBTYWx0ZWRfX7ajg42dNSlD0
 WYy1ydB6YC3VUrPUfRvRayBpxH2oKoOBV5CSZ5R7nvbkYy6pHgcJwWa8hmyaubul/hCWNb6gtQn
 e6g5zHJ8Hm3t5BAiWTJw4XRet8s93E7nc96mkEcvhUHVlzhQBWMIQ+Lc7gLyjv7OrzMRfX7IjL1
 jpUoEl/v43ehNIweAzTnRzM9ZtynGr5PQDwVVK8FMktDSfjyiiqAjQHXgXxVqQ/NqgwEPGa/2Sf
 GOyP/7kOwmrEmBCPAEbVW0nwJ3pO+jsyacTSe0KdzHMb8pHh4aOPRi4W5SUFDPtgKZbELb1QoZP
 HNUNv3y31kgxE8k1pK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=825 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210096
X-JNJ: AAAAAAAB1yukKIaHd73gWHMPPNHDmQHnZ2D5aa2pOl0dPF58fOteJy1mHWXwKjR5teplizHwC9F47KB55PWhTNGjQr3iUU1KD//aE4CD5IPGwZmnjduaoMjzt2FFntyxgn8G5cF8Alk/isVge4KEgCAseDYRoNSf9bz9argRz8fx2Te98gv6RRr9GpUHgIQjbsGgi7nwG9KTR/7IJr+kbQSkPevWPJXYsdo2BmigbL0UEU1klqU3JxuybIWkC13v07phJS9KEdeP4GxJxC4rLyUD7j+x3CbNisUExGURfMJxCb0dtQGD8Kw+m6DutAwgrCPS13IqIt29l8jBu31JU49IhP+6RJ91QS9+A+6Yh4jutc3ZTH77u5zP6Pb/7cLf1LBml2M8cx1zBPKiYFFXZUKT8NMymPguowoZXFvMKNVk1uhNTsz1pl20x8jDGEbrfxfoxzyK602rpE/t3LYqfP8DbfLV6fvd4F5Krv+0yclbVliAbZpI0fLik32I8xeYO2CPl5Xi5ik39RZuyH1idmTdXiPgRGjTvM2P+XhVJk4e26Vzx6by0t4QKXBrwkzQxu4iDbbCY9xZqOLWA0+9nONwXc9r3UVJpZ5XdPxn
Received-SPF: pass client-ip=57.103.72.251; envelope-from=mads@ynddal.dk;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

My work has changed focus, and I do not have the time to continue.

Signed-off-by: Mads Ynddal <mads@ynddal.dk>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36a2be3ddb..f0a6a0d00b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -536,7 +536,6 @@ F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
-R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: target/arm/hvf/
 F: target/arm/hvf-stub.c
@@ -553,7 +552,6 @@ HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
-R: Mads Ynddal <mads@ynddal.dk>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -3655,7 +3653,6 @@ F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
-R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: trace/
 F: trace-events
-- 
2.51.0


