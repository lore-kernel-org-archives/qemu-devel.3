Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A705C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRk-00061L-FV; Mon, 23 Jun 2025 16:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRi-0005zm-7X
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRg-0003WE-CY
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0hAo7uObo/yCTF5mbeDUJEe0VzTLQTBlXgVDJht0Fk=;
 b=B6Zyxuz8bgqRpxxbx2R0BhtvC9eQEV2B6BUAjfoBP+zDZIrAc1K+Qr7zdeyDGihYOpxOuW
 7HWKMW8hVqsiU0nyVnL6TvGbPofN7HlZ0IejS6ZCYgnUzgUt/Uq4bZak/PiKrjV1NwDLjv
 SbKpEwt+8t/SIgN0KFVezgUf5uwOnYc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-YydpmtMEOmiDWv412om_mg-1; Mon, 23 Jun 2025 16:07:09 -0400
X-MC-Unique: YydpmtMEOmiDWv412om_mg-1
X-Mimecast-MFC-AGG-ID: YydpmtMEOmiDWv412om_mg_1750709228
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fb3466271fso73772056d6.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709228; x=1751314028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0hAo7uObo/yCTF5mbeDUJEe0VzTLQTBlXgVDJht0Fk=;
 b=gZuEGQ8L8NwqT2DCwgfrZE5HqU2elSkhhchc0d7QMgRoz25a+j4TquPCWYeFhaW46i
 xu4g2PX0JJDD83I4/D4sYfOuIKJGzRe94F7apD3R9/Q3Fm5PEeZ8VOQR1BLH4H4K2aUY
 mpWLm+QOjjpy3iTD+ZONOcw04g3knn5RF3fs8KJSP7Gj5w9iYVDEpXCp10jG2uDb0wol
 38Jtbt35ms1w2Dxyk21WGhw8rGKUWZuG764P2EeoKZbRvnRvQnmJzPmupqXTRQeTtt9d
 FaqhZuGrE2W//Ifr9z0ZebZ/3l28Jo1/BVVOV8uWpwu5dzrfSxjmCa9lS0Qbz+ydBvDz
 BhXA==
X-Gm-Message-State: AOJu0Ywc7yvrimUzd1EfdmB7ZC9xGdjla62sSxywTdsrsrLFp+A5qmvo
 4oKH7lDbj9luiRMw+E88f9lMD7e+cGhdnBQe4vF7coLQnrc2FFZZ71WikEN3g0vCgbIwWGMzAKU
 bHTRwqGwA5Zd0yyQh4uMf0dEcMpXlx5WApUlM9aN6fH9XQCZjsORXhKBmeGIwcE4R0Bet5GrSWJ
 qyK43myc9hHoF4eAQ6P626RfXosAb3O5pcKLY1Ig==
X-Gm-Gg: ASbGncvyHF3HoTK48yjXPYxDUNdGKS5ofR/GpPKkw2x5YuIGODt96hD1JaArdGxYxKr
 NigsDfRDl5YFhi+eZVfksvkwo1G2ZbfgBApzyW1paNb8plE/ZTsUSj2zOoSVDAmNTAjdjO3BpsZ
 TFlck3m5XzAN2SzFNYTfbPyNDAK9Rwu+ZiKm35+gxg9hJzxyAotS1V8+P2deBYY+qhJBfUU6SqK
 oClVHymuEvwGsKhCO6wiI8ignkeHF/3ZX+Hb+eb+N5Zzjypa7xwNORbmSGEIrLCBTsa3+jO45PK
 zczn/dJFglk=
X-Received: by 2002:a05:6214:2685:b0:6fa:fc4b:8ea7 with SMTP id
 6a1803df08f44-6fd3889809emr12340226d6.21.1750709227592; 
 Mon, 23 Jun 2025 13:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8WGyXrgpUhkjz4fkFrFvMntq1BPtDJ/A5tMfg0LDz4blDM8G6kgLS4da+VP3COftIKWfueg==
X-Received: by 2002:a05:6214:2685:b0:6fa:fc4b:8ea7 with SMTP id
 6a1803df08f44-6fd3889809emr12339696d6.21.1750709227044; 
 Mon, 23 Jun 2025 13:07:07 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jaehoon Kim <jhkim@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 05/11] tests/migration: Setup pre-listened cpr.sock to remove
 race-condition.
Date: Mon, 23 Jun 2025 16:06:50 -0400
Message-ID: <20250623200656.1882674-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

When the source VM attempts to connect to the destination VM's Unix
domain socket (cpr.sock) during a cpr-transfer test, race conditions can
occur if the socket file isn't ready. This can lead to connection
failures when running tests.

This patch creates and listens on the socket in advance, and passes the
pre-listened FD directly. This avoids timing issues and improves the
reliability of CPR tests.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/20250611205610.147008-2-jhkim@linux.ibm.com
[peterx: null-initialize opts_target, per Steve]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/cpr-tests.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5536e14610..5e764a6787 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -60,13 +60,12 @@ static void test_mode_transfer_common(bool incoming_defer)
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
+    g_autofree char *opts_target = NULL;
 
     const char *opts = "-machine aux-ram-share=on -nodefaults";
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
-    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
-                                                   cpr_channel, opts);
 
     g_autofree char *connect_channels = g_strdup_printf(
         "[ { 'channel-type': 'main',"
@@ -75,6 +74,17 @@ static void test_mode_transfer_common(bool incoming_defer)
         "              'path': '%s' } } ]",
         mig_path);
 
+    /*
+     * Set up a UNIX domain socket for the CPR channel before
+     * launching the destination VM, to avoid timing issues
+     * during connection setup.
+     */
+    int cpr_sockfd = qtest_socket_server(cpr_path);
+    g_assert(cpr_sockfd >= 0);
+
+    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
+                                  "addr.type=fd,addr.str=%d %s",
+                                  cpr_sockfd, opts);
     MigrateCommon args = {
         .start.opts_source = opts,
         .start.opts_target = opts_target,
-- 
2.49.0


