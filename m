Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BA2C3601A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWh4-0006dz-LZ; Tue, 01 Apr 2025 04:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWh2-0006dX-Kp
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:09:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWgz-0005iZ-R7
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:09:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so3392420f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743494991; x=1744099791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/C9eBT5K6NV+Z7IEOoDW8bFUHrvBiPlv6gBs4OyowY=;
 b=PI/MTn3/i1mEMSCbCzFZ4mSNZDKyHdi31cA/PdRrVVqVy6U4g0rZw/+EorBdzEtRWH
 m1+8HU8GaFr2R7RctbaT1ux7EyR2feyrfpKwNZ4WmsvSgiPUGFj87xuTOtGDqPrnpncN
 oWrvpTIozYMaHm24XzjMmIwL5r7yjug00Y8iKSWULdIfwWa48CYibd04fDMi+/RkEcQl
 zBAyoewmDaLXBBd68+MnoFkRX5/l4g/r3t+EQl/QhWMFe4Lh1YaLJygUygX93ufVmWBV
 Mm3OWo0aPQrzb0VaIzSGjlUGy4kvpqvZejB26CRwNYB3EFtINBsU79m8ESggvkFaUCBB
 DuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743494991; x=1744099791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/C9eBT5K6NV+Z7IEOoDW8bFUHrvBiPlv6gBs4OyowY=;
 b=LHwnwbvgt0Th38kTkFtotFUsmBNAXw3A9+mTAYDnLIcqjNaLBzl99bxRrrdZfNu2By
 txzwOEXtRNP2A6C/Oc8/FOvWuJsdeR7oYNm/r7upfUdOguu/3oEHHnzwloUFDGkHoKe6
 JKaAM+9dwkKPCba2tVz6Ox87TRbOJNk8CgIZYivK+zqx4zwE60PAvTPFJ1scmKZuEWqn
 6Rvol2qqVWdKNWyEFFiFSoTkfrIQme2ubLgmxvuSxdoDUAro+RcPMSF0l684nYKdvid6
 IZn/9P5kX0ZtG3DFK1LAHG0vrUlmbMfeTrk50iToAU9OA8/O10ykwzpgBm2rQ7Tt1saL
 lhnw==
X-Gm-Message-State: AOJu0YxxbRMJA2MgkpwtjkN6/mwtQr4+5/O+kqL3l2a9XkrHvTazdaYp
 Jk+WJOFg18BMvDMVUIIVVL9Fl6DwvuaUpDzu9aJKTn5oH5Qt7pohOM7Itxdk5vmsu/yD06SB433
 1
X-Gm-Gg: ASbGncvu/TQdKvjhD3AM6XJYnbU2pHR1a7zw/Q8MgaFuDPm8iuH3EhQE5JBS6lz71OJ
 FdcCzwoHrn948Ifz4K6EF5qVldl8ZhrsZa0t3ifoQrPcRgKlCLQYfOgOhaEodco/UYDPvGUy9Xy
 If0hiwDO0mz6Niy8G0Qq7njvTiTZTay/of9upxLnkeh5WcD4/sYvA/kxP5vuc6NjaP00+8q0jyh
 XwvtH9dOqsNAXzpnHqdKordVaUIonM0xtLkcM1VdbP9JocBOmpimQ36NownGI0KeOvUrJF9TJMU
 2CwbUwpX/qaoIIJz1LaTl3Y7ilhT17sUfwsi1nx8FoL8Eu+k7reCiLizLOsKt8b2Z1yu5yNBXF6
 Vs1rdUPch9/6A094/m3s=
X-Google-Smtp-Source: AGHT+IEKyHABW/9S8MH+kAgs6Yt/oKt/EVfk0i2V29/3U1pIuY5Jx2iNHdVs56QAL9K2kaJcsqiXcA==
X-Received: by 2002:a05:6000:40e1:b0:391:49f6:dad4 with SMTP id
 ffacd0b85a97d-39c12113977mr8572739f8f.41.1743494991123; 
 Tue, 01 Apr 2025 01:09:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e1b0sm13319243f8f.75.2025.04.01.01.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:09:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 02/24] accel/tcg: Introduce TCGCPUOps::mmu_index()
 callback
Date: Tue,  1 Apr 2025 10:09:15 +0200
Message-ID: <20250401080938.32278-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

We'll move CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h  | 3 +++
 include/exec/cpu-mmu-index.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f60e5303f21..106a0688da8 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -67,6 +67,9 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    /** @mmu_index: Callback for choosing softmmu mmu index */
+    int (*mmu_index)(CPUState *cpu, bool ifetch);
+
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
index cfc13d46bea..651526e9f97 100644
--- a/include/exec/cpu-mmu-index.h
+++ b/include/exec/cpu-mmu-index.h
@@ -10,6 +10,7 @@
 #define EXEC_CPU_MMU_INDEX_H
 
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
@@ -31,7 +32,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    int ret = cs->cc->mmu_index(cs, ifetch);
+    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
+                                 : cs->cc->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
-- 
2.47.1


