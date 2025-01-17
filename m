Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAD1C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidd-0002lD-50; Fri, 17 Jan 2025 04:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidW-0002dJ-8D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidS-0003T1-AH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQr5RCbFdS/oHuH0+9xIml7K7ZNy+hcaQwV4qGT2rv8=;
 b=jH8lxNlFZTlPO0rm7WUyG0rDu/1BSVh5dmeWEMitBxG/D5l3SZ/jPTzLvwq/It41ZkDO+0
 a/ajvdRPynI56dhyvw728l1fL33E2sW6pRnRgx7D9goD9hktPcs1N5lY6eJARdqtvwLr1F
 xfq/q0kvbaxsA67UsMUM50qp+MeAnus=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-D3StjTfANsWSJ4wxWltlhg-1; Fri, 17 Jan 2025 04:27:23 -0500
X-MC-Unique: D3StjTfANsWSJ4wxWltlhg-1
X-Mimecast-MFC-AGG-ID: D3StjTfANsWSJ4wxWltlhg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa689b88293so170728566b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106042; x=1737710842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQr5RCbFdS/oHuH0+9xIml7K7ZNy+hcaQwV4qGT2rv8=;
 b=hP6MUH4fqtW2PBPMgbSYiwZkF/NgUqjJ7sjMzM2wSb5uJvtP53UXTxP6D1lMFmbYFB
 2/rPoiiQGOSjIojp7zxcBVfVlEFpbmgGly4cNHyluA6BbqeopM5GMfHlGhQuAlNZBX1m
 +JTqbv2U+CCJNdMt3F35jBKCUH6RIGp7agoL9g6O3MvuQNkvlvrA7CctPmtaZwSuFGzW
 tGmH43zI069A6NNZ6YC0ljSem0rixxsog4y90LqWNYtKRjRLm4hYF6yxweyVE4RK9d2o
 BgRjhJFoXNquBNXKMTxvQenXtuAisj1AbTNKhanBC4tz/tvBtPqsHVThwRQJPHSvK7zY
 7Ffg==
X-Gm-Message-State: AOJu0Yy1953pPOW0E8JPXE9p69+FRXEpYVgHY1k4T2WQswYMf7OWbEm/
 CljYL4EqKt4rw3iYETZdBRgwLDanY2YI7wuiUCFlIUa5zT6W/9HpItiyHSyi0umBYY9WkfWoJlX
 ZybiKcBbexDDojUpmMrAe2DfheL45uT1XSbaVYEkvttywP5NRhLToKa4ceM4wm4Pwn7tYS6AKDO
 XTynBGE6tXB18SBw7X2hmO++zaxwfZIpkFVPhdcaU=
X-Gm-Gg: ASbGnctvWJATknF9jODpsgEhl7D7yKy1KFKcjhqQACtFdq9NGyGV5FfHY1mbeX06RRb
 rjRIpa1lyDV59k2Oo1hn6n9UF2ZMGwDirNN20Ci9k6xCaen4PMth0Kck5L2m3BdDM5FIWQ1Usx2
 HOCgaWXDE3GPkpQztgpiPrqg/PENCGiOu/QYsGW2lCqtoH/RcXPhAt2cAg14b1v4mHdyZ9cPR5I
 8YniI6bepX59KtUFxTmpLii45uG2TT+3n6kwsyVh/vhEyfPodPbBT6MJ3Jx
X-Received: by 2002:a17:907:7f03:b0:ab2:d96d:6364 with SMTP id
 a640c23a62f3a-ab38b10ade0mr170623166b.18.1737106042097; 
 Fri, 17 Jan 2025 01:27:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSdKkAVtnSSAasBosqLjZLUARijfc4OnYQL6bPMd9C4NKnh3l5NI42h6VDZaIVxZs5bkT+5w==
X-Received: by 2002:a17:907:7f03:b0:ab2:d96d:6364 with SMTP id
 a640c23a62f3a-ab38b10ade0mr170620566b.18.1737106041655; 
 Fri, 17 Jan 2025 01:27:21 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcb5desm135754966b.165.2025.01.17.01.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 10/10] rust: qdev: make reset take a shared reference
Date: Fri, 17 Jan 2025 10:26:57 +0100
Message-ID: <20250117092657.1051233-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117092657.1051233-1-pbonzini@redhat.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Because register reset is within a borrow_mut() call, reset
does not need anymore a mut reference to the PL011State.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qdev.rs        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index af0f451deb2..019c1617807 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -164,7 +164,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
     const REALIZE: Option<fn(&mut Self)> = Some(Self::realize);
-    const RESET: Option<fn(&mut Self)> = Some(Self::reset);
+    const RESET: Option<fn(&Self)> = Some(Self::reset);
 }
 
 impl PL011Registers {
@@ -604,7 +604,7 @@ pub fn realize(&mut self) {
         }
     }
 
-    pub fn reset(&mut self) {
+    pub fn reset(&self) {
         self.regs.borrow_mut().reset();
     }
 
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 686054e737a..4658409bebb 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -30,7 +30,7 @@ pub trait DeviceImpl {
     ///
     /// Rust does not yet support the three-phase reset protocol; this is
     /// usually okay for leaf classes.
-    const RESET: Option<fn(&mut Self)> = None;
+    const RESET: Option<fn(&Self)> = None;
 
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
-- 
2.47.1


