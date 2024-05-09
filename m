Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35409C25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578a-0002DI-Iz; Thu, 09 May 2024 13:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578Z-0002Cv-MX
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578X-0003Uv-UE
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LrJYd46GHGKVcNYX3wgLHzt987Ipk3AVpa7I+rUYDY=;
 b=R8m8OAL0f24r/PkU3LkbT2aplPa/Ay2OZWtsDHmNuc6Bkwtz1Ezo0jwWj2D7+tTguqy5mg
 6RwGyd7z0d5icuenfPi9RAKK2AIoqzVeUBkj4DWXuko3Q8EECuzgH7/Ai68iqqb27yfMNU
 a/nOOBg2dY/g5RkOr1n9E91ZdqRH3SI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-j6ZPJ_ZSN82cs3Sh86Y2Uw-1; Thu, 09 May 2024 13:00:51 -0400
X-MC-Unique: j6ZPJ_ZSN82cs3Sh86Y2Uw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59a5b06802so63539666b.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274050; x=1715878850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LrJYd46GHGKVcNYX3wgLHzt987Ipk3AVpa7I+rUYDY=;
 b=NjX9ba0KiBTlKfRvlyIuwsRFlJR0OtlhnRoQV2A29GKaLQHI83DJOnXWQD4IJ1BTIF
 C+u3kmVlnLN4Q3WcO78f1363Aix3HWS1f3FxKyIjA9EMuZoywb8A94xlIGKA7sr318pX
 y0o5zUA22o4Jf5DgTSOy4vRhD8/60urylIc4SxBGyGRV9p+hwcjoFQLNAB7m3Vj3pOqn
 B7/3UMwO8t+OV+m7oALWYsh5LVVsgz5Zr2Q/OcC9/xCT4LVeZiOL0zZlBphxf+LNAeyX
 bo5i41hK4JcrALwAilc1mzDKkqc0fxpZzbY1KJVLAUavDlqdTKVhngDFonvv44GSd6y7
 Ql3g==
X-Gm-Message-State: AOJu0YyoSd9BkEtygbu3mhjIGWOxwwSP0f63dpk73iEMl3eaJ+Y/UtpO
 pQoc/2+IAz4ftNwnguO08LUQ4oL3dGwNcXcvl1iWWuVJ3WTH0WC8vYXIDLr9Zm9WDToBt3tjBW0
 4Z3VH987gJhY69yYMlDLNycYlgbXoBp57m3ojx0PYV6G3TfALkdUd7b4wk6xUrG/KN8w1PJZNRI
 r+ndtP66IRgf+5f0BuReYMdBIt3ICPLgF7GObF
X-Received: by 2002:a17:906:f6ca:b0:a54:c130:21fd with SMTP id
 a640c23a62f3a-a5a2d53ade1mr13736966b.13.1715274050031; 
 Thu, 09 May 2024 10:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHreuDCtL1B1aeAW4RUhdRt9SuJ2I7vlx4l7CrAcCke/aTgNgWMXoblpJ29V45D4UCHJJUHgQ==
X-Received: by 2002:a17:906:f6ca:b0:a54:c130:21fd with SMTP id
 a640c23a62f3a-a5a2d53ade1mr13735266b.13.1715274049704; 
 Thu, 09 May 2024 10:00:49 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17cc5sm91389566b.205.2024.05.09.10.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 02/13] s390_flic: add migration-enabled property
Date: Thu,  9 May 2024 19:00:33 +0200
Message-ID: <20240509170044.190795-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
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

Instead of mucking with css_migration_enabled(), add a property specific to
the FLIC device, similar to what is done for TYPE_S390_STATTRIB.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/s390x/s390_flic.h | 1 +
 hw/intc/s390_flic.c          | 6 +++++-
 hw/s390x/s390-virtio-ccw.c   | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 3907a13d076..bcb081def58 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -47,6 +47,7 @@ struct S390FLICState {
     /* to limit AdapterRoutes.num_routes for compat */
     uint32_t adapter_routes_max_batch;
     bool ais_supported;
+    bool migration_enabled;
 };
 
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index f4a848460b8..7f930800877 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -405,6 +405,8 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
 static Property s390_flic_common_properties[] = {
     DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
                        adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
+    DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
+                     migration_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -457,7 +459,9 @@ type_init(qemu_s390_flic_register_types)
 
 static bool adapter_info_so_needed(void *opaque)
 {
-    return css_migration_enabled();
+    S390FLICState *fs = S390_FLIC_COMMON(opaque);
+
+    return fs->migration_enabled;
 }
 
 const VMStateDescription vmstate_adapter_info_so = {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index feabc173eb3..1383e47eeb5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1174,6 +1174,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
         { TYPE_S390_STATTRIB, "migration-enabled", "off", },
+        { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
     };
 
     ccw_machine_2_10_class_options(mc);
-- 
2.45.0


