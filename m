Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C710C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLs-0008QE-Ll; Tue, 18 Jun 2024 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLp-0008GX-6a
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:29 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLm-0007lr-Nq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:28 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52c819f6146so7474894e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726784; x=1719331584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZqLfefuSJqvtpGWlLdOMb144pE69iIqAnMbzj9lfMc=;
 b=gYJRYVCXAQ050McA92JbN+Q9sRO4AFPx+ViK3Xd6Pe0a/9tKU4ydROA7WBNQKBgjUF
 vLRBbjoc2QVNlYlQ6EQiMEUv/v6HacerdOWf2nx3IqhCP3n+zj8yON1U5XF5KuXCBJZw
 OoEQTyR6Id2DpkICJxkCdTKDhXw9IYhE8XBd85uN1roaD5LhwmliJBiB5OYKp4pc8hMn
 9Tj9vf3PZ8XagmpJ61JNk1uPFLpNLTCbUTk+17C5LJ7OUbyQml4uJUriSlp6SDi+LD32
 qX1OGuOOTN5R4Wq4Xtb3BYuMRkwYGmTjwHR0KNZvejyH/qwUHb2XClZVEj30rMx3u3iI
 uSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726784; x=1719331584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZqLfefuSJqvtpGWlLdOMb144pE69iIqAnMbzj9lfMc=;
 b=YOagtMuLN43NhQ9Ghvr2c9SHPZVlKZCLX9VGFSZBd/6MPMmNYteSxn9oxgLqT15Gn1
 6V9TJQ1yIwTmUVGasNukIZqxKeI/limqRrZK0btDcQQ8c/J5aLYMheGVqgfmXuApS53d
 bsVRlz2jIvxffMjbthK0Kiw8NXGI1qtZj5kO/wT7rRBQsGhYhiCPKewtQHCuT6HcEYMF
 oF93iLGgWRML+qUFQmb1aCap5GA22tVRLHrocJP8rVKSmO7VcOO4EvlO8yLsR0AyXe8a
 MHXMlqN+phjXczUMlhiGo2Zd7GMis82KVMPZcIwuyFUKrJajbO2g4mSP9cS8NxVZHbhH
 4FOA==
X-Gm-Message-State: AOJu0Yyiaw0XlBBcwhspr8oi9pVFuvlANn+mXfAMNGLP5u2WOp8FfYMu
 gV84KQNXLJSAcLLYkQzXtdPnk8o1aK8fmDmIUtUDoRJLkaLgj+42jGt1AvesuzzjQuQV75dnUD8
 0
X-Google-Smtp-Source: AGHT+IHgapr+YfMy+QPjQyO9pyugICHyMldlKkHlmydVjbYGLv4qD8d89FYjEC9W+mfMsrPxEKu/pA==
X-Received: by 2002:a05:6512:3691:b0:52c:8316:d0c9 with SMTP id
 2adb3069b0e04-52ccaa0a1c5mr64321e87.0.1718726783668; 
 Tue, 18 Jun 2024 09:06:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2489sm14358289f8f.69.2024.06.18.09.06.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 59/76] hw/i386/iommu: Constify IOMMUTLBEvent in
 vtd_page_walk_hook prototype
Date: Tue, 18 Jun 2024 18:00:21 +0200
Message-ID: <20240618160039.36108-60-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

@event access is read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240612132532.85928-4-philmd@linaro.org>
---
 hw/i386/intel_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8e59674e..c4350e0ff0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1170,7 +1170,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
     }
 }
 
-typedef int (*vtd_page_walk_hook)(IOMMUTLBEvent *event, void *private);
+typedef int (*vtd_page_walk_hook)(const IOMMUTLBEvent *event, void *private);
 
 /**
  * Constant information used during page walking
@@ -1533,7 +1533,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     return 0;
 }
 
-static int vtd_sync_shadow_page_hook(IOMMUTLBEvent *event,
+static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
                                      void *private)
 {
     memory_region_notify_iommu(private, 0, *event);
@@ -2219,7 +2219,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                  * page tables.  We just deliver the PSI down to
                  * invalidate caches.
                  */
-                IOMMUTLBEvent event = {
+                const IOMMUTLBEvent event = {
                     .type = IOMMU_NOTIFIER_UNMAP,
                     .entry = {
                         .target_as = &address_space_memory,
@@ -3889,7 +3889,7 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s)
     vtd_switch_address_space_all(s);
 }
 
-static int vtd_replay_hook(IOMMUTLBEvent *event, void *private)
+static int vtd_replay_hook(const IOMMUTLBEvent *event, void *private)
 {
     memory_region_notify_iommu_one(private, event);
     return 0;
-- 
2.41.0


