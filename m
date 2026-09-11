Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A69BC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9R-0002dH-2E; Fri, 11 Sep 2026 05:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x94-0002BP-V5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x92-00086c-VL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dveBwypMxxlS0tHYi3KN/e1QMBIv6aayFrNW2TY0wNY=;
 b=NTXkVvrfI3OCqW0JUBKZ7BZ22ob2W26zch6NlEJP2PtT+nzrL33MSoc8j88DEpQPJylfEn
 9JA6oGwXvDNUgZGgJnDWYGF4NP2ZcFiZA6ObtffB4l9AmyBrva0U83aBFd2mtnOi5uoRv/
 ekAi7TeZ+yNVA3MGycSh8G8eWFYOXNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-R18IH6Q2PcS_E0ZENTP7dg-1; Fri, 11 Sep 2026 05:02:02 -0400
X-MC-Unique: R18IH6Q2PcS_E0ZENTP7dg-1
X-Mimecast-MFC-AGG-ID: R18IH6Q2PcS_E0ZENTP7dg_1789117322
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4843d9ab895so606764f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117321; x=1789722121; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dveBwypMxxlS0tHYi3KN/e1QMBIv6aayFrNW2TY0wNY=;
 b=CFiJEwd8n31UGyZnCVs8dk0xubbzAHD+NiaHnUCpShU8iEJ9IhaA45arK/qouhbJ12
 os8euJ4vH+t99MIkxWVpFNFN+QUptWpWxjRFs9F5DzrIhbosRP5I4zYD0OB69Ssepvcv
 lMquZHxmElfDpHoO2aCUUG8K8C8A9mnguZqTN6SjJe1RXixnVPKZqJaUiYlVUuHPYCjy
 +w/Cf/JP60gjs51PrgJk7aeGx3jCrmq02yifF8iY2NujqS/u99yifj0KML90HF1Ey1ia
 cL+zZGCLGhtFyjDBfRrcB+P66uswI4mOUrMIzNFGGvhhFlXOpeb4gPnL98oLVOPcLdML
 Utew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117321; x=1789722121;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dveBwypMxxlS0tHYi3KN/e1QMBIv6aayFrNW2TY0wNY=;
 b=pCPh98AAP501djLbQdRBi8XcufFRNI1a0oUASwEM/yf2nVvYZ0oSKifAC89WeZlbEU
 7Kt0YcSX/+vxWlCSzjBqAyeUJGqKJWNwXIDLVh966crS6wQlwOAFm99OnyPWNyLEGms+
 +eTVJOGJIFtOG0Ezv6Z9yaUsjGGDWn8KtQM42+J06mh3ikNSiTdDPWGtePXsoNWXsjLR
 rpkuHwsLdKmaU88Ihm680CUTwdVBTCXo+09hnuntGwlt4v5n13bnjXi3QAECjltFLcjY
 AgUQF2lgB/OPFNNu4zfcwOChhEc67qtrQmWRtP8h7IF7C7ffxsoLn9Gb8bXMRB1mO1H9
 5hPQ==
X-Gm-Message-State: AFuF++lTESCefsPraQHDc7CysphK5Orpk8ENDhAm/6V8Uqqbb86Cy8y3
 XXxkjpfMS6Eum4iWDMz0Wh50vKB4jR3bkE6V5Wua+r3frLAOjRFZAteBJiPX6IafKiVenKkILBW
 5JT3NoRTvxiEGg0wG8bNXsLNrNuASD2o4KpAiogFrSGHeI1GDnPNiQLUB+8OnVGwqk7S/2IykZY
 heqiDoJ/8V2cWd8N7Pjdi9O5rl/1WU3JyoGQ==
X-Gm-Gg: AYBFou3ukhgtBw75NaeBDignnmB6z6/kr+SzUvC8uYQNKUED+pB4fwopJyZL4SsFwLj
 hfpOHOxgq1NkGVqchPFXo6A3ju26MRCtEDwVjEa+e0lriKSyIaR4nBLaaUMu37Q+F0JSrXU+WT8
 bNjIJAUccOpGylPC/+FmYFRdsV3hxWfx/e5SVuEPR/PzeTkbCqlgZBgqd3uoO0KZWBSyf335bXs
 cgCpx+Na8uBrANlZGCAr6AriCrt5MFaXJbql2MTmF3VMzfIJDR1O8AbRbpGNbbiLFfsHKsNh3uy
 CFXgYe42jzkrnxeuB/3NHhSC/k4kiIRcwFvJupSbDhOdPJINtr+tNffHq+3CjQw38aLuqMaWqDq
 hMkZSpSlSX9PMkO1uWRwxEPY=
X-Received: by 2002:a5d:534b:0:b0:485:8c16:5ef6 with SMTP id
 ffacd0b85a97d-486eb30ac8dmr2606924f8f.48.1789117321427; 
 Fri, 11 Sep 2026 02:02:01 -0700 (PDT)
X-Received: by 2002:a5d:534b:0:b0:485:8c16:5ef6 with SMTP id
 ffacd0b85a97d-486eb30ac8dmr2606858f8f.48.1789117320719; 
 Fri, 11 Sep 2026 02:02:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb360409sm4180360f8f.36.2026.09.11.02.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:00 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>
Subject: [PULL v2 17/75] qapi: add local migration parameter
Message-ID: <c9affb8e9b786fc1ec01f0f28d008d390f118af6.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We are going to implement local-migration feature: some devices will be
able to transfer open file descriptors through migration stream (which
must UNIX domain socket for that purpose).  This allows to transfer the
whole backend state without reconnecting and restarting the backend
service. For example, virtio-net will migrate its attached TAP netdev,
together with its connected file descriptors.

In this commit we introduce a migration parameter, which enables
the feature for devices that support it (none at the moment).

We can't simply auto-detect local migration by checking whether the
migration channel is a UNIX domain socket: the UNIX socket may be only
the first part of the transfer channel to a remote target.  Hence an
explicit parameter is needed. Moreover, "local" migration parameter
may be useful in cpr-exec mode, when FDs are passed through exec
instead of UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-10-vsementsov@yandex-team.ru>
---
 qapi/migration.json      | 21 +++++++++++++++++----
 include/migration/misc.h |  2 ++
 migration/options.c      | 18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b1eaf7b054..f7628b55e9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -830,7 +830,8 @@
            'zero-page-detection',
            'direct-io',
            { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'local'] }
 
 ##
 # @migrate-set-parameters:
@@ -1012,10 +1013,20 @@
 #     Must be set to the same value on both source and destination
 #     before migration starts.  (Since 11.1)
 #
+# @local: Permit the use of optimizations for local migration.  This
+#     must only be set when either both the source and destination
+#     QEMU processes are directly connected with a UNIX domain socket
+#     as the migration channel (to enable use of file descriptor
+#     passing) or cpr-exec migration mode is enabled (this way file
+#     descriptors are inherited by new process).  Individual device
+#     backends may need additional configuration flags set to enable
+#     local migration optimizations.  This will be documented against
+#     the device backends where it applies.  (Since 11.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
+#     and @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
@@ -1053,7 +1064,9 @@
             '*direct-io': 'bool',
             '*x-rdma-chunk-size': { 'type': 'uint64',
                                     'features': [ 'unstable' ] },
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*local': { 'type': 'bool',
+                        'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 2b2fbb59a4..019717f4cd 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -161,4 +161,6 @@ bool multifd_join_device_state_save_threads(void);
 
 void migration_request_switchover_ack_legacy(const char *requester);
 
+bool migrate_local(void);
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index d2575edb6c..05b026f4bf 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -25,6 +26,7 @@
 #include "migration/colo.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "qemu-file.h"
@@ -350,6 +352,12 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_local(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->parameters.local;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1101,7 +1109,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1449,6 +1457,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         qapi_free_strList(dest->cpr_exec_command);
         dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        dest->local = params->local;
+    }
 }
 
 static void migrate_params_apply(MigrationParameters *params)
@@ -1581,6 +1593,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        s->parameters.local = params->local;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
-- 
MST


