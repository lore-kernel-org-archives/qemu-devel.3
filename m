Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE0FCEE338
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 17:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syamN-0005XH-Hv; Wed, 09 Oct 2024 13:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamH-0005WJ-DK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:13 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamF-0003KI-I5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:13 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99650da839so10425966b.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728496028; x=1729100828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kP/GlD6pGrFyW69SdwNvhDWDCGBHEOF0ILopDy32tWo=;
 b=iNWyroW6LRFdp2xpHWH+Y/W9ELOotNOhrWISiZE1qevqNVm4CsClNeuFMlbDqSJ+g4
 dSMBNIAZ9gJPIc/nRf94DE2GuuPjWIyl5miKXyv7j15KXSToz8Tb5mZHSMm1ThtsRPvG
 anru67yPRi+gdPKGLuGxj4Amgvky0ESvwqhksLEEIIOao0fX+ZezZmAdHs0HICq6cY46
 plSw5ZFBqSH74SoTuHeYs8EF+FSPN/zMaz+4wXdtxNTpzLXmOlBUvnU4hojSdqnVqblq
 Cp4fl9lqY/07bZhMMQ8lcyXp7P31maJD4Gn/LQFDtGtTpL/zDjGzISA5VE2Qu+8DEc7l
 kLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728496028; x=1729100828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kP/GlD6pGrFyW69SdwNvhDWDCGBHEOF0ILopDy32tWo=;
 b=qFH9nRqqmr0LGsBNRyd7e7Qr3tH3tyZ7eWva65UuERhouF+s7x9/YWDwW1FWSLI9oc
 cFTLXISBmKGHhhBmDsLgTIJNCSQMyV7Lhmoaa+WT6C1+1gMCtwYEJw7ZLS6m4CSCrngw
 A9CFzpOh8mFbbYnKh2xsKFwMvowqjF/H6SeRFHWDLVxKx8CE7C/q9jhB6GDQGKGiR63r
 tONAAkazp2X80y+t5zoD6c7ZFMj31ISPzBCaR3wDThRXQrk0JEPTnHYj0GGIKxDeYnZi
 Iw+PFcMPGnEypP/O9agimtChqgid/Dr9oiPSHJ8TgXbN5ze5993l9H1DkGC969qyGenx
 dO3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvsCnE8PBkv0X0Y/Xpx52pv3FloxVfGF26zp+h3gln+DhxWSh268svL09ZGS6tFvDN4j9QR7wy5O47@nongnu.org
X-Gm-Message-State: AOJu0YwZXIvIoRAU952wPdr6fLu1R01HEMkQneBBExH6iytJFJFP3N97
 klwg4T1rpb7jTNk78YNqPurXdVQv3dueoiuoYeZsFYc+i96ffNdbp1BgTg==
X-Google-Smtp-Source: AGHT+IGwLI4u2S2nqPFZM2cKL34YQQT9i2dwBn+ScSq1/uFU1n8hJcuoECsNWX6b5onLglaY302huA==
X-Received: by 2002:a17:907:970c:b0:a99:4567:9227 with SMTP id
 a640c23a62f3a-a998d1996c9mr288276666b.17.1728496027947; 
 Wed, 09 Oct 2024 10:47:07 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994f38068fsm491667666b.40.2024.10.09.10.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:47:07 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] chardev: implement backend chardev multiplexing
Date: Wed,  9 Oct 2024 19:45:12 +0200
Message-Id: <20241009174517.286935-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62a.google.com
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

Mux is a character backend (host side) device, which multiplexes
multiple frontends with one backend device. The following is a
few lines from the QEMU manpage [1]:

  A multiplexer is a "1:N" device, and here the "1" end is your
  specified chardev backend, and the "N" end is the various parts
  of QEMU that can talk to a chardev.

But sadly multiple backends are not supported.

This work implements multiplexing capability of several backend
devices, which opens up an opportunity to use a single frontend
device on the guest, which can be manipulated from several
backend devices.

The motivation is the EVE project [2], where it would be very
convenient to have a virtio console frontend device on the guest that
can be controlled from multiple backend devices. The following is
an example of the QEMU command line:

   -chardev mux-be,id=mux0 \
   -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
   -chardev vc,id=vc0,mux-be-id=mux0 \
   -device virtconsole,chardev=mux0 \
   -vnc 0.0.0.0:0

Which creates 2 backend devices: text virtual console (`vc0`) and a
socket (`sock0`) connected to the single virtio hvc console with the
backend multiplexer (`mux0`) help. `vc0` renders text to an image,
which can be shared over the VNC protocol.  `sock0` is a socket
backend which provides biderectional communication to the virtio hvc
console.

New type of multiplexer `mux-be` actually is an alias for the same
`MuxChardev` struct, which uses same functions as for the original
`mux` type, but supports multiplexing N backends with 1 frontend.

Once QEMU starts VNC client and any TTY emulator can be used to
control a single hvc console, for example these two different
consoles should have similar input and output due the buffer
multiplexing:

   # VNC client
   vncviewer :0

   # TTY emulator
   socat unix-connect:/tmp/sock pty,link=/tmp/pty
   tio /tmp/pty

Difference to the previous version:

* Separate type for the backend multiplexer `mux-be`
* Handle EAGAIN on write to the backend device
* Support of watch of previously failed backend device
* Proper json support of the `mux-be-id` option
* Unit test for the `mux-be` multiplexer

[1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6
[2] https://github.com/lf-edge/eve

Roman Penyaev (5):
  chardev/char: introduce `mux-be-id=ID` option and _MUX_BE type
  chardev/char: rename `mux_cnt` to `fe_cnt` for the `MuxChardev`
  chardev/char-mux: implement backend chardev multiplexing
  tests/unit/test-char: add unit test for the `mux-be` multiplexer
  qemu-options.hx: describe multiplexing of several backend devices

 chardev/char-fe.c          |  14 ++-
 chardev/char-mux.c         | 212 +++++++++++++++++++++++++++++++-----
 chardev/char.c             |  57 ++++++++--
 chardev/chardev-internal.h |  33 +++++-
 include/chardev/char.h     |   1 +
 qapi/char.json             |   9 +-
 qemu-options.hx            |  46 +++++++-
 tests/unit/test-char.c     | 217 ++++++++++++++++++++++++++++++++++++-
 8 files changed, 538 insertions(+), 51 deletions(-)

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

-- 
2.43.0


