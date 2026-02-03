Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0459E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHxe-0000RX-Sr; Tue, 03 Feb 2026 10:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxY-0000R6-Qg
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:04:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxV-0001MN-Vz
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:04:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso58683825e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131092; x=1770735892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zthk00SxucuQ1CzIK19t8pUtXPzN0T7bbc2k/4jU/C0=;
 b=WvWYquT412iKlpcnICLD+y468G0ODouK2X/pRADNWxG/dE1dxCNhB9M9L7SW57ySib
 t3qAdgSJeE2QFooVtj+X570dKXtvCf/MqaSet0JQ80uDWxcEM6bRO5ikpuDvy5G2H/fg
 DWoCIt6X8rrOXVT/g5l8184zRLkJGZfkzfkXXIN7xs469LBn5S9avxGUgoCPG8kcKIYI
 5aDVHbXyqKotrojfQtlRJy6/hVlGiMs+b6SLi0jC7vZD0KNIyanxdVMSVgoL99RJbpiA
 TIArwcYMlHPA7V+uRRLaPU6+56Ox6IVjEP8r1UwQIJTBtKOk/AUPx3Rlg5jSqJn0UdJV
 SF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131092; x=1770735892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zthk00SxucuQ1CzIK19t8pUtXPzN0T7bbc2k/4jU/C0=;
 b=r9TXCvZ2LDu6WDuGrZ/YrpkJRsHBo8ZmNhVoXFWco74WUKOPUBwKmqDPn20MBUH32g
 ntL4xnZ5nE0JDMzBtRdyKDSzOez5VC0bQBLon33hXAspHhTlPMyNfMrZEGsvgPfqOJZf
 7pmiawqE8DhgYJFEJEhMXPCznPCUbBigVTSeEQbAuihk8jyQKaqCqYdKr7HGSLZ9IH2d
 liHDmQNHCv0bLcPYRJcdEoTOrMSo2xmnEqTqPacqhRTKlGoyeVXxwEF0/GLDSOV88mFU
 EM2m5pHMoVeCKzUJZlv4lQCUnrqTafYULXw8APAR+q9a25bv3FxWkzWkX1V9wlwF6p/l
 0jlg==
X-Gm-Message-State: AOJu0Yzf7yGthm1h3Bt694mwE58O3UYrTNTX5Doo51665a6lLdq42m1n
 gOcbYbJMHZ88uBdUAolC4Cy/sm5gw07dc4sRDLnXp22ySjLrBISq0+e5gEnI2Z/vCqYxoKjktmL
 iI6Ze0wg=
X-Gm-Gg: AZuq6aLsq4nLrrRYEfqrcfWB29bjPSNR3jeB+JDf0na/FjgGO+SrcGeu9u8gJ9esow9
 J3JZx1VQbdB4EysmRyZKIMviwwGzD1RmyLbb/LZPZo5jRVRT521LIOi3N5APzTUitxhadYZ3wi6
 6/zuTqEQGruylQjEgAQtSjClnaWAqa/SqQnG3ofv5u8UV4Sua78sr3GzkA6RO18WbP/rQv3n/4t
 +tLDcKh+vjoVph6bwQ7rztPQvjEp52kstfww/69E9hucUW/vgaKXke5F34EthtePEuZi4dNKDRU
 UuitXDpjrjILGQSAzoCNIaa5hiN20h+vaM7QK12Tp2KjL3wTzmAVbPX11RJMnIZYf4MN4PCWrEp
 bjW3AyvNDYhTzKN8bjChvDtxQRVTOfcySOdyscbmhFzazSrVQ2IQpoKxcsa6cSoUuiivW3m+V/q
 fKF5zW1iPU02waFGqwkZIc86B4f3TP4WMnEA/OgXWYyChgWEC54QU81cXOz0gr
X-Received: by 2002:a05:600c:628d:b0:480:1c75:407c with SMTP id
 5b1f17b1804b1-482db4577f3mr190304705e9.2.1770131091829; 
 Tue, 03 Feb 2026 07:04:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e2e3bf18sm126494805e9.19.2026.02.03.07.04.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:04:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/30] target/ppc: Inline cpu_ldl_data_ra() calls in ICBI
 helpers
Date: Tue,  3 Feb 2026 16:04:07 +0100
Message-ID: <20260203150436.71907-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Inline the cpu_ldl_data_ra() call in preparation of
removing it. Since the returned value is discarded,
don't bother to set the access endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-2-philmd@linaro.org>
---
 target/ppc/mem_helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 7318b02c46a..636ad769a93 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -320,22 +320,27 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
+
     addr &= ~(env->dcache_line_size - 1);
     /*
      * Invalidate one cache line :
      * PowerPC specification says this is to be treated like a load
      * (not a fetch) by the MMU. To be sure it will be so,
-     * do the load "by hand".
+     * do the load "by hand". As the returned data is not consumed,
+     * endianness is irrelevant.
      */
-    cpu_ldl_data_ra(env, addr, GETPC());
+    cpu_ldl_mmu(env, addr, oi, GETPC());
 }
 
 void helper_icbiep(CPUPPCState *env, target_ulong addr)
 {
 #if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
+    cpu_ldl_mmu(env, addr, oi, GETPC());
 #endif
 }
 
-- 
2.52.0


