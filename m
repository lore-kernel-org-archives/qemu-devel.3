Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C11CCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1i-0005nU-IW; Wed, 10 Apr 2024 05:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1h-0005nM-Rw
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:53 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1g-0005ZW-8K
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:53 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a5200afe39eso147156766b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740430; x=1713345230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KsSirCZg01hhKd4JAUXgq8lzzdN/Hb2WqmF/tsoo34=;
 b=g8dVZt2nAQq1yN7yU8j0Srki/Lh3hrZSTekEbT44PdmZOjvmTwTPzIrrI8jPKAwM3P
 1E9XnUuM7ihPEJuhcPM36Nu7Ql23WtcLMb1bWxI+YfTM1rWMZ85AB3AIZ0M6OKT3cRB1
 IuL8IcUjHLAzap//pBU9JiJEg9vnHAtFFi1Y7VoltyR+aOW85kvEwSG0xqdOBxhw3l23
 lycq5KBPD/UblaUqClZGL5yuYkWlBNwXYQBVW3DzqbTWGF2ZajuUPiy72//H/Nw84sVq
 bWcX+7mg/vL5F61uFfe+IC5BcVmJ/HVS1hqGW/ovfrC0o3LlYpjKoVy6qsC5+ASkgQKA
 Y72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740430; x=1713345230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KsSirCZg01hhKd4JAUXgq8lzzdN/Hb2WqmF/tsoo34=;
 b=qtJf/QX/KI9OArmVOUcLT698jeNFJCACydIXbw8Wa9QnG0OQaxn2H3lHdg0/KpgbL4
 ZuIPgMYxa0zbRHvuY5p1b9XUYZKP3/NaED8Gaa2hX23r7susTy0bNar1SYVE3yc1ATes
 EHKVS9N3sIJZo26QQ/MAgWCfGvrq1VwnODiPTfv3bBT050Jw7Gb+vLGk/7U+5o8DkJz6
 tGiUwd6jaP6jdRVzVsFc2TxhycaElGNNH0HDHZ7IyDDjZLZUAcImUUvjB3qlpKKMQrUF
 g4ONneXFjn37Bib/m3KzswFPYffM5zq6bGjrYieXpPynp7qTOE+9eWzl2x1DR5FvC/ZA
 XKyQ==
X-Gm-Message-State: AOJu0YxivZ7gM1xXxJUPT678pqir3xQ0P7zH8KnjUdCrTrCglBwYA1WC
 FtEq+yFdsAxoGJShd0co43cOgMQrWgMxGrlRkicPvrf7gy0ZV7NDNmhNYL104O1l9ibNJAlP/7O
 Y
X-Google-Smtp-Source: AGHT+IGfbrGv2eRQo22z+re7ozKJqKSBXnJkE8EPhHfBWLFhkVQ6x3/4nVassDnuBA0bYsdMW4tmIg==
X-Received: by 2002:a17:906:f116:b0:a52:10dc:4ca8 with SMTP id
 gv22-20020a170906f11600b00a5210dc4ca8mr782642ejb.72.1712740430220; 
 Wed, 10 Apr 2024 02:13:50 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 hd19-20020a170907969300b00a51bd3b432fsm5302611ejc.115.2024.04.10.02.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/16] qemu-options: Fix CXL Fixed Memory Window
 interleave-granularity typo
Date: Wed, 10 Apr 2024 11:13:04 +0200
Message-ID: <20240410091315.57241-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Fix the unit typo of interleave-granularity of CXL Fixed Memory
Window in qemu-option.hx.

Fixes: 03b39fcf64 ("hw/cxl: Make the CFMW a machine parameter.")
Signed-off-by: Yuquan Wang wangyuquan1236@phytium.com.cn
Message-ID: <20240407083539.1488172-2-wangyuquan1236@phytium.com.cn>
[PMD: Reworded]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-options.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7fd1713fa8..8ce85d4559 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -151,14 +151,14 @@ SRST
         platform and configuration dependent.
 
         ``interleave-granularity=granularity`` sets the granularity of
-        interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
-        4096KiB, 8192KiB and 16384KiB granularities supported.
+        interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
+        4k, 8k and 16k granularities supported.
 
         Example:
 
         ::
 
-            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
+            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.41.0


