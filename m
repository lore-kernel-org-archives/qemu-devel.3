Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B53E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlNx-0005yJ-F1; Fri, 03 Jan 2025 12:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNw-0005y2-Nd
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:22:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNv-0001O0-As
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:22:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso113491565e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924973; x=1736529773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlVN5y46CcSMejJupZx1BQuV3ovHng+r81SDig0PPcM=;
 b=jiuSRzv3/Ybkng7ShWDIxVHxVDec7am9puq2WV7jiWjRlEjiEt2MOiF3EntvFX4iBF
 HzRGmcJfNhouWkW86bK27Nli1C8VZ1zwqfDRZMsCisfxx2F7SHGYz8zRvytJapwDqVjN
 /wobjwedwQ2muxpfa9Y0tvPir7EHwCb+73e98+eV4zksQtpCx8p55P7rlbFqYt/abzZg
 Iem83JvGMWvQWTRZ90RjrEnB3oeJksKwe7RjUhTGQ61JoGyajtj1+j19p0cKZwDK5zna
 T9hI2FIjr9rExhBEAfku9JqtMgAkBLwKv7rvrGKjJ313ECVX+xs++GiqSuWJPGaPw8C4
 2ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924973; x=1736529773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GlVN5y46CcSMejJupZx1BQuV3ovHng+r81SDig0PPcM=;
 b=ftJEK9/JX5wLhbwSfb0T6CVQA0SHJ/r9Gxkycc7tgJZHm4GTa19HXoeN2aRvvdf5Ht
 Ilz4q0EinuDHgMNBZUqM+NAEJ3cTCrkA1QAwFpfsVkGt3s35Vv4y/siKqJoM2Z9EfG6S
 TScKqBlB4pQIrK34cIVw34qiRqpPJH588IYgrJG/IfL4WZx5eTZKJV5F0jXnzJ90HlTh
 QHjGZJE2/2HObHth26IN9D0KwkiwedBM/JaqKs2TqIp/EdODhOXRS0Hgm7NChVtyE9ZV
 HamiW+C9/Ux9Cw4a571InCNSFYAj6t0UQpjeXN52U5DlRshz4cZVpaw9pNxpflACuUIO
 jqiQ==
X-Gm-Message-State: AOJu0YyBo45Ak/juPfyHVv4lVqgdfBz0IPXOcLrbQHjZ5vvPixR4l6M1
 pVc+HOsnv8DVSKC521asfWZ+4OUdQEhgSprmetwUqZUCuDr8R+gAtPXvJhNYorbQLp0UY+dZwap
 35z4=
X-Gm-Gg: ASbGnct6DaQs8jYkddNfcX93sbIitExHUUiGxqWmT/prx0iuu3FvzuMdcHUc3QcR/PC
 dhO/QC1xJTDQxJZ5d3zkW3x6BoDYS18SGRthJaa8Z+sx9tqxgWWkT6JWTTa1Fv7YMetZahw1RUS
 B0E/WBkWRVUYApnJSr7fHI70nOmM+sV1I3ylbFFFTZZ4IepjEax/4M9xQ+q/hIc97kg03Ohsysp
 y3K35+20ULFs7VJAaZpL7fBXO91p3WbJwe9UfKtUpdAcorh0KAdViUS54794xr9oj3wCubdnY2q
 6n/0JCshqf0hS9q+6YiiJe+l1bcjs5o=
X-Google-Smtp-Source: AGHT+IGyxVCndHj/pTMGfjvPSV9eCuiFdx3ug/8h2WJ9LNhi+aADdu5rL88R184yUE7q9jIyCyFPdQ==
X-Received: by 2002:a05:600c:154a:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-43668b786bamr376435975e9.25.1735924973185; 
 Fri, 03 Jan 2025 09:22:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c508sm488947785e9.33.2025.01.03.09.22.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:22:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 2/4] tests/qtest/boot-serial-test: Reduce for() loop in
 PL011 tests
Date: Fri,  3 Jan 2025 18:22:37 +0100
Message-ID: <20250103172239.18562-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103172239.18562-1-philmd@linaro.org>
References: <20250103172239.18562-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since registers are not modified, we don't need
to refill their values. Directly jump to the previous
store instruction to keep filling the TXDAT register.

The equivalent C code remains:

  while (true) {
      *UART_DATA = 'T';
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/boot-serial-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index a71d2857807..553575ca75c 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,18 +70,18 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /* loop:  ldr     r3, [pc, #8]   Get &UART0 */
+    0x08, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
     0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
-    0x00, 0x20, 0xc3, 0xe5,                 /*        strb    r2, [r3]       *TXDAT = 'T' */
-    0xfb, 0xff, 0xff, 0xea,                 /*        b       -12            (loop) */
+    0x00, 0x20, 0xc3, 0xe5,                 /* loop:  strb    r2, [r3]       *TXDAT = 'T' */
+    0xff, 0xff, 0xff, 0xea,                 /*        b       -4             (loop) */
     0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /* loop:  mov    w1, #'T' */
+    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
-    0x41, 0x00, 0x00, 0x39,                 /*        strb   w1, [x2]        *TXDAT = 'T' */
-    0xfd, 0xff, 0xff, 0x17,                 /*        b      -12             (loop) */
+    0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
+    0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */
 };
 
 static const uint8_t kernel_nrf51[] = {
-- 
2.47.1


