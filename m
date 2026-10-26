Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE92606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d5gqyKcj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLIdI-0004uO-3i; Mon, 26 Oct 2026 07:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLIdD-0004ts-4h
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLIdB-00081m-Qk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793013165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Z6SWQMvOYKJ5kV1wp6+6d18VGMWfUXZM+KPWyBHhog=;
 b=d5gqyKcjPWonfYD7cp52xVEvUyWSpW986D+dUM7IVzo2NV8jOAi0Gzx/u09CKH7kFsMzQN
 Wg69FX/Z9WBjtmACS8XzPUVck7sQKRRwuVfJkTvRIhR6rn64YqpN+JyRvrVF/6BVUDAerZ
 1JGFDwlHenF+lmzZFXWQYjQJBMWU3yA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-XrVT0k17PqK_u2wHjVEq5w-1; Mon,
 26 Oct 2026 07:12:43 -0400
X-MC-Unique: XrVT0k17PqK_u2wHjVEq5w-1
X-Mimecast-MFC-AGG-ID: XrVT0k17PqK_u2wHjVEq5w_1793013162
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D186419560B7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:12:42 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B977C30000E3; Mon, 26 Oct 2026 11:12:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/2] crypto: add newline in error hint messages
Date: Mon, 26 Oct 2026 11:12:37 +0000
Message-ID: <20261026111237.660633-3-berrange@redhat.com>
In-Reply-To: <20261026111237.660633-1-berrange@redhat.com>
References: <20261026111237.660633-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The error_append_hint() API contract requires messages to end with
a newline character.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/block-luks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 277a5110607..f7217ad7b77 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1674,7 +1674,7 @@ qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
 
     if (qcrypto_block_luks_find_key(block, old_password, master_key,
                                     readfunc, opaque, errp) < 0) {
-        error_append_hint(errp, "Failed to retrieve the master key");
+        error_append_hint(errp, "Failed to retrieve the master key\n");
         return -1;
     }
 
@@ -1687,7 +1687,7 @@ qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
     /* Now set the new keyslots */
     if (qcrypto_block_luks_store_key(block, keyslot, new_password, master_key,
                                      iter_time, writefunc, opaque, errp)) {
-        error_append_hint(errp, "Failed to write to keyslot %i", keyslot);
+        error_append_hint(errp, "Failed to write to keyslot %i\n", keyslot);
         return -1;
     }
     return 0;
@@ -1785,7 +1785,7 @@ qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
 
         if (qcrypto_block_luks_erase_key(block, keyslot,
                                          writefunc, opaque, errp)) {
-            error_append_hint(errp, "Failed to erase keyslot %i", keyslot);
+            error_append_hint(errp, "Failed to erase keyslot %i\n", keyslot);
             return -1;
         }
 
@@ -1838,7 +1838,7 @@ qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
             }
             if (qcrypto_block_luks_erase_key(block, i, writefunc,
                 opaque, errp)) {
-                error_append_hint(errp, "Failed to erase keyslot %zu", i);
+                error_append_hint(errp, "Failed to erase keyslot %zu\n", i);
                 return -1;
             }
         }
-- 
2.56.0


