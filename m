Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62125CF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuXu-00037B-L0; Wed, 02 Oct 2024 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuXl-00033G-AI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuXj-0003Og-GV
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727857026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=0vs7+OFJSuY+WDv1wtM1DY+hESGV99w+zOBIPUEJFV8=;
 b=eWPyoF1RncjpD/9b+OTJXTr8b6cYivCezE4WLiUaQLXh/Cmyiv7+rPGEvcjdFeBWSFZ7Bo
 PgaX53aTRG0fP48fXIoRof8bVmQoiVYuCcL9EFjVBfnK/QJsi3rGgezFiq5LDLkNU8v0UT
 31brr4HFa0AxkXzl11ES6RBJs6mj7Wk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-JbcWMql7PESz7cOIBB96xg-1; Wed,
 02 Oct 2024 04:17:02 -0400
X-MC-Unique: JbcWMql7PESz7cOIBB96xg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C6B81955EAA; Wed,  2 Oct 2024 08:17:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06EDA3000199; Wed,  2 Oct 2024 08:17:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC4F221E6A28; Wed,  2 Oct 2024 10:16:56 +0200 (CEST)
Resent-To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 02 Oct 2024 10:16:56 +0200
Resent-Message-ID: <87ldz66hs7.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Oct  2 09:44:04 2024
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF97E21E6828; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 10/10] qapi/block-core: Drop drive-backup's "Any other error"
 documentation
Date: Wed,  2 Oct 2024 09:44:04 +0200
Message-ID: <20241002074404.1983368-11-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
References: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

We've always been rather lax about documenting errors.  Many "Errors"
sections are obviously not exhaustive.  Only drive-backup is explicit
about this: "Any other error returns a GenericError".

Not useful.  Drop.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240911132459.2548063-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d3f076db9d..5c2b3ac0d4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1858,7 +1858,6 @@
 #
 # Errors:
 #     - If @device does not exist, DeviceNotFound
-#     - Any other error returns a GenericError.
 #
 # Since: 1.3
 #
-- 
2.46.0



