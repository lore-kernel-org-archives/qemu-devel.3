Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45FFC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHmz-00010E-Fj; Thu, 07 Mar 2024 12:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmq-0000tA-5x
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:44:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmY-00045i-QU
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709833430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIlCcmDQIk89Hj3GT6H2QVvx/Dx1HtXandT/F1r5aws=;
 b=Pc17ZfBSFcx+Wi5rYVGgYACvGBJx/5JoLU/braef8jFazmVOMYSm7m6z4RfpRIx8crqMKY
 SQZUMgBfw20pQHT1KiDWOc0/NAX8wioSDGImztlPxMJEkwgz9JW6uJGj9inxI37G3JRKPv
 Z1JZqDl52M90kqcaCmOOxa0msBtfMhk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-f_mtK3nzPSqkQRSN1LS5Uw-1; Thu,
 07 Mar 2024 12:43:47 -0500
X-MC-Unique: f_mtK3nzPSqkQRSN1LS5Uw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9226B3C5CF2A;
 Thu,  7 Mar 2024 17:43:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A261492BDC;
 Thu,  7 Mar 2024 17:43:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] docs/about: Deprecate the old "UltraSparc" CPU names that
 contain a "+"
Date: Thu,  7 Mar 2024 18:43:34 +0100
Message-ID: <20240307174334.130407-6-thuth@redhat.com>
In-Reply-To: <20240307174334.130407-1-thuth@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For consistency we should drop the names with a "+" in it in the
long run.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8565644da6..7058341f8f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -202,6 +202,15 @@ in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
 an alias, but for consistency these will get removed in a future
 release, too. Use ``power5p_v2.1`` and ``power7p_v2.1`` instead.
 
+``Sun-UltraSparc-IIIi+`` and ``Sun-UltraSparc-IV+`` CPU names (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The character "+" in device (and thus also CPU) names is not allowed
+in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
+``Sun-UltraSparc-IV+`` are currently still supported via a workaround,
+but for consistency these will get removed in a future release, too.
+Use ``Sun-UltraSparc-IIIip`` and ``Sun-UltraSparc-IVp`` instead.
+
 CRIS CPU architecture (since 9.0)
 '''''''''''''''''''''''''''''''''
 
-- 
2.44.0


