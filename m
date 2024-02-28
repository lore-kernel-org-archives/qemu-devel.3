Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5F8C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyO-0001al-2B; Wed, 28 Feb 2024 03:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyL-0001Ww-Hw
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyI-0000XY-Pf
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKjZSqacAB8iZPfTH6FwKVpy3pBbPqdXPJfiOVIqgCQ=;
 b=PqCXt/kIOlb3X70YQvID9eaFrV4L9o2s61gnLJRHWkS2nnt1EdXZ3Lu7gdRxG57SjEO8Te
 F2ZmKQFoQvL2uk8emh1prLR7bJhFJwgyBVsI0+gmmrbnT5sTAgAFn2Z+RCsfADlUO6mKpk
 x/qeJmu9RoT37nZi7x8yaVscQScWUDs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lQNm9PrsMhmg_VZDa48ynA-1; Wed, 28 Feb 2024 03:07:20 -0500
X-MC-Unique: lQNm9PrsMhmg_VZDa48ynA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a43381a778aso220394366b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107638; x=1709712438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKjZSqacAB8iZPfTH6FwKVpy3pBbPqdXPJfiOVIqgCQ=;
 b=wvLSPn0f6nrg6qK6MoPsQigvUKo14yxKMQiUuZmc/RbqOUpcGl+VHMEzr5Yq5t7utK
 0TPEWRfun9249zdeeAWyiWykZPUbM+IUsv4LCk/7qmegpQ2BVHLRbbIXfmV7Yitc1XUg
 N9chn1SMmKhxhrG00N4fU32v4DR0j1ShMEQ/gt+ZG4yOXT391XCBwEBq7RYz06nKuvPw
 rKJj75m/8gSlWWmNST1NjmWbi7QaZMy2FgfzEq5fl6HGlmDxQX/s6og5zalu8V0Qx+YN
 69iqolKyLTKyZZJUjoSH4S7cB6fCJV7yfx2Ah6B0z1/f2Fadn2owh1vavLg53Him3ahG
 0U6Q==
X-Gm-Message-State: AOJu0YxqcKYfU1d6XGo1vwtlNmnVEsdRSwd16GCy/eHcSDagVu+ooLHh
 TXyMpaUXaA7Xk4ZNrxNecAEhpRWI2n/d+bAjuG2ylJL+XGN3+HexnG9bVWeNNuO8Ra6SZr9gCEa
 sh3+sZ4EMs9v4QFDnOMlSWXsCjgL+6k/K1c8gEDT0AB/Jq33ViwwzLmOI5Jby4PUV+cJc/PUC8c
 Bz/1s9XHykrgBgfzrCMGTcaeenmiywymLCt7Ui
X-Received: by 2002:a17:906:34cb:b0:a40:2999:5404 with SMTP id
 h11-20020a17090634cb00b00a4029995404mr8079342ejb.3.1709107638799; 
 Wed, 28 Feb 2024 00:07:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+S1OTiMphVSICCeIQoGoLFQE7Tny4p7dR4wGy/rDpbOBajLEH2WSBA7xIbriRLzGQYxAGrg==
X-Received: by 2002:a17:906:34cb:b0:a40:2999:5404 with SMTP id
 h11-20020a17090634cb00b00a4029995404mr8079332ejb.3.1709107638490; 
 Wed, 28 Feb 2024 00:07:18 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 hk12-20020a170906c9cc00b00a3e59410a75sm1583572ejb.170.2024.02.28.00.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 07/10] target/i386: remove unnecessary/wrong application of the
 A20 mask
Date: Wed, 28 Feb 2024 09:06:43 +0100
Message-ID: <20240228080646.261365-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If ptw_translate() does a MMU_PHYS_IDX access, the A20 mask is already
applied in get_physical_address(), which is called via probe_access_full()
and x86_cpu_tlb_fill().

If ptw_translate() on the other hand does a MMU_NESTED_IDX access,
the A20 mask must not be applied to the address that is looked up in
the nested page tables; it must be applied only to the addresses that
hold the NPT entries (which is achieved via MMU_PHYS_IDX, per the
previous paragraph).

Therefore, we can remove A20 masking from the computation of the page
table entry's address, and let get_physical_address() or mmu_translate()
apply it when they know they are returning a host-physical address.

Cc: qemu-stable@nongnu.org
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8bcdd2906d5..2ddc08b4bb6 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -164,8 +164,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                 /*
                  * Page table level 5
                  */
-                pte_addr = ((in->cr3 & ~0xfff) +
-                            (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
+                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
                 if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
@@ -189,8 +188,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 4
              */
-            pte_addr = ((pte & PG_ADDRESS_MASK) +
-                        (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
+            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -210,8 +208,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((pte & PG_ADDRESS_MASK) +
-                        (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
+            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -238,7 +235,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
+            pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -260,8 +257,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((pte & PG_ADDRESS_MASK) +
-                    (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
+        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
@@ -287,8 +283,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 1
          */
-        pte_addr = ((pte & PG_ADDRESS_MASK) +
-                    (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
+        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
@@ -306,7 +301,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
+        pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
@@ -335,7 +330,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 1
          */
-        pte_addr = ((pte & ~0xfffu) + ((addr >> 10) & 0xffc)) & a20_mask;
+        pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
-- 
2.43.2


