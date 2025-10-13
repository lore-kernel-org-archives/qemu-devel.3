Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43074CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8GTL-0001au-Tn; Mon, 13 Oct 2025 07:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8GTJ-0001Zi-Fn
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8GTG-0003XA-Av
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760353922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LMoT1g6Mc8x8J+8u0A5iWPekJXDZGpdrQuYVm2L9EzA=;
 b=EbwCn6Gt0RU7hgBuBLFEBM0bFEbYKIQf3L/wk4xgTIS2gyUwJUpWYARR7+bpxdefKsR5gb
 lvuZPaMlWxn0JfC8LAzFr6rMoPxWhkOTCIDScIXw8DktQUMjCk9zXDxhmIzdWn6udsp50p
 IfmPkPlkqeQPkdkPTyrAOebIELCY/Kc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-8FXATEX0MEioFulC3yBscA-1; Mon,
 13 Oct 2025 07:11:57 -0400
X-MC-Unique: 8FXATEX0MEioFulC3yBscA-1
X-Mimecast-MFC-AGG-ID: 8FXATEX0MEioFulC3yBscA_1760353916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EA0A19560AE; Mon, 13 Oct 2025 11:11:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.160])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3FAC1954102; Mon, 13 Oct 2025 11:11:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-trivial@nongnu.org
Subject: [PATCH] hw/xen: Avoid non-inclusive language in params.h
Date: Mon, 13 Oct 2025 13:11:52 +0200
Message-ID: <20251013111152.25807-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Copy the latest version of Xen's params.h to the QEMU repository:

https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=0291089f6ea81690f37035a124d54c51fa7ba097#patch8

With this patch, we get rid of a non-inclusive word in the comment
there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/xen/interface/hvm/params.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/interface/hvm/params.h b/include/hw/xen/interface/hvm/params.h
index a22b4ed45d2..99c40b4287f 100644
--- a/include/hw/xen/interface/hvm/params.h
+++ b/include/hw/xen/interface/hvm/params.h
@@ -246,16 +246,11 @@
 #define HVM_PARAM_VM_GENERATION_ID_ADDR 34
 
 /*
- * Set mode for altp2m:
- *  disabled: don't activate altp2m (default)
+ * Get mode for altp2m:
+ *  disabled: altp2m not active (default)
  *  mixed: allow access to all altp2m ops for both in-guest and external tools
  *  external: allow access to external privileged tools only
  *  limited: guest only has limited access (ie. control VMFUNC and #VE)
- *
- * Note that 'mixed' mode has not been evaluated for safety from a
- * security perspective.  Before using this mode in a
- * security-critical environment, each subop should be evaluated for
- * safety, with unsafe subops blacklisted in XSM.
  */
 #define HVM_PARAM_ALTP2M       35
 #define XEN_ALTP2M_disabled      0
-- 
2.51.0


