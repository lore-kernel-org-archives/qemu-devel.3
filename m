Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C32C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoC-0006cD-6b; Fri, 20 Jun 2025 12:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo7-0006ar-QX
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo6-0000Hp-7u
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMGhYnZFHX5IefyrfK9nBnHDbZhTF5W9KaGEmJ1RYIY=;
 b=Pb2iN/kGRtq/jtBEO2B8WzHD34aB6Qj55Kp4YNlTKNcQWcqm5sKHCaLn7dKgRt0U8Fgo9T
 lFSmcbvSL9n+6ishB35y6D3WAhewYAmPW8Ew+a1IDJoLTm2WLBjJ5bA5032Ow/Q3wbpb7X
 CzC8iKPOkirxj7Yty3TzHG9FM2OOYnw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-uQgv9LSVMKmIfdX1XISmbA-1; Fri, 20 Jun 2025 12:41:36 -0400
X-MC-Unique: uQgv9LSVMKmIfdX1XISmbA-1
X-Mimecast-MFC-AGG-ID: uQgv9LSVMKmIfdX1XISmbA_1750437695
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso164354766b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437694; x=1751042494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMGhYnZFHX5IefyrfK9nBnHDbZhTF5W9KaGEmJ1RYIY=;
 b=nMn5Plr5EyMtCnoNW4qEgsDyD6YyFInejsfkD4pLYYxFU6JfKJzg68llilhOF/ei7d
 +7aw22222w++/Fuhha0VDwFzK/OfpbN0nPaPOFiitTcmlumuqT9/mdA0T/0FLcIurRSW
 Wgxf82uFEa1h+vkEFJbYlI/jTRNNBoMVvIjn2HAnRkL+jWxJ48HfeWqS2Q2PKkjn6mXA
 iVd1Tskg/4pBHCf4iZGx3w4J2atbtghnK+EArG0XqZDy90T/OCDYHQjGqkeLOSBhtcbi
 YIfYRv2Kg5d0Lu+c4U6emA+wapUdjcx/zfg0wgwNzMcuRHKpcrOyUGIoQAPE2vQET2Dg
 SsNA==
X-Gm-Message-State: AOJu0YwWZ3tK5CPbKAbTN1CLF4bry0SGJTSdeqrDPqw3gSIZSZPfXA0b
 o+4MCgsFw+4dGI123XabFQYnSitiEzGqSn3iWSfuJ4h7GY50t8exQaXwQ9Uf01ycXfny2Y2ewyZ
 tDIB0ozy129jxvQwvziqv0Bi0gWuQoz+CoNXAzk4BodUNunOEATT1vRnMdzGrMUJV0ubydgpH79
 1b1e3wxYCJXqKRQjWsXMNOv8K3vTlxO8TSbxOb6tcJ
X-Gm-Gg: ASbGnctDhC9a2x+ayK0Zic0Zoek9CkyJ9xxNlUPB/9ieCDHhjbKfaIyDoG/X26kcE3h
 HKMORQzHsoFpabdezg5V0aRBtFXm+D58kSmd7BETalZyQ4HmKgnWkpoD0uqBRup+5l26jpxELOS
 nXlU+qBZ2CFcpSpMTGkE1dLWWA2rvRh2FAi41hif+jjmVXoYqp4vvNQf6QsgEdtYLWQLedXa2js
 h8UKIahaIKYC0q5++dfINqtwXIrfNgWUprQsZHKjJUaupKR44Hab30mKXH1kpeq1MmpoQ0IQBOT
 jfzegZljGEHUVwkfpneRUAqsGQ==
X-Received: by 2002:a17:907:db15:b0:ade:8d5a:cf37 with SMTP id
 a640c23a62f3a-ae057f2166emr335957566b.44.1750437693806; 
 Fri, 20 Jun 2025 09:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPQJ5Dtib/VLX65pHAXxYw1y9ZXtr1SOopos6qQ00HYRWazdyrZ5sEuoeOrcGhyDruN2uNsg==
X-Received: by 2002:a17:907:db15:b0:ade:8d5a:cf37 with SMTP id
 a640c23a62f3a-ae057f2166emr335955366b.44.1750437693353; 
 Fri, 20 Jun 2025 09:41:33 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e801ccsm185328666b.7.2025.06.20.09.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 14/24] rust: pl011: Add missing logging to match C version
Date: Fri, 20 Jun 2025 18:40:42 +0200
Message-ID: <20250620164053.579416-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20250615112037.11992-4-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 92dc295540e..5b53f2649f1 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -305,6 +305,12 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
     }
 
     fn write_data_register(&mut self, value: u32) -> bool {
+        if !self.control.enable_uart() {
+            log_mask_ln!(Log::GuestError, "PL011 data written to disabled UART");
+        }
+        if !self.control.enable_transmit() {
+            log_mask_ln!(Log::GuestError, "PL011 data written to disabled TX UART");
+        }
         // interrupts always checked
         let _ = self.loopback_tx(value.into());
         self.int_level |= Interrupt::TX;
-- 
2.49.0


