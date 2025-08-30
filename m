Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793A8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNzq-00006E-BH; Sat, 30 Aug 2025 12:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERV-0007WX-BA
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERQ-00051r-SP
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2445826fd9dso33012545ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532875; x=1757137675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNjN5B/BY+FR/sks3ZCMW62nI8kvCxcg9XIZHJr9QyU=;
 b=PJtOUDPBa+jktCGtw9JpcOa0CfYJFcj4ebfffeIlMWxkFX2XzUnLvhYpj2WZMvW05t
 zYG+kmSwguFLKlX2KdZIxFwSbOGhBPAMlVhXpiJ5pWv9IN9RSR3XHYWV6HNNpw+BgWx6
 G75tj7S3ouU68BQ8qNqA/dAudVB8t4foJDRrWzhE0ZYa4D9iAxrq4x44VKKBCcZkkLXD
 RdDgpqAm+dAEMEUDvncmqEhcxO8S4J3l3CgKYWeXYrNsGVpjDsdmFcdJN921YLR4Cq63
 6qxaJzq+p03lqb+9E8qle2I9t1wErP+2+CznGZg/CRhXpzV1EChr0FiuoVzXz/PLwR8T
 Kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532875; x=1757137675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNjN5B/BY+FR/sks3ZCMW62nI8kvCxcg9XIZHJr9QyU=;
 b=M34dSGgzFL5/8aTIJKZ/rUXf0AjlO9vNGf6l4Db0cRqcpMDGwtaHRiPzUGAQrEGmsZ
 V4t2lkpmxv55qSx8iqPyKsXBy87UmPtTbLKF7rFZ1qbAYdtR3rdStrVx0M0fRthS+/bP
 EEwmH6GudXo9/VhXl7g+puUlKmNda3QB/dYQvWTIYPqZD8gMk+IkduHMQdKuCRLLKU77
 K1LbsWiAxu2693CHRdxNPpc7sS7eLw1ubtyd6TH6O+wKANfbZLV4/W/QFvG0dnJcMJXI
 O9qnWJM0VJTaU8v0HeFy9DE0k8o5rYk7qPlDqpxP2soFNH569pSMsdVrFjrx5xDM/HT1
 E/5g==
X-Gm-Message-State: AOJu0Yz+fokB9q5U6CTO0oaSzVJwY4/vp5lZaOkvAEkvqwj7/jwWHA5W
 nQk3shcrV8kXMKEXZ9YZBLm3UyxlrDcn91ilvvD44GM3GFoN530nfdUEqyG0MLfo5Ky0kNgVqP1
 UyjVue/8=
X-Gm-Gg: ASbGncupOziOfImT3HA8DkAIMYwaIU9goAm60IA0hOv7pCcAAy7JeSiO4Mp/TEU0tzq
 jCVyf0pxt+8wIiS+4ETR2yXg+LDcGIorGyeYxo015glnzFC0eAyIL3aqjPvU8kC5Ii5zY4Ic3+N
 0f+4TiUe/6Xt6MMnkT8bIpJbWGefkKDuswW0nRByUUNC38+RoppXikJx+4FmQJmAHilavCGuE67
 IUFQcmg3/mBp4r4xbSo+ZjK6wRo6NbZpQoHD98misUqUDHNUpLpNou3PJxop+lwi1z+xX59LF9w
 10/MA1RDVtbGSieNSd7ZmWW5e7NElhVTvuzlkoDNrr/IwzZJzBSj4lffGuM1xlRbPJB9unQebxd
 KmaP0xM6Hip1+6Tj/fEmdTs90xqwg61A5+q8Qoh6yiVXALgScXwCbZDIUhjWOnY5FVc28oKzDbA
 ==
X-Google-Smtp-Source: AGHT+IEBGSWjcfK6Ks7RA7n873UkXWNDdUCrCAzAOl09BvWV7VyI02DPLxwmMDP9r9dBfhuZaiyuaw==
X-Received: by 2002:a17:902:ecc6:b0:248:b25d:ff2d with SMTP id
 d9443c01a7336-24944aed41cmr11694465ad.51.1756532875529; 
 Fri, 29 Aug 2025 22:47:55 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 71/84] target/arm: Copy EXLOCKEn to EXLOCK on exception to
 the same EL
Date: Sat, 30 Aug 2025 15:41:15 +1000
Message-ID: <20250830054128.448363-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Per R_WTXBY, PSTATE.EXLOCK is 0 on an exception to a higher EL,
and copied from EXLOCKEn otherwise.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2f19695d82..4bd96de926 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9194,8 +9194,13 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         } else {
             addr += 0x600;
         }
-    } else if (pstate_read(env) & PSTATE_SP) {
-        addr += 0x200;
+    } else {
+        if (pstate_read(env) & PSTATE_SP) {
+            addr += 0x200;
+        }
+        if (is_a64(env) && (env->cp15.gcscr_el[new_el] & GCSCR_EXLOCKEN)) {
+            new_mode |= PSTATE_EXLOCK;
+        }
     }
 
     switch (cs->exception_index) {
-- 
2.43.0


