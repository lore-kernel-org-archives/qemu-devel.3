Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347E4C9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHmZ-0001vA-SG; Mon, 12 Jan 2026 08:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlZ-0001Xw-03
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlX-0002bG-Ig
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvsWtIfrf4yznnr06FlcP4VHxBPYYTEfls48cI2EW78=;
 b=eR3FO5zE7h1xr6Z+S4gjcuXJZsZSBnEFHN/DZO5rCQ/oZu7lW9aqHX292Bc0Fjk6py7HRT
 W1w7X55g4qugsbjkS3iw6qqmLL1rq6vEvMmcS6g1hkQ5h4ZX/+iEic1E+jyxPNB5DCVDhc
 n0yeYnF/CgtA6O9rOf1OSZfbCbcsVCE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-mHiBBlH8NfKoFq0b6go1Dw-1; Mon,
 12 Jan 2026 08:15:18 -0500
X-MC-Unique: mHiBBlH8NfKoFq0b6go1Dw-1
X-Mimecast-MFC-AGG-ID: mHiBBlH8NfKoFq0b6go1Dw_1768223717
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9531F18002C8; Mon, 12 Jan 2026 13:15:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00AE83000218; Mon, 12 Jan 2026 13:15:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 qemu-trivial@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/15] docs: update copyright year to 2026
Date: Mon, 12 Jan 2026 14:14:49 +0100
Message-ID: <20260112131457.67128-8-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

We are already in 2026. Update docs to update copyright info to year 2026.

Cc: peter.maydell@linaro.org
Cc: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260107045250.34420-1-anisinha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index bc4e9622dc8..f835904ba1e 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -92,7 +92,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2025, The QEMU Project Developers'
+copyright = u'2026, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index bc8fab91697..a9ccec7b38c 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2025 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2026 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.52.0


