Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440ABC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2D5K-0005DT-ET; Thu, 03 Sep 2026 15:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2D5J-0005Cy-3D
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:26:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2D5H-0001Xr-Eq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:26:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso10563555e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788463610; x=1789068410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i83cE/17EisGeNXzdFqULz44McRdJDA8yxTFatemjNw=;
 b=JSbOYHaA/bHgEz+KatXcIi9mwA94TqB9DesEn8I8qlL2No6tctpg6iJFpp//9+N4c2
 nHnGic4xkvxUeNAa0jEFN0aX8Gp5Rs4wzyIKmYwMKFbhSI/ehMp9SxfRzviEa+3xYdBX
 xd+oOe+mIQp2ydZFByoIAEkpMhBrd60+eitPrwI3Ye1bxHbCPvTSnIuBQYPZBq8U2Fq6
 EXy/nqbprMZ0CaUwe/s7x9BcGvjYE9/rbjTHz+1xJP1RZnqGMA+Lfhxg2xN4jJPIbec2
 5K+j7OT94UOFPIOlKPb3sUWfM6FTEgflHm3NIpcJSLqF8XIC9Xfxl23tJu8qexweR9d8
 rzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463610; x=1789068410;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i83cE/17EisGeNXzdFqULz44McRdJDA8yxTFatemjNw=;
 b=K5bPhGH6Y+FCx4MZm9ydXkWzCMsAbKyuGtetO7RVKK/xAvKr00p3PR+nPPW8DwFIMS
 tHPkkRG1CuhpCC51b8OPzg8PMjH04cjCSK4OJxUMmEfsY9YakAGkoUj+OYHrth5+ij9Q
 iW/UPXwX6jouf/GiTMbn9sShYIjjUnyN0zjH0Sh7uk+rpY8gCyM39R1DuIMCqniY5NvH
 RhSb8DYSqTb2NynxB4km2q7sLsjFxilB6kWwluc/TzHajKk8h3mXoO9ZqjUkhnonPtx3
 0cNzpShorUe2iaCJcd4hN4SHjFoECVGDw3Yd3EGNs7oRo/TWMqSy6KCu4FfpCrjApZAE
 itjA==
X-Gm-Message-State: AFuF++mMzbBzNz4bHRC5JUAgWzAWr17JFJ8HlP/GLeZuRRXyMJ9wtv9F
 M5rTCUnA9LHbbuDRT0p5Ys5YZG4iFlAnIJK8rvbzbpeOLGFLv0CZSb6P5dDYZ6qCjSMS8PVV8Tp
 Hy9Zv
X-Gm-Gg: AYBFou3fkbtRJZruTT89ihJ8f9q3MebDq7cFsX7P6HONApqCPzGFwtCpFT3EiM8qXy0
 Szu9q8QkZXS3iRD8sXDD2dEcpwM1KoStRSxvaWABqXQ8uZlgshpEaQeDwa90dOgaM3yjMCJOylg
 teI+g9Zd6z5XhKzw0s1iPxBDK52Q5mmeg0HkxFlROBmpOUmThljbrAVSJa40Zpav1mgwBipDW+z
 ZkpfYHfER35bosv6e71w2XzpOwhAEjZoByns4VP+Ze/pRgYPnNxyj72rT6RjdaDn2RwwF0nfuXm
 YGEKszz6rPXMQdPSxWUVbwL6Zh2t8FQKyaDkkOyXJfg7N6SccX+uiTE1nnGN1kaZsOxBSNBiFP7
 Z6zcQP2K2hbQV4h9RxNyhSSyykxPrg83rH1fs58/tqyXrKKwoonr49YJXnRAeIK4MviR2I2CoMg
 E7cfIVOyX8CG9kuYR95+eXDNTaHhd04UltGMZSgVHW+NkEoB7MhyZOGO8Y
X-Received: by 2002:a05:600c:248:b0:49c:e160:cbdb with SMTP id
 5b1f17b1804b1-49cee5b050fmr85378295e9.2.1788463609807; 
 Thu, 03 Sep 2026 12:26:49 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm663164f8f.36.2026.09.03.12.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:26:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] ui/cursor: fix two races that free a cursor early
Date: Thu,  3 Sep 2026 21:26:45 +0200
Message-ID: <20260903192647.2677279-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=den@openvz.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A guest with a qxl display can make QEMU drop more references to a
QEMUCursor than were taken. The cursor is freed while another owner
still points at it, and that owner's later cursor_unref() decrements
four bytes of a chunk the allocator has handed out again. Nothing
aborts and nothing is logged; QEMU dies later in an unrelated
allocation, in another thread.

Two defects get there, and neither fix is sufficient alone:

 - qxl_spice_reset_cursor() replaces qxl->ssd.cursor with no lock held,
   while every other writer of that field takes ssd.lock. It runs on a
   vCPU thread from QXL_IO_DESTROY_PRIMARY and, unlike qxl_hard_reset(),
   leaves the SPICE display worker running.

 - QEMUCursor.refcount is a plain int, taken and dropped from the main
   loop, the SPICE worker, ui/cocoa.m and ui/dbus-listener.c, with no
   lock common to all of them, so an increment can be lost.

A qxl device starts a spice-server instance for local rendering even
with no -spice, so this is not limited to SPICE console setups.

Patch 2 also asserts that the refcount was positive. Only qxl was
exercised here, so if another display backend drops a reference it
never took, that assert turns a silent leak into an abort.

Reproducer: a libdrm program in the guest queues cursor SET commands,
then disables the CRTC so the driver issues QXL_IO_DESTROY_PRIMARY.
Unpatched QEMU dies within seconds; with the series it does not. Happy
to post it.

This is independent of the pending "ui/console: fix use-after-free in
qemu_console_set_cursor", which fixes a self-assignment ordering bug at
the same line. With that applied the crash here is unchanged.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

Denis V. Lunev (2):
  hw/display/qxl: hold ssd.lock while replacing ssd.cursor
  ui/cursor: make the cursor refcount atomic

 hw/display/qxl.c     |  2 ++
 include/ui/console.h |  9 +++++++++
 ui/cursor.c          | 17 +++++++++++------
 3 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.53.0


