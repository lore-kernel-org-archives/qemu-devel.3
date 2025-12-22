Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE4BE674AB
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 12:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXfIs-0006Rl-2t; Mon, 22 Dec 2025 07:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXfIR-0006J9-E8; Mon, 22 Dec 2025 07:46:03 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXfIO-000744-1S; Mon, 22 Dec 2025 07:45:54 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHT5t9PUlp2+wsBA--.940S2;
 Mon, 22 Dec 2025 20:45:49 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXr+xyPUlpieINAA--.25982S7;
 Mon, 22 Dec 2025 20:45:44 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v7 4/7] hw/arm/smmuv3-common: Add NSCFG bit definition for CD
Date: Mon, 22 Dec 2025 20:45:14 +0800
Message-Id: <20251222124517.3948679-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
References: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXr+xyPUlpieINAA--.25982S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWlIVJoHaQABsI
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AF1kJFWUKFW8AF17CF4kWFg_yoW8JF4Dp3
 WxCr1ku34qgF1Ikrn5Jw47WFsxZayDCr1xtryjgry7urn3XwnrZ392va13KF18Wr4vvr15
 uFnagrWrWFZaqrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add NSCFG bit definition for CD structure. This allows proper
configuration of non-secure access settings in CD.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 include/hw/arm/smmuv3-common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index b6da2fd62c..7f7dd02221 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -123,11 +123,13 @@ REG32(CD_1, 4)
     FIELD(CD_1, A, 14, 1)
     FIELD(CD_1, ASID, 16, 16)
 REG32(CD_2, 8)
+    FIELD(CD_2, NSCFG0, 0, 1)
     FIELD(CD_2, HAD0, 1, 1)
     FIELD(CD_2, TTB0_LO, 4, 28)
 REG32(CD_3, 12)
     FIELD(CD_3, TTB0_HI, 0, 19)
 REG32(CD_4, 16)
+    FIELD(CD_4, NSCFG1, 0, 1)
     FIELD(CD_4, HAD1, 1, 1)
     FIELD(CD_4, TTB1_LO, 4, 28)
 REG32(CD_5, 20)
@@ -155,6 +157,9 @@ REG32(CD_5, 20)
 #define CD_R(x)          FIELD_EX32((x)->word[1], CD_1, R)
 #define CD_A(x)          FIELD_EX32((x)->word[1], CD_1, A)
 #define CD_ASID(x)       FIELD_EX32((x)->word[1], CD_1, ASID)
+#define CD_NSCFG(x, sel) ((sel) ?                                         \
+    FIELD_EX32((x)->word[4], CD_4, NSCFG1) :                              \
+    FIELD_EX32((x)->word[2], CD_2, NSCFG0))
 #define CD_HAD(x, sel)   ((sel) ?                                         \
     FIELD_EX32((x)->word[4], CD_4, HAD1) :                                \
     FIELD_EX32((x)->word[2], CD_2, HAD0))
-- 
2.34.1


