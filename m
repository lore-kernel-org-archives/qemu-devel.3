Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1DC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRRPD-0002uI-VG; Tue, 17 Jun 2025 04:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRRPC-0002u6-0I
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 04:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRRP9-0006ZV-EG
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 04:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750147846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9EqfbV+ZHm5ARvX1NQiJALdFzsoUm+xQx0JBZ3DOigg=;
 b=F/YdPU+kc5s8jk/oQBrpP5PDRfNbH4yvo24uPbfGoIfVIzRRdzioOPFQGGpt6Sup3RCSBA
 Gg9ojA9kbh7Utm/Xnj17HZGwxb99NTVq4GjaeClSR7TY0Rc+jxLG/UUgTi8iTw5LVenoTQ
 FYfoFVs1q2iS2Se7jPL4SyY/dB+xCrQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-Z6USZuatNt6o2inJe2sF0g-1; Tue, 17 Jun 2025 04:10:44 -0400
X-MC-Unique: Z6USZuatNt6o2inJe2sF0g-1
X-Mimecast-MFC-AGG-ID: Z6USZuatNt6o2inJe2sF0g_1750147843
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d290d542so32768125e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 01:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750147842; x=1750752642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9EqfbV+ZHm5ARvX1NQiJALdFzsoUm+xQx0JBZ3DOigg=;
 b=DqsQXnt8Y2AK1o4zv5pT2y8QOOknyaCw5mwXOVxALC1Poc2HlV3yY49BU6y/N36c/y
 MH4MBLoBDiqZ6UGl7DrOmaYVwwV1TBw48y3xP3RatiBdpl9mDuj2+tH3/o8C2rRwihdT
 19Mb/sPbujfPm/uuESh44SOFI1c7nR5sYGjgWSNjSdi5CjJPi5H/cXuWzOrnHHkgt6D3
 shMvXp5Bi5EnM91aYl6LRbzAXUI1x3kSPYvlNO7oxl2Crx8oTBlIziM6sFYeCnTzxK42
 tXJhqpsmSH/X/phit4cm9e+7Ou5maGOmgXF72VEu4OCqs3HpZEFeoChh17r/J5pw4BSC
 9hqw==
X-Gm-Message-State: AOJu0Yz17kb3wSZUGHYpQIJfl+onWp18jMjtomtIEcGnHS/gF8TjfILs
 5ev8BnyMpjWlfLxlziSsDoMFfyWQal5qx5Lyqdow7rKWChJLs4PTuyJSrExdZ+BBHYeOgDWW3e/
 y7eoF49KS8Wx8mUM1pehB5dVXfcsamqSiGjNismJRFejsIk9BNRnWjEj64KZB6pl7oP3Pac1GUa
 O6lGAfCBcKl48JnaMAXWdIlZlccifypf8peqhyqqJ/
X-Gm-Gg: ASbGncuzez0OcHoOs1PWLPMPZDf9/3Cqdutl/tgQ6OejacF2G2BKw4Q/mZBGqyo1xYP
 L7PnHZ/ZxCmIvghhlPtOcNt7OatuWO70+gQIiCsrw8u8dDI2rTP6XbnFH1MM2CKrmqPorNdCrQN
 /lt7V3Qds4jwUJFn1a6+jE1kNc+eMvKwMUIrxj7yWVDipbf5RgqFeKmQ81QNBTZi7FEeZMFSpm3
 1U/YeAxpfFeM64FqOWrQzMOqdTTvmNakt18KRou7v0yObsipT/MXy8BoG64igtSx8Vs5kxz4N1s
 2dxBnG2lwKhGQxw1Dx7Nip6t2P4=
X-Received: by 2002:a05:600c:3541:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-4533ca42734mr112478805e9.6.1750147842042; 
 Tue, 17 Jun 2025 01:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBdAr8uvb+XUyOoOSR5kwqZgLdgJvV7x8P+QD7Svoi6KrGv5Az22SOcWP3si2GDFkX/84LYg==
X-Received: by 2002:a05:600c:3541:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-4533ca42734mr112478375e9.6.1750147841553; 
 Tue, 17 Jun 2025 01:10:41 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.88.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532f2ca228sm169414965e9.13.2025.06.17.01.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 01:10:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, stefanha@redhat.com, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust: hpet: fix new warning
Date: Tue, 17 Jun 2025 10:10:38 +0200
Message-ID: <20250617081038.115099-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

Nightly rustc complains that HPETAddrDecode has a lifetime but it is not
clearly noted that it comes from &self.  Apply the compiler's suggestion
to shut it up.

Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index a281927781e..acf7251029e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -771,7 +771,7 @@ fn reset_hold(&self, _type: ResetType) {
         self.rtc_irq_level.set(0);
     }
 
-    fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
+    fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
         let shift = ((addr & 4) * 8) as u32;
         let len = std::cmp::min(size * 8, 64 - shift);
 
-- 
2.49.0


