Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5A2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNdN-0001iY-VL; Sat, 30 Aug 2025 11:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Lu-0005nt-ID
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Lr-000501-Kv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E61UbPQ98vkxoeM+8ySKgPLne5BO/4Y70dZrTRJJ2TY=;
 b=Zp3z5ruN9KWOKMJMNX3KB1mOxQ6VksEIooK82U9IAy30UaXz345elSncu5E3FklCDrm9P1
 KA8Q3fig08DmKffwJtbFawVmB9dkjWTIjvznjGfWshpc8xRkyBWXGpKZWdqLBNeohDV9Co
 Wz1d+EmL9n0o4DuTWfsFtBGXMQypvH4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-wLP9lAiuNjaHeWe59bCA8A-1; Fri, 29 Aug 2025 16:05:31 -0400
X-MC-Unique: wLP9lAiuNjaHeWe59bCA8A-1
X-Mimecast-MFC-AGG-ID: wLP9lAiuNjaHeWe59bCA8A_1756497930
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-327706e0642so4042168a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497930; x=1757102730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E61UbPQ98vkxoeM+8ySKgPLne5BO/4Y70dZrTRJJ2TY=;
 b=UFQ031dcp6/h2fQqwCgW+bOkVYHuFAvAbwK4tr40Ii4HeWSggaStVGO91ynimQD44J
 k5MqBVrI/cy+5N0s6KLDfTdQmAVRiZzcW2Pz3YrYV8M8aJddno1HRmMeD78zw725zS1T
 8C683iKPeqYNkLQJvqvAbQ1SAtmPy3OWC24DclRwh0aq8jguLUtBlrpvi9jZGoJfYoT8
 jGJful681Dav49n2EYhMfvZvnthow9g7powDyjRiDQ+okOkejygkJWt0rR6uAMKIYeXG
 n/xY3fsOhME8gxb5rlVlLt0u4oeABy+vDN6FiI+hlYiEFhDD0yds65RATWqgPtyAiuut
 ZgPw==
X-Gm-Message-State: AOJu0YwtQqR8cjmZKdSwS9db+xQBZGIAp32t3ZCZtutTRrYj8XC0z8aM
 QfRW+DkX//K9I73UePDmpMMvWx8HN7wvVJAQAvlL92cVzSBrqYfIPZScnBzlbPgXacEEsZ2NtYO
 15RjayjEYjWPOKkP/cPwDdembok9n9myGkFpYQdtiB6AnFqOV4lkvJSw+
X-Gm-Gg: ASbGncvRvGac+pxMFT34uNhMBvJbUGvFjof6WIE008qh7zhCXMNrRXaFzuHks5UXArU
 4Jr8ppNWBNt9BR5jU6uElC7DZBTc9MR4psFbclz474OTMnlEqASzmDVj9OmULC+RJzOjl+Yafgs
 D0mx0Ybp4FJyorJ2qvX/oY1MKuq8xeKis1QtqReDhlJedjKYpl5kPKpxzV4pVihkgY4y8ITsoTB
 CRJAl7mgMrm4ORsKtnXipB0q3T3yLzPFOmQZ9U1u3M4xXE82gmIiARxH58Io58yJfEhLlchrWC5
 Mbcl7zFIk+nWTfJMr/bLROMNyMRHT4nsrR/htQS9bYlJ7o/YkmkOlA==
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id
 98e67ed59e1d1-325c492175cmr22835607a91.28.1756497930079; 
 Fri, 29 Aug 2025 13:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuX/BrZGUS172oogpgm5e6mzBTOhZOlFtQqbEyr0ARMKNzXC53YQE91AW8LSA472NHdtRa3Q==
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id
 98e67ed59e1d1-325c492175cmr22835556a91.28.1756497929609; 
 Fri, 29 Aug 2025 13:05:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:05:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:53 +0530
Subject: [PATCH v13 13/27] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-13-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=armenon@redhat.com;
 h=from:subject:message-id; bh=J3tCTCrF6nSfsNZa6QUxbIzpTTI6Us9gYinavq3Uol8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdt/ciOUuZSfElEo/hXLe3BQ6kSdq/bYj2WuSj8tua
 9a+xj2to5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQEWhn+6R77/EEq7FXO3nf7
 zm3VmHqp6XfGp8+yyx1EUw96Hv9wQ56R4eiDt8fvT94s/2CP1Fl31e1uIpY/1ig2WUyT+msyJ2z
 1TiYA
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use warn_report() instead of error_report(); it ensures that
a resume command received while the migration is not
in postcopy recover state is not fatal. It only informs that
the command received is unusual, and therefore we should not set
errp with the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d54028b1be4d7a1e4615c2b05611535bd7478e2b..c079942b7ecb959b3b668b977174d906f73c2777 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2334,12 +2334,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: illegal resume received", __func__);
+        warn_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2391,8 +2391,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2647,7 +2645,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         ret = loadvm_handle_recv_bitmap(mis, len);

-- 
2.51.0


