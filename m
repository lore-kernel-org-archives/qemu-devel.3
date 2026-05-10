Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B713BCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 17:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM8J5-0000LN-4u; Sun, 10 May 2026 13:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wM8J3-0000Kb-Sn
 for qemu-devel@nongnu.org; Sun, 10 May 2026 13:51:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wM8J1-0001hk-8h
 for qemu-devel@nongnu.org; Sun, 10 May 2026 13:51:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891f625344so34345285e9.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778435464; x=1779040264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c67CZxLMUIcBPR1yl/CBxq3zsoOSpsyIfsbCNt9sOuw=;
 b=VIV1KH9Jp41aqvQom4paITXezSEYghDLO4IkFkzk/U5FvR0dIRkQqw0nvGiPmlQDGl
 2IZcFKVti9k5LbBPBWqkuH6FA52VRPvBc6zeUauxn74AVXpE+ShxfwO1b98aCK+BoT6O
 UVKYaUmaiLMS7tK1pE/puJDw9Um+MrWetemLZEMr0vNhCaekDKH9ftP9skI23la6CygS
 bpc4E/EOIl7lHVeIbGf43u86bUt774NXKJii2eYafVchkOBLK/82hBnXyubUaxZD6toT
 Z1cP12V+wPAlleKAYKU6iPq6OgCTs46ab9PpGtZAqqOnQ73AOHEFnUZQ8GJqSMTw/1Iz
 h1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778435464; x=1779040264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c67CZxLMUIcBPR1yl/CBxq3zsoOSpsyIfsbCNt9sOuw=;
 b=mpMcBVwCNNh1eH5YeAHHScyi0GkDoVuF9q50HvygIreFppdYaQjaFsFOO6x3fPyaHJ
 +rTjTCDi/LmRC4bTtE1ROB07r5z4Ym5K0tnSiFKKaDCHdUTlzc1U4L6wbpVfHiio35By
 SP4QZjmY9Ad+Iy1d/WLEMidDxagWnWpcbuyTVlNAF9J7son59pT1VfO0Sl1zFRVtmtfC
 tERp733qo4gZ51AuLWQY8cFrj5gv997VXpCaHIrB8n7+gejQ0LF8SuCYNXf3/tTCFGYz
 CuQoVGtlgNykxfh3VHmODeaUcWC3A+X/Zw0I3md/4R7F7HvBS21xnmtd3AAEAFg5wpz0
 E0xQ==
X-Gm-Message-State: AOJu0Yyujqhqa4PZC9Lb0DdK9ITYI4zflLCXG8eIzvqcG7jkTlorU9qH
 N01ndzHVl194qPCTfVsSSwNHZjPqSLLVFJ0zRRGgL00rVMfi5OXu2XFbYaFMNg==
X-Gm-Gg: Acq92OF8AM6wb1naaZlHYTMhxzMA20toWAwxhqf7xrfGljKzChZV9ZjB01Ig8b/ZdXI
 ykjH2qimc5VvmsCa7pYReZz4TgstFdRAJux+6/hDqC3ONBZxCJfX6KQxOiplcteJ0zmr2tk3HRJ
 EKzS9V2pJ/PSL9AI24rcw8UoaUG8hsgiaBUnmeS2L/XJqJE/04XCzsFafZh8j5BOCWVXM3JLrZ7
 EYszA6SnWYoAZvI/8wFJbN8aK8vQuza736blXztWtrvNIbWm0w2RD1+J8F1eQ2xCtgEDLU2hiM5
 Ey4MbzH8oKcleLmcNiv40EDfazFgUEERNESj0NC+qAnmD9/BUZmOIsMsK3oDFvkxapvvkcP6ruZ
 roR6Sthn3mbtF84VoA7Lo7iK1BZNH3h5cWS8v0ikeyaM2Wo1+CnlR+Bt0DFeIgimB6PDh6TIPGP
 NIn2h7/mZXo24ZuG/fxHcW8SEcpav+jCP02ZAo1dnWX+h3HiV1B6bAPtYRhPa4pec=
X-Received: by 2002:a05:600c:3b20:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-48e5dfcd4a9mr223442745e9.3.1778435463930; 
 Sun, 10 May 2026 10:51:03 -0700 (PDT)
Received: from groves.. ([95.90.240.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e0bf2sm225215565e9.4.2026.05.10.10.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 10:51:02 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v10 1/4] docs/qcow2: add the zoned format feature
Date: Sun, 10 May 2026 19:50:56 +0200
Message-ID: <20260510175059.311814-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510175059.311814-1-faithilikerun@gmail.com>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x32e.google.com
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
2.43.0


