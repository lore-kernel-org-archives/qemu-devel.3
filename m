Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7008ACCD182
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFH-00022P-O8; Sun, 05 Oct 2025 15:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEp-0000Lc-VE
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEo-0006YA-12
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ml2pFyRHG+5Bce2r6KPnxhJb7q8qJwL1Tv/Mz3Zw5Ls=;
 b=T9HPp4m5UV8eG7PSON/9yYUwZEadOjNhrMhWKwiAeF809pUMXKeHPkiC27yaQYWS9phGgS
 dpVDDg7an3UxvvL735bx69rCs2Rx4jBKXrqMX3Yae4eNg9FXqi38hzADo/wmBhO/LUW4pF
 xcEwfavaoPH6Lp1tDIeaoix1KPi7vu8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-HKJN_48YO4WlCkbFmeOOqA-1; Sun, 05 Oct 2025 15:17:40 -0400
X-MC-Unique: HKJN_48YO4WlCkbFmeOOqA-1
X-Mimecast-MFC-AGG-ID: HKJN_48YO4WlCkbFmeOOqA_1759691859
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3efa77de998so2422407f8f.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691859; x=1760296659;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ml2pFyRHG+5Bce2r6KPnxhJb7q8qJwL1Tv/Mz3Zw5Ls=;
 b=rTquNMCF8HFHp/wkHetit+ZgIQywc34cWGd83e/DA7kLHF8DbJkqF2l46BF8ZIwAhw
 vFnFZOy+4TYU2oh4Vrzw7UvTrwiows5a/DhJDWOcwuM8wzLNY2u5WI60UwlSmSDzKf4V
 wOb+AgnkrzQs+QqrOAQ16FDI/Xj8x8rxH4gaCZwamP0KaeLyaUCzZur6Fi1SHf39lfco
 Pafz8ONUFkTeNhBeRqjZqelVB62X/Zc5wLNeH5CWzmRfwJPhdPOdMZ2CJo8gHcQTfNMR
 spjPbzSjeqMuA8RycAGTYU7uSoS70nLyD+8AZhN3kPO60xlFpbgQ+mmYYhQ7K1eHtnLA
 k3ag==
X-Gm-Message-State: AOJu0YwxGvxLolAhDTLMlt+4sFNG/v2ZCXOvFpMXzG9UPpCCucRlmc1i
 WAMvfanyhb4GOfG1dulnpOtrvamzmZMh/cgyGDaEG+Llr66cQMEbwjsmyoVxgLQ0aceGnqe/NXj
 6orlfk7PL0Ss8fSAo1xpmWmWYkAnVUff24uk+LKInYNGhADZ/7P+zXypkB5sQdci8BqDExWMreV
 SKMsfHGEWz8UFdw4ooQ1FYbLxWAZjNTdRv2A==
X-Gm-Gg: ASbGncuRegTth6YnBUC7GJ3yp6UN0bA4rl49Cr5n5X4NPm244rmKxojZz3jvbNdPgcn
 9E7jLji59riHp4mZtkplhtqLzB/702DHrdrHAnRCQ+CDttpdH65jqofyIRqaAlQ00BCd5MNvZdN
 r5HCBNB4BuLxmHZInqkkssaPWItSc3u1AxTDlPHJh3T86TsuBmrZf4u14IbQcCY8EjG4nflEYjk
 uxmbxJ+xNtwvklsjtiuSV421LjgvcUATrodmkfNuaTqHoqMIHwkiwqlimO1Qo6Igt1uBEFlunP7
 GncAxplOpIV1kMn2DsTLX9xCxWmxxiC+Grl/QD0=
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e71147470mr70617265e9.30.1759691858955; 
 Sun, 05 Oct 2025 12:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEocTYVD3Zo4TaQuwGW2gr/V5ZX8yY3DnPRKTTtMy4X0M78zGcVL/zOtaT54s2UT+a6t9zig==
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e71147470mr70617115e9.30.1759691858416; 
 Sun, 05 Oct 2025 12:17:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm17544030f8f.3.2025.10.05.12.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:37 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 42/75] x86: ich9: fix default value of 'No Reboot' bit in GCS
Message-ID: <b10166b104fad54d5d79024beafe1bcfe8a35c4a.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

[2] initialized 'No Reboot' bit to 1 by default. And due to quirk it happened
to work with linux iTCO_wdt driver (which clears it on module load).

However spec [1] states:
"
R/W. This bit is set when the “No Reboot” strap (SPKR pin on
ICH9) is sampled high on PWROK.
"

So it should be set only when  '-global ICH9-LPC.noreboot=true' and cleared
when it's false (which should be default).

Fix it to behave according to spec and set 'No Reboot' bit only when
'-global ICH9-LPC.noreboot=true'.

1)
Intel I/O Controller Hub 9 (ICH9) Family Datasheet (rev: 004)
2)

Fixes: 920557971b6 (ich9: add TCO interface emulation)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250922132600.562193-1-imammedo@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/ich9.h | 2 +-
 hw/isa/lpc_ich9.c             | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 1e231e89c9..2c35dd0484 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -95,7 +95,7 @@ struct ICH9LPCState {
 #define ICH9_CC_OIC                             0x31FF
 #define ICH9_CC_OIC_AEN                         0x1
 #define ICH9_CC_GCS                             0x3410
-#define ICH9_CC_GCS_DEFAULT                     0x00000020
+#define ICH9_CC_GCS_DEFAULT                     0x00000000
 #define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
 
 /* D28:F[0-5] */
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 304dffac32..c9cb8f7779 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -132,6 +132,11 @@ static void ich9_cc_init(ICH9LPCState *lpc)
 static void ich9_cc_reset(ICH9LPCState *lpc)
 {
     uint8_t *c = lpc->chip_config;
+    uint32_t gcs = ICH9_CC_GCS_DEFAULT;
+
+    if (lpc->pin_strap.spkr_hi) {
+        gcs |= ICH9_CC_GCS_NO_REBOOT;
+    }
 
     memset(lpc->chip_config, 0, sizeof(lpc->chip_config));
 
@@ -142,7 +147,7 @@ static void ich9_cc_reset(ICH9LPCState *lpc)
     pci_set_long(c + ICH9_CC_D27IR, ICH9_CC_DIR_DEFAULT);
     pci_set_long(c + ICH9_CC_D26IR, ICH9_CC_DIR_DEFAULT);
     pci_set_long(c + ICH9_CC_D25IR, ICH9_CC_DIR_DEFAULT);
-    pci_set_long(c + ICH9_CC_GCS, ICH9_CC_GCS_DEFAULT);
+    pci_set_long(c + ICH9_CC_GCS, gcs);
 
     ich9_cc_update(lpc);
 }
-- 
MST


