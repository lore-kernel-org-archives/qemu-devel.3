Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CC8C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udo8a-0004wl-GK; Mon, 21 Jul 2025 06:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1udo8V-0004pu-Md
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1udo8T-0002CW-S3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753095163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SKZhYrhLklT7wy5r7XGVHBie6wvhRMRWF/tewAfL1Jk=;
 b=R6Vo4YzkVUkaHFwhvRU1TKQVAyApo1QuRDiuvVa3YUBTVPGCgFupz5Q8a0EdAN6ygC6r3n
 56Da2+2n3smuzveZXLZQOBF9o5eVaRcTec/nBYhbvABZevXNDjTFIVMXMZEwq6U8KJyDV6
 IM5w9jIaeNQed/OqyIOunaEpiMjuCQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-wPqHimsPOFKVHNwtZaLPog-1; Mon, 21 Jul 2025 06:52:42 -0400
X-MC-Unique: wPqHimsPOFKVHNwtZaLPog-1
X-Mimecast-MFC-AGG-ID: wPqHimsPOFKVHNwtZaLPog_1753095161
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so22234775e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 03:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753095160; x=1753699960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKZhYrhLklT7wy5r7XGVHBie6wvhRMRWF/tewAfL1Jk=;
 b=i+jRak9uENQRJUaq814CtwDQzy0mNWNzmLqFFUlaXllelesNuQI00diUB/nVQ1zoQ5
 Jot7S0YMLb66EkGjIYSEPmYAqZFK91YSZ0JjIfjpeVmO0DiIzIfyCKeUOZ25lMZ5Kjmk
 bRu9Z3OhYQJCymYESUy7w44chPGB4eFlmhHOa1AJtF5j3D9V13eVaHnGaJy4hKCaHvL3
 9P4TVjFook4JYT4wM2VN9tSAv8hsy9h/ravVbxECYrfoF1bFkcf/AoJZSU7s6ErFpV3I
 qyv58GewocwMPggv244/opPxvnGcIrwXFWB1DWOty33r6gtypOLj+s/+AwEtVfRkSLmx
 Fq0g==
X-Gm-Message-State: AOJu0YwZwOwRBwOImRk7OaHkzk7Yng4eYav2dN4g+RML1U0bmK9ISacM
 lkivjQsoUtZ7FTEjcVLshNh2/A4pH5mchz3MjS/MN3RGiOy3ami+fPTQtELBWZdZrnKjRcpREMD
 O9P1D2vq4d+KD/+HCX6fZL5k892dASQEk5/qOZPY2I8a3nijJGuMpjjHPx1Dmf9v4Bb0yhHnCpb
 BDffgZaIzTaao/auVGphdvHeK+1/2SqVobQiCqAvqp
X-Gm-Gg: ASbGncsgSvkn3Kib/YiCY0Ag5BAY4NstECn3LwjLdeA5ZzrhBXzNsB2ULBe3tEBVl0j
 BvoB6s0OZTMFVdw72kWql7MNpaS4ov1sOn4rlevi5/hiu4Jg1ucBPsZiJ9tfRLLe6H0bMsFnq/x
 qulPGgMLIEBsFp87rKs5d3ipYuJyBGacRbdGv2uzIVGVFQbXrUIbH9AIcxGS/H6y7Ou31Muc2Dg
 HOzajYImTNeB4FJFaUNn99r+VLONCmryjCtcZ3GzmTMVg+G/XhNaEdvjd5bZ7RdY21wnXm4E2G4
 BMVYChLYodHdHBuRFDZKFQ5NNttBhN94F5mfQQGX//Q=
X-Received: by 2002:a05:600c:3d96:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4562e3548f0mr236287075e9.10.1753095160564; 
 Mon, 21 Jul 2025 03:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF380oqN9iIkN4CvENPijA20YfTvZfRqEV1lKgxIilS3tOzmQTVhWO176QuhwEitXQeJ85ZYQ==
X-Received: by 2002:a05:600c:3d96:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4562e3548f0mr236286745e9.10.1753095160141; 
 Mon, 21 Jul 2025 03:52:40 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c9edsm10155226f8f.88.2025.07.21.03.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 03:52:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: devices are not staticlibs
Date: Mon, 21 Jul 2025 12:52:38 +0200
Message-ID: <20250721105238.461477-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is only cosmetic for now, but hopefully later on Meson will parse more
of Cargo.toml.  Devices are linked into a staticlib but are not staticlibs
themselves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.toml | 3 ---
 rust/hw/timer/hpet/Cargo.toml | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 003ef9613d4..88ef110507d 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -12,9 +12,6 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
-[lib]
-crate-type = ["staticlib"]
-
 [dependencies]
 bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 6f075027843..ac5df23c1d0 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -10,9 +10,6 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
-[lib]
-crate-type = ["staticlib"]
-
 [dependencies]
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
-- 
2.50.1


