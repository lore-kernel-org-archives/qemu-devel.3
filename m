Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5C6CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAQh-0002XJ-TA; Mon, 01 Jun 2026 17:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUAQf-0002W3-Pf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:44:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUAQd-0001mw-WD
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:44:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso3000661f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780350250; x=1780955050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgEwgmGCCqbMf1H+1FkphVRc+TsRQBb20ovgYmFyBEU=;
 b=ggzfzd4Kd5OQtCGNaB1ZS0HFw4jnBrc5VNu0aGMS03v8P5mYFT1Vw9VkyMlcimhbGk
 FkfrskIzDjYw962oi2LDqz1B4s9umv3ZutPe8z0msf/Ex4raUSZjlMMMQH3w8Om/S23o
 KwCsEaRLXq1FjX3qzixrUVUnIo1qd2qV8zyD4w7SIG5Pv9LECW+caNZbZU2hNTQE0RqK
 0JBfa18eFczV60QpiFJgm6SlRFbysQ1a4L4KZ41/wBiq6SD6FkdXdl4H0inn1xrHExQO
 JeeQkFaUum95npJxX8fu/NXQleM4TgZXhIwW11ZdcuGK6KVi82o1h7IAvDebVSL5atu+
 2tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780350250; x=1780955050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cgEwgmGCCqbMf1H+1FkphVRc+TsRQBb20ovgYmFyBEU=;
 b=EEVFU+zpMJXXYWusBuwUgm1aQeb2MQCZkV/rUAw3fb5jZ+ltGhK82gWBgkqJmG6iAi
 aOZvTKKMAn/aIsQdz/ckFwrmRXt2XmfT1DU3l/7K9t+8DJ6b68UkqnlvV+hD+BoWNQnX
 h/A9Z/pTJfnQ/GZbVVri8Zyfbd1oGZUyQqUc90hlrPQsu/6y7gHgKIWE55Kk+gAGwhKv
 XxVbSJkSQT0vuxmHok3xEa8+ezHRrT6bklW5rOIogBYafI1QFw/6s/M05pEzrL9VZCz6
 cEEMWwVWlKfuv2A2Swrh98BtItbbdaEKthgkU4a56pSV9Py+Ps890F31lBggDIRfiiFq
 mqqQ==
X-Gm-Message-State: AOJu0Yy4qmhkNQOYh5246FBz6uXKkNswAZhciyyHNLQXi3GXDSg6utZq
 YSe7rwhu/LVzs2ecaXoNSmtS1L5Y0MVOfnKgfPCvfR4L3dG0Hed8XXL94YjF2o+vobU=
X-Gm-Gg: Acq92OHO+M1a+UenaBGIxGd3tUT75922l7py2EmcbsPNvbTbm64EfftA//r1FgjAyxh
 2gKH+A98keRP2/TWUi06mxq1Q5DgTEPfkZVjAcX6+1y+kc3W4BY9inOqz/QF57oU55JeZr8PC+Q
 xM1a3g8Dqar8pub123JUj7T26EWFpCrjfsgTXAIJVeqecVxwDXoZ265qpjtjnXSQZ+5UacAUzE4
 rrb1D5qaLbtF+XND+GP3zQvvFeVPxw3PRNvpybfgvwzeY+o6vCMsHV+C9t5b1IqlVv24NxywMTI
 a61hgiWmSYJdXkBPQ+toQmQpM3lPF0/tHC7BnCspbsLKxJ+K39dR+KZO1neHoI16ruxU3QHvpjp
 bAJynB27e8MWeWnp5zyR8uzoxX5k3jEKesdJPY0Wh942QVJFJVneESZJVkfM50EimYFOPJY39C+
 6624hnt8V1+qE02bMHuMPwuTmEzWK9159RRKYbgpWeXmhH2ZvneW8GsRx1JYNxgNCKhw==
X-Received: by 2002:a5d:674d:0:b0:44b:7ec9:2d76 with SMTP id
 ffacd0b85a97d-45ef6ae9810mr18901585f8f.7.1780350250275; 
 Mon, 01 Jun 2026 14:44:10 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:595:8cac:dffc:932f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356b129sm35423496f8f.32.2026.06.01.14.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:44:09 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>, hare@suse.de,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v11 1/5] docs/qcow2: add the zoned format feature
Date: Mon,  1 Jun 2026 23:44:01 +0200
Message-ID: <20260601214405.252818-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601214405.252818-1-faithilikerun@gmail.com>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x435.google.com
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


