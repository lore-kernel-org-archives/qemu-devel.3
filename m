Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB9ECD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgY8-00047O-IV; Tue, 12 May 2026 02:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXi-0003Ka-GD
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXe-0006Nj-Av
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so4625120f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567067; x=1779171867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=csiRPnZWzJrCYGF97CObJC6aEY5aL83bFmlakWQo47E=;
 b=uyDXzyya5Y5Zf61idYClN8Zo5aXjHo04kLt6g/fg+9R8RRkvZd7xjLWBqhWmbT2Fkn
 jwm9oGaqrxSu8BJ4G/eXDySl146TbZiNQAHe9mQ1dgE+vKacO4GUt7t9FuSXFyHTMTCL
 fK084aSf9GEpTgnlLQh5PPjgAtkQeCcIEQ5hliSgBjhM/POnOyl5dTqJF+1j1YmTu6JV
 2vuEKIqlMVa1yRdHBHIZ4m5haWHSZlo3qztDzquS3gGmeB3MHzMSIJ7o/E1hHAWS+7xe
 sZrgAg61giRIlG3sIpCxsvnDsrn7dBAbS11WAC8N5bzaCQ8V0IdHOTr9+/RD/HHDie52
 uYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567067; x=1779171867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=csiRPnZWzJrCYGF97CObJC6aEY5aL83bFmlakWQo47E=;
 b=ccbnk9XB6s1z3UGdBd4ynIf5/Njk6IXJhMC8a1XIxozbvTvBzv2nB6qjZLpM634fwx
 WsQXW5ZaeSaXuqKyl40t5eAnbHK2TirN1KlprVG3vKg7ZG/nrrhWL3XBta4n9tVywpAg
 twgJz1q9c0VbIT9IyIvXS5Rm992IeXfOw+dDZR0ZdvmEkNlrXIqbQa/NYOcvuahZXLzo
 +g0cOYgPtV+Hjx/JIhSB3WKKqDA7w/zZeHB8ezW+3y3q465CVbalBWXTMLGqk06xSpOZ
 ijvZlOkWklM0Qoa3SL1pSGQPFxv6Ls+VleTOQjKKVm5rnvymT3HvS0UmEo6xebMu06hp
 LdCg==
X-Gm-Message-State: AOJu0Yx0YBMAAIw64vgRMq5n+cuCh2ST3sMb9p15W5BIpg38Xg2xg8Lg
 AQEqGwGOU/cToqT+Hs1LO561YBXmkpd0CRusX6pApX2t4sz3CgDfgvOTQcf1uGVjczbbD+QBGcW
 M/7mTP00=
X-Gm-Gg: Acq92OHOkoQTn1q4tGPanVmwnSx0CfR0PaZaR7hHSpFJr/RCpIrPSu3PEGSb2qx3Oil
 IeI5GGRZ6URV5IfoNqoXT7cALcaexPOwHgX/08q4EGRleLaJZr4SqAoPZpFoZniQuSeEEUSkA4k
 zzSlGlbFqjy4sPRomVHr2oI2E5CGGMhIXsj6teJv/VSlTWcg0XFwheWeYq1rzRTUwc2F5jPnOvc
 +urkmtPTUb7rG+NKN68rfMahIB5NUBKZd8+lq3/ofSPfgT5KJ1jY5qdAOmkeVeQy1ZDqFcSYstb
 oQRQRPg2vm/uphyCPYrbbkRSAwAnzf4XSdR20p5WhMBNNhVbMUGKIAiJdU9Cj2SimUl5xxYo4Ev
 2Pc6aoI6afqImOEb2Fssk9VlQMteEIT0KE3UikinSWFa/deQl56hppi4vUC2xYPNL9VNL6dmkiI
 MxeYSHCyg46PrvLYI31CaIZ5Dk8+mROH/QXA6Cuh+soW9dUSrOeldXwfDpn6q4u0JqmvUjAibrb
 jLzNdP5Z6A=
X-Received: by 2002:a5d:5a0b:0:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-45570bc2220mr17861530f8f.12.1778567067200; 
 Mon, 11 May 2026 23:24:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-458b3664e3esm14754794f8f.3.2026.05.11.23.24.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] plugins/api.c: Trust cpu_get_phys_addr_debug() return
 address
Date: Tue, 12 May 2026 08:21:24 +0200
Message-ID: <20260512062142.67998-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

In qemu_plugin_translate_vaddr() we have a workaround for not all
implementations of get_phys_addr_debug returning an exact physaddr
for the input virtual address: we OR back in the page offset to the
return value.

Now that we guarantee that get_phys_addr_debug returns the exact
physaddr for the input virtual address, we can drop this workaround.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-14-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-15-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 4b6fad49998..c97cc688825 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -625,7 +625,7 @@ bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
         return false;
     }
 
-    *hwaddr = res | (vaddr & ~TARGET_PAGE_MASK);
+    *hwaddr = res;
 
     return true;
 #else
-- 
2.53.0


