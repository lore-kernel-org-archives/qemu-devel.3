Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EE9FC6175
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spClp-0006xe-W4; Fri, 13 Sep 2024 16:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sp9Ip-0005eu-KG
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:37:47 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sp9In-0000gC-TK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:37:47 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso314031166b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726245464; x=1726850264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqY4NlBytX7ch7su6BqSvYG5vlrA13LQHTCrcMuTwk8=;
 b=HlVg+s+6+ue4spQczaoo0yTLhuJx8+eELhzQO4VA+tVLeSs1YL32ya/76brNaI01K6
 mrDpH0J25eiIb0vv0Qfwtkt+VmVQSxYLT1EFJfLtKIG946f5im10ARW8f+6vkdg3L6HX
 BGi46WC+sYcvgEG37Ohv2X/Px3WALaCYRgzFUhuLqdEdVwzYh9jImnbt8EHlZQL6LWZx
 97tk8n1AcA5ijsWh71pH0IcDZT1zdfg/0pbC20SKtwATW24zpYljy0mLa1ieDdbRAopR
 HkswcaQEe7piX5SZp1ymFkuy88XMYn5M+nMMxx6ldpruDK+oAhFtSQncMM0gYLTm3VfD
 svpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726245464; x=1726850264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqY4NlBytX7ch7su6BqSvYG5vlrA13LQHTCrcMuTwk8=;
 b=PqSA0J0UPSToXcNfrXo9R+yuDRGkAQKGwVVtFo+7AQvTwzax4fG5f2mFQzvLUInchx
 fyYBbroXU0okkvkBBTgBiq65XnvKYmbNMGoIgzZNMCyWdcXDClTjkDySeKyDNxjqN33B
 A5HM9bg04eE0mF+/ZTdPlGiS0xGStSiyJdJ4j0siIn+bmstLnaac1AAPvkHDwyChlxT8
 E4hYnJ5hz/mZNHVFIn6fAiEc3XkCc9vtSMauiBHZJW0+S3wbnagwRWN7PS5iL03B37SQ
 bCG4HRP7XRhYSSgULLnJwc7vsZgdPmmbeEBqvctTxIER07bf1s7sKIpfXEXBBy8b7MFW
 jU0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpRGBnrMe7VzhcQn0Do+aYd3fYlBPHJDqq7W/PyCNA1C2+8vWZGbpE79SBrx5NUtipsvBZvEPADzzb@nongnu.org
X-Gm-Message-State: AOJu0YwwdCTPE/+/jAbW+IR9Bci7/XWmfyj0YKtEmO1DGCqAt8DbsWUI
 PEE43+oGrdSlaTNjDVwSIj6CEOPpTPkqj6vDZL8ZYJK2ekj+WtsNOBNEdA==
X-Google-Smtp-Source: AGHT+IHRdH+uAv9Jv9elIjSsOedBtdF7WvEhd/5jA1Ue8fbEjgSUwoTt+m9ok4VyEduOTR5HYcbnZg==
X-Received: by 2002:a17:907:1b13:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a90293b15e6mr871125966b.6.1726245463199; 
 Fri, 13 Sep 2024 09:37:43 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:24fe:3d15:e808:f6ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7286esm878983366b.138.2024.09.13.09.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:37:42 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] qemu-options.hx: describe multiplexing of several backend
 devices
Date: Fri, 13 Sep 2024 18:36:36 +0200
Message-Id: <20240913163636.253949-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913163636.253949-1-r.peniaev@gmail.com>
References: <20240913163636.253949-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Sep 2024 16:19:54 -0400
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

This adds a few lines describing multiplexer configuration for
multiplexing several backend devices with a single frontend
device.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qemu-options.hx | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d94e2cbbaeb1..de1d540b85cd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3782,7 +3782,7 @@ SRST
 The general form of a character device option is:
 
 ``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``mux``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3839,9 +3839,9 @@ The general form of a character device option is:
     the QEMU monitor, and ``-nographic`` also multiplexes the console
     and the monitor to stdio.
 
-    There is currently no support for multiplexing in the other
-    direction (where a single QEMU front end takes input and output from
-    multiple chardevs).
+    If you need to multiplex in the opposite direction (where one QEMU
+    interface receives input and output from multiple chardev devices),
+    please refer to the paragraph below regarding chardev mux configuration.
 
     Every backend supports the ``logfile`` option, which supplies the
     path to a file to record all data transmitted via the backend. The
@@ -3941,6 +3941,42 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.
 
+``-chardev mux,id=id,chardev=chardev-id[,,chardev-idN]``
+    Explicitly create chardev multiplexer with possibility to multiplex
+    in the opposite direction, where one QEMU interface (frontend device)
+    receives input and output from multiple chardev backend devices.
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
+        -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0 \
+        -chardev vc,id=vc0 \
+        -chardev mux,id=mux0,chardev=vc0,,sock0 \
+        -device virtconsole,chardev=mux0 \
+        -vnc 0.0.0.0:0
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
+       socat unix:connect:/tmp/sock pty,link=/tmp/pty & \
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


