Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C719C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYD-0007Ry-4I; Thu, 23 May 2024 19:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXu-0007I0-Mt; Thu, 23 May 2024 19:08:27 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXs-0005h7-UW; Thu, 23 May 2024 19:08:26 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2bd816ecaf5so2392775a91.2; 
 Thu, 23 May 2024 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505703; x=1717110503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nV6w1AjQDLWDB3Npch3KGBEPSiv+4sXlghjNuPVyMEM=;
 b=bjhin0lYhhaKn78bb+lqf57T8BNYMPIMDBqGbTVcqxlr6doE+oYYKAjIXRezp+JvbN
 w4HNwaMrboJoDVIZUO4VNJWgQ48SRYALqPCUzKxDDTehBGkG0I7GqIlF/hAynoiXWzjB
 1eegN1idd8kjVej4XO2S30QSJGm816lxgChk14kdby4aOyzLoUi0NliEXOXoq2Ale2dx
 Z9gHVCCcwWxe5OwGg86UvYr4sgARDzd519bMysPyYQanDNAmJ3Otr7iCkm+zlSmNiN9v
 obJZBql2D44P5F8I6etD7zes8upQnbqP54ZVa2kunfnFBearxzKKRdEAUHuAMJEIkXtI
 dTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505703; x=1717110503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nV6w1AjQDLWDB3Npch3KGBEPSiv+4sXlghjNuPVyMEM=;
 b=dxiQPx/FVd62ALAHxhEU7Nv9xtIq2AfPhqV1g1/a12utHWu5QIKzjxfTpxMi1Xyb9q
 V/kL/Cf26yx/si6r7I/Vb8Vs+rfkxHCROgPenxUfcYBDDmMix+vLFSAvPSGmLFUWjXio
 aKTSCFELot8r+oyxslcUH9Rh0Zbj6y/MUsdDgKOV27dEoHZWzd0i01J+WeWstUwzTgio
 dStCGOyjSN8rYz2oNHr+hPRrKYkyKlprD+dfp3pw0030mxEbf4E2ANFLcg8L6DB41Uyw
 p1Tm/DZGBKi9k5DO8nDzYNSM+UDPPNXdKV7izKzS+VPom+n64Rxj4bRzA/b3mk8mf+LE
 W2jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXls2BJ77URuEMDj71/2dhfJkKejsMXFRZ20R5+E1iqvi1PEjkvbSZ4tUmIYswOpX3XMBSMfVi9oLM4M9zij87pbhfe
X-Gm-Message-State: AOJu0Yyy91YalgwWY7JNh/qg4PPkYFI/blvGVK14JTNrIJusDpnCzxnX
 xvwBtrAcTiJFLN1pw5M3wZTB/mwX4jms246zYh4ca1eUSFLZee2jpT32EA==
X-Google-Smtp-Source: AGHT+IFo3ln8e9W/4R6ElV65NgjAEj7rFathR3JjZtSEmcbPI5h874VnNAz7cYvZDVREzgpJfcV7TQ==
X-Received: by 2002:a17:90b:1093:b0:2bd:8aed:740a with SMTP id
 98e67ed59e1d1-2bf5e569480mr615167a91.23.1716505702735; 
 Thu, 23 May 2024 16:08:22 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 08/72] target/ppc: Add ISA v3.1 variants of sync instruction
Date: Fri, 24 May 2024 09:06:41 +1000
Message-ID: <20240523230747.45703-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
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

POWER10 adds a new field to sync for store-store syncs, and some
new variants of the existing syncs that include persistent memory.

Implement the store-store syncs and plwsync/phwsync.

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode             |  6 ++--
 target/ppc/translate/misc-impl.c.inc | 41 ++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 6b89804b15..a180380750 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1001,7 +1001,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 
 # Memory Barrier Instructions
 
-&X_sync         l
-@X_sync         ...... ... l:2 ..... ..... .......... .           &X_sync
-SYNC            011111 --- ..  ----- ----- 1001010110 -           @X_sync
+&X_sync         l sc
+@X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
+SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index 7574317600..c1661d2f43 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -25,6 +25,7 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
 {
     TCGBar bar = TCG_MO_ALL;
     uint32_t l = a->l;
+    uint32_t sc = a->sc;
 
     /*
      * BookE uses the msync mnemonic. This means hwsync, except in the
@@ -41,20 +42,36 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
         return false;
     }
 
-    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
-        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
-    }
-
     /*
-     * We may need to check for a pending TLB flush.
-     *
-     * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
-     *
-     * Additionally, this can only happen in kernel mode however so
-     * check MSR_PR as well.
+     * In ISA v3.1, the L field grew one bit. Mask that out to ignore it in
+     * older processors. It also added the SC field, zero this to ignore
+     * it too.
      */
-    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
-        gen_check_tlb_flush(ctx, true);
+    if (!(ctx->insns_flags2 & PPC2_ISA310)) {
+        l &= 0x3;
+        sc = 0;
+    }
+
+    if (sc) {
+        /* Store syncs [stsync, stcisync, stncisync]. These ignore L. */
+        bar = TCG_MO_ST_ST;
+    } else {
+        if (((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) || (l == 5)) {
+            /* lwsync, or plwsync on POWER10 and later */
+            bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
+        }
+
+        /*
+         * We may need to check for a pending TLB flush.
+         *
+         * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
+         *
+         * Additionally, this can only happen in kernel mode however so
+         * check MSR_PR as well.
+         */
+        if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
+            gen_check_tlb_flush(ctx, true);
+        }
     }
 
     tcg_gen_mb(bar | TCG_BAR_SC);
-- 
2.43.0


