Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E544FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEIY-0000Hb-WE; Tue, 05 May 2026 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIX-0000Gx-Bi
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIV-0001Vn-Jw
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LSBZrLVmPzfRrT5Uwma+TZ+F1UwlvVpEGqNHUhYwck=;
 b=SkHnFV51AO2dvnRlWq6Hn9tkHyasNeetblAveratSNuBhfErBzrwLiybEIb/Y1WVE3p6mn
 e11uy+Wzpp4RBXJ8dVqhSMcJOyq6I11ACyi2KN87DZVZ8iNeXX10sBKIv7AI0uJrLix8Xf
 +4+uWGCAwL7S55MSBXX2dPHX/haERRk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Zl7bSJ7DMRed-cdA0ueV7g-1; Tue,
 05 May 2026 07:50:40 -0400
X-MC-Unique: Zl7bSJ7DMRed-cdA0ueV7g-1
X-Mimecast-MFC-AGG-ID: Zl7bSJ7DMRed-cdA0ueV7g_1777981839
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F54F1956095
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E83D196B09E
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB38821E6A05; Tue, 05 May 2026 13:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/5] error: Restore error_printf()'s function comment
Date: Tue,  5 May 2026 13:50:34 +0200
Message-ID: <20260505115036.1170186-4-armbru@redhat.com>
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
References: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Lost in commit 397d30e9401 (qemu-error: remove dependency of stubs on
monitor) many moons ago.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260114124713.3308719-3-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[Trivial conflict with commit a582a5784e5f (monitor: move
error_vprintf back to error-report.c) resolved]
---
 util/error-report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/error-report.c b/util/error-report.c
index 92b04915ce..f832ad9b6b 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -70,6 +70,9 @@ int error_vprintf(const char *fmt, va_list ap)
     return error_vprintf_mon(monitor_cur(), fmt, ap);
 }
 
+/*
+ * Print to the current HMP monitor if we have one, else to stderr.
+ */
 int error_printf(const char *fmt, ...)
 {
     va_list ap;
-- 
2.54.0


