Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1456D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80tA-0008PH-9R; Mon, 04 Nov 2024 12:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80ss-00089b-Oq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sr-0000TW-5v
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGWRmX3rMWBrx19dauoWAvIXhk+Rz6c9rIxN6h0dBpU=;
 b=TwgtsqUXExU/5sTO32eeAjhqeThoARY0FDVn/1bjNpWZePY9Th0bXaMfzQjj7ZNy70WK9O
 cW44Yx+j2ZFA1vk3GzT3hNE9QRS+KChFn0llnmJDtYl2OWVjX6ExwvO06mvo8HqC3VTu6Q
 X7UIC5Zsv0aB7W+DYQnZNW8YzN2/f+4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-IF2r7xVjPWilAdXzkf7O9Q-1; Mon, 04 Nov 2024 12:28:54 -0500
X-MC-Unique: IF2r7xVjPWilAdXzkf7O9Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4699779e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741332; x=1731346132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGWRmX3rMWBrx19dauoWAvIXhk+Rz6c9rIxN6h0dBpU=;
 b=Djp5W9WWVdIG9hOXBjmptyA8pfWjaYXaR/k3w2M1DojmyAFi/QScbXNSJtbIi5n5IN
 rH7j6/Zffc3iDQwaVKD2vY55zBGCeFPvAwrqGbeKHnVKNTIyDKCdDtoT6kk/sy1ky3jl
 PJ7rBoVpPtHYWefqPJ7vatJlF6AEunSvtBnyvO1QBh7Y2ojcLPr0eqVJvmVWP6Tf6/5F
 09oEV2FKumxEVUYelYEOBdi6wQJhH4yqVZOu13wfEu/tBUMMS4vvR9fiM/n5iUZnPp8b
 Wl5xh7FGmC91Y/5aqSnVbXMJSuyamkHk8vFFVzWYh4E/LrvNqTp7QiffqmPL4x2PTZBn
 FNeg==
X-Gm-Message-State: AOJu0Yztwww3osktU1PTCUG2pe0g62RWWJV0X0nbro9dq2hOVKT+q/X2
 6t/Lm0KdG+mHpDOSlIvw70tWUNdj7a3KMMAc4u8yo1MS/HkeoQajPUuDTXStytqEJAtW7CpbM84
 hDKeb6Gp4UKwTY1CQh6Qq0ZRHir4NuA5ePdew7dSPLT6+hKYXT2SuRxxodLV4DkUiawColq14j1
 UdYNlYcxGsvlE7LM44FLDoQHOhGHYxiVQdoy4ASFY=
X-Received: by 2002:a05:6512:12d3:b0:539:fb49:c47a with SMTP id
 2adb3069b0e04-53b348c38b0mr18004264e87.4.1730741331763; 
 Mon, 04 Nov 2024 09:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvXcC5nQC1vtlOzI2/O8BSyCzrrLMkJgRWoPoLQ1i66qToryZaXzmr1qtCNt7nPD7Ov/Nv8A==
X-Received: by 2002:a05:6512:12d3:b0:539:fb49:c47a with SMTP id
 2adb3069b0e04-53b348c38b0mr18004212e87.4.1730741330923; 
 Mon, 04 Nov 2024 09:28:50 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e51csm13814117f8f.79.2024.11.04.09.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 40/40] ci: enable rust in the Debian and Ubuntu system build job
Date: Mon,  4 Nov 2024 18:27:19 +0100
Message-ID: <20241104172721.180255-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
 
@@ -71,7 +71,7 @@ build-system-debian:
     job: amd64-debian-container
   variables:
     IMAGE: debian
-    CONFIGURE_ARGS: --with-coroutine=sigaltstack
+    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
       sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.47.0


