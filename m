Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FBEC02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 16:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZBt2-0003z4-5L; Sat, 18 Jan 2025 11:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBst-0003wa-27
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:20 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsq-0007oK-PT
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:18 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so620804566b.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737218474; x=1737823274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=voproMK0qNLO31B6xoJmJki4e827lXTY8uYATHmgzcQ=;
 b=dWa6IkZGn2fwOVqtSwC7G1ka37a70gY6BTyf3ClTUGXvIBnIyexsRu17D/hYxABkXQ
 ZXXyYqynJIvHyu6t179yDYeoRu6MtJmwsGhUPb50eUi7CetCSZCAhDw3fmrbYMhMVjwd
 h6ovyQhhZdWvADHCAkTZ1dal1aU3JWjGOBuFnC7t1uvVEBQ9JcxeFB3e8Rj3DL4sGk/X
 2bYq0jrwDV7kmftx4wPWVvtCklUS2/3GRNUJUoX4uIxot5nrsNUk+Zizfqq9rBZ9Mqrz
 8hnra1bST2/Bv7csEg+DQcxNUIdvIMOVvdT6nhR35aGvIPFPEOJb4bDE0XNvBRkYJFsv
 OXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218474; x=1737823274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=voproMK0qNLO31B6xoJmJki4e827lXTY8uYATHmgzcQ=;
 b=NtH98eJhDY2NoGxeVdQQ+cZ3y1vyM11NbvFFvQNzVFuOUK7w4ua2ggmcn/KPVUc2RP
 gs4bpLuebrAYCdtjjFrQthbMyD96rqoiT541Uyr4CtDi30chJAk+iiehFK0DPPgagVFZ
 SQ7K4WRuMLoz/MolaupQjdUWJbJ3D+XmMV1+xigHJ9o+tw6oRUAH0WAQt6um5Ku8lsmX
 BEzDqUtURyqVXhYhkUYaiM4tmY+jkqWLY+2dvO1Bq7P2HA8mrjxgml0cNBauJBNHU34i
 9vrBdg8O2OSRR6hN8c6I/Pht2tQAunn7QAl0Ksor20dWHDOxri9Js//5nK17P0M2gazS
 3TTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3fC8xNdJOT5npe0NMkwltV1x7dsFz/07meMXhd8YL8znCjWblDmdIpzeDIzMl7CuwyIhEgogjE4gU@nongnu.org
X-Gm-Message-State: AOJu0YwUEIuVQtNLDSUY+miskVLmoIwpU2eI+gLAtz3IXRnTfPQ/Ejm5
 1jMo36HJ9fUZ+ekoqJuP+OTL/jCDU9CtdZDCLfuqrq8s8bfzy7jt
X-Gm-Gg: ASbGncvxtfFn+YrhJBZnW2gCm89gFNqy6B0DqVSM0dwSlEkEXyuwprcZAbM7eX6qFvd
 Oqoe2GM28SrIDi8SII/N1ejsPOfqzNXnGOR/sKfWu8KMCEY8dsxfeD8X7VaPlN3vSjLCNSw+FMj
 Zg26XbNYmlC9I8To2q4ZfzuMz4Ytakq8P8Uitzt76Kw3QEvuixevqos7GUzIundIddr3+z2BAhw
 +y496gKzRlIyqmnYCM/0xObeu1MUWP99Bu7yV2qPhSWzrexUyPn3ZxPYwvUapJy2RpdTWfqWjZy
 ePo=
X-Google-Smtp-Source: AGHT+IFbqo6yPhlnzoB1RHj7Qp9dLyiI+nFqRTErtf6e1suvyIyVzM4jlrrgxXwOZXVceyejU8/nKw==
X-Received: by 2002:a17:907:d0f:b0:aae:bd4c:2683 with SMTP id
 a640c23a62f3a-ab38b3c63f5mr696372166b.49.1737218473777; 
 Sat, 18 Jan 2025 08:41:13 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:d15a:20d8:4bbe:9a4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8624fsm358331266b.150.2025.01.18.08.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:41:13 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v7 0/4] chardev: implement backend chardev multiplexing
Date: Sat, 18 Jan 2025 17:40:48 +0100
Message-ID: <20250118164056.830721-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This work implements a new chardev backend `hub` device, which
aggregates input from multiple backend devices and forwards it to a
single frontend device. Additionally, `hub` device takes the output
from the frontend device and sends it back to all the connected
backend devices. This allows for seamless interaction between
different backend devices and a single frontend interface.

The motivation is the EVE project [2], where it would be very
convenient to have a virtio console frontend device on the guest that
can be controlled from multiple backend devices, namely VNC and local
TTY emulator. The following is an example of the QEMU command line:

    -chardev pty,path=/tmp/pty,id=pty0 \
    -chardev vc,id=vc0 \
    -chardev hub,id=hub0,chardevs.0=pty0,chardevs.1=vc0 \
    -device virtconsole,chardev=hub0 \
    -vnc 0.0.0.0:0

Which creates two backend devices:

* Text virtual console (`vc0`)
* A pseudo TTY (`pty0`) connected to the single virtio hvc console with the
  help of a new backend aggregator (`hub0`)

`vc0` renders text to an image, which can be shared over the VNC
protocol.  `pty0` is a pseudo TTY backend which provides bidirectional
communication to the virtio hvc console.

Once QEMU starts, the VNC client and any TTY emulator can be used to
control a single hvc console. For example, these two different
consoles should have similar input and output due to the buffer
aggregation:

    # Start TTY emulator
    tio /tmp/pty

    # Start VNC client and switch to virtual console Ctrl-Alt-2
    vncviewer :0

'chardevs.N' list syntax is used for the sake of compatibility with
the representation of JSON lists in 'key=val' pairs format of the
util/keyval.c, despite the fact that modern QAPI way of parsing,
namely qobject_input_visitor_new_str(), is not used. Choice of keeping
QAPI list sytax may help to smoothly switch to modern parsing in the
future.

v6 .. v7:

After discussing v6 it was decided to:

* Rename "multiplexer" to "aggregator"
* Rename "mux-be" device type to "hub"
* Drop all changes related to the original multiplexer implementation

Code changes:

* Added counting of CHR_EVENT_OPENED and CHR_EVENT_CLOSED events
coming from backend devices. This prevents frontend devices from
closing if one of the backend devices has been disconnected. The
logic is simple: "the last one turns off the light".

v5 .. v6:

* Rebased on latest master
* Changed how chardev is attached to a multiplexer: with version 6
mux should specify list elements with ID of chardevs:

    chardevs.0=ID[,chardevs.N=ID]

'chardevs.N' list syntax is used for the sake of compatibility with
the representation of JSON lists in 'key=val' pairs format of the
util/keyval.c, despite the fact that modern QAPI way of parsing,
namely qobject_input_visitor_new_str(), is not used. Choice of keeping
QAPI list sytax may help to smoothly switch to modern parsing in the
future.

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
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org

Roman Penyaev (4):
  chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
  chardev/char-hub: implement backend chardev aggregator
  tests/unit/test-char: add unit tests for hub chardev backend
  qemu-options.hx: describe hub chardev and aggregation of several
    backends

 chardev/char-fe.c          |   9 +
 chardev/char-hub.c         | 334 +++++++++++++++++++++++++++++++
 chardev/char-pty.c         |   3 +-
 chardev/char.c             |  26 ++-
 chardev/chardev-internal.h |  56 +++++-
 chardev/meson.build        |   1 +
 include/chardev/char.h     |   1 +
 qapi/char.json             |  27 +++
 qemu-options.hx            |  48 ++++-
 tests/unit/test-char.c     | 399 +++++++++++++++++++++++++++++++++++++
 10 files changed, 896 insertions(+), 8 deletions(-)
 create mode 100644 chardev/char-hub.c

-- 
2.43.0


