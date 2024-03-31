Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC18CD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqzzO-0007XQ-2Y; Sun, 31 Mar 2024 14:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rqzzK-0007WT-Pt
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rqzzI-0007Lq-5A
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711909978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMxZuOXNWNRsfkWmLxWprCnxf7aQfHm6dGry164yY7o=;
 b=c00dDeDzKIi6JSChzI3tuGaVad/6VpjAV7Z3su/FrrSeKzPWw2ZGxmrLa6NXYW22T1qjR9
 n2HEsoSF+oyP1QpipX5yeBlvgfqff8KuqQO0GBhrXGx012lJCEoeeibGcNbdCC1gCz32GO
 eNkmAUGSMOSlgEOt2Awn8YzxvJlP8gA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-BWBZYRmuMvyqozmK5nv1Mw-1; Sun, 31 Mar 2024 14:32:56 -0400
X-MC-Unique: BWBZYRmuMvyqozmK5nv1Mw-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-47858503cacso142681137.1
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 11:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711909976; x=1712514776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMxZuOXNWNRsfkWmLxWprCnxf7aQfHm6dGry164yY7o=;
 b=GZ5k9kfkdfqRE/Jy4caix8rhNYDxjEjhO7vBk+fwO94ZjQpuzyAzpkuk6kpuOZr7tS
 U9Cm8oKu3DWGf3PfjeV1WkQ8SeLYlzqAX6tn2oudwgzB8+eqMnnh8eON/KoXVwJSM9iR
 9ZBH0o7CJMiiqhfM0XmAlzY8tntWW0psoFlYD4/LSjTRxB+PRC5kvwqFT64dElIkrJ7h
 vb2AV67vRxpmcbl47B9zZdDw7+RPFf1xHM1zvMghVHBXoWIJ5ARwv2P+799AefDJxO0o
 xxQ7XD6e5URAq+oX/ZvMXJLLqPTObNzCU1nWBbAoWCi/UUeLftzBMIy+1V6J5oKiFF1S
 H3Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnWIvrNtD26z9dKEXx4Yho8GBss4otmtaWBimJpl/6zr9c9EMH1pVmBl/MwgSqEI6IMwKCmodAe8APrq37Kqt8fwvqQm4=
X-Gm-Message-State: AOJu0YxOqhmaWAbofAbeUiJEG/rrIgYBBBMfpbqeObZ/3vK0A1xk9tas
 fI6btynRDy/DNFOQRJsHm1VZ6bdbs4hbrN/zUXpKWgosWNLa2moEHnguSOIOZwIC2aF7/xqhHTj
 nBJc2fwbg1sJSh99fgk584XA+cIUBvIj970uURrM3Ow+ppYJNaAZp
X-Received: by 2002:a05:6102:5127:b0:478:766d:e83 with SMTP id
 bm39-20020a056102512700b00478766d0e83mr612788vsb.2.1711909976200; 
 Sun, 31 Mar 2024 11:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEttP5CaamZNcni/bRcGIk6uRyaGQjtAYlP7shK4ZjX9m3h4+n3s4qMRzilkifN8Zj88gQgpw==
X-Received: by 2002:a05:6102:5127:b0:478:766d:e83 with SMTP id
 bm39-20020a056102512700b00478766d0e83mr612777vsb.2.1711909975677; 
 Sun, 31 Mar 2024 11:32:55 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u10-20020ad45aaa000000b00696a47179a1sm3748823qvg.14.2024.03.31.11.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 11:32:55 -0700 (PDT)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 2/2] migration/postcopy: Ensure postcopy_start() sets errp if
 it fails
Date: Sun, 31 Mar 2024 14:32:51 -0400
Message-ID: <20240331183251.1045817-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331183251.1045817-1-peterx@redhat.com>
References: <20240331183251.1045817-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

There are several places where postcopy_start() fails without setting
errp. This can cause a null pointer de-reference, as in case of error,
the caller of postcopy_start() copies/prints the error set in errp.

Fix it by setting errp in all of postcopy_start() error paths.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 908927db28ea ("migration: Update error description whenever migration fails")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240328140252.16756-3-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b73ae3a72c..86bf76e925 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2510,6 +2510,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
             migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            error_setg(errp, "%s: Failed to establish preempt channel",
+                       __func__);
             return -1;
         }
     }
@@ -2525,17 +2527,22 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed to stop the VM", __func__);
         goto fail;
     }
 
     ret = migration_maybe_pause(ms, &cur_state,
                                 MIGRATION_STATUS_POSTCOPY_ACTIVE);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
+                         __func__);
         goto fail;
     }
 
     ret = bdrv_inactivate_all();
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed in bdrv_inactivate_all()",
+                         __func__);
         goto fail;
     }
     restart_block = true;
@@ -2612,6 +2619,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
+        error_setg(errp, "%s: Failed to send packaged data", __func__);
         goto fail_closefb;
     }
     qemu_fclose(fb);
-- 
2.44.0


