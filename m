Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF7FF327CB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Y6-0000AJ-M8; Tue, 21 Apr 2026 05:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Y2-00007w-2x
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:39 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Y0-0007si-HS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:37 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1357214a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764255; x=1777369055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIeQ72MINFLwiJyja9lYXXTVaJXOtPeuJ5tBq73U/30=;
 b=enyY/qiKAPWFvjtMAKvTX4gAnVBP4oBykdS1lwKvcZ1IfkE9vIpxcyQOAMNVs9RMPA
 z0VrXYPHSSIIPDJrXDCLryqWUWK6v6Ethmp4tgId5PUyHFcYZ3YSG74BVsUkF3BWq3HD
 sxtA0a9J2e18YupsodB1qYCRv/ydbvDan7GVGmYPpQDwUg8yprHVZW2lKTJD0HDyJVd8
 /WiOH3LySsUocSe5yBJsQKqAVDRLPWnURTdUfeDrwsoAEospzWPLKRQCMIN3yFMRHC6N
 sUZsOitsrGdSd8b6CgouEebnRMq0IkE5BLxOkG/CEDnYyfbxIHFDpK8jJG46sWM390ND
 Bsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764255; x=1777369055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eIeQ72MINFLwiJyja9lYXXTVaJXOtPeuJ5tBq73U/30=;
 b=BrkRd4uHgjk/ElxxPqd0Do6TDMSFK/q9AIZlrQDX6g7GOkHQhK7PDv+bbE96Fb4Im0
 7qmdE3ryRIBKlZqImLD9k5H8vYGAnUTKyYnFgQOAnyZDjfm1t24LOn7da5CZPkTgPga/
 Gl6tEblTXlSBzcR8UofTIx7F0BfBCJUtekzaijHrCld+4EWayVwWIEni7EZrUKyZEdbV
 aiif+Ts07Yj0Jz31ax66KC3eMnUYAph+VNyOF/vJQldTl5ta7XBk79w5DWu2GnoPZ7Hr
 ZG5YcMtRppC1XhphEzTf4uRrl2ZiQK+sNL89ingt8H4tbnzp+mcBiu7ZrNzF+NgRd2hX
 oOZA==
X-Gm-Message-State: AOJu0YyQaLFAdGdSGkiW1soKMybTvchKbymvq70WMg91+yB27mAGRlrT
 MrLroK6r18saAlePlcSDmdOjUJ1zUfNGi3GumwfvSYsak+rwL7o0kYcgCWSqVF7DqxhDtwKqgf7
 1R+5j2uG9L4E5De763V+D1rtTC66NJQqaSpjxXrHkMw+kjVmfvBKEIjNZtKIPju06G5Wpsyw+tX
 BPNzR3inbaY2fiR7yHG9ux6rOAh27oe6zkV7mnWikyLsGsb4zN
X-Gm-Gg: AeBDieuPGgnKM9NoP7zwzJgT1gESTuT0Emm9m41sm06waCH9zW9pMQOOND4aUaxxJin
 8h1FnsbUEkdN9cUFp+WmUTApi24Ec88PbMG4Sg6qr9tMTYmORV6cMH08GjWhKjQY5fHlIq8kR61
 zyiDo/RtM0twUQXmDVTOYwwJSgU4tzyoOx7BxEOnwyKUtWF0fb/tzrTZBsmGXFJbKFtto9ufSDD
 bJHWqC01t7xXx5nOVWlwnnpZSNdQ0X80sYFaoXNomSQMmR4MCEX9fEkpJU5E31FxC1k0geZwu7L
 byJJTmwuZQgL+VKPciDaMugVlnwPKlw453eTm9Eywsdbl41hk7TFhCp3x6ZZjLJOndHagFPSmD0
 ShO++rBO5X7xjTMwNwhyQ5lOy8pvouGZnFvXz8nWk430aA5ozaEXoj0Z0kVby3u1t3NuEjdoiRy
 kcgTcF1Nm5LNW5mHjMva6qleETkusxk5ImuFOB9dxDIhbMI8hf2QsoWXXKkdqM
X-Received: by 2002:a05:6a20:394c:b0:39c:4af6:4309 with SMTP id
 adf61e73a8af0-3a08d748b55mr18530051637.12.1776764254611; 
 Tue, 21 Apr 2026 02:37:34 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:34 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 5/6] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
Date: Tue, 21 Apr 2026 17:37:14 +0800
Message-ID: <20260421093715.2995067-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
References: <20260421093715.2995067-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm() to better
reflect its actual usage. This function is used when checking the PMM
field for virtual-machine load/store instructions (HLV.* and HSV.*),
rather than for VS/VU modes.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 2 +-
 target/riscv/internals.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 672f0dab0fb..138183e017c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -890,7 +890,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2b3fea81d50..ef1ff7cb0bd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,7 +214,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     int priv_mode;
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 43b77d30f27..82d24f433dc 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -203,7 +203,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     /* get pmm field depending on whether addr is */
     if (is_virt_addr) {
-        pmm = riscv_pm_get_virt_pmm(env);
+        pmm = riscv_pm_get_vm_ldst_pmm(env);
     } else {
         pmm = riscv_pm_get_pmm(env);
     }
-- 
2.43.0


