Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE6C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK14-0005bA-0B; Tue, 06 Aug 2024 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0l-0004Lj-Gp; Tue, 06 Aug 2024 09:14:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0i-0003XD-Nb; Tue, 06 Aug 2024 09:13:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so46087765ad.1; 
 Tue, 06 Aug 2024 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950034; x=1723554834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYtQ+iWLl5Zd5RwOL72P9POMBpC2vDPbojh7D+T2lE0=;
 b=SeKMSWmzG2LpTGWFRaAV83QZrq6upBXg90Yi9Cn0W3zykX40J9XgP3mOKEcFbGVCFg
 vIvRCNkvSIk0yaa5LP9dS0qqAsRS4w69GWghqv+FC6TPkSzXReKJKFqCW+z+bDOuDssq
 qENoFvpFFyVwf51e34uw4A7M+l9ErTRGj7QnLgFeuOM2n8BCW83GTUQlwUN4sqkB2MuU
 bafdOi/WJlwgs4bDVxoxY6lfaJTFMiSEoHe/sG6fQl9h1cHCVMyP1uJpr0w2RvPo49SU
 yo7+IatZnWcKnA4Pa05o1CB43vJHRdzOW8t7lAf5oswTzPbMIiGEOKXj9yR9TcqQlGUz
 kKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950034; x=1723554834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYtQ+iWLl5Zd5RwOL72P9POMBpC2vDPbojh7D+T2lE0=;
 b=wJaBRs1qTggphz/xKhsdW+vtX+lxtFr9+rkCc3IGdb4ifP6IneggwIntv1tiAFyAH9
 fsMEU4raLu5lJKZqKP8cpGnUcyYGnz3J+sjyqk5SabXZIAYajTNFIcHN4VwZctuzYOkk
 w8QDBSpjABaZACHcf4JakFK+aCkJM30HRSovIqwV96gr5zTPG5EX0XwAb4NY7amORvZA
 3ihpwuNDtoJZbHq4AfDD09neEinbwW5aJkfsFZj0GCRoE5f480poVlSAKVuPdB1ol9uR
 bgtbKsOroJKOXObn8gFzI+Vrw7Y+yJwZjq9C/9cTVIyneXPdw/OkoYtq7gcuhfixWVRn
 mkgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGlqFV4g/z7s57M5OsCe/DgghI4vQtNjxtQWUGAQxMkvJd7QfpW6rmerCyaY7YsxqpdWMz+ZKlqlnWnV/0b3Th9nmcXXU=
X-Gm-Message-State: AOJu0YxRgDXHJs1wEt0PpHv+m8aZuass86QPHxRO5XKgZ3CxN45Kyqof
 Wuz2Ebh+9+E9CwlqIyPsz3KCdQndnZSaPmQvrvSMiQjEwxdEDzdd0cuMl3mp
X-Google-Smtp-Source: AGHT+IFXwEEbAbqNJy2gwj2saeY3w8iWaRaOmOAMT8/USpcib0DdzlQ5uKTM26+6H/t+BlxSvijbRw==
X-Received: by 2002:a17:903:1209:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-1ff57f062b9mr270064675ad.28.1722950033738; 
 Tue, 06 Aug 2024 06:13:53 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/ppc: Fix VRMA to not check virtual page class key
 protection
Date: Tue,  6 Aug 2024 23:13:17 +1000
Message-ID: <20240806131318.275109-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

Hash virtual real mode addressing is defined by the architecture
to not perform virtual page class key protection checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5e1983e334..c8c2f8910a 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -993,6 +993,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     int exec_prot, pp_prot, amr_prot, prot;
     int need_prot;
     hwaddr raddr;
+    bool vrma = false;
 
     /*
      * Note on LPCR usage: 970 uses HID4, but our special variant of
@@ -1022,6 +1023,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             }
         } else if (ppc_hash64_use_vrma(env)) {
             /* Emulated VRMA mode */
+            vrma = true;
             slb = &vrma_slbe;
             if (build_vrma_slbe(cpu, slb) != 0) {
                 /* Invalid VRMA setup, machine check */
@@ -1136,7 +1138,12 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     exec_prot = ppc_hash64_pte_noexec_guard(cpu, pte);
     pp_prot = ppc_hash64_pte_prot(mmu_idx, slb, pte);
-    amr_prot = ppc_hash64_amr_prot(cpu, pte);
+    if (vrma) {
+        /* VRMA does not check keys */
+        amr_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    } else {
+        amr_prot = ppc_hash64_amr_prot(cpu, pte);
+    }
     prot = exec_prot & pp_prot & amr_prot;
 
     need_prot = check_prot_access_type(PAGE_RWX, access_type);
-- 
2.45.2


