Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F11ACD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuJ-00082q-JG; Wed, 06 May 2026 10:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctU-00066q-Vg
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctS-0001ne-AW
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so61636285e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076387; x=1778681187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2EaMnP2+uXFrom5NkOg4tiM6HPN2Cv1EUyzsXJZXsUs=;
 b=AV2HG9M78VqssaeQQgKxBYxpmyX0KTeAyhzYx0vcikLIxMB+zaSiXjrfx6F/LX8/k1
 LYSq23mxfGjDOXa29dQ+oLvYu4u1iBbElhTT11S9Wt32rNjveDipfUdPL79Rv4sLxekW
 7K4FWy4lhGAc07yX7CeBuH7QnkpLFMDrC1zsW5/S71JAKI7dRtl3LGOeRoO3d6bsc72T
 lCMZvGmp2bvCOoyIH8xYqBwOgQeRk1bUrsod8UcrXpy4Gc90Gb4TcDse7yn5Xd7fBNtq
 cmOSLw5Hrn+9IZHLN1pZg+9ZhZztunhW+Bc5OOxWftNebllwpEl4MSqfVBZh9L/v9fZS
 fowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076387; x=1778681187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2EaMnP2+uXFrom5NkOg4tiM6HPN2Cv1EUyzsXJZXsUs=;
 b=tCp2ShHaIFJEBdMLmsB6jWZu4Nde5tQVIDhBxRNDC9XYh6ToUy/g2SDXKsw7WW57Tr
 7QfO6/od/dJ7epcK6Z8uJrGw67g8tQBM/OBYaYU7OzO+E5ayMIYbRmVreEVGxEMmbxMl
 d98dPdUJnZj/fdSY8ql8ZdfIEuLmCFpaOcOtWWplIVv57LoiF/4qIkdrBlplaD9NW1w/
 0agd0sTRx73XzquA6kZe4EH1U3Ujmf8WYJVg6gpflmKxB/TiQROtSFuvpOZjQVcUYwJ2
 C6EgiTnkm88iJr7K3AcVFIh8HYoeg5QTVsPu9rLfHzOqN1vremUp+mAeU009neFpUKw4
 lV8g==
X-Gm-Message-State: AOJu0Yw2gd6WPO8nK0wLpCiMLaahcSF0HxTsZcvysvdL+/RAed9rBpqz
 RZ2zwC1ZmklwT/wCi9cB/i4fqfU4wA5sIsr4PNEEIhyBSMT2QVnh4U4IhIRHLwR+d2oBaU+sCLL
 z7NHuBHE=
X-Gm-Gg: AeBDievJyMe9Kv1MQbvZvykC8WidXoDjAGBcqDMsl4Nr6HG8y3ZWqvZBuvb9eRvayP+
 dJlx7W2ZVXiYe4f3UA+NL5x237vXkuwkJ2U8JFZbiZ9cO/hglWUMUlHXDCcjguY04e6mPgWUhYI
 ICW5r68EAcPvOqexDtHspw38zJUC3IhMAYZsCNa+wv+x1f4euQWSYz492D7WTcCCXWCoBmz7A6A
 ErCTkGLHr4+j1v9uFDuKjrS/6GzouJfM3fxUYfnQlq9TJeR97ygqQ60wsHE+g0QUqJNtrko5MEx
 bjVdtiaIr3Qeb2L6DWCG78ztUfcdPbCPExJqlIxNv2rGaTfjkvKBkvz3uFyjIHkEufZlnD2OM/3
 okDqYQV5pqG8uHfruzexAvrybE67tZrq0myjwp01K5XZ3vnHt/yFciAenUJUdNhKSDFsbY+xGMn
 tVEItwaeKztQ8vmmLxjTy748Di17udBKrzyZ6XFtv7I8CD5YP2Yg7i1OUWIQG0N5UU9Cr83x0E6
 5dL5ezUZbs=
X-Received: by 2002:a05:600c:1d18:b0:48a:8cb6:88b9 with SMTP id
 5b1f17b1804b1-48e51f44621mr62106925e9.22.1778076387447; 
 Wed, 06 May 2026 07:06:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5311f891sm28758155e9.4.2026.05.06.07.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 084/110] target/microblaze: Compile helper.c as common unit
Date: Wed,  6 May 2026 15:54:56 +0200
Message-ID: <20260506135524.20617-85-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Nothing in helper.c prevents it to be built as common unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-6-philmd@linaro.org>
---
 target/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 7f7d27d4efa..94c76de39bd 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -3,13 +3,13 @@ gen = decodetree.process('insns.decode')
 microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(files(
   'gdbstub.c',
+  'helper.c',
 ))
 
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
-  'helper.c',
   'op_helper.c',
   'translate.c',
 ))
-- 
2.53.0


