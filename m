Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AE606A33F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=MtD9NJhP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzHT-00048w-7R; Mon, 16 Nov 2026 11:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris.bainbridge@canonical.com>)
 id 1xSz2L-0000cQ-GO
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 10:54:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris.bainbridge@canonical.com>)
 id 1xSz2J-0000jf-Ot
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 10:54:29 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 96B913F71C
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794844453;
 bh=cfsQLM282692b9XkuXE/gp/fNGSKqysS9JDIp28ql/g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MtD9NJhPqufS62nscAy3K5WxiD6U+zTUVipjw7a66JiSepYR4IJ8El9VC+/268xw2
 PEdMkZmehUHIcY6PWkEKRYRzAt6JNn2aaVNiLOwUBLULKcAqdgXPRqZAn6/uVXA/+K
 7qYzejqP8UDDKMq8B9IlxAghZZTgNsj2pFwTr9cYhm6TXYKwDhz5pYYZmvCjawFwHX
 4TNMxQzAmXv8uqUAzUTr6FYgDh0FdahqClUYOn6NsCQebW0ZneUP5YP3PZ9h5oSImE
 8UDJUHBMKU1Bo3mj+Q9pTHChnbL+ka+Qvhq7kgyNGlyMdH5+/ksmXQQwW6TOReWHRp
 9uKPovTUSttKUBV0bE0NfP7rDTg+/hwcNJ36SJnYU08S//aRKhd02JvKLW351DMGk/
 yH1SzwWXBhBqjE/O7UFEs1wkqrViUeEg82zNzqcNdfy3ReAhyFuOvME0o/K60g46vs
 rdq08ycDuGA7lBh+iL6f5sfh4sm/ovQNb7ng3/UqcRUSRUjP2iV93IZIAvLP1lxdak
 z9ppAQgOkRkY1gx+FNdzSfCpfXN0eIt3V89tti5AbpZrLHuhAKdvztVb1G0nPjhHyH
 5kJ0VDvDCtn5g6lKOUXtpXrveLt9fEMyGnIdWfB8PsJ5zQTb03o/dz4gFGrjdCtg+1
 4UJYpTu0NR7Ef1HinDAaAKzs=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso16901955e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 07:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794844453; x=1795449253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfsQLM282692b9XkuXE/gp/fNGSKqysS9JDIp28ql/g=;
 b=zL85wOKFiRz0aSnQJAUQNmKVrS/n1avmis2o90HH+DtxwqgUf8PZSjYHbTtLQLoXYD
 fBfJZdyNyYE39Z2zs0wJQGeWDcMZz/yDwoxjoID5eKl0DaQdZcpxT3PZxuOiSPc6WJvZ
 VzrQ3KyIUvNsf/ydkiavFYSp7YPrMRwtdTieg65PsVlhXla+ermr+sfptMshrkn6L56G
 nUxiVRZFJSuIWqETbAbjs0NcMSvP4IIJOhyTuQ2vgojksvp5xV2X7umhj1hhLimUQrZ2
 NYfUrAEnwMCXzKW3sQykwYO7HR/P2R78SfYdY93bhG2TZZ+B5nnGpzF768OcTXIYPs+3
 XZJQ==
X-Gm-Message-State: APuU4Z9foTGAok6kkjht3Wi+109SBQdnbe1BpuV1N25LvmLAT10v50+F
 PhUv/79BtzGjbmcDtLXqc48nqy3IbvOdUBIduOaImNvftJ/OKe8g9IbPvS4HGGlnOU9LL315+bk
 3FHudzBPRx6h69Kp0pMia64ThJbOUZ6Bhzp+svJRUaxneznmRFGluwiSkEuFCRfs3JMCZitDGPL
 GSmwlgdv0=
X-Gm-Gg: AYBFou0PrwzO2pjZmJaEkva7+pqQ0855JE9jyedOwNDkqLwRu6qmXC8WuAJsefoAINc
 sqn9l2UjdtI8RVolw3CuL/R9DuIQfxdl/LlW6yqDdCNV9JSgL8lLnR1p0ZZbRec/rbXbN7iWePq
 uz5q3uY5soNoQSnyV7v6NfZX2df1qZM6xLhWfXci/2igfJ6JutBVT1PNE215BftpYhNgbVKMrJc
 KfE7z3hVnbjBp0TK56I+7Y9n3gyf3ff7U/85eEi0x1LPariHlcuO33B7EIDKObgEFcbd9AufO1Y
 ttW1qwuDPSyiVCjfbaFjx5pbzBNIi0PnEvgT/2DiBMLTajHyrC/A3ScvUDO2EkO8+3IofCW8bx1
 hR+k1wIau0beUJ7Con5A985qk7rNe5eVXTVuzyboWOsaspjlt1OOGLD6+hyFsVKU=
X-Received: by 2002:a05:600c:4e45:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4bb55a84b08mr226515215e9.16.1794844453129; 
 Mon, 16 Nov 2026 07:54:13 -0800 (PST)
X-Received: by 2002:a05:600c:4e45:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4bb55a84b08mr226514725e9.16.1794844452643; 
 Mon, 16 Nov 2026 07:54:12 -0800 (PST)
Received: from px13.Home ([2a06:5902:822:4600:c90d:b019:3410:bcf9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm311313f8f.34.2026.11.16.07.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:54:12 -0800 (PST)
From: Chris Bainbridge <chris.bainbridge@canonical.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-stable@nongnu.org,
 Chris Bainbridge <chris.bainbridge@canonical.com>
Subject: [PATCH] ui: fix screendump PPM corruption when the width is not
 4-aligned
Date: Mon, 16 Nov 2026 15:54:09 +0000
Message-ID: <20261116155409.300888-1-chris.bainbridge@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=chris.bainbridge@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Nov 2026 11:09:58 -0500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ppm_save() writes pixman_image_get_stride(linebuf) bytes per row, but
the P6 header declares the image as width x height, i.e. width * 3
bytes per row for the PIXMAN_BE_r8g8b8 line buffer.

pixman rounds scanlines up to 32-bit boundaries, so the line buffer's
stride is 4 * DIV_ROUND_UP(width * 3, 4), which is larger than
width * 3 whenever (width * 3) % 4 != 0.  Every row then carries up to
3 extra padding bytes that PPM consumers do not expect: readers which
trust the header see progressively misaligned pixels (a diagonally
sheared image, with the row padding interpreted as pixel data), and
the file ends up height * (stride - width * 3) bytes larger than the
header describes.

All standard display widths are multiples of 4 (and so is their
width * 3), which has kept the artifact invisible for years; any
non-aligned width triggers it.  Example: after a VNC client requests a
desktop resize to a non-aligned size (SetDesktopSize), or with
-device virtio-vga,edid=on,xres=1050, the screendump of a healthy
guest is diagonally sheared at the correct resolution, while every
other display path (e.g. VNC) shows the correct image.

Write exactly width * 3 bytes per row, matching the header.  The PNG
path is unaffected: it uses the same padded r8g8b8 line buffer, but
png_write_row() only consumes the width * 3 bytes described by the
IHDR.

Verification: on QEMU 10.2.1 with virtio-vga and a 1050-pixel-wide
scanout, stock screendump emits a sheared PPM whose size exceeds the
header by height * (stride - width * 3); with this patch the PPM is
exactly header + width * 3 * height bytes and renders identically to
the PNG screendump.  scripts/checkpatch.pl reports 0 errors, 0
warnings.

Fixes: b12f32c408ef ("pixman: switch screendump function.")
Cc: qemu-stable@nongnu.org
Signed-off-by: Chris Bainbridge <chris.bainbridge@canonical.com>
---
 ui/ui-qmp-cmds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 753cc2bf52..64027da2c0 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -309,9 +309,10 @@ static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
     linebuf = qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
     for (y = 0; y < height; y++) {
         qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
+        /* Write width * 3 bytes, not the 4-byte-aligned linebuf stride */
         if (qio_channel_write_all(QIO_CHANNEL(ioc),
                                   (char *)pixman_image_get_data(linebuf),
-                                  pixman_image_get_stride(linebuf), errp) < 0) {
+                                  width * 3, errp) < 0) {
             return false;
         }
     }
-- 
2.53.0


