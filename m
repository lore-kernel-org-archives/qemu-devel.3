Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B451CCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNb-000139-DH; Thu, 09 Oct 2025 11:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNX-00012o-Pg
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNR-00012S-MA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so12177605e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022974; x=1760627774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99wP1GCXE6k+TUtubvwH3eeZDturgfhg3YA/n7Fnf9U=;
 b=ZmkV3iOOfhOk5Sh5Yqrspvj+s95LVT3TczsPnznQhW1EFOdWBI8L8lW4ZujHcWcYG0
 6LoiRM8dgfg+NP5KWnCv6I/1qXjS+x5XnnBqcEwpGVo4Gn3mEMPb3AdnVwdjfsv4Ph8w
 JNqJ4sVClmroO+4ifNCoKL4o8pchrKu6YrlR8VI4L7bfc5FVv0xP4TL+XuFlrOM4nrp7
 6b/UiLBG23DDQIP/jAnyp1X5THEh5a/GtcQkikjByLknHfpL8Oa7uf6ak5Yn4coH6VL7
 dH5iH/PDrCdTlyvHCyJxQyGoLkKh1/Ie90qhtHhkZmgoXOLKOEt99tIYzgAyadBh45dR
 IBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022974; x=1760627774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99wP1GCXE6k+TUtubvwH3eeZDturgfhg3YA/n7Fnf9U=;
 b=sXFZZl3hg3uDcMSeYpr+jnHh9XxMf3cVFUF9zOSvGgDsQv7SK4evvFEVcW7leCALpO
 0tOkz23k/BJ76HOSQKqX+e5J/PPQ7SFNyOZcBwSh52pooqdbmGxKXyZTheNgkL7K6BQp
 35ou2YVE4T9IPlIdKXVfKxEytCFAwScY3gTTuz8D1Tk+yPpBJGtPnqA4Xt/V+6HkZsLc
 NWMRlakOXha9QR1ATEx14CcpS3HSXq0yctHmVK3rohH8JRGPaEBJn9cCFCB/x32xLzin
 oBtPkI4/Z379vQIOVIjO/Mf8mHYKD0AejoEQEWLOY7/x3sBxvxXN0oUBe7ZYloYRu2B9
 2fdQ==
X-Gm-Message-State: AOJu0YxLjjt1HrOh1O+Bu7IdDRBYm1ZHAWZ5NzKcK3l/E+cr+QJbUTEo
 U7OO4ZZWkLdgN9SJPx0H+BXj0XMTLFLyF9AWLyZxX5nDCDGIaTzBRSu4ybRw2H3slnufC21v946
 obf6oknrVew==
X-Gm-Gg: ASbGncuZca7fksCYt44jBRpJ7XgYeX0YPHc1CnkuJSu4Hm4i+AcN+gpvK7TfAuXI0N5
 sPvAGA0JhqrNgEd9TfyzZika/yDX/53d9KnEUC/jBazJV92mMEI9DUXHTjbRlF6sA8z5cZFk6ie
 /or0DGi3J4nAKzQ+T8ptWM8lrtmNDEvs1u2PLw64JmfCka92K1novdG5mxCrEU/drVp29qSueAw
 Dlkw8rfZiiYZEsChiGFYGwUu2+OTLNhJY7qdDEH9aLSlXpnp4uvj2Gfl0HAlaFd9LkkuG+2Lc3S
 B0r19NmA/k4VJKp6w/7P5SptwX4NZaHBOttKIp3uGIF7LZfoEEjZIMl/kla3fgKhjhIOKt3KMQP
 o8ddo6FJvzOLYWApNQirOSzBBrkdpKN+R0CqiZ0XJTjLy/UmA9wCuDN463vgqKqMulw/KZNXgo2
 bEIIW/F/I5W/H2QYZD+8nzPMlC
X-Google-Smtp-Source: AGHT+IFNutKQjVeeRRjwuHOy/jaPwY35cMHKM78r8gNHtHNjk/bmUFsA/jw1OsemQ5KJ1w9EYDD2rQ==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e397 with SMTP id
 5b1f17b1804b1-46fb42ee51fmr5439975e9.40.1760022974497; 
 Thu, 09 Oct 2025 08:16:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633badsm40900905e9.3.2025.10.09.08.16.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] target/rx: Replace target_ulong -> vaddr for translator
 API uses
Date: Thu,  9 Oct 2025 17:16:00 +0200
Message-ID: <20251009151607.26278-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Since commit b1c09220b4c ("accel/tcg: Replace target_ulong with
vaddr in translator_*()") the API takes vaddr argument, not
target_ulong. Update the 2 callers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 19a9584a829..c22ca78a055 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -85,7 +85,7 @@ static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
 
 static uint32_t li(DisasContext *ctx, int sz)
 {
-    target_ulong addr;
+    vaddr addr;
     uint32_t tmp;
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
@@ -147,7 +147,7 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(n);
-- 
2.51.0


