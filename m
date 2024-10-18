Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9C2D3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n1v-0005h8-Ls; Fri, 18 Oct 2024 09:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1t-0005gb-Kl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1r-0007Ni-Tt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qld2nKcPqOEkBG5sB6awVUHedtwy4wYqOCrZQLB7dPk=;
 b=WHBBV0fvw9Bh9ygFu3MTaHQieAcmyHZ3MdI1Zwsl9VsSRu4jCZOWQVf+KslAVuASN0ej8R
 pO4pmLBPc+4yKXSox4z10dhPcMWjby2i2EXrZoCLqqbUpMKRgTCg9OjH61p1ZjiK7tB9Dy
 iqhr5fgCB2UU9BdrfgxZ0RG9DQSFla0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-hdZ4pI9tOSCPhJSGVK7gKw-1; Fri,
 18 Oct 2024 09:28:28 -0400
X-MC-Unique: hdZ4pI9tOSCPhJSGVK7gKw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DE2119560AF; Fri, 18 Oct 2024 13:28:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F7D119560A3; Fri, 18 Oct 2024 13:28:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F27221E6939; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/9] error: Drop superfluous #include "qapi/qmp/qerror.h"
Date: Fri, 18 Oct 2024 15:28:18 +0200
Message-ID: <20241018132824.3379780-4-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241010150144.986655-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-bsd.c   | 1 -
 qga/commands-linux.c | 1 -
 qga/commands-posix.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 9ce48af311..94ff6fee6a 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "qga-qapi-commands.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
 #include "commands-common.h"
diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 51d5e3d927..9b1746b24f 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -15,7 +15,6 @@
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "commands-common.h"
 #include "cutils.h"
 #include <mntent.h>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index c2bd0b4316..389c5eeb5d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -18,7 +18,6 @@
 #include <dirent.h>
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/host-utils.h"
 #include "qemu/sockets.h"
 #include "qemu/base64.h"
-- 
2.46.0


