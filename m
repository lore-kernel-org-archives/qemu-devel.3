Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B1EC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyJ-0001Vp-Rz; Wed, 28 Feb 2024 03:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyI-0001VA-81
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEy5-0000Tr-Hu
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJU9e2eU5+KH4PwxmXgA5VX7eK+RWqpGt+HRjhX9ZFY=;
 b=DYPJ6dghZnGNbO7mlcazYoxOpC3vtV9SIU4UnmXQE502oPnPhtErm65/4KVgfieDu9YwUZ
 YbplIDevPDg96cO4MLNEFgmxnV7Gh80tVARKmOhD7BjXTEyqNdyoqeN8MscMmafCo6r7Ud
 3cSofqRlsV1pFc20zj8J/OP9KlQgnfI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-_6Z_a9gzPDWAqYMat0g7yg-1; Wed, 28 Feb 2024 03:07:07 -0500
X-MC-Unique: _6Z_a9gzPDWAqYMat0g7yg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56421fd7029so2821372a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107624; x=1709712424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJU9e2eU5+KH4PwxmXgA5VX7eK+RWqpGt+HRjhX9ZFY=;
 b=fMHgYe1yvobg3sCI69StYY+QuKmPeCyxCwYJstECUC3yERcK4VUvwwX9ZudV+fo/9B
 0v/xhloaGei8m7OfUkxwofR2xjWR+bImzJ5OQ46oreEuo1HryBg2GPKDR/JcysZWa65e
 CPaPyGch7Rjb4ifpqGiIkcVTg4bUXmjvN8/D1kfHbeCThb3uLp79T+vGncSyBNmsp64y
 xdm6lxQnpq54FhDZlsVKpPqBDrYnWjhfv0R/wfKHJB5ClFcD+cxdYqKL26Q0tSnHi3oO
 u6ng1EV7H2DWJUI4aTgMPGa0XymwHgJOaLis8I5wwjrLIuPDUSFldAfgkdktW/RRcOQ5
 rKHA==
X-Gm-Message-State: AOJu0YwFkoJ79cicpWXkXJOr67kOi1yj+q/Ny+mzISShsu0F4Y2Iff94
 7nyq+MDgN2eSaXGfpgqQTLiM+7rOb0QkLz8k5u4pBMhKRL3IQF7I9KCQKYpkfcaNH1TiNOM04nk
 YGsrAHmdpRViXpcPEvTeXsj72Av3ISgOZnNh+V7MaW3xoCtQfDxT5H04W1ULob45xFOSz5T27TG
 JISxUC6K9CnFNTaYn2IBbHLVzsKEbMLBBYfdpT
X-Received: by 2002:a05:6402:612:b0:566:1fbd:22bb with SMTP id
 n18-20020a056402061200b005661fbd22bbmr3741352edv.9.1709107624615; 
 Wed, 28 Feb 2024 00:07:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZSHbHt0TIsRSGAMsv7rhypqyj7CyxCUJLj0jvvHR0qxNOdluvwXgYZfyXgAPsBY20YDOoew==
X-Received: by 2002:a05:6402:612:b0:566:1fbd:22bb with SMTP id
 n18-20020a056402061200b005661fbd22bbmr3741332edv.9.1709107624196; 
 Wed, 28 Feb 2024 00:07:04 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 if3-20020a0564025d8300b0056659364b0fsm761821edb.51.2024.02.28.00.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/10] target/i386: mask high bits of CR3 in 32-bit mode
Date: Wed, 28 Feb 2024 09:06:38 +0100
Message-ID: <20240228080646.261365-3-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
paging or PAE paging).  Do this in mmu_translate() to remove
the last where get_physical_address() meaningfully drops the high
bits of the address.

Cc: qemu-stable@nongnu.org
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439add..11126c860d4 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -238,7 +238,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
+            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -306,7 +306,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
+        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
-- 
2.43.2


