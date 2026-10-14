Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50843CC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqK-0004wr-NP; Tue, 13 Oct 2026 23:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq3-0004qM-DY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:40 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq0-0001KV-AE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3a813079a55so3233130a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949164; x=1792553964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sfx1HIlYACatyDIWreyR3Kawd11D1y/HMQNShWOnHhU=;
 b=LCkGGWdNRS6kQ8dmUivk30ztr4FaeYJT8sB6S+pLJRnVQslfoa6LYite5bpsKgLxWC
 qhxhQUTQ5p05DbrEgoy93Lp6pS3lnAQO/+ONwCVakPvWWLpMb1sWDRvZCkfbRxj6knyE
 gTUDCC3OqV5bcuNYrBui4/zTdxiHgoHqfR1EqrjubUJNHHYBkyE8VRTLl1Wr2ytD3UL8
 N+W6X+x9FPnlyg/yL3XNj0E8IP2Fm5xaVvcw86CaNw+uXfeNfH9bfvD0IQ8LHOQKqsIr
 HW5tRrX7rdDSbDoMwfmvLFo6DabxHBemZhv4BSy8JsZ1bEAVYAwz5hPUj43JlrEafL+D
 PIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949164; x=1792553964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sfx1HIlYACatyDIWreyR3Kawd11D1y/HMQNShWOnHhU=;
 b=VUHq+6Rwl+3AULW/oIsZlh/HemMFutRS8KHs29bpSQzdd0qY9PWkQux9hU+l1eXzNN
 SvWElpxlelFTfxsUbDY+e079P8DOW1JOqB90xYqlgzevA7/ymsVxfFa9hJYEycE6Km+6
 CRF741uleXDnAM0R4IddZ1e7ll8uVnh6z/ghy1GzY9xwEwLm3MthkJixyqFrxF1AmowF
 oTL+Heud8lZnzppTiqVtgC1sYv+0zmlcsx6wLUFaYMibS8llprMdw/BJeCLdmm2Y0LBB
 FnuN3cfsIYHUDVAutLGHcckd+l6s9ZIdA6fedYAlMYWOcSOt6/DSfPVxheey6qDo7B4b
 ZugQ==
X-Gm-Message-State: AFq9FYKq2mlXZ00yCMeLOGSzAYlGPGN+0z9o9OS2/04AdWkKCRLIpqv2
 GRS8nhQrceVzlEYi1rBxqi9pEIWnXsVLCZVliJRECqagSPtwGnjS1lHX6NSc2Q==
X-Gm-Gg: AYBFou1ZVfKHD+dt5dt0TuFv7MvNdBOPmmnKjJvGe9YAq7qv40BJnvvWbwPZsrQrt5A
 WwVIjOsW0gXu+luI7XIT3pqj3DDFQkmKNct25n893plxvcCOnl0HmTEjvWvShWU3NNvSrM39Qbv
 Gr24vHy6hTmpRipeFz0K2fOh34HFl6ZGB1iR91seYTeB8QUhIXsybGSenznCRDULVPlel4cvCic
 aOSko+zHYekj90BZw+9OMIb2S+vGuvo36Tq9f194IGQiC5LBDXReGxqiuwlYv+df2Y2P1d77jv1
 PBTWXRZlktsCJ1VsFwr8RMbvdXLNqPXjTZGRNVm+1WsFZURwEiLsqMwIVvb8lSOlsY4QDCnwTsh
 /OvVauG/PMHxbiFIC10cRWikfuFo678m8bptJmhiokrLXfuNzTTigS5IKWy57eocOlBN7fhsozk
 /xZ9ZbyX9oQ42p7YeHvqUsATGavO0qUCCU04Hfr2rfPzkuLqYUToWdooUVxVHm03P9ry3exAEyo
 /TkRxdPf3VOkLVP
X-Received: by 2002:a17:90b:4b82:b0:3ab:a09c:f858 with SMTP id
 98e67ed59e1d1-3aba09d4a0cmr5831337a91.33.1791949163804; 
 Tue, 13 Oct 2026 20:39:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: imaginos <imaginos32@gmail.com>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/52] target/riscv: check G-stage write permission for
 VS-stage A/D updates
Date: Wed, 14 Oct 2026 13:38:16 +1000
Message-ID: <20261014033907.3332383-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: imaginos <imaginos32@gmail.com>

During a two-stage (VS-stage + G-stage) page-table walk with hardware
A/D updating enabled (Svadu / menvcfg.ADUE), a store that reaches a
VS-stage leaf PTE whose accessed or dirty bit is clear triggers a
hardware write-back of those bits into the PTE. That write-back is an
implicit store to the PTE's guest-physical address, so it must be
permitted by G-stage.

Fix this by re-running the G-stage translation of the guest PTE's
address with store semantics. get_physical_address() then also checks
that G-stage permits the guest PTE to be written, and raises a
guest-page store fault when it does not.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3426
Signed-off-by: imaginos <imaginos32@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705140508.17692-1-imaginos32@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/cpu_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..6115f65adb 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1133,6 +1133,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    hwaddr pte_gpa = 0;
     const hwaddr base_root = base;
     const bool be = mo_endian_env(env) == MO_BE;
     int i;
@@ -1170,6 +1171,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             }
 
             pte_addr = vbase + idx * ptesize;
+            pte_gpa = base + idx * ptesize;
         } else {
             pte_addr = base + idx * ptesize;
         }
@@ -1424,6 +1426,28 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
+        /*
+         * The implicit store that writes updated A/D bits back to a VS-stage
+         * (first-stage) PTE must itself be permitted by G-stage. Re-run the
+         * second-stage translation of the PTE's guest-physical address with
+         * store semantics. If G-stage denies write, raise G-stage store fault
+         * against the PTE address.
+         */
+        if (two_stage && first_stage) {
+            int gpa_prot;
+            hwaddr gpa_paddr;
+            int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
+                                               pte_gpa, NULL, MMU_DATA_STORE,
+                                               MMUIdx_U, false, true,
+                                               is_debug, false);
+            if (gpa_ret != TRANSLATE_SUCCESS) {
+                if (fault_pte_addr) {
+                    *fault_pte_addr = pte_gpa >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
+            }
+        }
+
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                            sxlen_bytes, MMU_DATA_STORE, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
@@ -2114,6 +2138,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                  * doing VS-stage page table walk.
                  */
                 tinst = (riscv_cpu_xlen(env) == 32) ? 0x00002000 : 0x00003000;
+
+                if (cause == RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT) {
+                    tinst |= 0x20;
+                }
             } else {
                 /*
                  * The "Addr. Offset" field in transformed instruction is
-- 
2.55.0


