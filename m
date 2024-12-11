Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FFCE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIaM-0005sT-Mv; Wed, 11 Dec 2024 04:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaG-0005s5-EG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaD-0007px-LS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyVMbnHqL1+3boU5qvy7iVKUU9uLYhwndpn10q33Tw8=;
 b=fVENbf5PkjoqpOrnd/oNURX1dzmCkU9NQ7xpS7dLYGLX6Qcf7k89DkITc7jw1AqBI+EqSy
 phYngyQY6pmiUR8S7aLenDtXWnjPBSQKs3ReUSj0Du+IJtdedSBVLUnuoP+AwX5f4NgFno
 J8cb/K5Gb+pTTrT5YCXlB0mgfzjYqPs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-IaIRYXE7O7CPyH2PZYDTAA-1; Wed,
 11 Dec 2024 04:00:31 -0500
X-MC-Unique: IaIRYXE7O7CPyH2PZYDTAA-1
X-Mimecast-MFC-AGG-ID: IaIRYXE7O7CPyH2PZYDTAA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE8CD19560B6; Wed, 11 Dec 2024 09:00:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 445A11956089; Wed, 11 Dec 2024 09:00:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/26] docs: replace 'Edit on GitLab' with 'View page source'
Date: Wed, 11 Dec 2024 09:59:47 +0100
Message-ID: <20241211090014.619351-4-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20241209163506.2089961-1-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.1


