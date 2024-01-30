Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6E2C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlpg-00063p-VQ; Tue, 30 Jan 2024 05:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpb-000622-1X
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpY-0006rr-EQ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706612342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evX1FYUVlrNnELuzOsiJXXgrBwvq+7rJl/I1dXYE4LI=;
 b=QMQGBG5qHWmftnnxxMLsV53AbsiuNEeSqukNCuIgD8oABPESLecHLIoRigi7lWI1c92nP4
 X+mEb4M7D+dzqJ1jAjN3CS4Unr8h/0lqVBIeTDHFXsPiKIHLxYMJFVtY2cjzk4udxDHf/z
 nR1NpJ/2lkMDA3atc/Y1yEy86CKCQ+o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-JLQ8qEv0OPC5enENyNHbFg-1; Tue,
 30 Jan 2024 05:59:00 -0500
X-MC-Unique: JLQ8qEv0OPC5enENyNHbFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC6152837804;
 Tue, 30 Jan 2024 10:58:59 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B09494;
 Tue, 30 Jan 2024 10:58:58 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/4] guest-agent: improve help for --allow-rpcs and --block-rpcs
Date: Tue, 30 Jan 2024 12:58:53 +0200
Message-ID: <20240130105856.27178-2-kkostiuk@redhat.com>
In-Reply-To: <20240130105856.27178-1-kkostiuk@redhat.com>
References: <20240130105856.27178-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Angel M. Villegas" <anvilleg@cisco.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1757

Updates to qga help output and documentation for --allow-rpcs and --blocks-rpcs

Signed-off-by: "Angel M. Villegas" <anvilleg@cisco.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 docs/interop/qemu-ga.rst | 8 ++++----
 qga/main.c               | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 461c5a35ee..72fb75a6f5 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -81,13 +81,13 @@ Options
 
 .. option:: -b, --block-rpcs=LIST
 
-  Comma-separated list of RPCs to disable (no spaces, use ``help`` to
-  list available RPCs).
+  Comma-separated list of RPCs to disable (no spaces, use ``--block-rpcs=help``
+  to list available RPCs).
 
 .. option:: -a, --allow-rpcs=LIST
 
-  Comma-separated list of RPCs to enable (no spaces, use ``help`` to
-  list available RPCs).
+  Comma-separated list of RPCs to enable (no spaces, use ``--allow-rpcs=help``
+  to list available RPCs).
 
 .. option:: -D, --dump-conf
 
diff --git a/qga/main.c b/qga/main.c
index 8668b9f3d3..bdf5344584 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -261,9 +261,9 @@ QEMU_COPYRIGHT "\n"
 "  -s, --service     service commands: install, uninstall, vss-install, vss-uninstall\n"
 #endif
 "  -b, --block-rpcs  comma-separated list of RPCs to disable (no spaces,\n"
-"                    use \"help\" to list available RPCs)\n"
+"                    use \"--block-rpcs=help\" to list available RPCs)\n"
 "  -a, --allow-rpcs  comma-separated list of RPCs to enable (no spaces,\n"
-"                    use \"help\" to list available RPCs)\n"
+"                    use \"--allow-rpcs=help\" to list available RPCs)\n"
 "  -D, --dump-conf   dump a qemu-ga config file based on current config\n"
 "                    options / command-line parameters to stdout\n"
 "  -r, --retry-path  attempt re-opening path if it's unavailable or closed\n"
-- 
2.42.0


