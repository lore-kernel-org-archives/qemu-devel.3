Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A079DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXWP-00052n-2T; Wed, 24 Apr 2024 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWL-0004sU-UC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWK-00033s-5y
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5k/XgyV6OBmCESICUalI1ibyWn0WpELMf2zPFLN3Uo=;
 b=bddnJ3IJAFI0iRULiy10eUT2hRCCm9AV5e5SAK+oJZrA0I3IKyRau4EChBSD9zYHIOKDPi
 gzABLlyNDQCLEE30r+Z7w+cP4QWYlGaQkOM4zBBW/L8fmO5NmxOw5gZpdFbwPM2WwJ+amb
 s4CmmiNqn42FEc/axtvcbtO+lM3usTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-lL4zu9BvOd21pfT6CCNyww-1; Wed, 24 Apr 2024 03:58:20 -0400
X-MC-Unique: lL4zu9BvOd21pfT6CCNyww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA0F118065AE;
 Wed, 24 Apr 2024 07:58:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 695A83543A;
 Wed, 24 Apr 2024 07:58:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 16/17] tests/unit: Remove debug statements in
 test-nested-aio-poll.c
Date: Wed, 24 Apr 2024 09:57:34 +0200
Message-ID: <20240424075735.248041-17-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We have been running this test for almost a year; it
is safe to remove its debug statements, which clutter
CI jobs output:

  ▶  88/100 /nested-aio-poll                      OK
  io_read 0x16bb26158
  io_poll_true 0x16bb26158
  > io_poll_ready
  io_read 0x16bb26164
  < io_poll_ready
  io_poll_true 0x16bb26158
  io_poll_false 0x16bb26164
  > io_poll_ready
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_read 0x16bb26164
  < io_poll_ready
  88/100 qemu:unit / test-nested-aio-poll        OK

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240422112246.83812-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-nested-aio-poll.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index db33742af3..d8fd92c43b 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -30,19 +30,16 @@ typedef struct {
 
 static void io_read(EventNotifier *notifier)
 {
-    fprintf(stderr, "%s %p\n", __func__, notifier);
     event_notifier_test_and_clear(notifier);
 }
 
 static bool io_poll_true(void *opaque)
 {
-    fprintf(stderr, "%s %p\n", __func__, opaque);
     return true;
 }
 
 static bool io_poll_false(void *opaque)
 {
-    fprintf(stderr, "%s %p\n", __func__, opaque);
     return false;
 }
 
@@ -50,8 +47,6 @@ static void io_poll_ready(EventNotifier *notifier)
 {
     TestData *td = container_of(notifier, TestData, poll_notifier);
 
-    fprintf(stderr, "> %s\n", __func__);
-
     g_assert(!td->nested);
     td->nested = true;
 
@@ -62,8 +57,6 @@ static void io_poll_ready(EventNotifier *notifier)
     g_assert(aio_poll(td->ctx, true));
 
     td->nested = false;
-
-    fprintf(stderr, "< %s\n", __func__);
 }
 
 /* dummy_notifier never triggers */
-- 
2.44.0


