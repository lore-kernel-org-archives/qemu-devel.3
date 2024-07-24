Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9591FC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYcV-0008VR-Dh; Wed, 24 Jul 2024 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYcS-0008Ii-Bd
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYcQ-0003ZW-TQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIccZmhKXBc7BuOsi31SdYQ75lt4SoV1XHnlyAIxiMM=;
 b=KcXDOykodA45p6BnScKQ4Hnf3fsCRCUeDNy3l7/t2kAsFkSHV59Xp7P5HATL8HDFNcwCeo
 R/04XnUSCBljcwy9gonXNdI7ncaEqoITvTBEDQdmu09yxHGZKrteDhAukRl35+nuIoerFB
 tJFwKL2piqYXYV0Zx3bRGswRr3/fE8s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-83KBwe9WNCyWlr49_dN7OQ-1; Wed,
 24 Jul 2024 05:48:28 -0400
X-MC-Unique: 83KBwe9WNCyWlr49_dN7OQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5E071955D4D; Wed, 24 Jul 2024 09:48:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C08619560AA; Wed, 24 Jul 2024 09:48:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 06/11] qapi: drop unused
 QCryptoBlockCreateOptionsLUKS.detached-header
Date: Wed, 24 Jul 2024 10:47:01 +0100
Message-ID: <20240724094706.30396-7-berrange@redhat.com>
In-Reply-To: <20240724094706.30396-1-berrange@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
was left over from earlier patch iterations.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/crypto.json | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index e102be337b..f03bdab8c9 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -226,8 +226,6 @@
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
 #     processing.  Currently defaults to 2000.  (since 2.8)
 #
-# @detached-header: create a detached LUKS header.  (since 9.0)
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
2.45.2


