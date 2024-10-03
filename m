Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7635CF34D5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVUI-0001Pa-0H; Thu, 03 Oct 2024 19:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVUD-0000qm-Jh
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVUB-0004AF-EV
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso14421255e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727999033; x=1728603833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZGu7nup/MOBwt2x+hZAsnAeVSIrLImHXyaQQxWjE7s=;
 b=sQf7EUhX5ddXa8eMxf3nYJzVadNaaE0TBlruAv+FebAaS1iMqaHFqys7s3WbG5bk1p
 TDB12bEiqBCvnnDIxMT2+t6i+swu8Qir30heMDqPui09JnkNLak9VvZYW8McRGBFJjp/
 uWEQEK0nL6p+7tD0KYvy7J2vgWcuB8NVpOUfjh6stUNf+PqQ3IbGaZYr47lG0R/tGW3w
 w7DryKtb7/o270Q36jYGSDk4LG3+J7Vx/YjKra3bVzPtQXhDdp8fxP2sUxQ2O2xMmg69
 GvYLsmAKcK7FBYorzvHkwqRDgFxKBspoMDh4x5TEtCo5M5lU7l86A84nR+Zdm+u3m68r
 ApEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727999033; x=1728603833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZGu7nup/MOBwt2x+hZAsnAeVSIrLImHXyaQQxWjE7s=;
 b=JCEXqEjaWtoHm1YD/jjlgXUrmPEYXXVcX8C3g/dYLsl2iJupVBrqCKxuBwKTSWR1wc
 8Fs4xG3WSqh8QRS5G1fZmBXaLQhsKhvEnD5WAM+hJYU+q9nrJtvsmPlCdwWySz5FGJ6x
 7rSWm2b4Vs1YbDXb+DHcNTcf0Npf/Ql2bSp92/QgbKJN4ulVwqEz68LRDZoEid+cP+qS
 xLCoFXSU7yAycU/SdQh5qzUP+w64n0D2NoG/4rU9yBx7Nbw4HbOIZbvO780onNV9iirx
 tZq8FwaqaIlZJ9Y5CkCrbUjzCZEI0tRhWX+yxGuRvA/g1I8WCFHRsSwD421PciJzAzA7
 4GMA==
X-Gm-Message-State: AOJu0YxizrddrLe9KnkgngA/arU0aP3tiuBY6YAtKK1TWTR6D+e5OrNa
 tUlttd5ayV4+HDGIMG7qaFUS6txrI5gomNDVjiOk4SPmUFew13UgWWxWXhMsSzBGW5Tbymp/usc
 O2NU=
X-Google-Smtp-Source: AGHT+IFNWQPMW+5cp0lVLiIWBgQoN+66Nw63ho4gMVwdf+kbfpZdvUknFN0B6zw6KWFP3BBYPgTAEg==
X-Received: by 2002:a05:600c:350c:b0:42c:b55f:f7c with SMTP id
 5b1f17b1804b1-42f85ab7b35mr3906955e9.15.1727999033469; 
 Thu, 03 Oct 2024 16:43:53 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082a6a2esm2138210f8f.66.2024.10.03.16.43.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:43:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/16] target/sparc: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:07 +0200
Message-ID: <20241003234211.53644-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SPARC architecture uses big endianness. Directly use
the big-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ec0036e9ef6..da72a7d3f69 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -110,7 +110,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #if defined(TARGET_ABI32)
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 #else
     target_ulong tmp;
 
@@ -165,7 +165,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #else
     else if (n < 64) {
         /* f0-f31 */
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_be_p(mem_buf);
         if (n & 1) {
             env->fpr[(n - 32) / 2].l.lower = tmp;
         } else {
-- 
2.45.2


