Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A858C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOj-0006Ke-R6; Mon, 12 Feb 2024 04:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOi-0006Jv-N6
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOg-0003cZ-7N
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jlJNt2nB5k9s8FJ5XGlFQdQEYfD/PmgjgPEnVINocY=;
 b=Pw16ZQAMr53UTfvzQ6O/nS7Nrk13o2ofZFRw4olc3thhBW4CLz0oaGgE9hDc3o0ZWuCaQn
 D/iiTRKQ8QQWOx2k9Qc2g9XkNkFvDRQUsm0GZu81IwVBjCueCzoaU7c6km8WFhuLN0M4c9
 vB92pjS0PwXw+yoC7QGzhgQS+OldbbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-582TDMmMNHmfcO-NWIuP2Q-1; Mon, 12 Feb 2024 04:14:38 -0500
X-MC-Unique: 582TDMmMNHmfcO-NWIuP2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB87D831016;
 Mon, 12 Feb 2024 09:14:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98FCD1C1A80E;
 Mon, 12 Feb 2024 09:14:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F7E621E65EB; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/18] qapi/block-core: Fix BlockLatencyHistogramInfo doc markup
Date: Mon, 12 Feb 2024 10:14:21 +0100
Message-ID: <20240212091436.688598-4-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The description of @bins ends with a literal block:

    # @bins: list of io request counts corresponding to histogram
    #     intervals, one more element than @boundaries has.  For the
    #     example above, @bins may be something like [3, 1, 5, 2], and
    #     corresponding histogram looks like:
    #
    # ::
    #
    #        5|           *

Except it actually ends *before* the block: the unindented '::' line
starts a new section.  Makes no sense.

We could fix this by indenting the '::' line.  Instead, double the
colon at the end of the preceding paragraph, and drop the '::' line.

This shifts the box for the literal block right in generated
documentation, so it lines up with the description.

Fixes: commit a0fcff383b34 (qapi: Use rST markup for literal blocks)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-4-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/block-core.json | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 781c9bd03e..80ed4122f2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -656,9 +656,7 @@
 # @bins: list of io request counts corresponding to histogram
 #     intervals, one more element than @boundaries has.  For the
 #     example above, @bins may be something like [3, 1, 5, 2], and
-#     corresponding histogram looks like:
-#
-# ::
+#     corresponding histogram looks like::
 #
 #        5|           *
 #        4|           *
-- 
2.43.0


