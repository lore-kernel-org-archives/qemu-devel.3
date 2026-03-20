Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807CD10987B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d3w-00060N-Iz; Fri, 20 Mar 2026 12:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3p-0005v7-Uc
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:58 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3m-0001gL-KS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso2121031f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025452; x=1774630252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko/NuQ8s3llnSfwWg8qZEUB+hUDbScGaC6K4YYh0HTI=;
 b=u/E3LWG6w2XxFIA6o4gDIhrwMPuXR4hrbExH1tqNiTsjvr7XJMYF3Oy345Xwmn5TgH
 zTRBdcsuRX9uL+V4vjs1Mqamgz94qkYaWfPL/BSpHHp8JuHEG63SJb3ZqHUynL5AO9dv
 Vk1ul6ygdpEhUzVZXdklcT2lGtGLLcGMlLUHUEq4bao+mqef1p8+SohSTY5sr4g7DoT9
 nCuP40XHWIUwfk5wbafxfWxHLvg3BD+7TDeZxLiZRz/JPeusuWgUixeIuAnmSre1VvwU
 /LRiznvZTrlDnZeqRg7sMc1IGvY0j7LE/1nX25KHujcXRDzU0X3mGppuwFuszIygQTf4
 Rp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025452; x=1774630252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ko/NuQ8s3llnSfwWg8qZEUB+hUDbScGaC6K4YYh0HTI=;
 b=YxCuQQGjoYNfYypXQ69ek4puoRp69v28LkCkGAq26xwAmTvkl5cClkSkXAMI53D7yk
 pCPb0yU2Dc3N6PS6F8wztQjNHbXIdx6kLCCjA30NSRMSQuLc50rnKJld8Nhkqgq9ME5k
 TkYz/PENwOVqZXjZxW+iHxsT9q4ZwwLskQqkTIRdd8VJHqbyyr/WOYh81WIAVuDfSN3c
 iSB2yNRp9cL5C7aE17gCviIeobhswVEonrOmDfNYTKraBjjczBq8auHTMsE0FLKVlvKO
 phn1roZu6kBs18uRjip3V6W0cQSB6K02PBMUUjCxquWiX8wW4V+qBsaSow8zF9qEfM5a
 rF1w==
X-Gm-Message-State: AOJu0YygwpzMbkYKLBirLXCbB4eOXzoVbnvWMq+Wz30KwOxXbxLq+mos
 y7WEuLmT8CydfLCOEXhqk7nfDc4gOyFFpltG8GxFevDz4eaFGXdt3KULOXdCjkx98ql5MRgdh9d
 3X4iOBfM=
X-Gm-Gg: ATEYQzxfHP1WcEskMl3RiEiemkhQrplqgoVOVY798VPZibTKm5nTrE7U/UBL9VgDiXO
 ojiHM4HyCHsK6lpNnKGz3FBScMsVnuN09m+nq6q5+ED0h8oXAxFavr6yoC5HU3oDo4MnX8J9xxf
 33PZoZISSp+3dXsY9QNFdWOKijb9MF/Blk082wvEfYtLrVeXOMZaD2aF1bIMdQiGPMPkiivYKZ/
 WsbZb9uunPzbIX7fcrqP5LEzAC3thFKTkubtPgHrJPqU2WdZRrQLuf1atcBb3Bg8hBMAxjmS0aR
 oTaQR/W1JlafB+tV0+BPvRnhBgfcEkCm2W61UgBOqs7OWFuD3tvzrtx71eFz9XG32db32bDcNwJ
 SNWGY5pHpTdkQXSB7yRwTWzxl46E1IEj5od1xDhHBDQJITFxnc88fWnfMG7I4SX/sQkJGJRW02I
 qJGynyBQqPl3YLJndoymvIoqzoQZUxlh5nj8YqAQnvM/0ijUzHvtsAPyeyLfIMrf3z00yJQdJv
X-Received: by 2002:a05:6000:26cb:b0:439:bb42:dbde with SMTP id
 ffacd0b85a97d-43b6427daf9mr6982391f8f.23.1774025451578; 
 Fri, 20 Mar 2026 09:50:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6471a27csm8215511f8f.36.2026.03.20.09.50.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 4/7] target/xtensa: Display [ID]TLB header within
 dump_tlb()
Date: Fri, 20 Mar 2026 17:50:17 +0100
Message-ID: <20260320165021.39521-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Move common code from caller to callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/mmu_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 9dbf671228b..48e1d64a3d7 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -1091,6 +1091,7 @@ static void dump_tlb(Monitor *mon, CPUXtensaState *env, bool dtlb)
         xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) ?
         mmu_attr_to_access : region_attr_to_access;
 
+    monitor_printf(mon, "\n%cTLB:\n", dtlb ? 'D' : 'I');
     for (wi = 0; wi < conf->nways; ++wi) {
         uint32_t sz = ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
         const char *sz_text;
@@ -1203,10 +1204,7 @@ void dump_mmu(Monitor *mon, CPUXtensaState *env)
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
-
-        monitor_puts(mon, "ITLB:\n");
         dump_tlb(mon, env, false);
-        monitor_puts(mon, "\nDTLB:\n");
         dump_tlb(mon, env, true);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
         monitor_puts(mon, "Foreground map:\n");
-- 
2.53.0


