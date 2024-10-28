Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC3CD13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 08:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5L3G-0003j4-S7; Mon, 28 Oct 2024 04:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5L36-0003if-Al
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5L34-00017L-P2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730103864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tsUT3jzMYD5+Mr0ZTkd2XlGREse/Gg+yaEc3jtKi334=;
 b=PbOmVKPusa47xKxdj4L6wtGYaVEZOp4de9l5axVQ+a+/DWwzJ82PZNfGaitzgA8Gs4guJB
 2X/lACKNXQopDx1x0qewN0SoQ3ALvZbJZWJlatTIM7OlD4Ejh0qyDcRP7WxkV1dWj5tZL5
 2Kfq9BHjieAuYfHDHtUFm3N6Pd1mH3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-ikMMh8BfOwmfNYPAZFu0YQ-1; Mon, 28 Oct 2024 04:24:20 -0400
X-MC-Unique: ikMMh8BfOwmfNYPAZFu0YQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso2057705f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 01:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730103859; x=1730708659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tsUT3jzMYD5+Mr0ZTkd2XlGREse/Gg+yaEc3jtKi334=;
 b=YIH3fzQgF7Yjw1xfPYbGYbrvISS1WEcVFqA+KPfHA+rEIGXesAK8QFBfLuAd6kcuS1
 Pp1wTAmZKcn/HjyKxmMAJ6VVPNXf71yzgNghfB4RSizo7A70cr8mhkmla23Z4thZtqpX
 FUKH2y7y6SGM+XvUSlK+7TH7E6S4JpcPgvJwUVcS1ll9b+YiVnlQg0c5NqyTxfnSq4/D
 p39PWvFTm0hZy1mqGpPr646WPrYJNoly5/azPhDPCe/ivqb911tYAujrfleNHRUT7tSl
 uJYBBfUJTHwyeOAfIugmCzSfCxMcxy+SddODT8H/PeMyoz8GIlYL8HD3fPvsyxE+bMZl
 Y6yg==
X-Gm-Message-State: AOJu0YxOItqiK5rIRUEnzmkgfbx5kZteEbKce2Tj18Z0/VVYxmOJKRIm
 HYBcB7RmQjHN2jsBA+bAHk7zKqAG1ZQvcWGNR1DZfTFEjZYYo8wb2ZZGfxuVMo6aeXiaqT8GiIf
 SYPWwBGKPf3Hsv+feNYfuDkdXnnaPU5aqr1sCUfer9RBISwUQvtLDIY0FS1dHcgaLsKPofRxXsk
 +1UhB8YM9Liod9thjV/YAlGFqPMqFWEsLrupTLsTo=
X-Received: by 2002:adf:e38e:0:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-38060f37478mr5216614f8f.24.1730103858916; 
 Mon, 28 Oct 2024 01:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyIt/dM6wqO3F62/P1rbkbmhfi46r7jpCHqzoDkuXisNa9Rsonb+Ep3lk/xJNJq26gC8V2pw==
X-Received: by 2002:adf:e38e:0:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-38060f37478mr5216593f8f.24.1730103858408; 
 Mon, 28 Oct 2024 01:24:18 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b1cc0asm8904672f8f.10.2024.10.28.01.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 01:24:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2] configure, meson: deprecate 32-bit MIPS
Date: Mon, 28 Oct 2024 09:24:16 +0100
Message-ID: <20241028082416.265437-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The mipsel architecture is not available in Debian Trixie, and it will
likely be a hard failure as soon as we drop support for the old Rust
toolchain in Debian Bookworm.  Prepare by deprecating 32-bit little
endian MIPS in QEMU 9.2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst |  2 +-
 docs/about/deprecated.rst      | 12 ++++++++----
 meson.build                    |  8 ++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8fd7da140a3..b779eb54934 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -41,7 +41,7 @@ Those hosts are officially supported, with various accelerators:
      - Accelerators
    * - Arm
      - kvm (64 bit only), tcg, xen
-   * - MIPS (little endian only)
+   * - MIPS (64 bit little endian only)
      - kvm, tcg
    * - PPC
      - kvm, tcg
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ce38a3d0cf0..f3f4cd4059f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -164,15 +164,19 @@ property types.
 Host Architectures
 ------------------
 
-BE MIPS (since 7.2)
-'''''''''''''''''''
+Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
 MIPS moved out of support making it hard to maintain our
 cross-compilation CI tests of the architecture. As we no longer have
 CI coverage support may bitrot away before the deprecation process
-completes. The little endian variants of MIPS (both 32 and 64 bit) are
-still a supported host architecture.
+completes.
+
+Likewise, the little endian variant of 32 bit MIPS is not supported by
+Debian 13 ("Trixie") and newer.
+
+64 bit little endian MIPS is still a supported host architecture.
 
 System emulation on 32-bit x86 hosts (since 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''
diff --git a/meson.build b/meson.build
index 5e2b0fb82b2..110e93f84e9 100644
--- a/meson.build
+++ b/meson.build
@@ -4721,6 +4721,14 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
+elif host_arch == 'mips'
+  message()
+  warning('DEPRECATED HOST CPU')
+  message()
+  message('Support for CPU host architecture ' + cpu + ' is going to be')
+  message('dropped as soon as the QEMU project stops supporting Debian 12')
+  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
+  message('that QEMU will compile or work on this host CPU.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.47.0


