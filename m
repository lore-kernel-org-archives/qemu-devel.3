Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14F5C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjN6-0006Ju-Dr; Fri, 22 Mar 2024 14:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjN3-0006IZ-PQ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjN2-000712-2g
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKoN19oHMDcrobaP2i6e/+46nFqFio8cvzkfoUlaEf0=;
 b=DV6YPXqCEPd3oDD520Cy6f8bcohaplOany+goBs3M/D3/M2099LCCtFp8atpPl7m/LE2v/
 Cgbreos4hrFJo6fcVZ3n2M17B3wfO8BEIcD3loB0LRWzSZf98in4OcSwG+McjIj6BYrJkX
 IXjOOhEHXH0kGTBcXqJbtBtGFr1BLXY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-tdqMKmOyMpiX6QSTdRGg_Q-1; Fri, 22 Mar 2024 14:11:58 -0400
X-MC-Unique: tdqMKmOyMpiX6QSTdRGg_Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4711e69b9bso130010666b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131115; x=1711735915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKoN19oHMDcrobaP2i6e/+46nFqFio8cvzkfoUlaEf0=;
 b=SbByCXEP/eFEJoZLER58jv89T0pIuvYF2xdl9BjTdkdP2PR4u10jCMkYCGkhdjbg8j
 tRoLJuRTF15Uiq8pXffibGBCFF+b52oal8O7RoSoDRCjjOzTNhx0BJt7fCB/jJ8LM8Oe
 ejh2w1ZGQ9vAgtVS+5HcsT5RKMDiJN9WoTgW/UxGq148c3r9IUh8Vk24gloznKMJ1+R4
 fr1V4WlF7FmeVexK0Z/iN0/Gy1NeY+YSzfhuejixP8WxJttudZN5N4J7RUCvf7d39Y2O
 hkiR4N8m37P7uavGx2MqqDTG44e8A8hoxkQPf3OQRKs+P5fjC6AiQjlBB7UBiGIjKNF1
 uFkA==
X-Gm-Message-State: AOJu0YzqdH5LN0soEig60Mwexo3qh/Ud7fgEP2EDzc9Xdo6FwcW6ayuK
 p8LQ7vvJMTDCJqx6/MP3QEw8+roCNEXLuDYkm9KdOSB3LUMb3kiDsg0DaQ8o3jikqBNVnV1Fy6P
 9lybz3tQoVRu+C+2HE+5eFC8Fya33/U8Zu63WceLHtSoViRdKLwAYij+QSkGF7Ku2/BaMva3904
 WMpVh2zSqg9JYQ/HNVGPa+Wbs+Tu0ZYthycppD
X-Received: by 2002:a17:907:1706:b0:a47:1911:51d9 with SMTP id
 le6-20020a170907170600b00a47191151d9mr381091ejc.73.1711131115690; 
 Fri, 22 Mar 2024 11:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvOFRaIAM+HpVA3SMdT24B5mRFLIptJh+Et/HFrqFPSE2dgxP/ZS0KzsCmEJ7KEPohisiRsw==
X-Received: by 2002:a17:907:1706:b0:a47:1911:51d9 with SMTP id
 le6-20020a170907170600b00a47191151d9mr381081ejc.73.1711131115413; 
 Fri, 22 Mar 2024 11:11:55 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a1709060e8200b00a46cddf1efbsm78830ejf.29.2024.03.22.11.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 11/26] runstate: skip initial CPU reset if reset is not
 actually possible
Date: Fri, 22 Mar 2024 19:11:01 +0100
Message-ID: <20240322181116.1228416-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

Right now, the system reset is concluded by a call to
cpu_synchronize_all_post_reset() in order to sync any changes
that the machine reset callback applied to the CPU state.

However, for VMs with encrypted state such as SEV-ES guests (currently
the only case of guests with non-resettable CPUs) this cannot be done,
because guest state has already been finalized by machine-init-done notifiers.
cpu_synchronize_all_post_reset() does nothing on these guests, and actually
we would like to make it fail if called once guest has been encrypted.
So, assume that boards that support non-resettable CPUs do not touch
CPU state and that all such setup is done before, at the time of
cpu_synchronize_all_post_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 15 ++++++++++++++-
 roms/edk2         |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index d6ab860ecaa..cb4905a40fc 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -501,7 +501,20 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
     }
-    cpu_synchronize_all_post_reset();
+
+    /*
+     * Some boards use the machine reset callback to point CPUs to the firmware
+     * entry point.  Assume that this is not the case for boards that support
+     * non-resettable CPUs (currently used only for confidential guests), in
+     * which case cpu_synchronize_all_post_init() is enough because
+     * it does _more_  than cpu_synchronize_all_post_reset().
+     */
+    if (cpus_are_resettable()) {
+        cpu_synchronize_all_post_reset();
+    } else {
+        assert(runstate_check(RUN_STATE_PRELAUNCH));
+    }
+
     vm_set_suspended(false);
 }
 
diff --git a/roms/edk2 b/roms/edk2
index edc6681206c..819cfc6b42a 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit edc6681206c1a8791981a2f911d2fb8b3d2f5768
+Subproject commit 819cfc6b42a68790a23509e4fcc58ceb70e1965e
-- 
2.44.0


