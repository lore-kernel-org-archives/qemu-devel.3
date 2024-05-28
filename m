Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1CCC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmq1-0005gV-Qw; Mon, 27 May 2024 22:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpt-0005Wd-Hj; Mon, 27 May 2024 22:45:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpq-00041k-HS; Mon, 27 May 2024 22:45:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6819d785528so246636a12.3; 
 Mon, 27 May 2024 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864308; x=1717469108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xv5zByHXrMR6OVpxVCKjSat3U6+gmlv5WCvdVnmoelg=;
 b=TWEpryTkxKGXNjsDQzkVOiRwuoLVNTim8cq8lOclqV9UQUt7a9bBE6dVH0n2c2JqTq
 Mp0Mk1j4JbruZ9tpOjnXW7rKIIDQNPZWArPO+caj0jgaQ9Fz80GDzwExubiK/wVCkLyE
 ZMi+GrLnc7SbrdzBlOy7Bj2ZF/e8vQHjwIJ/9vaQRzZ/OBErS1Y0k3ghNhgQPEKXncJY
 T+bktFC7QtsdpN2beTwudKw77DfWL60P8iEsDgpxyEgnq/sSzQhslpvqrmBTiJy4Dmza
 sqgdiCvmSbOKhbegLzAJknmybhv/s0Ff/3X+uz1fu4YWqBeEN7Ud86NGyDOax9Xf5KyM
 TtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864308; x=1717469108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xv5zByHXrMR6OVpxVCKjSat3U6+gmlv5WCvdVnmoelg=;
 b=Al1D1E8pxta73RO9iCwnLsVw8vLkRogJ6/836ynsEPpkC9/4R5qcwNEAKnmZisUCpr
 sHmrH+Rqphiaq9swOQaqP1d0pWbRY5T9js++39yybLdzmbC4I9g+OFiAb7y1Phh4V5Xq
 YSKzIXWDmayzfGFN886oO/CBERHr6Z74pAA2T0mNXtiyHcSt5h/Acbf8LRVfBuRDM32y
 t1RhXsWWaYkoMdRIBzVG6J78CYYC6MwKBcK5fm0qWrgPRJV1mhY8hZJ5QSj6blN/Tnro
 zbv4OXi+AGLX5xtIoifSShC+1OKVGENePv/2X1LNjWeEjVNrhzk0fqV92Ai+tFPYZ5Na
 Lv9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkfmcSbaODWZPPFiWGY0HJkh7yHIEn4Ddmd3D4+XTA5JxrtTQdfy1fyTPX/bG4Alta8Ifzp70gVodEjOArRSalOiWbn0FX
X-Gm-Message-State: AOJu0YxzK8saXD0Ad4K+xvoxKidzsseH5f0zAC8rEBH8cQ6PcsotdPU1
 STu3eV5Wjq6U6sgaO1efZg4F0WrmWM0Mxg94rS8eokEpzucleAhEANYpXA==
X-Google-Smtp-Source: AGHT+IGyjNhVDLV7wP2cTb0MykOtOadn6UrXBIbLFt1w1Fo5jBfmvaQK/H170C4ZpKL11CA+R1IuWA==
X-Received: by 2002:a05:6a20:914c:b0:1ad:90dc:4a65 with SMTP id
 adf61e73a8af0-1b212d3a7ffmr11815750637.27.1716864307765; 
 Mon, 27 May 2024 19:45:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joseph Chan <jchan@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 21/28] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Date: Tue, 28 May 2024 12:43:21 +1000
Message-ID: <20240528024328.246965-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

raise_mmu_exception(), as is today, is prioritizing guest page faults by
checking first if virt_enabled && !first_stage, and then considering the
regular inst/load/store faults.

There's no mention in the spec about guest page fault being a higher
priority that PMP faults. In fact, privileged spec section 3.7.1 says:

"Attempting to fetch an instruction from a PMP region that does not have
execute permissions raises an instruction access-fault exception.
Attempting to execute a load or load-reserved instruction which accesses
a physical address within a PMP region without read permissions raises a
load access-fault exception. Attempting to execute a store,
store-conditional, or AMO instruction which accesses a physical address
within a PMP region without write permissions raises a store
access-fault exception."

So, in fact, we're doing it wrong - PMP faults should always be thrown,
regardless of also being a first or second stage fault.

The way riscv_cpu_tlb_fill() and get_physical_address() work is
adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
reflected in the 'pmp_violation' flag. What we need is to change
raise_mmu_exception() to prioritize it.

Reported-by: Joseph Chan <jchan@ventanamicro.com>
Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240413105929.7030-1-alexei.filippov@syntacore.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d71245a8cb..574886a694 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1177,28 +1177,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (env->virt_enabled && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
+        } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
         }
         break;
     case MMU_DATA_LOAD:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
         }
         break;
     case MMU_DATA_STORE:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
-                RISCV_EXCP_STORE_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         }
         break;
     default:
-- 
2.45.1


