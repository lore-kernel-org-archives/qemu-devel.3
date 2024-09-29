Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80926CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suuDV-0004ir-2X; Sun, 29 Sep 2024 09:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suuDT-0004fR-1J; Sun, 29 Sep 2024 09:44:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suuDR-0008OZ-F0; Sun, 29 Sep 2024 09:44:02 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so527632766b.3; 
 Sun, 29 Sep 2024 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727617439; x=1728222239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtwsPRJ0G+vOcECLaC2xnLMNp7yAtpiAKrMCbcRHmo4=;
 b=Ou85RapjqrNvo7lYsQje7ktsOje5oiRC7oIl6KsuSvGmjlPQtjV/WynkeUUZOUq4w7
 H2FEVPXu90mod7Cw5QLsp+qCsi0HdlNlF71XZ6NWRWxEjjoic8EdayCqXZO2UC+1fAYu
 Z4fW71hVyVfn9iMRmkebMMdDkouNKveFUmC/f3+STnJ8rCH1DgfFRYU/nsGaMQG1BBdV
 Bgo8vg9swXX+FTScdFCB2QQblMFn33L1NXhq7/ADWej/tnAr4Wm8pN7k/4iLx/JDGCgh
 Nhgdkk+tzIDyP9lLaygHghP0ZrUSx0oZ/pIiYoks6DCupI13jwznKt2ERaiepHjfACL4
 N9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727617439; x=1728222239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtwsPRJ0G+vOcECLaC2xnLMNp7yAtpiAKrMCbcRHmo4=;
 b=W+hRT3nRyAT9B/eZGYo40dpgE0G7CB+HhNn3ztahUDccE6zwlJAaNUHCZ1ehePBEgq
 R2979WUnswlwJ6CrokyFl2EqRdBr2XZWFF8WlXkF5fJPmau8fUDScI0gx/y5TTfRcqPd
 JEUxGVCnv+7mv93Oinkv5CkFcpmFYqqz2zhJD61jz3yroIdw8UAPqdF1qTM/rSo3iGKX
 3A69fPNGoH02t02+XJdNTNbnIDDIDIEdEAMywql0ilSpAs7jLlSE1HP7pKUQMTnC4I6P
 ive4C7YnBPXbpHO19UTRzdyoNgf43peefDkbtpf/3R50nYyZ6VlDOzDITKGGwM9dq2sj
 kM2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnNKgsuf6FkXP0KncJhn9LOZCnien4jDgG9XY8YjVfuiOX23VzUWGQap/Qh8WXr3YW3aGn7U/J1H6H@nongnu.org
X-Gm-Message-State: AOJu0Yw1hRW4sM4jtWNAfpZ0Nno+8EvcC3kkcZRKftEdJrnIEIqNlAX6
 NEIF+KpBRJ+Xm3VhRHAumW5UKSOd2HaKC5zN4kCvUT1NuOtVKtnXg+ly8clL
X-Google-Smtp-Source: AGHT+IHOGMWQw2i2EuzyPY8wpLPvrG0MdbFZXxU/aXtcofiJz9cKDLTZU/pw9uvEN5oPgLtbj/rBuA==
X-Received: by 2002:a17:907:7f1f:b0:a8d:3e29:a82d with SMTP id
 a640c23a62f3a-a93c492ab45mr907400566b.37.1727617438869; 
 Sun, 29 Sep 2024 06:43:58 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2775934sm377029866b.35.2024.09.29.06.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:43:58 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, Eric Blake <eblake@redhat.com>, dmitry.fomichev@wdc.com,
 dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v9 1/4] docs/qcow2: add the zoned format feature
Date: Sun, 29 Sep 2024 15:43:53 +0200
Message-Id: <20240929134356.562086-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929134356.562086-1-faithilikerun@gmail.com>
References: <20240929134356.562086-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the specs for the zoned format feature of the qcow2 driver.
The qcow2 file then can emulate real zoned devices, either passed
through by virtio-blk device or NVMe ZNS drive to the guest
given zoned information.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/system/qemu-block-drivers.rst.inc | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 384e95ba76..5066c943d5 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,48 @@ This section describes each format and the options that are supported for it.
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
+
+  .. option:: zone.capacity
+
+    The initial capacity value, in bytes, for all zones. The capacity must
+    be less than or equal to zone size. If the last zone is smaller, then
+    its capacity is capped.
+
+    The zone capacity is per zone and may be different between zones in real
+    devices. QCow2 sets all zones to the same capacity.
+
+  .. option:: zone.conventional_zones
+
+    The number of conventional zones of the zoned device.
+
+  .. option:: zone.max_active_zones
+
+    The limit of the zones with implicit open, explicit open or closed state.
+
+    The max active zones must be less or equal to the number of SWR
+    (sequential write required) zones of the device.
+
+  .. option:: zone.max_open_zones
+
+    The maximal allowed open zones. The max open zones must not be larger than
+    the max active zones.
+
+    If the limits of open zones or active zones are equal to the number of
+    SWR zones, then it is the same as having no limits.
+
+  .. option:: zone.max_append_bytes
+
+    The number of bytes in a zone append request that can be issued to the
+    device. It must be 512-byte aligned and less than the zone capacity.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.34.1


