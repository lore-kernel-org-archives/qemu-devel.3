Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C75CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4R4-0001Fq-19; Fri, 10 Jul 2026 02:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qh-00017l-Lh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qf-0001to-CE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2caed617615so4898995ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663780; x=1784268580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QdAr9D/AKWbbgVhux8nSZTA92u/F5FOChbkl4ZDK1HI=;
 b=iKkl1krAs3LtTmiGf7eSqgygWbH6dpQmZxFwQD/TaI69T8X5lDeF3HBiGAI96u7wuf
 45zIUASKnu6MstwWMdqOsY8jrvl8xZgzHky19ELU4TE9QuuKbb5w56/xPczrkWIoIfaC
 oTJT2KpvbmcAqxo3EQ4DerHkVF8xLd7i+OjcFwpOL+PpbuiF/U/V+9/jfGcGhXNsB6EL
 ZfcFaZ1DlgauZPBIAHCdcsaJzYATzAsjhnx2SKrudZpNJJffoEyHm3jbHi3iFi8jmrk5
 MBTnwg9j8Thc8k4HtN5jJZpVpUfOaKyE9MMJ9KEv0tVG/T/QTCuIqpGvFzT/3bmDHXcO
 7TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663780; x=1784268580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QdAr9D/AKWbbgVhux8nSZTA92u/F5FOChbkl4ZDK1HI=;
 b=VcZfXF+swvvoLV0sIFwPmY9P3YcdjDWBX1+7yj7Gm9bV+TzSD9uW7kT7ZUVOKWNqgg
 aLwZkgiAcBvtZRzX+rNu9WpK9gS71m/rJ74CSmGnNsC2Pxz+YQGxjAKDXzRNEZIECKzS
 /1cqzsTbYs1evgzC/aQDXb1aFutocVeslS6trfn14+giBFrWhfD+uyElbNKqVZ3PhDRT
 XZEBPn5YShVZjlMpd9Od3VrdsWhx9K/iXIJLkv2AIsvM8TlzxdbZJ6UuYY4uyBr5G78z
 0F5j0agR4NSv/9KZTCwBwfzbC7mVvIoPbi8rS59w/kxyzgYQpvx9g7IdlWfLb1HY8p6A
 JxlQ==
X-Gm-Message-State: AOJu0Yzb9yPSWxUnIGI2Ziv+kVLkbz6hiM8plTxolT5Sh7crG2kPy8Ag
 9g66C+M3Nltt4+RnT310lunp1Y25PHkA3AOOfo+PMKyeLpiBvwrcQYzm0oUVXsjq97Pj3Beswv3
 HOXVPtY8VLOl6KOdceroVq2uYQi0BKNfO4q+fb32dRGfdH0yJYcEmNbFv1KgthDJqNvvvXBeiP2
 /dESqS8oZfBOB2hHfUBCobHwBCtQ3qA+pUIa7E/FN8Aid26nKu
X-Gm-Gg: AfdE7cnV4bkmc7lH5HL6Jsp5XyELcX62GcpehAO24D2oTjau4LdPzFPnXzq5LCNk5Ua
 H52wSpy7K1Pph5G1f6L4LRz4tdwecGUlciz37EiNVNy49KRlkls+w80k5KOn+BeATfmVGMDAEFa
 bcxa48mFwUjGJTSSCcQPUeIokoictqDXFNc6nxUAPvsQUE7pvwY5sJQNy0sVcQnlGmHlZ2aGBAb
 JIv/nOMlONDemSHGxFFoQ8KroGGdraUd8WMH6kY9gUhiRfNG1SqW7WuAlP7KDkhWAqGYURMxrx3
 VIyta8f5wymQxSEJvdjpkorVh+S63aMt1g8jzP7dims6bagY8qFKplVTVmv+uBm1OrwYen7upT8
 NZMQjN4zPJAdv5irAYmEHLZgOdAqsGhtNYc+RV5TahMIf0JnE1lZc9YPipeEs2DxPcW7rt1pbOA
 uPSM8773QAwk8I8I87jnLF2E9mnEAcW8t49K1cPnQ=
X-Received: by 2002:a17:903:1670:b0:2ca:52ce:6f74 with SMTP id
 d9443c01a7336-2ccea464790mr119302695ad.29.1783663779961; 
 Thu, 09 Jul 2026 23:09:39 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 4/7] target/riscv: Enable Zicclsm for the compatible CPUs
Date: Fri, 10 Jul 2026 14:09:11 +0800
Message-ID: <20260710060914.1227027-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060914.1227027-1-frank.chang@sifive.com>
References: <20260710060914.1227027-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Now that Zicclsm is supported, let's enable it for the following
compatible CPUs:

- Base 32 CPU (to be backward compatible)
- Base 64 CPU (to be backward compatible)
- XuanTie (T-Head) C908
- Tenstorrent Ascalon
- Ventana Veyron V1
- XiangShan Kunminghu
- MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims that
  it has unaligned load/store support in hardware)

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..7ee89f6fc4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3268,6 +3268,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3340,6 +3341,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3426,6 +3428,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbs = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zbkc = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zihintpause = true,
@@ -3469,6 +3472,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicond = true,
         .cfg.ext_zicsr = true,
@@ -3518,6 +3522,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         /* ISA extensions */
         .cfg.mmu = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
@@ -3577,6 +3582,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
      * The RISC-V Instruction Set Manual: Volume I
      * Unprivileged Architecture
      */
+    .cfg.ext_zicclsm = true,
     .cfg.ext_zicntr = true,
     .cfg.ext_zihpm = true,
     .cfg.ext_zihintntl = true,
@@ -3633,6 +3639,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
         .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
-- 
2.43.0


