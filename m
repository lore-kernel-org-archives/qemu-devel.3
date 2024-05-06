Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53E8C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t96-0005u0-RX; Mon, 06 May 2024 03:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8h-0005lF-Jc
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8g-0001cF-37
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbRcX/gpwNAE5Vz8aXltJ8y/z7iGDUMqF8FDXO7YTrk=;
 b=FKJcSlzwQOlJ+6WFe0mcREwhRWq3v1+0HdhcFWpPxDlgHgiJmC8Vqqcflj5j8deeoFts82
 zWgrZfAeYhKTcKwQaFsK9fzJxVl6HJovPn9q/GWCnKw1c3U2VKX7QRzAjicfB9IZfg2SdK
 ++N5d4wS3qqVYoa73SpjQlaC8oBiGDQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-JTlkYXEtNxOPvP1NPmPStw-1; Mon, 06 May 2024 03:51:55 -0400
X-MC-Unique: JTlkYXEtNxOPvP1NPmPStw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c0ecd59cso80944666b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981914; x=1715586714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbRcX/gpwNAE5Vz8aXltJ8y/z7iGDUMqF8FDXO7YTrk=;
 b=tcyN1AO+2zGOR6Xmv7m2S+2EcaHP6pNvH4jyK3qJyjiQTG/VSJcQchGj4QnSPxhmvN
 aCVB2NkHDiLG7I+etKKRqNQu/wJK3xoqchtMQKVptWHuP8vXYUCiMEwrFW2blFeN9rfy
 I958/eLiDSm5JUuMqzgyCnglvsHDf34TIfrClAj1PZzE12QxUkyuKnJRcCnKnSvkXeRS
 k9jaL+P6BGnYKsQVY/VNieo3UDzdRear4ZJzn9mr1JDFlqIDXTXLaqGLa6tOsyqkLVqX
 Zos+LbXpg6PFH2NxkdWvYGdvBzpDIVzmqxX6rS/1Fdplx1ppNSVRMS8eR8NohctvXghQ
 i7Jg==
X-Gm-Message-State: AOJu0YwWGyl/KbAHx/W6GrvU7LDqRviMQxbbdL+ZAA9cgpM5ZAexBJ4J
 tw479RobEYFgfXM4lYmrC8uHE4L/3zgDTTPMNUum4ABnCjwwUKaRHXQMcsgHxJ+hUEthkKEC01X
 UV1o75dEXq3TO07jLcRfSdx+fen1FfieeD1FsoyIyImWokz91iykgNMyyqn/b0smZisiGrZo+WZ
 g2MZ1v7zHjkx9h5WYEeeYV2pxc7QhjXe9w0D+P
X-Received: by 2002:a17:907:72c3:b0:a59:c327:25b with SMTP id
 du3-20020a17090772c300b00a59c327025bmr3838279ejc.12.1714981913761; 
 Mon, 06 May 2024 00:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbwUXK78DOT3sgz02OV/1U7wlH5CqztiV4RjBKZKrp28UiBgNHuOWS9opKzrs5LIqwyAXTUQ==
X-Received: by 2002:a17:907:72c3:b0:a59:c327:25b with SMTP id
 du3-20020a17090772c300b00a59c327025bmr3838260ejc.12.1714981913437; 
 Mon, 06 May 2024 00:51:53 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 bf14-20020a170907098e00b00a59c3e28917sm1571335ejc.70.2024.05.06.00.51.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/46] cris: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:49 +0200
Message-ID: <20240506075125.8238-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with CRIS.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/cris-softmmu/default.mak | 5 ++---
 .gitlab-ci.d/buildtest.yml               | 3 ++-
 hw/cris/Kconfig                          | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/configs/devices/cris-softmmu/default.mak b/configs/devices/cris-softmmu/default.mak
index 5932cf4d06f..ff73cd40847 100644
--- a/configs/devices/cris-softmmu/default.mak
+++ b/configs/devices/cris-softmmu/default.mak
@@ -1,5 +1,4 @@
 # Default configuration for cris-softmmu
 
-# Boards:
-#
-CONFIG_AXIS=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_AXIS=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 3a03cdb0151..f4dc5666467 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -662,7 +662,8 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu s390x-softmmu sh4-softmmu
+    TARGETS: alpha-softmmu avr-softmmu cris-softmmu
+      s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
index 884ad2cbc0d..26c7eef7437 100644
--- a/hw/cris/Kconfig
+++ b/hw/cris/Kconfig
@@ -1,5 +1,7 @@
 config AXIS
     bool
+    default y
+    depends on CRIS
     select ETRAXFS
     select PFLASH_CFI02
     select NAND
-- 
2.44.0


