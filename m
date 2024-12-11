Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC65E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZd-0006Du-1G; Wed, 11 Dec 2024 11:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZW-0005M4-Ux
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZV-0000Ta-7a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xp/Cl1MXRDbDXW7R4GInQg1UHIFQJ6brbsJU+CLkAsY=;
 b=d7mGJ+aX6liThU2+RJH8YlsbtebZQwWTVea4YBuBz5yfEDs4ALSOMCBomJcaStaejZa+Ug
 Tq5zoF0bcqog6v1NlBbeG8iv2NtT4n/FV5VklE4miTjCak7sqhPsQ/CzEobnmeeabPpgwa
 HVUG6SobEOIgqz1Ihy9KAV2OJVv3fbk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-fmyIeBQ2MGOsIkMk0cwe5g-1; Wed, 11 Dec 2024 11:28:17 -0500
X-MC-Unique: fmyIeBQ2MGOsIkMk0cwe5g-1
X-Mimecast-MFC-AGG-ID: fmyIeBQ2MGOsIkMk0cwe5g
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434f3398326so4668665e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934496; x=1734539296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xp/Cl1MXRDbDXW7R4GInQg1UHIFQJ6brbsJU+CLkAsY=;
 b=MD5Ji7ts3EIgObp26MPx97vkNevSK18e0gHJQBNOfVB1zG/mW4/juPzWyBZxIm+Svt
 O6ctui4B+PpUD6D2SxVwupHbk9EIZUAQXmczH5Bk376ITLH1ekvVeLYSIFrpuKrS1u7O
 iAKAinU21bao1HmQexWtzpYPObl2JqMF64gb50Dp2Yl3+YQoB94br3n/WXrJECzKzel7
 jfPb1cl/rqWzpW2xorDDAdRojxx3XdFlzJWBsLIAc8LbX3lf2eXld+AB3GmfoKU3p54P
 Br7ecXaKlp+pNYtgZYuWIwzXNzhrPnZeF68rFHJPlKsoMV8YsogozSuzpAw4Yx9jUInB
 5zxw==
X-Gm-Message-State: AOJu0YxrycRrja8pk5aOpNWB9gp44lZ9krpPO7OOGjztW+FL+0p4ok3b
 yvTNsjDqwwlUrevcEbMnkOgp9HO/OczhcZnpaiRPeQNGGDEWM8XhIqb/7TOJ0d3E/Yn1HGxHsRe
 F2KqEFzWlGuvuNTEc+MAWi8s8pe3DEt/j+oHGm9oeEWD5+7XEzMw6il44SxrfvhUvSoiDjpjw6D
 4SFgQPmfK2XGC1Bb37jBx+PTGdRJAaOgO2rQ1V
X-Gm-Gg: ASbGncvNGHouxEl/337KmmxdMhhxCg3yxSDk2xb0e3Ezu1YYnafrGxqvy7NnD+0U2H4
 0aSixcbqPgzdNEaV1mSsN/QNnztdTlPpjGN1P75wE/2ekJTKSh8OFMHJbMnOI5MZrGZkyoLTIAy
 +oO7IsgDWugA6J2usFrRB4q9tciSv6P8pglnnJxQLi4XcBp4uQFQodpTrYuUXe3D+pUXxbioXZ3
 6cm0/wpCLzZFRbXMxKwLE1D3sIK2s4EOjpa3LS9A3TPwf1JHfhIgpVx
X-Received: by 2002:a05:6000:1843:b0:386:3262:ff70 with SMTP id
 ffacd0b85a97d-3864de8ef4dmr2433910f8f.2.1733934496039; 
 Wed, 11 Dec 2024 08:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm2SYkr0RdJlt91nUaILw0MyL7ZvHqqEVLHpra4G31laP0c/1/KhHCoxd1EaygOOVG9F9bBQ==
X-Received: by 2002:a05:6000:1843:b0:386:3262:ff70 with SMTP id
 ffacd0b85a97d-3864de8ef4dmr2433897f8f.2.1733934495694; 
 Wed, 11 Dec 2024 08:28:15 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362104aa9csm10176785e9.31.2024.12.11.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/49] ppc: Replace type_register() with type_register_static()
Date: Wed, 11 Dec 2024 17:26:52 +0100
Message-ID: <20241211162720.320070-23-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-5-zhao1.liu@intel.com
---
 hw/ppc/spapr.c   | 2 +-
 target/ppc/kvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d4efaa0c09..827e7d6b140 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4723,7 +4723,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
         MACHINE_VER_DELETION(__VA_ARGS__);                           \
-        type_register(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
+        type_register_static(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
     }                                                                \
     type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3efc28f18b3..0d464824dbc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2633,7 +2633,7 @@ static int kvm_ppc_register_host_cpu_type(void)
         return -1;
     }
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
-    type_register(&type_info);
+    type_register_static(&type_info);
     /* override TCG default cpu type with 'host' cpu model */
     object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHINE,
                          false, NULL);
-- 
2.47.1


