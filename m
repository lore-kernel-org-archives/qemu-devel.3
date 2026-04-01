Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71A9107637E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7w3c-00031q-8V; Wed, 01 Apr 2026 09:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1w7oJn-0001Ul-14
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:40:43 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1w7oJk-0003sG-9P
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:40:42 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso5357106e0c.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775022039; x=1775626839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSThUlx67lF4UcpDajQRGXGdp+BA8NL3r+o77yX/0xY=;
 b=S3osCslLs4XkCfBnZFPcsNujDbmUZdHVpnniOpb+TV9MLhshBR+UipT6uI4mz4f6yg
 yC8WpXfntEegJRRQiMtKuuDxdGBExrOb2kzGuRfWMr2tz6YfJ297pohJ52RX6Un1bq2W
 RKf23Zmr463Ci3qXG9/Ap10MDtTajFMliMx/5+qliovFUzPJbHRm6i/1NVriAOWlDroC
 EbvYBG1csPq8LUwsAg841d2UVeK7BFrGKE13E6nKFYevSVzXG5Ei0zwyubrE/rmAWYzw
 6zKc0iIPsWLIIdCc69D3kYS4eaTcYBc8czVRKM/6rgNKkSYXxAn8PbDTmO/cqQ82I2Q0
 sJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775022039; x=1775626839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RSThUlx67lF4UcpDajQRGXGdp+BA8NL3r+o77yX/0xY=;
 b=S3e1sTE/UQaspC2etPLtsG1YK1AmGfhqx73PhbF7QTuMTpUfAIgZe1z0bCtykISaDu
 azBCnJb11+CfT8R8czrrqCphxDgON/6vZsJKzxQyatwvgyFM2abyC3k8jKrc7+Sa2z/p
 dQqQ/i+7lF6jznV15/9P3bbUP5/AotBER1McDJ0z3UlvfPdVxFeEJyh1K1q08YZ1CN/N
 lEUazcoGkxLt9sJsbzc010JWRjBYNB+s9Ea6kW0M2XMuM7Cy5bmzA6la6m/UngQxv1Sf
 L64vlylFksc6X9s7BTJ6hQIR3QSh4XPlrz8KYVY+OVywTwD5Dw/H+njyrClYORe2RInI
 jUZg==
X-Gm-Message-State: AOJu0Yxv4gKITLOaKB97+qGfricwsPxokQBPq7XfxG4GrCGW/x+Eapxr
 dZipz14d/GffCEmzXMTzQABuC1nNsi908yuD3qd8f6Jw8jYwZC3LqpVUlaWw1G1SAXZPwA==
X-Gm-Gg: ATEYQzzvn1cZ1ihFC37OiDPrLbG6ZEB3V6nhRQS+xc9px1SKZt+koajTZrxFjx9MMv+
 suqBlzWPEbm2zSZmKO2QnTVJNGySKqY7EOl3fZkeRExLoOlvXo/EabtVTC/yHth07C/16drwoBk
 esMaUy/C2zEZBrFrVtGbL+hUin6NTA5Pch6mrwb/KoN5HzfOe1et+XTRxcjGXFgCVJJ8oXdRH0D
 kfAEZ08xNbzRR8TkWVOEr3BhICrdhPfkwavXn0CkcvzIyY4BdI67qmeRiVoFRG+prWzPwSjLF2d
 hXgIeGLVqZN4mD6LyM6jQcECpHy8N4h1BR7nFq72y7FRLh8Ra7CI1cIHmxLQ0n3furB5ATVPiOZ
 2zRFMRwcx9454Wm5g2NTNW2vSAjPT3AS0SQmOvIHn8NN9PNOeigG6tttCE+e1Wzh3STc1smL6DB
 FNJ/nRDTtrvWY9xGb7XvQqU5g=
X-Received: by 2002:a05:6122:82a5:b0:56b:9aea:41e3 with SMTP id
 71dfb90a1353d-56d8aaa8323mr1100052e0c.16.1775022038960; 
 Tue, 31 Mar 2026 22:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6d9:aa::11:1a6])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d58a7ba96sm14817891e0c.17.2026.03.31.22.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 22:40:38 -0700 (PDT)
From: =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 berrange@redhat.com,
 =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
 qemu-security@nongnu.org
Subject: [PATCH 2/2] hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
Date: Tue, 31 Mar 2026 23:38:53 -0600
Message-ID: <20260401053853.10473-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401053853.10473-1-sebasjosue84@gmail.com>
References: <20260401053853.10473-1-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=sebasjosue84@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Apr 2026 09:56:21 -0400
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

The MMIO read/write handlers index timecmp[] with the absolute hartid
(hartid_base + offset) but the array is allocated with num_harts
elements. In multi-socket configurations with hartid_base > 0 this
causes heap OOB access in the QEMU process.

Fix by using the relative offset for array indexing.

Cc: qemu-security@nongnu.org
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
 hw/intc/riscv_aclint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 9c1491b..e27e5fb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -131,6 +131,7 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
         addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
+        size_t hartid_offset = hartid - mtimer->hartid_base;
         CPUState *cpu = cpu_by_arch_id(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
@@ -138,11 +139,11 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
                           "aclint-mtimer: invalid hartid: %zu", hartid);
         } else if ((addr & 0x7) == 0) {
             /* timecmp_lo for RV32/RV64 or timecmp for RV64 */
-            uint64_t timecmp = mtimer->timecmp[hartid];
+            uint64_t timecmp = mtimer->timecmp[hartid_offset];
             return (size == 4) ? (timecmp & 0xFFFFFFFF) : timecmp;
         } else if ((addr & 0x7) == 4) {
             /* timecmp_hi */
-            uint64_t timecmp = mtimer->timecmp[hartid];
+            uint64_t timecmp = mtimer->timecmp[hartid_offset];
             return (timecmp >> 32) & 0xFFFFFFFF;
         } else {
             qemu_log_mask(LOG_UNIMP,
@@ -174,6 +175,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
+        size_t hartid_offset = hartid - mtimer->hartid_base;
         CPUState *cpu = cpu_by_arch_id(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
@@ -182,7 +184,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         } else if ((addr & 0x7) == 0) {
             if (size == 4) {
                 /* timecmp_lo for RV32/RV64 */
-                uint64_t timecmp_hi = mtimer->timecmp[hartid] >> 32;
+                uint64_t timecmp_hi = mtimer->timecmp[hartid_offset] >> 32;
                 riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
                     timecmp_hi << 32 | (value & 0xFFFFFFFF));
             } else {
@@ -193,7 +195,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         } else if ((addr & 0x7) == 4) {
             if (size == 4) {
                 /* timecmp_hi for RV32/RV64 */
-                uint64_t timecmp_lo = mtimer->timecmp[hartid];
+                uint64_t timecmp_lo = mtimer->timecmp[hartid_offset];
                 riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
                     value << 32 | (timecmp_lo & 0xFFFFFFFF));
             } else {
-- 
2.43.0


