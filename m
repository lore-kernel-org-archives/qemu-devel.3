Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C795C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KS-0004hE-EM; Tue, 26 Mar 2024 03:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KO-0004dk-69
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KL-0005M5-Ni
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guo92hK/Vrt5JmdZAgTsv4nliR53RFEJNWqwDcR0BxM=;
 b=d4y5m7keSI5IKV7mOk+GoQ8zuHZjuY72rBk9h6SeErBbeBxR2150u/ZmVlTKsQHA8xitqu
 Cp11wj/WuY5OU8i+YQ4RnYkdXtiY9IJveVfvoXQgO9piU42mu+P948vHGisd1fqLRLEldN
 X5AHMpaOpIbnI9tsz701Gw1K6CCoTvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ZbRA-oDiPFGkSTC1PaH8Pg-1; Tue, 26 Mar 2024 03:34:31 -0400
X-MC-Unique: ZbRA-oDiPFGkSTC1PaH8Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5E128007A4;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95BE9C3E620;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98F4421E5D2C; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 06/20] qapi: Tidy up block-latency-histogram-set documentation
 some more
Date: Tue, 26 Mar 2024 08:34:06 +0100
Message-ID: <20240326073420.738016-7-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Commit a937b6aa739 (qapi: Reformat doc comments to conform to current
conventions) reflowed some text that should have been left alone.
Revert that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322140910.328840-4-armbru@redhat.com>
---
 qapi/block.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 65d9804bdf..2410145cd3 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -545,8 +545,8 @@
 #
 # Example:
 #
-#     Set new histograms for all io types with intervals [0, 10), [10,
-#     50), [50, 100), [100, +inf):
+#     Set new histograms for all io types with intervals
+#     [0, 10), [10, 50), [50, 100), [100, +inf):
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
@@ -565,9 +565,9 @@
 #
 # Example:
 #
-#     Set new histograms with the following intervals:   read, flush: [0,
-#     10), [10, 50), [50, 100), [100, +inf)   write: [0, 1000), [1000,
-#     5000), [5000, +inf)
+#     Set new histograms with the following intervals:
+#       read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
+#       write: [0, 1000), [1000, 5000), [5000, +inf)
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
-- 
2.44.0


