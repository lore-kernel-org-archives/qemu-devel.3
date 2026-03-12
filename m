Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CD3FED2C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wmy-0007jj-W9; Wed, 11 Mar 2026 23:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wmg-0007L1-Bw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wme-00067X-RL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so3938675e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 20:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773286343; x=1773891143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1iQco9MhVEGD8RsBT+zhv9hoHQwgfldsI5gxB7iE48=;
 b=WnaHajupk1L6Bq6X4hRp+gMBsViVgPKPFd3gXycJtqrZjNU3IUuvhinnO5+ADijIUk
 Y0f6ljoR8d7XyreJNtVIY+SC8xRw6glCvuYCB2+Lj/KOm3dtHy8xF4EOBLyOeTMnZhF0
 NzHvIRWmQR+yh0N5fzftudv1Q4PQnLQZs2uBL2Ic2Fw0P6n4XkMUkVYPePEwBYoOLrM9
 66rwmWtjlQ26Sm3Ux/R9diaa98g1ufgfqUvx47CVtDp98e4lVIaj96S4PWlLiVcgpgXY
 f2PugdK5r9IewEA14DAQefxz8aSNgwvWEqDQam5A+kGthC4qfgxWlZXKfpXfFCrIV6+c
 3cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773286343; x=1773891143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1iQco9MhVEGD8RsBT+zhv9hoHQwgfldsI5gxB7iE48=;
 b=DSjNMJ2N9F31eV80HGpsDH/1D1uL3iT8cm/v9sOaVI5rrQQEa1FlvZb691uH7EyYfc
 Ma/hYZ6jrMt5y3lmAVRmnZe7kkdvXd9RmxxwFECknE3KJxCgz4pW9rV21L9Cz6PZCgCH
 R1DEiOWnV2lAl3fS1bWaZoEM9oDxp311/RZ5YPrGTubBlG35U9VimPS/mVTEmU5qtmim
 FcggEOOf8yr/mjULLIAnl3fHaKNvWsW/34osREkkmohFeLD6Ordtx2HRMRFoC5StU/Px
 67l0ccIGfXRiQVV4R18S47BJKFN1ur7asvDtYY+7rJmO46mv0JZzLK1wM+X58TEyVpjn
 WFxA==
X-Gm-Message-State: AOJu0YzHmm6jHQiiVDS/iClcs6UPgyFzGFocYUOa7rtLX7I6PW1R9Kp+
 URGLjaS/ZBJ2EWnFjwNo8v1ywVxrAonoqmh/lSh6A35yBpKmmYuJkGTV9lSm3rDtmObvNA6fsmZ
 di98iNVCqMB9UJAQOqZA/l8VX25SMgaO7Hl9/HzSPX5jBWx3eT1coJBb5bC1I3KajbfWhvy7Arn
 zC4noOTVGlVEoTrSAoNNaXupOnS2joYfsZmtoB5fbm+uM5yw==
X-Gm-Gg: ATEYQzxJ9RNdEMo2A2FpM8pSkrbJNgHvrAZ/AqX2xGcXgEFRfqNA49mOxw/akfxZMbd
 n+Za0rZEwCXNj+IdpeFpQWvtx7/4PNSTT0ocx3XIQvrqqI2YFDI8iiNmX9j/fdldl76Wh0hwUyI
 aPNquC8mbfSKYTEH9MoQFHemE1tGIKa2qYGtcjo4UuHrKa132qW38B4amokxPuzBFQDUUeuYEqk
 rS0M36uXeJhTGO+EwllOyzfidNppYr9M428wieqQGdW9JIzwFm0w6VY1c03hNvmuMwpwf0UfDC/
 pGL1WoJBawU7iCltrF39cW4rNIqoJErV0h3m4xUwIErExm7QXTTKWxcj6/Ff8cex6uri1ssYx7h
 okTDpmxxmjpb5uunpPIbWzJD2kRTOs2GnsBJox/oaYaU/N4aUU+9n8mhHQZ7dvFDR/DN8wrt9yS
 /QGw6SBOPP1VAAzPjKzrvORFMO//gcvCCCpZnSHSeJpx61OD/QOA==
X-Received: by 2002:a05:600c:19d4:b0:485:3ae3:b394 with SMTP id
 5b1f17b1804b1-4854b158082mr86503415e9.31.1773286342940; 
 Wed, 11 Mar 2026 20:32:22 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm94807735e9.4.2026.03.11.20.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 20:32:22 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 3/4] hw/char: sifive_uart: Update IRQ when rxctrl is written
Date: Thu, 12 Mar 2026 11:32:00 +0800
Message-ID: <20260312033201.1619554-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312033201.1619554-1-frank.chang@sifive.com>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x335.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When rxctl is updated, we also need to check whether the IRQ should be
raised, as the user may activate the Rx channel or change the Rx FIFO
watermark level.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index ae71a15a2a4..f255cca960d 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -216,6 +216,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
+        sifive_uart_update_irq(s);
         return;
     case SIFIVE_UART_DIV:
         s->div = val64;
-- 
2.43.0


