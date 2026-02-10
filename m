Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A9BEA8122
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohb-00058m-T4; Tue, 10 Feb 2026 09:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohQ-00055H-Rv
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohN-0005ie-Tm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733600; x=1771338400; i=lukasstraub2@web.de;
 bh=CnwVz8XWBmqHpe67zT//2crJ7bk/SW6My44mPIi5+mw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sLtMRErufd/0QR84D59DlaSH+/Yizzr3+1S908iO++sBjRDsy/J12lRsDZijaPdq
 tsrTtXXmYMqca7cjOf4AsQEM+OfB2kj7EzgJJz3AYrKONd1ffjuVbcEu+kij+f9TK
 HToMNxFaT8NP5tYkKkbHJ7R/XxiPgwOa/9aLe+ga5q2HMCuww/EJVYW2Wh5v7VYxh
 k18/MUwsQcH2Zjq3JV61mf/4yoEHNZf96DeUn01P450CLbeKIJbLinNTWAhMkFnI+
 QlXIgIdsKqvVePib/1EUsfu6JU8mgHa+T/HbTvttV3ixw7NM9VJZAynTzIg/H3oLk
 eqQyOtC3sYnLRsnCjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1wFuHx0olt-00LKe7; Tue, 10
 Feb 2026 15:26:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:17 +0100
Subject: [PATCH v7 05/18] colo: Remove ENABLE_COLO loadvm command functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-5-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3390; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=SGXPHYdQMG52/VIHBHNTHrlp7HQYjrDtfkgWimh5FOg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Ab9HqoyJRAPtrBCaR2gq20gRJ5S8tY9rrBT
 rZBT3x1XEKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAGwAKCRA1qwsonF2y
 WKXWD/oDE038bXU1gWXH1dTJxBipNshyEQmKt1O9N62d6rwIsMxBkulHP6XI8CVL6glP/26TzA8
 IWX8E2a8C2+5+a0G9K/DKHdQsLbB1J7iD3dedU8h2+IUW1rvhetV5f5RuRptm9N8A7DS4rweH03
 kzDxcEuF6esxzeBbfF4x+4YSL0hY76IOUgO4B5frqyL5mMq2Ha2L5+DJJUR0F3p4N+bS870tykU
 sKmgOAn+Jm554AIN9zue7ugCTGgEzA/iTTi3IgUf6sBiHkO9ZHF72/pAv2coeYusZb4pDM9Gf/X
 +WPkh2t2EcC2lHj7BUXae1V3AJpwzCrjvXb2CwIw6+bwcddvJUAJzVbPDFmVthHPaNY57t5ms+M
 k88jNAkVzItO4Av95YAcef5gYi8aX9/7YxVXHce33v01ntNur+qj29eCXLepnoIDkD25A9Wye6T
 qGKFl/wxuxkg2slji0peO7PkbhNVG8yFShaxjY7aJ2MlWRux5LwEIb3aQYwn50FaFGHJUAmsn2a
 N6dQaE9vvh45JqqlKpD+JXv1vTm2XDvcM4mpWbA+IGPj/nNqKwXl9bUp6aEICaP0oXasnHoDw88
 vq6cXMc64fs8MQo92a4iV/bI65miuFOPgnYJVPunzgrzylZ0mS6+BehTAq5AK4iXYIrRmLL/Hsq
 cDu7BTtnidjLiLA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:K0ubuD9ke+lWeBvN8JKHDaocDxRiJzqHUQLXEnGYsa+z+JFyxZr
 h+W1TDGR0804hMM7DVmtFqdHb+KoDczWg0a1NEu4bEir95/DLla1NdUyGt1bLln5JmOiM8r
 gf1GyuHPVz/L+COmUWSvlAVBTwTXw6QjUlGjZcCXfZjK4au7J0Cme9Pm6UBr515U/3o8FEk
 nHe7XwpMtc2DDpg6gyV+w==
UI-OutboundReport: notjunk:1;M01:P0:iQGCoyyL6SY=;QEpci89u/if4qVRnzCChNbwRVih
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No need for it anymore now that x-colo capability is required
on incoming side.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h |  2 --
 migration/migration.c    | 26 --------------------------
 migration/savevm.c       | 10 ----------
 3 files changed, 38 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2496a968cc1ce709f706c0efe57e4f765f163d3c..8f94054a10760d0f2598f08064=
3f45f9944cf051 100644
=2D-- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,8 +25,6 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
=20
 /* loadvm */
-int migration_incoming_enable_colo(Error **errp);
-void migration_incoming_disable_colo(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/migration.c b/migration/migration.c
index bc8ce64ff5000b0eb634a20b22e5f3e3289b9707..3f3fc5276bb067ae1960e4b675=
b33208ad641b23 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -604,31 +604,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState =
*mis,
     return migrate_send_rp_message_req_pages(mis, rb, start);
 }
=20
-static bool migration_colo_enabled;
-void migration_incoming_disable_colo(void)
-{
-    ram_block_discard_disable(false);
-    migration_colo_enabled =3D false;
-}
-
-int migration_incoming_enable_colo(Error **errp)
-{
-#ifndef CONFIG_REPLICATION
-    error_setg(errp, "ENABLE_COLO command come in migration stream, but t=
he "
-               "replication module is not built in");
-    return -ENOTSUP;
-#endif
-
-    if (!migrate_colo()) {
-        error_setg(errp, "ENABLE_COLO command come in migration stream"
-                   ", but x-colo capability is not set");
-        return -EINVAL;
-    }
-
-    migration_colo_enabled =3D true;
-    return 0;
-}
-
 void migrate_add_address(SocketAddress *address)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
@@ -735,7 +710,6 @@ static void process_incoming_migration_bh(void *opaque=
)
             runstate_set(RUN_STATE_PAUSED);
         }
     } else if (migrate_colo()) {
-        migration_incoming_disable_colo();
         vm_start();
     } else {
         runstate_set(global_state_get_runstate());
diff --git a/migration/savevm.c b/migration/savevm.c
index 0353ac2d0de819b6547a1f771e6a4c3b8fb1e4ef..413688b75f4bee6cb10878eb51=
886cf6ba14872d 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2403,13 +2403,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncom=
ingState *mis,
     return 0;
 }
=20
-static int loadvm_process_enable_colo(MigrationIncomingState *mis,
-                                      Error **errp)
-{
-    ERRP_GUARD();
-    return migration_incoming_enable_colo(errp);
-}
-
 static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
@@ -2528,9 +2521,6 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len, errp);
=20
-    case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis, errp);
-
     case MIG_CMD_SWITCHOVER_START:
         return loadvm_postcopy_handle_switchover_start(errp);
     }

=2D-=20
2.39.5


