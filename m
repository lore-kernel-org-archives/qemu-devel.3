Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92660C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yl-0002Gj-Lm; Mon, 22 Jul 2024 21:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yk-0002Dp-Ow
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:10 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yi-0008Qp-HW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:10 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-447f25e65f9so24636371cf.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696767; x=1722301567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWDXnEPKNEpB10DKBkm4YAVj9PA/XeShZDvT8s5ahIU=;
 b=YGVH/aaCSe664C5ZG0ggrdmROP8H8Kiy8kQjStfTxYAuL6EFxcFCvrWS9fiDMxbt77
 LiCkqcPD7l4++DJ0VF80d1GdrHV1jDMh2/Ju3uF3uXUGMF1iwO+Na6Mu2wiZ5dvc9/IF
 mSFEX5YzYTqHaVT1Oy5/JYOkv0q2Ru/zrXMiyQOody3sRwPSKkG9P3a3GPzvlRp5IL98
 G6pUg0M9DYO59iwlpd4fDW1gispD0jdP9k9FvlZ6250Mft/8gXHdDw3a+1mpdoyhcSIO
 M4ryNMe49tPttOu35Z7AUL9yH2uvcLqWfERyKFB/ldX+htEUS/Xc6PkRrgfuC7UNGPeq
 n63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696767; x=1722301567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWDXnEPKNEpB10DKBkm4YAVj9PA/XeShZDvT8s5ahIU=;
 b=Q9d7T/7i8UJ5JChuc2xqyF3rnz48/iRiSIPWmRbF3sGsEuvSVkvdjxJYaSW/CQ0I4+
 o0czzZyficqduZZ7YNolyOfXYqCW0u2W1MfEQaIx7rwXmSxqmpOS/fKO7RC+6liO42Qf
 h+I/UsQW5l11gzZI484BKM52eV9WbLAraZPg4kU2hrl8fDbnnnLbxm1JIqNS+ZBour6p
 nAnrtsSqmSpnIJ+OJql+7TC69bek4Z+bhuzYHouJPsmiiqhruPQ6rSH32ZSHX/oq1ttB
 02jvNJFxVQfE9U/mSQSxWrc8yumE9C64Hi/cSKLYtYX+6JG59Uln/mnGM16FyesC2A74
 unVA==
X-Gm-Message-State: AOJu0Yw3xVYARWn1CdX/8NokR3VeHk2k6Ro2PLsrhEK+YpVRlg5yE9o2
 uCWIF4mHSVNbgDxlNDwQtVv6wLJoq3oUc438c9AULB+9wx62Yuw+78X/M2SUFCfaTE/C1yUd9qP
 A2WrHV/gEFSmnbE6/NMWc9FiaRARgNjuUhEjjX8107aBmvUukDs/qz5F0wwbL2pPH/2NowKY5RY
 MLgyceakSPJFIEO3TEsmG6WMqr+oIv
X-Google-Smtp-Source: AGHT+IFaGbFIPPIqWA40uW1wev9Fb7KBPBt42XbfQf6WFvs4DG/Vkcs4gZ48ufZxyU+yHoMdknOVow==
X-Received: by 2002:a05:622a:411:b0:447:e786:3f9b with SMTP id
 d75a77b69052e-44fc557b048mr20252751cf.49.1721696766621; 
 Mon, 22 Jul 2024 18:06:06 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:06:06 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 7/7] Convert x86_mmu_translate() to use common code.
Date: Mon, 22 Jul 2024 21:05:45 -0400
Message-Id: <20240723010545.3648706-8-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=porter@cs.unc.edu; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 target/i386/tcg/helper-tcg.h         |   2 +-
 target/i386/tcg/sysemu/excp_helper.c | 417 ++-------------------------
 2 files changed, 30 insertions(+), 389 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 1cbeab9161..8f63280359 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -96,7 +96,7 @@ void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 typedef struct TranslateFault {
     int exception_index;
     int error_code;
-    target_ulong cr2;
+    uint64_t cr2;
     TranslateFaultStage2 stage2;
 } TranslateFault;
 
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 3ebb67d65b..37c33fdfb1 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -36,32 +36,9 @@ typedef struct TranslateParams {
 typedef struct TranslateResult {
     hwaddr paddr;
     int prot;
-    int page_size;
+    uint64_t page_size;
 } TranslateResult;
 
-static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
-{
-    CPUTLBEntryFull *full;
-    int flags;
-
-    inout->gaddr = addr;
-    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, ra);
-
-    if (unlikely(flags & TLB_INVALID_MASK)) {
-        TranslateFault *err = inout->err;
-
-        assert(inout->ptw_idx == MMU_NESTED_IDX);
-        *err = (TranslateFault){
-            .error_code = inout->env->error_code,
-            .cr2 = addr,
-            .stage2 = S2_GPT,
-        };
-        return false;
-    }
-    return true;
-}
-
 static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
@@ -102,371 +79,33 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                           uint64_t ra)
 {
     const target_ulong addr = in->addr;
-    const int pg_mode = in->pg_mode;
-    const bool is_user = is_mmu_index_user(in->mmu_idx);
-    const MMUAccessType access_type = in->access_type;
-    uint64_t ptep, pte, rsvd_mask;
-    PTETranslate pte_trans = {
-        .env = env,
-        .err = err,
-        .ptw_idx = in->ptw_idx,
-    };
-    hwaddr pte_addr, paddr;
-    uint32_t pkr;
-    int page_size;
-    int error_code;
-
- restart_all:
-    rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
-    rsvd_mask &= PG_ADDRESS_MASK;
-    if (!(pg_mode & PG_MODE_NXE)) {
-        rsvd_mask |= PG_NX_MASK;
-    }
-
-    if (pg_mode & PG_MODE_PAE) {
-#ifdef TARGET_X86_64
-        if (pg_mode & PG_MODE_LMA) {
-            if (pg_mode & PG_MODE_LA57) {
-                /*
-                 * Page table level 5
-                 */
-                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
-                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                    return false;
-                }
-            restart_5:
-                pte = ptw_ldq(&pte_trans, ra);
-                if (!(pte & PG_PRESENT_MASK)) {
-                    goto do_fault;
-                }
-                if (pte & (rsvd_mask | PG_PSE_MASK)) {
-                    goto do_fault_rsvd;
-                }
-                if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                    goto restart_5;
-                }
-                ptep = pte ^ PG_NX_MASK;
-            } else {
-                pte = in->cr3;
-                ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
-            }
-
-            /*
-             * Page table level 4
-             */
-            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                return false;
-            }
-        restart_4:
-            pte = ptw_ldq(&pte_trans, ra);
-            if (!(pte & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pte & (rsvd_mask | PG_PSE_MASK)) {
-                goto do_fault_rsvd;
-            }
-            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                goto restart_4;
-            }
-            ptep &= pte ^ PG_NX_MASK;
-
-            /*
-             * Page table level 3
-             */
-            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                return false;
-            }
-        restart_3_lma:
-            pte = ptw_ldq(&pte_trans, ra);
-            if (!(pte & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pte & rsvd_mask) {
-                goto do_fault_rsvd;
-            }
-            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                goto restart_3_lma;
-            }
-            ptep &= pte ^ PG_NX_MASK;
-            if (pte & PG_PSE_MASK) {
-                /* 1 GB page */
-                page_size = 1024 * 1024 * 1024;
-                goto do_check_protect;
-            }
-        } else
-#endif
-        {
-            /*
-             * Page table level 3
-             */
-            pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-                return false;
-            }
-            rsvd_mask |= PG_HI_USER_MASK;
-        restart_3_nolma:
-            pte = ptw_ldq(&pte_trans, ra);
-            if (!(pte & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pte & (rsvd_mask | PG_NX_MASK)) {
-                goto do_fault_rsvd;
-            }
-            if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-                goto restart_3_nolma;
-            }
-            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
-        }
-
-        /*
-         * Page table level 2
-         */
-        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-    restart_2_pae:
-        pte = ptw_ldq(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        if (pte & rsvd_mask) {
-            goto do_fault_rsvd;
-        }
-        if (pte & PG_PSE_MASK) {
-            /* 2 MB page */
-            page_size = 2048 * 1024;
-            ptep &= pte ^ PG_NX_MASK;
-            goto do_check_protect;
-        }
-        if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-            goto restart_2_pae;
-        }
-        ptep &= pte ^ PG_NX_MASK;
-
-        /*
-         * Page table level 1
-         */
-        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-        pte = ptw_ldq(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        if (pte & rsvd_mask) {
-            goto do_fault_rsvd;
-        }
-        /* combine pde and pte nx, user and rw protections */
-        ptep &= pte ^ PG_NX_MASK;
-        page_size = 4096;
-    } else {
-        /*
-         * Page table level 2
-         */
-        pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-    restart_2_nopae:
-        pte = ptw_ldl(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        ptep = pte | PG_NX_MASK;
-
-        /* if PSE bit is set, then we use a 4MB page */
-        if ((pte & PG_PSE_MASK) && (pg_mode & PG_MODE_PSE)) {
-            page_size = 4096 * 1024;
-            /*
-             * Bits 20-13 provide bits 39-32 of the address, bit 21 is reserved.
-             * Leave bits 20-13 in place for setting accessed/dirty bits below.
-             */
-            pte = (uint32_t)pte | ((pte & 0x1fe000LL) << (32 - 13));
-            rsvd_mask = 0x200000;
-            goto do_check_protect_pse36;
-        }
-        if (!ptw_setl(&pte_trans, pte, PG_ACCESSED_MASK)) {
-            goto restart_2_nopae;
-        }
-
-        /*
-         * Page table level 1
-         */
-        pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
-            return false;
-        }
-        pte = ptw_ldl(&pte_trans, ra);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        /* combine pde and pte user and rw protections */
-        ptep &= pte | PG_NX_MASK;
-        page_size = 4096;
-        rsvd_mask = 0;
-    }
-
-do_check_protect:
-    rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
-do_check_protect_pse36:
-    if (pte & rsvd_mask) {
-        goto do_fault_rsvd;
-    }
-    ptep ^= PG_NX_MASK;
-
-    /* can the page can be put in the TLB?  prot will tell us */
-    if (is_user && !(ptep & PG_USER_MASK)) {
-        goto do_fault_protect;
-    }
-
-    int prot = 0;
-    if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
-        prot |= PAGE_READ;
-        if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
-            prot |= PAGE_WRITE;
-        }
-    }
-    if (!(ptep & PG_NX_MASK) &&
-        (is_user ||
-         !((pg_mode & PG_MODE_SMEP) && (ptep & PG_USER_MASK)))) {
-        prot |= PAGE_EXEC;
-    }
-
-    if (ptep & PG_USER_MASK) {
-        pkr = pg_mode & PG_MODE_PKE ? env->pkru : 0;
-    } else {
-        pkr = pg_mode & PG_MODE_PKS ? env->pkrs : 0;
-    }
-    if (pkr) {
-        uint32_t pk = (pte & PG_PKRU_MASK) >> PG_PKRU_BIT;
-        uint32_t pkr_ad = (pkr >> pk * 2) & 1;
-        uint32_t pkr_wd = (pkr >> pk * 2) & 2;
-        uint32_t pkr_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-
-        if (pkr_ad) {
-            pkr_prot &= ~(PAGE_READ | PAGE_WRITE);
-        } else if (pkr_wd && (is_user || (pg_mode & PG_MODE_WP))) {
-            pkr_prot &= ~PAGE_WRITE;
-        }
-        if ((pkr_prot & (1 << access_type)) == 0) {
-            goto do_fault_pk_protect;
-        }
-        prot &= pkr_prot;
-    }
-
-    if ((prot & (1 << access_type)) == 0) {
-        goto do_fault_protect;
-    }
-
-    /* yes, it can! */
-    {
-        uint32_t set = PG_ACCESSED_MASK;
-        if (access_type == MMU_DATA_STORE) {
-            set |= PG_DIRTY_MASK;
-        } else if (!(pte & PG_DIRTY_MASK)) {
-            /*
-             * Only set write access if already dirty...
-             * otherwise wait for dirty access.
-             */
-            prot &= ~PAGE_WRITE;
-        }
-        if (!ptw_setl(&pte_trans, pte, set)) {
-            /*
-             * We can arrive here from any of 3 levels and 2 formats.
-             * The only safe thing is to restart the entire lookup.
-             */
-            goto restart_all;
-        }
+    hwaddr paddr;
+    CPUState *cs = env_cpu(env);
+    bool dirty = false;
+
+    bool ok = x86_ptw_translate(cs, addr, &paddr, false,
+                                in->ptw_idx == MMU_NESTED_IDX ? 1 : 0,
+                                is_mmu_index_user(in->mmu_idx), in->access_type,
+                                &out->page_size, &err->error_code,
+                                (hwaddr *) &err->cr2, &err->stage2, &out->prot,
+                                &dirty);
+    if (!ok) {
+
+        err->exception_index = EXCP0E_PAGE;
+        return false;
     }
 
-    /* merge offset within page */
-    paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
-
     /*
-     * Note that NPT is walked (for both paging structures and final guest
-     * addresses) using the address with the A20 bit set.
+     * Only set write access if already dirty...
+     * otherwise wait for dirty access.
      */
-    if (in->ptw_idx == MMU_NESTED_IDX) {
-        CPUTLBEntryFull *full;
-        int flags, nested_page_size;
-
-        flags = probe_access_full(env, paddr, 0, access_type,
-                                  MMU_NESTED_IDX, true,
-                                  &pte_trans.haddr, &full, 0);
-        if (unlikely(flags & TLB_INVALID_MASK)) {
-            *err = (TranslateFault){
-                .error_code = env->error_code,
-                .cr2 = paddr,
-                .stage2 = S2_GPA,
-            };
-            return false;
-        }
-
-        /* Merge stage1 & stage2 protection bits. */
-        prot &= full->prot;
-
-        /* Re-verify resulting protection. */
-        if ((prot & (1 << access_type)) == 0) {
-            goto do_fault_protect;
-        }
-
-        /* Merge stage1 & stage2 addresses to final physical address. */
-        nested_page_size = 1 << full->lg_page_size;
-        paddr = (full->phys_addr & ~(nested_page_size - 1))
-              | (paddr & (nested_page_size - 1));
-
-        /*
-         * Use the larger of stage1 & stage2 page sizes, so that
-         * invalidation works.
-         */
-        if (nested_page_size > page_size) {
-            page_size = nested_page_size;
-        }
+    if (in->access_type != MMU_DATA_STORE && !dirty) {
+        out->prot &= ~PAGE_WRITE;
     }
 
     out->paddr = paddr & x86_get_a20_mask(env);
-    out->prot = prot;
-    out->page_size = page_size;
-    return true;
 
- do_fault_rsvd:
-    error_code = PG_ERROR_RSVD_MASK;
-    goto do_fault_cont;
- do_fault_protect:
-    error_code = PG_ERROR_P_MASK;
-    goto do_fault_cont;
- do_fault_pk_protect:
-    assert(access_type != MMU_INST_FETCH);
-    error_code = PG_ERROR_PK_MASK | PG_ERROR_P_MASK;
-    goto do_fault_cont;
- do_fault:
-    error_code = 0;
- do_fault_cont:
-    if (is_user) {
-        error_code |= PG_ERROR_U_MASK;
-    }
-    switch (access_type) {
-    case MMU_DATA_LOAD:
-        break;
-    case MMU_DATA_STORE:
-        error_code |= PG_ERROR_W_MASK;
-        break;
-    case MMU_INST_FETCH:
-        if (pg_mode & (PG_MODE_NXE | PG_MODE_SMEP)) {
-            error_code |= PG_ERROR_I_D_MASK;
-        }
-        break;
-    }
-    *err = (TranslateFault){
-        .exception_index = EXCP0E_PAGE,
-        .error_code = error_code,
-        .cr2 = addr,
-    };
-    return false;
+    return true;
 }
 
 static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
@@ -491,10 +130,11 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
     cpu_vmexit(env, SVM_EXIT_NPF, exit_info_1, retaddr);
 }
 
-static bool get_physical_address(CPUX86State *env, vaddr addr,
-                                 MMUAccessType access_type, int mmu_idx,
-                                 TranslateResult *out, TranslateFault *err,
-                                 uint64_t ra)
+static
+bool x86_cpu_get_physical_address(CPUX86State *env, vaddr addr,
+                                  MMUAccessType access_type, int mmu_idx,
+                                  TranslateResult *out,
+                                  TranslateFault *err, uint64_t ra)
 {
     TranslateParams in;
     bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
@@ -511,7 +151,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             in.cr3 = env->nested_cr3;
             in.pg_mode = env->nested_pg_mode;
             in.mmu_idx =
-                env->nested_pg_mode & PG_MODE_LMA ? MMU_USER64_IDX : MMU_USER32_IDX;
+                env->nested_pg_mode & PG_MODE_LMA ?
+                MMU_USER64_IDX : MMU_USER32_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
             if (!mmu_translate(env, &in, out, err, ra)) {
@@ -565,8 +206,8 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     TranslateResult out;
     TranslateFault err;
 
-    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
-                             retaddr)) {
+    if (x86_cpu_get_physical_address(env, addr, access_type, mmu_idx, &out,
+                                     &err, retaddr)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
-- 
2.34.1


