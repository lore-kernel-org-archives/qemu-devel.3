Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933AED2628D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGgC-0007TA-8l; Tue, 20 Jan 2026 13:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfp-0006vG-1J
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfn-0006Zu-FU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso9837045e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934510; x=1769539310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uCSk1DF6Mp1gbYlF8coioEniIIt1yf0zOgnDdIi+mDU=;
 b=Qn5g07m9ViwDca5zkXSnT25Kv3pJuK8SqlofzLe0oJuD7Nb6ipPkaavZKNZHXgcKyh
 /5sxsEf3/gSdQoV7aV/QSQMJV5E4WBci64P9dBT9PajidpbrELBPIvAdJAoyQme2OfJp
 Sz4BKB/qKFmcmo0WudHp3Fzso2CeMZ8IHRNsi1zt46xcZKDGwI4DsO+E4iDQXebg2Hji
 /dVqeuaTAsKW5j6ougdK/Lik5fApTnphcwID/oVuo5YICMhaDTIo5fEZygOHMJPOU7LI
 7iLat2SmM7jOo3z7DAS9wo3UaqeXM4gTI2NV6YVv88qAyZAZfPxaDd2WLMpumgTTNpUf
 gI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934510; x=1769539310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uCSk1DF6Mp1gbYlF8coioEniIIt1yf0zOgnDdIi+mDU=;
 b=VBnn8Fc9XGScPrezFXYs+i9iSIRtQqUrG4mGZQcs+1s38mC4voaRvCrkxfu5cU5O6/
 Cyp47usJ17/bHjazBeAKucqU+YysqCLZeooKCwt0ZA0BR8Ob+9YSR6tztrjXb6McGbes
 VSc9F2zQFtXz0pLe4Aia8dwjQnCHkgiMY7s5qMVviwQzaxtkA1EonF2rdLHiVQ6EEnFy
 l/18cFNypjVNbdk4XSrqFjefxc/6ylJKLSwD7/o56GL/5FW80/ZxQUCZjKpUm9+Mme+D
 2290prVQBcuKRupsS+7vOF26VbAKLOja8VoB/7ic4vQ0+reqCJraLdU/89aZQxOOcEg7
 dxEg==
X-Gm-Message-State: AOJu0Yy4eBfrtcFOp1EjiK2ZgmvqtKASIPOWPHEg1/YYF7zx3qPbY97x
 VaaevJa156A//gFUd/2JmTd6H1HNYBpntUBLJal6LDxhe9EUHjbx17bS+Hk8b6x6CC3hwZ+n1kv
 ZdqSpH6U=
X-Gm-Gg: AY/fxX6XzyJYAKZwc3dHvxtdp+R1nxR+R0MK0vHKS5Lmhmywai78Ya0ZseMSk9V6YDN
 zmyKwN1Rp/xrmvgX7ysM+TOBi4u8PGsOiEGu39RuJ5JSIg40gPNwKWBMWrNRbBxlTIGJwZz1zn7
 8ZtTQNFOptKjONxVL03zYQ0DHQ658Ji8r1PmRcG6iLK+3A3Kqx8+//uudnuGUsCmyHyItxxYGP1
 oI91JXmo9v4tcsI2ZZmHKcVnbOcSoua8g3cGyEoScNIMVIuaAPwhxEYp01XML4d3bw1RmPPGIF4
 qQaSXcSDRxQrNv1Lrup76/p7tFR9IQRXwcSFq5rV5TEz0KvWudaQUIv/EYE7a5W/M4ppgRunMnT
 a/APv6IMI+6E7bKRHNB2B8Ie4SiNLLSqro/8KEIpG/By3IqucfoWB1dImbH1AeH+WVDUI0EYwof
 s+wd2wU6CqTonwz9TWDHi1X6f+lSBefLMyS5ooZ69mnZTCyBkPEgRMQmn64ntMOsK3c6R/5uM=
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4803e803c1amr44675355e9.36.1768934509643; 
 Tue, 20 Jan 2026 10:41:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480424a37dasm1252525e9.2.2026.01.20.10.41.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/29] hw/loader: Use g_autofree in unpack_efi_zboot_image()
Date: Tue, 20 Jan 2026 19:38:57 +0100
Message-ID: <20260120183902.73845-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Message-ID: <20251124123521.1058183-4-daan.j.demeyer@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 21204a0cb91..4952443fe5d 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -898,7 +898,7 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
     const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     const struct linux_efi_zboot_header *header;
-    uint8_t *data = NULL;
+    g_autofree uint8_t *data = NULL;
     ssize_t ploff, plsize;
     ssize_t bytes;
 
@@ -936,12 +936,11 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
     bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
     if (bytes < 0) {
         fprintf(stderr, "failed to decompress EFI zboot image\n");
-        g_free(data);
         return -1;
     }
 
     g_free(*buffer);
-    *buffer = g_realloc(data, bytes);
+    *buffer = g_realloc(g_steal_pointer(&data), bytes);
     *size = bytes;
     return bytes;
 }
-- 
2.52.0


