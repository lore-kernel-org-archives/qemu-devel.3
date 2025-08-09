Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7773EC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 05:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukcTa-0001w7-4G; Sat, 09 Aug 2025 01:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTW-0001tC-4i
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTS-0002Hb-NV
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754718633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaDoeL5DyFczd3jVxAe2QCI8h3IBnZohyaWArlgB8R4=;
 b=Ze4YctLGkn8rRH0+xo0CIE8LqqWKcPS0chqR0UKDlNt4ZQd22jr7TD40tXnU535pcVAJ09
 jsG4qrOImaimt/UI8pyGo6tZlFygMAhcuNulR5Z8jRZNoAp3l4wFaFJ+G3nb+U+6/lUVmm
 Wgliq3ZVqQk9Ue3niZIKTwvpZfXu8is=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-p_-hkcOuODu2DJ4ea2l2gg-1; Sat,
 09 Aug 2025 01:50:31 -0400
X-MC-Unique: p_-hkcOuODu2DJ4ea2l2gg-1
X-Mimecast-MFC-AGG-ID: p_-hkcOuODu2DJ4ea2l2gg_1754718630
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 846771800347
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDAD519560B0
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED36421E6925; Sat, 09 Aug 2025 07:50:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 2/3] docs/devel/qapi-code-gen: Fix typos in QAPI schema
 language grammar
Date: Sat,  9 Aug 2025 07:50:25 +0200
Message-ID: <20250809055026.2944835-3-armbru@redhat.com>
In-Reply-To: <20250809055026.2944835-1-armbru@redhat.com>
References: <20250809055026.2944835-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 3248c1aaf2db (docs: update the documentation upfront about schema configuration)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250731054044.4011789-3-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 138921b386..2cd51729c3 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -786,8 +786,8 @@ Configuring the schema
 Syntax::
 
     COND = STRING
-         | { 'all: [ COND, ... ] }
-         | { 'any: [ COND, ... ] }
+         | { 'all': [ COND, ... ] }
+         | { 'any': [ COND, ... ] }
          | { 'not': COND }
 
 All definitions take an optional 'if' member.  Its value must be a
-- 
2.49.0


