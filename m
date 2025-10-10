Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2695BCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DQy-0003pG-VJ; Fri, 10 Oct 2025 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DQt-0003ch-Jt
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:45:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPj-0008JV-C4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:45:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso12417525e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103835; x=1760708635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkc03exu55eBo9yCSXwIrehmGU4C40E+gstJ6ZsPFco=;
 b=ViYQxAlXIuHm+peN7hK2vZC/MQLY3/HG7I1eqO0yvqYFbe8XPmcozGImxLScoZ9ADy
 LaJUPH6Mv4MnuPWw+WZXzJQsEj1y3ucvLUTQoFBTUSjGFtFAkIniQXGx2ZEtsRqKUXjr
 2Ncj3r41G+KecIaAX8ZFMdoXyMb+PdHSX/ufmibc4TMg+PpPER1xNCtkJnToLUMkf0aq
 R+UY47vauQzk9vnJPr+LWPPRG2Z0FRvuiY/aqhQ9feMaeed8XIOBoFgY3GysdCQl5hRA
 JCOJktpe0LTfXACmV5Dx98z2DMCeweV1dJH5bJZyGBLB0qMkbO8vEwNYmdGBSxLhgR/B
 tj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103835; x=1760708635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkc03exu55eBo9yCSXwIrehmGU4C40E+gstJ6ZsPFco=;
 b=ZDtLBzqXNXXNvIU1WU1FOooZGs53hYG3BD2Ehh1uw/1dQ/OqNHxvGAOpXiPPz9VzQY
 vHsROtcOikOMqG92msRPe1hj4ipXxbdhA4VsRKA/hUYxTWxIPSczlM2dAFPoogSJ0UWJ
 /zR8ajKg3yHGC1VdxdLQFvq8Me1g3MIRNUGe28BLROmXDQ6ZT/Ve0j/jqu9zD/YlRd44
 or7lL9BwUTOYob2NDvqGJOfk7G+VWSDksXlM2O9C/GukHZr3Qn/vF2E15yv5U2gihvhJ
 Xz/dxb+dIw0vi5CTfZWq61fctzbnGFsnptMYtF9EgWzeIS9n8W+r8Uju26To4Z2AS7BD
 CPQQ==
X-Gm-Message-State: AOJu0YwO0wl+QKafC9DwncLMniHP0Xp3NXpBiE1Aex+iC3l1LBinSFkP
 Fx1RmWwxNgWO4v9YRWbKfO7VuoelKO7zfH28zL1k5IbaIjZ7SbXXFVVXSQDTChoqRz6Q9cdWlYh
 NNqDY6C8ulw==
X-Gm-Gg: ASbGncvJuZreLI1znG66UI1z9oP+DW7NL36jwTmU/WQJH3J+x+f+aCDWBm8csy/7R7o
 4uGC8eJpzhav6EtLFN6ExvVXSjp5NMc8Cn6rHvHCoh++iIw/Qzq2KNDaJo0LunxA4i8vJ9Q2tRX
 IB9WzYfIn5LyAaPmVZNJg5w7yC3j4JWpQvzK9KAPmHcKmAefzbBbSxrvOvd5iBUzKFzJUnmAnPy
 Ttm1WOKqoDWLGjQQREEuCGHRHGKUMtoyWEjwdgd6L4iaK9ALLHTZNpbCAJvy/xL2tai/rkFoGL5
 hpzwqE5YKmUMePVpAFNNOl4X4RKnFkCXfYCilbAwDLM939a0PWpjZS0XIgUycrgc33AM0AVT4Us
 ZmisqN0rVd73OZXfg/YD2LJ3i0nYAYgtzTK30CJKCgKVIKcaQnVrn1JqqU/uLOxivjhJF44GdkR
 4xMpvciAhdQaGfZKRBdnTXezU/5c1L8w==
X-Google-Smtp-Source: AGHT+IE6LY1k+UfqIuVIOh4wE/dwJvXWsQQBI7D27IlvBg6zUbG4pRugCrmKqq6Tynirh0fqhPm1NQ==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id
 5b1f17b1804b1-46fa9b1b18emr83406515e9.36.1760103835401; 
 Fri, 10 Oct 2025 06:43:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d4bbsm4347777f8f.2.2025.10.10.06.43.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:43:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/16] util/bitmap: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
Date: Fri, 10 Oct 2025 15:42:25 +0200
Message-ID: <20251010134226.72221-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SUSPICIOUS_RECIPS=2.51, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/bitmap.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/util/bitmap.c b/util/bitmap.c
index 8d12e90a5a4..2346159116e 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -421,19 +421,14 @@ static void bitmap_to_from_le(unsigned long *dst,
 {
     long len = BITS_TO_LONGS(nbits);
 
-#if HOST_BIG_ENDIAN
-    long index;
-
-    for (index = 0; index < len; index++) {
-# if HOST_LONG_BITS == 64
-        dst[index] = bswap64(src[index]);
-# else
-        dst[index] = bswap32(src[index]);
-# endif
+    if (HOST_BIG_ENDIAN) {
+        for (long index = 0; index < len; index++) {
+            dst[index] = (HOST_LONG_BITS == 64) ? bswap64(src[index])
+                                                : bswap32(src[index]);
+        }
+    } else {
+        memcpy(dst, src, len * sizeof(unsigned long));
     }
-#else
-    memcpy(dst, src, len * sizeof(unsigned long));
-#endif
 }
 
 void bitmap_from_le(unsigned long *dst, const unsigned long *src,
-- 
2.51.0


