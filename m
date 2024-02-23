Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5D4C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVNe-0005VZ-Fb; Fri, 23 Feb 2024 08:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJn-0002b8-UO
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJh-0000TA-66
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnQ7i5ueTC+xlo8UAzRXXauDN9cg2kKCLhjsqVL+gjQ=;
 b=IqXZj2NGjw+7LiegsAQ1yOGBOqVpzwWama/wKlMPUle5DD1VtmQyNYMnnCdsaCMP/RXkyO
 Nm7RvI7pDqaO5SJ49JBb+AKB35rdedwEcZ1Lup0CpLri/0adW6gHIH7xsuxM9tHZKmD+Zn
 OxrdOhZ0Gk/IjfsdcRyZ+2QZygIbVA0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-_BmBdEPEMlSimcFuVcDmKw-1; Fri, 23 Feb 2024 08:10:13 -0500
X-MC-Unique: _BmBdEPEMlSimcFuVcDmKw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d27386667eso2558301fa.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693810; x=1709298610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnQ7i5ueTC+xlo8UAzRXXauDN9cg2kKCLhjsqVL+gjQ=;
 b=CDd+wcUeabW/8nmcpOVx1W7of3ReSU9UZLuXbgPQ/VyPPfeQsR+JHp0FYcmpOVwE68
 cND01nyNYzaMEwM42R/gMixVh5w1jnN6evzYdrBLJqkP6S9wSzV2/UZnwOg6kHLL8p52
 q8aZTp7ehqHisb97/8BjroYc9kKpqDyMfmUcl2LsXQ+123gF4Gxvs4Dmjc20/jA6DiXD
 iBF/n6HKuS5Qt7M0dmWA8Iy1WaZtFCJIo/KOR7UtAoXivW4G9mzS9/b/eZbo43ulsYwX
 2o7hKurVSsE9nMjkEBghGdXzJL9by6H+qhjW0sfAUNhtIrztAGvR8OkZekdHspDm7Zg5
 c/yg==
X-Gm-Message-State: AOJu0YwGfaeoPvXN32H83OJTJisdR3abjZNKW4duHYSv0eKzqxmibelE
 COUlPCdPZ4jfRs1Le90tG8AVCtkbo0PR+q/pmd66Q99bNsHzf74ZWybEuGhmYNpmNjsz8ed/AzJ
 y7ca/klSsVMY3OaCI/AAuzCl5gBgMmkcOrFQ67uKXsoXr9Gj12qMo36SBYhPlbqkKVpzjPrw3Hr
 bZCg5OBy5Mivz2lSQb8LLRIqfSNbydpb5c7hyH
X-Received: by 2002:a2e:a78e:0:b0:2d2:39ab:eee1 with SMTP id
 c14-20020a2ea78e000000b002d239abeee1mr1705204ljf.32.1708693810464; 
 Fri, 23 Feb 2024 05:10:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElP3c5/uDGrDGmeAi97RUXbnQQgyKcu1VdqWxjWVIWvgYhFWLy7diaD3riy6szGHec702ezw==
X-Received: by 2002:a2e:a78e:0:b0:2d2:39ab:eee1 with SMTP id
 c14-20020a2ea78e000000b002d239abeee1mr1705178ljf.32.1708693810148; 
 Fri, 23 Feb 2024 05:10:10 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a2e86d6000000b002d0acb57c89sm2563335ljj.64.2024.02.23.05.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:10:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 7/7] target/i386: leave the A20 bit set in the final NPT
 walk
Date: Fri, 23 Feb 2024 14:09:48 +0100
Message-ID: <20240223130948.237186-8-pbonzini@redhat.com>
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

The A20 mask is only applied to the final memory access.  Nested
page tables are always walked with the raw guest-physical address.

Unlike the previous patch, in this one the masking must be kept, but
it was done too early.

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
2.43.0


