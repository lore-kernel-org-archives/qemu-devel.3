Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7711EC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RHI-0008Ns-QC; Tue, 15 Sep 2026 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RH2-000832-FF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RH1-0001oM-0I
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYnX9mPK2x67ZDs6gPfEbMYlm/sJLO4I3WVtzVyPus4=;
 b=B+NbJMXm7sfC8ujCT5FJxk1AJv6jU3w00S4aF5hUmoqwCgK+2anbzJnwBLuZIlB9C+jDON
 27MpcZ9vTgJfiZQI5Q8TIWGF70YTXwkqPFyuFvW4eXuwTa0rmYIh6TlpZ+qy1IPQ8ZLDaP
 7O7tQMQrQC0idcO798QbOvEXGJm0YEY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-hcocvDFpMueGV8LLpMJRUw-1; Tue,
 15 Sep 2026 07:24:23 -0400
X-MC-Unique: hcocvDFpMueGV8LLpMJRUw-1
X-Mimecast-MFC-AGG-ID: hcocvDFpMueGV8LLpMJRUw_1789471462
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3856D1869D97; Tue, 15 Sep 2026 11:24:22 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9A01956045; Tue, 15 Sep 2026 11:24:20 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 10/19] qga/vss-win32: return an interface pointer for
 IID_IUnknown
Date: Tue, 15 Sep 2026 14:23:28 +0300
Message-ID: <20260915112337.43307-11-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CQGAVssProvider implements three COM interfaces, each with its own
IUnknown base subobject. Returning the complete object address for
IID_IUnknown relies on IVssSoftwareSnapshotProvider remaining the first
base class.

Return the IVssSoftwareSnapshotProvider subobject instead. This selects
the canonical IUnknown identity without relying on the complete-object
layout.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-8-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/provider.cpp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 377571b948..44c3c74bd2 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -212,7 +212,8 @@ CQGAVssProvider::~CQGAVssProvider()
 STDMETHODIMP CQGAVssProvider::QueryInterface(REFIID riid, void **ppObj)
 {
     if (riid == IID_IUnknown) {
-        *ppObj = static_cast<void*>(this);
+        *ppObj = static_cast<void*>(
+            static_cast<IVssSoftwareSnapshotProvider*>(this));
         AddRef();
         return S_OK;
     }
-- 
2.55.0


