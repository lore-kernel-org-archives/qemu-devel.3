Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549B3D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLZ-0007Jt-9l; Thu, 31 Oct 2024 13:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLW-0007Bl-P1
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLV-0007DQ-7K
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bnl1YZedKs8GMr8W+kHSAthdIC7YbZ63USIqcJYma/4=;
 b=KJRjswmmpBsAX7hZBisBZrvnHKznwcalGuSYYB9w2mxSOdNZmEhRRfFZWIC+RV0ufPr+YF
 BX3R3I3y9MaLCZuK0xA6DlnTRc9FOBPLfDcCmbyeTbNAGQimqoDnHnzha896D2X2TffwHW
 cu2H17lAIc2qmTd7InU5iYEzmmQxtUM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-XdGUW7c6MhuGul3gOhQrig-1; Thu, 31 Oct 2024 13:52:31 -0400
X-MC-Unique: XdGUW7c6MhuGul3gOhQrig-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so7500715e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397149; x=1731001949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bnl1YZedKs8GMr8W+kHSAthdIC7YbZ63USIqcJYma/4=;
 b=M3K5O82y5Lp9JmZKYyCUqg0c/4KIYhbViUtADrlys+yAPqNlhLcVwaYerUd8E0LvRt
 74xldom5jy8rdrZrac2AT0z29qcibwVDqg60tRGVQnj6DBqzy/J6Zry8dPGIQh0uDFdY
 TBNSm+P6o2d4W96mqvEIfZD08OaSCtcELmui5ceukMmrg8Jk9gcSA/9Prn4O+UMaCDjw
 6b0M8XFAeyK/uKHtbMi5kfHPjOWfvsD8HIJR5YeobFfMuuzGTXwDjeaEJ/+HKG1fbOO1
 CCtEmWmY75oDJ3ww765RBaUR3z/KSFcmgDTHX4byVJIJqIi8p65m3lp6xn1F6oPFyQaM
 gKHg==
X-Gm-Message-State: AOJu0YweNKZTYSYq4owYqrAn7MKXKmnTUvpe/5zcBXgIXfGhG4O5zuQ3
 1WuK0tW2TBgzycIHpk5ttoJhq95MwFy2eTe/kWIpNw/x2szHs0SffvswA87KVIkKM+A8r+1dBWJ
 ELAO0lKqIrgKm6wwT2mknVO8i5jbpNZkMlqWdfnU6ZnwxSKoE00TCicJFLYk9fLGv8jKUBbilcR
 l4jRfDRVmWdJ1fHFCUElKeJ1rvXkBKu/aZdSdOfuQ=
X-Received: by 2002:a05:600c:4e91:b0:431:5f1b:a7c4 with SMTP id
 5b1f17b1804b1-432832990e5mr6185135e9.34.1730397149380; 
 Thu, 31 Oct 2024 10:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeG976qDKZv/ZitVVJFWL5GvyTHszY+IjtvrRv9MBEMnSm9oejMMekBjQ5+NZnNYyWoZe7Vg==
X-Received: by 2002:a05:600c:4e91:b0:431:5f1b:a7c4 with SMTP id
 5b1f17b1804b1-432832990e5mr6184965e9.34.1730397148931; 
 Thu, 31 Oct 2024 10:52:28 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852d9sm33684665e9.37.2024.10.31.10.52.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/49] configure, meson: deprecate 32-bit MIPS
Date: Thu, 31 Oct 2024 18:51:31 +0100
Message-ID: <20241031175214.214455-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 1e1e9f5f18b..7c2be893255 100644
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
index f7d45175212..bae7a4370de 100644
--- a/meson.build
+++ b/meson.build
@@ -4720,6 +4720,14 @@ if host_arch == 'unknown'
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


