Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFCC109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mkz-000127-1Z; Thu, 19 Mar 2026 19:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mky-00011e-48
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkw-0007iD-N5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b0586d5bb8so9094925ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962781; x=1774567581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+0x6O4gZwnc0GCjlyoKzmEsRAKxwFxCRzvQROS36aQ=;
 b=c7EXkeI5BVTz4/L3X15k9vF/ww2ZnLJ9jDtfUCscXdqRFNmepYUWf45Be8clnydAt6
 dFtPnSa/Y21EYuSAblyMQ0au7bnptAiz1ZeLbT/qkmFYl7RtktLXW4zMyg9/PKDJfbFE
 28laITUy+v+cYKApUmynJ8vf2tO0UIsBxCzQsro40S4YCLe2PCMg7fZbW6PivHrwD2Xi
 lPnzBgGpc8i3lf1vTzJujk5mIgY0xcU7/eEYP8vSjCmf/53cqxXY2UKlDI+XAh2xEDhA
 BZIGWtgMBMZ8o7l+7KYMzcolAgz3VrsiuFJqiISW41TWCSFcBCH/8MR5oLGq0Z78U1II
 0VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962781; x=1774567581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0+0x6O4gZwnc0GCjlyoKzmEsRAKxwFxCRzvQROS36aQ=;
 b=eZ2XnSK364nAcTatr7WdbFJu8+6sofWktKVfO87SLIiMmdyIZBmANR0L/L1U6ETBmn
 f/2xIyUXf4ysmqz7hVOvoNkcWSHfzMkkgmwGZRhaHiagYmCN5HDuJnpn8zs8JX/WzJdF
 NNij1saNIK/STSJgq4hUNQ/8uESDjZutbizYVZaOYQnfMuTO5Ooqr/PT4uEMUlxzPS5h
 fIHGRPPiDtf2RB7ntbqFFo3+Iv5/SFceIdxXPfdMaMzH4iG8dw1xHZjrBdCHsvAnglxu
 GTtrKneEi0WL3RsEnMMr/NKD7e4Wtxm2ytUwltTzslg7b1yAqzLqLQjPAHgIMXzXovg2
 VbAw==
X-Gm-Message-State: AOJu0YwpVM64IhrWv+YYxs9oZzUIe4MVbm+KBqDFjOhokdpqblWRuQQH
 f7sWLmQOfM8d+ccwttGOojo3861kVKVIeRQZmbyS0XF3hpnzz9przOyodMaA5A==
X-Gm-Gg: ATEYQzznJdo4vo81BKzJzny2RDq4FA1mLArBDkcd/2nZkDfxJ+4lUbkh8QtpwmyjJDx
 iudYhzZDVCpgptxefJ5yve5LMiIsTu3gohOwcqJiSZBoKrhXgzRxTOifpnCxSN2FIzdXcwiuff7
 IRf8kBurdySWOVT5VWKIc4o/7m4ZSORabXLIfQOh6je9RLUsbI5lHSfxuhuWxno414H6MGaLJU7
 t/oDqK/cV8cmHcdiwxd+OEJkEOMAKr71JnnVH6vp455EY4mFeThhOgIQWaY/dilE3EOoqMV/M+e
 jHhX7O9SCJ6rVjEcMX1KxzjUxUwDrUPSRAsWx8Ig0dF1ELxLfzLSxndFx6HB0plZjpi4pvA9DIW
 xzqyRG1SznCtQgO/76ncl0MEZrpvBMRfA+o/w3r0Cxx+9eKwFRmmI4BNkN5KnOwJ7kAftGFyV2T
 JsOlVZl1XmIHju6sjKKZWI0njTZHGQnjnS+vROtDeQDw==
X-Received: by 2002:a17:903:19eb:b0:2ae:aca4:b177 with SMTP id
 d9443c01a7336-2b0826c696bmr8449675ad.5.1773962780832; 
 Thu, 19 Mar 2026 16:26:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/17] hw/char: sifive_uart: Update IRQ when rxctrl is written
Date: Fri, 20 Mar 2026 09:25:18 +1000
Message-ID: <20260319232522.1867400-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

When rxctl is updated, we also need to check whether the IRQ should be
raised, as the user may activate the Rx channel or change the Rx FIFO
watermark level.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260312033201.1619554-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index ae71a15a2a..f255cca960 100644
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
2.53.0


