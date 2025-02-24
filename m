Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66653C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdPX-0004Ul-3b; Mon, 24 Feb 2025 13:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tmdOd-000427-RS; Mon, 24 Feb 2025 13:41:43 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tmdOa-0006r7-BE; Mon, 24 Feb 2025 13:41:39 -0500
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-220ec47991aso65172155ad.1; 
 Mon, 24 Feb 2025 10:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422492; x=1741027292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eFNfM0c+Ibx/QrlYzcwNJybRS6DgFvk8R8vglhbxGbc=;
 b=Zn0kkg40AdShrv4H1/AOS8IqZeqyiXi/94pxrOvx2vviHrtAYyTlrh8AfrYo3PGwfm
 HNHJHavL3ainm+4G1e4Y+eWWfajybk1V2zQPKelqLc8AMxSEMmZyOm8cBiUxmyq40w76
 +cX7pxUiUpzau8ctpVBbQyjrVne48U/q6EKc1ntQ1qm9unfBFQOvCMiRWonA4pTDkZ8n
 zJht07WB9KNrqzFgXYomxDLeyCiXtkuzxjRpGVbyPnlBWe/wTOnXukVFpSkkDtQ0/uJU
 jhixH1a/PmBSpUoCl0lekruTFDwC7cx1O0zUka8HSpA1+q5mlTXb9BtiZLX75C+tTAy7
 S0Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWZUYziSGSBqZUaWU+YIK8Lqdt5WZGjTRlaq8GHyD4C2OSnZ0/ke1s/IH33/n02bO6IF2YGms9DA==@nongnu.org
X-Gm-Message-State: AOJu0YxrITs+8iRIaz8oSmoVvkm2XUjoH7OSpdjWr3QbPbpwkn7OYq+N
 e0rgF6Oa646UkYtO7V3MOrcXTnEWKAn+Hs1jjxpbw6ZD8wwBgxYpbCIrpenX
X-Gm-Gg: ASbGncs254PBq/L16QYPk9SpAmc5hcx9svC73m4V7jFacbu3jk7CHU1z9CPucO4EGvl
 Z7r8g6Ng0IZIlL0wDWLS2+m5DhRUcEHsf+xGJennk7tCmvRYPe8wOgFWqh4YtJ2CFtGu/+jjS3e
 AOzYK9a70mxJM/e8zyqkEdpltsKiQgnJKTWZyFHgQH3EFgAJOFeijwIdXMLIjPHEMlKTS+/CbQx
 EqNVeQ1ByznRS3UMQObKXReqa2V7R9WOuS5tj2GLSQ/cunxurUn+d2Jz529tLmwvmaYnzOpMaHu
 R2nM5TqwI52oDAiK5vRjZT7La5B+GV5OymwFbDa/mHjacuhmRXqc1R/s
X-Google-Smtp-Source: AGHT+IFbgY5KX4yUXiAbRzOWSDArd8gLr9FkaGMzqmKEBQFTdNPX+OsgDy1/UmE8G+FfI0UMxiAegQ==
X-Received: by 2002:a05:6a21:150d:b0:1ee:7fa1:9156 with SMTP id
 adf61e73a8af0-1eef3c48fe5mr25000165637.3.1740422492479; 
 Mon, 24 Feb 2025 10:41:32 -0800 (PST)
Received: from localhost.localdomain ([2607:fb90:37a2:e54:b846:cde3:ca66:b2d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52aee0sm19214227a12.47.2025.02.24.10.41.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Feb 2025 10:41:32 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] hvf: arm: sign extend when SSE=1
Date: Mon, 24 Feb 2025 10:41:23 -0800
Message-ID: <20250224184123.50780-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.173; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f173.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

According to the ARM manual, when SSE=1 the data item must be sign
extended.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0afd96018e..43cf250eef 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1971,6 +1971,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         bool isv = syndrome & ARM_EL_ISV;
         bool iswrite = (syndrome >> 6) & 1;
         bool s1ptw = (syndrome >> 7) & 1;
+        bool sse = (syndrome >> 21) & 1;
         uint32_t sas = (syndrome >> 22) & 3;
         uint32_t len = 1 << sas;
         uint32_t srt = (syndrome >> 16) & 0x1f;
@@ -1998,6 +1999,9 @@ int hvf_vcpu_exec(CPUState *cpu)
             address_space_read(&address_space_memory,
                                hvf_exit->exception.physical_address,
                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            if (sse && len != sizeof(uint64_t)) {
+                val = sextract64(val, 0, len * 8);
+            }
             hvf_set_reg(cpu, srt, val);
         }
 
-- 
2.41.0


