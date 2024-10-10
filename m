Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E470FCF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHk-0006UC-CO; Thu, 10 Oct 2024 06:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHh-0006TD-Sa
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHe-0003ZX-SK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:41 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a994cd82a3bso106739466b.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555637; x=1729160437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/kVJhzVjNqZegRHoxyDOgPB1EKvebYmFk2tXt70azc=;
 b=XDbhZqt60QkBpku3j04WU98O8N/At7cyvz6Z0Hiu/T89SPUL805afvQTSdSz2ZmrC/
 oYsdoMFaVANEUwZgn6UzVZA1AEmiAh5eofrmRLu6LED/TrZSQFx9Wh/5/u1YDOM3wbtK
 7Q48OYXlsc7C5iQ8a69RUkAqJFwUb441qvFJcUlhaoLAIe6Z/P+CJGCn6wIZ5/HHuSCd
 ztzbdPPtp8OAE8Qx1ONKYlqjAyXlk3v+gTueE6nYqLxlbsyZz/Xno9jbthb1n1+L/2z/
 5gUB80R6ZUX9bEpLQ9NS459vsb7ZpNLTKY6qYDjyQfz700mp2fgpe9SayvyEQv5oS4ul
 Cf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555637; x=1729160437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/kVJhzVjNqZegRHoxyDOgPB1EKvebYmFk2tXt70azc=;
 b=SeffZlfGARksKNBs2OIjyJJc9x+8Z/1njehO4HayPb1KxM1focaPlaEzc8eZsetOwg
 3Ek7p8n1x/OqwCQ/sji3zXg45SSdLksysr+CzCAa2GtCY1NVPbvydRUBgbexvTkmFlaI
 yDOB/h0yB/nFQNEHgYInK4O2AxQJEcJgpkV2L3hWXI/hiK6PHhVk8i98Ms25tjTRrOvq
 XiZs5CrBN9dt+KmbiZWmH/LTSQUj5BFiKHwLNrmoo7kHF4uqLvqsRjFdS3wkwTrOsKGt
 Q4ZlwLUpjPgOV+eLXfHKHVe6+6TIFPRoFcN/prCSnIvUYWNkM9mymwoeG8UkcuBG1tw/
 9cWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdmeN3b5bCKuRfTqH02o+pmujfC+UOqJnZxmxBFPrShS9PIobXGYh3nS/yN7mJFlpjhR5g40x7eD1+@nongnu.org
X-Gm-Message-State: AOJu0YzkrctoD1rdUDg7uWEBTC33N725bKQDEA/8mbOW2PagwCf+vaLL
 pzTTs8yrhJuE95qfQhKwfGAotkJsGMM6k7WmsbXgdW0Pdj/EvR9o4Ap6iA==
X-Google-Smtp-Source: AGHT+IEXfSz7EwBl5LLGHUuTJCZGzyTvYRSBbgtstyr+NuW14WNK1wBVgyvbl/9649ZTNN8Aj8gJow==
X-Received: by 2002:a17:907:7e89:b0:a99:42fe:949b with SMTP id
 a640c23a62f3a-a998d33ee47mr500751966b.57.1728555637095; 
 Thu, 10 Oct 2024 03:20:37 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2436fsm68240266b.53.2024.10.10.03.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 03:20:35 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] qemu-options.hx: describe multiplexing of several
 backend devices
Date: Thu, 10 Oct 2024 12:18:38 +0200
Message-Id: <20241010101838.331032-8-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010101838.331032-1-r.peniaev@gmail.com>
References: <20241010101838.331032-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62f.google.com
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
 qemu-options.hx | 78 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d5afefe5b63c..22490c529a50 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3693,37 +3693,37 @@ DEFHEADING(Character device options:)
 
 DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev help\n"
-    "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev null,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
     "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4=on|off][,ipv6=on|off][,nodelay=on|off]\n"
-    "         [,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds][,mux=on|off]\n"
+    "         [,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds][,mux=on|off][,mux-be-id=id]\n"
     "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
     "-chardev socket,id=id,path=path[,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
+    "         [,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
-    "         [,localport=localport][,ipv4=on|off][,ipv6=on|off][,mux=on|off]\n"
+    "         [,localport=localport][,ipv4=on|off][,ipv6=on|off][,mux=on|off][,mux-be-id=id]\n"
     "         [,logfile=PATH][,logappend=on|off]\n"
-    "-chardev msmouse,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev msmouse,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
     "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "         [,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
     "-chardev ringbuf,id=id[,size=size][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev file,id=id,path=path[,input-path=input-file][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev pipe,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev file,id=id,path=path[,input-path=input-file][,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev pipe,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #ifdef _WIN32
-    "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev console,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev serial,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #else
-    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev pty,id=id[,path=path][,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev stdio,id=id[,mux=on|off][,mux-be-id=id][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #ifdef CONFIG_BRLAPI
-    "-chardev braille,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev braille,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
         || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__)
-    "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev serial,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly__)
-    "-chardev parallel,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev parallel,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #if defined(CONFIG_SPICE)
     "-chardev spicevmc,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
@@ -3735,8 +3735,8 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
 SRST
 The general form of a character device option is:
 
-``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+``-chardev backend,id=id[,mux=on|off][,mux-be-id=id][,options]``
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``mux-be``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3793,9 +3793,10 @@ The general form of a character device option is:
     the QEMU monitor, and ``-nographic`` also multiplexes the console
     and the monitor to stdio.
 
-    There is currently no support for multiplexing in the other
-    direction (where a single QEMU front end takes input and output from
-    multiple chardevs).
+    If you need to multiplex in the opposite direction (where one QEMU
+    interface receives input and output from multiple chardev devices),
+    each character device needs ``mux-be-id=id`` option. Please refer
+    to the paragraph below regarding chardev ``mux-be`` configuration.
 
     Every backend supports the ``logfile`` option, which supplies the
     path to a file to record all data transmitted via the backend. The
@@ -3895,6 +3896,43 @@ The available backends are:
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
2.34.1


