Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E18C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 11:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ClL-0006Kj-GO; Wed, 15 May 2024 07:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7ClA-0006JU-Nb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 07:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7Cl5-0005Np-Qb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 07:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715772318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5I8jw8ZwQFcVE3TCt7mfhOF34xGJqPPGqmUyT0I+3DA=;
 b=Ma9fDKofPjc0HVJECQv21NrZOwaAqdp6bpd4En/AsYZrSCWhPpkjE7S5RuDHfYQ8mHgapj
 Cobzz6N8TMUIF1VeS9FC+3MEyhlqeMwFbL9usFeoZaRyleYBEuydTs/SzgjiBtYY9XRZ/u
 VBCwPWV0ivH/t3iotm4Fms6cDSLVUcs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-9gwbVcbZPm2Y96eETvfFzg-1; Wed, 15 May 2024 07:25:17 -0400
X-MC-Unique: 9gwbVcbZPm2Y96eETvfFzg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8DF580118E
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 11:25:16 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0318400057;
 Wed, 15 May 2024 11:25:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] vl: fix "type is NULL" in -vga help
Date: Wed, 15 May 2024 15:25:12 +0400
Message-ID: <20240515112512.1100498-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A VGA interface is available if it has no class_names, or we can look up
any of the names - we shouldn't call module_object_class_by_name(NULL),
as happening for ex with TCX or CG3 on x86.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index a3eede5fa5..398f88b0f0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -999,9 +999,16 @@ static bool vga_interface_available(VGAInterfaceType t)
     const VGAInterfaceInfo *ti = &vga_interfaces[t];
 
     assert(t < VGA_TYPE_MAX);
-    return !ti->class_names[0] ||
-           module_object_class_by_name(ti->class_names[0]) ||
-           module_object_class_by_name(ti->class_names[1]);
+
+    if (!ti->class_names[0] || module_object_class_by_name(ti->class_names[0])) {
+        return true;
+    }
+
+    if (ti->class_names[1] && module_object_class_by_name(ti->class_names[1])) {
+        return true;
+    }
+
+    return false;
 }
 
 static const char *
-- 
2.41.0.28.gd7d8841f67


