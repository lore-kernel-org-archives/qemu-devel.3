Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2415C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578s-0002Hb-WB; Thu, 09 May 2024 13:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578p-0002GS-0b
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578m-0003YB-Vs
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgqJCblTtWKOGjneOII9w24G3R5kWdUK9+a6Wm03r3E=;
 b=hu7qxq05qbpYlws5ewprlkip9E5a6RvU1X/1y/6QCHqYk4+H6ZKs+lDy+3NCvZcnZJ5o/b
 HpnYpPxU/6dasUQEK+ErboANg3h5yrPyO8vOcbjo+rmQPTRq15l24mhy2ir11Sk/jcGj2F
 vaYNk3wXodo4cF9HE25T8+xqIq7PnhE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-Dw_GSiN-N12x3ZK0erYOQg-1; Thu, 09 May 2024 13:01:06 -0400
X-MC-Unique: Dw_GSiN-N12x3ZK0erYOQg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5206ef0d6fdso961255e87.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274064; x=1715878864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgqJCblTtWKOGjneOII9w24G3R5kWdUK9+a6Wm03r3E=;
 b=u1rqKT/oTJAGwepCxnkDICLZTnsw/uwIv8Q5GPn1IdigO86RSIuGaExRdxWc1BovwP
 eME2HIab7ZVGlTzLfnNuhPr1tmeIyur0y2WHsRXOeRLc+4oVuWrhwcSPSkufOQp61PEB
 UM2sK/zALK/+ig+RfDU2mqRc3LlJkAnyFBNRAkO3/4qe8FKJGGVKYxd7bW0mXCqwK/ng
 tqualg0fl04TooYZLoVfYYD5d0TGpjlkmijJQCNmbvdAERwqgoMfrB7ks3eitzlu2xy6
 B9hUeLqYpq+0NOwFBagXyRu0hKGhF9RiqWjDGMGXhFPaSGGynWWCt1kNv+6csg321iJK
 dk5w==
X-Gm-Message-State: AOJu0Yy79M1ND6z6k3Mm6Y5ykBRameWw1jVFiJ62GocA4nrSe8BbN0aO
 6Q9rMcZrJGcuwVrf0AjGu6UAqns92XJS5FiW0giaofDhWXn+NH0m07Gk0gwoJ0X1LG8Bj6O+b1U
 6C6ESOSGsl9lE6e1UQktPcieH7KwjiySq4AEXdwSzC2ZDT/nb4Vjw2/+JGWV1OzuyYVnBk0Jdam
 kthOMUN9vbxlpMUiG/ZMv3kZUJVpiBWC5dfZFp
X-Received: by 2002:a19:e043:0:b0:51d:2529:7c4d with SMTP id
 2adb3069b0e04-5220f646013mr98117e87.0.1715274063955; 
 Thu, 09 May 2024 10:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBNPmqz2/dhBivLLDbKihMa1v+CFAs1PRZ6MxFKeBXvgFcB0GX88zY4XFkXUWqcloEYjz5Lw==
X-Received: by 2002:a19:e043:0:b0:51d:2529:7c4d with SMTP id
 2adb3069b0e04-5220f646013mr98108e87.0.1715274063596; 
 Thu, 09 May 2024 10:01:03 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b18110sm92085866b.225.2024.05.09.10.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:01:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 08/13] i386: correctly select code in hw/i386 that depends on
 other components
Date: Thu,  9 May 2024 19:00:39 +0200
Message-ID: <20240509170044.190795-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

fw_cfg.c and vapic.c are currently included unconditionally but
depend on other components.  vapic.c depends on the local APIC,
while fw_cfg.c includes a piece of AML builder code that depends
on CONFIG_ACPI.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c    | 2 ++
 hw/i386/meson.build | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d802d2787f0..6e0d9945d07 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -203,6 +203,7 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
     fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
 }
 
+#ifdef CONFIG_ACPI
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
 {
     /*
@@ -229,3 +230,4 @@ void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
     aml_append(dev, aml_name_decl("_CRS", crs));
     aml_append(scope, dev);
 }
+#endif
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index d8b70ef3e9c..d9da676038c 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -1,12 +1,12 @@
 i386_ss = ss.source_set()
 i386_ss.add(files(
   'fw_cfg.c',
-  'vapic.c',
   'e820_memory_layout.c',
   'multiboot.c',
   'x86.c',
 ))
 
+i386_ss.add(when: 'CONFIG_APIC', if_true: files('vapic.c'))
 i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                       if_false: files('x86-iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
-- 
2.45.0


