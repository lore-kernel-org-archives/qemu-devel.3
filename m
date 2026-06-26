Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE1C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6Pt-0008ES-9C; Fri, 26 Jun 2026 09:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pf-0008B9-7q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pb-0000wx-4F
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4924944fe6bso6832835e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782479761; x=1783084561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5kEQqDASX85Z7nerxKTqOg4pt8TEJhHjvpM9aHYwqw=;
 b=sWGXLvb1Y1FyL9LWtPnP9J1voERgrHWN0HhsqiDiexDWR1AeqJBeg00CQYOu0wnsbd
 MXem87QO7thu5mB4mq3e7fpcoOfey9MdJfDXveBeEcz6JLLcZ29rgPDpl9TxRcC/v5jv
 VEzB1Fxzg30aPO6LjzIdNfGFUpixt8mcikqh3N4ObRpJalnaFSep54q0cfeJvxj/kBcb
 kSH26eR24RHU6obZbKFkX+8Kr1aIcxdm6TeV24HlfG5cJdZFq/7LUqFS8SH6C08gkciO
 8hxJ2hWxRBTP3/Rv30aDg2tAL4lKy3CENRxWKrsf/SK8oGzziR0ufh/4xI4BbYkfnhOB
 UyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782479761; x=1783084561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C5kEQqDASX85Z7nerxKTqOg4pt8TEJhHjvpM9aHYwqw=;
 b=O/GN2UORYjF+XUJbqmEsBh8HPBXVeISRodOhBsjR5LipV1AzHigucNS24lRO44cEG7
 Ef0nk/6MvXDtE2JNMaSSXW0MK+iBYaZ7fJJzynhSS6s1iRWgRYCZQ/Ov90HiJ/f98hpC
 6P0w/cJxcwKAkVlyKgP9C5RrKQKGp91OEccG5BU0+DlbHQ9Lw1odq2Wfx9PVJ2KUHPj/
 E61q6P+OgXz5PZtqr4UTpFK9KA5RTMGeZSVmhsVpV6zFm/hFoLzGeYk7gid029CnoXBD
 KZQ1Esz/WvqtoPzyDH1Hdw5TButunUR/4p0NAKsKt/TSYYuKTewex2V1E5rrCGtiQ6lO
 G4WA==
X-Gm-Message-State: AOJu0YxYJELqvxzhoYlI2BuxOWqqXGym4qC8tm55nS5wyWJLrBtvnhE/
 XONytem34n7NjigYKUeld0L4Uz/tGMZpZBnHScRUmNZBfQyrLEMiejZVMMVnhw==
X-Gm-Gg: AfdE7cnKJWbnIAeBDvm7NOJ54hW9cb85V02gtdLKq1Jk52v6KGRiAfX9IGe6DwJEpIf
 f8leV+kF5tBcNlB0GUPJ77R44XGYXVvLSbmjUMKTDWaoOMtWnnBZZQuNMP+Q845V9gkYtHxAFFj
 YjEF0KiI9D7WfZi8NbzARH5YqwKhOV55JCPtPjnIKMDhESh4xqjRy5WfIZFffUfk+WELHuYTwBL
 SG9vjTgdEdM0zRNl5xxF2MOdOswCvD7OPw97BbRib4cOvBjYv3m1bnaBLGHH7DibmsqukPyrwCk
 pjQPXtgpWPD5kBWWfDFpfp0gG7aKangDs8ng2PKG8LbhvvqfbLDgReywOLT1D27OcI6Y1m+sROl
 TzXXHldrdWNUXiPGEixMdfMDKX2ZwS7JbSSklsVdajdQs7mAowYQdmHDTthrFSWNb8TQL6HQA1H
 p6dnbKlREUoik5pzTlgGxKktqOzAgPXR6Dxzzfihpe4t0gTg==
X-Received: by 2002:a05:600d:4448:20b0:492:1e36:552b with SMTP id
 5b1f17b1804b1-492668b7522mr81219265e9.36.1782479761223; 
 Fri, 26 Jun 2026 06:16:01 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:b369:c9c1:81a0:4afc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm26093756f8f.29.2026.06.26.06.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:16:00 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v13 1/6] docs/qcow2: add the zoned format feature
Date: Fri, 26 Jun 2026 15:15:50 +0200
Message-ID: <20260626131555.459792-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626131555.459792-1-faithilikerun@gmail.com>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the specs for the zoned format feature of the qcow2 driver.
The qcow2 file then can emulate real zoned devices, either passed
through by virtio-blk device or NVMe ZNS drive to the guest
given zoned information.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/system/qemu-block-drivers.rst.inc | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 675daa72f9..19587c515f 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,56 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zone.mode
+    If this is set to ``host-managed``, the image is an emulated zoned
+    block device. This option is only valid to emulated zoned device files.
+
+  .. option:: zone.size
+
+    The size of a zone in bytes. The device is divided into zones of this
+    size with the exception of the last zone, which may be smaller.
+    Defaults to ``256 MiB``.
+
+  .. option:: zone.capacity
+
+    The initial capacity value, in bytes, for all zones. The capacity must
+    be less than or equal to zone size. If the last zone is smaller, then
+    its capacity is capped. Defaults to ``zone.size``.
+
+    The zone capacity is per zone and may be different between zones in real
+    devices. QCow2 sets all zones to the same capacity.
+
+  .. option:: zone.conventional_zones
+
+    The number of conventional zones of the zoned device. Defaults to ``0``
+    (all zones are sequential-write-required).
+
+  .. option:: zone.max_active_zones
+
+    The maximum allowed active zones (zones in the implicit open, explicit
+    open, or closed state).
+
+    The max active zones must be less or equal to the number of SWR
+    (sequential write required) zones of the device. Defaults to ``0``,
+    meaning no limit.
+
+  .. option:: zone.max_open_zones
+
+    The maximum allowed open zones (zones in the implicit open or explicit
+    open state). The max open zones must not be larger than the max active
+    zones. Defaults to ``zone.max_active_zones`` if that is set, otherwise
+    ``0`` (no limit).
+
+    If the limits of open zones or active zones are equal to the number of
+    SWR zones, then it is the same as having no limits.
+
+  .. option:: zone.max_append_bytes
+
+    The maximum number of bytes of a zone append request that can be issued
+    to the device. It must be 512-byte aligned and less than the zone
+    capacity. A value of ``0`` means that zone append requests are not
+    supported. Defaults to ``64 KiB``.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.53.0


