Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDDBC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mj-0003J0-F0; Sun, 12 May 2024 06:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mh-0003Hn-Cp
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66me-00061Y-6n
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uezGeFyim6ovuWYoINo/lMQ5Hhmp7uQJxfjY2Xs8BJI=;
 b=bUwzts5ddlRZD8wv7+J/SC36nHaec5h3LDw/DSOvkYuSxhiPyY4bZaLFVIdY6pog5XX8j3
 TCkz912LI31sPAGb+aldfUc2PCIIpXNoi6wTQgZqTPEnWPMFoxRbsQa7K4nRRVmi36lufM
 lTzL8PSJYKdvlW23soKb2vNB+Z5DFyE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-spZ0NSiBPCWnHRoJ7s1zag-1; Sun, 12 May 2024 06:50:16 -0400
X-MC-Unique: spZ0NSiBPCWnHRoJ7s1zag-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572d0cb1ffbso2497299a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511015; x=1716115815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uezGeFyim6ovuWYoINo/lMQ5Hhmp7uQJxfjY2Xs8BJI=;
 b=M+TfYVT+yasTE4AH9NXPJIVQtcRS+SBgLJSDGemntJztkocMRn1+s07c8AGtglyWk1
 WrUxPNKIuZjizMVTviR3mzyaoGIM7LY1wBNenTN/vhXNidJTqm3mhnl8Hzqxa3S4GNNd
 WhY0+nocZ5NMQsMyE/SKFrrq4WslENQZjkBrAprKLO9HJhLJx9sEnRe4w+FjruzaNep2
 PCsHTtOrAe2e89vCXDN7etBDF+Wj67gOzCietM30+/dE12OkT5t9GalOi8gslc/D4jPB
 s3/RugxGnmHRpvtED9iAZ9F0f2b/UVGBy6TIdjJ8CzxhHENjH70wCT9f1SzismMFzWqf
 n1PA==
X-Gm-Message-State: AOJu0Yz9cLPDVNq9OYGD8Rb1qC5+uDommNf9bhVr4vV7sXSK0A9Aekjd
 KQEM1OXWFJuO3cHQ+CrWA3YiL22lnm48veaRJG1sL5YJwfJ7Z6mHoULbAicT31xNEO++oJTRB62
 6SoQz9N/Nj/kduIJQUBnu5HyRUfrYpd4BwM6TW3xKaYLvl5OYjXdXQMQ9D74rObEEilT5H55gT+
 oFVs3pu4OkOwOAkfvy4XbrIoittRr8/k25qsgK
X-Received: by 2002:a50:8e55:0:b0:572:952e:7a5e with SMTP id
 4fb4d7f45d1cf-5734d5cfe4amr4682294a12.24.1715511015231; 
 Sun, 12 May 2024 03:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHekULmLiFK/eeRTT0t/5/5T8uWG+fLqNRrRQWXMrmiu83GbqguW9VXU3Ym6GmOeMOBCiEPHw==
X-Received: by 2002:a50:8e55:0:b0:572:952e:7a5e with SMTP id
 4fb4d7f45d1cf-5734d5cfe4amr4682287a12.24.1715511014941; 
 Sun, 12 May 2024 03:50:14 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-573413b2ac3sm4335452a12.38.2024.05.12.03.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/27] s390_flic: add migration-enabled property
Date: Sun, 12 May 2024 12:49:28 +0200
Message-ID: <20240512104945.130198-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240509170044.190795-3-pbonzini@redhat.com>
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
index 42628fc45d2..756b4f40aed 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1182,6 +1182,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
         { TYPE_S390_STATTRIB, "migration-enabled", "off", },
+        { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
     };
 
     ccw_machine_2_10_class_options(mc);
-- 
2.45.0


