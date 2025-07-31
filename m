Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A9BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU65-0000U6-Bi; Thu, 31 Jul 2025 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFM-00055y-4R
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFG-0008BU-Vb
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DW1IUpPF5ZiKpDHfiTHo74xptJJXvnHIMV0+ph0+/iw=;
 b=J9nyqLOdsw/TcUl8ucWwN7i9X/sK4fxUat9A2AG7zEEmVv/Ph6fpKxrrqjUZUlXuOKnNJp
 xqEhkPWe73G3EWm2ANjlQlWvHV20hbVB8HJhs1j/ejNpQ4EK3+W4UjonmGsWHUEOma3jA0
 M6Bcn3EIpuHWeXNzdKZGMsVkDOiXed4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-E3dygPL6PDChvr17tGKUiw-1; Thu, 31 Jul 2025 09:22:52 -0400
X-MC-Unique: E3dygPL6PDChvr17tGKUiw-1
X-Mimecast-MFC-AGG-ID: E3dygPL6PDChvr17tGKUiw_1753968171
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31f030b1cb9so1522242a91.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968171; x=1754572971;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DW1IUpPF5ZiKpDHfiTHo74xptJJXvnHIMV0+ph0+/iw=;
 b=WBug776i9A86jn5tlr2eVMZjmDWqWFerI0yd7gMyoe/CGiUx6YMZThRZSzQ2uLJRZt
 clFHK8NnKllt+yOJ5ZPQq8l8BFRsl3o2lCQDiEgX3KKe9iJ8CJ/HnGLyRVCfJawRWW/t
 5fNe8/fyaYC39UA1waeDyemgy8wM7o981YVk5rkmBxlY3/uRpyfwfTnHG4MHcPxRfm7Y
 TXF18elz5pZ3+xz+KFJjaliOobwSZjoT8ZsCLFlSPKANVJX5Hfpj24q2Ks9q7oLVZ/5L
 xxOpZMtdnlJMe7klH+KoUkyFDDW4cuNur7l9JJtgjAHqQ8t24VhnwzEa2qvnXP98oyWj
 Aq5g==
X-Gm-Message-State: AOJu0Yz2NHCkzdKQThtLuNySbXfu1laIiAs8OQRHgpum5HDMqPrINf4g
 VMIvXLU6SuFO562bMGtpd3dTlrpyZsp2B0KVA7jJeY8YQZCnPh3oLToPuA/FzaKD2FBkP/2/nDm
 egnTg2fxXqIRIE0UU6LbTOAGAEWyIXTMi1pXBJdyIfqFXSJuC3XQUWlYyqPwSXSmBaFUpswnmnJ
 db8GxTglwR+sH8Rq7qKBqjUBEHBzrJCvJ645q7gjoogg==
X-Gm-Gg: ASbGncvzVj0YGKn8giJoXQRd1+z63T1HAIo0l+8+knxZ+sgcVvi4VNEQZioqWNpb0aH
 AHW9cJ5uOzR8acaKPfYl83J2sFpo1fqZsK04gBPa0iel8DukPbaZm+a/fqNh4kSJAX/9fEWBNmG
 VYFryRmFAv3kbjttx+H3lhrBXytCpBVnVko0a6Txt20lh67HTMbCWxj4pXbhehffmAsqh78SAgo
 wNOsP+/IAPTKuR/y8s5h6tUsN7/em7iFpExZwQXvYoxVhrfxM95/qmPW5LbRWkpV/tJPE4NKYKS
 on+QitGHNLq0eQrA5uu+/XcwdGLz1f5iiqoJUfH0QY+XrYRE6R5A
X-Received: by 2002:a17:90a:d604:b0:31f:3029:8854 with SMTP id
 98e67ed59e1d1-31f5de5561dmr10669280a91.27.1753968171083; 
 Thu, 31 Jul 2025 06:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtvBfHfVARD9jLj7SG/M6M71+OByko1bTpA6JOLnZMLl7OINgNwW6E+3ZkshObNVq0e4ueAA==
X-Received: by 2002:a17:90a:d604:b0:31f:3029:8854 with SMTP id
 98e67ed59e1d1-31f5de5561dmr10669204a91.27.1753968170515; 
 Thu, 31 Jul 2025 06:22:50 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:22:49 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:46 +0530
Subject: [PATCH v8 06/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-6-28fd82fdfdb2@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=armenon@redhat.com;
 h=from:subject:message-id; bh=GZMrml/XZ+AueUWSK097qKRlu/lpBaqzz/IkCXVxJdE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37lP2xy8Ku6bv3uvYo7Jv8xVjdgc1h8Cv4ozS2WWb9
 5xVSnPsKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJGEdQz/DE4UsG85baD7Yc0y
 GW127nW8cU+C7lW3ivomWN48LR9izMhwZuneN4LmL10d7Wv+1X5c8O0zxwyb53HRgpb1ApOUi5i
 ZAQ==
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
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 59751677c1bb7c893b4ba61cbfe1f55ade6ad598..9ed842eb87a019666d4409e1213c41643a173447 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2772,8 +2772,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
@@ -2784,8 +2785,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2796,7 +2796,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2804,10 +2804,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, NULL);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        error_prepend(errp, "error while loading state section id %d(%s): ",
+                      section_id, se->idstr);
         return ret;
     }
 
@@ -2818,6 +2818,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Check section footer error, section_id: '%d'",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3074,7 +3076,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, NULL);
             if (ret < 0) {
                 goto out;
             }

-- 
2.50.0


