Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABDCC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSy-0007v6-5Q; Fri, 02 May 2025 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSf-0007nV-V5
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSd-0006U0-5I
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5iX6m9+qrQrDzgZbzFt+Gv7DkVpFoyTApZijRzVBoA=;
 b=JFuw674F4HfbTKA1YajnVf+uSGhfA2zL/jX0FvoDJSbw4oRH/V6LaO5Fr4INAr7hZdTdqE
 OEt2ReL5k3W/3tIsds0JbWZRdBUjdmRDCoInkA3gvdQXHbk2tcD3CpsUtOIHZ/BMT0/FGb
 7dI9wPxLURcvTGmyjiqtUzqFd/rNC1g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-SN1wn0LuNXioNoJxHk6uWQ-1; Fri, 02 May 2025 12:42:01 -0400
X-MC-Unique: SN1wn0LuNXioNoJxHk6uWQ-1
X-Mimecast-MFC-AGG-ID: SN1wn0LuNXioNoJxHk6uWQ_1746204120
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5c77aff55so492507185a.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204120; x=1746808920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5iX6m9+qrQrDzgZbzFt+Gv7DkVpFoyTApZijRzVBoA=;
 b=NzqkBMhGFOifqKViG2nk8kRMjmlNCinUjxKs2Oml41pKxgzrvgBVX37uSVbR8GRgMA
 IojEvVHqZX5hgs/Nmr0JgMZlmqfiL83+x7BgKwBrCH+uQ+wsHeR51CqG1EsK/mXenBds
 n4dXuAL12QB0z53m4v/XqOQqOlKhSMNBmFnifM98yhV+dzexuvTK29LncTByFid67cDL
 4spCoNB3UCdh6bkrVBGqy6/tLxfze+l8U5kdLxn8B2RT8Wdxx7vI5EVsOo8GeP8vfd60
 9JvW5KsM8ooBpR+yFUYZNO6XbVfAtExR8PcBlDw/zk+L60XzC661FArcM7FcgdlQvtMk
 SAZw==
X-Gm-Message-State: AOJu0Yxokf0SmtjzncEK3RT8D/fNHSAFltXyX8jwcgSjKGzit0ZAuBgi
 4yDSCSuxPU423xx2Gz+25ygQSwrPCizZLKOhCz9usJKzU+CBKF4rZekJlr+MkxRK0w92y2xXyoH
 hCYFH+prkU0A+QO9M4EygKl928zJUVoihcX3TBXT2PlF2SxOOPi84ONSvFSqJS9fNC/8TtMy5xY
 yFqHzDKqoNcVbEsoG6GJV0lUF6DeqFnjW7Hg==
X-Gm-Gg: ASbGnctKOJWQ24GkQjUwEyoPZUODejXOdrOSkaNOlfzxtzh+Ho43Ie7xRZnLKpUaiGv
 LngeyHRvF5J2zpewLtWpPh4JVikfxy7wkSyA3dcu+mIgVgp10T2iCWjwOOu5d0pHqyASKSmif5e
 jM4CvfallM+Tt4jJQoyjMxUToCok6sGSt9XOm2AH6O5jaRQ8R7MLVy1CPENKilFnvlJchvKK1HW
 g5NFd0BRxMDpixVuep9vlmy7qm+ohWTKFypOD2kEiOU/pTZZPH8ikHU5yjdoVyj5J8P2J3wHljk
X-Received: by 2002:a05:620a:4442:b0:7c5:9a4e:7b8a with SMTP id
 af79cd13be357-7cad5ba5b8emr628657285a.54.1746204119924; 
 Fri, 02 May 2025 09:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE1lvHcDGV72kGzDKze0OlkIDIUP483PHYina4WYWOwFFIJsgZFF/F53YSuHwwwpe22G2qrQ==
X-Received: by 2002:a05:620a:4442:b0:7c5:9a4e:7b8a with SMTP id
 af79cd13be357-7cad5ba5b8emr628651785a.54.1746204119443; 
 Fri, 02 May 2025 09:41:59 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 10/14] migration/ram: Implement save_postcopy_prepare()
Date: Fri,  2 May 2025 12:41:37 -0400
Message-ID: <20250502164141.747202-11-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

Implement save_postcopy_prepare(), preparing for the enablement
of both multifd and postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250411114534.3370816-5-ppandit@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 1181a99cf6..a749e4a421 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4398,6 +4398,42 @@ static int ram_resume_prepare(MigrationState *s, void *opaque)
     return 0;
 }
 
+static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
+{
+    int ret;
+
+    if (migrate_multifd()) {
+        /*
+         * When multifd is enabled, source QEMU needs to make sure all the
+         * pages queued before postcopy starts have been flushed.
+         *
+         * The load of these pages must happen before switching to postcopy.
+         * It's because loading of guest pages (so far) in multifd recv
+         * threads is still non-atomic, so the load cannot happen with vCPUs
+         * running on the destination side.
+         *
+         * This flush and sync will guarantee that those pages are loaded
+         * _before_ postcopy starts on the destination. The rationale is,
+         * this happens before VM stops (and before source QEMU sends all
+         * the rest of the postcopy messages).  So when the destination QEMU
+         * receives the postcopy messages, it must have received the sync
+         * message on the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH,
+         * or RAM_SAVE_FLAG_EOS), and such message would guarantee that
+         * all previous guest pages queued in the multifd channels are
+         * completely loaded.
+         */
+        ret = multifd_ram_flush_and_sync(f);
+        if (ret < 0) {
+            error_setg(errp, "%s: multifd flush and sync failed", __func__);
+            return false;
+        }
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+    return true;
+}
+
 void postcopy_preempt_shutdown_file(MigrationState *s)
 {
     qemu_put_be64(s->postcopy_qemufile_src, RAM_SAVE_FLAG_EOS);
@@ -4417,6 +4453,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
     .resume_prepare = ram_resume_prepare,
+    .save_postcopy_prepare = ram_save_postcopy_prepare,
 };
 
 static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
-- 
2.48.1


