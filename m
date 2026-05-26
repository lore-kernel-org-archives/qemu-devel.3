Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284BACD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmZ-0000Cp-D3; Tue, 26 May 2026 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmL-0008Ki-8F
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmJ-0001Ej-5h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso51247615e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805746; x=1780410546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jG7hMMv4t6TRZZSkjv097Jp4nBu3JBHsjisoTvyuADM=;
 b=oksYFg+wzRCj5Jk2X4JxffvR29qrixLaHeCGmMh7WSM2IA/5miLzGDweuZ5i8CYuow
 cmE0WY8Rlq9Sjn8vhtzybY7bgCcKR4SWYvtbRZ6weM021MBs0YPzwHXXAw6h9+XjedBG
 vLnipSyrU2ba2Tofz0HMsIAggClxv8gHxyNBia01sxRgLrELAVRQmiGYjtj5sR0mr15M
 vWfUzyGS3Mqvn1ka4FaiLKjAWPoLpR7uwvf0LCtSxnXUDcUe231QjrA/X5afjPZbgpPi
 N85D1op12bg8JYL0uuLmfHe4hw3vJSA8HfWhn8FkEjfFGm61g5nSawANhPKVxcIfAs+6
 i0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805746; x=1780410546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jG7hMMv4t6TRZZSkjv097Jp4nBu3JBHsjisoTvyuADM=;
 b=oJvA20jgVn5t5UFPLlNiUP8dZCOz9SIDyBHX1owncDKqDROP37SFiPbhv/D72UjSTz
 fgvdX2NWlM1k5Tjm14BpE1/dV9g8z/aUhFqz2rP2zSHkl5PCCZfSMOQ5N0Abq8znE25S
 1V+6QTLPFlCXYSAy6qSxkon8wW3dCpmQWqZ8B6aFRgpmGIyhBJncLRPNxqnQnD3PIPEA
 8MFOBbkYXsI/AZmy8wX+UtKRcGPY2hf9cjF0j9P7rDiQ5cGRGK2buwBQSl3weWEvyCFQ
 DNnThWeeU3OIcUx8dy1CKUwoCo8Am+0CXYCIOwDhyj9q+P+Z033B9dNoIvSrUCGkWZeK
 kVRg==
X-Gm-Message-State: AOJu0Yz3RD8ic5Ody9bcxcVAYFu+iscQid3ASsFeQ57SJbrd/5WUcRl2
 OShLOUECFWAoV93YC3mMvIE94NFblWhhbtO4Qhm+51QNtN5hKx+W7nx5WrYz0+p+xqJYfOQC6Qz
 omEuo
X-Gm-Gg: Acq92OFi5BRrfLn/zQ3EK1yOEGce/05PbIlusD6Pt+BYLMpKmRnDTgOX1O3JujERIud
 z5RfKl/ieHfZQdXYt5jQqyMK1h4rP2630xRjcwUq80aYwbIcoocJ++yYKxzUM5dXMhTDWs62Cam
 mt2IIknRlqWZpcCjPWmlslA6gqlYrO1in/8AGz02kxxy80/nrd+tn3di3X53gkQcOP6EME2UuIt
 xtCVUHis1p8Rp4OYN7dpvQGPkt1k06oHwlWULb0qTGoPcTSqKEdgqrcK0zo0BCiY0Du7ywLoJDe
 Ij7KTo3hnI3xocu64IFxWzKyhhuOb/u74XGTz4iQcAUntNuGO8sCnYNWALdWwuldLLOg5WCe30p
 zGTz3ap0xNcVxhbjEJsNoOT9mv+XhssWcmNsgGg55tyrJL26kmbH1cmHj4Pgyn2m2wsYQNB23SU
 dAkvU0ob+9mh+q2AXi/gVRTQLA/ZnjoO9a6b44LfxdNZfz+EsOXqJ6+1wfTl2AdxHdehKidMAdl
 4NHBIW5C92QHOIZfBM+SrN34DLQS8Y=
X-Received: by 2002:a05:600c:6207:b0:490:538a:9c0b with SMTP id
 5b1f17b1804b1-4907dae371fmr7835665e9.2.1779805745654; 
 Tue, 26 May 2026 07:29:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/54] target/arm/ptw: Flip sense of get_phys_addr_disabled
 return value
Date: Tue, 26 May 2026 15:28:10 +0100
Message-ID: <20260526142850.2326589-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We want to bring all the get_phys_addr* functions in ptw.c into line
with the sense that translate_for_debug() has and which seems more
logical: true on success, and false on failure.

Start with get_phys_addr_disabled().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-2-peter.maydell@linaro.org
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7cc1d5884d..9565a7d446 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3506,7 +3506,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
                 fi->type = ARMFault_AddressSize;
                 fi->level = 0;
                 fi->stage2 = false;
-                return 1;
+                return false;
             }
 
             /*
@@ -3548,7 +3548,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
     result->f.lg_page_size = TARGET_PAGE_BITS;
     result->cacheattrs.shareability = shareability;
     result->cacheattrs.attrs = memattr;
-    return false;
+    return true;
 }
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
@@ -3682,7 +3682,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
-        return get_phys_addr_disabled(env, ptw, address, access_type,
+        return !get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
 
     case ARMMMUIdx_Stage1_E0:
@@ -3782,7 +3782,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
-        return get_phys_addr_disabled(env, ptw, address, access_type,
+        return !get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
     }
 
-- 
2.43.0


