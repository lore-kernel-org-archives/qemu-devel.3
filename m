Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A6DC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlpf-000639-0g; Tue, 30 Jan 2024 05:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpd-00062f-C8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpa-0006ty-Qn
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706612345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3cbLHHTCuf0dgBlQOw30VOMPuN+ojLFcsl1F2/oAvE=;
 b=N1MVNi/lLUckI7HrqtLKIsk7GeWYTigUnzQ+6YjyT9vaX7/Z3Q62hIHZlWokfWP850u8Ko
 0yJjCuUlEGWzsj3N/i1iyZ8eLCfSoCupn/Mj3D/72gU7eatbo935GcPU1aldGQQX2S3jrD
 udUEW19se4D+GeXewrTXkcUTFYSCewM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-KV_IvIvdMcq46NnBFSDqIg-1; Tue, 30 Jan 2024 05:59:01 -0500
X-MC-Unique: KV_IvIvdMcq46NnBFSDqIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2C2E85A58C;
 Tue, 30 Jan 2024 10:59:00 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C158494;
 Tue, 30 Jan 2024 10:58:59 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/4] tests/unit/test-qga: do not qualify executable paths
Date: Tue, 30 Jan 2024 12:58:54 +0200
Message-ID: <20240130105856.27178-3-kkostiuk@redhat.com>
In-Reply-To: <20240130105856.27178-1-kkostiuk@redhat.com>
References: <20240130105856.27178-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Samuel Tardieu <sam@rfc1149.net>

guest-exec invocation does not need the full path of the executable to
execute. Using only the command names ensures correct execution of the
test on systems not adhering to the FHS.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 tests/unit/test-qga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 671e83cb86..8cddf5dc37 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -822,7 +822,7 @@ static void test_qga_guest_exec(gconstpointer fix)
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/echo', 'arg': [ '-n', '\" test_str \"' ],"
+                 " 'path': 'echo', 'arg': [ '-n', '\" test_str \"' ],"
                  " 'capture-output': true } }");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
@@ -883,7 +883,7 @@ static void test_qga_guest_exec_separated(gconstpointer fix)
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/bash',"
+                 " 'path': 'bash',"
                  " 'arg': [ '-c', 'for i in $(seq 4); do if (( $i %% 2 )); then echo stdout; else echo stderr 1>&2; fi; done;' ],"
                  " 'capture-output': 'separated' } }");
     g_assert_nonnull(ret);
@@ -924,7 +924,7 @@ static void test_qga_guest_exec_merged(gconstpointer fix)
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/bash',"
+                 " 'path': 'bash',"
                  " 'arg': [ '-c', 'for i in $(seq 4); do if (( $i %% 2 )); then echo stdout; else echo stderr 1>&2; fi; done;' ],"
                  " 'capture-output': 'merged' } }");
     g_assert_nonnull(ret);
-- 
2.42.0


