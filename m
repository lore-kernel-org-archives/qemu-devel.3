Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8870C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENv6-0003kg-Ow; Tue, 04 Jun 2024 02:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENv4-0003e8-0T
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENv2-0007WN-0M
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igvy5MjawADq4B5bigVhVsctbwF1BmPBU2i5wDuvoNw=;
 b=PqhylQH+VFbscby68iNn1zZJf6f4az8WOJOmoGiNOgP5oYcLEHYgv6tttUMQ95Eq9RZY79
 H5osreajzmKFPl8KK5dIArZo/m/21XwygeL1wErHBAb3IyFnazKyEoURQ+QiDPuwp05KG2
 vWkBUirzMaYkXnLYlc4TkVtEqM8VbFg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-gd1mdqT8On-wuXyIuVmGdA-1; Tue, 04 Jun 2024 02:45:13 -0400
X-MC-Unique: gd1mdqT8On-wuXyIuVmGdA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6905050583so97003266b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483512; x=1718088312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igvy5MjawADq4B5bigVhVsctbwF1BmPBU2i5wDuvoNw=;
 b=WwWWQ3NoxQdfNW0Aar5XEDueZyJQI1PUBsTYtK9aTDwaINDefm/7dBfnPBtJ5P5dIf
 6rxAuIqEg9b4Fd3cI5uUGtV4CFBkl6KvsxI/BPh8iG3xvYpRcbgqTWdD4LFQ4VcOKfaY
 ZntX74UgkojwcqYOKfG6Y2ghUTPB7708z/POrtUHuombP0VhDdocdJ7v9AnQien3eIGS
 SG6oOk4innlBWgOxu9ymffvzwvQemPJe69mMIHcqF7nGlsopw1J+S56eqVJq1JidEWbP
 4CjCd7natGwmW9ut82xaJWHU71RLPQfsApwO3HpXYURCMkdSByHr3gveswTA2kVNA+r8
 +CsA==
X-Gm-Message-State: AOJu0Yx3OCRp05ZxGz7xb/x9cAuEjtk6C0tmF7mbctp/OquaGmbjIdOX
 lrTWF3ya3Qu0XH1cY8lLMY2+o3lym4J1/gAwVSPVtN55I1SqNpGdWlIVwZrYmQRkeWbK5OqVQNw
 W8R9Fz0oFIsY88AA4lVYSq6LsECMG27fsJSXXytglC7XuGdNxMbQdT7KfTv7fHAl5jDW9+DJtzy
 S4x+1670N9Lu73sF3SfU2qGDmVL5wnnAC0oki9
X-Received: by 2002:a17:906:670b:b0:a69:67e3:57e6 with SMTP id
 a640c23a62f3a-a6967e35b07mr29309566b.49.1717483511879; 
 Mon, 03 Jun 2024 23:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvvOW3MRqpYvtIdHt86T6NL8grWnMNUUd4UEAaWtrQYlS+xr2n0F69nabah24Ifu5bNckVXQ==
X-Received: by 2002:a17:906:670b:b0:a69:67e3:57e6 with SMTP id
 a640c23a62f3a-a6967e35b07mr29308566b.49.1717483511478; 
 Mon, 03 Jun 2024 23:45:11 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68aa93dfbdsm467308966b.196.2024.06.03.23.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 20/45] i386/sev: Move sev_launch_finish to separate class method
Date: Tue,  4 Jun 2024 08:43:44 +0200
Message-ID: <20240604064409.957105-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

When sev-snp-guest objects are introduced there will be a number of
differences in how the launch finish is handled compared to the existing
sev-guest object. Move sev_launch_finish() to a class method to make it
easier to implement SNP-specific launch update functionality later.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-7-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b2aa0d6f99b..28a018ed833 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -71,6 +71,7 @@ struct SevCommonStateClass {
 
     /* public */
     int (*launch_start)(SevCommonState *sev_common);
+    void (*launch_finish)(SevCommonState *sev_common);
 };
 
 /**
@@ -801,12 +802,12 @@ static Notifier sev_machine_done_notify = {
 };
 
 static void
-sev_launch_finish(SevGuestState *sev_guest)
+sev_launch_finish(SevCommonState *sev_common)
 {
     int ret, error;
 
     trace_kvm_sev_launch_finish();
-    ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_FINISH, 0,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_FINISH, 0,
                     &error);
     if (ret) {
         error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
@@ -814,7 +815,7 @@ sev_launch_finish(SevGuestState *sev_guest)
         exit(1);
     }
 
-    sev_set_guest_state(SEV_COMMON(sev_guest), SEV_STATE_RUNNING);
+    sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
 
     /* add migration blocker */
     error_setg(&sev_mig_blocker,
@@ -826,10 +827,11 @@ static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
 {
     SevCommonState *sev_common = opaque;
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(opaque);
 
     if (running) {
         if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
-            sev_launch_finish(SEV_GUEST(sev_common));
+            klass->launch_finish(sev_common);
         }
     }
 }
@@ -1457,6 +1459,7 @@ sev_guest_class_init(ObjectClass *oc, void *data)
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
 
     klass->launch_start = sev_launch_start;
+    klass->launch_finish = sev_launch_finish;
 
     object_class_property_add_str(oc, "dh-cert-file",
                                   sev_guest_get_dh_cert_file,
-- 
2.45.1


