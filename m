Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A9FCD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTM-0000K9-MK; Wed, 10 Apr 2024 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTD-0000Dp-DC
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaT9-0002cw-Ae
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:42 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a519ef3054bso657564366b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765195; x=1713369995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQdWVo6NuDCj/u3KVg91SVMh7Be4Qk4bewXGZ1yULgw=;
 b=fZwumd9uPxRBgT5GI6xQREaJXs9duP0GHqy/KpNiJsCAqAHkUUbU1Y9QXt1DKcSUJv
 a4W6qpLhLAAUVOi3qVwYtHLLynCcNbTxBLX+u3F5zjbba0V3iIrcvxk0oC6wM8O2Msjh
 22PL4++KX/4tpDsfSb7jvgShDfa9fvfIBtTQO/N0kgmZQZVzZ1DGpvKbEyJqbCpQYLTM
 t+aSa9baqtcS07glHUqC2qLcVi2Kn5wsJ0jwC2EID91L13YqES6vrL/pQCjVKcNPLcgN
 qAhxX9g1fMoOtqcV8Vdj53vCoQCPwfBQVeCprqvaTbecMjJCk6+f7O7b9FrwSazOUyV5
 dtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765195; x=1713369995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQdWVo6NuDCj/u3KVg91SVMh7Be4Qk4bewXGZ1yULgw=;
 b=Hj0dfRlHvzEO54Dpxj1CRa6n1uI0bpoycRmOXiN3B71Q0VK0Tw7cpFhyyM9NktlMPj
 lufR3j6LX+4VgN92V4RB5/rLjnNW5YXHOoB1syWCWFmmPZwAJb9OC5+w+5UHFzwCbEOw
 qqBLv3v+8yRiG7SKd1VER+ak2wDF3qmeu7n/WDuqcwDtaXDxP4/tRawDytERdgEeWY5O
 KxMWKxH2q5q/zInHHuJCk8Dgfv1pV4M5jZ/oeToCUcLDYpoolFQMWyi2onG5IPicjtvP
 +ldogBN272O+bi8GPN0ci9sExgu2s48L46qzOWKN4aOsHjEh9JtDuW/tB0NPpvMgFh8a
 V02A==
X-Gm-Message-State: AOJu0YwH0SVt3FZ6Ouht91mi0ecMjLh2aLy6sqwxORaWawEOHOGXavQ5
 d/zkjyhzsAAftAiP3AD32PI41QETX1sSD2e09iBQO1erfjJ9TbiGwh5VkuvDDjhq1qvo9cx3k1T
 c
X-Google-Smtp-Source: AGHT+IGFvW+9ygHDGnppntWRAUKRZQsvT+L4w8oBZ53XvqPq0W8t3lhhn1JHVX2SJ9DOuOwOetpBcQ==
X-Received: by 2002:a17:907:7ba2:b0:a52:10c4:edf4 with SMTP id
 ne34-20020a1709077ba200b00a5210c4edf4mr1711961ejc.4.1712765195295; 
 Wed, 10 Apr 2024 09:06:35 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 b10-20020a170906194a00b00a51b3c951b6sm6080248eje.191.2024.04.10.09.06.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 03/12] hw/ppc/spapr: Replace sprintf() by g_strdup_printf()
Date: Wed, 10 Apr 2024 18:06:04 +0200
Message-ID: <20240410160614.90627-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Replace sprintf() by g_strdup_printf() in order to avoid:

  hw/ppc/spapr.c:385:5: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
      sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
      ^
  1 warning generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e9bc97fee0..9807f47690 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -375,14 +375,14 @@ static void add_str(GString *s, const gchar *s1)
 static int spapr_dt_memory_node(SpaprMachineState *spapr, void *fdt, int nodeid,
                                 hwaddr start, hwaddr size)
 {
-    char mem_name[32];
+    g_autofree char *mem_name = NULL;
     uint64_t mem_reg_property[2];
     int off;
 
     mem_reg_property[0] = cpu_to_be64(start);
     mem_reg_property[1] = cpu_to_be64(size);
 
-    sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
+    mem_name = g_strdup_printf("memory@%" HWADDR_PRIx, start);
     off = fdt_add_subnode(fdt, 0, mem_name);
     _FDT(off);
     _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
-- 
2.41.0


