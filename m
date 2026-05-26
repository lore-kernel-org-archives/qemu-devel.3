Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BDCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmb-0000Wx-Tb; Tue, 26 May 2026 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmU-0008T7-HX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmS-0001KB-Iu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:17 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so6253059f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805755; x=1780410555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R3ory+fpoxCHFqI4j913Yzu0vAlCVPr6aD908OJVlG4=;
 b=X3278JSQLaIVTaof4nOxVJqaV+F8nqX9hNb7cyBlvJl4mFfapSVWK1XyjZczwcaDS5
 am48gTMXJVm9SpnF6LE8lJtxD5xiIcuNROzDlevg3Xbvp2g+DcDByaTwB35GJnMS8Ryf
 rfMVdWsOe/3RaX/l5LGrcAlLcu+KOAKylQ0mBKG0xKGrFg7Ki4LREfQ4pme44uS+HE9n
 UxdqoXQFIzO2Bv/jrsQFw5uxmDHYK3zx+jDoUjBIbnt7/bzeeNJd0e0TadV5j4Go+HrM
 VQaj6TsKvSxweeyotSVFI6swLKQioqqxDndlaUQQFJx8Zedwu0w5+XoBBtME5ZRiE+t5
 0oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805755; x=1780410555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R3ory+fpoxCHFqI4j913Yzu0vAlCVPr6aD908OJVlG4=;
 b=QMWzLIDISC7nLKeKSNpbqXo0OwxvhdnUEJFpXq4UO1rDPBMdeojnuvxp5lW12KvMUH
 KxpgqahCgO+fprPXHjDXUKdW29UER6OlWPsr2qygyvDJRBy0uY+R5N/HejdLim3VMxZN
 TSv+6Kx/dZ6+tmBE6GrncYX1udC/Qjll1pOz3v5QwQd+YELV6nJtKQnrbHjJAzNdXJqW
 sgJToePesNKUMzkgCvgSFsMn278XmHrkmXnhkfF0gyW8SUo67Gg7R/TcWldKA1DEJwxR
 JRL7s0n6FX7xqwREyaty51IWGgkRxwC+kPWgcU8tHNEdibV0YM34lToNtrSiP8oHkdXE
 r60g==
X-Gm-Message-State: AOJu0YwR2HG81CnFCbGlLrCgOr0TrFQWkILMbVTyDAvQjA5fbdzqWWuC
 WriYqzBEjx8BFEydKScJ6cB6KWXnnSWLDn+BhEGIdqxGUHTiTG1X2m1eJp/mDYByXzZjzL0lF4S
 rTb5K
X-Gm-Gg: Acq92OHJUbZSg5SwDRqznLxX0/gKK0WsBBa2Zk7aJmTYCfYRdpP6ale+6oleiUVF0uX
 tpFiaKdAqYyMx2gDAv6Edpi37qJtexFQ26/wZsiVaqkRdcWSqjDQenIiKYTzOLkB5s3gbPGH4ud
 N7nkq/cLBd51h5vMjWv9SxjzewxbERBououycGWVbt/30wdImKUUlXsqY4hXhqnWlu4DSSF2+6R
 +42z6chTDvi/jY7s/WgUEssDQ+zBXzdsC/ei5ID1kkjyab/OxEe8aIdUgqRFzmc+lCZ24cGkjQ9
 AWwqd1d5LGcrtQob5/LVlAUcLP8t2W2Lf/Lz4qs9Q/skNmNkIfjSrOpXirtjfEOvrRi6iaDsJ7u
 iP3QlwPpKEGtUow5HXD0/vcCk3cJOI/Iy6k3YgNFm1zwoLnV+kzxi28SyYEcp72Fh9O9PWu4Q4A
 rpGqX75S0yPaqSbejaYKmYWWT5FXNOm0u40LtZbCfsgxJ17TB/2Oqil1zf9QweRFONivhh99k2S
 ybyw6LywIi3967tS4vwEwKj2fmcwbY=
X-Received: by 2002:a05:6000:4701:b0:44a:525b:2851 with SMTP id
 ffacd0b85a97d-45eb369c4e3mr31183397f8f.10.1779805755046; 
 Tue, 26 May 2026 07:29:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/54] target/arm/ptw: Flip sense of get_phys_addr_gpc return
 value
Date: Tue, 26 May 2026 15:28:20 +0100
Message-ID: <20260526142850.2326589-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-12-peter.maydell@linaro.org
---
 target/arm/ptw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 4538ffeb10..6146367e23 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -667,7 +667,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
+        if (!get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
             goto fail;
         }
 
@@ -3806,7 +3806,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
 {
     if (!get_phys_addr_nogpc(env, ptw, address, access_type,
                             memop, result, fi)) {
-        return true;
+        return false;
     }
 
     if (FIELD_EX64(env->cp15.gpccr_el3, GPCCR, GPC)) {
@@ -3826,11 +3826,11 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                                           result->f.attrs.space, ptw->in_space,
                                           fi)) {
             fi->type = ARMFault_GPCFOnOutput;
-            return true;
+            return false;
         }
     }
 
-    return false;
+    return true;
 }
 
 bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
@@ -3939,7 +3939,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         .in_prot_check = 1 << access_type,
     };
 
-    return get_phys_addr_gpc(env, &ptw, address, access_type,
+    return !get_phys_addr_gpc(env, &ptw, address, access_type,
                              memop, result, fi);
 }
 
@@ -3956,16 +3956,16 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool fault = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
+    bool ok = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
 
-    if (!fault) {
+    if (ok) {
         /* translation succeeded */
         result->physaddr = res.f.phys_addr;
         result->attrs = res.f.attrs;
         result->attrs.debug = 1;
         result->lg_page_size = res.f.lg_page_size;
     }
-    return fault;
+    return !ok;
 }
 
 bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
-- 
2.43.0


