Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6862C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzhB-0006vq-NU; Wed, 16 Jul 2025 06:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzda-0008Gj-T6
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdZ-0000fj-9a
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pk7ECmEWBWCtqLQ5Fy/ewJ4UrlKpzE3br5jslXWi6+A=;
 b=ZAqct4J5Q3FTNuwog509k7YQvEM3fSyQr/2Gvbp7p2an0TQfpzoWOhj/uwMVoh33GbT271
 6CSEBVdGHdHQ5J9701f1bwq9kNSXEc4iVVDw4mkme+kM65jMBeHheCnmtvWi/13iFdUom9
 7G6CeLmGTIh0aq6aCQDb/mV75yazeT0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-SPqPsM5EP4WLzT5F_PQmIA-1; Wed, 16 Jul 2025 06:45:18 -0400
X-MC-Unique: SPqPsM5EP4WLzT5F_PQmIA-1
X-Mimecast-MFC-AGG-ID: SPqPsM5EP4WLzT5F_PQmIA_1752662717
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235eefe6a8fso51241585ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662717; x=1753267517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pk7ECmEWBWCtqLQ5Fy/ewJ4UrlKpzE3br5jslXWi6+A=;
 b=aAprnmILyQDkea4NmovIr/GxSN1Mb3EcR4AjniJitYjBasHEMpN+prQBtVzxUzwDkA
 vSWV/IS7nibyOyfexLbgHdfFHnfHkkAHa3KZB3tBh98CxhozZ4GZKe5VZ+L/n7l12aUY
 9I2aDeFsYaAW5g1kEOgEBJH5x7vWsbSKPByiwf13mHmwJy0YoUGf0tKQBXNozenEAQ7k
 KHRRY0OMT1KryHlyDCZtrZpO9TsjXCVsxnmURVn+rx0m12ob1meOS/skQZkDuvWkPIZF
 O1QnFytbKZY73OVlHsPYNjnl7N4ZUff69dzZrjb1HrLWGTURPzZbj+fIzNTTom/HpJ5X
 jxaA==
X-Gm-Message-State: AOJu0YyucZLp9+03yjUvX1h1RYRZ5HN0lfJpfaUmQslrg2Ikw08JERHe
 t/N00nnUTwSe0bOS6v/zT64AtjKEEoD/8IPEN741PGpgrvGC/VvaWrYjnn1TCUUz2L0EnNsuxHc
 i9xEwZm70gVTFcUhwi2qUg2ejs7XptKN9e434I6kQW24DHQP1gdMBCju1
X-Gm-Gg: ASbGnct87a/eWmfD9m37KihCdeoYDLK6zRmWkJgRqcCBK4I4XYhhym5e92sZ5FMjR/0
 UI36srmDGQvmohWgT73C5QNaEhoRKhC+qEQ1EroOBxa9MoW+naaxSz0DWzinvsV8wAZ11XprQIT
 ahGcOng6TmJllkkhiERyhKJ5IhZ5hHpbQp6t9NM3RsxBmpmfKM4LVqVlGCWb6BokNQb8CkTbcq/
 ys+RxJNSZ+O/BhvRy5/+KZj1ICedAWHtMXFw0uyJeXvtuqwuEQ32N38joA7dPF663QwjTGi6A/Z
 QcI+ugbUpcgtmTturu9OTmypeMqxya9XZVftKRbEP6XYKkqKYQ==
X-Received: by 2002:a17:903:2c6:b0:234:c65f:6c0c with SMTP id
 d9443c01a7336-23e24ed62e3mr33721115ad.15.1752662717545; 
 Wed, 16 Jul 2025 03:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPL0viZl7YYhDsNJ9rZ4PhjiemP3bdYADqTwNHjMLC+Xo/fbJ8/4tsXLGqA32+i2zc+nWzYQ==
X-Received: by 2002:a17:903:2c6:b0:234:c65f:6c0c with SMTP id
 d9443c01a7336-23e24ed62e3mr33720695ad.15.1752662717160; 
 Wed, 16 Jul 2025 03:45:17 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:04 +0530
Subject: [PATCH v4 14/23] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-14-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=armenon@redhat.com;
 h=from:subject:message-id; bh=+X/H+PuaDcKnGLgxS1vHYslTov2C3HY+iFWJdSwjVr4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k318ycWLj98+mm6/qfh4uB2H/e7Cz+7ytx0SxE8fC
 Ta/68/ZUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLdtowMP29NtOdwr/MSkS4W
 NupTNxSwcLT2rFTrLJ0kFip2Si+ckeHC+5zKgFtuIlNeh7wVSo/5tau7RnpTQHm15bIW99Ybvzk A
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 9843b359c2968098bef3c7c3ac336a5cfffb9917..b5cd6497cfe4eeb1a9428d4adfd52e4c8a7e7bb0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2333,12 +2333,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
         error_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2390,8 +2390,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2635,12 +2633,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_ram_handle_discard(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_RESUME:
-        ret = loadvm_postcopy_handle_resume(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         ret = loadvm_handle_recv_bitmap(mis, len);

-- 
2.50.0


