Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3129DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyS-0001fu-7r; Wed, 28 Feb 2024 03:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyQ-0001f1-Sa
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyM-0000YQ-G8
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FOwAaHjkgtd1Obqs7Hvk+sV/XW9OPoHUZIDnhZ07Wo=;
 b=TwbwWzK0XO7Cq3Y5gbmi83SG/x6HBBdO8koMmI/A98L/JmmStsrebae1cuHLBz51Ajnf6Q
 7EM/WBrAvh+dieg5reOBSckLwIm6u/ZfiibIVO7ShURdI/4jQqTLDikMt/PLkhs+esOkR7
 p7po8w75lt3B0UON3BudYGZySR17Olc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-AphdRWmYM5ed1pCkcJHyyQ-1; Wed, 28 Feb 2024 03:07:22 -0500
X-MC-Unique: AphdRWmYM5ed1pCkcJHyyQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56421fd7029so2821514a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107641; x=1709712441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FOwAaHjkgtd1Obqs7Hvk+sV/XW9OPoHUZIDnhZ07Wo=;
 b=LHXf+d1ewjMGRwuwg24nqOj3xVX3RvzNPckWDU+avdVM3hh9hXRlCmIGNnk6J5QC+L
 bugeaFz2Z0sxconBYZy8lxb/nS1mojpoGG0xcxehxSdIXC1srEF2YfYI/fLhuwG5TYkM
 fHMNWIOUUZvWRpntDAdMYL1veqlyLIzQcmlfGqywEOmrxRRYJYAw/P+Wi7pSgVdaZFsy
 xqiMhtKPN/zYT4EBcc8fnPIQpIuoacl7ll/zG9t/y38Wucy3uBFlyu2rkhIDYKSMKTsM
 CAB+gzr25teJDSfRKbQs4Y6WAVOe76Z7NLmJdAVVGcTkp+IXMHcNn+nKxGVby6Z8Tqg9
 tRMA==
X-Gm-Message-State: AOJu0YyLP/N8ZpJzDdcIxTdVsxk3b8OAdcgBaEQMc6VKHvzs7ubfVeXS
 SSbwQe0+RI/iXkaWZh2qDNUvu+JcV7jKhoxlsj7z8VQOW/TXaoWvN093SXwzoJfSij7xWgfB3F2
 Tm36JxF19Kj/ztyCYvv+gnZpL9iU5tcRawyVAHh6wTCm+wDTD+hPZ30FEQbwTV3hv9TurMhsWzi
 oFaJKLQh94wkZcB3ABr++dHZLAXq/0tql4u07f
X-Received: by 2002:aa7:c657:0:b0:565:9b18:8af5 with SMTP id
 z23-20020aa7c657000000b005659b188af5mr8474053edr.39.1709107641106; 
 Wed, 28 Feb 2024 00:07:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYJ4jor1+MprrPcUB0AIt6MuocBS55h3tWFcoctHRgbt9LKrirvM3TAPunIaDvQZ6S+EfYlg==
X-Received: by 2002:aa7:c657:0:b0:565:9b18:8af5 with SMTP id
 z23-20020aa7c657000000b005659b188af5mr8474035edr.39.1709107640775; 
 Wed, 28 Feb 2024 00:07:20 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a056402500d00b005648b000e91sm1535758eda.92.2024.02.28.00.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 08/10] target/i386: leave the A20 bit set in the final NPT walk
Date: Wed, 28 Feb 2024 09:06:44 +0100
Message-ID: <20240228080646.261365-9-pbonzini@redhat.com>
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
 SPF_PASS=-0.001,
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

The A20 mask is only applied to the final memory access.  Nested
page tables are always walked with the raw guest-physical address.

Unlike the previous patch, in this one the masking must be kept, but
it was done too early.

Cc: qemu-stable@nongnu.org
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 2ddc08b4bb6..8f7011d9663 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -134,7 +134,6 @@ static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                           TranslateResult *out, TranslateFault *err)
 {
-    const int32_t a20_mask = x86_get_a20_mask(env);
     const target_ulong addr = in->addr;
     const int pg_mode = in->pg_mode;
     const bool is_user = is_mmu_index_user(in->mmu_idx);
@@ -417,10 +416,13 @@ do_check_protect_pse36:
         }
     }
 
-    /* align to page_size */
-    paddr = (pte & a20_mask & PG_ADDRESS_MASK & ~(page_size - 1))
-          | (addr & (page_size - 1));
+    /* merge offset within page */
+    paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
 
+    /*
+     * Note that NPT is walked (for both paging structures and final guest
+     * addresses) using the address with the A20 bit set.
+     */
     if (in->ptw_idx == MMU_NESTED_IDX) {
         CPUTLBEntryFull *full;
         int flags, nested_page_size;
@@ -459,7 +461,7 @@ do_check_protect_pse36:
         }
     }
 
-    out->paddr = paddr;
+    out->paddr = paddr & x86_get_a20_mask(env);
     out->prot = prot;
     out->page_size = page_size;
     return true;
-- 
2.43.2


