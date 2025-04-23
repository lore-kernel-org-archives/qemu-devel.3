Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C424C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wdb-0002D1-Ao; Wed, 23 Apr 2025 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wce-0006OE-Hn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wcc-0008Ri-T6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRpUhngwpi2vur6uGX0YLMr4zg93ENMqYIQoB01ZNgk=;
 b=OZz8xpba8huDmOdBv0QMygFyNFYiHSXn6TYR+fhuMiGTKz0F+bi0g6qBsrUtmSTkFhS9Dx
 7WctMsjyGYDifTKP05EmsH080lo19bLS0LUQRcgR32XXgAJngvizWPr9T6lIue7xbGgKTF
 iQiqOAu9dl+zOSyZ0yBQPQnXRTwUEQk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-TbnUk8l0MxuChIS3dP0ghg-1; Wed, 23 Apr 2025 05:42:25 -0400
X-MC-Unique: TbnUk8l0MxuChIS3dP0ghg-1
X-Mimecast-MFC-AGG-ID: TbnUk8l0MxuChIS3dP0ghg_1745401344
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac3c219371bso513691066b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401343; x=1746006143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRpUhngwpi2vur6uGX0YLMr4zg93ENMqYIQoB01ZNgk=;
 b=n20Z5tnh1lGrU76296B1uTnmyGcIe7f0KrndJctCaGBy+1a/l46kNeY+PyACqztGpa
 q8hWbtX4u6+okgrNAjtTL+JWR2OtQQvkZg4SL5Y63mwRZbhb22CNm3Mnqb+4K52DL3nO
 goXaCsO8bC6FPeoEu7zEsAdB+fgkqa2hPdUUXSiF8o0xKJgxHY0TuFqywP8u91lGymM0
 +k4yP/NrYxjxVUO1F9j1Ic+XOzfZfOamPl6T3fCLWxC3uiauPnuA/nq1sRmtM37pgMA4
 07zLPyNQ64BSyM6YbjTqV7HvC+YqlMIptuWhrYM36VlXuAOiggIiAX1sthr5MjnKD0kj
 fmqw==
X-Gm-Message-State: AOJu0YyHQxTavTB16brJTrz+S6nqDTJgE5ZxSjtdut6nougildN19ZUT
 CVZfk0jPPBpSgr7lG9nccgQp9jJnAWtcaB58IH5o24qI4FSRbuxlrvM1ke5sSIKaRD7QWJhINxm
 yint7ZUHFuqOO/l5AZtpZqmmrSC0ZLEWqqnkKS339UuAwjZfvxuPOvHn2RA/hq9HdtqBuWebvCZ
 14JM24K8T0WR5EdkoM9KcNmG/PW+3g9d3pXkYh
X-Gm-Gg: ASbGncsjcKL3uKcPaRwDSvKvXQQik1x/8PJ007BjqJWiVf9EqIfw7Sz+o1rtcNf1l5P
 zoAKTNOjpmfOnm9mU3Yw/9t34QahefifIdXyGL3vcaZoSztYVrVDdNAg5d5vpF6jnHSd7Uw7QJh
 SOAcIGg3HfZjdA3KHov3qdkfxmznh1S1WUeER3u0uxUeuSGxAU3sHFRNbJsnF+n4WN+qvJPxNFL
 VrbuJSBRVNj8oPqE57nJPXmM7KFcYXMxpS682UfAzEtaPUZzEAPy6G8Gtpc+S6HrhFx9Uv4bbd1
 ndhNHnx+nPrhQWVw
X-Received: by 2002:a17:906:79d8:b0:acb:b0d7:15d8 with SMTP id
 a640c23a62f3a-acbb0d719c8mr693505466b.51.1745401342931; 
 Wed, 23 Apr 2025 02:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq9LEFbFME1fTQE8Winf5FmuCeYOl5swd8Kmw+5wkR4opkXwEWPUMyP58Iet352MTWoiWCzQ==
X-Received: by 2002:a17:906:79d8:b0:acb:b0d7:15d8 with SMTP id
 a640c23a62f3a-acbb0d719c8mr693503466b.51.1745401342477; 
 Wed, 23 Apr 2025 02:42:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec0c068sm791793966b.11.2025.04.23.02.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Subject: [PULL 34/34] rust/hw/char/pl011: Extract DR write logic into separate
 function
Date: Wed, 23 Apr 2025 11:41:04 +0200
Message-ID: <20250423094105.40692-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Rakesh Jeyasingh <rakeshjb010@gmail.com>

- Split `write()` DR case into `write_data_register()`

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Link: https://lore.kernel.org/r/20250407181327.171563-3-rakeshjb010@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 87153cdae13..bb2a0f207a5 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -221,12 +221,7 @@ pub(self) fn write(
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
         match offset {
-            DR => {
-                // interrupts always checked
-                let _ = self.loopback_tx(value.into());
-                self.int_level |= Interrupt::TX.0;
-                return true;
-            }
+            DR => return self.write_data_register(value),
             RSR => {
                 self.receive_status_error_clear = 0.into();
             }
@@ -307,6 +302,13 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
         u32::from(c)
     }
 
+    fn write_data_register(&mut self, value: u32) -> bool {
+        // interrupts always checked
+        let _ = self.loopback_tx(value.into());
+        self.int_level |= Interrupt::TX.0;
+        true
+    }
+
     #[inline]
     #[must_use]
     fn loopback_tx(&mut self, value: registers::Data) -> bool {
-- 
2.49.0


