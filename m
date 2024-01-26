Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C63C4828A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMIa-0000qD-Nq; Fri, 26 Jan 2024 08:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIY-0000lW-1S
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIU-0007bN-EE
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso12250355e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706275865; x=1706880665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVWt+St3Ao7R6IQtw+wm6ZjZD9uCy5mKNVtcNByTS0E=;
 b=IeQwgOQ7vBckQ0DNx8H9kA1oX7cu/N9QIfuBZneyUbbRGyeYHVlPAr4kdLntGCDyXI
 yeSMRFhSLrFbsDfyQWRIH/MCJfXn+MmuWCWzMRDqoxTt6GtIeQzzsVU8OFurNPXlgowZ
 RsV5FMoydVE1r0RHcWCES8x14AMIp/haRgI5QEUvE/tVG8jjAGG4fG+s7nPFOjA+E5qG
 hIzxIoWp7cBiZvY4rrOBGlDi/jXR12BoEBBNsb6pXB+Bks2kYTI6Sqc6E4ucXMJ2t5dh
 ZJAx+itjDoyuuwm4o1nrICmBZSYuPwPKJ9fAVTG8/0hXCD+CQJJTOxobAmFi4s4wQQXV
 dkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706275865; x=1706880665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVWt+St3Ao7R6IQtw+wm6ZjZD9uCy5mKNVtcNByTS0E=;
 b=BXx1yMCmieq69X/xeI9r+iZYkoaSf887C1AWfM/sMvL7zz8ZCr69/KvCTIRzHmQuVu
 gn7/aFBRgBvAWcZo3TgzarfjJl0mihWe7Xit6rvF3APn5RCF8lQXvTryfwPJIqNJRJOs
 pqUBx3/KDMev0tDMLQPjKyFdIHpF6qdU/h0zwgzR9YH1CdEA4AAqqCVE9W7GOS6SAHzM
 fLJObSHtqWI/T5sbRCje/LCAcZf/vuJQEHQw8boZGVRovQoojSJXU1Fq1BGmgDJALQFK
 lTYVDg6PpdQK7fAQGCAJr8Nz44uhxyLOiCHGxn2pu276rR6b5ZtHas3G5fLj0vjcTYhQ
 Vf8Q==
X-Gm-Message-State: AOJu0Yy7sO7lnChPZvgM0wS6klAeLk6r5xI2X1VsS5q3tZXowxJEEP6c
 m2/ml7jqNY/pU79kBVHsVMZ37SzC+fMdxYKJcImQcmImx1PSi+3pJjqIrvh60A13aDYTfMO5qzS
 u
X-Google-Smtp-Source: AGHT+IHP6LQoTNmZHR2oodocUL7BmkJZvjTK5udXH74C2vxgw35NBxU+8nXWncJRB05FM+LlJS0KJg==
X-Received: by 2002:a05:600c:3785:b0:40e:c7fc:a44d with SMTP id
 o5-20020a05600c378500b0040ec7fca44dmr547990wmr.355.1706275864754; 
 Fri, 26 Jan 2024 05:31:04 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 b26-20020a056402139a00b0055c4c97b1f2sm591166edv.91.2024.01.26.05.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:31:04 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
Subject: [PATCH v2 1/6] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
Date: Fri, 26 Jan 2024 14:31:03 +0100
Message-ID: <20240126133101.61344-9-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133101.61344-8-ajones@ventanamicro.com>
References: <20240126133101.61344-8-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Recent changes in options handling removed the 'mmu' default the bare
CPUs had, meaning that we must enable 'mmu' by hand when using the
rva22s64 profile CPU.

Given that this profile is setting a satp mode, it already implies that
we need a 'mmu'. Enable the 'mmu' in this case.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index da437975b429..88f92d1c7d2c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1107,6 +1107,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
 #ifndef CONFIG_USER_ONLY
     if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        object_property_set_bool(obj, "mmu", true, NULL);
         const char *satp_prop = satp_mode_str(profile->satp_mode,
                                               riscv_cpu_is_32bit(cpu));
         object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-- 
2.43.0


