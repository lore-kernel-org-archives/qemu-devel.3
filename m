Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2CC107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2woU-0005un-FD; Wed, 18 Mar 2026 15:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w10-0002Vz-64
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w0x-00066j-3z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:09 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486507134e4so2017615e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773859985; x=1774464785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDtU3k6M3GiftyqmYDg1aRbMp4kh06I9uB7ga9EAvCk=;
 b=nrRFbKrsM3ghrCBwefMS1BEYh+UYgjz5VQiZvZZDjC5P/KzNdpAUcTUz3BVMP3lgW+
 zdhImmsPyqHdNL5DdIkzmfjfTN6rmYOKpSlgVz9o1WcfqQ2FbBgSYiAwm/0Pl+9lXVm4
 JmtioOMsjCIft78UVmNJSe65sXn0G8LQ1N5MDGh7ZdX07DfCZiyQdmyiFQQWDwnaAQ47
 wW9c5Z3ozxjgW2CwxRxngwvo8cfEA2V8Bz94fHiDBcTIis72ix8/G/xhI+uOkkrUzl/2
 dLMP2820x5MDeBQX+0ypDQrRwDehoy+1kwoCk74ScJfyG0C8c8BYZH8RI2v89nxri6/M
 r1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773859985; x=1774464785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jDtU3k6M3GiftyqmYDg1aRbMp4kh06I9uB7ga9EAvCk=;
 b=P7YZL4kPQUHMmptoqZGnqCA4ILKStESR2hA7h/zuKy+6yo80JUM4GVPqhGbHU5930b
 xhtOwaXQdiu+bX+blxfxvsRZJwjLxfce8qZTok9q/+I+DUOg+X88J2ANqegQZfcSFg1B
 xkEJywSQfVK7YWzaOeQqAVGl8CJoLXsHEwFlZJUvVM1ZQWOLheNaQO+qVFEeMEmABPzb
 jW203KrKl0Pv/jAVi0mwq54H/qUVwxBbMyiIgM6oqweTmQHbnofplwhMUUhKhLNU3ySx
 nZVEfCxbii0+Cqink0JPTbz8CBWJvYcMir96VLE/vgTJsSYdujZamhk0SNI1g0YaiDQG
 3VeQ==
X-Gm-Message-State: AOJu0YxgW+vyL1TxFQOCbYVLpX2ydxVH4VhngYqXasD+ecQXhHlfKpSg
 8sMNoXpgY3+lQ3AkLkJ5JI1dvtJb2EeKN6e7aLEmxKy9yuuQ0WJKL7fKDbfFlDGtqbk=
X-Gm-Gg: ATEYQzxqzPesX+t+O1lIvXX9j9E9JaebtHFvdqC/1MRHAvzndn+H2nfcYwXJ9OxolzH
 5bvZC10duutqDixQeeB6fzUwjzdfuK0DC+/GqLo5yN6UnZBSfg986FrQl4Ys1yzHRvyww9SdJK9
 N2Vr21hAIe1R/V/ybJMMB7j8gkSOV5K55j+QT6rFfOlTt5Ox2gZ3yic6Qqu8AOkr/E1zEWxqwSz
 FHJTT7Js5eFifCfgS0omDKnoRZllvFBU5jCzSHNktQiyklP5oMMVGqXGO8mTvHchrjo16p5czeG
 KW16HgmWUUjP9X8sZVhJRXKgvXwlB6c88HXZNBq4TN2m+6B82BXJxCwYS7teANEanfL2ZE2X2QY
 71PzCMo5NmmSoZ9tiRBjik8DHYfU+dCkq1kA0OTMTHqpvKDHkko9qYYC5KL0XIZt0m+tdEJ2byx
 HI34FegFJ0qb/GtD+8BNgXUMBQOg4MirhJH6SOSWL8Rhp22dahqFGa5sbucgu2NULzvhJHdc4je
 v/NRR5q2IGgWej6ZmP5UCrOKBtQsgk1BHSKsXA=
X-Received: by 2002:a05:600c:4a17:b0:485:3b34:2f62 with SMTP id
 5b1f17b1804b1-486f44222d2mr51017495e9.14.1773859985208; 
 Wed, 18 Mar 2026 11:53:05 -0700 (PDT)
Received: from luis-IdeaPad-Flex-5-14ALC05.. ([148.69.202.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b0bc58sm16135905e9.3.2026.03.18.11.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:53:04 -0700 (PDT)
From: luisccc <luisccunha8@gmail.com>
To: qemu-devel@nongnu.org
Cc: luisccc <luisccunha8@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH 2/6] target/riscv: Add SPMP CSR configuration
Date: Wed, 18 Mar 2026 18:52:32 +0000
Message-ID: <20260318185238.99143-3-luisccunha8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318185238.99143-1-luisccunha8@gmail.com>
References: <20260318185238.99143-1-luisccunha8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=luisccunha8@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:17 -0400
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

Introduce the CSR definitions and handlers  to configure S-mode Physical Memory Protection (SPMP).
This patch adds the SPMP CSR bit definitions. The implementation allows software to configure SPMP state but does not yet enforce memory access checks.

Signed-off-by: Luis Cunha <luisccunha8@gmail.com>
---
 target/riscv/cpu_bits.h |  3 ++
 target/riscv/csr.c      | 73 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..9b7ab28bba 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1049,6 +1049,9 @@ typedef enum CTRType {
 #define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
+/* SPMP Values for Indirect CSR Access Extension */
+#define ISELECT_SPMP_BASE                  0x100
+
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
 #define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5064483917..167d84d92a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -759,6 +759,16 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
+static RISCVException spmp(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->spmp) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /* SPMP can only exist, if smode exists */
+    return smode(env, csrno);
+}
+
 static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->ext_smepmp) {
@@ -2454,6 +2464,12 @@ static bool xiselect_ctr_range(int csrno, target_ulong isel)
            csrno < CSR_MIREG;
 }
 
+static bool xiselect_spmp_range(target_ulong isel)
+{
+    return (ISELECT_SPMP_BASE <= isel &&
+            isel <= ISELECT_SPMP_BASE + MAX_RISCV_SPMPS);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2790,6 +2806,9 @@ static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
     return 0;
 }
 
+static int rmw_xireg_spmp(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask);
 /*
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2808,6 +2827,14 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
         ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
     } else if (xiselect_ctr_range(csrno, isel)) {
         ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
+    } else if (xiselect_spmp_range(isel)) {
+        /* Is SPMP enabled? */
+        ret = spmp(env, csrno);
+        if (ret != RISCV_EXCP_NONE) {
+            return ret;
+        }
+
+        ret = rmw_xireg_spmp(env, csrno, isel, val, new_val, wr_mask);
     } else {
         /*
          * As per the specification, access to unimplented region is undefined
@@ -5292,6 +5319,52 @@ static RISCVException write_pmpaddr(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static int rmw_xireg_spmp(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    int index = 0;
+    bool m_mode_access = false;
+
+    /* Read 0 and write ignore if no rules are delegated */
+    if (env->spmp_state.num_deleg_rules == 0) {
+        *val = 0;
+        return 0;
+    }
+
+    index = isel - ISELECT_SPMP_BASE;
+
+    switch (csrno) {
+    case CSR_MIREG:
+        /* If M mode, signal it */
+        m_mode_access = true;
+        [[fallthrough]];
+    case CSR_SIREG:
+        if (val) {
+            *val = spmpaddr_csr_read(env, index);
+        }
+
+        spmpaddr_csr_write(env, index, new_val & wr_mask, m_mode_access);
+        break;
+    case CSR_MIREG2:
+        /* If M mode, signal it */
+        m_mode_access = true;
+        [[fallthrough]];
+    case CSR_SIREG2:
+        index = isel - ISELECT_SPMP_BASE;
+        if (val) {
+            *val = spmpcfg_csr_read(env, index);
+        }
+
+        spmpcfg_csr_write(env, index, new_val & wr_mask, m_mode_access);
+        break;
+    default:
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return 0;
+}
+
 static RISCVException read_tselect(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
-- 
2.43.0


