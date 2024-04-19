Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6634C05052
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1P-0007Vf-3q; Fri, 19 Apr 2024 00:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1C-0007SI-LZ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1A-0004C4-O3
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rtuow9SNA+OVjXTxvHwCUSUMwDlRyPh0+mhQGPz8ocQ=;
 b=VutQ0i6FwiaEiHxyqi9rlTvJN3rrwuDFxaKssvCM6m7jcLhp2whjKmk5NpqAW7mvXfzrf/
 8UzwIe8Yw0TOylhIgc34BYdbYeBi7QP5GgLTQXTA1OBS0nnvliNFqez+1ZIfO/ARGne2N2
 Xg6GB4Z9gjXQn2ZCfhFeaaHqrtnno+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-2eb8cY2_Nti9Q0RrmW0RXw-1; Fri, 19 Apr 2024 00:38:30 -0400
X-MC-Unique: 2eb8cY2_Nti9Q0RrmW0RXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C054D104B500;
 Fri, 19 Apr 2024 04:38:29 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6864011FF7;
 Fri, 19 Apr 2024 04:38:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 11/27] docs/qapi-domain: add "Errors:" field lists
Date: Fri, 19 Apr 2024 00:37:59 -0400
Message-ID: <20240419043820.178731-12-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

``:error type: descr`` can now be used to document error conditions,
naming the type of error object and a description of when the error is
surfaced.

Like the previous Arguments patch, this patch does not apply any special
QAPI syntax highlighting or cross-referencing for the types, but this
can be adjusted in the future if desired.

(At present, I have no commits that add such highlighting. Sphinx also
does not appear to support Grouped fields with optional (or no)
parameters, so the ability to exclude error types is currently not
supported. If you omit the type, Sphinx treats it as a regular field
list and doesn't apply the special Grouping postprocessing to it.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        | 4 ++++
 docs/sphinx/qapi-domain.py | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index a570c37abb2..004d02e0437 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -98,6 +98,10 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :feat unstable: More than unstable, this command doesn't even exist!
    :arg no-descr:
    :feat hallucination: This command is a figment of your imagination.
+   :error CommandNotFound: When you try to use this command, because it
+      isn't real.
+   :error GenericError: If the system decides it doesn't like the
+      argument values. It's very temperamental.
 
    Field lists can appear anywhere in the directive block, but any field
    list entries in the same list block that are recognized as special
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index c0dc6482204..1f0b168fa2c 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -273,6 +273,12 @@ class QAPICommand(QAPIObject):
                 names=("arg",),
                 can_collapse=True,
             ),
+            GroupedField(
+                "error",
+                label=_("Errors"),
+                names=("error",),
+                can_collapse=True,
+            ),
         ]
     )
 
-- 
2.44.0


