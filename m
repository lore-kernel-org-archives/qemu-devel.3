Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71B0D10F3B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO6-00017h-Lq; Sun, 17 Nov 2024 20:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO3-00014b-GG
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:07 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNz-0006R6-Pg
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:07 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so2063510b3a.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892621; x=1732497421;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oSUPXuytVxHyXeI2aPjQi2EpXrEeGDlZSuBf96jPaMs=;
 b=vKGyv9zMPh6OQ9jxuXZkAIXhVGhwJxTCr+KtkooHHJnssq8xGCld/u8X/l/M8uKmAo
 kxZJYF1J7gKpYdsxYdiMojaljZHr9D0Y9i+SkH7SoIpyTQeXkJ11eOJ3lh/BBCtOersn
 3yw51PKtTji+Tf2G2egqBx3if0VPNT2l5SJLLPIgrL3cXxle+gbr5/8n3cIufIueh/Jn
 lxudD0pnp7z9j6g92RzTnOK+VtH9ZdUxPdHgxKzFKZm+YiHRSHfAm9GGEbaOIpKQM27k
 WcELi/cB6b75afRschTlwfZYHbkxhEE5z3ci4FQlyRnLuyPUs7XYMj5qmpfkGI/PMNxs
 OC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892621; x=1732497421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSUPXuytVxHyXeI2aPjQi2EpXrEeGDlZSuBf96jPaMs=;
 b=g/t8chrXvK2cCVK1pq8PkeCyJF7KOiz20fwoIC6O7/i0YOYFr5TBue8oQ2HZa478EX
 1IeHhPNscZaZIXsvVGu/aha5qgRCJIPDNj6fVYgxiyNGhr7aWELU9ISlRPJqe3VFda00
 fZTZ3ZNbnL8ILanDzPlJkI2fH3oHCF0uk+HRxuDrcvxv/BfLjGItjZ7d6yu5sC0SOUHO
 016rXW/tghrB16pWUeCIGERkTYnREDGtDB1u/z9xDMvtNx8Ca2cX/sp/8r6PORPOmFp4
 rU7ABulKlmz4ufutwbtf4lyreiUGLqY1pgtUpt1d8YeEs2aOeDjtBDSpLE7hHKmSlVc0
 9fXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Uo6Fh0bMeS3zS1RMy3DTc5PxGzi/ZtOMyyPtrFiDU4Pnr9Ss1N2tqiAYvU1G3zLDRAbEoavia8+A@nongnu.org
X-Gm-Message-State: AOJu0YyD0szwk1L2M/FWOM6iv7IIlfRgEnJ+LkwkfzKfx82i3Q8dqc4p
 dq77hGSnzcKR6Yq1itDB7WVMSAkBXUI57d5NOV4ItWr550Hd2G/cfQ0hL0JZuS72+un4Eqm4uj3
 p
X-Google-Smtp-Source: AGHT+IGOdGuvtbJGF7L5AEWhRBrQdxhQh6Qf195glY+Md6k8mkKbDKO94tr/0C2B3sVqpW/9G8cvQg==
X-Received: by 2002:a05:6a00:3d07:b0:71e:4dc5:259e with SMTP id
 d2e1a72fcca58-72476c4c22cmr14211486b3a.17.1731892620701; 
 Sun, 17 Nov 2024 17:17:00 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:16:59 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:55 -0800
Subject: [PATCH v3 07/11] target/riscv: Add select value range check for
 counter delegation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-7-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds checks in ops performed on xireg and xireg2-xireg6 so that the
counter delegation function will receive a valid xiselect value with the
proper extensions enabled.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 57e9c9e25f02..97cc8059ad37 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2158,6 +2158,11 @@ static bool xiselect_aia_range(target_ulong isel)
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
+static bool xiselect_cd_range(target_ulong isel)
+{
+    return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2283,6 +2288,17 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+static int rmw_xireg_cd(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    /* TODO: Implement the functionality later */
+    return RISCV_EXCP_NONE;
+}
+
 /*
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2294,7 +2310,25 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    return -EINVAL;
+    int ret = -EINVAL;
+    bool virt = csrno == CSR_VSIREG ? true : false;
+
+    if (xiselect_cd_range(isel)) {
+        ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        /*
+         * As per the specification, access to unimplented region is undefined
+         * but recommendation is to raise illegal instruction exception.
+         */
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
 }
 
 static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,

-- 
2.34.1


