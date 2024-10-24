Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11764CE8E6B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x3p-00044V-A1; Thu, 24 Oct 2024 08:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3e-000429-9P
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3Z-0000F7-IB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZutbzFTDEStGDKvonSXIlmUiAX6SlfPp2eA4Uk6zgXs=;
 b=QFQOdmDbGmAFttNFoJOfle/uP7inVrRYAS+54e+PVPoKL/40zGGz8XRnjX3jbJPLtaYfIL
 Zyn4Hp+EdlEWpu0RWPkbGetiwB27L0VR9tW8uNvp0wHOwh2dVm4hEe8siq2OssAS//TYGi
 0+Sl4rLBvCDgNaZ3X0jZ0nmY3V12H/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-W7iAJ4OeMH-NwPst-O7XTg-1; Thu, 24 Oct 2024 08:35:10 -0400
X-MC-Unique: W7iAJ4OeMH-NwPst-O7XTg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315d98a873so6458425e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773308; x=1730378108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZutbzFTDEStGDKvonSXIlmUiAX6SlfPp2eA4Uk6zgXs=;
 b=T22Jf3TUsN3nYEvjr8K+ueyhcZiEBVkzMMYZMRfvEY+OtgADIPNSJwfbE/BiPB6NY8
 gm5heXIc7VOypEmEGhgUoO+qlNfZKgccyZPv2ELsm2dFvrxFobM2eP1p03FFr3UH/l0I
 wWGb8zmwihtDoE4HuSPNSwZMm+zrS3qZy6cgA0SPXf6NU7IE3PqS7mrzdHBv85JjYXtO
 mkYWXiCeIA7jbIepwx6Z8Q94fUMWH8fMs6o9Gd5N6uAupxLMtu+A4a3kpaM61DAmBZ8A
 9fHrRscyV7Fb5WBhOBKHM7aRQ0euI+epLSHWGsxKHuXab9TOozIOi7bfHwfthZfCTqT7
 Hl0Q==
X-Gm-Message-State: AOJu0Yy3OA8y7ndTjsvir4D5tUr4SdA75czx/SHxc5f0MteqXp22gTj2
 5kCkaeJlI7eP0k+w4Fi4MFQfIfcFAkTlT6jo76Z1SQ6ci7DnexedCcIps4oTFEPCJA5N8TC4HcR
 qTslWS4EME+wQjbbB2LPeQtUh2wKw0EqgmkxDZdD8r5PSlP3smA6yjBOXQDocz0YkSf32emwYPS
 mEEQi0ApAoufnjK9SK6szL8eGNAvUmJfbnyddlYgE=
X-Received: by 2002:a05:600c:1546:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-431841a605dmr43332595e9.33.1729773308018; 
 Thu, 24 Oct 2024 05:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4BCokAsYfvsVvhCY7Y7GP9qji1O8bYJEuOJqe61RdY8b5hADXRok/F5S281mPc1oYPtqGyA==
X-Received: by 2002:a05:600c:1546:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-431841a605dmr43332395e9.33.1729773307571; 
 Thu, 24 Oct 2024 05:35:07 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a585f7sm11066334f8f.51.2024.10.24.05.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/8] ci: enable rust in the Fedora system build job
Date: Thu, 24 Oct 2024 14:34:55 +0200
Message-ID: <20241024123459.59350-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
References: <20241024123459.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

From: Daniel P. Berrangé <berrange@redhat.com>

We previously added a new job running Fedora with nightly rust
toolchain.

The standard rust toolchain distributed by Fedora is new enough,
however, to let us enable a CI build with that too.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20241015133925.311587-3-berrange@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 01e8470a693..7705000e3cc 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -115,7 +115,7 @@ build-system-fedora:
     job: amd64-fedora-container
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-rust
     TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.47.0


