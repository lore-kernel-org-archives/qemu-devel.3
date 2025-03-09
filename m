Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360E2C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqT-00075A-Jj; Sun, 09 Mar 2025 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqC-0006mb-8S
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqA-0004vM-G9
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so19919535e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542808; x=1742147608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v+mT1UbCSCra120s07KB+HyE3Ag704KDjhrj8pB4giU=;
 b=CQJ0ptqCVD6rF3ggn5fzCBsvckxJOC6aifDNv12+sCDAU7pJWUePFFx9RxNHK2a2Pf
 0TZozZgatHADA7/NQeDhq2jGyc61M0wkB0chu0cUkyopGjeKbZjLidfvhW3Ln7/yKTjs
 UuN2shYb8J+Ehsz6YWpGTTnntnn7Eaifx+aiJqhYUI0Y19M/7ezgwfjMH5Ao/YDbrSUl
 8Z8tudTZY9b6mFV6gqDvuEyJfD0ridw/fHin88QwUWf2IceH3l91Dmu4wmoX6Uj/Vs/l
 pzPsdh7DD9ex5lqoC9/+slwnQAC6XApoRXay9cg1Os1auStJhnBKy1m23KY4rE8dowDW
 ZRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542808; x=1742147608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v+mT1UbCSCra120s07KB+HyE3Ag704KDjhrj8pB4giU=;
 b=EPOucKQps28jOJC42xuMlukGoHAco9M81wIOm7rh7sXVBwseSavUh1lr1MvPFoVmks
 VBEM0UhaMStdtk+UcVL89PEof9BNN6fIrU6UHIn8Rkq07qMWA45/L/kIVnZevJSIGKqT
 wdoycvqaL5Lg1oWQTCTBdG3EV2l096mIN8QthRSOmZovs3sENy0EYIGgsfXAdpBIkFUt
 oAtJO7BtcOcZa1y8lL3mzSPMS0vOVFrobPm8bcIw4/xwhlp/9X6qcSmQeDLlB0daXYHP
 Y3yxp4X5AlLS0vxPM+jCUqFGb5H3Fz9SVD3U8k3siiTryYGm8YDQSglBpd08oGzTeA3O
 WV1g==
X-Gm-Message-State: AOJu0YxqP8493huatgVLhlA6ON8/5TetQ5VTdxIByXIbgy1zVYVG8Fb+
 StMGjQvWFSRXHW/eMfqe9YpU4aVILOYz9khsYeRvD80WilJGi5//mfIma9BqglaMyfxbJKqruHM
 NBak=
X-Gm-Gg: ASbGnctbR646nSYpdTEspdoZH901oxXjiyROFb9wgDjCfq8ikWZ/kt8dYBTyIwfQIEP
 3HXVtxW6FROZinUgnVnjGUXQ5o9O5Eq/x7CCU9VxtKW6DQLbHbBLKKtWmSr9Jbj1ymGa2PmkLYc
 KhykbZDbnmbzeHyqM80sXIKK3GMPHOtNawpN1SxtAoloLOzZI3BVHMCMMeTyz/K2OcSlWOmacVk
 91w22vRoJqFNq4Rq5selfVpkqzkDdL/l5AlmydEmeSGhkc1fPANMfNE6ttpInxQtapob2GIENqW
 HOuiqLiAajVWtIDtNGJylLID098V8qv9TTGSnTGpqqe48hWolrGhnddaZBag/Hl64vvDK90h6Nv
 LvIULDSyPFuKE2k/GUvc=
X-Google-Smtp-Source: AGHT+IED3lluJls6m2GW63mCbMX1+0lAC72HBxn3+YhUo7Xi5vQZPb/5m59BOkUbA8F4ouMobFaCCw==
X-Received: by 2002:a05:600c:3c82:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43ce4ad68b1mr42198135e9.9.1741542808232; 
 Sun, 09 Mar 2025 10:53:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cea8076fcsm54050805e9.15.2025.03.09.10.53.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/38] target/alpha: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:46 +0100
Message-ID: <20250309175207.43828-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-5-philmd@linaro.org>
---
 target/alpha/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 2eabd7724df..584c2aa76bd 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -63,6 +63,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool alpha_cpu_has_work(CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
@@ -77,6 +78,7 @@ static bool alpha_cpu_has_work(CPUState *cs)
                                     | CPU_INTERRUPT_SMP
                                     | CPU_INTERRUPT_MCHK);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -224,6 +226,7 @@ static void alpha_cpu_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
+    .has_work = alpha_cpu_has_work,
     .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
 };
 #endif
@@ -259,7 +262,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->has_work = alpha_cpu_has_work;
     cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
-- 
2.47.1


