Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D1DFD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdid-0005R2-Hi; Thu, 26 Feb 2026 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdia-0005QS-UK
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:56:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiY-0003oS-SY
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:56:00 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43988056dc3so1040877f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121357; x=1772726157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6AgZw9f+Htkor4ugRgGRf724/uPDwcMahSVEptulgQ=;
 b=ifq6i4F8rU87rrkZVaxlX9oXeasr+Vt8SOVMq6lKGNogyG1eVFuEZYAB7j9V6RrdA1
 T7kRrRV7pOBJRu2uJLnNCWq0cYgIdTnxR8YSqNx1+DlrnpYfr0AFNylzQ6OPDEf4eyQd
 GRxswKIBmkW5yweERcdfmNK4RHI30Bs+jiJ+EZ/a1iSq5TLuHxd7y3iCV+hbiR3F65MT
 S6sOTOcvcG4YJI6td5eO9M+vgVdKeO8mUGZFSrECo0jQHLh8RBe9tZdhXREQMAv/ZxNj
 jhlBNYAS7kPyDxXf/m0/eNeuiGI0QtH/4lgrKkmFXG3I1aSE/l00HCyMT9iG7/batPMP
 Wg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121357; x=1772726157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e6AgZw9f+Htkor4ugRgGRf724/uPDwcMahSVEptulgQ=;
 b=hGOjwOYni5wgLCHABmtY6vhTfnRqMtBktiyoL9TyqVLunuQKuUClMY3X+O7w0XC8fG
 UktRLRVNkDtv04c2irpEqWKhxFCbcYSP/7hLHSA5L5erR6hxbdPgBU4qopqrLG/iZMOi
 bykFhKSSUN1mwdMw5ceKIxjHhVLRuzy2qDq/tv6toBQnUrWVZrTaB5WqXXXCjzvehhhw
 QghOlr5i6BP9bHr6x1dpMdnHvspgrOZvhV0IcnRSNfg/G0eKtMQ1xwIacb/rTDgxTX/N
 zoag308lv9BjBlp+5lA3zbD1KGWuDXtCLpbinHxPXWBkCjQqLKEImbRBgRTwJPBbaISZ
 exoA==
X-Gm-Message-State: AOJu0YyQrQkn87OYQrD3Wl2WKR/OfqYCWf4Jf8A3nPSZO+6Dc6y5QPja
 N6enh/wmQXxBXvffvvEm5UwmEKU/EJR+jtMB652Sypea6LEkyduLnF/ezeDiruMOGinr/RRG0D0
 mN7Ds
X-Gm-Gg: ATEYQzwlLYnIq85mhhyzntNrol4LYaTcZyhmPb59xDSelVPFQBycrVuc44kDLufGYSL
 fMY1sea1gCxUAuwOAtIcQrOv5NASADu6Z+83Xqz5eefYtTeJyecZhj02eVvOR3a3A5M911dCCbf
 bL4a/82yPvis3XqRBKmKXlUlK3DIF+EJ5lgf0TyiyPITf+XOPBhKa4LZi3tZc6R+6S3UN61mjG3
 /L2a0O01yKk7ySSpeiP/Su0Vak07ytEPNawVoAaye/WmoH+t3eSR81nUdxtHgy0Q1kxHC+RGXZU
 HHu2T9zP5JLtckmA9otG1f8PWt6QSOf+eOtd1e9x+ykTeOMaFGQ7tocmo/D4f0+DEwraJG9gWls
 KaoxHruOcNg+zoLjSUAkRMcXY/21Ifdvb2qgTIYAXnL8so3tueHGL/Yhiry/BKBfRmLHLybJ+OT
 /DcjpmYC6xoyDX0T01Nk3EKR6oADh+ipMjJOXz4lDoUVMLbD+64CbMB6xJQn84hB4ryvPHFEFvb
 Wr7Uosznr1p7oHYf+bD920PdESb5Tc=
X-Received: by 2002:a05:6000:230d:b0:439:6f10:fc19 with SMTP id
 ffacd0b85a97d-43997f46457mr5406519f8f.55.1772121356918; 
 Thu, 26 Feb 2026 07:55:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] hw/char/pl011: Only log "data written to disabled UART"
 once
Date: Thu, 26 Feb 2026 15:55:35 +0000
Message-ID: <20260226155535.1171290-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

We log a GUEST_ERROR message "PL011 data written to disabled UART" if
the guest writes data to the TX FIFO when it has not set the enable
bit in the UART.  The idea is to note that the guest has done
something dubious but let it work anyway.  However, since we print
this message for every output character, it floods the logs when
running a guest that does this.

Keep a note of whether we've printed the log message or not, so we
only output it once.  If the guest actively disables the UART, we
re-arm the log message.

Notably, the Linux kernel does not bother to enable the UART if it is
used for earlycon, relying on the firmware having already done that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260210101702.3980804-1-peter.maydell@linaro.org
---
 hw/char/pl011.c         | 24 ++++++++++++++++++++++--
 include/hw/char/pl011.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index b2ca68e3e8..cb12c3e224 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -227,10 +227,25 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
     if (!(s->cr & CR_UARTEN)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "PL011 data written to disabled UART\n");
+        /*
+         * Only log this message once, not every time the guest outputs:
+         * otherwise we would flood the logs with this message, making
+         * harder to debug guests. (Some very popular guests like Linux
+         * don't actively enable the UART.)
+         */
+        if (!s->logged_disabled_uart) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "PL011 data written to disabled UART\n");
+            s->logged_disabled_uart = true;
+        }
     }
     if (!(s->cr & CR_TXE)) {
+        /*
+         * We don't bother with the only-log-once machinery for this check
+         * because TXE is enabled by default from PL011 reset, so there
+         * isn't likely to be existing in-the-wild guest code that trips
+         * over this one.
+         */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "PL011 data written to disabled TX UART\n");
     }
@@ -457,6 +472,10 @@ static void pl011_write(void *opaque, hwaddr offset,
         break;
     case 12: /* UARTCR */
         /* ??? Need to implement the enable bit.  */
+        if ((s->cr ^ value) & CR_UARTEN) {
+            /* Re-arm the log warning when the guest toggles UARTEN */
+            s->logged_disabled_uart = false;
+        }
         s->cr = value;
         pl011_loopback_mdmctrl(s);
         break;
@@ -665,6 +684,7 @@ static void pl011_reset(DeviceState *dev)
     s->ifl = 0x12;
     s->cr = 0x300;
     s->flags = 0;
+    s->logged_disabled_uart = false;
     pl011_reset_rx_fifo(s);
     pl011_reset_tx_fifo(s);
 }
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index ff735b5234..5695787650 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -51,6 +51,7 @@ struct PL011State {
     qemu_irq irq[6];
     Clock *clk;
     bool migrate_clk;
+    bool logged_disabled_uart;
     const unsigned char *id;
     /*
      * Since some users embed this struct directly, we must
-- 
2.43.0


