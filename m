Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6083AC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 06:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTFh3-0005FO-Ht; Fri, 26 Jan 2024 01:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgx-0005Bp-DL
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgt-0001lB-HR
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706250470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXw48Z1gqb2OkeP2X3gYVnL+yU4lWWOVRa93Cz5SFvQ=;
 b=ZbzyTOBAQsYaXAMEeBEBMLCEk4rWoT/Xc7A6mBeONseW2YZKZvdPUVIxc5qhKkj7+L2SZM
 kvTZqFeX41wzsAnwP0kHUTXqQPVGkxEnNJox0m2bLEGfMrfiiy09c4P55Pf7IfW0q/TKVg
 ipEQZM8l28zlqMV77gcU2KPBVSHyRPE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-E2Hx8QeHPiqPlLPXIn8G0Q-1; Fri, 26 Jan 2024 01:27:46 -0500
X-MC-Unique: E2Hx8QeHPiqPlLPXIn8G0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDAFA185A781;
 Fri, 26 Jan 2024 06:27:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB2901C060B1;
 Fri, 26 Jan 2024 06:27:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCB2321E669B; Fri, 26 Jan 2024 07:27:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 3/8] docs: Replace dangling references to
 docs/interop/qmp-intro.txt
Date: Fri, 26 Jan 2024 07:27:39 +0100
Message-ID: <20240126062744.265588-4-armbru@redhat.com>
In-Reply-To: <20240126062744.265588-1-armbru@redhat.com>
References: <20240126062744.265588-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Deletion of docs/interop/qmp-intro.txt left two dangling references
behind.  Replace them by references to docs/interop/qmp-spec.rst.

Fixes: 0ec4468f233c (docs/interop: Delete qmp-intro.txt)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240120095327.666239-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/writing-monitor-commands.rst | 4 ++--
 docs/interop/bitmaps.rst                | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index 2c11e71665..3b3d5517a2 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -8,8 +8,8 @@ This document doesn't discuss QMP protocol level details, nor does it dive
 into the QAPI framework implementation.
 
 For an in-depth introduction to the QAPI framework, please refer to
-docs/devel/qapi-code-gen.txt. For documentation about the QMP protocol,
-start with docs/interop/qmp-intro.txt.
+docs/devel/qapi-code-gen.txt.  For the QMP protocol, see the
+:doc:`/interop/qmp-spec`.
 
 New commands may be implemented in QMP only.  New HMP commands should be
 implemented on top of QMP.  The typical HMP command wraps around an
diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index 1de46febdc..c731be2f01 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -166,9 +166,9 @@ Basic QMP Usage
 ---------------
 
 The primary interface to manipulating bitmap objects is via the QMP
-interface. If you are not familiar, see docs/interop/qmp-intro.txt for a broad
-overview, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full reference of all
-QMP commands.
+interface. If you are not familiar, see the :doc:`qmp-spec` for the
+protocol, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full
+reference of all QMP commands.
 
 Supported Commands
 ~~~~~~~~~~~~~~~~~~
-- 
2.43.0


