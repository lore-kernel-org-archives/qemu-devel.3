Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1F4CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 01:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNKgB-0006qi-BI; Wed, 13 May 2026 21:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKg8-0006qR-Lu
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:15:56 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKg4-0000qf-Jj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:15:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bc7b311e77so20544825ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 18:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778721350; x=1779326150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mxwCx4OeOMWpI5sBVWTxhTZlDA7w225FBpZAcqrcYk=;
 b=A9yXhtqrYBDxr8267D5tdIiA8OM/cKDXNbnUMh8IB7GrVEHcau5P5m0USR/uTE3F7w
 Ao304IHBHlK77gXtgxPK0FBY51/zJ8z3oyis5JQ1Xw0WtFIADjWtw79DaNlqdwUwHH+3
 F24WVb698aybmaGjz/ODt/mzU2EuVaNvUJ0fXFtgYvVGux4gyB/j0wu6TSslOEXj0MRF
 zoQEtXXrhJC7frh+YEWyNCov14rnDZsM+ymTUrzwVBq08bu6unRVwYVFXh1riyOTEcDu
 5STU/vwzpS74e6PPHwXwEDxRhylBsP+ajp3cJoJWp0TGpbYcVq+0oPJ+A9NNDC/Nr5VC
 HFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778721350; x=1779326150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0mxwCx4OeOMWpI5sBVWTxhTZlDA7w225FBpZAcqrcYk=;
 b=hFl+t3xiVXB5LoVSVOQgwtcVycyfNXlzW9gr0ZtbWHuiYz6HCc1uItY4WRZcGO86+N
 dGSDXvWXXnuXgKplifFi7+oy90F4Nvf/Ra5k/mwRswCrYeYGA9j1HdqXmQxj2zSvLHKB
 2PPxSkvBBSUDkB/49vTM2JDwJRF3SuQwx4c9U6X00/be4zwpp2eBa87LEpmLv/SPk7xU
 iYheQxfl4qm21FRK+a4dnvertrU53+o/E2g4XFU/km2J7PH6/vrR2AjMvF1WA7h5KOTo
 3zn2Z0dJAqe9jjIYOTDcXnWURyknj4pu5keNQp/uJ3a2DY6YzqJhybwT1X7TsthZnqKK
 3PMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v0IQq2kjW7AxJiCJ4JEvC5ytJFcVwLYNnhk8TpXNMFH9k/MTP6pKWaN/b1WY+3EsdngNedK7vimyP@nongnu.org
X-Gm-Message-State: AOJu0YyqInCE00gzasPzocc+/3+aEdeTWpx9mcSdBKKtqeaExdQuX85U
 Fr1r2wCeyxaaDNLYwUpU7oajIzgSnm60SpCKcFAp52Cpc80cVqve+KZk
X-Gm-Gg: Acq92OG53wxC7EYzHd9R/x+1Rqdsc3ju4eYchotsJX4cV5o6QXgD+Dc5pKTczJaysIS
 cQysOweut4TCgtVbHJ8p8PZuvE689Oywc5tjNkrk30Dv3ybXCaEtvuyPAoo9wBOmaBtRsnZ4uK+
 3jAXrNZiNf3c+nhDRJrGMJUXzl5qpUSmm/9s6rf7NjiB+AQWIBy2WtJOwsphcyeY10DdMCoNaiC
 YPPuSmNVwFarWuhXYpWLG+Le2k/sJzTGn5qKYzxm8OtrXIzKlbbCGOacn4XFBAELY3cu1TAAP5N
 /cY4EVTkE+Qp1Vi1vFT4Zz6oMH3tL4D3IuZlrYSw/hPfhUK7BRLdDtB232pbU0wL0fgiBFNZwOo
 kZObo5ojjAOI4iSHrYAnQRBtGMDawBAyXNRxk8H5hzGa38L4bJ+NdXZ8f/u4ejJw/HH9d2XjXw7
 ukO1sVA158zqdQQNJ/ttQ7ctXkNWepMIdIH3rSlK8ts+DaJBTcl8Qfj6MetS61Jm0ZXMLJY9v6V
 iHwSEFm7V5wvpGMXVRZb5QlTNH+Eh+aVflt3uVR5S3r
X-Received: by 2002:a17:903:3d49:b0:2ba:5f24:caeb with SMTP id
 d9443c01a7336-2bd5277b9d8mr9591255ad.19.1778721349469; 
 Wed, 13 May 2026 18:15:49 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600c3sm4982575ad.29.2026.05.13.18.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 18:15:49 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/6] target/riscv: Add stubs for T-Head PMU CSRs
Date: Thu, 14 May 2026 01:15:23 +0000
Message-ID: <20260514011528.1263665-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260514011528.1263665-1-visitorckw@gmail.com>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

T-Head CPUs use custom CSRs for performance monitoring, specifically
mcounterinten (0x7ca) and mcounterof (0x7cb). [1]

Since we don't implement these custom PMU registers yet, the system
crashes with an illegal instruction trap when OpenSBI like this:

system_opcode_insn: Failed to access CSR 0x7ca from M-mode
sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -1)

Add simple read/write stubs for these two CSRs. By silently ignoring
writes and returning 0 on reads, we prevent the fatal exceptions and
allow to continue normally.

Link: https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource/XuanTie-OpenC906-UserManual.pdf [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 target/riscv/th_csr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 49eb7bbab5..b095364c31 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -21,12 +21,19 @@
 #include "cpu_vendorid.h"
 
 #define CSR_TH_SXSTATUS 0x5c0
+#define CSR_TH_MCOUNTERINTEN 0x7ca
+#define CSR_TH_MCOUNTEROF    0x7cb
 
 /* TH_SXSTATUS bits */
 #define TH_SXSTATUS_UCME        BIT(16)
 #define TH_SXSTATUS_MAEE        BIT(21)
 #define TH_SXSTATUS_THEADISAEE  BIT(22)
 
+static RISCVException mmode(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -49,11 +56,34 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_th_pmu(CPURISCVState *env, int csrno,
+                                  target_ulong *val)
+{
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_th_pmu(CPURISCVState *env, int csrno,
+                                   target_ulong val, uintptr_t retaddr)
+{
+    return RISCV_EXCP_NONE;
+}
+
 const RISCVCSR th_csr_list[] = {
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     },
+    {
+        .csrno = CSR_TH_MCOUNTERINTEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterinten", mmode, read_th_pmu, write_th_pmu }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTEROF,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterof", mmode, read_th_pmu, write_th_pmu }
+    },
     { }
 };
-- 
2.54.0.563.g4f69b47b94-goog


