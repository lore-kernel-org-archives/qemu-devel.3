Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A6C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl0RX-0005oB-T6; Thu, 20 Feb 2025 01:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tl0RV-0005o1-Sj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 01:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tl0RT-0000OY-Ln
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 01:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740034428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qi9JFAGDuhHg9O0I57gQFiOTHm0Co5TDo2QgNh/nzfw=;
 b=b3F7MY1Ygvsk+mQsaFgXPq+0Y38OGSw9twVTbrTCcnXuD5s/ijiK/2C9JByuEj/HaGkmrf
 Yi+l0l3sSJM3iLxWXSbukYn+TnJUiw/ftv1VblW6nBPmCAu3dlZv6LXw84chN/EhG/O3yQ
 VNnMwVsaWZ56XbLaGNkNTTSEeluR760=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-BaDuDWkrNC6Y-3m601xrlw-1; Thu, 20 Feb 2025 01:53:45 -0500
X-MC-Unique: BaDuDWkrNC6Y-3m601xrlw-1
X-Mimecast-MFC-AGG-ID: BaDuDWkrNC6Y-3m601xrlw_1740034425
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22119b07d52so9435775ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 22:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740034425; x=1740639225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi9JFAGDuhHg9O0I57gQFiOTHm0Co5TDo2QgNh/nzfw=;
 b=LsyY1+I6iTFdXeW0L2NsbzJTLXkVhYJHP2M4HQgn6rUzrphMylGkb5lTjoKroiqx2z
 rkrExWu9JH9IOdp+u9fMxq4jcXGzwDjnjIiQQCo4z9shDhkowmS3QAKRvccBuQ3p/Sfp
 aDjRpz2YSTROdAeqkADiofoY+beNVlF+NGjWhXHe7flDUjh1s0kMzfTq/hK+MhoTbQjH
 NCJywUUi9sjN3/H/lycJNs4p0wA2VZccVnBzGFohwpR8V2i4nm/kgr2TLO45BysSBdFw
 VdRk868Mx3uBwO+yErb3B9S29a1TJY5x2Iat++JpbsvQyIXh3xZhVTDgUwrAnp7WOBG6
 vZRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbJKqwjdDNoYpGWpd8YtHFqvUY1njg5wjV6QRsMmKsi5L8sSP9MuL7q6wUESplFukSCqcx6S1gySQ+@nongnu.org
X-Gm-Message-State: AOJu0YzozFZHpFBqneQL85U+qXLZZpYNmUwxr355OafARv9OkuC6HoX9
 Eb+qVJeXqgqIkUViHFyFadLeBEfQVBdrUo9wL8bb0sDVbnK/vIuwCYkFhzSWakLrld3k02rXzpj
 l4Ws62Y5BwQ+BqDTIsg1xeboCWELwpbQppquyXUNbBhNKXVwxwpOm
X-Gm-Gg: ASbGnctO0FvQ91ySShyXCBZ68MpR0bdJ3wZ8d6o1ENN5uQL26m6O9R2I/iV9RB0Qrb5
 yjPTvXRAxF4C3EhGZiupbJ0z1ndAr+/9ONb12vAhr04sreadnWLnQuxypP8PNyGZVFbsHvmuvsb
 p69l6KP4TukCE37uiGNA8egu33dEtBE2PyvgoUnn46exdwbETNJ+xTwCW4zF/FqTNklvYv/GeAh
 1rt3y0eLEwCTn4192F9Hc8GzF+g+a1pXwVPxcyftYXwbKlew8HQBOmZcRdhT2vy35J827GJLFLk
 Zgu0P8bbMonZYmNiLfU7SE6Fua3e
X-Received: by 2002:a17:903:8c5:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-22104030814mr355336835ad.12.1740034424792; 
 Wed, 19 Feb 2025 22:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUYbyalyaITCmu7XI0WFJRCfVrnwVvge8pRKaWSVoOeZgTIDZ6iXXHhaWmn5xc3SekWCQuWw==
X-Received: by 2002:a17:903:8c5:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-22104030814mr355336445ad.12.1740034424423; 
 Wed, 19 Feb 2025 22:53:44 -0800 (PST)
Received: from localhost.localdomain ([115.96.105.203])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-220d536698fsm114481805ad.91.2025.02.19.22.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 22:53:43 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2] microvm: do not use the lastest cpu version
Date: Thu, 20 Feb 2025 12:23:26 +0530
Message-ID: <20250220065326.312596-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
introduced 'default_cpu_version' for PCMachineClass. This created three
categories of CPU models:
 - Most unversioned CPU models would use version 1 by default.
 - For machines 4.0.1 and older that do not support cpu model aliases, a
   special default_cpu_version value of CPU_VERSION_LEGACY is used.
 - It was thought that future machines would use the latest value of cpu
   versions corresponding to default_cpu_version value of
   CPU_VERSION_LATEST [1].

All pc machines still use the default cpu version of 1 for
unversioned cpu models. CPU_VERSION_LATEST is a moving target and
changes with time. Therefore, if machines use CPU_VERSION_LATEST, it would
mean that over a period of time, for the same versioned machine type,
the cpu version would be different depending on what the latest was at that
time. This would break guests even when they use a constant specific
versioned machine type.
Additionally, microvm machines are not versioned anyway and therefore
there is no requirement to use the latest cpu model by default.
Let microvms use the non-versioned cpu model and remove all references
to CPU_VERSION_LATEST as there are no other users (nor we anticipate
future consumers of CPU_VERSION_LATEST).

Those users who need spefific cpu versions can use explicit version in
the QEMU command line to select the specific cpu version desired.

CI pipline does not break with this change.

1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")

CC: imammedo@redhat.com
CC: zhao1.liu@intel.com
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/microvm.c |  2 +-
 target/i386/cpu.c | 15 ---------------
 target/i386/cpu.h |  4 ----
 3 files changed, 1 insertion(+), 20 deletions(-)

changelog:
v2: tags added, more explanation in the commit log.

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe..b8be1542ff 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -458,7 +458,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpus_init(x86ms, 1);
 
     microvm_devices_init(mms);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72ab147e85..0a95b33d15 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5513,18 +5513,6 @@ void x86_cpu_set_default_version(X86CPUVersion version)
     default_cpu_version = version;
 }
 
-static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
-{
-    int v = 0;
-    const X86CPUVersionDefinition *vdef =
-        x86_cpu_def_get_versions(model->cpudef);
-    while (vdef->version) {
-        v = vdef->version;
-        vdef++;
-    }
-    return v;
-}
-
 /* Return the actual version being used for a specific CPU model */
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 {
@@ -5532,9 +5520,6 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     if (v == CPU_VERSION_AUTO) {
         v = default_cpu_version;
     }
-    if (v == CPU_VERSION_LATEST) {
-        return x86_cpu_model_last_version(model);
-    }
     return v;
 }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..71f150a05f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2701,10 +2701,6 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
 /* Special values for X86CPUVersion: */
-
-/* Resolve to latest CPU version */
-#define CPU_VERSION_LATEST -1
-
 /*
  * Resolve to version defined by current machine type.
  * See x86_cpu_set_default_version()
-- 
2.45.2


