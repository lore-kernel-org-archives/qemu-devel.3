Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9FEC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 17:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2cL-0006QN-61; Mon, 05 Feb 2024 12:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2cI-0006Q6-MR
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2cG-0004i4-F6
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707153522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JZvROJBWMXD1Yk+SkyV0oa1THIhBeXssppJtBWAqOk0=;
 b=aoW5KuwCqr2m89Axt7R5zsA3bVikAd0es/0XPTGFLc8hQo2vRk1zxlVUi+48yqv0W4UzC+
 NN1nFQePCCGTE+ae30B/MdOMBYqujCfk286Da7872O0LtNWximZCgq6DfDilx/rMJXqvcZ
 Db/om+1rYr1fRrCv5+F6nDGPX2KX1B0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-kZktsLM_PiCKHxlq4gloBg-1; Mon, 05 Feb 2024 12:18:38 -0500
X-MC-Unique: kZktsLM_PiCKHxlq4gloBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B889C185A780;
 Mon,  5 Feb 2024 17:18:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36C9CC15E61;
 Mon,  5 Feb 2024 17:18:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] docs/style: allow C99 mixed declarations
Date: Mon,  5 Feb 2024 12:18:19 -0500
Message-ID: <20240205171819.474283-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

C99 mixed declarations support interleaving of local variable
declarations and code.

The coding style "generally" forbids C99 mixed declarations with some
exceptions to the rule. This rule is not checked by checkpatch.pl and
naturally there are violations in the source tree.

While contemplating adding another exception, I came to the conclusion
that the best location for declarations depends on context. Let the
programmer declare variables where it is best for legibility. Don't try
to define all possible scenarios/exceptions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/style.rst | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b50079..80c4e4df52 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -199,26 +199,6 @@ Rationale: a consistent (except for functions...) bracing style reduces
 ambiguity and avoids needless churn when lines are added or removed.
 Furthermore, it is the QEMU coding style.
 
-Declarations
-============
-
-Mixed declarations (interleaving statements and declarations within
-blocks) are generally not allowed; declarations should be at the beginning
-of blocks. To avoid accidental re-use it is permissible to declare
-loop variables inside for loops:
-
-.. code-block:: c
-
-    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
-        /* do something loopy */
-    }
-
-Every now and then, an exception is made for declarations inside a
-#ifdef or #ifndef block: if the code looks nicer, such declarations can
-be placed at the top of the block even if there are statements above.
-On the other hand, however, it's often best to move that #ifdef/#ifndef
-block to a separate function altogether.
-
 Conditional statements
 ======================
 
-- 
2.43.0


