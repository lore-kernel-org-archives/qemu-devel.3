Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DD2C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAM-0002dj-GB; Tue, 08 Jul 2025 16:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luxu.kernel@bytedance.com>)
 id 1uZDis-0000Wt-I4
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:11:49 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luxu.kernel@bytedance.com>)
 id 1uZDii-0005pM-F0
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:11:19 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7d9e2f85b2cso162287285a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1752001852; x=1752606652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DlW7iJ+C8rcpKrpFJBlschQsTW0cjQ0FNGJLVtjFCKo=;
 b=kA7mzyD4SvugwqfP8alf6gRHORCcvhmkkWkSFcUlW7+WxtWKnVxIzjARrlgBweLiPK
 4A/ULbdQHr0aZUs1AVfyC+ACv39LWOYGihpdcOTA1yiJpo0eqiJs1SDRSKR7Pa2+D+GY
 1ZXj5pf4+VOZsiVfrI7S1rTKUxZFfV/C356Alp13d3UWcJPaUGYsPtY6Kh893xckZnhk
 h3fn8RTi/gQCmK5tGAhyy2H6jDetG7l5uyYwEgshd1ebhmsUntoLflxMKY1kxYn1jmot
 nBr05/skVzabPKkxTy/aPbyTElZ5prevrxP28hP4l6SS8nm9nf65VNGkq6ZQjewjIYlS
 7psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001852; x=1752606652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlW7iJ+C8rcpKrpFJBlschQsTW0cjQ0FNGJLVtjFCKo=;
 b=Fh7FyBvDDtsuCxmngTpYqiYAGV6r0nhqdheQfFHrN0h/0nG4Pwz8flsrkBhehEAXCj
 p7Kkq19YCzNw4XN6hkbB+l75g/83qj1pSr7qrX50H2LMVk7eVOFcvKONdPlsgDrCcJMe
 iW4uzYJKC+jbgYDEkwXPU0gT9z8/EmoVkbXKL06DJ5AbxxoJHGiQlTpQuh19vrqSAfj/
 CZa1UMdkJ1H/VH/sx0lxLuG6DrqIc/uvi6Tg7hPUDCf7sDMnJdUeTiJSH00RrrHyGMWD
 2WVcNeEgdFCsjMroXq35meIhm3EQCwCpjbzVzcjNFsUcZ70uSLmDuNflFPK3JTekMeAP
 7P/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmuGFOKV7wimD54XSmeWaat1pmohhR19uYYexzF7eTr6wMwNA9zw6g5ZXbOK42Q3Q5A4eRrW/weWSb@nongnu.org
X-Gm-Message-State: AOJu0YzejxG6lOJyMsHPhttauZIrH/i1gavf26SATVoPBBGbvhYYd8mx
 yCI1KeTFSRtKWZbF/kqbFNNTErI9rsxOlfsAFJqoA9bCYCXpCumCUpTakUsu50tU/i3HalZEr4T
 pvRQ2GSJx7uIH
X-Gm-Gg: ASbGncvPLbS8+57iI0UY2pCVzPqGaLRAsRxtbHTA+6lyl8q7+rZQmLseLxa5baVyuiL
 vHuF8F/WqoypfwLbbLldgauKsKz0sHH4reGI7wazrl4Q50l8JjPpnlndyNHhCB6pYGZXeo8sxZo
 qAHDnrWx9GiuPpGeQbmRNkm6Bw1OgPzLWKaK3RMauBTxSuYm1fqCV3riJ/HDPYfie1ZA2gTcask
 w5U3/+xTpcvMEnu7vCwe2NVqsELc0wO++zpTGjTnQWKSXTl0sUX3jsXWKr67tvvd1bI42HsglaB
 YjqCX0N7c22BzkP2iW/N40thne13cZMNdztn9r90hu1L8GhSI885PL+MQ8KdeGpHiZm0PIgkLrt
 sdO+kmueZOYD0aKNpCrB7/cuhV/DeaTUxa86IDBIdw5b1/BAUEw==
X-Google-Smtp-Source: AGHT+IF6AAIvK9eyIkmGLUG4TOKJUDJZ2TnguFMof4aiR9CrOjY+tkFI+unFspBENtcPGZ+AxsiDUg==
X-Received: by 2002:a05:6a21:a81:b0:220:e7d:8e30 with SMTP id
 adf61e73a8af0-225b8104ab1mr26951229637.18.1751954849898; 
 Mon, 07 Jul 2025 23:07:29 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce359d634sm10615776b3a.25.2025.07.07.23.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 23:07:29 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, apatel@ventanamicro.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] target/riscv: Fix exception type when VU accesses supervisor
 CSRs
Date: Tue,  8 Jul 2025 14:07:20 +0800
Message-Id: <20250708060720.7030-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=luxu.kernel@bytedance.com; helo=mail-qk1-x736.google.com
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

When supervisor CSRs are accessed from VU-mode, a virtual instruction
exception should be raised instead of an illegal instruction.

Fixes: c1fbcecb3a (target/riscv: Fix csr number based privilege checking)
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8631be97c5..9bebfae3f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5577,7 +5577,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
 
     csr_priv = get_field(csrno, 0x300);
     if (!env->debugger && (effective_priv < csr_priv)) {
-        if (csr_priv == (PRV_S + 1) && env->virt_enabled) {
+        if (csr_priv <= (PRV_S + 1) && env->virt_enabled) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
         return RISCV_EXCP_ILLEGAL_INST;
-- 
2.20.1


