Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32779E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgjC-0003Ue-MO; Mon, 09 Dec 2024 11:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKgjA-0003UG-Er
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKgj7-0004kY-I0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733762115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W+BLSyS0e/pSGH11Pnc94tbZg0PezwYT1p2uN5liH7c=;
 b=ANE3PhR94MKD1j5cCxiCqd/xzcGoc5xmyAdwwwau5STtLYDMa7H/smtBfhy+0DMUASRWrH
 n78B1NkT95sSQEaPbsbe5FX7CNhwzhZ7YPcHEpLW/rAf0vEMiYpD0v8VIa9S+VJUczvYAp
 cibVpwQ/lmV6folByrB4n+GFj3A/y1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-zpZ628kzNKWMEa7nndoDtw-1; Mon,
 09 Dec 2024 11:35:11 -0500
X-MC-Unique: zpZ628kzNKWMEa7nndoDtw-1
X-Mimecast-MFC-AGG-ID: zpZ628kzNKWMEa7nndoDtw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B0B51955BC5; Mon,  9 Dec 2024 16:35:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.115])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B46C7195605A; Mon,  9 Dec 2024 16:35:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs: replace 'Edit on GitLab' with 'View page source'
Date: Mon,  9 Dec 2024 16:35:06 +0000
Message-ID: <20241209163506.2089961-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

QEMU takes contributions via the mailing list, so while you can edit a
file on gitlab and then switch to the terminal to send a patch, the
wording 'Edit on GitLab' strongly suggests we take merge requests.

Switching back to "View page source" is a more agnostic term that does
not imply a particular contribution approach, that we had used in QEMU
before:

  commit 73e6aec6522e1edd63f631c52577b49a39bc234f
  Author: Marc-André Lureau <marcandre.lureau@redhat.com>
  Date:   Tue Mar 23 15:53:28 2021 +0400

    sphinx: adopt kernel readthedoc theme

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index c11a6ead8a..164a8ee8b2 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -186,7 +186,7 @@
 ]
 
 html_context = {
-    "display_gitlab": True,
+    "source_url_prefix": "https://gitlab.com/qemu-project/qemu/-/blob/master/docs/",
     "gitlab_user": "qemu-project",
     "gitlab_repo": "qemu",
     "gitlab_version": "master",
-- 
2.46.0


