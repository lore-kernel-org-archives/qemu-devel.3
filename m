Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBEDD1AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11GS-0003hT-Ef; Wed, 16 Oct 2024 06:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GQ-0003h5-P4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:22 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GO-00048k-WD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so6141754a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729074499; x=1729679299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yM8QW7aQGE7oXuJsVmUNIviTBYs/Nivh/gZalad9Tfc=;
 b=Hw+Z1ghRj5WC7psQoc7beqa19R9jTnvL3rRkEmL7O2lm7S+maYxzut6P2Dy5q53QAW
 N72ycXhYa1ZJx+NdbLH5gzsmuDs9XvAECOPTfaDFu/LMOh94BCEHfML1tDyb7Jl8UcAx
 Q5aQba8ZUmcEKNGU8TLSSPoKaCMxDk8+lpPitr80MHJOVNEGauVpFJc48mDaeKGMGuHa
 VrJfexTnNnHP7oWoCMfiejm1uhZe2rO6rXB9QptOkQ7dVtBSUKUnyARkzewABh8X9wpB
 5yty4Pp0hkqvO45fWdaC9hY/RR55HvyQVg+0pIWC4VcsZi14RvUDqmpLCMUac8jKlc7i
 dJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729074499; x=1729679299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yM8QW7aQGE7oXuJsVmUNIviTBYs/Nivh/gZalad9Tfc=;
 b=Kq5HtXEBn9L5ZadlHB76E47wy5Q8yT+guYfXBB5/OFd0/0vXK4GPQyTVONw2pj3IVs
 wCBt//BARXbMFs0/0TZXsWIq9FiQv8nkT3WGirw+GV8ILKU43j1Prl+dvY2ku0rQdYn7
 e6598wDxvEHoTLLVIgDikyvDrpNTYqCBFRydX+Z5OLtIopyuLnbrWo7gYB90MIg+RBKq
 QbCerFKB6AvPPGmAEjCOG+i0r+GhAwKNBrhpUOwN+gNomUFJYNGRCWgXAYHzVSzl27LE
 aavxfUOy7L7RfYotCqY0p0TRLac6aISv6IGdhgqPvpP27HpLRHme6CFqKv6jYGPgMmBX
 KJOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpMNqzyZiwmFdSwSFuhm9vJwNBJjSuWs3scPdliJhWDS/CbdPFNEkKPvOAvZiwCclXmvv+yx+S+s5H@nongnu.org
X-Gm-Message-State: AOJu0YznnzeEWg7Yrn/BdJLsOD6ZSydZiOVQbRTEQ5x9kRvrvw888IbE
 SHZik6/LFbisNiVql8tws2HpoZIwFlXcD4fJZ8ssyK5BM2bX+MauBl/neQ==
X-Google-Smtp-Source: AGHT+IHXxvyDfuTlbw201tIXHV6k6hiWYMhnErsIRaZzAMx7i+ncV8mjrIvaMj/dFQNfg9QR+R7NyQ==
X-Received: by 2002:a05:6402:d0e:b0:5c9:6eea:8e06 with SMTP id
 4fb4d7f45d1cf-5c99518ebd3mr2609287a12.24.1729074498657; 
 Wed, 16 Oct 2024 03:28:18 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f85dcsm1566680a12.22.2024.10.16.03.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:28:18 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 0/8] chardev: implement backend chardev multiplexing
Date: Wed, 16 Oct 2024 12:25:57 +0200
Message-Id: <20241016102605.459395-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x535.google.com
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
can be controlled from multiple backend devices, namely VNC and local
TTY emulator. The following is an example of the QEMU command line:

   -chardev mux-be,id=mux0 \
   -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
   -chardev vc,id=vc0,mux-be-id=mux0 \
   -device virtconsole,chardev=mux0 \
   -vnc 0.0.0.0:0

which creates 2 backend devices: text virtual console (`vc0`) and a
socket (`sock0`) connected to the single virtio hvc console with the
backend multiplexer (`mux0`) help. `vc0` renders text to an image,
which can be shared over the VNC protocol.  `sock0` is a socket
backend which provides biderectional communication to the virtio hvc
console.

Once QEMU starts VNC client and any TTY emulator can be used to
control a single hvc console, for example these two different
consoles should have similar input and output due the buffer
multiplexing:

   # VNC client
   vncviewer :0

   # TTY emulator
   socat unix-connect:/tmp/sock pty,link=/tmp/pty
   tio /tmp/pty

v3 .. v4:

* Rebase on latest chardev changes
* Add unit tests which test corner cases:
   * Inability to remove mux with active frontend
   * Inability to add more chardevs to a mux than `MUX_MAX`
   * Inability to mix mux-fe and mux-be for the same chardev

v2 .. v3:

* Split frontend and backend multiplexer implementations and
  move them to separate files: char-mux-fe.c and char-mux-be.c

v1 .. v2:

* Separate type for the backend multiplexer `mux-be`
* Handle EAGAIN on write to the backend device
* Support of watch of previously failed backend device
* Proper json support of the `mux-be-id` option
* Unit test for the `mux-be` multiplexer

[1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6
[2] https://github.com/lf-edge/eve

Roman Penyaev (8):
  chardev/char: rename `MuxChardev` struct to `MuxFeChardev`
  chardev/char: rename `char-mux.c` to `char-mux-fe.c`
  chardev/char: move away mux suspend/resume calls
  chardev/char: rename frontend mux calls
  chardev/char: introduce `mux-be-id=ID` option
  chardev/char-mux: implement backend chardev multiplexing
  tests/unit/test-char: add unit test for the `mux-be` multiplexer
  qemu-options.hx: describe multiplexing of several backend devices

 chardev/char-fe.c                     |  25 ++-
 chardev/char-mux-be.c                 | 290 ++++++++++++++++++++++++
 chardev/{char-mux.c => char-mux-fe.c} | 157 +++++--------
 chardev/char.c                        | 133 +++++++++--
 chardev/chardev-internal.h            |  55 ++++-
 chardev/meson.build                   |   3 +-
 include/chardev/char.h                |   8 +-
 qapi/char.json                        |  31 ++-
 qemu-options.hx                       |  78 +++++--
 system/vl.c                           |   4 +-
 tests/unit/test-char.c                | 306 +++++++++++++++++++++++++-
 11 files changed, 922 insertions(+), 168 deletions(-)
 create mode 100644 chardev/char-mux-be.c
 rename chardev/{char-mux.c => char-mux-fe.c} (71%)

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

-- 
2.34.1


