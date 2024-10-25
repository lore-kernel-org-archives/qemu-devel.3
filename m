Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F112CD149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mot-00056F-TF; Fri, 25 Oct 2024 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MoE-0004w2-KS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MoC-0005BH-Kj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1V6b7WD574xZK3wF/C5mFToVHXs12LTfpeZesQABro=;
 b=OR4T+LtdHoVCNVehgwTpkuFW6ZUm3Tpe0bCpxTMzeCj3ZnbeKXv5yTDHNP716Q41e9Vm7p
 FegdcCKseho3zyEe9b1/4rZ1/9bh7AHj+I7dd1mWWAwnp0vko443wkhzBwm2uubV8qq/AG
 NfnF1gEGYM11jvSM7KZF4EpCej9bJZg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-rSZzLCADNLG0FmHUfgJteQ-1; Fri, 25 Oct 2024 12:05:02 -0400
X-MC-Unique: rSZzLCADNLG0FmHUfgJteQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539fe4e75c4so2420458e87.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872299; x=1730477099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1V6b7WD574xZK3wF/C5mFToVHXs12LTfpeZesQABro=;
 b=wHIj07bhJuPObAUWQCG59yhrrGYRrPNfUyb1FCBmm+SonEpsaMQ5kM1o8w8GVFV3aC
 sikLFVCL0uFjw9u1jvhuVeLUURZ6M+och6Sy7Yl+dgD3efJF0UkEn7TJd1W2WPUVsw5l
 V7LuaW1fNj986UwiCS4wm0qTlmNs70nTvsEwei4PlyGZn20jZi2mPV2yDETbjv/RPNQi
 hbaLeRGBSL1YxSLop8XlHOYLpoFSh/j/I7O1EoaUpDIqwfqC3bfNOPeJKqdNGZ5lccCw
 VmcOGHyn+pleixSvVNLumRueER4DEmYwh+qkBLkUwOUJUK3Z7q4LglhAvyG75eAfKnO8
 Jw7Q==
X-Gm-Message-State: AOJu0YwJXd3n4T6IFX62CFPcxCZYRZfarW5mv376UPm+6igYelgL0F0s
 FwA1u8eoTet97+sE+Wli+TwiokE2JMjvn0X6yoPoEpa4uuiGU9//39DPnVHKzpCSJEKLGy9lGsZ
 MdpfrXRc+3jms90IKbXiYysGwZrhjVsCmHVe/cFQW5s+T3+C1Ue/mXxnvfisu3ojjg8je12N2e6
 Kye3+1k230XZlacF1nNGyR/GacELCbPhtqBkhWmcI=
X-Received: by 2002:a05:6512:3d8f:b0:536:542e:ce1f with SMTP id
 2adb3069b0e04-53b1a328380mr9416171e87.18.1729872299253; 
 Fri, 25 Oct 2024 09:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBhEYaybodERFQzYyZo/R3yQ6zOsNJ9esSX898Ky280/LlMY6EOd6iPh85NX9pgOofyH6e5g==
X-Received: by 2002:a05:6512:3d8f:b0:536:542e:ce1f with SMTP id
 2adb3069b0e04-53b1a328380mr9416123e87.18.1729872298671; 
 Fri, 25 Oct 2024 09:04:58 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f29744esm85403966b.130.2024.10.25.09.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 23/23] ci: enable rust in the Debian and Ubuntu system build
 job
Date: Fri, 25 Oct 2024 18:02:08 +0200
Message-ID: <20241025160209.194307-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

We have fixed all incompatibilities with older versions of rustc
and bindgen.  Enable Rust on Debian to check that the minimum
supported version of Rust is indeed 1.63.0, and 0.60.x for bindgen.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aba65ff833a..8deaf9627cb 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -40,7 +40,7 @@ build-system-ubuntu:
     job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
-    CONFIGURE_ARGS: --enable-docs
+    CONFIGURE_ARGS: --enable-docs --enable-rust
     TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
=20
@@ -71,7 +71,7 @@ build-system-debian:
     job: amd64-debian-container
   variables:
     IMAGE: debian
-    CONFIGURE_ARGS: --with-coroutine=3Dsigaltstack
+    CONFIGURE_ARGS: --with-coroutine=3Dsigaltstack --enable-rust
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
       sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
--=20
2.47.0


