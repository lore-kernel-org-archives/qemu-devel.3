Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADE7D58B08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1fah-0001gm-Aw; Sun, 15 Mar 2026 03:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fag-0001fr-7X
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:46 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fae-0000bb-Bc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:45 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35a08ce49dcso3328699a91.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558523; x=1774163323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGp5LxAmYWTKuDMXym/h2A+YdJTwFfJW4kvCbf6qbNk=;
 b=F4GfW8ZbvSthL0RWRPj6rQzndR1Z+50+wIobHZhQYlfWYP1aKzKyMMIZr//9mn9kIo
 YGSw0Uukr+DAPDV6StivN2Wdv15j+fHczyPWtuNpINDtr3YzEVLPezE2BqNlbkUA499q
 LnVyjlQiRpqGrVIUVN9UQBx9qPFhnaSLJtJ0bAujmScv5TKiSfYnGaD5TZcoAQKvoKDB
 PfKgZVto3XZW010mWGWX2kmxGQDp/FIAnujztZwQCkkSvy+ksc6xcb0pPm9cyYB3hLnb
 z7R+SpTr8zEZGf/5GaI0P+rOZiDJjH72AfWZHmW4AJGoGR6tvFx3EYZGgHyc/Xst6eCI
 IApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558523; x=1774163323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGp5LxAmYWTKuDMXym/h2A+YdJTwFfJW4kvCbf6qbNk=;
 b=guGpFXaukiohAIOvlbPfzi/+VaJjV1ryw6MbOFLCfylANMDuStYYMKO39aDZK3aIWz
 co/IyOXGd+/FcA8B5e42CwAikJ6ZjKlXYu8X8XFatzH2Wbgr9neMsxB/KfszkUKMBmt1
 st3gjuBuoNB6efQUmc7cxwh2vxn4ULhCQ/Jr+eH3xV8dKiMMyUmd4q1JLkFD+Jl5WXe9
 +R2h37CQF7T/oHfPAKvGkVCjUoSLHSNk5sshaMInwwr3UGTIotqAljZx8UbF4Wjge1sw
 0wuX+SQWequ6tiROqAZhhnvZr7jessrDVOwSplaMsgQb02r1JhVhGojjqyia7QiIDnRh
 7yjw==
X-Gm-Message-State: AOJu0Yz7fDL6KiRHO61Tiqxabk7XsLHz8klG5jZjHpqCAz42g/2Ir44n
 /eZh9W02M5hXFX9c6szPGwPUUOzv9VQwJgjXM6ZqNVhICv5a6fjP4/kIFRDVb2IZPaIlpCsJXNX
 NQ/BbfEw=
X-Gm-Gg: ATEYQzyMNZRA9pPRf6V8LhPGxKd8NB6ucS9DbhlEHj4uTden18fpZeMo+22p2m5Rcw1
 vT/aUZfxIchv5RsQsfGo3yQkTX2GkXVXKzZV5iz7d24mO8ZGYz/97+Qd02Poq5lCrmFJ7gDxUpn
 g0m9Z5ew7mhFpFr4JY4cW4nlqXS0xtohLoHAyuyOqsq4O9me5dfY4Smuz8RfmYTcJINWHjblaEW
 7z/YAK9Gm5wsxjj3SiaO+q803WaYkI64Fa2HJNtwNnSbNwiygepQjoGbukUcQUlDVLCY78yTDne
 l+pdCKFfo9X7QagCFgcyL9LTlYj4COz7VOxUYlJXYn0aan9fFCEbua2LhhsZU2nt5s7mKvFEcyf
 BQv8uhAAIGo4CkddFXE6HpCNPo+Z8MtNb2auzcth4x9krClCI66E/PBpcb9o6eRBymeb6AuVDnq
 0m2qh73Kn40hV8UJkoKDoqUviMfe/lFj7BtuHXfWXOPKVkkyB2Xzn+g9ALu1ngxy2gItxOVqTLa
 ck=
X-Received: by 2002:a17:90b:3501:b0:359:fa1e:2bc3 with SMTP id
 98e67ed59e1d1-35a21ea5dbfmr8294012a91.6.1773558523006; 
 Sun, 15 Mar 2026 00:08:43 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 1/8] hw/vfio/listener.c: remove CONFIG_KVM
Date: Sun, 15 Mar 2026 00:08:27 -0700
Message-ID: <20260315070834.198331-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

Code concerned is under a kvm_enabled() guard.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/listener.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a93..31c3113f8fb 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,9 +20,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#ifdef CONFIG_KVM
 #include <linux/kvm.h>
-#endif
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"
@@ -303,11 +301,9 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
     if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
-#ifdef CONFIG_KVM
         if (kvm_enabled()) {
             max_memslots = kvm_get_max_memslots();
         }
-#endif
 
         QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
-- 
2.47.3


