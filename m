Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F146C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNpk-0002J2-7h; Fri, 24 Jan 2025 12:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNpf-0002Cu-V7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:51:04 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNpe-0004Rd-A0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:51:03 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43635796b48so16027875e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737741060; x=1738345860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=se+/ei82uiUe3GOlyYsBHGJGXnKSrED8GmHFVnOMzmw=;
 b=Tgvq851RS0qlZ60dn/wJLgUauJ4TKUoaI6j0fBttP5y1g4HZbqwygxd/vpaaHovK8B
 MlJzR8aakz/dG/Zp3/UGMB3/8KmaPyScWjF7x/7GJZnEsKlRdSYl08dqacywmlcmTXz2
 hlAkevEfjqONWn6kIELTuFTVjCOMhWk0R/RhCmq54spWqFRlxtWzYVjgg+DqxZb8y5Fk
 uryT6qfw9qkRYwk0MZ/kSWoIVZeTLa1I12dn0WK26e/gcVJRCHvSeXGD2/VF/d2ri1jc
 3Xe+iQGunMmuVfy8dpaXVXYiYs9yKPeJV5huJfRbUuGtlXhUfaliWYf1Kw+fObpyYJZj
 UTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737741060; x=1738345860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=se+/ei82uiUe3GOlyYsBHGJGXnKSrED8GmHFVnOMzmw=;
 b=osNyRYd0uufAUFq+XdzhB4/a5iv2Y2fyiRABfOpxP04YepnHxcU/cf3HbIfJuRiQ8y
 Q9qm9wChIoEMcGZbHph66IbalEnwEZI/I0E/ViYs0wrDJfnWRVMjUOBOKpIZGcc0N9Xk
 tNgdNqbfKSfScCj8zJFaTX8SjAtGtWa9SXMKf9bqNqwcaWOyGY7JvZRao5UmsSHUQVtY
 vTL98StpIiLqJ0it3Oqs/5ZYV0/bJm6B0KRsQLuDBkA6ppkgc4FANhyHu+6gmauefaG2
 UTtM7ofK6kNaJH90ZOJoTLr1NBbzVnB4vfwqOxGg5pmHevCyHW4Nn1z23XzWnv01sqMZ
 1rlQ==
X-Gm-Message-State: AOJu0Yy3XcGfME/hEa6xoNh9nxFpEHwjUf9xVDB4VugONfYSpTbYIbHZ
 0XlySuXEWFvkSJjvRxpdZLDSz/lxoZnHKvKDqTlKf2PPVyeISeMz7t4rLua99uC+sgRoIIhwni2
 ERbA=
X-Gm-Gg: ASbGncuOZHPoC5d/D8cx7BXpeXHxjB/sTgXpjMw+F6LgQnxBGE0eCUxf1UMTXRC4JoV
 G1LZGdy1xJimCBiBWHiAceS4opL6ct+o8s0gv18axMproaIoF+Y+eb49eXG8ep92KtT07a2LMul
 VFX1EQ+wQ44MBIUoR5MxuUFhiXW1mV09wy8fU4E4uRSGhjOUFhj3wWe9YyYbnI0cIk08urQrJwt
 yx/niDrZhtNSnM92NfUF3NhZ0QaLZQ8mKNNQv/dZyTAgEvkoKrM3RMRspiTjfBoWxHSgzYGJSun
 XAnSze7imhdnvmOK5UOFK7D4QY9SCIdDlhmt/KDWvW6cVI86rEDZZpQ=
X-Google-Smtp-Source: AGHT+IHvb/V+l6MKLucRPgkhqa4uVeEipHl2wfbD0WpSvHSh8WL7BAytVoLTfBNGlP6RGSFv+O5ekw==
X-Received: by 2002:a7b:cbce:0:b0:436:1af3:5b13 with SMTP id
 5b1f17b1804b1-438bd0bd2edmr41981755e9.15.1737741060169; 
 Fri, 24 Jan 2025 09:51:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48a906sm35858865e9.18.2025.01.24.09.50.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jan 2025 09:50:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/char/sh_serial: Delete fifo_timeout_timer in
 DeviceUnrealize
Date: Fri, 24 Jan 2025 18:50:52 +0100
Message-ID: <20250124175053.74461-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124175053.74461-1-philmd@linaro.org>
References: <20250124175053.74461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

fifo_timeout_timer is created in the DeviceRealize handler,
not in the instance_init one. For parity, delete it in
DeviceUnrealize, rather than instance_finalize.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/sh_serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 247aeb071ac..29ac9f9e5e7 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -436,9 +436,9 @@ static void sh_serial_realize(DeviceState *d, Error **errp)
     s->etu = NANOSECONDS_PER_SECOND / 9600;
 }
 
-static void sh_serial_finalize(Object *obj)
+static void sh_serial_unrealize(DeviceState *dev)
 {
-    SHSerialState *s = SH_SERIAL(obj);
+    SHSerialState *s = SH_SERIAL(dev);
 
     timer_del(&s->fifo_timeout_timer);
 }
@@ -447,6 +447,10 @@ static void sh_serial_init(Object *obj)
 {
 }
 
+static void sh_serial_finalize(Object *obj)
+{
+}
+
 static const Property sh_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SHSerialState, chr),
     DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
@@ -458,6 +462,7 @@ static void sh_serial_class_init(ObjectClass *oc, void *data)
 
     device_class_set_props(dc, sh_serial_properties);
     dc->realize = sh_serial_realize;
+    dc->unrealize = sh_serial_unrealize;
     device_class_set_legacy_reset(dc, sh_serial_reset);
     /* Reason: part of SuperH CPU/SoC, needs to be wired up */
     dc->user_creatable = false;
-- 
2.47.1


