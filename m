Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B06AD374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rky-0003UG-Ak; Thu, 17 Oct 2024 10:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rkw-0003TZ-Q2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:38 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rku-0005cX-QD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:38 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so12894141fa.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176334; x=1729781134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8o0jHHm4HGadaDCCtgC5WdOSgCSIw+a9ax4xPsrCy1Q=;
 b=b891D1d5YwLYS9by44gkRw0QAbPZQYTsbvqw53U9AAymW7Wg3w45miOTfOzzNh1h+j
 MRBclVRXl++P/go3WwxD4I+usqn5jJwUTVNkie4eKzaCZLmyk3ku3NL3e1UdJtDISAyw
 7cjjggp512bom4xGSlF5lDh/k9XNa/J/o7qQOR2bjB4Ag54EyjzeyXMxjxAJ2vhj5Oxv
 +0PnU7swwIL1hL+mLHZJPJXa0By3t75SyfEEK3Q4HX4wx+/xq+B7QZJITbAgIy10c1I7
 vIEPd1xk1BY2W+tG2Hp0A4GloFqpIST4+yqee7THulX9AdsMBjZwZrWq1GEFIqKf45c7
 sV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176334; x=1729781134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8o0jHHm4HGadaDCCtgC5WdOSgCSIw+a9ax4xPsrCy1Q=;
 b=WYgEa+aKN5QoxRP0JKEP++NGyTk0BoyQyQc9LO4OJRdl2b0f3YKgUKWjrm9WqdvkEr
 R8mv1pZ6G5f7jsmWzHq82eO5BMapeFhdjXQAyVqpJ98TMI+V8ZfiIe9rzr0wp2kXujuu
 UF4faOhqmGHAyVAory7EiKTKb4w7CBxXPIGhpF48s/scAtQNZC3dud4LVDj84TEOTqpd
 13NBsLRqS76nE13pc8tCVGjojpqKdMQsZ2xqOYqK4v2VEXETHIG8bJi1I+graS3wvjEO
 NJvR4N3CrpagastrAjKTcO4mLLQxfWVy7iCDd7EieNlQCjXEEbjPpfw8SFTxQTc3yIHp
 6Jpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfbEZWVlCwHlwB0STg20vWKWsL0TuBHYNm1AOtzfxVvPh1XtidRZshmIRosRiaeXOlGQYjBJY64u4G@nongnu.org
X-Gm-Message-State: AOJu0Yw1XLtRDA1H/o42flbHdfhElhyLyyYVhXb95P3vjinWftBpfWm9
 WZlBCJMCRrlB1vDbN6M+myGC8DzqR2h8qEu14D/ZjFzAmfzLjT7d
X-Google-Smtp-Source: AGHT+IGenumB6nr5Pwfd6ElDCfa5UseAQKouamhngqj3GaJu1ZAnshsN/IwAu26CaFSVvE0qjYrkxw==
X-Received: by 2002:a2e:be1f:0:b0:2fb:30d5:669f with SMTP id
 38308e7fff4ca-2fb61b3e651mr53565901fa.7.1729176334244; 
 Thu, 17 Oct 2024 07:45:34 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:33 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 0/8] chardev: implement backend chardev multiplexing
Date: Thu, 17 Oct 2024 16:43:08 +0200
Message-Id: <20241017144316.517709-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22b.google.com
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

Which creates two backend devices:

* Text virtual console (`vc0`)
* A socket (`sock0`) connected to the single virtio hvc console with the
  help of the backend multiplexer (`mux0`)

`vc0` renders text to an image, which can be shared over the VNC protocol.
`sock0` is a socket backend which provides bidirectional communication to
the virtio hvc console.

Once QEMU starts, the VNC client and any TTY emulator can be used to
control a single hvc console. For example, these two different
consoles should have similar input and output due to the buffer
multiplexing:

   # VNC client
   vncviewer :0

   # TTY emulator
   socat unix-connect:/tmp/sock pty,link=/tmp/pty
   tio /tmp/pty

v4 .. v5:

* Spelling fixes in qemu-options description
* Memory leaks fixes in mux-be tests
* Add sanity checks to chardev to avoid stacking of mux devices
* Add corresponding unit test case to cover the creation of stacked
  muxers: `-chardev mux-be,mux-id-be=ID`, which is forbidden
* Reflect the fact that stacking is not supported in the documentation

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

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Roman Penyaev (8):
  chardev/char: rename `MuxChardev` struct to `MuxFeChardev`
  chardev/char: rename `char-mux.c` to `char-mux-fe.c`
  chardev/char: move away mux suspend/resume calls
  chardev/char: rename frontend mux calls
  chardev/char: introduce `mux-be-id=ID` option
  chardev/char-mux: implement backend chardev multiplexing
  tests/unit/test-char: add unit test for the `mux-be` multiplexer
  qemu-options.hx: describe multiplexing of several backend devices

 chardev/char-fe.c                     |  25 +-
 chardev/char-mux-be.c                 | 290 +++++++++++++++++++++++
 chardev/{char-mux.c => char-mux-fe.c} | 157 ++++---------
 chardev/char.c                        | 139 +++++++++--
 chardev/chardev-internal.h            |  55 ++++-
 chardev/meson.build                   |   3 +-
 include/chardev/char.h                |   8 +-
 qapi/char.json                        |  31 ++-
 qemu-options.hx                       |  80 +++++--
 system/vl.c                           |   4 +-
 tests/unit/test-char.c                | 323 +++++++++++++++++++++++++-
 11 files changed, 947 insertions(+), 168 deletions(-)
 create mode 100644 chardev/char-mux-be.c
 rename chardev/{char-mux.c => char-mux-fe.c} (71%)

-- 
2.34.1


