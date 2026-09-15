Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E287C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RHE-0008G1-VE; Tue, 15 Sep 2026 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGx-00081u-FJ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGv-0001nh-GU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyxt3Ph9FjkWPDzeyjyr2dRARVBNe47DI2FzEFfXQ6o=;
 b=JF0V8TjoDr9wlEZo1J0dqhx/NfNNmCmET8NdmcvlW2JwpLUMLsNI3d+wrtzOvy1aVUFQ8n
 wUpjz0liAOz+B1zn7pVdLnlyJrQL1R/HM+oyB70iyMBD+kPqTJK9rHjKZ+qC8dHj3CJg5c
 zD8uulx1JBA068xYMFj3VJLYaO9YGs4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-bphY2KO8MaOyEPBsvIaVJw-1; Tue,
 15 Sep 2026 07:24:14 -0400
X-MC-Unique: bphY2KO8MaOyEPBsvIaVJw-1
X-Mimecast-MFC-AGG-ID: bphY2KO8MaOyEPBsvIaVJw_1789471454
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0BFE1865FF5; Tue, 15 Sep 2026 11:24:13 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C62F1956045; Tue, 15 Sep 2026 11:24:12 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 06/19] qga/vss-win32: explicit NULL/zero initialization
Date: Tue, 15 Sep 2026 14:23:24 +0300
Message-ID: <20260915112337.43307-7-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

We use -ftrivial-auto-var-init=zero, but static analyzers don't..

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-4-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp   | 2 +-
 qga/vss-win32/requester.cpp | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index f89658d277..12b045e207 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -61,7 +61,7 @@ static void errmsg(DWORD err, const char *text)
 
 static void errmsg_dialog(DWORD err, const char *text, const char *opt = "")
 {
-    char *msg, buf[512];
+    char *msg = NULL, buf[512] = "";
 
     FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
                   FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 493ecd5717..52176d7512 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -170,7 +170,7 @@ static void AddComponents(ErrorSet *errset)
     unsigned int cComponents, c1, c2, j;
     COMPointer<IVssExamineWriterMetadata> pMetadata;
     COMPointer<IVssWMComponent> pComponent;
-    PVSSCOMPONENTINFO info;
+    PVSSCOMPONENTINFO info = NULL;
     HRESULT hr;
 
     hr = vss_ctx.pVssbc->GetWriterMetadataCount(&cWriters);
-- 
2.55.0


