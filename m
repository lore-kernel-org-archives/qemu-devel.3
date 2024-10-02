Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D54CF3199
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svu1w-0006pp-Pm; Wed, 02 Oct 2024 03:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svu1u-0006oe-Tl
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svu1t-0008OZ-JW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727855052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NL3sAUoNIgW0yqVlbF5otXoOxGXwXch870iAwGeCdWE=;
 b=XYPz8dlllifjiR6ujx9Xm+tocXMKd96NCdE+syjPhfVXkOOPj0YtoFGFxL/DXwgtwDObSP
 UqNjaWF4UJtGM1aO7uJL6K6kiC9mCTgAlCnfKFd0ICt0bD9F98l4uwiP455dI2aKdk0WL8
 GpyCtoo4DF4shy1WGD2jZLsWnA7klw0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-e8A8SOc_NXK34pV3e_3D5g-1; Wed,
 02 Oct 2024 03:44:09 -0400
X-MC-Unique: e8A8SOc_NXK34pV3e_3D5g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F7531977016; Wed,  2 Oct 2024 07:44:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADCFB19560AD; Wed,  2 Oct 2024 07:44:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAD1D21E692E; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] qapi/crypto: Supply missing member documentation
Date: Wed,  2 Oct 2024 09:43:57 +0200
Message-ID: <20241002074404.1983368-4-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
References: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since we neglect to document the members of QCryptoAkCipherKeyType,
their description in the QEMU QMP Reference manual is "Not
documented".  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240911112545.2248881-4-armbru@redhat.com>
---
 qapi/crypto.json | 4 ++++
 qapi/pragma.json | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 867b09d322..9431522768 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -602,6 +602,10 @@
 #
 # The type of asymmetric keys.
 #
+# @public: public key
+#
+# @private: private key
+#
 # Since: 7.1
 ##
 { 'enum': 'QCryptoAkCipherKeyType',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index f03b9cc444..625eac99df 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -64,7 +64,6 @@
         'NetClientDriver',
         'ObjectType',
         'PciMemoryRegion',
-        'QCryptoAkCipherKeyType',
         'QCryptodevBackendServiceType',
         'QKeyCode',
         'RbdAuthMode',
-- 
2.46.0


