Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A51C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzez-0001o0-V9; Wed, 16 Jul 2025 06:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubze0-0000n5-9E
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdx-0000kH-Ie
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAF0noMQurlPmtqo1YEukseuZMatujPkgBB0tdCHQME=;
 b=guf20WIns3o5ByICEJJpfr1v350WXAnucxeOcZpzBns+Ny+mndt2mgQw/2YMPJTbrTGNlO
 AOqKmTYngHmIoehRyYcUW0y2UBB/nrW/K9GpuPPSy8n5z2LuYHYOrQk5H0Y5GapI4tmS7V
 miG+YEjF+PtUVXjU/G4LKiBBUezsU1M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-tdm96dlvNne5NehGoQk2zw-1; Wed, 16 Jul 2025 06:45:43 -0400
X-MC-Unique: tdm96dlvNne5NehGoQk2zw-1
X-Mimecast-MFC-AGG-ID: tdm96dlvNne5NehGoQk2zw_1752662743
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2356ce66d7cso105079375ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662743; x=1753267543;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAF0noMQurlPmtqo1YEukseuZMatujPkgBB0tdCHQME=;
 b=wMGSmmQDtVAW+6OzAdEtV/cINay4Va2zeMB7b0TDx7UzZ2+GICZJzJRyNt6gDRMwXr
 YMQPSEPmPLIi3n9O5YvGqhQOmx9b9nn2KZEklEaBxYc8bvRurjgjKDvJ+2b6Ke87ONpf
 oNvZ5Toq6qTdqgscA2atpdfrIPBGlxteP6awNbCJhlkAZLD9yvQH2TFTDuF6CbdmAYBh
 SmNWGrwYj6L901SscDc7+LpcnF9wwRfrkcqe5VRM8k2fOTBHgHZPUkAwpKhcME66tu3F
 UsvrrRK+mWX4JIVIIUMWk9r88uouVMUTbH6IQXV5VeMGNGPSfpIza/rXICypAcW4dw/k
 SkDw==
X-Gm-Message-State: AOJu0YzmYPZIfQHx0QcWkxPxK/HNBiTXAW00n4kIOuXzfG3J2j+fVop0
 LTK07YAF2MVWUnA3oe03CX0i7vp2J7G1PcesaWc7m5tBMC5u6Ab4rjol4V5R05fEWxhw0jsENWa
 6tR6fdHdql0mD+1oCaDeI9Zpb8jm3DFBRItKYCUi8HuPpkUiZKqRwV8up
X-Gm-Gg: ASbGncuxa4XIz8DDOy9q7T/rngCFkkx8dkQEza+kv0j1siyUEuWRQimQZUfzQhNLGvw
 1ciku7tpcHrhCfH1uNlPaZTignnPyOtkOYVwQz0sYTeZFXbzfRWCQfWlJJJOfHdU2+kAbO2OwMN
 8Nl+TWwSBiRubX+t/lQWWCWIZhSM4wRFJ/bg1e/H4zgSXoBPk2SBt4KPxHwndas1b2VER0QBbuQ
 1KTtr/IeTQ7WDh58fQMQqlEnPjHtd5du9zUPA0s7xcE6NyRgI0JM760pWHT1p5eJjSfgZdH59lD
 2E+djGYnfxJiUxcv0gzKSY8RNQtaptMZp0sr6yJQuSXiNsvXUg==
X-Received: by 2002:a17:903:2441:b0:234:a44c:ff8c with SMTP id
 d9443c01a7336-23e256cd198mr25672225ad.18.1752662742815; 
 Wed, 16 Jul 2025 03:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgXTnKwbVMwED7PWRJJg4zwTIoeB7824IhEhz7AqE61yP3H0zVEz/wCqPY4SxNtmvQ1du5Ow==
X-Received: by 2002:a17:903:2441:b0:234:a44c:ff8c with SMTP id
 d9443c01a7336-23e256cd198mr25671635ad.18.1752662742413; 
 Wed, 16 Jul 2025 03:45:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:07 +0530
Subject: [PATCH v4 17/23] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-17-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=armenon@redhat.com;
 h=from:subject:message-id; bh=i6EtI1EJtxgu7zEw9aw435DaWLJjjvNxIDw6J2FQGlo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k0Pmipuzl82WrotT3Gps+FLcMkqZtSt0AlNIoObEe
 JuQixIdpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJrLpLyPDMeM/PMp2BbXWi05c
 WFO4vbHkY1srm/qOltXfM++XFEmUMDJcfsU/uyPOMlfpzkmhlX9rt0sec1isI8CzMufGj0dGvZJ
 cAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a4add82ca0f654bfe7252ae33fe80276f8ee5ffd..2df266129f24d3d0d24ee84c3a8d2f494e50d03f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2527,7 +2527,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2540,6 +2540,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2650,12 +2651,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.50.0


