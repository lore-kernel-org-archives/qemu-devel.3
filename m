Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E64D1812B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxk-0006Fm-0H; Mon, 14 Oct 2024 11:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxb-0006EU-VO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:16 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0MxZ-0000v9-0p
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:15 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso167692966b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919571; x=1729524371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ieYzz76NYc0hrbPNlnrF7MLdxbnRYeYEf3mLbRzHXl0=;
 b=aqiSyVN3d9OPJMrWLwhhmmxpTAwUlc4gLGklTjYC1NOgnC30rH2CF7lQ9WUOQuBmeA
 O6dsn+wY9D0Vyc7nrmD5iIi1l8+3YYSr512jKzd1TC2dztJ7Tw4USdelUF0b10LWAalt
 oltUslIHXznGMGMvpSnIWy/Ckhahu5qH8cXSACT9De3JOLHGkUZyJ34tXUPOOvuB8jS5
 N402jL/XdkR4btUc5aVqxPGDzBETXkyNGAzWXkKrgFG5Z7oWrXsLV5c4xKCgDQz9zKGh
 vHV1BmcZrfNY0zXHTaqEol7pPyDs3mgkGTT61GGHdWvUcpXC1mbqUx3IMwjFYAOPjs8N
 SwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919571; x=1729524371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ieYzz76NYc0hrbPNlnrF7MLdxbnRYeYEf3mLbRzHXl0=;
 b=EBHkc4Z8fZ5V/R5yMGVlO6E/Pqi5KaqBY3k+GTiwvkl7ESgEWKvRQ1v43wi6twFUNH
 D+Ny1rt/qI0E7J9XXK3cD2oZ8WjybtYSJyk87iOPQIPEss+fn7YmOWo1Glkz/B1dyj6D
 2mfvKGohUM70/VtKy07LJ9GyjV1zMe+ula7BnBATMG2nfMx3jTv8Vtq+kJXGAs3T7K/I
 XpNl3sQmw58H+e+a3KoabIN8XCg2fR2GicAcKNI+d1WRX0sJjv/k3TD3vBqdXIksCYib
 dcU7CUupHcJzvje5qVdN/GEaijqdwtNtUi3rvD1b84UITmxB7DZIgNufqkVZYXazzyg+
 cG4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdY8fCsyULglZEuqaRlu+ihwUjPxaKIVP3Xk2b98s2Qt2yQJB9GtKeqPY8G/5rwa5tasoZV9xW5gni@nongnu.org
X-Gm-Message-State: AOJu0YwrehA0M1UotU8iV+9X82Jdbwz/9iNlMQ/lWOwyP04zzSQIi9qS
 xNclSGVVBOw0Z/pzO7nBQ+9XfDlGhAVLtKYkF480aXgh0eCmnJZI9ofy8g==
X-Google-Smtp-Source: AGHT+IFZ1HZvstib6yb+OWPLQbTX6qBsf4tUltr3PqaQ4845oJZkJp/e/KTvpr7yHp7z1rR/hdRUrA==
X-Received: by 2002:a17:906:730f:b0:a86:9d39:a2a with SMTP id
 a640c23a62f3a-a99b9307063mr1016546766b.8.1728919570623; 
 Mon, 14 Oct 2024 08:26:10 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:10 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] chardev/mux: implement frontend detach
Date: Mon, 14 Oct 2024 17:24:00 +0200
Message-Id: <20241014152408.427700-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x631.google.com
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

Frontend device can be detached in run-time, which can lead to a
"Chardev 'MUX' is busy" error (see the last patch with the test case
implementation). This series implements frontend detach for the
multiplexer based on bitset, which provides the ability to attach or
detach frontend devices in any order.

Also first patches do some refactoring the purpose of which is to make
integer unsigned where possible (such as sizes or lengths).

v1->v2:
  * improve if condition and assert for bit verification

Roman Penyaev (8):
  chardev/char: fix qemu_chr_is_busy() check
  chardev/chardev-internal: remove unused `max_size` struct member
  chardev/mux: use bool type for `linestart` and `term_got_escape`
  chardev/mux: convert size members to unsigned int
  chardev/mux: introduce `mux_chr_attach_frontend() call
  chardev/mux: switch mux frontends management to bitset
  chardev/mux: implement detach of frontends from mux
  tests/unit/test-char: implement a few mux remove test cases

 chardev/char-fe.c          | 13 ++----
 chardev/char-mux.c         | 90 ++++++++++++++++++++++++++++----------
 chardev/char.c             |  2 +-
 chardev/chardev-internal.h | 16 ++++---
 include/chardev/char-fe.h  |  2 +-
 tests/unit/test-char.c     | 24 +++++++++-
 6 files changed, 105 insertions(+), 42 deletions(-)

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org


-- 
2.34.1


