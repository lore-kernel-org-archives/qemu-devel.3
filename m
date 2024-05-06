Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87547C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t8j-0005mZ-59; Mon, 06 May 2024 03:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8d-0005jR-If
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Z-0001V5-Mn
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4DvSUKViypdg4PBIo4khwTjt6DHzg9hai78TXVwSuA=;
 b=Sv/oH71qXhak98dm3r7wP7JTMIIaXCO3uXxWAXq1H2sxdsoyIr1EcWLcCnhwbXqUTu+Hgy
 sW5J5ihNsUsZP8ve1c/013G4MmJWZn0fkcwFVW4dyiOYcVsmMbCuUMuzJVgJZ9ZRIRxpAd
 8hY0F67fM16u6dOqAKTbESpUb9VX9qg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-BnRSNtGSNdGW-ntz1dV-vA-1; Mon, 06 May 2024 03:51:40 -0400
X-MC-Unique: BnRSNtGSNdGW-ntz1dV-vA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a5966e85bf6so304177566b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981898; x=1715586698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4DvSUKViypdg4PBIo4khwTjt6DHzg9hai78TXVwSuA=;
 b=xR+i6pja9prAZBU4xG0WsBk3HhPD9OavT5ShQSCrFFjR7qQYPVbCMko3a3s+uOuROf
 W3yySddkP5eLeWrsqYl0ZSJMrtYMFqZ41rLKG5cnpWPWlaBnpEWzPhnbN1i6hQA79SjO
 t30ITievMXnXmd2EE+hzDGmLWYWfgLE4tqiCg9m77ir1pL/ZxoLO/Fe7Yv/ge7N+7d1o
 TJNZmItYZpJoMmKKfpO0bY48WgHjFsNVpZaRcclBngtK1Y/qR4TRulMQ6gVbDn4JbE7d
 WRnsPP4k3hh9UAIh9JYY56y0kZmcBzvRDRad4y2jn73BRkqo8hTiRQB/sWmyoVgiacaZ
 HHXA==
X-Gm-Message-State: AOJu0YyVXlEvxH0R2go5X4StszsFKyuWjMA+nOlOIk7aul0kG+HnVI59
 kWxTYde5IvbDcHFQrZvfJxhGGXYMWwyRMDzR8YxWcrMBogRzD/nvfNUjSb4jzRE5PJz0cJbxyDp
 nwPBwPZ54SiBduhXGPOOy5yCagO2JgJyECU5ZSt8V/zXQFJiWS5LZnaZfy2PaLWh6u9gUzLYT+9
 qNogL2BocnKT6OwIHSeOWYhvpOurTBrWEwVnCZ
X-Received: by 2002:a17:907:983:b0:a59:92b0:e0d3 with SMTP id
 bf3-20020a170907098300b00a5992b0e0d3mr7248705ejc.34.1714981898420; 
 Mon, 06 May 2024 00:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBY3iOLgUzOjCyH/zu1c9sp951ZiMA8tMgK9Hhx/ZZY1AG2L+QeEV09LaxZYKHv+bofxbLDw==
X-Received: by 2002:a17:907:983:b0:a59:92b0:e0d3 with SMTP id
 bf3-20020a170907098300b00a5992b0e0d3mr7248691ejc.34.1714981898033; 
 Mon, 06 May 2024 00:51:38 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 rs21-20020a170907037500b00a59b259e2ffsm2192988ejb.93.2024.05.06.00.51.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/46] gitlab-ci: adjust msys2-64bit to be able to run qtest
Date: Mon,  6 May 2024 09:50:43 +0200
Message-ID: <20240506075125.8238-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


