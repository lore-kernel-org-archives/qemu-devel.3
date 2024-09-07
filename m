Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC17BE6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlzh-0003hE-8I; Fri, 06 Sep 2024 23:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzP-0003En-1Z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzN-0004rV-3s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-205659dc63aso27854875ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679191; x=1726283991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4MfaAoEg0D4PG1s02DK0HI+nWn0NbjMokYUO+miRKs=;
 b=VyFIHfk8uZ+7XyQ6F3in7K7dbr0ICc4j2aTIjkZzykzGUQZL+iaKFOE8p2ZBr77R93
 L1LPOpcCwczbJ561BPIu8cc5IGQ7mscAAkE8iwMXddjuHbQD73owCvd5Sn2mY0lYxCsJ
 xIfOQREOk19eTFl49yeEWQaTPv/qZ3uObFqBh5QRKebxnrCN8IgfNdfpDiCW/UbCjoty
 R2rMeyXj6Zcai4bZtlXLty1cPCbY1dJlCxcXNFdJ6tWw6qOdc6R7DltA+2I57SlnnRm4
 6xwSD8FWI/As9FYKis4yFeLd3L/1JkvfevVOkq65CcMLUtypGCA9CMZVax82YCGsW5eO
 A+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679191; x=1726283991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4MfaAoEg0D4PG1s02DK0HI+nWn0NbjMokYUO+miRKs=;
 b=OZqy4oUVvT5uFww6uyK5Qqar46/HKSTbKNSgFstt87T+cQ8OVFHjct6YwmH/M1+R82
 HbVq+i56VJ1NgfHWUMjUZx3NUftDEOV9Djq5RoLWMPc9e3UCK7kDKKxQYEhpdws/jVWX
 GW+xxJAIy2lGlLTuPyBZr/ePuJ3MSuQHjMhwEMoqdGrq1TSY5ImK7vMmub9ZEQkzEWvc
 uKSxr+mHFjWv7bAAo5gAUaRJ9RkBco2WdGzv+44bI59G3385+L0zvv1LHlrNbf8CC2El
 gevvMkmXssCW3yp8RFeM1vv2THsGGVEpXwwG7kvT8jNUZq8+uuQI1NqH1Lmx24c0X80l
 pdBA==
X-Gm-Message-State: AOJu0YxuHV9bGTr77dQHQ7lkQkBaIgi+xMgFuH/zZEhAeNIj9DeZz0vH
 rpDghYd97QG5vrNs6IP40+vfYeoxgRK1GZWWEwppfp+zg/XyLsK3afL5suqY
X-Google-Smtp-Source: AGHT+IGLKO+vkOqS3nX4jPxAsKf/07UdTLheLbJRCq+xlG8Ljp1w9E7SpSRJAf9thF5p9oRzrzKNQQ==
X-Received: by 2002:a17:902:fc50:b0:205:4273:7d3e with SMTP id
 d9443c01a7336-206f064c443mr61078525ad.57.1725679190603; 
 Fri, 06 Sep 2024 20:19:50 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:50 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 05/17] bsd-user: Add RISC-V ELF definitions and hardware
 capability detection
Date: Sat,  7 Sep 2024 13:19:15 +1000
Message-Id: <20240907031927.1908-6-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Corbin <mark@dibsco.co.uk>

Introduced RISC-V specific ELF definitions and hardware capability
detection.
Additionally, a function to retrieve hardware capabilities
('get_elf_hwcap') is implemented, which returns the common bits set in
each CPU's ISA strings.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_elf.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_elf.h

diff --git a/bsd-user/riscv/target_arch_elf.h b/bsd-user/riscv/target_arch_elf.h
new file mode 100644
index 0000000000..4eb915e61e
--- /dev/null
+++ b/bsd-user/riscv/target_arch_elf.h
@@ -0,0 +1,42 @@
+/*
+ *  RISC-V ELF definitions
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_ELF_H
+#define TARGET_ARCH_ELF_H
+
+#define elf_check_arch(x) ((x) == EM_RISCV)
+#define ELF_START_MMAP 0x80000000
+#define ELF_ET_DYN_LOAD_ADDR    0x100000
+#define ELF_CLASS   ELFCLASS64
+
+#define ELF_DATA    ELFDATA2LSB
+#define ELF_ARCH    EM_RISCV
+
+#define ELF_HWCAP get_elf_hwcap()
+static uint32_t get_elf_hwcap(void)
+{
+    RISCVCPU *cpu = RISCV_CPU(thread_cpu);
+
+    return cpu->env.misa_ext_mask;
+}
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE        4096
+
+#endif /* TARGET_ARCH_ELF_H */
-- 
2.34.1


