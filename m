Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF6CCEE336
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syamT-0005Z8-BT; Wed, 09 Oct 2024 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamJ-0005Wk-RG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:17 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamH-0003L6-Jb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:15 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so11121066b.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728496032; x=1729100832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuqOO3LqDX2G8oXdRbMxrpr3s/uI9Id95M9jvHkmB7w=;
 b=GpgI4sqL+i4lGIlvDLBqGk8PmyxN6uw+muafZPDlYjl3wuEIhY19zkTSQvDlLfSVnX
 497BgkkZgb7/jTqeDJ9dxeNVM6UNY8C2i+DUGais7SOZD14Zw3ZOYuEFU5msVdV+8nfm
 oZEH3+c1bAlfvdG/WnQSdY1G0XrDcut68xDQo8Jz9/L/2xTzBbfPsPq3IkROi4ag3an6
 smYz2VvIlhSZILsW+AuNDzfK8oMKI78zjYyqqOrvzXIU4eAd81f/cxZE/TkQ80GzfVq8
 lYJ22dX2kSTFX1mkBn8ApCtTSBbZ8+dYpMmeunZjY84jwV8vtmB+NG7DbDaNQFdoGxQ1
 GsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728496032; x=1729100832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuqOO3LqDX2G8oXdRbMxrpr3s/uI9Id95M9jvHkmB7w=;
 b=EjdtnxanwxASiVfyUM28U39zLBMXRJL0rJoqukD1Z8zufVjcSOc50UG0gpY9hfnYdL
 CUI7bEBDH8jBgBcdZ+ftLDxpJ2xn0IjAWcbBAd46p+RlRG+kP4uMjg8lpm53g7uLPfZv
 7/LWtgpD2d+97tbHPkIRsJP19h7X6Z0fa3qAhdrXuTtSLIKBv8eZKaaJDnuqag7UDYzy
 7PNg+LHwvRA52wxFkGJW4q35kpNg3DN6Chvur71qMh24kPVlvZE1te/ASGYhbbGNI28T
 x6bEoP+XRqmHv65OBd+//NW/ZxO8XIAIxT0nH4+a9bI1igtNQykMN5KcnGj+LTKO/60S
 GhCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlX9gXkNDaMfu0fu5wM+8Rj3Q0pv32pcHpHorYsFlFXxG+wAfFxdzb6fEZAAanHVUlVLQMgNncKc1l@nongnu.org
X-Gm-Message-State: AOJu0YwlKg5EPOyI6qTAQpLOWbRT69q0wfwYW4jhgPnhDU1pGAHsC6Rv
 pmo94v1C3N6OlhhLGevuAthpG6dfYNe405DdwJ1p6pXY8x8PWrdz07uIWA==
X-Google-Smtp-Source: AGHT+IHpPn56cXSUnuNc7OvsbrP3yRPwlJeo9u73u0OTE/IEDPZeR3kQcKv5qNqIBHyjqx57xT+G0g==
X-Received: by 2002:a17:907:c7d8:b0:a7a:9fe9:99e7 with SMTP id
 a640c23a62f3a-a998d313ca4mr304421366b.41.1728496031881; 
 Wed, 09 Oct 2024 10:47:11 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994f38068fsm491667666b.40.2024.10.09.10.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:47:10 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] qemu-options.hx: describe multiplexing of several
 backend devices
Date: Wed,  9 Oct 2024 19:45:17 +0200
Message-Id: <20241009174517.286935-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009174517.286935-1-r.peniaev@gmail.com>
References: <20241009174517.286935-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This adds a few lines describing `mux-be` multiplexer configuration
for multiplexing several backend devices with a single frontend
device.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qemu-options.hx | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d94e2cbbaeb1..21f112c2e445 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3782,7 +3782,7 @@ SRST
 The general form of a character device option is:
 
 ``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``mux-be``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3839,9 +3839,10 @@ The general form of a character device option is:
     the QEMU monitor, and ``-nographic`` also multiplexes the console
     and the monitor to stdio.
 
-    There is currently no support for multiplexing in the other
-    direction (where a single QEMU front end takes input and output from
-    multiple chardevs).
+    If you need to multiplex in the opposite direction (where one QEMU
+    interface receives input and output from multiple chardev devices),
+    please refer to the paragraph below regarding chardev ``mux-be``
+    configuration.
 
     Every backend supports the ``logfile`` option, which supplies the
     path to a file to record all data transmitted via the backend. The
@@ -3941,6 +3942,43 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.
 
+``-chardev mux-be,id=id``
+    Explicitly create chardev backend multiplexer with possibility to
+    multiplex in the opposite direction, where one QEMU interface
+    (frontend device) receives input and output from multiple chardev
+    backend devices.
+
+    For example the following is a use case of 2 backend devices: text
+    virtual console ``vc0`` and a socket ``sock0`` connected
+    to a single virtio hvc console frontend device with multiplexer
+    ``mux0`` help. Virtual console renders text to an image, which
+    can be shared over the VNC protocol, in turn socket backend provides
+    biderectional communication to the virtio hvc console over socket.
+    The example configuration can be the following:
+
+    ::
+
+       -chardev mux-be,id=mux0 \
+       -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
+       -chardev vc,id=vc0,mux-be-id=mux0 \
+       -device virtconsole,chardev=mux0 \
+       -vnc 0.0.0.0:0
+
+    Once QEMU starts VNC client and any TTY emulator can be used to
+    control a single hvc console:
+
+    ::
+
+       # VNC client
+       vncviewer :0
+
+       # TTY emulator
+       socat unix-connect:/tmp/sock pty,link=/tmp/pty & \
+       tio /tmp/pty
+
+    Multiplexing of several backend devices with serveral frontend devices
+    is not supported.
+
 ``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]``
     Connect to a QEMU text console. ``vc`` may optionally be given a
     specific size.
-- 
2.43.0


