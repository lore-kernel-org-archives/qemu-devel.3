Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FEDE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPYn-0008GZ-FD; Wed, 11 Dec 2024 11:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYj-0007sf-MQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYg-0000CW-Ue
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eybao4hIER+UtTO8XJ3/cn/2NUI2ozda1q+92b4PeHk=;
 b=MVFIS7v734N4sfeNPJe9oOaiBt4OFpvOVD/AS5Orki22q+hl5vhnjMpChly+dXzInImpid
 Ea1/eLsT9AL9UsbC853f4wvJt0e9G4/m8KMwyjQiGj8tW6PX78xQLh7Fteg/mMggJIUgp3
 hi+iRbV9f/NkmCUWEXSRb0Zn6jn8yqY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-gBYZBtTxMXuAWsAWntThvg-1; Wed, 11 Dec 2024 11:27:27 -0500
X-MC-Unique: gBYZBtTxMXuAWsAWntThvg-1
X-Mimecast-MFC-AGG-ID: gBYZBtTxMXuAWsAWntThvg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso4467895e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934445; x=1734539245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eybao4hIER+UtTO8XJ3/cn/2NUI2ozda1q+92b4PeHk=;
 b=ibrq67Gt1R2Mtcp+J+ot5L27qx8dQF653SMqTheZx9ZiDV7kF9U1SoAZktsTYZpeAh
 LoUukbVpIi1w5DY1Z+qp3KqehWdur+L8ix4+pZw3PRL7EnJUzkj48xTDO2eX89B4bK+h
 wE1UgR1624dIN+AsGarhmHQYbpXzJnoYGBuZXjNuxIO/k5hGGFTfX0yKv+oFqp/BCqUI
 5Df8BYdKoxvKJUrO8KXyYvveHLfVwy3YnJocJ+cz1E/bPIEPcPI+ycSHjC8NLOS9kgIX
 SxkDQ0b66uUnp3e2I4MW7W/HjRIBJQPAzTgR9QhfU6LK02sXXIISm5W9pROIPLLG3Y1w
 0j6g==
X-Gm-Message-State: AOJu0YzJMycYY9hFgMC4eTCnGhYJXXtRGPBYIbKn1inaripFEMwixzYE
 dzMo919xn7vFpSv5fZMgdgAHHM65wZR+5V5qfzRgYzk15T/xVujbTLYkBdknJ4FYO0J8mir10Pk
 KFU6f+9Crc/4Kv/y/AxKbMFSeVsZFW61v+CnlSZqxh2vc8UTU5Ljrjq2K1INnLjC9X3dFyUoiEO
 YPGY3owkJ+TXBDfhgO9FJ4+ZR7BN97QP8zPgi5
X-Gm-Gg: ASbGnct3Vd29wVHNSSeW+mOqigDhKpj6WpR7X6MsHUNMZz7r8112MhUa5bsX6JVN9M8
 jD+vmmo7NXq+pEJaF0nmqjvze8c69FbVu8X+z9dDqyboRlAh1CJt2WosUyWhEsddsVYNyHDM4Yg
 jcpNGh3SHsmNCPnQ/kCEazjaTTXdHWbjn+q26R6587HWaY/4Zfq9lM5SMSoCr9XiRUT/U+MHmge
 OpzNHNGq6l7JlcrDe9o/o2/z3fSUlQNsDar+LVYOVNloAEgPMdmJ+E7
X-Received: by 2002:adf:e18a:0:b0:386:2a3b:8aa with SMTP id
 ffacd0b85a97d-3864cec5c0emr2916453f8f.37.1733934445220; 
 Wed, 11 Dec 2024 08:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpMhtghde5G2OcyrdBwiv16Dq4/Y9DU1JcH8yB0KDK2sUGVvszcABphbnH61ucYPeSTeZ5QA==
X-Received: by 2002:adf:e18a:0:b0:386:2a3b:8aa with SMTP id
 ffacd0b85a97d-3864cec5c0emr2916435f8f.37.1733934444794; 
 Wed, 11 Dec 2024 08:27:24 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4f4dsm1603306f8f.31.2024.12.11.08.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/49] ci: enable rust in the Debian and Ubuntu system build job
Date: Wed, 11 Dec 2024 17:26:31 +0100
Message-ID: <20241211162720.320070-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 336223484d8..4265a577834 100644
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
 
@@ -71,7 +71,7 @@ build-system-debian:
     job: amd64-debian-container
   variables:
     IMAGE: debian
-    CONFIGURE_ARGS: --with-coroutine=sigaltstack
+    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
       sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.47.1


