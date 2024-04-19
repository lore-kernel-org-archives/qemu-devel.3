Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B45AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjvD-0002gO-AS; Fri, 19 Apr 2024 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjv6-0002fS-Ae
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjv3-0007ZC-Sm
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713516509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kHEYBckbAZWVsxVOv9Z20aD6o0POU9kFay7g0bMsXY=;
 b=EXSCnurc/4GYCaBYl8j96vtkiHbsRBRXkehGGdU5onfmSsxmsWxW0oOP9qo8yxcrs73uCY
 X9/1zovHEdZ+oMYS9ddF8Yd0vBpOv5qKpfvyWKpim7T3jAg5SVwKck2QAph7/p4znEn0FW
 gqV+hzDqRW+2Ks5pQONAbi9dRW2tHMQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-k_ExXMzVMBSZH_x6cekDsw-1; Fri,
 19 Apr 2024 04:48:25 -0400
X-MC-Unique: k_ExXMzVMBSZH_x6cekDsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDF2E380670D;
 Fri, 19 Apr 2024 08:48:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADCCF1121306;
 Fri, 19 Apr 2024 08:48:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 4/4] docs/about: Deprecate the old "UltraSparc" CPU names
 that contain a "+"
Date: Fri, 19 Apr 2024 10:48:12 +0200
Message-ID: <20240419084812.504779-5-thuth@redhat.com>
In-Reply-To: <20240419084812.504779-1-thuth@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For consistency we should drop the names with a "+" in it in the
long run.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6b932961bc..70026c3c11 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -206,6 +206,15 @@ in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
 an alias, but for consistency these will get removed in a future
 release, too. Use ``power5p_v2.1`` and ``power7p_v2.1`` instead.
 
+``Sun-UltraSparc-IIIi+`` and ``Sun-UltraSparc-IV+`` CPU names (since 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The character "+" in device (and thus also CPU) names is not allowed
+in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
+``Sun-UltraSparc-IV+`` are currently still supported via a workaround,
+but for consistency these will get removed in a future release, too.
+Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
+
 CRIS CPU architecture (since 9.0)
 '''''''''''''''''''''''''''''''''
 
-- 
2.44.0


