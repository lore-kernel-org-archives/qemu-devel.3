Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24B4CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYO-00063G-Th; Tue, 12 May 2026 02:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXv-0003VO-RE
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXs-0006Wk-KS
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so45850445e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567082; x=1779171882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xmisohfUh01EbvNNSz+FoRzd51EcDKXzYYGKUUEU+RE=;
 b=JS76vRTZo64vqz39hiCCRWsQywBJ8IyJOoFMbNPsXcImFXzrolaVVLqB/fQBUWxEjN
 i2h2mZhKwP7KX8mmdOQ0JFBXHidQnw6XaxgsxRozCNvZYcc4gQgVBAjdpgmQm/LZa3m/
 PBcCMSPuQKK7474nrWScpDfo+tLTexL00mIbGG2LcjfMHD+WKmwB7KbVa7a07YvZYXq4
 jNcgQAA5+osFzeOFiMs5CeCeEKkcU1Up8C7mevHkaJM/72Chp1qvhQPNgGoFcu6eTDFb
 a4SQazJ3IknfCvYUGqjnTFWigZSFFBpqqdzf6+WUzv27ki4qqumbGuVU6QlBQL3ecNsK
 g+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567082; x=1779171882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xmisohfUh01EbvNNSz+FoRzd51EcDKXzYYGKUUEU+RE=;
 b=f74XgK5vd50bl9g6mpmEwAnKnTK79iWmuvTO16RyfqV8r2MXInkmAq1TwjTAm9vXya
 k+5ow3yqrK7Ih6ggDqlY7cG2MRQb5iVs4bKjlUPmS9zZZfTkeQgt8PNOANEciKTOp9Ya
 ElSq6juA/kv7ScHOZksFcWZ9OFp0YLjIMDKaD/c4tgaw9vyYRLVimtA1lKTDTdzJwuTq
 agVufdAIYNzlkI0fvnuBDw7irRuVr+hT+laPQlGxUnoKI9Ek5EiSRXa2ttI5VrEpBjJu
 IZTeTfPD9NHn/bWI+/EGtU1KwhSc87PPhevIu4A16K9WGqBw30zdBgRjvrsHVcWyJ6Xa
 5UCg==
X-Gm-Message-State: AOJu0YwpRU+aiheQrzOg7vguhtUANmTe4q3O+zg5ukqJ2osBQiBn73+I
 PlcMfmSVFh5uY6rF8gQH8dsxsjZECe8hHOPU6E96FQHas0Fru2EW49BytOQ9SQ7PBr7a3semq3p
 dh2OaBrk=
X-Gm-Gg: Acq92OGuVv5n7CzUwqmbA+l25m8qXBVJKwWiXqjSA8qTk6evEDry5hxMPc/9qaibuGy
 se90PBljX/E7FFgxoNPduVcmoyqRDjyOe65lNn1h6vCnPc6p25TZfi6SSlonhzSP19nVXMsgjh+
 AEwDzQ08nGpt+CRr8C5cit6mHa8HdPJPX2sCvn1GDOmksw84Ywh6WnXUho/n9tSd5RZmN3LfBhE
 RyVHy+tdughfWD2xqcDCPlEFNK+Z/OjS8X8UrKPnbGXnuXtIeG9KfGVxKMPpg8D4MqScYHe9o1p
 5HnP/+rp68ImYxjKZdPCwJScCUG/RMzZeuKO1RapQHuUZRHpOV2JfEcfi7nNhpcPIjeqK2eYFHp
 1yzMzNvA9bDkV8eS1CLqlw999gW2d4N4pKZKwUN4+ASqeEthqcrYDHYUy+vaTn6G5s8U8C1Y8mq
 g9vYpHHYlyWO40sCGsJHb4AYrWA0Qe08q/2Kjl6+rB5nyXaY4y8KYdaaXzlA6/15OuI8w8eCj6
X-Received: by 2002:a05:600c:c058:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48e8fe7fa6fmr15451465e9.23.1778567081889; 
 Mon, 11 May 2026 23:24:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9053f690sm24441985e9.7.2026.05.11.23.24.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] hw/core: Implement cpu_get_phys_addr_attrs_debug() with
 cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:26 +0200
Message-ID: <20260512062142.67998-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Implement cpu_get_phys_addr_attrs_debug() with
cpu_translate_for_debug(), so that CPUs can implement only the
translate_for_debug method and have all of the wrapper functions
cpu_translate_for_debug(), cpu_get_phys_addr_attrs_debug() and
cpu_get_phys_addr_debug() work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-17-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-system.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 252e90c8fdf..954b81931d8 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -90,19 +90,14 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
 hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
-    hwaddr paddr;
+    TranslateForDebugResult result;
 
-    if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
-        paddr = cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
-                                                               attrs);
-    } else {
-        /* Fallback for CPUs which don't implement the _attrs_ hook */
-        *attrs = MEMTXATTRS_UNSPECIFIED;
-        paddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
+    if (!cpu_translate_for_debug(cpu, addr, &result)) {
+        return -1;
     }
-    /* Indicate that this is a debug access. */
-    attrs->debug = 1;
-    return paddr;
+
+    *attrs = result.attrs;
+    return result.physaddr;
 }
 
 hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
-- 
2.53.0


