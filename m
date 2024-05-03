Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C34C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rp5-0000rS-Cy; Fri, 03 May 2024 08:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2rox-0000mp-3u
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2ros-0006pL-DR
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714738517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s4DvSUKViypdg4PBIo4khwTjt6DHzg9hai78TXVwSuA=;
 b=Sz/YYgooO3WkXgAIpGIot1gJeFFMwW+7+CDvH6rbRu4gGJs2CGxhgp+uVDuG3jtJx7kgDv
 WZTNELkENznEJcBzhnS/leGiBNpNX09M2QldlWp3WXcHi2Jb7pifmhUV7H+tZOwr2X9Mp/
 MzoxswUtP592DQt2reMhFgJgCjNLaFs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-JWWoqHO0P52uot_TfDr8OA-1; Fri, 03 May 2024 08:15:14 -0400
X-MC-Unique: JWWoqHO0P52uot_TfDr8OA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a599dffe736so8336266b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714738512; x=1715343312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4DvSUKViypdg4PBIo4khwTjt6DHzg9hai78TXVwSuA=;
 b=VVri7+/8eUBoM5juXvMKydfnoPlqDqKXmOOYeqbSk6AeECY2gecTqCMWtZT3l9Z8Nq
 8MfjX9/8jN4l+a/pHPjrZc8aAe500X8uDzB0Ng64whKL45DpOLOj7C1q02/iVLrl6D4d
 O3aPyheKcA9xfEGi2fxLgezN+wQ7JnMJ1oJR6tdgyWBvflaaj9gAHjuD281Xzy6wuP4J
 xMY/2EPzisqenoUWmP1E+JfOD3i+vTZWUIqvg2f1ZVCADWHZskmGUW3OYoQv5G4eaB30
 8BPiKIPNaXdTiV64MBgKTJ51D7MGY7sklywAp6YrfInNjffHX9jBS0/NGjPGUoE+zZEA
 lygA==
X-Gm-Message-State: AOJu0YwtRlMqF2hGpkKVpeyib4JAzOjf458dexlBPHMLk7wngDsbvO0R
 +2rRVFZSk1i0F7++kix3mwCsc0x+UrvZN13ODO42rPKTWaCQHK22ZPI6OVeDMxZEs4vl6eFBtlc
 iXgX2s8kHW0IIhVKskkgiZsAGZKi7ZUvM/vO7OLhqMZ1mW6lie2YzZKjFRFPm8Bz+T1+KQCaJ/F
 sfLaVdJsdOwyOKf9UypsHNqBYlSQ7CW0T1YyxR
X-Received: by 2002:a17:906:4892:b0:a55:8631:b673 with SMTP id
 v18-20020a170906489200b00a558631b673mr2236799ejq.8.1714738511801; 
 Fri, 03 May 2024 05:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxaPGsArRwF5fkFmKwsERnw7i4EDy1UYC11w5sZ8JS25xJ4MH5gONgI2lX8jACXoxmKNwiUQ==
X-Received: by 2002:a17:906:4892:b0:a55:8631:b673 with SMTP id
 v18-20020a170906489200b00a558631b673mr2236780ejq.8.1714738511271; 
 Fri, 03 May 2024 05:15:11 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a170906561700b00a599623b07bsm468853ejq.206.2024.05.03.05.15.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 05:15:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab-ci: adjust msys2-64bit to be able to run qtest
Date: Fri,  3 May 2024 14:15:09 +0200
Message-ID: <20240503121509.219567-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

sparc-softmmu is able to run a subset of qtests when compiled --without-default-devices,
so use it instead of x86_64-softmmu for the msys2 run.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/windows.yml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 94834269ec7..d26dbdd0c0d 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -24,10 +24,7 @@ msys2-64bit:
     # changed to compile QEMU with the --without-default-devices switch
     # for this job, because otherwise the build could not complete within
     # the project timeout.
-    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
-    # qTests don't run successfully with "--without-default-devices",
-    # so let's exclude the qtests from CI for now.
-    TEST_ARGS: --no-suite qtest
+    CONFIGURE_ARGS:  --target-list=sparc-softmmu --without-default-devices -Ddebug=false -Doptimization=0
     # The Windows git is a bit older so override the default
     GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
-- 
2.44.0


