Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ACDC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD14S-0000LI-PS; Thu, 08 May 2025 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD14R-0000L3-Ca
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD14P-0000hS-Qc
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746710028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6ljvXYz3Ammv9IyTNCcBI9y3hT6/YYDHfD78BUikWg4=;
 b=foQUxqchLO373aXj9U2JWiqcjJS6gQXBEHnynHcvHLcLeDSmivHTGMJVcWmajonxbdIN+m
 6y2lQrQxpxoA2ZqendfgXdEN5cxF0AyNVMFzc20ZGoTNRH+lAm5gFmOwEO6FfmRO36bcqn
 i5bwaqli3UY92FHBWgECdqtRed+bVNg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-2LoRx98qMHiRHVhrMX9O-w-1; Thu, 08 May 2025 09:13:46 -0400
X-MC-Unique: 2LoRx98qMHiRHVhrMX9O-w-1
X-Mimecast-MFC-AGG-ID: 2LoRx98qMHiRHVhrMX9O-w_1746710025
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b5d18cb7so416575f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746710025; x=1747314825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ljvXYz3Ammv9IyTNCcBI9y3hT6/YYDHfD78BUikWg4=;
 b=YKj24+wTHaZZ9gp0z0DpAmYEwbZfHU77/kpBpdYi7J9UYvNQwDCaszj8JQ1MP5yB/g
 ue0Oag25WgnjlJrFq3K1QjSgOCF7ZnRx4cHlH5xgzfvL3uhi5ixLtiPVQzsN4m2YNvDO
 flbgIlXK//Ivf9pCvnOf/lruOtlxFUNyaW2Grvl3tK6qNQtkmhLcKA+BfF9drgWwWjcX
 CMkAnJ+98PnyCTm7CGaaKP7R7zT9ZSi+CxPyqTXhlMwd9O4Fjg/jJoqVDSUEWfCbOyNk
 yZeYobnFS6e/0WbaSBaEKACma0nuHV79iFFz6SdLwfuu428bVB+uJ79h10CjPj5HhbXi
 RpmA==
X-Gm-Message-State: AOJu0Yy9pxKGsmB7JlC9lUskk8B+p6aPRQL3EbqP4cWrh4XH/AmbLtQg
 73Y4LEPbqbPBvrg2Rt0cX3slOK8furs/r2lb1vawQXOPYmmruycXXCr0tY7m6YEmYU1N9K+N+i9
 JEh4ugzFAnB+iz4X7M48T56a4wC0LKbw5/XzI0+kDoukuF4rPtINH76PQhtB3hgfpbMuVctiAfw
 Zg9HeJFuJlrc87oWL5VBeeyhPCxnCCi6mKbQtl
X-Gm-Gg: ASbGncstxAZ1ZLEYpkRem1MffYK5kofbFj3s9kJULMrLfRdyMQz5zAUeX5aPgmqaQ2j
 SSSQtIxepurnE5l+HMKzpsF32xyXWnvLW0fA0uibIjWE4ny0/DMIEKOgubaz3rh+UsdOyck8mKt
 DBMunQbGtXpPXjJXqD7ViqG+RtpkLreZ6tE7AySvOcVBY6S2Be9IXOoVtKuaa0kf8c5ddxIFLN3
 1cCMACZoSmxL1/aW3itDP02xx14BzWqRSf/trs0Bp9ifV1jAboc/kmC0zZYwSdinWYcDiD/xBcr
 wln3itcchBUOVo8=
X-Received: by 2002:a05:6000:4310:b0:3a0:b784:8826 with SMTP id
 ffacd0b85a97d-3a0b7848cbdmr3060969f8f.19.1746710025112; 
 Thu, 08 May 2025 06:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaKrSXJ8I7Cg83JOHOZoiv9KZJXeh1YHNtPuw1QA+xD3deOYI7y+1YICMJZcuBHrKgvjGvQQ==
X-Received: by 2002:a05:6000:4310:b0:3a0:b784:8826 with SMTP id
 ffacd0b85a97d-3a0b7848cbdmr3060947f8f.19.1746710024599; 
 Thu, 08 May 2025 06:13:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d14e0437sm28496645e9.36.2025.05.08.06.13.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 06:13:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: remove unnecessary dependencies from specific_ss
Date: Thu,  8 May 2025 15:13:43 +0200
Message-ID: <20250508131343.502891-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All dependencies that are in common_ss (which includes system_ss) automatically
have their include path added when building the target-specific files.  So the
hack in ui/meson.build is not needed anymore since commit 727bb5b477e ("meson:
pick libfdt from common_ss when building target-specific files", 2024-05-10);
drop it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/meson.build | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index 35fb04cadf3..6371422c460 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,7 +1,4 @@
 system_ss.add(pixman)
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: pixman)   # for the include path
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: opengl)   # for the include path
-
 system_ss.add(png)
 system_ss.add(files(
   'clipboard.c',
-- 
2.49.0


