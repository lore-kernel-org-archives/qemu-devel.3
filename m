Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C86C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8t-0002w4-9O; Mon, 31 Mar 2025 15:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8X-0002QR-7l
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8V-0003Q6-DD
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso31314675e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450569; x=1744055369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLKl/DQ934NXDgHaUVfID1TPnM6HcvqoUZCXZk9DXsw=;
 b=Lb2DmhycIw1arJdgtH1jjHJUPllHppY52Qm69/6nL5AVk26fxZKgjReKiGFWtyKWtm
 4zRKph3qTqwtm5hhzBdNUfI6H+PH5+oMymL2b1AYzpI7Hz7t/V8IP4ykjl4+17cm5kbz
 eZ0LoMDP1nbXRWw322OzWbLAMgF1JibBCmdDSSwfYarwsQcDyLh6ECN3TYoe+DY8cO7e
 +yZ9BBnvyc7y0BX5NAbZFLw+00OCVza5WzMQzGTio0FUFbPk0oQQZc2LrmiTlPRIIp3z
 8K3X3ouabtFN7wAnuDb4F4k/NXRNVrKxfki6yW2qtx07iP9kJ+6OU5YBp+N0gQ/rDgXY
 VZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450569; x=1744055369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLKl/DQ934NXDgHaUVfID1TPnM6HcvqoUZCXZk9DXsw=;
 b=uy8VhTaem3dW2X5OZKZ44W6DG+bQPLdNL1SaQnP9zibyqBaa6xmMstT8UR2cbXqGAb
 J2O6rd2d40wwpJOJyNB0iA6qnNFPzYLiD9uYWnHdHChc2lJSxs8aZ0wOTTGRdFbqE6Ru
 /PqTbQ5Q9YSa4sEkL1H15yfwpwQytLY28JMZjy0oACDJPH8LuMT2NyNQkh1iuNVmIH7K
 gVDeqssd3EC2qgxt1lNv5Vn1PW7tFzMN1QOApjOPnlL5avbRiLfjtxyPSIEfwmh8QHKP
 CthuFTz3qfELKGnz87FN/8xw9Aa9vomVGR+NUefbmov4dU0LaM4czgKZVAUZj1OPYzbC
 N1RQ==
X-Gm-Message-State: AOJu0YxcckZHG1cDeaqdbEWEmK0RNFAVXADuUwmgTyMKl92STfRLxgCO
 f7glcjZjuLhE4H4wwgd+tYWhlBn9KbfecWiHfoN+qRS4xySllA1h7FPxozrxyPR7YdzW0B1z0db
 4
X-Gm-Gg: ASbGncvuNY+MYexUu3ZpnaIafRjtWzYsPBTzIbt8026V4EcDiRpuTWfqLY1Pzn3XOcz
 DkwfZMDusbbcHRAisnNyTib9pwqGIJe4e1VX88poc6JQX/kX7KJzuckt+pDG3+yQTVdvLrR18Kl
 Dss0NUI1fenezpVBsDV7Xdj9cZvw6rR/QqEppUT60B8o3geubRPIXk0BVs0ZyW0iUdmXI37J8/3
 PqcZ6xWt1Z4pVJUYAwDWsf2mL+Q0RQm2ESmkTYvaZMhlk1gUwrMl0r4HnLlbU4U/QdWQdIXbOav
 fqI4bMVK7PwL8dAWRRQcrXEeCgF2XSwlqkYPiATb8on2hpyR/VBJ30ej40FcWjF1Jq8TZ0vm7yi
 2FIOutcO6iilcCX2WIaPSCo46lUdrVw==
X-Google-Smtp-Source: AGHT+IEbLwBNPAU24yEFMIehDIm4aMBSHxKuX9Bha+tzrHrqpE16Mvs5G1nGv0jNAedOKS7XBK2MJg==
X-Received: by 2002:a05:600c:c08:b0:439:8e95:796a with SMTP id
 5b1f17b1804b1-43db62bda6cmr82376705e9.13.1743450568715; 
 Mon, 31 Mar 2025 12:49:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fccfd9bsm132177175e9.20.2025.03.31.12.49.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zheng Huang <hz1624917200@gmail.com>,
 Zheng Huang <hz1624917200@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/23] hw/scsi/lsi53c895a: fix memory leak in lsi_scsi_realize()
Date: Mon, 31 Mar 2025 21:48:11 +0200
Message-ID: <20250331194822.77309-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Zheng Huang <hz1624917200@gmail.com>

Address a memory leak bug in the usages of timer_del().

The issue arises from the incorrect use of the ambiguous timer API
timer_del(), which does not free the timer object. The LeakSanitizer
report this issue during fuzzing. The correct API timer_free() freed
the timer object instead.

=================================================================
==2586273==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x55f2afd89879 in calloc /llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:75:3
    #1 0x7f443b93ac50 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5ec50)
    #2 0x55f2b053962e in timer_new include/qemu/timer.h:542:12
    #3 0x55f2b0514771 in timer_new_us include/qemu/timer.h:582:12
    #4 0x55f2b0514288 in lsi_scsi_realize hw/scsi/lsi53c895a.c:2350:24
    #5 0x55f2b0452d26 in pci_qdev_realize hw/pci/pci.c:2174:9

Signed-off-by: Zheng Huang <hz1624917200@outlook.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <73cd69f9-ff9b-4cd4-b8aa-265f9d6067b9@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/lsi53c895a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d85e384ad63..6689ebba25b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2372,7 +2372,7 @@ static void lsi_scsi_exit(PCIDevice *dev)
     LSIState *s = LSI53C895A(dev);
 
     address_space_destroy(&s->pci_io_as);
-    timer_del(s->scripts_timer);
+    timer_free(s->scripts_timer);
 }
 
 static void lsi_class_init(ObjectClass *klass, void *data)
-- 
2.47.1


