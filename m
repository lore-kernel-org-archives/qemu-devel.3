Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B762606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ApTfKOc1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV5eP-0005sT-36; Sun, 22 Nov 2026 06:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV5eI-0005kw-HX
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:22:23 -0500
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV5eG-0002yc-Su
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:22:22 -0500
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2f04824c47bso4607305ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 03:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795346539; x=1795951339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hMfAgA4IYg1RZDAariCOsWVW6I9jTZHHcKfHjNPqEjM=;
 b=ApTfKOc1JwTMr9IDvdf0wLQRPSJCBKiGch8DZumZlqC7M5x/eF+bO3rE0fONRSh+JS
 ukTrw5c35Gfmi0FXytHJbs9YztLPyG60T/RlkoCvqVnO/hHas7X3mSC9U7TCeU+W2+op
 xOpraoDH7qjFq9cCrPrMreN9v4PD58J+iyR7nUU25jKa6sw2Alu1ybcZePD/V9mSbvl1
 bp82m5lsx3ORgsQwIByrFnJ7/s5nddpQ9XQ9MZBhVBqvsiyDWHo4e6gVt2fHjPWdUI7E
 /NiMUjKp2VwThxdK/66g9JWVs/kIJ43lPgxHpEmCf6RxoOi0vgIv70chogeFXrQgCERY
 1gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795346539; x=1795951339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hMfAgA4IYg1RZDAariCOsWVW6I9jTZHHcKfHjNPqEjM=;
 b=ycE1Q6fORbOUot8HVo+8gQXbk+mpD1j6rVyLinubcbEeQ435nJKIB7GywxUlbRi/bs
 hVfFPpuxMkbW+/JnXbuKpN0I19q/AALftrp3oaY8TtE1D392kn95CXp+gm/xcIzNSCSw
 L8WUXIkx9DKWkKDJNDRzQ907jOlsnAUEWdtWFEhnhdcgd+guDcVse+i3W2RKGYhZyaOC
 5CSxDMYokJhvUpZA8Q08RHpgfspGP9TsB5zj2oIo5vMM1jvOqFMq9Mxx/GbDk4ZuesYJ
 IVSsgsp+oXnv5u3IwqU4fq9gxBWv1lEGresXhy8XwInBSoSeGWtO3Gczntv11ObwocPS
 v4ng==
X-Gm-Message-State: APuU4Z+wlkoFUdCWm56fHzpCD1SgaJFiZphojcUaJ7uN/25rxNxkPsw6
 GAD2P5u3Tsk1NjQbgwC9O7opqAt1qm1w3u7+sktT+I+wI4SaHDJi78q0TE1OvC23Ob0=
X-Gm-Gg: AZFdTZehcUaPBpK2gCc5b2eP7B3rKiLpQMPadCNWrWLhVLxWqr81ocw3c2TGk0AOj/+
 53ZEVyAoxUAK/xwEKZsfiznoiNsuxrUZ+MpAbLtf6gS/O2vzLwzQ2LFX+PH82XUFzPdkg4uBVcF
 qe3DMOh0OQ7mCHRfNYYAfm4So5I9GT801dPPI7uxdLI0Gd5cgV2dIVQUxW61MhRilIIm/cSb9JY
 ky8Obu3GVCDxb+I1Vg2vs/VlTTJcS7S1a/MJMcZvaB+RFII+dt8p51+RaHy3ZPDGx0JEOtPuioz
 TZZx7itDiztF9f5DszMPwpYYerHSwZMwqsl7Yc5tYJFjyzPbTmWBqE7dc+o5y+CIVcXPqMozey8
 vIImadK1AHd/v3LPPWmAUbsOD3kMIPNrf37MrTm5lvu7L5jmOftUvZbLC7Sy74kYfQgfAIxvnFW
 V7zadeCgSqJDFgc7KwFMUYQZstaOGOHtEoO3sJbstgfzLcgOdDcfWVU9qyRpqw4gHqv1RAGvyfj
 BiUOZpNmV6f8r/Uz3Gdn726ZrkETZcsR7o0WSM2/YfjfpIyFCiahBPC7kdaO1g1OuBswTxfqsSB
 FakqmjtrXdYJtMITxE6VCzEXDik=
X-Received: by 2002:a17:90b:3f8b:b0:3b4:1357:d538 with SMTP id
 98e67ed59e1d1-3b41c92a1femr7927159a91.32.1795346538948; 
 Sun, 22 Nov 2026 03:22:18 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b704cfesm3573820a91.1.2026.11.22.03.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:22:18 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 niming <niming@sangfor.com.cn>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH 0/1] ui: fix QEMUCursor leak in qemu_graphic_console_finalize()
Date: Sun, 22 Nov 2026 19:22:12 +0800
Message-ID: <20261122112213.1645993-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x01.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

Hi,

qemu_console_set_cursor() takes a reference on the QEMUCursor passed to it
and stores that reference in QemuGraphicConsole.cursor.  The reference is
dropped and re-taken on every cursor update, but nothing releases the last
one: qemu_graphic_console_finalize() only drops the reference held on
c->device and leaves c->cursor untouched.

Consequently the reference count of the QEMUCursor never reaches zero when
the console is finalized.  The QEMUCursor itself and the pixel buffer it
owns stay allocated, which shows up as a leak under ASan whenever a
graphic console is created and destroyed during the lifetime of a QEMU
process (e.g. with a graphical frontend, vnc or dbus display in use).

The patch releases the reference in qemu_graphic_console_finalize() with
g_clear_pointer(&c->cursor, cursor_unref), which also NULLs the pointer.
This mirrors the existing handling of the spice display cursor in
ui/spice-display.c.  No functional change beyond the refcount fix.

Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

