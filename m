Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D1AC48297
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 08:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWBTn-0002ou-Hn; Sat, 03 Feb 2024 03:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTl-0002oe-KX
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTg-0007IB-UI
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706949259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvjV7huPimUbN8Uv56iRsb0WHVjJEp7Ao2MLjjHu5dg=;
 b=Zal1JwXZojLvgMsXKS2ZJv9EOrmWhbD1m/GGbAT+mgC+Hpl2/XgNLjvhXHLv7D2+SkXW3q
 fNGahcXjHVHcQrDB57HfPC60FHaYxcIO/NMHfudRix3bBA+2TxZWujQg/00HYB6YnU+onk
 FQ7wUHJExRvA18OjFzZkBri3hvGaw0Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-NlsbvrnJO5iatgI4YgVEMw-1; Sat,
 03 Feb 2024 03:34:17 -0500
X-MC-Unique: NlsbvrnJO5iatgI4YgVEMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 436B1383E127;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7E11C060B1;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EEF1D21E66E6; Sat,  3 Feb 2024 09:34:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 1/5] qapi: Drop redundant documentation of inherited members
Date: Sat,  3 Feb 2024 09:34:11 +0100
Message-ID: <20240203083415.2937003-2-armbru@redhat.com>
In-Reply-To: <20240203083415.2937003-1-armbru@redhat.com>
References: <20240203083415.2937003-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Documentation generated for SchemaInfo looks like

    The members of "SchemaInfoBuiltin" when "meta-type" is ""builtin""
    The members of "SchemaInfoEnum" when "meta-type" is ""enum""
    The members of "SchemaInfoArray" when "meta-type" is ""array""
    The members of "SchemaInfoObject" when "meta-type" is ""object""
    The members of "SchemaInfoAlternate" when "meta-type" is ""alternate""
    The members of "SchemaInfoCommand" when "meta-type" is ""command""
    The members of "SchemaInfoEvent" when "meta-type" is ""event""
    Additional members depend on the value of "meta-type".

The last line became redundant when commit 88f63467c57 (qapi2texi:
Generate reference to base type members) added the lines preceding it.
Drop it.

BlockdevOptions has the same issue.  Drop

    Remaining options are determined by the block driver.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240129115008.674248-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 2 --
 qapi/introspect.json | 2 --
 2 files changed, 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 48c181e55d..530c4af50f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4665,8 +4665,6 @@
 # @force-share: force share all permission on added nodes.  Requires
 #     read-only=true.  (Since 2.10)
 #
-# Remaining options are determined by the block driver.
-#
 # Since: 2.9
 ##
 { 'union': 'BlockdevOptions',
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 8df1ce85ed..b041b02ba8 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -93,8 +93,6 @@
 #     particular order.  (since 4.1 for object types, 4.2 for
 #     commands, 5.0 for the rest)
 #
-# Additional members depend on the value of @meta-type.
-#
 # Since: 2.5
 ##
 { 'union': 'SchemaInfo',
-- 
2.43.0


