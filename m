Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEBBCCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 07:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHGp3-0001sY-M3; Fri, 07 Nov 2025 02:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vHGp0-0001p9-Qx
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:23:47 -0500
Received: from p-east3-cluster5-host11-snip4-10.eps.apple.com ([57.103.86.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vHGoy-0007JD-Ti
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:23:46 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 58CC71800143; Fri,  7 Nov 2025 07:23:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nDzxdNvPMbkKihCrPo/2QZNzRevpnavezbFvV21gJNk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=O3YddpEYpfCr0To37k+iYB4bQBCgb+Zk9Kgt6U1y3fszm/LQK0fT4CKM+lCRL/7YslonW12+8lYs5SXBymE6lEg/mqMJ7p1cDzkYq1C9S6a1nqTuJ2PeP5UVAz8EW3gMkJ5GlrNZ7PwRfDdPs+VqUl829R9UtexQugRdhHpVb3vtAmS1EMXM1ZzIi4xVMCW2hwTi7YQUaeGsZtNZAdFHBqWhEtdZDvkSy1BDAV/u1F3xuf2YNqc8n7+tHPq3r+/OYYkphTu6gvxUMBJwT5RzhgN+rZUSfO2VuDKNqnORl2jZj6iZYq2eut93odfZGfYXOkH4Vu6/9ObDlnjuuV11Sg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 A9F95180010E; Fri,  7 Nov 2025 07:23:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] MAINTAINERS: update maintainers for WHPX
Date: Fri,  7 Nov 2025 08:23:37 +0100
Message-ID: <20251107072337.28932-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mpXUsRvU2KnzT7gv-sAwMBfgqSeIU7oX
X-Authority-Info: v=2.4 cv=ApvjHe9P c=1 sm=1 tr=0 ts=690d9e7d cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=yMhMjlubAAAA:8 a=kv-9D5d5aYtht4lzJZ0A:9
 a=U4hE3kul-ix6n922hGs7:22
X-Proofpoint-GUID: mpXUsRvU2KnzT7gv-sAwMBfgqSeIU7oX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA1OCBTYWx0ZWRfX75lJIa37Fp3d
 7WUWC2IQ+IsYXco7ujgd+duE+fwS/afHYYMtRUsJZDK+ZMLTYwSnUwigK0ICRLBGqhJ+65QUsxm
 ICjt4Xov6T4+LZdGTvcDUb6BLS3TnR5eWmGbq3DYVeKs1R3Bp6055PSjLp776bmoyzPAOmlmz8g
 59HQOMLt1ydZqNaiwSUKl2Txyx1N43qcSwZH/i9iu8ywTKqcg3HgA4vLIEcAGNfD7A9I97CidmZ
 jVtFeqPZQZP3g6XaEQZFDPcXZU+8hOUvFJrpunDiDVN5CPKeX7YUFBUwR0kjYabpLz8kh7NVurM
 PjWKzgc8HCVKX0TqO+k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxlogscore=686 adultscore=0 clxscore=1030 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509250000 definitions=main-2511070058
X-JNJ: AAAAAAAB7so9mBjgO0plwl1qDcQT1PMNb/c+LGPuhtqAQi/VSoxv2D8ggD3gLDlHNW7HLQWumvNEXGe+h2Qcv6Faa3uoJNIwcMZcc+IVoeCC7Y44wiKiQrTgkt8y9lwLtcMWbYXaewufIEgcijX8pAAoZlIYvjAoURMh4Y9p49KmPRmHFAGCiexyP+zTctRbJCX0nMGMNlssO9G1Xu6EibtTgIbrtI/EzJZqrh6o4hcM5xtddAWvNsydEYxtz39zQvuMJo+kF6eouIGbStOb5jDJ2PijG65JP4Br2GbsgQAPJVxQg1UxaSJBgGDIxYc/nY1FMHNHIkXhcOoPZXzx0XKQaNufWEhkvFB3OnRObPmhV1N3QvAOZ/13YhWk5vt99SkU9jq0e1zOkZJgTNvNBp5Hcb9WSRGAQ1dNRN2tecDpsCWFNgCyVhQFWm9YmJvaLPRTRbI3GTiB4L3KtzccQTsk4FlyLf0w3gT/vG1a57F0mkfXrK7oy2cN7Qct3mkE0g03TQu3gGq9Jhv1VRVaN1ynMJBHoe8HtRVT1qntvlCJ1Gi0kV5bOicnImBtToMjhX9GWJ7MwJLRDeY5ZbJjEXjP5l2cWeqkRuoe
Received-SPF: pass client-ip=57.103.86.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From Pedro Barbuda (on Teams):

> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be6efff80c..c75b1a4d07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -547,7 +547,8 @@ F: include/system/hvf.h
 F: include/system/hvf_int.h
 
 WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+M: Pedro Barbuda <pbarbuda@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
-- 
2.50.1 (Apple Git-155)


