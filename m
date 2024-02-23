Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9D6C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuU-0004yp-1G; Fri, 23 Feb 2024 10:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkN-0007TI-J4; Fri, 23 Feb 2024 10:46:00 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkK-0006hM-Sy; Fri, 23 Feb 2024 10:45:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so8688225ad.1; 
 Fri, 23 Feb 2024 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703152; x=1709307952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZdatq3vYOtwDhs+2bqO9//78PD1EpkdiB+KCSZTTMM=;
 b=SkCzFTx9QAKi8Qq7NP7hrAsfe7CAy4LowqNdwbswY/Q8pqKswXo9CBkFmUlcV3sAgs
 95VDNGk4bpKYfglRwk30n2yZZP0aFgHsbjkMIQSWZ2jtwoIIDhwmVP+wnEnPVq+20DVQ
 Oux/FB9/kML6ZMldXOrolKBDBoQxLQO+iC/La9roT2x4TA5Lv1d3T4d0ECkN0nnJnGTR
 gNsWUylXg54BZycmqzy02iWZ28SEFw9Gjz9mkjWyMM4wcIFDa9oPxV5mQtKz36ow+JAM
 H7MQuv1Gugw/BmnptcD5a8ErkXwqTm/dbs2tSdaJ6gFhiFGdQTDyQ5vC/mDDsoj1NelL
 OW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703152; x=1709307952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZdatq3vYOtwDhs+2bqO9//78PD1EpkdiB+KCSZTTMM=;
 b=wx/bQNo8L8CQh7ko/NwshLzfLBVJqk59r3TZTwSqolRwujRF3bQabseCsVKhUoBa0f
 aoxPLdpsHI0se4/Vc8nlNfXLdxvLdR3P87eR72bfC46EkWKCtY5Sksjam9oGXNXz+6Wh
 Vdn4wvk9zvpcfsDNQEx9uLvHDf0Gob1YVqSFTQv6fviSIV1QP6HjMujieyzffVKsl1sD
 g/SHsAg17iH3Hztbzl13KhCB6MPJXDQBPocePXf3hY14TDV4WSSC97SBpK0vzvaGaPxl
 wia4pZnpU8QmlbGTakEVnWc+SfikFOuePVDD3qLO0a1ZHfeI9SsLyMaxr83wcu6jeNZl
 gZAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVFnY8ZgjcCnry3oa2y8wLtFrCokBz1egQCWxQHRXrjVRPIIMci9rlbAmQFBNIzogpVLiUR4JSDiwEwjHWGlnE+j1D
X-Gm-Message-State: AOJu0YzfLGy2YfFeR/WbCfENfab2YC/NoNfBCbil5Bbe2QvAaSd+12az
 mF7IuPkz8vb9QplYChwcy5ZnTNgWOjWu1G6aHqwm+c/AAQD9Joq9nJN8gLpR
X-Google-Smtp-Source: AGHT+IHvj8aczwj9U/oL7uK2Ja5QVpepaKCFWHqr+rvUa1EyNyI90MdDQzyDtFvgS/jz5Z3feEl9qw==
X-Received: by 2002:a17:902:f7c1:b0:1dc:6071:60ad with SMTP id
 h1-20020a170902f7c100b001dc607160admr124459plw.24.1708703152013; 
 Fri, 23 Feb 2024 07:45:52 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 42/47] target/ppc: Fix 440 tlbwe TLB invalidation gaps
Date: Sat, 24 Feb 2024 01:42:01 +1000
Message-ID: <20240223154211.1001692-43-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The 440 tlbwe (write entry) instruction misses several cases that must
flush the TCG TLB:

- If the new size is smaller than the existing size, the EA no longer
  covered should be flushed. This looks like an inverted inequality
  test.
- If the TLB PID changes.
- If the TLB attr bit 0 (translation address space) changes.
- If low prot (access control) bits change.

Fix this by removing tricks to avoid TLB flushes, and just invalidate
the TLB if any valid entry is being changed, similarly to 4xx.
Optimisations will be introduced in subsequent changes.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index f87d35379a..c140f3c96d 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -855,49 +855,34 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
                       target_ulong value)
 {
     ppcemb_tlb_t *tlb;
-    target_ulong EPN, RPN, size;
-    int do_flush_tlbs;
 
     qemu_log_mask(CPU_LOG_MMU, "%s word %d entry %d value " TARGET_FMT_lx "\n",
                   __func__, word, (int)entry, value);
-    do_flush_tlbs = 0;
     entry &= 0x3F;
     tlb = &env->tlb.tlbe[entry];
+
+    /* Invalidate previous TLB (if it's valid) */
+    if (tlb->prot & PAGE_VALID) {
+        tlb_flush(env_cpu(env));
+    }
+
     switch (word) {
     default:
         /* Just here to please gcc */
     case 0:
-        EPN = value & 0xFFFFFC00;
-        if ((tlb->prot & PAGE_VALID) && EPN != tlb->EPN) {
-            do_flush_tlbs = 1;
-        }
-        tlb->EPN = EPN;
-        size = booke_tlb_to_page_size((value >> 4) & 0xF);
-        if ((tlb->prot & PAGE_VALID) && tlb->size < size) {
-            do_flush_tlbs = 1;
-        }
-        tlb->size = size;
+        tlb->EPN = value & 0xFFFFFC00;
+        tlb->size = booke_tlb_to_page_size((value >> 4) & 0xF);
         tlb->attr &= ~0x1;
         tlb->attr |= (value >> 8) & 1;
         if (value & 0x200) {
             tlb->prot |= PAGE_VALID;
         } else {
-            if (tlb->prot & PAGE_VALID) {
-                tlb->prot &= ~PAGE_VALID;
-                do_flush_tlbs = 1;
-            }
+            tlb->prot &= ~PAGE_VALID;
         }
         tlb->PID = env->spr[SPR_440_MMUCR] & 0x000000FF;
-        if (do_flush_tlbs) {
-            tlb_flush(env_cpu(env));
-        }
         break;
     case 1:
-        RPN = value & 0xFFFFFC0F;
-        if ((tlb->prot & PAGE_VALID) && tlb->RPN != RPN) {
-            tlb_flush(env_cpu(env));
-        }
-        tlb->RPN = RPN;
+        tlb->RPN = value & 0xFFFFFC0F;
         break;
     case 2:
         tlb->attr = (tlb->attr & 0x1) | (value & 0x0000FF00);
-- 
2.42.0


