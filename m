Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C8C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohpO-0004Po-7Q; Mon, 25 Mar 2024 06:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rohpN-0004Pb-0O
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rohpI-0000ws-7Z
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711363511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MfigfErxRzOmRHLpDuakUQfLG5ml1wXFescyL+NgGCg=;
 b=YN3Vm2bhP7yG7G66s6PLV2Anf3RoJLe8vOpZAqwKAAL1hh7HgwDdW1Ec2CFY53OUwANq1T
 GRjfq6xbWmP2PNREGU55WLVNPARPGFtS5dXGH1XrebL3OEdWr+3K8OTq8jWjIYwoamlDhv
 XzykdxvtU7qsJ/vjUqaeYnY1MIYiDhU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-aIYKJ7NNP8CgSQvrxnFweQ-1; Mon, 25 Mar 2024 06:45:09 -0400
X-MC-Unique: aIYKJ7NNP8CgSQvrxnFweQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a466c7b0587so304914466b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711363507; x=1711968307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfigfErxRzOmRHLpDuakUQfLG5ml1wXFescyL+NgGCg=;
 b=XEKMBOUZ/XbGE6Qz2VwXfLYOfxuxI3comm4/9AXTeAguN6eFV5fr5f4tjSfNJwyqLg
 uyNESEfaY9Fv8s5klggHy/bZ2tsR0Xbc2uiQhbOgzcLkOgMJ5o1IKncTd1uGzwJDXLM5
 0OYswkA+Y+IIv7NDwwQjLMnpp+TNEbpNWS1ly4E7RVXg6h9Eq7CHJcXpZYHOmo5HyAmo
 Cqxy2qAR6IejewnHJRA+WESuNEgLjLUFkQaTI/31HHfs8pvzJDKpiOxdJn6B3ZiJN/31
 96GKOBxdbS1aIlQVVezM0vQhAxMjyh04dhF5/bvzxUhMKt5K10uWYC5DQDZVS0WEAhEa
 1V0w==
X-Gm-Message-State: AOJu0YzIsCsvUX9cLVqvCK3wOlb1u2OiAUth/f+4M0zU7AmYBAgFCJaE
 F6xLv9ge61DAqcinf48+1IYikRkJz+LPhU1hJECe7isqtTeRs1tAaaDelc9LhKU7S3ltmuFc7qc
 moEs69YXO9covRS9PFyBL0SzkePSm78HAXYOTA2sAb8LbK40r8dS8ZXxPDnWrWUysk+s8OhkRTB
 1SAAEUssfdqYzHA0FEIM47pN40z3VxP805eLyV
X-Received: by 2002:a17:906:6bc3:b0:a45:ab61:7a47 with SMTP id
 t3-20020a1709066bc300b00a45ab617a47mr4070813ejs.16.1711363507436; 
 Mon, 25 Mar 2024 03:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdqOJ7+8v/9ategfbJQvjLebvpOb7nh3Z5CKy5Pva7kPOu/HuHeVwcQrF2cu9aSHhFleYwGg==
X-Received: by 2002:a17:906:6bc3:b0:a45:ab61:7a47 with SMTP id
 t3-20020a1709066bc300b00a45ab617a47mr4070795ejs.16.1711363507039; 
 Mon, 25 Mar 2024 03:45:07 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a170907270c00b00a469be48551sm2921233ejk.45.2024.03.25.03.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 03:45:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qapi: document leftover members in qapi/stats.json
Date: Mon, 25 Mar 2024 11:45:04 +0100
Message-ID: <20240325104504.1358734-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/stats.json | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/qapi/stats.json b/qapi/stats.json
index ce9d8161ecb..578b52c7ef7 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -114,13 +114,13 @@
 #
 # The arguments to the query-stats command; specifies a target for
 # which to request statistics and optionally the required subset of
-# information for that target:
+# information for that target.
 #
-# - which vCPUs to request statistics for
-# - which providers to request statistics from
-# - which named values to return within each provider
+# @target: the kind of objects to query.  Note that each possible
+#          target may enable additional filtering options
 #
-# @target: the kind of objects to query
+# @providers: which providers to request statistics from, and optionally
+#             which named values to return within each provider
 #
 # Since: 7.1
 ##
@@ -136,6 +136,8 @@
 #
 # @scalar: single unsigned 64-bit integers.
 #
+# @boolean: single boolean value.
+#
 # @list: list of unsigned 64-bit integers (used for histograms).
 #
 # Since: 7.1
@@ -254,6 +256,8 @@
 #
 # Return the schema for all available runtime-collected statistics.
 #
+# @provider: a provider to restrict the query to.
+#
 # Note: runtime-collected statistics and their names fall outside
 #     QEMU's usual deprecation policies.  QEMU will try to keep the
 #     set of available data stable, together with their names, but
-- 
2.44.0


