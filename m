Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51822C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8L1-0001um-TW; Thu, 25 Jul 2024 19:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kq-0001H7-Ly; Thu, 25 Jul 2024 19:57:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ko-0001NY-Bh; Thu, 25 Jul 2024 19:57:23 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb585375f6so303122a91.3; 
 Thu, 25 Jul 2024 16:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951840; x=1722556640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+87aLDu/AZjA6A8xbSUdBt1RgtjjD/tVl2VZXlpWFaU=;
 b=GeXIh9I8+VxbHnXAAJazJ5ve955uQUPhRUaiPipP7dXd0+UaxaEh9+ntJnzg5z5Z1O
 akbgerZIKlKEgExZS9gVTdFP57arqcqTP9u69yb8QPMyu/cBrc/Kse6cZrXjyRif5bgl
 /qDWoArWZ4dwL/grqBPDOE7+I13hx99IF+Su2jBQPkq9U7wxbSoxRog6Uca/MX8I6Tu3
 ACY0XWc0z2c+3CRmM3sVXcQxi81XJ1333hJi7EcSS60FzE5XyZQxQ+F2K1FF5o930Eef
 IFjpUa/Hncr3ZRB6pyoka1pA9EcMjI4q1LtpNPvtJI5U1Bk0frNwqG7Mvh9yMaATX8Yq
 VaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951840; x=1722556640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+87aLDu/AZjA6A8xbSUdBt1RgtjjD/tVl2VZXlpWFaU=;
 b=dieO+7m6U93FjzDjpo1/0bF6Gb7j3wEZQ0zo9iWg11hgS/0S/kdmXRn5cECBiv1n8L
 8HmEOBuJEAjHoacBgPnJXq3foOch6AWOJPdy2L6S8B3UU/IaF0BsvJKWbPQThtF5Az0F
 xaPz6LpEnm2asHHuB2oMoaEz06Xmqp4IkBZT9iKPQ/zCCsG0uOQdKcFjfksXMZPtYVvu
 cY5dsoDRBZ6XknwUYGQhPEOYFxCzjpXbLa+bzWAkfZZsncoRWR6BEfYBT1jyMk14rc92
 rwmdH3sKAATcs331jOvhaFV3/VgOd94bh8pQB8HnuV4yy+YcenYfWPRVC0mrJaSgdEvo
 0S7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ39Q4roNMX3klFoq5bzTQztvupIvwQ+hpu2h7Ke0CdT5xDizjuuYj5fyJjafHlRgGBvqECB6sJMEfS9PsG5QHIXkg
X-Gm-Message-State: AOJu0YwbNVQcvWlJIXvI4cxrTBy9SpDAAJotMO+pYkclzMrsmbhwJYLL
 FzaJ3V9gN7ip7Fasv7UZb1fYO+haB1sD0KfWjEA0BP57V8zqnPGhFi0RcQ==
X-Google-Smtp-Source: AGHT+IFfWMOI7949SOzS96XZADOYijxVTWtqbXDrHoEfRPWveKEXCzzOyWxBY8GFgv3k9PvcTGpERw==
X-Received: by 2002:a17:90a:f311:b0:2c9:7cf3:4aea with SMTP id
 98e67ed59e1d1-2cf237a2a2bmr5548968a91.17.1721951840463; 
 Thu, 25 Jul 2024 16:57:20 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 49/96] pnv/xive2: Fail VST entry address computation if table
 has no VSD
Date: Fri, 26 Jul 2024 09:53:22 +1000
Message-ID: <20240725235410.451624-50-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Fail VST entry address computation if firmware doesn't define a descriptor
for one of the Virtualization Structure Tables (VST), there's no point in
trying to compute the address of its entry.  Abort the operation and log
an error.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 08b9166a09..9fbd44f974 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -244,6 +244,11 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
     }
 
     vsd = xive->vsds[type][blk];
+    if (vsd == 0) {
+        xive2_error(xive, "VST: vsd == 0 block id %d for VST %s %d !?",
+                   blk, info->name, idx);
+        return 0;
+    }
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
-- 
2.45.2


