Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C62CE8E7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRY-0007CS-2H; Thu, 24 Oct 2024 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRK-00079O-4O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:53 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRI-0003xP-JE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:49 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so1719229e87.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778627; x=1730383427; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+f2xVZQLPWqFbFB+BWu+Obk2BX5gjbKzI8BtdihEOhw=;
 b=x757YAgWhbgySev7v88ehyBUJcBK9gMUzbg7l129YYQaw8E51akmR11EYuu1pPtLhL
 G8ABzozRA3WPB3hFEgL0QNtTF+FdhWYh0aZsqJzhWMfyZD6HO1YfyBviCmwaSVsTDFjB
 9w1rZe3qOmVuV1D7rrB2O9+uIjlRae/KkPeOZ3x7P/rx+z9uAXeoRjFAw/vLzW6UxCW+
 nMlicj3kY92c5oFKlcWUUOr616inv1XKu1cUZyUjvh0CwbBqQpxfRJYm2BuOYPjpYGCS
 U9tybzEXCbltR+a10/6e4CFDBgYF9xDNnCbfqRLQjCa++0VsGXboynsFZOqJyRyT21Kq
 KQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778627; x=1730383427;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+f2xVZQLPWqFbFB+BWu+Obk2BX5gjbKzI8BtdihEOhw=;
 b=BS96wOYMrwXntGNHMrq2EeioxCeUWTtNGR86CBIqcLTT9chTaE5+mxDEERx8413Jkh
 RCecjqHQPFIPwsgv1+6a5inpTNYImjb4jEkp6Vo4mf5CzNGzFMz0a7uk5dTWTQrIX7wn
 uRYmiBFzsZnRcHIOy4oagLZRFTFWmXF45ELm+ujiB/bI4uwl5G+QHXD87Pj+904aPQ81
 gys1yiV0tQi0B4UIZiZxslsXDQFKFdLfQ1TlzlHVMB9yGWbHehoCeoCljUrKEdGhp7PX
 xZZ3TopjoyfSLoIe5p7MQifWtyoPw/doz9LdvKBMGIsGm0/jzRFsGn5gilF59fhE5Q+I
 IS4w==
X-Gm-Message-State: AOJu0YxahGxMAPHLSaoS3otJnB3b5lOUQD23UzV4ughcuZxU6+FTxWBu
 keLuyWy7XTjx0Mz627c/i1tj46/eSaM4KzS0FhKC+INKVreBPdrkj5qsJZgG3H8=
X-Google-Smtp-Source: AGHT+IFNTpaW98rOnxMm3Y8ZLBNHbKqK4YnC2gjjC0lC3jKFXMUfWGFAHXaNRPhkcGtxIe0uKymlZA==
X-Received: by 2002:ac2:4f06:0:b0:53b:2105:18bb with SMTP id
 2adb3069b0e04-53b21051ad7mr3631272e87.51.1729778626320; 
 Thu, 24 Oct 2024 07:03:46 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:46 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:06 +0300
Subject: [PATCH 08/11] rust/pl011: remove commented out C code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-8-051e7a25b978@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=BgYU2Od7c4AJykhXahujBUfmPiu+WkyIxURQdVBKM9o=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9qRHdJNXlTUzlzK2RlZmF3MktMbzRJOG9uCkZvVExPM3FtMGcwUnVWZStL
 RHlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG93QUt
 DUkIzS2Nkd2YzNEowSUMvRC8wVXdGNFFPZEZPZzBLY0tkeTFmU083TGZFYXBqR2RXZ1Bsa0VEcw
 pBZ2FvdFBVZGVaTkpHMk15eDJ4dndHbDZoeWlzaGlYeHltRy9LZGo3dmtRNC81MkRCYlhUUjhWb
 TdlYkc0UE4xCnZyNExuRlhyL1lqSncvcDdoM0tLWjhUN1BGT3M3NzU1QnpjcDVGNitzWk1HdlZQ
 ZjN0QlpDbGFqR043cUhFdjkKK3pmN2ttSnZ2ckduZ2hvZlFRYWhBRjN5dHh1TGZ3bG1xWGlZUGl
 6c3ZIOU1MMmF6Sy9nUGg5bkxCeUtrQlNUNwpMK2NTVTZlUVA3K1RZUEJFVXdvb2dqT0JsSnE0RX
 dnYmt1aE1iaFkzYXpyQU9TeVB3Z1FDT05YMVdJYTE0Ny9XClo1Y1ByaldidDYzVkUxdEw3RXZkU
 2JLYWpKS2xrUnRzaTBhSlFpeDg4UzZDYjJIR3JFZ2ZwQThKWmZiWWI1MXQKU3dMaFRQVGVpbjVS
 bXl2c2xLU3RjMWhyMTVpZHFQTTIzVXVqNno4K3RlenNuVzlMZEkrbHg1VVpFQmtobUlGZwp0WXN
 2R3VhNnpzWUVKRHFKYmtLUkNNQ3N6N0M3UE9VSkdQRWFNcG9GckVrc0RrdTljQ2F2SHcxQld4Un
 ZFVG1NCjhPcnVlWndWd0VNdjBlOWZYUlA3TzFJc2R5QmJsZ3F5VnhqM0dvQ3hyVEJ3ME1CYnlZU
 nVlZmMwSHc0QzROMHEKbTYxaitNeEJaVndEanNhblA4M1F3WlUzZG5wZFVqWUM3MjFBeXYrcitT
 N28xL2NnYlVUd3p3a0tPbDFPQzdTZApwd1VwcEtPWldaMnRTU0pXbGd2ZzJRbmRkSm9icHJjNjI
 5M3NOQUtKZ3hOamd6aWJVTnZuTmZTNnEwSHlpSWt1CjRWbnl1UT09Cj0rVS9jCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12e.google.com
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

This code juxtaposed what should be happening according to the C device
model but is not needed now that this has been reviewed (I hope) and its
validity checked against what the C device does (I hope, again).

No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 75399fa6352916fa9cc24164af0ea2e20fe29399..cf1964fecdfd6d9dae3378890aa8b515a1ddc036 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -347,7 +347,6 @@ pub fn read(
                 0
             }
             Ok(DR) => {
-                // s->flags &= ~PL011_FLAG_RXFF;
                 self.flags.set_receive_fifo_full(false);
                 let c = self.read_fifo[self.read_pos];
                 if self.read_count > 0 {
@@ -355,11 +354,9 @@ pub fn read(
                     self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
                 }
                 if self.read_count == 0 {
-                    // self.flags |= PL011_FLAG_RXFE;
                     self.flags.set_receive_fifo_empty(true);
                 }
                 if self.read_count + 1 == self.read_trigger {
-                    //self.int_level &= ~ INT_RX;
                     self.int_level &= !registers::INT_RX;
                 }
                 // Update error bits.
@@ -529,13 +526,6 @@ fn loopback_mdmctrl(&mut self) {
          * dealt with here.
          */
 
-        //fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
-        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
-        //fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
-        //fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
-        //fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
-        //fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
-        //
         self.flags.set_ring_indicator(self.control.out_2());
         self.flags.set_data_carrier_detect(self.control.out_1());
         self.flags.set_clear_to_send(self.control.request_to_send());
@@ -546,10 +536,6 @@ fn loopback_mdmctrl(&mut self) {
         let mut il = self.int_level;
 
         il &= !Interrupt::MS;
-        //il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
-        //il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
-        //il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
-        //il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
 
         if self.flags.data_set_ready() {
             il |= Interrupt::DSR as u32;
@@ -622,10 +608,8 @@ pub fn put_fifo(&mut self, value: c_uint) {
         let slot = (self.read_pos + self.read_count) & (depth - 1);
         self.read_fifo[slot] = value;
         self.read_count += 1;
-        // s->flags &= ~PL011_FLAG_RXFE;
         self.flags.set_receive_fifo_empty(false);
         if self.read_count == depth {
-            //s->flags |= PL011_FLAG_RXFF;
             self.flags.set_receive_fifo_full(true);
         }
 

-- 
2.45.2


