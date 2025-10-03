Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40847CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huK-0004yj-4j; Fri, 03 Oct 2025 11:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htc-0004mY-Lt
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htJ-0007ch-8N
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zahpM/D5PA9JjmHfIIK5IsZUz+KQI+y0ImP/lppglU=;
 b=NChCE8BCFD6eQVGqEn0tAU9Qi3867S/AeD2sasuOoyJ9E3LLVBIzylYqjIaiYdfs8TiIAc
 X63qaLMCvgVfvwS6E9bIRWSJVmj2mTA0Hi28vhGYGItFc8xWzbSGbOlUvhqi9gBWIr+D+w
 m9M2OlPcWg22pKc+2/ZcY2OV/O/3BKs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-QvPX6rZ6O_CqbzlGjSElvQ-1; Fri, 03 Oct 2025 11:40:11 -0400
X-MC-Unique: QvPX6rZ6O_CqbzlGjSElvQ-1
X-Mimecast-MFC-AGG-ID: QvPX6rZ6O_CqbzlGjSElvQ_1759506011
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7a758650abdso78549286d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506011; x=1760110811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zahpM/D5PA9JjmHfIIK5IsZUz+KQI+y0ImP/lppglU=;
 b=lfCEJuSsvQVT4uZkQoKQf39i0h8M/eeg/TjuLnmrCUtoA+VSG+9kx0T9Mi5/lh0+Cv
 cxmRaHJv5bwLqYleyf8sOtYbUxOV096YIBubzDgLHIYdTWBzywC7G+sVN7g2mMieMRBb
 qdOFzfVC4afcSzLpU/GabDlb6Rvz6sRt6ibvZFUN3DTbUv2w7QMPmsR2cIs/e4F1Ez5/
 MJn+TQQjYcJqoHfbyVhzwz2U5nPWzQGUw9cHOUO4V+DIz3NemCu37WB87XhV0HiRwdRG
 fflhoKKEIIj4d6VZN8GFtoaEg9ouSc9RUdmjxeLb7spRGRg06gX84qE5zdoRw224EFdV
 VTsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKOM4wDfmt0FhQw+j/VTkdWRsaH2aMqYMVZADVIHJ1T7G2xZ0VG3nZEPQk6hrOUAAGMJB4NbJ2i6nc@nongnu.org
X-Gm-Message-State: AOJu0Yzz7QQFCb2o5yXnyskEywIN3orr1rNCci2t+Nqgu2m4jXJgqTj2
 uZ9AoCECVqOcj4OKnMuVu/m0dNaoZjtT/M3UXE8ChXR453HS2E+HXRiC2mq8nerYG1ycJYDrrX/
 gu9Ro0MN+FZtSBa3oVhXOtUDp4uvZknDGhxpAkSO3skITUPrTyw/9AvVj
X-Gm-Gg: ASbGncvbmk61d4LGImzcNTMHGtdM1mj2iPSq34ZAXRDpGJIfu4g98vINx3oFSLb9Js1
 fggwUnpP3+2xhBe2UXJmUsoNdXEhJwhyYOJtzE1NLTuhfD4n/D72MTj8eX0iKRKNkZEGwPLYwcA
 q5sDlfss4Dz/qoecLOhZnU7YzPXx/R8XeFgEuaoEWz1Ixp3QlfiK1JJUhj0EaMpVxxrXaB0fxvw
 Z3QoQSOClO9b4ZvJSI6cCeRUySfgut1yOadEYkwEK1UoKOiJ4vjNIlr3QbLxiucG2sC5IAuTyR4
 OHnb1g3asNOjqnMzg3dD9WjJqhg0QveYfFz2Hw==
X-Received: by 2002:a05:6214:1d23:b0:7f7:708e:4797 with SMTP id
 6a1803df08f44-879dc776e94mr48110966d6.12.1759506010735; 
 Fri, 03 Oct 2025 08:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2IHRzbCpsqcnKL7HtvDPTCFZE4yMQxNQ5eLzATG9kS4xXADq+WUf/NI0pesOPFyaoPkqyow==
X-Received: by 2002:a05:6214:1d23:b0:7f7:708e:4797 with SMTP id
 6a1803df08f44-879dc776e94mr48110476d6.12.1759506010162; 
 Fri, 03 Oct 2025 08:40:10 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 12/45] migration: Update qemu_file_get_return_path() docs and
 remove dead checks
Date: Fri,  3 Oct 2025 11:39:15 -0400
Message-ID: <20251003153948.1304776-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Arun Menon <armenon@redhat.com>

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-12-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ad50a3abc9..db783f6fa7 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -847,10 +847,6 @@ static void *colo_process_incoming_thread(void *opaque)
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
-    if (!mis->to_src_file) {
-        error_report("COLO incoming thread: Open QEMUFile to_src_file failed");
-        goto out;
-    }
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
diff --git a/migration/migration.c b/migration/migration.c
index cba2a39355..ce17dcc1c0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2656,12 +2656,9 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static void open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
-    if (!ms->rp_state.from_dst_file) {
-        return -1;
-    }
 
     trace_open_return_path_on_source();
 
@@ -2670,8 +2667,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4022,10 +4017,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s)) {
-            error_setg(&local_err, "Unable to open return-path for postcopy");
-            goto fail;
-        }
+        open_return_path_on_source(s);
     }
 
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0f4280df21..0ee0f48a3e 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 
 /*
  * Result: QEMUFile* for a 'return path' for comms in the opposite direction
- *         NULL if not available
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index c1ae36b50a..eb2a905f32 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2588,10 +2588,6 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to
-- 
2.50.1


