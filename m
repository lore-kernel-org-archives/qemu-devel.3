Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4A510F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJN-0007zR-4S; Wed, 08 Apr 2026 15:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYGn-0004RJ-4M
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAPnc-0005kD-Fe
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 06:06:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so48359785e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775642774; x=1776247574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEuPWWzhYNRcUX4pgtCbVMTtFv0Mv67NoRXMJwkflzs=;
 b=LS2OjBEOCw00wtlRNvgcq7PbntqqzyxaVSKiJnDPVChdXZ63US58j/FLef229Z2y54
 uqqn0fIXjXzEVi+6va4PknI5hoTSG1v1EzRhGZMpyJlYeQa6d3yp6xJd3EVeSRaKyT1E
 OrTUYPwKwHkyibTOqFD8oexOgavAScfBa08w+cBEXvH9B+m8yspRHf/yM+EHivD1ZYH2
 y5ilApZT79GYYMMlrdef4spvQxYWgNgt4oEHEPATiBPtND7zMlFUJh1W54DtUpleog0l
 +htpIN/UWIMliWPn7aF4okM7vuzAmpUayeWMG2AtY1n8fVg8LzWaUnj3EfOdMIO9kF0T
 kqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775642774; x=1776247574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dEuPWWzhYNRcUX4pgtCbVMTtFv0Mv67NoRXMJwkflzs=;
 b=AIynODrlicoesN12M3V8kUOBwLC4zwu+ZYBKSv5NoI+LZRRrwgt4w9Zd6mIq/MHYUz
 YqXkuZxmVr0Wjt22MhxYja5l3b482V0sLBfy7l60jtD1EeyuF9NkjwUWyQRPkwDVkUri
 wjQJja5cRlFacE5PriICGa+16cFrilnbeQKxhb5foSq9LQwvgBqdZY/hilSQuf/sqhiG
 a4LJIz2jEkYo/LghYofVo3wIBaRkpqqf476WxHHRU2yxuZmTyTbwxf/os8T0KY/qlkMP
 vD2lCer1dRg+czy5lDjRiK5UbP66fys7X6GVxNfq6faZW43vfHfKikRBf1/4OXWdmZy9
 I8Cw==
X-Gm-Message-State: AOJu0Yy/ecKizGoUHm664GOWroikW5aHOM0oNNA7tITxUEnGMYKFhFlK
 4tdJxH50aI4VHEQ5WkkR2Qu0cbmyGreLkwipA14TKmqdq/vVhdmko1/dPZcq83SIU6ytTBt3W8X
 8qJKl/Sg=
X-Gm-Gg: AeBDies7JtDjeyy7FqXKKL30R3dxMUpzkY7p9YfgBe+r69xH4fmvLhP99kBVhrdZHxl
 3zbf7oDMorbkMEaO5SaCPtWWaqfYUJ3ahdFBtdianTDGLzwDUN4QP5dx7PnfDazY4PXaMos6Vzn
 6Bb/I6v2tzmt6XskSQfqEcuIfRWUlWuvxOerled5//8RqvNI6P1cD26FVZJSIMpSponRl4UGfVu
 ob1u7eRN2/ky5oSxz2DxWt3DpaOISMvAgE/qNOqKlPDLr8AH+Zp7qa+zg4FxT0CLaHePblSeqVm
 RO/hvHgQW04eIbyx2B8d80rH5rcORW2OsA96rt6KvGh7BZGcD9XfHVjAFYP+rxUma2s2WHeH7Da
 hNu0P9nL9m5jRQ3sFd4wPBt/Mnj+s7hVfXOaNPQ5UcQkbpTKoM9qI9SEOzKV8RDG0TXZc8KN0gn
 BabXNnYjOwYWqhGyM7DU2/7x3tyu6e3d3sPO87t6eIR/CBP4G9SCFPmT85yOa+QPjosjHinoq4
X-Received: by 2002:a05:600c:3b87:b0:486:fe23:1707 with SMTP id
 5b1f17b1804b1-488997ac1bdmr300733115e9.20.1775642773800; 
 Wed, 08 Apr 2026 03:06:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c5271676sm16822945e9.0.2026.04.08.03.06.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Apr 2026 03:06:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Penney <matt@matthewpenney.net>
Subject: [PATCH-for-11.0? 1/2] io: Clear dangling GLib event source tag
Date: Wed,  8 Apr 2026 12:06:04 +0200
Message-ID: <20260408100605.66795-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408100605.66795-1-philmd@linaro.org>
References: <20260408100605.66795-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Following commit 34aad589019 ("hw/char/virtio-console: clear
dangling GLib event source tag"), prevent stale tags from
being reused by clearing dangling GLib event source tag during
the cleanup phase (finalize, unrealize).

Inspiread-by: Matthew Penney <matt@matthewpenney.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/redirect.c                     | 4 +---
 io/channel-websock.c                  | 8 ++------
 target/i386/kvm/tdx-quote-generator.c | 5 +----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index fda5bbca676..100afbdb06a 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1494,9 +1494,7 @@ static void usbredir_unrealize(USBDevice *udev)
     if (dev->parser) {
         usbredirparser_destroy(dev->parser);
     }
-    if (dev->watch) {
-        g_source_remove(dev->watch);
-    }
+    g_clear_handle_id(&dev->watch, g_source_remove);
 
     free(dev->filter_rules);
     qemu_del_vm_change_state_handler(dev->vmstate);
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 9902b014f79..da7e7c9e345 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -950,12 +950,8 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
-    if (ioc->hs_io_tag) {
-        g_source_remove(ioc->hs_io_tag);
-    }
-    if (ioc->io_tag) {
-        g_source_remove(ioc->io_tag);
-    }
+    g_clear_handle_id(&ioc->hs_io_tag, g_source_remove);
+    g_clear_handle_id(&ioc->io_tag, g_source_remove);
     error_free(ioc->io_err);
     object_unref(OBJECT(ioc->master));
 }
diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-quote-generator.c
index dee8334b27a..002bc40c8a8 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -74,10 +74,7 @@ static void encode_header(char *buf, size_t len, uint32_t size) {
 static void tdx_generate_quote_cleanup(TdxGenerateQuoteTask *task)
 {
     timer_del(&task->timer);
-
-    if (task->watch) {
-        g_source_remove(task->watch);
-    }
+    g_clear_handle_id(&task->watch, g_source_remove);
     qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
     object_unref(OBJECT(task->sioc));
 
-- 
2.53.0


