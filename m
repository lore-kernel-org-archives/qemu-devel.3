Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83525C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Pc-0007og-SN; Thu, 09 Jul 2026 22:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PZ-0007jy-AV
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PX-0008Ng-C5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc84e77e78so3222725ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652178; x=1784256978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZsrWJ9lTqtF3+aYhIUfv/byL/sR46/lsOsQ/fq5m33Y=;
 b=Wg1z198tztCUGTqGfwTHSRqwU/hjnfgm6XxEUPcReqySsalIMvN/nWwESzm4K50bQY
 8lDY6LGmyLf0fLjtpdXok+yOEKeNrp9It53J4zN9OioHSCqaXB9aW6qvHOTvViGkjvDF
 kuEHJFGzf0FQoN88OzhHVgUy1FKif9Wl3lrUKFSvsuSYk3gPlTfIA3XXMfSIn7FLLqhO
 2JdUU3/SrC1Z0um0h17nKFUoA2p7dDcMKRFRy4alS4d1M4Wk4InQAzcGcszEUrSsB1d9
 sV1xJw11MqIvwhhWPbz5jeOJIC/xwTiwf+DcdSEhz5qrBgRNihjOxadjM6MZX95gAE4W
 yWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652178; x=1784256978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZsrWJ9lTqtF3+aYhIUfv/byL/sR46/lsOsQ/fq5m33Y=;
 b=ivpkWISIbl8i88oc16DEqd3wh+jpHYUt1LS1VobRELJyVMaOaCm7juZJ4uSJj/mP88
 2ucr/6ovzqZwyJGu4DfKbkaBbmRfkMAn7Sk6pMmi3pRcrxxI8JPtJ/Cb1+8yC4JD/Dkq
 3wgw04UCf/mGIPD36x6wVWZ6ym7D0oOTQQQyDYUX+C+wncXVveCQ6d9v6mKW8Ay9P35h
 2I/6lefSrVi6Zm8aLKe4Ql2XMEnXfoEJCJ9FP1d8am1mtksGyQn0IzxfSn5ZdPtmlGe2
 dNtqcHcscnFIiPekLDi4q7oqbc/D8e+wpbNeAxk5Io+I+ExK7oWMFVEoy1usJdqIw1rO
 LkPQ==
X-Gm-Message-State: AOJu0YwPRZxdMPLsnl1/4GLWYf3u2/oJdJIBa+aVRYPAqsRuSPZI7Hiw
 jqEygnSzvYA4qi6XaCdjcLo1Gz0CH2pLFYXJI9dCxtAf3KjK7U2puo37M229vA==
X-Gm-Gg: AfdE7ckM/PiLK7vjkHnztVcH1Y6f/2q4Vuy8HFjbC4QHbtdiyX++9tUPf8QCV+aMZ1g
 8HRUjXBGBTJ4YfOh8GhCd8j/vdjuQNJ1c/mOG1PBlnHrHebnwLCjUD8tZF58zN1ow0yGe0tj/km
 UvyE9sldrOgrn5Lu2L6YyikXkx34oZFrInLfEch5CHCbYzvZp6DHAF58Jtg3VRtM/Tb7ajIjt1Q
 QhJHOxKOzKyD3k6VqlQAZZAAJ5EAo+WmnK71oIZ1e+Q8QMzs1Oh/TkV09h6666r3KgNuBeD7g2K
 337TaPadlEIMDWe0NkPS1YNR1pDNdhbHuQSK71xILLkCZwu9UHvJKJ61BjF/42/37SaDaCL9Pix
 UMFViHZzHr9zANSCzoHgfzjeagdEI+gpS7phVLNzRt5Boq/OIDUzK1Z9vn5rh/H4wvT69tdld4M
 5rnbpWc+/+RkMy9CYelj/Qc3ngrCYrGMo=
X-Received: by 2002:a05:6a21:339f:b0:3c0:9c19:6583 with SMTP id
 adf61e73a8af0-3c0bcf97af7mr14607409637.61.1783652177887; 
 Thu, 09 Jul 2026 19:56:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 12/40] target/riscv: move pmp files to tcg subdir
Date: Fri, 10 Jul 2026 12:54:57 +1000
Message-ID: <20260710025525.1704417-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

A trivial header change is required too.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260703180538.3346781-7-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           | 2 +-
 target/riscv/{ => tcg}/pmp.h | 0
 target/riscv/{ => tcg}/pmp.c | 0
 target/riscv/meson.build     | 1 -
 target/riscv/tcg/meson.build | 1 +
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename target/riscv/{ => tcg}/pmp.h (100%)
 rename target/riscv/{ => tcg}/pmp.c (100%)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 82362ef8d8..ecf2913d42 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -183,7 +183,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #define MMU_USER_IDX 3
 
 #if !defined(CONFIG_USER_ONLY)
-#include "pmp.h"
+#include "tcg/pmp.h"
 #endif
 
 #define RV_VLEN_MAX 1024
diff --git a/target/riscv/pmp.h b/target/riscv/tcg/pmp.h
similarity index 100%
rename from target/riscv/pmp.h
rename to target/riscv/tcg/pmp.h
diff --git a/target/riscv/pmp.c b/target/riscv/tcg/pmp.c
similarity index 100%
rename from target/riscv/pmp.c
rename to target/riscv/tcg/pmp.c
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 61874ed0af..42d0f6d538 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,6 @@ riscv_ss.add(files(
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
-  'pmp.c',
   'monitor.c',
   'machine.c',
   'time_helper.c',
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 5684fcf985..a05ab642f4 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -21,6 +21,7 @@ riscv_ss.add(files(
 riscv_system_ss.add(files(
   'debug.c',
   'mips_csr.c',
+  'pmp.c',
   'pmu.c',
   'th_csr.c',
 ))
-- 
2.54.0


