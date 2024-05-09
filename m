Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF9C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 15:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s55sN-00059w-Fs; Thu, 09 May 2024 11:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55sH-00058A-2I
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55sE-00024i-M6
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715269197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BvJWgcCgJ6AyS7lvUft/LuL2u3tE1Xg09QghCcPawa8=;
 b=HFQUbKLacwGFi06240czQ3EOEiu/iDMzEDELKh1oOgGF6ToK8OaMNPS8/9eroTHegF5vIH
 hG31XRbRUhz8Yw7ZHVF/RUnoX6aZ/XMEmjWITckWle6eQ7ClPhkmJNl7p9QaiKp3lvIFrV
 rzS8H43SGc8BKm4j13MQj0HZRnwH9Js=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-bDe6Dob0NQyYRpYvJQFj6A-1; Thu, 09 May 2024 11:39:56 -0400
X-MC-Unique: bDe6Dob0NQyYRpYvJQFj6A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51faceb0569so860595e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 08:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715269194; x=1715873994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BvJWgcCgJ6AyS7lvUft/LuL2u3tE1Xg09QghCcPawa8=;
 b=aJpkNFbOV8smnOG7Uqb1bKdpag6ZrV3sIV4O/MSwBFkXdlxh4R1slvGlFxElm0Rr9k
 c3OF2wO84JxA2rWhFf+QKW8vGbK5AQRH2tl2adQ8+Vf9EtJVpTkqFDKm8eV4EhLxHtsY
 s7Xt5hK6NEhOaEbcqABvqnS50y0LY8+9vmxK/SwgD/dooI3Gf4E2GNiMwl1GTCSqMpD1
 LtWAj58k/cGjn5piwzccM8iN3ixFVIoG3mUC8/gu1CuVTYqmFIXAigfMTm65bWZ0dxha
 bykIGm3FBfjb6ha0ddz1lcyKi+zcSD6EdKbW/NCMQj22m3qiud0fjjfki9j+aV3+rtaf
 2+Ww==
X-Gm-Message-State: AOJu0YzlJNIocD2YDbtKamxWkuhP4wwevAI3expJ6Pqbn/+27vhUDdw0
 QmwKDodo2ZwuIoBQUz18I9QKUYhEgwGx0dZO+v0NDqnZZT76b+XcYEoc6ZSPp8CMdUcCrWoI/Rt
 TiHOpgDACE1Kv1HHutRh7ngzb8JZJc6xdAZkgE6PDSYR6lbTJ+jUSqbvpoUWIxGA72reJ87Ar45
 EcBkvYUF3sHInQdyprN/yM7mqFuSdl/R0a1kuM
X-Received: by 2002:a05:6512:4845:b0:51b:e0f0:e4f8 with SMTP id
 2adb3069b0e04-5217c666671mr3807726e87.31.1715269194417; 
 Thu, 09 May 2024 08:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/TSuSCvNcIjn4TyJ/baYm8SrGnp6eg9HZhc4Y7y7UcvXREMaVvge/5usU/uvX7e3WTq9KzQ==
X-Received: by 2002:a05:6512:4845:b0:51b:e0f0:e4f8 with SMTP id
 2adb3069b0e04-5217c666671mr3807706e87.31.1715269193908; 
 Thu, 09 May 2024 08:39:53 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01a2esm83790066b.185.2024.05.09.08.39.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:39:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add feature dependency for XSAVE
Date: Thu,  9 May 2024 17:39:52 +0200
Message-ID: <20240509153952.143805-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The XSAVEOPT, XSAVEC, XGETBV1, XSAVES features make no sense if you
cannot enable XSAVE in the first place.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f2ea6899e39..6f5ff71c6ee 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1550,6 +1550,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
         .to = { FEAT_SVM,                   ~0ull },
     },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_XSAVE },
+        .to = { FEAT_XSAVE,                 ~0ull },
+    },
     {
         .from = { FEAT_7_0_ECX,             CPUID_7_0_ECX_WAITPKG },
         .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
-- 
2.45.0


