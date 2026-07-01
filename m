Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0D4C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wezYT-00087U-7l; Wed, 01 Jul 2026 14:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYR-00086s-Db
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:59 -0400
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYQ-0007Ny-07
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:59 -0400
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-380a00aae61so664278a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782930057; x=1783534857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owmkKHbIcXAuoU6ZOyy29E3Q7cNJi9sW3UC/cj3gxuw=;
 b=mBKNNUZk86+9ifTfkVL+W/o5F2Jjmpo9WCWvXkydFKD+AQ+ZgzzpeN67seFagkXINP
 99z5CUxG9DqaGGbs38/WYT8y2C7Oc0NfpxSymaEwVhEAyq/pLK0vrHqHn09tf368MVfw
 5P2yBHeCY7TR21drMIc57JJeJa5c1ylJYOjqZpebx4blJDV5go34+I3Cg5A60IW7YjLr
 WT3ezY6tvdgIx/fRjRluPb4BBo6X3ExRPQnC4LzV1c+YGqHsk84/YGTI8enYMGO0Nikx
 gndpE6IGH/tPeXVlAxERlUwRyIKXfrnxcfq1ROtXdiPe4G1vPxPA4WpxTltwac0ikH0D
 K8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930057; x=1783534857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=owmkKHbIcXAuoU6ZOyy29E3Q7cNJi9sW3UC/cj3gxuw=;
 b=clcmawWf68hd/4TrQjknGP0e28xKdSdABmpXj2w5jPv65qdKj0W9tmk8yd1/WMx0ng
 d9If2WGi6bIdW0WmkDqXJ2AzBVdjUhs5FMBr+nP1h6JOP1zKiM7B7RPRDyph+Pq8iDIb
 UC2iw2sY7KD3ERLQUvYHQuRA0q2G0NqJfT94DV4bZwS4kBl7pYT46CotDwg9ADdH8Oy3
 QworcL8r+NuBAhWU9zlTH5P+tz8O7ylfl2i31+Y6bnIkOeiGwPxfuWSc61zIGj+jnwF6
 jh0cIR071oczjmUW98xzOxLULNQ1OQcTaSvpkDjIJkzpYPpGFU80U0j0QPghRhPFsZAx
 y/Dw==
X-Gm-Message-State: AOJu0YzZBNx7xdhjbR5rMs7fn4O/kqrDzDmvIIInMu+Cjg2EQCg/bGRb
 X7LIHybXSp762IGE6toxEM/Cu8N9hHQmLWEMRwX7eCEhSkL96ZL0fdQKZzImaqndSg==
X-Gm-Gg: AfdE7ckaU76puxsmuHg5S8u+jP50C6LH6vA7zckGZLPrbqP04LBn6SA/D6yZPfVhSne
 VTFGpTfT5F7g6+WoPZtnY+/5OkWPKVSEMKIXMRQBxkhxeiQC0E9y6sUf5r+h/Yn8Tx3ceepLVOT
 noAgC8Onx/VZjrxAhgzhEeevPHa6U+DGp1qNBwms/hO2s2e0xxEP0AzP1KGkYTokUK4yFcVS/Vh
 X+pyxGg6iLVpPuLZ0f0nwcdtry/tlzQFPpa7h//t2j6aTIGbeb8OzI6Lj3H7oqzGQfbrMaTG/Ct
 jVWKAJRBvWs6rj74z7oH0vdX64y40WaV0Eoq7Tsc9U0UcBeeEB6Zv5QAKkp5WRDnXjyE/1/gBAf
 8uvsC96NXlrn4iosfgp6ASwQPDFDSvrMfnqn5mp9/cDtycCtKX4ZqPaaX9C5qUM4rVkIUQ2cjVU
 7leBdwpyo4dMkwH4ixNw==
X-Received: by 2002:a17:90b:2683:b0:37f:9ce3:ca92 with SMTP id
 98e67ed59e1d1-380aa1d77e1mr2483798a91.27.1782930056681; 
 Wed, 01 Jul 2026 11:20:56 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590:494:7c85:ae9c:cba8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm187109eec.27.2026.07.01.11.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:20:56 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v4 3/4] vfio/igd: Setup romfile_fixup hook
Date: Thu,  2 Jul 2026 02:20:34 +0800
Message-ID: <20260701182035.96010-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701182035.96010-1-tomitamoeko@gmail.com>
References: <20260701182035.96010-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x02.google.com
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

Install vfio_igd_legacy_rom_quirk() as the PCIDevice romfile_fixup hook
when romfile is set so that a romfile-supplied VBIOS receives the same
IGD fixup as the image read from the kernel ROM BAR.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f597218164..6fa8b26201 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -610,6 +610,10 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    if (pdev->romfile) {
+        pdev->romfile_fixup = vfio_igd_legacy_rom_quirk;
+    }
+
     /*
      * ASLS (OpRegion address) is read-only, emulated
      * It contains HPA, guest firmware need to reprogram it with GPA.
-- 
2.53.0


