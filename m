Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A2CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1gO-0007DR-6Q; Tue, 09 Sep 2025 12:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fp-0006bm-Kt
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fh-0007gv-A4
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SarWNkkPipfzaVswdxaKtk5JouDS/oxPAKWbBzRnR0=;
 b=eyhWqfJAKWhKqxnMAjrpPPZQBUS7FnSju9gdh7/TcmndElExyXsudBp04FK/kKFYsYPzzD
 8jwrky6ys5FhSbNbF5jd1bEi8WWIyIfrMUjVuqJKlinLezQytKPPUawrXmjZOcUhfP8h5M
 oveEwS28CVE8WxgbKDXskKMIDfx5OFo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-ChUqEFRSPUiZLeigq4nuJw-1; Tue,
 09 Sep 2025 12:58:15 -0400
X-MC-Unique: ChUqEFRSPUiZLeigq4nuJw-1
X-Mimecast-MFC-AGG-ID: ChUqEFRSPUiZLeigq4nuJw_1757437094
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69458180028C; Tue,  9 Sep 2025 16:58:14 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 328311800447; Tue,  9 Sep 2025 16:58:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/15] docs: expand security docs with info about
 secure/insecure markers
Date: Tue,  9 Sep 2025 17:57:26 +0100
Message-ID: <20250909165726.3814465-16-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The explicit 'secure' or 'insecure' markers will take priority over
the general "virtualization" vs "non-virtualization" use case
classfication.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/security.rst | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index f2092c8768..15cffc2685 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -49,6 +49,47 @@ Bugs affecting the non-virtualization use case are not considered security
 bugs at this time.  Users with non-virtualization use cases must not rely on
 QEMU to provide guest isolation or any security guarantees.
 
+Security status reporting
+'''''''''''''''''''''''''
+
+QEMU is progressively working to annotate object types to explicitly state
+whether they are considered to provide a security boundary or not.
+
+When the `require-secure=yes` parameter is given to the `-machine` argument
+attempts to use any type which is not explicitly considered secure will
+result in an error.
+
+When the `prohibit-insecure=yes` parameter is given to the `-machine` argument
+attempts to use any type which is explicitly considered insecure will result
+in an error.
+
+This gives three effective levels of control over the security
+
+ * default: any type can be used
+ * `prohibit-insecure=yes`: only exclude explicitly insecure types, allow
+   those which have no security statement, or which are explicitly secure
+ * `require-secure=yes`: only allow explicitly secure types, exclude those
+   which have no security statement, or which are explicitly insecure
+
+Violations of the requested policy will result in QEMU preventing the launch
+of the VM, or preventing hot-add of the device in the monitor.
+
+When considering whether to treat a flaw as a security issue, the following
+criteria will be used
+
+ * Type marked 'secure': eligible for security process with embargo where
+   applicable
+ * Type marked 'insecure': ineligible for security process, will be triaged
+   on the public mailing list / bug trackers
+ * Type with no security statement: "Virtualization" vs "Non-Virtualization"
+   use case will be used as a guide to decide on handling process, evaluated
+   upon bug report
+
+Machine type security status can be queried using '-machine help' or the
+QMP 'query-machines' command.
+
+Device type security status can be queried using '-device help'.
+
 Architecture
 ------------
 
-- 
2.50.1


