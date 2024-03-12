Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39274C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Uc-0002wD-Kn; Tue, 12 Mar 2024 08:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1UC-0002In-US
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1U5-00006I-8W
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N68zhv6X3UMCUUJJqmG9mEYDBKzqwOOl02HqP8oxwCU=;
 b=imSdpXiWr7SeOyjx4sg0ZsDSXFxqjVhUIqfjluvg+RIIEu0nLwcy3elbAQb78Lqtr3UysJ
 zJLjUKIHn7+/iRAal/9+r0Jm4cUhf5TJEX0WE8CtoEclTHEC6pWKvdGNNbD34kMcHXjuPl
 azNRWr33uRa7li5QwTFiqzNCKx1dl5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-0biEct9XMumF8Dk4KSxV2A-1; Tue, 12 Mar 2024 08:43:53 -0400
X-MC-Unique: 0biEct9XMumF8Dk4KSxV2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9327589C666;
 Tue, 12 Mar 2024 12:43:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E840492BC4;
 Tue, 12 Mar 2024 12:43:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PULL 07/55] error: Add error_vprepend() in comment of ERRP_GUARD()
 rules
Date: Tue, 12 Mar 2024 13:42:51 +0100
Message-ID: <20240312124339.761630-8-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The error_vprepend() should use ERRP_GUARD() just as the documentation
of ERRP_GUARD() says:

> It must be used when the function dereferences @errp or passes
> @errp to error_prepend(), error_vprepend(), or error_append_hint().

Considering that error_vprepend() is also an API provided in error.h,
it is necessary to add it to the description of the rules for using
ERRP_GUARD().

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240311033822.3142585-2-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qapi/error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f21a231bb1..71f8fb2c50 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -207,7 +207,7 @@
  *
  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
  * - It must not be dereferenced, because it may be null.
- * - It should not be passed to error_prepend() or
+ * - It should not be passed to error_prepend(), error_vprepend(), or
  *   error_append_hint(), because that doesn't work with &error_fatal.
  * ERRP_GUARD() lifts these restrictions.
  *
-- 
2.44.0


