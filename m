Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B336C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9a-000753-UU; Mon, 06 May 2024 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9U-0006vP-8r
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9S-0001kO-PN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jbyp55wNTG92uU0JjszKTSa5YnO873pTqXSIixUoRHU=;
 b=FYzpzr9ijyDeJjJqdwy9mMrrIl+IL4vw7854UriqZx+O9fHSOFNooazTRPiUWm1mKZi2+o
 J2tnLAW8mfbqb7SS2xBKQAvTvn+x5mU1hCkQcMx6mvHN+g1mp+s2uJJdeS1ayLFa0HhWO5
 SBgN28Unin2y0MxPdhoX0MqpT5pMU4Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-zqT_sUdxNFaKxEF6mmwLAg-1; Mon, 06 May 2024 03:52:44 -0400
X-MC-Unique: zqT_sUdxNFaKxEF6mmwLAg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f60b1644cso1404925e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981962; x=1715586762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jbyp55wNTG92uU0JjszKTSa5YnO873pTqXSIixUoRHU=;
 b=rcgMTSCf2bzCpvDET6tq3hGSqvybVVoVLM08lUcVus49pzzpcfYQyrYOo/IfOq8pst
 ZG2lDh7Jox+pHhBQHnP3CRghdqJhybB0vgInuSmj6fr6lXFTZ3KZ4WP83MGktQhjqS3I
 U8s2ijm7rMdYmtJwh0H+PRsEAt/pxllUuV1X/VKbBGj9Inn+jWg5dY6RKmYbafEVGcf6
 uM3t5Q38jTm4eiSVDwl8NBUDPee5NpbPB67NoxLlkpiOpADlswz0Lxvfcyxv6OaX9ADU
 v3B7xPINV4PrB8zumhEckT1hB9AiA6RUsGzr/TOxJk0MICEGHBxtM7YPhZgxgXbVXx47
 cNOg==
X-Gm-Message-State: AOJu0Yxae7QBUTiWWZ4XS3ZU92smHJH8uTmqDkaCuJUF5iyAUOdn3O1f
 1MvOcEVaxFCceY9A7stGogboVr2+uq/f1Afriy2KVeLziHMYB0RjPpea0XoW8W3GffBoCGZfvsn
 HZBweTMWdg78DceH20tQe5iryyQBButwGsbKZ6xOj4FmOGfbS8nc7XSDNNyExLvvlw+NczteNxG
 BF8GrAvDncoKnAHE0QJ/9A5HFDBMDTVaqOA4eG
X-Received: by 2002:ac2:5a50:0:b0:51b:1868:7cce with SMTP id
 r16-20020ac25a50000000b0051b18687ccemr8227854lfn.63.1714981962268; 
 Mon, 06 May 2024 00:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMja2BM/4D0h20Ww9gvlgaUhdF3iNFEE5qWpfNn/srgH91mFwK/FlQo4o6TZr4iU8gCbGBCA==
X-Received: by 2002:ac2:5a50:0:b0:51b:1868:7cce with SMTP id
 r16-20020ac25a50000000b0051b18687ccemr8227839lfn.63.1714981961742; 
 Mon, 06 May 2024 00:52:41 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 wr8-20020a170907700800b00a59be52ff98sm1857060ejb.191.2024.05.06.00.52.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/46] build: do not build virtio-vga-gl if virgl/opengl not
 available
Date: Mon,  6 May 2024 09:51:09 +0200
Message-ID: <20240506075125.8238-31-pbonzini@redhat.com>
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

If virgl and opengl are not available, the build process creates a useless
libvirtio-vga-gl module that does not have any device in it.  Follow the
example of virtio-vga-rutabaga and do not build the module at all in that
case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/meson.build | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 7893b94c8ee..7db05eace97 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -125,12 +125,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
                                          if_false: files('acpi-vga-stub.c'))
   hw_display_modules += {'virtio-vga': virtio_vga_ss}
 
-  virtio_vga_gl_ss = ss.source_set()
-  virtio_vga_gl_ss.add(when: ['CONFIG_VIRTIO_VGA', virgl, opengl],
-                       if_true: [files('virtio-vga-gl.c'), pixman])
-  virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                            if_false: files('acpi-vga-stub.c'))
-  hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
+  if virgl.found() and opengl.found()
+    virtio_vga_gl_ss = ss.source_set()
+    virtio_vga_gl_ss.add(when: ['CONFIG_VIRTIO_VGA', virgl, opengl],
+                         if_true: [files('virtio-vga-gl.c'), pixman])
+    virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
+                                              if_false: files('acpi-vga-stub.c'))
+    hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
+  endif
 
   if rutabaga.found()
     virtio_vga_rutabaga_ss = ss.source_set()
-- 
2.44.0


