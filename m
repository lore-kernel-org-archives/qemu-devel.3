Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E074D26284
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfm-0006HR-LL; Tue, 20 Jan 2026 13:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfi-0005ex-Sd
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfg-0006Ye-Vp
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so52446545e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934503; x=1769539303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6gIImb95v7u/uivF2HOogdepgZBf4tY1S5rNqmDkBu4=;
 b=rCX7uMW4r4eQY4Hd99uf3w3Sr5pAzSgrQBILfG1J7dXkHJSiha/pmFiGqy2XxEuRfW
 twt3Cuy60TOS47XOYHwQCiETdSyvMA12YP7TOLL8bPceeEBzKfnIzcOEd442CO2MVIfz
 7Xrw2YwkaH16x2ejQwTDsWcZCyDwJj+qPLAtDAs9YeMuhQ11DrF4M6e9AHcrA47Rvg6x
 +gL63GtLRGQB2tZSsYxwC21K65lmnaZMMCYnNl4sV8mY1twp6z6c/0ExHoH7NKioJ5PO
 Z/p50whBRxOSAi3Z57rcLoDJUoxd7NoPipJFKpB8yNAtgZAA9e9ZxZhcPSot524lPXJo
 TCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934503; x=1769539303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6gIImb95v7u/uivF2HOogdepgZBf4tY1S5rNqmDkBu4=;
 b=eVfHmlcUQcyRpXWSN7UmQoJUhkD1RT6TvPSYja0qpbodd/SDSFDlXczZbSXswoA3ol
 z+T/tX5/uratkHKPSsL+F1veWO8ld8UzI0ibQps52K+isSgtensgdXgPAs0aO7bk4mSJ
 1dhPjDQ5urp3LJaFooIoa5esjDaGwVv0Bari1PrQz3JF1OYcAYB1Am4zTHiTso9FJ1ZE
 u7kXExW57kwdKtjsMLupONA6D/aUGu05VNcGj/NNOnPoy4ebSJRDG1XKOlQCfnDZdfDn
 mi+J3SV5PYmWCfpa6FdmV+LudsAkKcZe3oMBjIulVXHT6EbQJBaijjJ45HZ+x4fAFp3p
 y6Dw==
X-Gm-Message-State: AOJu0YxHTn2lqIDxGps1OaSPesK1tQTD3uuY8Q3pzX4G6uco65Sbqoe/
 WY3hQ4+zg70/W4t/fYrt8QGEkEGBsAi/QFq9xf3BgBeHN2JwLiHU1ChLIqH8vTlYtsJ4TZZ0t8U
 gzf7Pkz8=
X-Gm-Gg: AY/fxX5PxsYM7n9roPNhiBBrmkHr/2P5YQeBRah5tTrhxHPrTql90tFLju7yjw7yixQ
 URCT7o4tUrInbqqZo1kZ9slkaWfp+/dVf+nW73NoaV48OxkZbA1GhsFt9J9K6FeIxDg4t4X/JLT
 /ZYjB5BTPyXBS00k1EyN0/SN1IqBlF4+TgCD/4XHj0jdVa03zoG2UnJZ3Quf4sLYprCPtT1IFb6
 xMHFTW+9yn8m7WEPkKMIWNtOJMihOBDWoVGkHXHavf8KcLHXWjjKt3cmMP78Ngjbq/lId63MkVL
 oEv2o5Ia8LbdgjYZlqb3PwrgsoLgGMZZ2KNY+PBq9R47a1JkT2PxwID8D1E2VMtlPZxlXXm5YGl
 hMy7kh4ITJViRa/MTuwUcteKPSsKPdH43SBNHF02BTtqYml5c1DgSVfA2ZTX/XcNrthjEeuWwxe
 FsEmWzsNCW+eb7FfVvY0cIV1/Uyr5TD2OJn6ptggoZhjaCeafGbey0belvvccF
X-Received: by 2002:a05:600c:3b8e:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-4801e2fe362mr199027425e9.13.1768934503057; 
 Tue, 20 Jan 2026 10:41:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4358f138e26sm5609384f8f.17.2026.01.20.10.41.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] hw/loader: Rename UBOOT_MAX _GUNZIP_BYTES to
 _DECOMPRESSED_BYTES
Date: Tue, 20 Jan 2026 19:38:56 +0100
Message-ID: <20260120183902.73845-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Daan De Meyer <daan.j.demeyer@gmail.com>

For consistency with LOAD_IMAGE_MAX_DECOMPRESSED_BYTES.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251124123521.1058183-3-daan.j.demeyer@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/loader.h | 2 +-
 hw/core/loader-fit.c     | 2 +-
 hw/core/loader.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index 1f14dccbca9..dd22cbb5e85 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -345,7 +345,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex);
 
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
-#define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
+#define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
 
 typedef struct RomGap {
     hwaddr base;
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 233a7f78c24..d29b2ff2231 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -70,7 +70,7 @@ static void *fit_load_image_alloc(const void *itb, const char *name,
     }
 
     if (!strcmp(comp, "gzip")) {
-        uncomp_len = UBOOT_MAX_GUNZIP_BYTES;
+        uncomp_len = UBOOT_MAX_DECOMPRESSED_BYTES;
         uncomp_data = g_malloc(uncomp_len);
 
         uncomp_len = gunzip(uncomp_data, uncomp_len, (void *) data, sz);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 79cb96b4664..21204a0cb91 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -754,7 +754,7 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
         ssize_t bytes;
 
         compressed_data = data;
-        max_bytes = UBOOT_MAX_GUNZIP_BYTES;
+        max_bytes = UBOOT_MAX_DECOMPRESSED_BYTES;
         data = g_malloc(max_bytes);
 
         bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
-- 
2.52.0


