Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2C9D3F07F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7PH-0000y2-99; Wed, 28 Jan 2026 10:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Oi-0000Zg-SO
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:01 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Oh-0003Tp-Cg
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:00 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso6918592b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769613838; x=1770218638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtjvUeuWhkZyONrdS1On48+U1sCeHHvT9T0OfWxFIiU=;
 b=Cl83GaaEsBeB7S05m92oQ1hOW4DwoQJQ98BHkTL35Ap3Gqm3O6i5ljxWBFJEt9ivC8
 2jrfsxkGXE3cu2DWPPTUhXyzEcTZAP+iJ4lCvlRIoHkykMXf5GJ/Z+5VaXXbw8Zj9Bwx
 NalKg/A11MFRW4cd2ArPp8FdFWzIdtfC/JfPbKjUfz2X2iZdAF4gHtviYOSwaz17ptoR
 vc3fj5Fq7hjU3+zlwkymtOEXd/AKI/NBpGynnUdTL/jFs4eRG0qi4VgZKvC1NmyBrIz8
 0n7iiTcbF1OWu1k1LxwMNWQ/jCvxQ07/sgxllo0tPSsNsw52FNFOLjYwi4fQROriz46c
 P5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769613838; x=1770218638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PtjvUeuWhkZyONrdS1On48+U1sCeHHvT9T0OfWxFIiU=;
 b=ZuW5YUqfm6eNUF4y1oiPh3ihRxD1UNtF2DCh7Jc77dN+c0nVAyqUmm8aMHNpkbyhgu
 ZZeylX/hEsC1HlkVezzdmx5h8N8+OatEiRADscBgsRef0hQsIhDkdL76LiCtk9CCH0hg
 LUc1wOCyK7N4nvMtohusUYRH+EnN5oY+r4NPVWGqY38yox9rRELhvv/3GZzGWR6rNMxP
 M1eQ0r2CxhykJ0HbQAG9ZgnMfETvK/h8z5l3KZVt9ERdhRRBMrDY2KpBaWcPwQt09EnS
 ZG7tJANFm/g6HWwnta8ovco0B8h5noC87pZlTm6cac+rebJ64oJ0JdT6MHXNIgz8FD5h
 H7Ng==
X-Gm-Message-State: AOJu0Yzg/KblOos0E6igHlUBJm6KBwuP+g8TxWWqRtYML8Gi0jnosFxM
 qPaocmzBy7gY+rdurqej5nVQcSqVc8boaw3/4QFl1+5Fd0DJ2CGXyMgZhp0rIqk6RJigjwWLqaJ
 epIvMs+aQZ6gni40ujIQxH1lht+GYWxjX5O0awS0UuTfmgLTFM6ctfT4UEb+oxR/guHf6shC2j+
 XHTixneI8bYyw0/FWKbKaO9eQGY+RR0dhTboqvNg==
X-Gm-Gg: AZuq6aJwATRnevpi2CEpzbj8nXe8fm3p/WAqtkYtnVV/umBRE+vqlAYn1PjkcKxlOCK
 Mqrj0LdfRbfxdfykaJlCx9Ae0VksyWjPrOrlOVW/s/KhbBsnJokocsQnSXsza0uxacwKKKzYZLj
 giSb4Hw1p+GsFKLj+K8G1cjm6bMqsTjRaEbeesL4vNtjz+1GZecIA3E0QH3+csFfpumlZIrkoLs
 +kZouPryITX48zjKsOMbqgQDlgf7WyLuAu55vKrbW/xLCC/vsfd89sCoM/Akl3UIJErm4AUCgr4
 Zix+CgcOMKkxPRXLR8lW9k+PvyIHZxkaV9gVJ2dMi+hZFfVkTTcXgxbQBcu23JuRlFdRDrJbVbS
 eWG2n4Mv7GcLoNYz+6PPukpGqeEqHq+MBo/xJYeUIn9i2XMhfSrDmNoGYcPa3efyoBA39CIr58t
 2h9XS5cFatCD3BMRVvSJIS8Y0HhokkCJDkn1SI6F8aQJ0=
X-Received: by 2002:a05:6a00:3a24:b0:823:bbb:76f9 with SMTP id
 d2e1a72fcca58-823692a7e92mr5427906b3a.42.1769613837616; 
 Wed, 28 Jan 2026 07:23:57 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c1eeebsm3021304b3a.45.2026.01.28.07.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:23:57 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
Date: Wed, 28 Jan 2026 23:23:46 +0800
Message-ID: <20260128152348.2095427-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128152348.2095427-1-jim.shu@sifive.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42d.google.com
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

To let io_prepare() function use the multiple members in
CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
member as the argument.

It is the preliminary patch of next commit.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 accel/tcg/cputlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6900a126827..82c9b6389dc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1270,14 +1270,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 }
 
 static MemoryRegionSection *
-io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
+io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
 {
     MemoryRegionSection *section;
     hwaddr mr_offset;
 
-    section = iotlb_to_section(cpu, xlat, attrs);
-    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
+    section = iotlb_to_section(cpu, full->xlat_section, attrs);
+    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
@@ -1981,7 +1981,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2002,7 +2002,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2499,7 +2499,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2519,7 +2519,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
-- 
2.43.0


