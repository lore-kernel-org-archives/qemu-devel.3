Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF4CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjhO-0004Nv-KZ; Tue, 12 May 2026 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjhC-0004Mq-Kv
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjhB-00010V-4b
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso4203594b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778579192; x=1779183992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ie/CRX9HgxQJIe7EyQji6JVrxvq1hEXjzqYVVL6RmW8=;
 b=UMyugTcTFzpVGiGvpAdvx4ri21gSyahhPwJ/mR4EznoPReXjY6QxRHlzz+XweLIEtG
 EjF/8+N1n4aB4kaGC8nEF7CrOxDYm6ft0RKvbLiTUr85Xe6WrFUPZyYem6xWhw72Zm5Z
 1M1rr6Gjo2tmvJ/ei4GWWqDOoOucRwT9UVj0/LdjN6gbzdvj16HIcr9bLRjoLrrVzwDD
 +eYuPwcAmsBZQ+BI42O/zspcf+43OlE7Q4FuHcSVLqmV0+dcoql5Hz3B4X3wbsjQJ+Kt
 Z1BgO1UZJC9Ttmuvtl6sd9rscX8q5ucAY09a4/ZwTdAU11FY+ES3JiCHwjs8w6giA7AZ
 ziug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778579192; x=1779183992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ie/CRX9HgxQJIe7EyQji6JVrxvq1hEXjzqYVVL6RmW8=;
 b=Dd9p9UWpgyvogwd4O2/x+UnFFs6iaa9fwKJ/lsj86iv7kZCxZSn38350dVDN1d7fm9
 moYBcA1NzIkTBXGhwsm02Wil0x4exMV8jg9LEJQe52soJTBLLnbjUceE66lqbotPydGD
 rvdZxDS3ATpIK5Jh78mX+0/gFvRIfNZnDuIjbYzBrbJPqAZvckN/ABSFhhojBkciSTE9
 GqyGaxfSda1DU1BJ/+HGlPPAVjEeCXgRDN5dVjLYFGUsbFu5g+xfhfyx0UvadVQxJycj
 638QPzUeDZgVHhS1KeRRqSRZDwlIbJDxdgUS43eZjxFi50upzxbiaMe4ZpUein02Pn3w
 Yfbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZXcbTbg6vyNOK37meGdxjUWkEwxf21L1J5Yu9vgp45CHh56bHlPmfInH8R7vYJSGCfJdxrF/BZ46J@nongnu.org
X-Gm-Message-State: AOJu0YxWXYU3DFL/QSoqppTV65fNZ+kqmxJbgmSHKUIQrogFpKs1mege
 vlCzHB/RaLnoFzMOG9gX5i0/TYoLCtb6f28uhs1p7/dSaL1PQ3DdkiEG
X-Gm-Gg: Acq92OFPf75ckn5M0qID2iQXuoiGXrcEBFptg5uRmqdWeWelCAI8kcLZxPxfUHwo/SO
 SQb/SKm/kntfaodhzP1+dBHpPdB0tDwS4XHjmEsKB0Tpvcsph/2pEQAfhbUUpgWwwtPENH1ePNu
 3WDbQgkynqGL3wd/vYM4hRWau406IMYAnGngkQ+lleN+Z3H6rp2NTlw16KnPgEmKzn9PKm7sOOT
 Gyz2qSeUBRJ7it+4l/mz5AGTMYQrqSD8E2xFXR6QW8cq2dn6wDlW96x3vSVlH+ZKoDX77o4xQZ+
 7+vDo8lHuDU5RQaNvLMbmK1nxDSY1oiFJ2knZJwS4MwydViLvyezJp1M+aozCnB8LvyNF+ANvHj
 jbMCfFNcQ7tQ7PoCfwqp4cQX0AdvBwxZfavJWrP3BmXWk+1t8QkBHYpe7OgtyDaFWT0VUgmZlC1
 yO2ITU+mJFm2AEYmN5UV5Znd7vim0zQH7Du07GMbtj8p7XMsp0aRgjVd8lbCmI+r9z1jifXDOCQ
 6Q7B9uFQXBCKvbQ6/k7pS05/OAIrZTSsg==
X-Received: by 2002:a05:6a00:bb8d:b0:82c:6683:b866 with SMTP id
 d2e1a72fcca58-83e39150f30mr13472303b3a.4.1778579191725; 
 Tue, 12 May 2026 02:46:31 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682aba01sm22960593b3a.55.2026.05.12.02.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:46:31 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH RFC 1/5] target/riscv: Add stubs for T-Head PMU CSRs
Date: Tue, 12 May 2026 09:46:09 +0000
Message-ID: <20260512094614.3464388-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260512094614.3464388-1-visitorckw@gmail.com>
References: <20260512094614.3464388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

T-Head CPUs use custom CSRs for performance monitoring, specifically
mcounterinten (0x7ca) and mcounterof (0x7cb).

Since we don't implement these custom PMU registers yet, the system
crashes with an illegal instruction trap when OpenSBI like this:

system_opcode_insn: Failed to access CSR 0x7ca from M-mode
sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -1)

Add simple read/write stubs for these two CSRs. By silently ignoring
writes and returning 0 on reads, we prevent the fatal exceptions and
allow to continue normally.

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


