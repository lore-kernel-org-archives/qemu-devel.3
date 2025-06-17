Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9037C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSdz-0004oq-6c; Tue, 17 Jun 2025 05:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uRSdx-0004oQ-D7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:30:13 -0400
Received: from p-east3-cluster3-host3-snip4-5.eps.apple.com ([57.103.86.28]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uRSdr-0007SA-9h
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=m5EHCxnLUI9g19UWq7w7xzHzv94wGzwFOBGbOx2WHpU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ya5DKljx3zciXx5S/12dmMe0HTN0WVuO9wCNcx88K+z45fld6aQyzbXYaT8PNcOZr
 +EGcrdKa5RK+RBww8ABNpYNyjjdBpuHHw+i+IG+pc7EldpEuOTeKeaIKQIUc0Y4gGN
 rMQUjI2K4M9HMnr3+qsQdrP5Y9A+KdED5nWkT5XI77GS3AERW4ygJQM2oht0yq3uYq
 22OCtAt6EVP8mAAL7ym8Vr+ORQ4kHOUnynhYhuMnROxFX6TVT+1ywf4ekwjUz6UgHH
 CQ8qHDEJJw/9C6nmFHFARDqLyl/1DVhx1xt0e0OT3CI3i9rPd0QOc2Ep+dGB4dmB0L
 6XCjhzanbhEeQ==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 0CB56180015C;
 Tue, 17 Jun 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id E74CA1800139;
 Tue, 17 Jun 2025 09:30:03 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] MAINTAINERS: add myself as reviewer for Apple Silicon HVF
Date: Tue, 17 Jun 2025 11:30:01 +0200
Message-ID: <20250617093001.70080-1-mads@ynddal.dk>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I0_mB6wpvK0J66Zf7HkkFJPIMjBV8fc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3NyBTYWx0ZWRfX3GiyuRmnKUGc
 9tU8cNbctMX1ZuNO3jlvKPbBGVuH1GKoYz3nwaQzEIoWX0zUzG+aG3fLcY6wR9beO1BEV59CI83
 P1p20Lyj7C89mYicuOO5sNkiPh21iqG55+345ZQMwZisOr1I1rGuaiQoCb2s+PnQlF3tWub9/BW
 VN1ks7YtRo0/RL36SCKOpTW2Bx7oOFZwqlvgKuUphKRue8KNJEvMp4Gs5CKIFc7md7U+NkFGB8y
 5Z1n6sqKUlxz+IEaBP8cE+Mo8lQenXP28bkhc5emiBxRrFoBW+onfy7ZdgEw53ifkpp98OdSg=
X-Proofpoint-ORIG-GUID: I0_mB6wpvK0J66Zf7HkkFJPIMjBV8fc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506170077
Received-SPF: pass client-ip=57.103.86.28; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I've both publicly and private been digging around the Apple Silicon HVF code,
and use it daily as part of my job. I feel I have a solid understanding of it,
so I thought I'd step up and assist.

I've added myself as reviewer to the common "HVF" as well, to be informed of
changes that might affect the Apple Silicon HVF code, which will be my primary
focus.

Signed-off-by: Mads Ynddal <mads@ynddal.dk>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28b3dd2684..2b9be05aaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -509,6 +509,7 @@ F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
+R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: target/arm/hvf/
 F: target/arm/hvf-stub.c
@@ -525,6 +526,7 @@ HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
+R: Mads Ynddal <mads@ynddal.dk>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
-- 
2.49.0


