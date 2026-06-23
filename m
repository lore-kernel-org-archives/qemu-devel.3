Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C997FCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6BB-0003At-I7; Tue, 23 Jun 2026 14:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6As-00038J-4p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ao-0001sc-1N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so188696f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782240515; x=1782845315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgEwgmGCCqbMf1H+1FkphVRc+TsRQBb20ovgYmFyBEU=;
 b=CpDXugqwwwpSbWDiwldqRSCgQzq4HgBhNp/a8b10Py0Nig3K+3PNEx9WqP1975s5Nv
 KYfJgf81Lg294VGaVjVKvcbyVq9yeZWP8reAaWKZz3pfNz8+Qu5Qy83mE+D45ONuzxtf
 3UmPJzlv757bkXG4dUiR+SNld0juA0RPJKOYyVopyDrp2lUYFHhLyuECOpthboRfpUUk
 bt2CJ1v7xR8yjf+NDR1v0Sq0AyXOtAdzPiICpfmp7QEQ4N68U65QISK9tjBpmoZAzYA0
 hcQFKxIiJZ8lvRR+cdf74vAh3wfE8pTEubWaNT10e32E10E4SFr4K4IgYh8sz9CHB38i
 rXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240515; x=1782845315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cgEwgmGCCqbMf1H+1FkphVRc+TsRQBb20ovgYmFyBEU=;
 b=dgnH0to4IRvkmesvoOQuGT+ECUc95ubYmwdyIrEBY7+cqDUl7EHiypOS/Wm4kQ0+Dq
 Bhrc1v1hvc1myOpe4VVqHsFP/OrSi7JuP387/tZwDVe2eLGbXxl1SR7Th9mIk+fM1j3w
 u0qOZqpUiW2YHLyISX6UKn4otfBD+6iauQW5/py1cUzzOeyLSP22BvL5GPLEMmHKq6j8
 jsAlgXhpsQyonX/0lSuGiL3mq1BXKypxCg0SSNp61AuKUXTkpaZOHILjoUlUrSnZnjgD
 jGHi/a9MXxoCf3+/QhLckJMSbVhPhsxDIQtJZTyqdkBzPnXZyY2x3sJrR+vFu+nHYQmG
 S2LQ==
X-Gm-Message-State: AOJu0Yzj8LrBVBjJn4Jbe/pPFsgATFp4Vz2S5ZlE6GNpGiRV3JvYv3aF
 4uvX6vegrcsXp4gmK6SHnMi9zzlkik+XZXP+7AEkHR+g4+g/PGQqug+tqi3Lhg==
X-Gm-Gg: AfdE7claRY3Kr9mNwolxKzFS5aoboURJfTzj1NuFq6X3kieUlehHQXjkV2Fn/TjfheF
 N2A+dMznRfZ7OoTWbQVBCjrw646ABqfgutvLd76+qLWBzhDiU3J+GJSea1n8Yc6CRh+PLsz6oWT
 e6rr12soT3fmOE5UhUBfEPagpluopManH1KCOVKeM3jDr5ZfCGYVJJvo6q9FNn8X++zpZ4ZZH1s
 6EWbMxRxEEwB2Dev7QaFRmcRfAN3belJtxu/Y2u7t0TYmAZwqe3SL3bphPILOaHrBrz9bxQUMuo
 0YLIR2E0MYGsu4qy/CpP4oyj37F1iUf17XcTPCFZOJVIcBsI2Le2vgtN1w2KmSzSxhTpNwnGXG5
 uD9HM86Esjo0F6klHXsgvPbwTiTumHNUfnFDGv3GsLLHPKqPOoqdim3SK+V5x1sUGdACXd0xvAa
 /5iQMczLmMxu/rcB8TXm3+gLmtjpFWM04UWt+HT2c5KH/APg==
X-Received: by 2002:a5d:5f43:0:b0:460:1f32:628d with SMTP id
 ffacd0b85a97d-46c04ff8b73mr242944f8f.11.1782240514960; 
 Tue, 23 Jun 2026 11:48:34 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:75bc:d765:f335:35fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f563dsm34644603f8f.3.2026.06.23.11.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:48:34 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v12 1/5] docs/qcow2: add the zoned format feature
Date: Tue, 23 Jun 2026 20:48:26 +0200
Message-ID: <20260623184830.373232-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623184830.373232-1-faithilikerun@gmail.com>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 docs/system/qemu-block-drivers.rst.inc | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 675daa72f9..1af968c4fd 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,53 @@ This section describes each format and the options that are supported for it.
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
+    The limit of the zones with implicit open, explicit open or closed state.
+
+    The max active zones must be less or equal to the number of SWR
+    (sequential write required) zones of the device. Defaults to ``0``,
+    meaning no limit.
+
+  .. option:: zone.max_open_zones
+
+    The maximal allowed open zones. The max open zones must not be larger than
+    the max active zones. Defaults to ``zone.max_active_zones`` if that is
+    set, otherwise ``0`` (no limit).
+
+    If the limits of open zones or active zones are equal to the number of
+    SWR zones, then it is the same as having no limits.
+
+  .. option:: zone.max_append_bytes
+
+    The number of bytes in a zone append request that can be issued to the
+    device. It must be 512-byte aligned and less than the zone capacity.
+    Defaults to ``64 KiB``.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.53.0


