Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC81C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU7s-00056R-DI; Thu, 31 Jul 2025 10:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGl-0004iw-94
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGh-0008Qn-JT
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuolSDeBSIsoWRBk/Igedb1zB8G7XhbIrcEjsXNUiTA=;
 b=WEFajkG7dXfdS1c032A2izgoYwQqaNMWWWQUOTCBWeX7rqdKec4U2ZI6g66r/f6VCY+yP1
 JUvh9+1q+rvX19XdXvpet4jNRo8ekWm/LbxdRtUFsf92OGT5da03Wl9BglVnKsFk4VL8YW
 /jS/4IwejC6IVwhBMNstdGE5TjZMqCI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-D4cRlDeMMTaIm2xeG7gclw-1; Thu, 31 Jul 2025 09:24:20 -0400
X-MC-Unique: D4cRlDeMMTaIm2xeG7gclw-1
X-Mimecast-MFC-AGG-ID: D4cRlDeMMTaIm2xeG7gclw_1753968260
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2400117dd80so3136515ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968259; x=1754573059;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuolSDeBSIsoWRBk/Igedb1zB8G7XhbIrcEjsXNUiTA=;
 b=MwyHz2MiQ/HOmiT/+26nS1kbmTdSxjwW8/Av0tjY1FiCz5+RW7OJDG0PQ/oe/C3ScQ
 lwA2E4/+9lObeKfBWnQm7AxkJ3dYuCIxYVS1iwUnEWE8Rg5MzJ+sRUECob2kj2/o7sz3
 K2c2GeNJ6OWuJkRVIMld4UO4OMJQhGkfb4lRrJeUbIpmWw+p0MMhOsteeTsPPWVJdOeY
 x0X0ybgz78DTmDLn+tlw35vein5XqU+BUSQ0ChTJ6UEYeU1UHeN7nWdxqMXQA1EJvNFh
 n7K2o6/9T6pwkqfF9GQMGfRVVfz/Nj0EjlljcI2NuC83I8sWIGZYeltZwmmlU6QkZjdl
 RV1Q==
X-Gm-Message-State: AOJu0Yx6FYCN2rceBeJ+xhaweapIWqYUMh+B9vde1WWSTO/tbPQBqQak
 TC17SoqW+KMkrCI87VJ5FzMb/tOzSEPHDakETyAjASJr4SPl+2We0D+e+6U+mLP5g1PjK7z3YU0
 zSs5Zw15PuoG90k0iqSXZcZud7lVFRr9eBJjCQBikvAUtDZbEL40EWz/Q41HQD7NxOEo8CgrVu2
 iGhHsLm60P7Fof7bzycHq6SEkFcJZMps6FtCGUK0lWew==
X-Gm-Gg: ASbGnctSgcxnx+dqYG7mT5S6/Y44DzE2mN3oYvNGANou7CMSbvjMD8V3Rcpb1amBjRN
 A8WrKQAyO6yWc0+ObXvTWBoHCUopT24r8a52T63ybIA5KnuYYFFWbcFpqfwYKHrT9qkKUT83Ako
 N72NvJLnHp0U9Ll1omWlYjzqUZs2423do8BNVa3e8TfGmeJfGHNazvUi7/XdBNOf1Dteboc3CP+
 vjzp3RC4Gdswuht+K7gvqVhW5QoAvB4b2t9VfX5ZTQ4BPmepaSHI7K5WpRTw/HeqqXALs+asXKF
 QhtQ5ZWI/s5NqYlpilgXRQwsPLUedlqGmq2MKHDtqKmi4HvPKn24
X-Received: by 2002:a17:902:ef11:b0:240:10dc:b7c9 with SMTP id
 d9443c01a7336-24096a636a5mr116386345ad.9.1753968259600; 
 Thu, 31 Jul 2025 06:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+qITmLNK5QEe+dil0WZmO/CnFbUaPuQb+j7HdoaCLoJ2D3chYV/VlWQG4wCweoWFihwksOw==
X-Received: by 2002:a17:902:ef11:b0:240:10dc:b7c9 with SMTP id
 d9443c01a7336-24096a636a5mr116385375ad.9.1753968258967; 
 Thu, 31 Jul 2025 06:24:18 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:24:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:55 +0530
Subject: [PATCH v8 15/27] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-15-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=armenon@redhat.com;
 h=from:subject:message-id; bh=qD1YsQfRAmA5wSa2RLuVrWzYc9u7dExn+qNTbwVOw9I=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rPbEwI6bl+VFNivYtux7oBTDOuSK2/5lI4dlI7UP
 ZXwhOlURykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgInk2zD803hldPFSxJlz2Sp/
 i9tmv1Sds2H5zMgZN9YsrDWRrDObd5Phf9yqEK83Ls/1fji7z4mUN4z+M/mrcY3NmwQNoe7tCwX
 /8AEA
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
It is ensured that loadvm_postcopy_ram_handle_discard() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 771c3d2a074d5b6a5ebd3ccf58d564d9b4cefb93..2f9105e4a3b3d1a443d44beed1b2bb2d876439ec 100644
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
@@ -2628,11 +2632,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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
2.50.0


