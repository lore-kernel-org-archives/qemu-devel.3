Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E5BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUBZ-0004Z2-NN; Thu, 31 Jul 2025 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGa-0004Bl-1a
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGY-0008PF-70
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLghEdi44xi6/POYpygXyfMOGple2iuK5st+VMUWU2k=;
 b=gsNUqZ6o32caURu1PFSbWXMNgXtMSO49ftharIhSscDYCuY2nLUh30Gyzg1HrW5kik9I/U
 wzJ2LkGyI/Y9UzX1N+rjfIcni9Vzx/QolG2O6j8YeVbEqn5Ca3zSmQTzS4VW/YCoIg5Q1e
 q0rDO+O53+6pfvl0TudPBzNSj6mu524=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-wxXdfNJbODiZ1hdiUY_cIw-1; Thu, 31 Jul 2025 09:24:11 -0400
X-MC-Unique: wxXdfNJbODiZ1hdiUY_cIw-1
X-Mimecast-MFC-AGG-ID: wxXdfNJbODiZ1hdiUY_cIw_1753968250
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31ed2a7d475so996748a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968250; x=1754573050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLghEdi44xi6/POYpygXyfMOGple2iuK5st+VMUWU2k=;
 b=nwurGhMnBJG0te+V/CceCVwF8O1DpdEHhSfHgrb4IvqT/kZTbi++6SWAVVHwN/GCTq
 B1TGWgbXv+H3IGvbGxWP3o/F7rXs7U+gHiJ6r0/tCGQ1Q0m/PEgY5I5nnwbw7gx6rvK+
 OdYyeP4TouGWAIDm4Y8uPOo89j5Ti/Wlw14DesIJcLFTGfwS7NKhYvW3KFXngZ6dHUda
 letfAXIwfR7/J23dG6h1T//KDNjtJpIXknlZw8sAv9rsXnCjtnSLpJ+bD9xlTTUcGOuO
 MUW/pqXzGaQdZYFbG/kwp9JjWDqWJs3ZzqH57gp9VciW0qDRe/3jZcmmc1SbFTcyzQPd
 i36g==
X-Gm-Message-State: AOJu0YwliBYXfyAD6qmblAWlc6PrHQ+lo8zjXE2umSXawKNHewSL1PeY
 07dlG/iscVigXIYFwAfDNzPF6c89anDdh8q0OsqI4lQ23PPI7FfIPP5gk4edxfoqf04nN7ofJGM
 tSYCv8lfbZNwjMSuAF1vqeOCvbYcDjdH4BUdLrfRN2D+FzQoPqy3pEkCicspfXmaasSASPI9fAx
 hCMcCLnnhiVYTzfY43L6W8SzgpuO/+v6EN2Gh7LBFHjA==
X-Gm-Gg: ASbGncvVr2Uuqyej2NFYGVY0Pfk9l9BWjb0EV23gbDjMpfo0RBb2Wv+nPSleC3M61wH
 85GER9kb29ubYxjE5oVFZ6VI89CZCt8BaOXPiKuTKhFKHNG8QamOEQih6hEPiHa0TP02MoWlvkA
 5O9IrBP9c6jGSK5rrTTvCOla3gKF7IA9197lMZz4/gEqgy9iysrlThtW+JV6Ye5l9yUuMC8yrQG
 OIT8sbBwCjyNnQrIwyLqidGaXloxp7vuQCxHNJt3JAyg/3B3qsY+VokTFxA+tGsUpB2GmgaP0dq
 kRtpgBmmr0siLpvLq9j+1eiITvPhkFwJWsLZmxHLBbr6KD1lO/Pv
X-Received: by 2002:a17:90b:4e88:b0:31e:ff94:3fba with SMTP id
 98e67ed59e1d1-31f5de73be3mr10968961a91.24.1753968250181; 
 Thu, 31 Jul 2025 06:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRJ5xULk/vCXVp+z6uvdiMa1wS24tfrk5Fa3pMGUSobsyYWl/IgpyQYiPt48gJ9f7omyryDQ==
X-Received: by 2002:a17:90b:4e88:b0:31e:ff94:3fba with SMTP id
 98e67ed59e1d1-31f5de73be3mr10968888a91.24.1753968249545; 
 Thu, 31 Jul 2025 06:24:09 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:24:09 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:54 +0530
Subject: [PATCH v8 14/27] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-14-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=armenon@redhat.com;
 h=from:subject:message-id; bh=WpuifoUIMf3O+h85by3an6J009O2UfK/XwRSBRbjBtA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rP3vedfZXwJujK3NcT8P7tvdtYH1qBwtScP8t9VB
 ekzePt0lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmIjMC0aG1qU5R2XLLGyj5irr
 Tb1s2sb6+t0dFwf2mjOWKQEGzx8wMjK8uPtjR9A8Vl/JNV57O4zbOe9M5DN9MlE4PjjZ6+KVJbe
 YAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c9ca0628183312e19fc72c06f791dc4d53566c16..771c3d2a074d5b6a5ebd3ccf58d564d9b4cefb93 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2273,13 +2273,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
 
@@ -2625,11 +2625,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.0


