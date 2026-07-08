Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaZ9-0008Eq-Fp; Wed, 08 Jul 2026 18:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZ7-0008DY-M3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:25 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZ5-0004Fr-Vh
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso2124167a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783548982; x=1784153782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OXrws65aUNdQ91XaTH7yxpdPdrZyTi9Sy/5xyhQXqEY=;
 b=f9vOmef8QLTeoyBEPmmCx4v3cm3rk9XNqbNj8FY1/3JSBXFjzbpXrSjPAIpr0E7o/i
 TIFTpNqG455W9F9mnximfETMAU2WAdpZy2xCdqP8OwPY9TPc8YR3g/vSus3yLJsz5GcU
 Mze4IfeTIWybUnyCGDMKEgp00Yuai7rV0obFmUpdGCcTXAgNMWxVJHnYZ2DXPfibLC9U
 9zshofosY1TXOG5tQz/4XY+ijn1xeb+LO5Bmlv6iDW6Va3yYE0JKRL7KAohT5UC7e1CF
 vvSAy+ne7tk5qNs5JgoIOoc5itGvN9+t7Q1qBsOEdHcwDYD4mYKJGYWSBU+EwWRTOMnO
 WguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548982; x=1784153782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OXrws65aUNdQ91XaTH7yxpdPdrZyTi9Sy/5xyhQXqEY=;
 b=dgRg9TmJJaKCte9FYjADBobabXeCmGFhgFWLbfsKhUQ9IyAn8lP34dPZkj5jkI9mRl
 4jZIqPx21A8CysKEsNw4K3yvfBp42lTAb7mGt5DokrYfWF0riEFFepQ9iTRz/N1YWN/y
 S/ghVJtzJPE+ett1Z1zuGMdtruCYZ5COgtHYPBQTqWtMjTXQkGmJ0NiAh2kd9NGiGNsZ
 CQKkOfVCgsseUab6oqof8daVsAkSkD38PcVUvXRYvCtOK8zKhA3q+EUWWMR5D/bWfdzm
 25rJEAp8R//Io+N3bG73QYDn36m46q/dICyCPj140ig1CLT3UgAGD3FMn/uJXwYPL3tc
 DVpw==
X-Gm-Message-State: AOJu0YyEG0Y0NE1jxlIGjGTpyuQvt5QPCydmXlPsmItuEP+WzAbPUzmY
 nUEMQjX+l2QSaKNweXO1oLQmfx5NxtMpeLiFFqmJAYYB0n355ynUsQ+zDHnU3LFYI+E=
X-Gm-Gg: AfdE7ckEwM/dcLqC0gCWWlx6xOEdC3mM1Q9QEMSG9alyQwXsvc/DP78yLw4fHL8a+Nb
 a8ykcauzL/+An2pER/foDF7EFr1Sd02qAmUPacxmHqmrznuimGvgbEc+IV5AM6xGj1ZPxzC7qL7
 x64CEZcW5pV7udScnofEw6qd2tUHrWsz7hAhzlfL3Ia3C+nd44a2fQPYuMi3tcl/o2ueTe3qbsI
 djXmgPQLzFOmyW4zggLCdprPPOhDckopnzwlYz7N7CUZxiwYN7PQ86MFFdSTqihE7mWGmwsCj87
 VXAxwR/zFQlQMjI03kAVpS3U2UM4agbTL3TTKXwkCJvqgVKyEzukSU79TR5WOtdzYx9viVg3T3B
 QzRyW5C9DvfmJft460w4I78hzsf0ilUWd5ho4l3oXeyJCakKKcM+NOA7fDvSjrbVDdPM1ODZGWE
 zeP9Ql49o2k28KO3NjY8Aq7K+MwwRvYWduimNJfvhEqNoXTQ==
X-Received: by 2002:a05:6402:3216:b0:69a:4372:72ed with SMTP id
 4fb4d7f45d1cf-69ab4478397mr1979803a12.13.1783548982332; 
 Wed, 08 Jul 2026 15:16:22 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:2200:181c:eef9:4c12])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm9059237a12.16.2026.07.08.15.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:16:20 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v14 1/6] docs/qcow2: add the zoned format feature
Date: Thu,  9 Jul 2026 00:16:10 +0200
Message-ID: <20260708221615.346155-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708221615.346155-1-faithilikerun@gmail.com>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52d.google.com
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 docs/system/qemu-block-drivers.rst.inc | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 675daa72f9..532fbb1f99 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,57 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zone.mode
+
+    If this is set to ``host-managed``, the image is an emulated zoned
+    block device. This option is only valid for emulated zoned device files.
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


