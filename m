Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559CBD3398C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qkm-0000A9-VQ; Mon, 28 Oct 2024 10:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkd-00009K-P6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkb-0003gw-D2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLiFAGc03L9VlsBrqIPUlTjf8Uu0ODAtffzXEXaCymk=;
 b=ZzcyOXopGhF2f1MDMX968DYXRULv1wnt4UPQD2EE7Y33D70D6BmERLinjLabLL7ruyXWxN
 tjM7cyWuuWOvC0591akXVuWj8HcXJH+c1PI1F0WJD4BIkpRsSBN2B7PXgUksjfIlYa9dxK
 1jwWh5JQYNj6Fv2Wvg4KkcV5Or1vaeY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-NOoFlOf_Oi-OlNzH2l_isQ-1; Mon, 28 Oct 2024 10:29:42 -0400
X-MC-Unique: NOoFlOf_Oi-OlNzH2l_isQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518ae047so27971345e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125781; x=1730730581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLiFAGc03L9VlsBrqIPUlTjf8Uu0ODAtffzXEXaCymk=;
 b=OBcQVVp1qQUO09dnwT0cQ9gC/iM/0uuDh6SjdRF0i67POt6NzhiYyCSwlYJJGicaty
 t8tmlBFxiB4/r+lD/HwMFmo+HoTY+MnkQswGcT4ZLo4mN9i/drC2omzR7ploL934LUUo
 P1YPTkiuMGJdYgUWDy8rripiy4UD+I+qbmXQxiKAmJ0dPcBHD+qhqwmBkS/gFXYqJSJe
 ih6pPwJIOjyRmN9hfBSCUjQBle+gL2qfaan+TsGNlU1sh+Q5DBE4tGegdxPUW8lJavKH
 0Tw4mzIylVNd6+hwKebLs/XEPrj4EOrJ86iYN8N8/ovtNpF0prUNAk4g28McALYuz+Mi
 7Ctg==
X-Gm-Message-State: AOJu0Yy4/u9qus4ha49KcF+fvznVKuwQ7LfWoIJgqvDR2QbSIyoBnJxe
 EC5nJ0a0C6oY5BCFqDHBCizLVjTGU5qbtp1Z6cnxIiUYfO9wRTcjXbycxQ7GJuwuNO1zae+xqJ/
 7PqwZZeH7DaZ23P5Tk0Pag2BcVgjAhx8cjCR8IoqOoEjjjvghp+Rvv53shBQI/c6d2n5mkoTyZV
 IKpe6jWaJflmDW407ddN3KPe040XFIw++2GoR5Jko=
X-Received: by 2002:adf:e685:0:b0:37c:ca20:52a with SMTP id
 ffacd0b85a97d-38080e234c9mr30747f8f.8.1730125780788; 
 Mon, 28 Oct 2024 07:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnIkTg1TFSWhJsYHy+SikxXzaeXzI4WVhJXb+3RXddnnJ8AeJOnaSqPiWFbiNeQm8dlG9XgA==
X-Received: by 2002:adf:e685:0:b0:37c:ca20:52a with SMTP id
 ffacd0b85a97d-38080e234c9mr30715f8f.8.1730125780436; 
 Mon, 28 Oct 2024 07:29:40 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47f59sm9622490f8f.54.2024.10.28.07.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/24] ci: enable rust in the Fedora system build job
Date: Mon, 28 Oct 2024 15:29:10 +0100
Message-ID: <20241028142932.363687-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index f0cbdf19924..19ba5b9c818 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -115,7 +115,7 @@ build-system-fedora:
     job: amd64-fedora-container
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg --enable-rust
     TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.47.0


