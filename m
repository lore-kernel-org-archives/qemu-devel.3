Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B970C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOgU-000358-Pr; Fri, 09 Feb 2024 06:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOch-000687-9l
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:48 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOce-0000oP-PU
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:46 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-363dde86f0bso2124665ab.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476443; x=1708081243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyuK4OE9n3bvCKQ/kownxcQ3Twb56+RQX3O6EOwuYkU=;
 b=MnxJB9W3XezBqM56P+RPOEm2TPQWQnRsCKC+OzWfnAcSAX5h6QcfAyLolmKsN5H2aw
 0ugzRJ/WaRHTYsbaM6xGSfa8jp43yC9qgZD8HUXAheO3dUGvIM4rANRzNf12mqDa9ktJ
 A3M8OBZz6ipQOkUJ+24UUe7bwerD7Xm3HfeVBGWpb6UCHwpRqsiSUDeGM8vQxFJ99vH5
 uDaVZkAbo2NjYuRd37JHyGtKyEb9qPE1ECPXV+54paqoUNbyubinRQ5gB/ONQzldZX/a
 ylct8pUDg/BBz4rZYZX6GifEn35jq+WrL8KMsP2U73+beKPDvGpQsOYzkZX3T4WCyyud
 ay0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476443; x=1708081243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyuK4OE9n3bvCKQ/kownxcQ3Twb56+RQX3O6EOwuYkU=;
 b=fFnjdg7TnBxekXu1ZOszd9pkNBSEJM5TyM3Z4+vjD8009w16cOTIf+bjiv93Vr7K0O
 8Tc9zpFSoWYmnXq9DlDHp7jaJoopQzsVPiztN7EOIcTQH/CQhTo+9yEdhUT2GDjX1Jm4
 68G3TzaKKeXMGPPO72R7cNOhW+yFIXj7v8Wu9TLu0GBq5iyBj0QlYfU/1IqQPZZ6uKtg
 IHYZP31shaX6HfSoSuDaLhsMm8OIj13Ch9HgKHyXMMZtc7db5+XC+obWa1YnpTpk+2Yy
 wWq+15EuzPNiVSbJCJWoXmG2atxvM5ObwXAPZ8JvKLelSjfYWgco5jvF65HlH5FKXgCe
 PawQ==
X-Gm-Message-State: AOJu0YxJSpDQHbB3o4VheJdKobq10IcMnRh8wdDj1xWfWIDJAX0cM6Rl
 G6LcyzHJ7tb0PVjU7sRcKD9It3O26dA7i6RsED/8WA1tsMgGZ8+HCMuN94FfgMEZQg==
X-Google-Smtp-Source: AGHT+IEG+j0d18WgSUdk6XRNyktRG4N+b+nN45QhWokbPDXUeNZxRGCUFbFvhsOmGbYZjGySYQTsEQ==
X-Received: by 2002:a05:6e02:551:b0:363:deb3:9baf with SMTP id
 i17-20020a056e02055100b00363deb39bafmr1342309ils.25.1707476443169; 
 Fri, 09 Feb 2024 03:00:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWku35a3qQsrzLIN0fb4DSXv4oBEspi9tqYSxqxmwt3To/x4L+w1LvG0nqHcIelAC9l13uj+Wf1D/L0OTIImsqbQi7jEpybdwwHQwMP+vUS2uSfVmzctw9QfWA0TgBc5xuPJSgIcMEe5hkbPsO9tNzhWhMLZ876mdpO1aqni63zvaU=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 42/61] target/riscv: Use RISCVException as return type for all
 csr ops
Date: Fri,  9 Feb 2024 20:57:54 +1000
Message-ID: <20240209105813.3590056-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12b.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

The real return value type has been converted to RISCVException,
but some function declarations still not. This patch makes all
csr operation declarations use RISCVExcetion.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240130110844.437-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 117 ++++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 43 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d9a010387f..d4e8ac13b9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -242,7 +242,7 @@ static RISCVException any32(CPURISCVState *env, int csrno)
 
 }
 
-static int aia_any(CPURISCVState *env, int csrno)
+static RISCVException aia_any(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_smaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -251,7 +251,7 @@ static int aia_any(CPURISCVState *env, int csrno)
     return any(env, csrno);
 }
 
-static int aia_any32(CPURISCVState *env, int csrno)
+static RISCVException aia_any32(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_smaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -269,7 +269,7 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int smode32(CPURISCVState *env, int csrno)
+static RISCVException smode32(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_mxl(env) != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -278,7 +278,7 @@ static int smode32(CPURISCVState *env, int csrno)
     return smode(env, csrno);
 }
 
-static int aia_smode(CPURISCVState *env, int csrno)
+static RISCVException aia_smode(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -287,7 +287,7 @@ static int aia_smode(CPURISCVState *env, int csrno)
     return smode(env, csrno);
 }
 
-static int aia_smode32(CPURISCVState *env, int csrno)
+static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -496,7 +496,7 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int aia_hmode(CPURISCVState *env, int csrno)
+static RISCVException aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -505,7 +505,7 @@ static int aia_hmode(CPURISCVState *env, int csrno)
      return hmode(env, csrno);
 }
 
-static int aia_hmode32(CPURISCVState *env, int csrno)
+static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -681,7 +681,8 @@ static RISCVException read_vl(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_vlenb(CPURISCVState *env, int csrno,
+                                 target_ulong *val)
 {
     *val = riscv_cpu_cfg(env)->vlenb;
     return RISCV_EXCP_NONE;
@@ -742,13 +743,15 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int read_vcsr(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_vcsr(CPURISCVState *env, int csrno,
+                                target_ulong *val)
 {
     *val = (env->vxrm << VCSR_VXRM_SHIFT) | (env->vxsat << VCSR_VXSAT_SHIFT);
     return RISCV_EXCP_NONE;
 }
 
-static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_vcsr(CPURISCVState *env, int csrno,
+                                 target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -798,13 +801,15 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
 {
     *val = get_ticks(false);
     return RISCV_EXCP_NONE;
 }
 
-static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
 {
     *val = get_ticks(true);
     return RISCV_EXCP_NONE;
@@ -812,7 +817,8 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
 
 #else /* CONFIG_USER_ONLY */
 
-static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
 
@@ -821,7 +827,8 @@ static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
     return RISCV_EXCP_NONE;
 }
 
-static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
+                                      target_ulong val)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
     uint64_t mhpmevt_val = val;
@@ -837,7 +844,8 @@ static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
     return RISCV_EXCP_NONE;
 }
 
-static int read_mhpmeventh(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
 
@@ -846,7 +854,8 @@ static int read_mhpmeventh(CPURISCVState *env, int csrno, target_ulong *val)
     return RISCV_EXCP_NONE;
 }
 
-static int write_mhpmeventh(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
+                                       target_ulong val)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
     uint64_t mhpmevth_val = val;
@@ -860,7 +869,8 @@ static int write_mhpmeventh(CPURISCVState *env, int csrno, target_ulong val)
     return RISCV_EXCP_NONE;
 }
 
-static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
+                                        target_ulong val)
 {
     int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -885,7 +895,8 @@ static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
     return RISCV_EXCP_NONE;
 }
 
-static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
+                                         target_ulong val)
 {
     int ctr_idx = csrno - CSR_MCYCLEH;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -945,7 +956,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     return RISCV_EXCP_NONE;
 }
 
-static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
 {
     uint16_t ctr_index;
 
@@ -960,7 +972,8 @@ static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
     return riscv_pmu_read_ctr(env, val, false, ctr_index);
 }
 
-static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
 {
     uint16_t ctr_index;
 
@@ -975,7 +988,8 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
     return riscv_pmu_read_ctr(env, val, true, ctr_index);
 }
 
-static int read_scountovf(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_scountovf(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
 {
     int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
     int i;
@@ -1638,7 +1652,8 @@ static RISCVException rmw_mvienh(CPURISCVState *env, int csrno,
     return ret;
 }
 
-static int read_mtopi(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_mtopi(CPURISCVState *env, int csrno,
+                                 target_ulong *val)
 {
     int irq;
     uint8_t iprio;
@@ -1678,8 +1693,9 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
     };
 }
 
-static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
-                        target_ulong new_val, target_ulong wr_mask)
+static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
+                                   target_ulong *val, target_ulong new_val,
+                                   target_ulong wr_mask)
 {
     target_ulong *iselect;
 
@@ -1758,8 +1774,9 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
-                     target_ulong new_val, target_ulong wr_mask)
+static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
+                                target_ulong *val, target_ulong new_val,
+                                target_ulong wr_mask)
 {
     bool virt, isel_reserved;
     uint8_t *iprio;
@@ -1833,8 +1850,9 @@ done:
     return RISCV_EXCP_NONE;
 }
 
-static int rmw_xtopei(CPURISCVState *env, int csrno, target_ulong *val,
-                      target_ulong new_val, target_ulong wr_mask)
+static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
+                                 target_ulong *val, target_ulong new_val,
+                                 target_ulong wr_mask)
 {
     bool virt;
     int ret = -EINVAL;
@@ -3031,7 +3049,8 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int read_vstopi(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_vstopi(CPURISCVState *env, int csrno,
+                                  target_ulong *val)
 {
     int irq, ret;
     target_ulong topei;
@@ -3120,7 +3139,8 @@ static int read_vstopi(CPURISCVState *env, int csrno, target_ulong *val)
     return RISCV_EXCP_NONE;
 }
 
-static int read_stopi(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_stopi(CPURISCVState *env, int csrno,
+                                 target_ulong *val)
 {
     int irq;
     uint8_t iprio;
@@ -3576,19 +3596,21 @@ static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int read_hvictl(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hvictl(CPURISCVState *env, int csrno,
+                                  target_ulong *val)
 {
     *val = env->hvictl;
     return RISCV_EXCP_NONE;
 }
 
-static int write_hvictl(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_hvictl(CPURISCVState *env, int csrno,
+                                   target_ulong val)
 {
     env->hvictl = val & HVICTL_VALID_MASK;
     return RISCV_EXCP_NONE;
 }
 
-static int read_hvipriox(CPURISCVState *env, int first_index,
+static RISCVException read_hvipriox(CPURISCVState *env, int first_index,
                          uint8_t *iprio, target_ulong *val)
 {
     int i, irq, rdzero, num_irqs = 4 * (riscv_cpu_mxl_bits(env) / 32);
@@ -3614,7 +3636,7 @@ static int read_hvipriox(CPURISCVState *env, int first_index,
     return RISCV_EXCP_NONE;
 }
 
-static int write_hvipriox(CPURISCVState *env, int first_index,
+static RISCVException write_hvipriox(CPURISCVState *env, int first_index,
                           uint8_t *iprio, target_ulong val)
 {
     int i, irq, rdzero, num_irqs = 4 * (riscv_cpu_mxl_bits(env) / 32);
@@ -3640,42 +3662,50 @@ static int write_hvipriox(CPURISCVState *env, int first_index,
     return RISCV_EXCP_NONE;
 }
 
-static int read_hviprio1(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hviprio1(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
 {
     return read_hvipriox(env, 0, env->hviprio, val);
 }
 
-static int write_hviprio1(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_hviprio1(CPURISCVState *env, int csrno,
+                                     target_ulong val)
 {
     return write_hvipriox(env, 0, env->hviprio, val);
 }
 
-static int read_hviprio1h(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hviprio1h(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
 {
     return read_hvipriox(env, 4, env->hviprio, val);
 }
 
-static int write_hviprio1h(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_hviprio1h(CPURISCVState *env, int csrno,
+                                      target_ulong val)
 {
     return write_hvipriox(env, 4, env->hviprio, val);
 }
 
-static int read_hviprio2(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hviprio2(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
 {
     return read_hvipriox(env, 8, env->hviprio, val);
 }
 
-static int write_hviprio2(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_hviprio2(CPURISCVState *env, int csrno,
+                                     target_ulong val)
 {
     return write_hvipriox(env, 8, env->hviprio, val);
 }
 
-static int read_hviprio2h(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_hviprio2h(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
 {
     return read_hvipriox(env, 12, env->hviprio, val);
 }
 
-static int write_hviprio2h(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_hviprio2h(CPURISCVState *env, int csrno,
+                                      target_ulong val)
 {
     return write_hvipriox(env, 12, env->hviprio, val);
 }
@@ -3699,7 +3729,8 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int read_vstvec(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_vstvec(CPURISCVState *env, int csrno,
+                                  target_ulong *val)
 {
     *val = env->vstvec;
     return RISCV_EXCP_NONE;
-- 
2.43.0


