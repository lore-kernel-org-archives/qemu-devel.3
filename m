Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31949CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 06:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0aVv-0005hh-TW; Mon, 22 Sep 2025 02:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nanliu@redhat.com>) id 1v0aVu-0005hC-1r
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nanliu@redhat.com>) id 1v0aVr-0008Ib-TV
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758524342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vSFNZtp1OF3sI2KNcg8k091rCczXY4eX9fStYwBSy0g=;
 b=ifpPSmE7lHeWOlA9G4cLDpX+4nz22S2Lg8Wc1Dsnt3ytKvwKdxx2pHnzSuqwcxKfjISFsW
 TFor3OP2TuQcoW85KNDargZ9sWjj8vgVwSfBLNhgZAsPrs/1WBHyZE5uZNRWjn+mUcXZOM
 hinQ2IMTnowsKG3SbO4TZKa7+5Uk6T8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-4gE9Fvp-PeKJrCTKscJODQ-1; Mon,
 22 Sep 2025 02:57:49 -0400
X-MC-Unique: 4gE9Fvp-PeKJrCTKscJODQ-1
X-Mimecast-MFC-AGG-ID: 4gE9Fvp-PeKJrCTKscJODQ_1758524269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7E91180034D
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:57:48 +0000 (UTC)
Received: from nanliu-thinkpadp16vgen1.raycom.csb (unknown [10.72.116.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B61F1800577; Mon, 22 Sep 2025 06:57:45 +0000 (UTC)
From: nanliu <nanliu@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	nanliu <nanliu@redhat.com>
Subject: [PATCH] docs/devel: Correct uefi-vars-x64 device name
Date: Mon, 22 Sep 2025 14:57:14 +0800
Message-ID: <20250922065714.93081-1-nanliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nanliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The documentation for UEFI variable storage in uefi-vars.rst
incorrectly listed the device name as `uefi-vars-x86`.

The correct device name as implemented in the source code is
`uefi-vars-x64`.

This commit updates the documentation to use the correct name,
aligning it with the implementation.

Signed-off-by: Nana Liu <nanliu@redhat.com>
---
 docs/devel/uefi-vars.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/uefi-vars.rst b/docs/devel/uefi-vars.rst
index 0151a26a0a..b4013b5d12 100644
--- a/docs/devel/uefi-vars.rst
+++ b/docs/devel/uefi-vars.rst
@@ -34,7 +34,7 @@ configures the shared buffer location and size, and traps to the host
 to process the requests.
 
 The ``uefi-vars`` device implements the UEFI virtual device.  It comes
-in ``uefi-vars-x86`` and ``uefi-vars-sysbus`` flavours.  The device
+in ``uefi-vars-x64`` and ``uefi-vars-sysbus`` flavours.  The device
 reimplements the handlers needed, specifically
 ``EfiSmmVariableProtocol`` and ``VarCheckPolicyLibMmiHandler``.  It
 also consumes events (``EfiEndOfDxeEventGroup``,
@@ -57,7 +57,7 @@ usage on x86_64
 .. code::
 
    qemu-system-x86_64 \
-      -device uefi-vars-x86,jsonfile=/path/to/vars.json
+      -device uefi-vars-x64,jsonfile=/path/to/vars.json
 
 usage on aarch64
 ----------------
-- 
2.50.1


