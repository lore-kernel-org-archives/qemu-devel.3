Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6CAC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHmz-00012U-VA; Thu, 07 Mar 2024 12:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmn-0000pv-1O
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHml-0004CW-5Z
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709833442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmFIhMjY6vN/e6JPU/huc49Xuw5+OwAjhgtRJDKzpUY=;
 b=JBU26Oeqi3Kap5MAS12FXTVvk6OOLclLEjrf8eIym2Wzu6xjQ7XUiTlXhYJUYuXJwA+v5+
 1VvUtIgZjmE/XWb4p7PsHS0+wVwuBHKsSsOXrf6C91rl/MwwMOwu+L8Xh/ZK/87Xns9Ql4
 hHmaXE0OinnH6YI8Y4O55pNZObuY7JA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-9Ma0ZduvMFGO0v4TQsAh4A-1; Thu,
 07 Mar 2024 12:44:00 -0500
X-MC-Unique: 9Ma0ZduvMFGO0v4TQsAh4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8805C3C5CF24;
 Thu,  7 Mar 2024 17:43:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21121492BFC;
 Thu,  7 Mar 2024 17:43:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] docs/system/target-sparc: Improve the Sparc documentation
Date: Thu,  7 Mar 2024 18:43:33 +0100
Message-ID: <20240307174334.130407-5-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add some words about how to enable or disable boolean features,
and remove the note about a Linux kernel being available on the
QEMU website (they have been removed long ago already).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/target-sparc.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 9ec8c90c14..9f418b9d3e 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -27,6 +27,11 @@ architecture machines:
 The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
 Linux limits the number of usable CPUs to 4.
 
+The list of available CPUs can be viewed by starting QEMU with ``-cpu help``.
+Optional boolean features can be added with a "+" in front of the feature name,
+or disabled with a "-" in front of the name, for example
+``-cpu TI-SuperSparc-II,+float128``.
+
 QEMU emulates the following sun4m peripherals:
 
 -  IOMMU
@@ -55,8 +60,7 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
 is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
 compliant firmware.
 
-A sample Linux 2.6 series kernel and ram disk image are available on the
-QEMU web site. There are still issues with NetBSD and OpenBSD, but most
+There are still issues with NetBSD and OpenBSD, but most
 kernel versions work. Please note that currently older Solaris kernels
 don't work probably due to interface issues between OpenBIOS and
 Solaris.
-- 
2.44.0


