Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587B8FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINqu-0004kb-KL; Thu, 30 Apr 2026 05:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqm-0004d5-CA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqi-0002WC-9c
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-445795cf6f1so438010f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541902; x=1778146702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MY7hfUPLGJ8oz6CMVQMMmJ8m7WR8XRXo8hMX7o/HlFQ=;
 b=tKEkum9QimQVYzY1ThGrCRNAIavfKnifNx/EqcA4I4522+3XVmkDhCPE9aH9wxHIrb
 8afbHTm0lddR/xRpJQnGhthgrqIyIGZkCXG/vyXNU0FpiWDo6I8YmwJ7XlBGKLpr3JQC
 wlzDdxGYDBpXykjHByTmNu+924PRIyKCbxnauGAj6iKMWGJrM7zmHs7C7E0hA7/ucKBu
 D0aRFIlXGmNgxGSO/1K4CBXgX2AmFlv1cbvfzAap9619Fyxam6/KmNKqTJsscs3o4sgJ
 m9fCBwojC3zKEePscOVckKSBpn6sa4cMpnqXtBht6xWfgewj5kTFyptvenKU89gAZgsm
 Kojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541902; x=1778146702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MY7hfUPLGJ8oz6CMVQMMmJ8m7WR8XRXo8hMX7o/HlFQ=;
 b=sQgBo4jc9EarR0JMxOqQuLF7hKIPgiLydGTjgNJpLN9o3o0d+8o5u6NHEz8kcG21rx
 RBYTFCTwKxFAYFbm3r2amipVBDX4yeAId9Q6VqqY2XYBsIwqfp/1Gco57XOGYSHgKimc
 WKgjpWBoPRPL42F5WkgKpT05sh8/FqhpXHeHA1FPPep1U1WI5OHIzIVKGXL7od8cFZBz
 JScY7zepWgJOIXhPHFl+zWurQsRx7TI3/waiEYwGCUQIunJrupRTFy3DXCcObAwpbuvn
 w/PXr0VcmeutWsD06Cg34PcIrarqbk3wwlhxki1Cl+cebhe8aDhgZHvXb0oeD9rgsfAH
 Vxwg==
X-Gm-Message-State: AOJu0Yy8CCDOWbDmsX80UDnfDE0J87VbuW6Halh4wp4Ka9IHfGJe/iFm
 iT4SB4lW2raWcGgugApHBDhvc6Nk6RKtkioUJHE13hh9rr+ir51GfGiTC7f4Tb2vxNsPIPh6qmn
 XpF1o
X-Gm-Gg: AeBDievmFgK65NM4Nmx8bBZOtlPfCvQFU74+JQX+laQeZI/uTFc0DWjmHkGO3TeDmjh
 4D2361BK+EAWGG/TONJ3h1fBVCKyoNA3VlKqPe7X0SM6jKESwv11O9ePrbb3X/lE8ImV2v90OJQ
 dU9qxKVNuSlAW8LPwqKG7WKjv/Sti/C69WDmeoA1RdwcV1MEl/npBn3QpOv7gpXCGXF4oIqvUR2
 bfjKxdpRUNV6OCXO8bO2pfaivM+PxhXItHYddJ20B5lPdxBGWQAeQuiJjaZqshDjo0gs2S4KbF2
 pEjzHokcs+LLjsj0Ux3c8sbS5tAzt/deFLGOzXtGEKLLVY2P3ygIfU/0AJOewDCZCRCA9pCER4V
 ABiePqpznxipKZ3MFe9qHgp5u+XdSEtKYnsAqHhEpimwQ8aURPzQCtbqHlkOlye8riRWnD0UBpf
 ms+SGus90NZwtoCO7QqN1Y+eifZ8H3soSAuDs2XLBc2FMVqmpEdEXOnTh6s7i/di/XxDXJxmhv2
 AkkUxIhE0l5DncMSIZ9Qk+hS0efNc1laRl5pFxU1Q==
X-Received: by 2002:a05:6000:25c1:b0:43d:7e11:1b72 with SMTP id
 ffacd0b85a97d-4493d7f9ea1mr3315847f8f.9.1777541902024; 
 Thu, 30 Apr 2026 02:38:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 08/25] target/ppc: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Thu, 30 Apr 2026 10:37:53 +0100
Message-ID: <20260430093810.2762539-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

The ppc_xlate() function can accept a non-page-aligned input but may
return a page-aligned output; we take the simple approach of ORing
the page offset back into the result address after calling it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-8-peter.maydell@linaro.org
---
 target/ppc/mmu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 52d48615ac..a1345df716 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -863,7 +863,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
                   ppc_env_mmu_index(&cpu->env, false), false) ||
         ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
                   ppc_env_mmu_index(&cpu->env, true), false)) {
-        return raddr & TARGET_PAGE_MASK;
+        return raddr | (addr & ~TARGET_PAGE_MASK);
     }
     return -1;
 }
-- 
2.43.0


