Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF8C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVOs-0007WC-Ap; Fri, 23 Feb 2024 08:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJp-0002bp-Uo
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJh-0000T5-6s
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XrayCEnRJN8kGbdEGm9Zy2s0s/S2qD4mtROa+V1h8gY=;
 b=NJUUlfEvCLmlijHUOQ3AAySrZl8Xwp+lbT2spMzUFiXrD1jou71Lo3DDrBJm+OqWiMS1fU
 /3HljA6Jtm1PVwg6Mve1sX6PZALSr3c9A26rzKIz6SLhfB+OjMJUvued58Hhp/l8VjiwQG
 pjgkcg67yHehf0mALe3k8+s3jeQH0jo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-zG7-9Ei8MVuw1-Hqgh58VA-1; Fri, 23 Feb 2024 08:10:13 -0500
X-MC-Unique: zG7-9Ei8MVuw1-Hqgh58VA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-512add274bfso690946e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693809; x=1709298609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrayCEnRJN8kGbdEGm9Zy2s0s/S2qD4mtROa+V1h8gY=;
 b=sFkpNdpQSzInOITgoiKh3iFn737xklPpdwls5nWEcMSFYgX9qz094QtApdxdFnzNNu
 at3LjwR4afHUF1DfNTWyXF02qasBrhOEeivkzIu6TC5zR2sT164t3OVeg0+9YGJdreD5
 d9J0Mx+bTkMh12sLA84vNXLc8dCnRTll/OM7K6wohVO3T2BO+cEvW6Q+CmnS35tct+yV
 yhbgvpG6j2bABtcXKicaDV5CqontmKYELFthTMKhv0mLEz/VbvK380iadFnWcjIcnzfr
 oHunVYHY2couxYeazKseV9llECeo/KXgyNxJzS6u6zzr59hIMmGbioQHWgqXibkiAjGd
 FGgA==
X-Gm-Message-State: AOJu0Ywq6xrkAFioC41pcVqrCTtUEyCb5c7/F8R3ynqS2nhSfeXOfGgu
 5uHuGyt9XbOFEIFyaBSAxHOeSmKXRv5U5raL/ytx5JJlKEFW5AXZgu1ARyUUONiNJ6QxllAgQFd
 HapcJva0vlEGTCcI5i0C3Y52GsWw/+KfgWfE9wLPFTBnzkbVznP+23g9Dc3o7A3fK/k41dtMomx
 KPQTYNQB3gOtcucoQEMfrRag+AdtqavwvPBjQ0
X-Received: by 2002:a19:e005:0:b0:512:be87:af7 with SMTP id
 x5-20020a19e005000000b00512be870af7mr1225923lfg.46.1708693809695; 
 Fri, 23 Feb 2024 05:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/17Hzai2aF6IpN1JeVAujUYEnr9TXJ5hfb32xxXPplJ4No4SSWzxTDHIXWEbSX1cWdo+L4A==
X-Received: by 2002:a19:e005:0:b0:512:be87:af7 with SMTP id
 x5-20020a19e005000000b00512be870af7mr1225884lfg.46.1708693808507; 
 Fri, 23 Feb 2024 05:10:08 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h27-20020a056512055b00b0051167de8560sm2430192lfl.38.2024.02.23.05.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:10:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 6/7] target/i386: remove unnecessary/wrong application of
 the A20 mask
Date: Fri, 23 Feb 2024 14:09:47 +0100
Message-ID: <20240223130948.237186-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
2.43.0


