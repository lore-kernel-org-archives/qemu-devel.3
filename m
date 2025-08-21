Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D62CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0yF-000844-9n; Thu, 21 Aug 2025 04:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0we-00041X-Ed
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0wT-0001Ei-LP
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkIBrmqU3UmVPpuTfGUkQi3Qo/t7acfxhstmxrihGOE=;
 b=YnK3pqpSviEMtMK891a+nlgRJ4kVg6bdRDBRiRJAulpoG7UrdAFBYPyWXJ/dD+t2IqglMN
 cF5vmlRw+chVDjFpRyFTZhVWN5f38wvEHRU9sO7xU5kytOpremn/+83/bQKgwIYnBxo9nb
 X8s3132tbZ+tZYuoPTxqi1xMyDgMPxg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-99gZgqT6PGSuwo9480K52Q-1; Thu, 21 Aug 2025 04:46:37 -0400
X-MC-Unique: 99gZgqT6PGSuwo9480K52Q-1
X-Mimecast-MFC-AGG-ID: 99gZgqT6PGSuwo9480K52Q_1755765996
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2461c537540so668285ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765996; x=1756370796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkIBrmqU3UmVPpuTfGUkQi3Qo/t7acfxhstmxrihGOE=;
 b=KXVeFdXNLdtmryiy9r43/0w0OittoIjVWWC7PjoACtFgqSzZoplQFu4YBXYtnxbgrc
 3l07JtLqUI8/RALXFA6P4Trm7HCMhPhyhWWeW7/YnGLLOi+pKuClpncE13UX9fhW18Xi
 kpx6UCf5aM45ZG/9XbGW1wB21LHtGLkG1pIciDyz3KdNuE/AytchOl8KQzdjfL8zXnAn
 dnIQpKjDtIh9ewZKIrOLRh+l0pZTkfNrBXr9iCnmK4ghI4ZKGDdn4ojycAbiIESt1k/g
 P374oAZaPc+XBOTk5kPIGTif/1j3QNEda2ZccjcKGnXtKIai20RywvOsr7ZASKS8pne3
 52yg==
X-Gm-Message-State: AOJu0YznJ31c5Xfwpe9CUUdU0VjbsPRx/AlHuT4hC5xXeI4cFfk0cQEr
 iFS7yR1hZwYCaVZS7PXoXEgqg74nFLwAzDz7qKWcqX5zcD156T858ytRBKqL12VWZCp+t4Xc19V
 B93Kg6L+Dn67l4zZ7QcNXqpRUYIjMqS65SSgH8wOh758rgMGRM4jh6S4A
X-Gm-Gg: ASbGnctSNgxBpWb+dxpgWPhuU3Z0A6viUoqNeyZxkKhKtp2VXqxBdLbmK5zQiEObpAt
 c55uM/WnPvqH4WW7IEUUBZ3wUVcJcZFw+iNeZ9K2j/cGIuPcoPXUqD01x9EcJlSq1lfkSJQzyzw
 OzsqwnqGyJ2U68IkuE9dY77JNdxb0B3L0CMA+2jN7jg8nzrj59WkNWvPMB58iYQIdaHosbS73i6
 Uce94FOWY3iPlqIx/zqPlqj2M8XATpPCrQm8biTE5blnBz6EnlNnzMuWgoMttJ4aYdYyB9S6Y3+
 g+fRkrbwB73NzjGTxgW0v4i+mOsFW5HSXVEKJhyn5hiEAlxf5TJq
X-Received: by 2002:a17:902:e783:b0:246:2e9:dac2 with SMTP id
 d9443c01a7336-24602e9dd52mr21310925ad.1.1755765995742; 
 Thu, 21 Aug 2025 01:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg3tbka06dAd9/eOpFctNaRhInu/oFrGI2JTSXsiQMRwBfOi4gOVGcVXWlNbCnXQM4x6jbcA==
X-Received: by 2002:a17:902:e783:b0:246:2e9:dac2 with SMTP id
 d9443c01a7336-24602e9dd52mr21310285ad.1.1755765995056; 
 Thu, 21 Aug 2025 01:46:35 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:46:34 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:05 +0530
Subject: [PATCH v12 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-11-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319; i=armenon@redhat.com;
 h=from:subject:message-id; bh=EwE1vk6Jgm3Xnj0Q1uNXL1tpRUqGyiHG8RIWqMlxQcM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8nvjLY3PhYqP/Rx6fSeUwZuhxfMtrA98H77oe05+
 vtZ70xJ7yhlYRDjYpAVU2Rp+Bog2xRQGBFp+/I6zBxWJpAhDFycAjARjnJGhukTz65jyrrw2D7n
 8PQ0oSSB5d8i4w55uXTd/s0VLLLhiikjw9NqT96WTNlz8qcC7k/ZwbvuQdpiUS6GL7WByW3N8Wt
 XsgIA
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
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.
This patch also removes the setting of errp when errp is NULL in the
out section as it is no longer required in the series.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b55adb7468e5356ecb636734241f1a356a42a284..8e0ee14cc86dfffee86e46e32c7500d23924dc8e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2803,21 +2803,20 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
-    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2828,7 +2827,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown section %d", section_id);
         return -EINVAL;
     }
 
@@ -2836,11 +2835,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
-        warn_report_err(local_err);
+        error_prepend(errp, "error while loading state section id %d(%s): ",
+                      section_id, se->idstr);
         return ret;
     }
 
@@ -2851,6 +2849,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3110,7 +3110,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3134,9 +3134,6 @@ retry:
 
 out:
     if (ret < 0) {
-        if (*errp == NULL) {
-            error_setg(errp, "Loading VM state failed: %d", ret);
-        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */

-- 
2.50.1


