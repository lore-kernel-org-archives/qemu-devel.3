Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846C8C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs51-0003Ww-76; Fri, 19 Jul 2024 14:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4p-0002sW-2a
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4m-0003r6-V5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so10126915e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412687; x=1722017487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMaUbmKJbBglpDupXq1EpryBjAO9Dx7J7NA5WWzmpPw=;
 b=mDIRd1HLnzN3H1mIfCrSmtcXIWAFBcZs1dNcYbTGm9qpPh70h3uuHpZrfyqf4HF96n
 77yS+/N9SGZ0Q36xEyKyDyBXk4slP9R8yN/fhlfiiYFY3AH/XK9xErnVQ8Zm27sgdDCG
 oDARJIq2QiElOoPO/L5cjUW36OcXF0MhUk23kcNqTiwyp8H3D9ZWNbBaq01byIlezkq1
 o4IP8NTnZGHldSduG2tkPnjDfLyyxtHABTEgtVT1nxMVAmPh6ka1MECVHJALQE2+Q9LS
 sf/m6TYvkNAiVOo8OPXRKaQXT18ghcTtrMi7cO7ahCu7SViA1OYhK2hmPHDcCLH8eIbz
 Gj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412687; x=1722017487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMaUbmKJbBglpDupXq1EpryBjAO9Dx7J7NA5WWzmpPw=;
 b=tR/F6M2+OAjpJ7gtHuI2VXKz8JLkm8gl7RibN2wMHZY6I+p7J1cpIYcgi77eDEdJbo
 PE5e8VCUmMDvuYoSzAPMhRZJYtmZTCU//K/+egOVJn99hCCuX5rV8mZ4wQYmO4z5Q+xF
 xe0keaEWat5cWQAeYrAkGaEaaaktIBA6e+xRBhTvn5bmNHSXhg+Vl4+bCwAj7FSjhsnb
 9rOrLuUhCgFWwwM203jRSuNoS8Z4d80yeKgp8VFwNqws6hMDEcghh93dF4656lOA8bEs
 eMc7yczMGgLzEwicEilRd5vIgoPPCa1xXE/xAM/pdOpETEYkEO4MlK8vzr5r/7e7JrAV
 a73w==
X-Gm-Message-State: AOJu0Yy2aV0STi7ZeLw4FVzR0QfsIorXvVsNSpJP0XBtD9GA26pCZeTR
 oowJx9UyYaaZzhALbSUNo45u9mZZIMBIlCCrBmmmiu7qDD+MC2h7AMoWX8aX6H2IdlsO1zCnfxb
 m
X-Google-Smtp-Source: AGHT+IHVhPZBltdNb5U19GKKsLFLqnLr+nLG4pavFd4q5Bf7ToAHBrItgl88M6VjcmZTDPKOzL9Caw==
X-Received: by 2002:adf:a3c8:0:b0:368:4488:66f8 with SMTP id
 ffacd0b85a97d-36873f18f12mr2144385f8f.23.1721412686920; 
 Fri, 19 Jul 2024 11:11:26 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cedabsm2217831f8f.84.2024.07.19.11.11.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 07/16] hw/char/pl011: Extract pl011_read_rxdata() from
 pl011_read()
Date: Fri, 19 Jul 2024 20:10:32 +0200
Message-ID: <20240719181041.49545-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
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

To keep MemoryRegionOps read/write handlers with similar logic,
factor pl011_read_txdata() out of pl011_read(), similar to what
the previous commit did to pl011_write().
No functional change intended.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c2ee9b0321..5e44837206 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -233,31 +233,38 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
     pl011_update(s);
 }
 
+static uint32_t pl011_read_rxdata(PL011State *s)
+{
+    uint32_t c;
+
+    s->flags &= ~PL011_FLAG_RXFF;
+    c = s->read_fifo[s->read_pos];
+    if (s->read_count > 0) {
+        s->read_count--;
+        s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
+    }
+    if (s->read_count == 0) {
+        s->flags |= PL011_FLAG_RXFE;
+    }
+    if (s->read_count == s->read_trigger - 1) {
+        s->int_level &= ~ INT_RX;
+    }
+    trace_pl011_read_fifo(s->read_count);
+    s->rsr = c >> 8;
+    pl011_update(s);
+    qemu_chr_fe_accept_input(&s->chr);
+    return c;
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
     PL011State *s = (PL011State *)opaque;
-    uint32_t c;
     uint64_t r;
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        s->flags &= ~PL011_FLAG_RXFF;
-        c = s->read_fifo[s->read_pos];
-        if (s->read_count > 0) {
-            s->read_count--;
-            s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
-        }
-        if (s->read_count == 0) {
-            s->flags |= PL011_FLAG_RXFE;
-        }
-        if (s->read_count == s->read_trigger - 1)
-            s->int_level &= ~ INT_RX;
-        trace_pl011_read_fifo(s->read_count);
-        s->rsr = c >> 8;
-        pl011_update(s);
-        qemu_chr_fe_accept_input(&s->chr);
-        r = c;
+        r = pl011_read_rxdata(s);
         break;
     case 1: /* UARTRSR */
         r = s->rsr;
-- 
2.41.0


