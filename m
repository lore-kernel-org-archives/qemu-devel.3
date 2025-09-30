Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6120CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rsi-0006G9-Nz; Tue, 30 Sep 2025 00:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RsA-0005xH-88
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rrw-00036w-9X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xqxaePZFX7JBR5oQdbULc+FFYr1GnftgQIu74pDpp8=;
 b=bsECsgkvEEjETkMUggCJcTXIKPt6tWp/o89sSgBFy+8YYsrWkN3wEADliz5sjextfyL6fB
 CQODfjKMBVVOqjeWBqWWbFhMkUU56hAH6+LuyKWwsfRJ/QEmbIf9O2lgeqpT/2ASij84Lp
 07N4bXR4Y29qLjClb6JrntTAc0tZmY0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-uilRimncNain9O7VpEIBGQ-1; Tue, 30 Sep 2025 00:21:33 -0400
X-MC-Unique: uilRimncNain9O7VpEIBGQ-1
X-Mimecast-MFC-AGG-ID: uilRimncNain9O7VpEIBGQ_1759206092
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4f8e079bc1so3408978a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206092; x=1759810892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xqxaePZFX7JBR5oQdbULc+FFYr1GnftgQIu74pDpp8=;
 b=WZE7m5DczmYbDRpGs3WNs2TVPefZeDJuVitK8iJzyurUN7cU53iKxzkHP/wQ0kznPp
 uLSrUIxCc8yrFe2z2pFf3kF7z20Ty5uIIKWPMS/Mz6kzEM4JYHSm2kdn7XFPzAcnbcKo
 q+OxVlTX+jTzQMZ7lQNPmyfLUrnccgD3SdcNCKffVdCIDAGpWOus0zNL/Nub73M5hwgR
 Znn7/7teUasPfV+LxXZqTB7bwbmZG8YMBaPNtoAuE30uJuaRlMs6AtXG76yR7I7NAxjE
 yVGezuoER8NFTKh7YeOg0/VzyRsUO56q/YcR/i7HmPg4qtYFtDULeNhxqUIGn+6JwvwC
 19zQ==
X-Gm-Message-State: AOJu0YzlULjG3O6aHEjtNRXd1RSbCccmfu8zmsCoRkpImthdqKphk8tt
 DUI36jk0vTZNov6P0vC3FDAfUVlt9FwGbcDvDe7+crOvfENFE0Q60RGJSKcYXLIQdeEF2g6bWFz
 V6GTJ5AtNnsSK8qh2nn1GxzqUYrw8esefIn6k9yqp3EAyLolfmD/9c5Wi
X-Gm-Gg: ASbGncuuCZ+tA411+KNecn5zUrtVZPZnLFo2aWexPNswPm4oDAhHhj/KZgfkfV9ScXW
 i5aEi3ehW9y+5qORPAGpn+8E7q2WXmSiRizH0KgvTsLmvZaDQM7VwKcA7GCGDcslgpOTnEzkBoX
 GxMPm4pTHT2QRzZyoN8A27z8kqhmPOpr5hNJBfum6+YZ8wSNHxqQNMhCGJ9c31grd99gUB7rEx/
 BHvwrZL0MK5LVkRcJVdFyxSo+fDmYzMMBtDqBwJ7m0HFGerdLiepd+NVzvvhy2q6lpH4/KCkfqX
 2dOxXSdSv+q5tzvPpJDxi8+vf1TpPhZMos8cO7aeWLjYThEHZzfdQa6hLg==
X-Received: by 2002:a05:6a20:7f90:b0:263:3b40:46d4 with SMTP id
 adf61e73a8af0-2e7da45fb33mr24019431637.56.1759206092237; 
 Mon, 29 Sep 2025 21:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx560X+M9YrME/Z0Tz5cdZofYwihPyv09u2PRvoW9m2bU2A7m5dsWlm4DAGq94Sy2DFTIFhw==
X-Received: by 2002:a05:6a20:7f90:b0:263:3b40:46d4 with SMTP id
 adf61e73a8af0-2e7da45fb33mr24019397637.56.1759206091784; 
 Mon, 29 Sep 2025 21:21:31 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:21:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:27 +0530
Subject: [PATCH v15 18/26] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-18-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4432; i=armenon@redhat.com;
 h=from:subject:message-id; bh=h5tW37GzpnqCtqAOXaHs7SIfLXHIjIq7utdpfmqZYuI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKEE2p2M/dJYGbm48bPfpz9d3RezW5i3t3xn+R3Ps6
 VpTKJ7VUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLhmYwMB/++idh21ZIrtUx4
 Z7lg8ZG2J4qno57Pf6OlHrn2YZpfPyPD98XPD853/+pz4tK03vT3emunT3HkOP5girD79OoJH69
 +ZAQA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
It is ensured that loadvm_postcopy_ram_handle_discard() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f7947160fd5af351a09c0ae75879e80710df4c7e..b80da04b47ff08b4cb6aed1a57c703acaf3eb9ac 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2004,7 +2004,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
  * There can be 0..many of these messages, each encoding multiple pages.
  */
 static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
-                                              uint16_t len)
+                                              uint16_t len, Error **errp)
 {
     int tmp;
     char ramid[256];
@@ -2017,6 +2017,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         /* 1st discard */
         tmp = postcopy_ram_prepare_discard(mis);
         if (tmp) {
+            error_setg(errp, "Failed to prepare for RAM discard: %d", tmp);
             return tmp;
         }
         break;
@@ -2026,8 +2027,9 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         break;
 
     default:
-        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
-                     ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
+                   ps);
         return -1;
     }
     /* We're expecting a
@@ -2036,29 +2038,30 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
      *    then at least 1 16 byte chunk
     */
     if (len < (1 + 1 + 1 + 1 + 2 * 8)) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
         return -1;
     }
 
     tmp = qemu_get_byte(mis->from_src_file);
     if (tmp != postcopy_ram_discard_version) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid version (%d)", tmp);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid version (%d)", tmp);
         return -1;
     }
 
     if (!qemu_get_counted_string(mis->from_src_file, ramid)) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
+        error_setg(errp,
+                   "CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
         return -1;
     }
     tmp = qemu_get_byte(mis->from_src_file);
     if (tmp != 0) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
         return -1;
     }
 
     len -= 3 + strlen(ramid);
     if (len % 16) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
         return -1;
     }
     trace_loadvm_postcopy_ram_handle_discard_header(ramid, len);
@@ -2070,6 +2073,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         len -= 16;
         int ret = ram_discard_range(ramid, start_addr, block_length);
         if (ret) {
+            error_setg(errp, "Failed to discard RAM range %s: %d", ramid, ret);
             return ret;
         }
     }
@@ -2629,11 +2633,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        ret = loadvm_postcopy_ram_handle_discard(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_ram_handle_discard(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_RESUME:
         loadvm_postcopy_handle_resume(mis);

-- 
2.51.0


