Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098EEF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQg-0003LV-RD; Fri, 10 Apr 2026 15:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQf-0003GP-P9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQe-0001sw-5M
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSGT99OkgCW307lrXTHvv+Q92/CHkGWCji9vCq1Sp1k=;
 b=JaUl5+ffRB0+jOuL7vU0/O6fiwe0XQck2x42nCyAGkE++hgvSXMnbV1yk6JkdU0A6MPbnr
 A7Z+i5SnecQg86ydF1tJcz3Bgw88irjUxG8YTfSmp40lPtkAc6C/DS3B57Udc2Va0TLpaU
 srzGSVgVg5p2Ol+lNTNbV2fsNzBTXxU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-tGH2mWS_MbysZAyB2-ib0A-1; Fri,
 10 Apr 2026 15:22:04 -0400
X-MC-Unique: tGH2mWS_MbysZAyB2-ib0A-1
X-Mimecast-MFC-AGG-ID: tGH2mWS_MbysZAyB2-ib0A_1775848923
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46B561956061; Fri, 10 Apr 2026 19:22:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 108B83000C16; Fri, 10 Apr 2026 19:22:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:53 +0400
Subject: [PATCH v2 31/67] ui/vgafont: add SPDX license header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-31-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabrice Bellard <fabrice@bellard.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UfWToAw+HREaYvavb2Mrm2wywGGo+qgGY+lv2y9kkzg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VX9RV6q3H+VA/ln5FFldU0eEbEnzPdSL1h
 m0rGylh62qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5TJyEACIP15j01ci48x1HD7oXmRRvvoc6SICahQ79SRyF8xzqk4gJfpaS4bHHv7v2119OOl9Pbf
 v0qK5nCwOv8sfTqkp1biQsc1DTDK4uijHzymWvOZ658cR/hljqmlyWUa6n7Xx+i0KyoJ8HwB0kL
 8SM05o92oQxwQuulX7DO9tZCuEWD3tXiZBKgfy4Fc7VFh836s0T1OBV5r0CwQe9uOSh+0CJmNKN
 U/+AQ1NioGBZBPB5Fdp/XTrxoHBfmqboJl4qI+RjfjR0ru6Bg2snGPkNpzJ3HKRkqtIJICrHWiN
 /e8ENF0pzGm4OYbnYs9eu25Ef9s2nqeyXsYCxZP15y6idXSpAk5amzHRBu9v7HicFW1FDxyKrdc
 k9I7ovsN4FwFjCfWROvlyb79FPQ+M2WZJ30vLJAJufyPX1RfCO54pNThzK1tFlXz+nZhkONO5l+
 UmcFOj/ZEB3qk2VP9CsEoB3q/kcP3kqW/sEgNc/p3AKUi7Uv+U5ufOEzlcy8h1D3PiOHjAW5Kwg
 7teUZK4Skqq8+FSXSVGy8eAiceDPdpi6aMqmkh+pfS7+aV34+V+LC4DzeyPHeEYuB6AlSddG7vQ
 cdI7BUoN/HBC/cFO0+USfl7fxaNwkt6as8FxMuUIoUzV88JOMULHQKGHcC/oAcgYCUk3S1hE0Dy
 dEshHniVQgeMi+w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The vgafont was added without source origin, but it can be traced back
to Linux kernel, which used
GPL-2 (https://github.com/mpe/linux-fullhistory/blob/master/lib/fonts/font_8x16.c).

commit c6f37d0e4feeb264a699eda289d3cc69405100b0
Author: Fabrice Bellard <fabrice@bellard.org>
Date:   Wed Jul 14 17:39:50 2004 +0000

    virtual console

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vgafont.h | 3 +++
 ui/vgafont.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/ui/vgafont.h b/ui/vgafont.h
index 4498ac4e07b..54aeeb7d192 100644
--- a/ui/vgafont.h
+++ b/ui/vgafont.h
@@ -1,3 +1,6 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #ifndef VGAFONT_H
 #define VGAFONT_H
 
diff --git a/ui/vgafont.c b/ui/vgafont.c
index 708c845a6bf..b9b9a7016f0 100644
--- a/ui/vgafont.c
+++ b/ui/vgafont.c
@@ -1,3 +1,6 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #include "vgafont.h"
 
 const uint8_t vgafont16[256 * 16] = {

-- 
2.53.0


