Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42BACD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbYk-00031m-7F; Tue, 19 Mar 2024 11:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmbYi-00031Y-OB
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmbYh-00042w-Ce
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710862755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C14dZd56YxXu7YRsqu6W/W3IkVqFoIgSmoO0MpClqdM=;
 b=AVXN6HKZtxgzXcm719kbTJe6Mh6kkHevBCe9rjuXoaFWm7KiXhACPJioKa1KVLkVjmRO+/
 stMZD6BREgi1JquA9Pj71TafxWDGmqHzDnhkJmX0PLfTd3vnituCFAoe2uRDkJyh91MU4K
 rA8TkjdX7L/otiOLzdtAtDcQDIQ41Xs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-0KKyUTU-OmiwgGgC1BhrFQ-1; Tue, 19 Mar 2024 11:39:14 -0400
X-MC-Unique: 0KKyUTU-OmiwgGgC1BhrFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C771A185A786
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 15:39:13 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F17A200B3BD;
 Tue, 19 Mar 2024 15:39:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH for-9.0] qapi: drop unused
 QCryptoBlockCreateOptionsLUKS.detached-header
Date: Tue, 19 Mar 2024 15:39:08 +0000
Message-ID: <20240319153908.194975-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
was left over from earlier patch iterations.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/crypto.json | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 931c88e688..ad9e3d0297 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -226,8 +226,6 @@
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
 #     processing.  Currently defaults to 2000. (since 2.8)
 #
-# @detached-header: create a detached LUKS header. (since 9.0)
-#
 # Since: 2.6
 ##
 { 'struct': 'QCryptoBlockCreateOptionsLUKS',
@@ -237,8 +235,7 @@
             '*ivgen-alg': 'QCryptoIVGenAlgorithm',
             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
             '*hash-alg': 'QCryptoHashAlgorithm',
-            '*iter-time': 'int',
-            '*detached-header': 'bool'}}
+            '*iter-time': 'int' }}
 
 ##
 # @QCryptoBlockOpenOptions:
-- 
2.43.0


