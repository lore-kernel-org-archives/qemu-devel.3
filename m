Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEDAC05052
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjv2-0002eq-34; Fri, 19 Apr 2024 04:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjv0-0002eQ-ST
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjuz-0007YT-7n
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713516504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjHqJKJAYlMpX924z0U0Cp6GUUtCDMf6NG/thlD52Gs=;
 b=G5scpgKDEhMxs+livqcw2JzqzURdi4H4RzLTVlfVB3WJsFiSvg09bcjv7R675unw3hlYKl
 qa+4bm/ZQGm5KlN+cg5UfZayhlXfRaixRxG7LOdj1n9FT0lOs1QF5e9W0veeoR4BaAZmN4
 syt7ij6ClNsxddxLqivFGLawDa7PJEc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329--HGkZNnrNKyleWJhZL8N0Q-1; Fri,
 19 Apr 2024 04:48:22 -0400
X-MC-Unique: -HGkZNnrNKyleWJhZL8N0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69B603C02B6E;
 Fri, 19 Apr 2024 08:48:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D981D1121306;
 Fri, 19 Apr 2024 08:48:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 3/4] docs/system/target-sparc: Improve the Sparc
 documentation
Date: Fri, 19 Apr 2024 10:48:11 +0200
Message-ID: <20240419084812.504779-4-thuth@redhat.com>
In-Reply-To: <20240419084812.504779-1-thuth@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Add some words about how to enable or disable boolean features,
and remove the note about a Linux kernel being available on the
QEMU website (they have been removed long ago already), and the
note about NetBSD and OpenBSD still having issues (they should
work fine nowadays).

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2141
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/target-sparc.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 9ec8c90c14..54bd8b6ead 100644
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
@@ -55,8 +60,5 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
 is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
 compliant firmware.
 
-A sample Linux 2.6 series kernel and ram disk image are available on the
-QEMU web site. There are still issues with NetBSD and OpenBSD, but most
-kernel versions work. Please note that currently older Solaris kernels
-don't work probably due to interface issues between OpenBIOS and
-Solaris.
+Please note that currently older Solaris kernels don't work probably due
+to interface issues between OpenBIOS and Solaris.
-- 
2.44.0


