Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7099C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7hv-0006pl-CP; Sun, 12 Jul 2026 23:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7hu-0006pO-Pv
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7ht-0001MY-7u
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so2250796b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 20:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783914708; x=1784519508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZpEZ+qwUWzKX/pdopbU/v27JKSx+5w4HgXw/8RsqiZk=;
 b=DCQVOgtMEDExJvXc9FBDzismug7X2lk1Hz182p+A+JEtuPgSK52Ga63WgToH+VeyNZ
 kBDCq9VHy75pT5lmdrhUM/v9UmSp8k5vbffMgBZ0GXmmzZPUiC40W926s3+eWB60d5lH
 FS2DuSAn889BDI7StdRpxIb/krL/X87s9WBHeppw/meHvmffODQncdHOot24AJbFOeNP
 lSQ2aBi1ewejRqkXx5eYTws2UpDNQqknbRWRxK5aMPwkJ6XGKEn2TvfICSgz+GQtDv6H
 QMhfNnub4CYKVbXGDq5ttBLtjlHMvloKZrPcIImUErKDxBvuVAAPwxJtbQTtQ3iCbOUx
 usOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783914708; x=1784519508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZpEZ+qwUWzKX/pdopbU/v27JKSx+5w4HgXw/8RsqiZk=;
 b=GS4wUK1k1PY23KwvFDbxVXL3ABetAnQ+bVV17TNKquc3Fs0rVUDt3xzEi9ZKGegFXR
 mXPB3zr0tDqAi2LBmfYI56iDc47U7mnNMI5U4TsHp+AlF5WBIbnUs5Qo/OwRLKsK1uO+
 LWYbxODt1SWNgy54IsTrwbM4slTErURz8GRKfFX3zphrxvJyYWI7JB8vSvTsbyPoiiAb
 3EZGdTgb4RkkPPfEHTkdLqnyNg0XbWBjnzwOvhLxUkgJ2QfoKsfkjDrv3pkD5OuFgfSs
 vvVrXRP9W4ebCDzX7r/RYwUlqhrjh4ARnPdgnUidrKwNZq88k9NcVNKBcuST3nDQpRtR
 Kn9Q==
X-Gm-Message-State: AOJu0Yx0KXrIgM+JxmGEceP++Tz+ohjKPfRB4zNI2n+ituCPlh1CyRYs
 F8jhPn65jgfytIbiemEUWHvmlcfjrLp2zKLzqQ9OeG+VHl3DMpFOWlBlvLMaH2PLZWBD2hh4L5n
 p8jRGdRDpwXyl8ITnvYyrUpi0EzhTVBRhbbnIzjLuWQJa/Nd9GlFqRudK/aQnwWc2tG2XHwY1rB
 afipdeljTTjG8e2k5hXqrLTzWOB1v/8Qj6JMxLqEjUyz3V2hv4
X-Gm-Gg: AfdE7cnhdp4tXvQdU1uG59woPg0CT4ZyoETguT81RDLbz+uM+Xx6DA80dgTDsXhr63l
 5T2kxvy4zWpKSRf5VGpu9CAPorcIYSutxK4zechZKXsKcpkypRbdhgKjkRlGbz+o+cTnAYPxtjd
 S7CEg+djkbV9zdQmejTpPgTX/6tepquUTzAHBeIrrGW4hc42/c9+1fJdMW+SbmQ90bVrSXxr3+u
 fndOfqvbyrQJ84jSC4gWFz12JiB3CXU4nnTZWg1heP1SN0IbcfVhP1dXdVWflaMhE2LpCI723Y4
 t3wSUN3i3njGEqPf0LcMzdMYBinmvNAhFuUAtDumCGYlKFfHKbBh910cYrscHhp+xdF4OyV10kq
 yqr/wQ+9Epmfy+cz/FY3HEd0rlqtTzfvCJfpdqdeCTp16Q5l576Jdp00ueTvn3UgSkDUcjmqHDN
 c+FEtHkJl/ic/Ha8Ls89cX/K3rOmv+nTdeJtFrUxs=
X-Received: by 2002:a05:6a00:1881:b0:847:8ccc:d7cd with SMTP id
 d2e1a72fcca58-8488974b0f2mr6660748b3a.37.1783914707719; 
 Sun, 12 Jul 2026 20:51:47 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3162d3csm7739884a12.18.2026.07.12.20.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 20:51:46 -0700 (PDT)
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
Subject: [PATCH v6 2/6] target/riscv: Enable Zicclsm for the compatible CPUs
Date: Mon, 13 Jul 2026 11:51:31 +0800
Message-ID: <20260713035135.3996990-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713035135.3996990-1-frank.chang@sifive.com>
References: <20260713035135.3996990-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
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

To support Zicclsm, let's enable Zicclsm for the following compatible
CPUs:

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


