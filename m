Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75814CF6499
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sutYU-0002Qe-LZ; Sun, 29 Sep 2024 09:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYS-0002LJ-8D; Sun, 29 Sep 2024 09:01:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYQ-000436-KS; Sun, 29 Sep 2024 09:01:39 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so518692266b.0; 
 Sun, 29 Sep 2024 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727614896; x=1728219696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kryi+fy6xb/vxObzPubhypuq1lcb7jsR8Hf10l3A+fI=;
 b=XS2uAssiCN4Wp6Rjw3tX0vZU3IqV01Snk8SJdIb4QLhDBlJaiXTBY3nMRs4nX6s6v/
 QFU7e8DV0ullMtD5eQha+t24QiCyXXF5GwaZq3HTxmK4oBA72PndCGGZ3D1W/9nVQQWB
 QqDI9gAm0+Nn87yFLeNHapvqq2HCaacjYpTZu5+TbPtxz1kTHXue4QzxP6Mjk75cXxVB
 zZdB7hQZqV2Fd/6l8pideX+LBdgPWseQPRQMVQYkofOPJd9MFLES6r6TA8P/duvipiUG
 goTT9dbTmu2TsRvR66poR4FyK5y6OV2C1/PNiPfLw1Pq0is6zbmCETu0bibdIUsz3gvt
 4B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727614896; x=1728219696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kryi+fy6xb/vxObzPubhypuq1lcb7jsR8Hf10l3A+fI=;
 b=ewEVSCkBEdW7cJDHL8sdxvtbhwPA3wYwSqLShjl5lzQL1AMfaf1P1TQ6MpLG88lFT0
 upQcULLSc7ZERRCcihq6ntRARVxWRsqZQaRVct82IYN6EluSl4cbmjIZIS5N//XNRpFg
 Z3H6hoXmYob7cvzV+QhNU2WNAb1YRVg79+DR8Baxa/Ctgo6iai+ebKBv2HcaSgUApM82
 82AHGwDBfTOXr8GgulN7yFd2THLQHL2gc4xueMVvf683/T1NmfpQ2ahx3akbvWmFJ69V
 gi3FQA9Xh3q98P02wqi/ukfZVo84oQSFo+a6hF/tlqypq8LkrSb8ItISdnPc5pvzg5VA
 8bVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrU6xOkUfA+H/MceaNUTvwHMhomwjHNeE03Iabb82UJnYKmNaTTVGJY0UdHsqn61OJrvMhhdYmNt+A@nongnu.org
X-Gm-Message-State: AOJu0YygXul9UziXLICWPwV9C8bqa0NR+mRJEcYV6K45kfshbnE4SmSe
 g46Efo/eEQyz274k6nkZKahNVyqvXhR8KPT0cG1FkcuCh13MyGcMgaRboeb+
X-Google-Smtp-Source: AGHT+IG4Q+kSDwrNwDst329bfCz/4yd7D9QOO08jQNwWSMSxRlT/vhyUwoW10H22bzAdtNg+8h6UBg==
X-Received: by 2002:a17:906:c143:b0:a8d:2a46:6068 with SMTP id
 a640c23a62f3a-a93c4961714mr909594866b.39.1727614896085; 
 Sun, 29 Sep 2024 06:01:36 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27776cesm373146966b.40.2024.09.29.06.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:01:35 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
X-Google-Original-From: Sam Li <jia.li@ionos.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, hare@suse.de,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v8 1/4] docs/qcow2: add the zoned format feature
Date: Sun, 29 Sep 2024 15:01:30 +0200
Message-Id: <20240929130133.535568-2-jia.li@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929130133.535568-1-jia.li@ionos.com>
References: <20240929130133.535568-1-jia.li@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x62d.google.com
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

From: Sam Li <faithilikerun@gmail.com>

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


