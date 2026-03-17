Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68997F33820
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDS-0003ij-MW; Tue, 17 Mar 2026 04:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBc-0000Vq-0Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBZ-0004vW-2u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXUoNPZN5EV2zp3AGyiG/87i2Fj/dzAN818B1iCDWio=;
 b=TD4aC5DQD/nlxUDckcaSg/WTnosMCKdDsI5L5BK0lLr6xOye7g0l5LroFg1RCVemX7IvoC
 +POOdnhV6KwL9MN29fJDhuF6Cy9X97wTg1jGBsvkCrphxSrGuJc9zPPY35HphZxa9K75Ud
 u1VumIq3SV0D5aUmvfGAwlvOxxKWqR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-o5AE1slNPBS8g8-dpeCc8g-1; Tue,
 17 Mar 2026 04:53:54 -0400
X-MC-Unique: o5AE1slNPBS8g8-dpeCc8g-1
X-Mimecast-MFC-AGG-ID: o5AE1slNPBS8g8-dpeCc8g_1773737633
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B41A7180034E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A784119560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:47 +0400
Subject: [PATCH 33/60] ui/vgafont: add SPDX license header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-33-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qMWcNg5eH1Tz0uC8J8gSFxwxyHv0Vnd+i9HhHOYtORc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbtJnW5wfK+kp7bbYkuBsD+bRmg1FHYWyz+
 Re/onhV00SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5Q+SD/4uL/cq02gOW4Z3mbouWCg9ftkslkvOJezzkVx8MLODX+Gg79/BUQ+r50DoUA0gW6gpVtm
 DnJKTZ4uggy+goGP5+hhKegyaBlvTpxBpQwEbJ3Lhklu15/1OGphfEqZH55TZMUN9AKfbr8blNr
 3kRCl+35H0tJb3XZbGzyDbPLWiF0mZpp/AAhKtgz33kdQtJKMkl2k+Fe0cC7MAXCw5U9k56x2xv
 a4jvCHzSY/sIgd1B3y6ItZkNtd7PfoAXmN7r2qADTOlexy91UDsQgjXvdghSW8rYhfpdQX9AMjp
 7eTOSi6HCNCmvhy0CgxY12oX0qCQxLCE0D89ymxQqsj04EwzewADMmYaWNqi2DvY1eUa8XI/nd3
 vxzFc6UMskpC7DyVYrVRTo5gdpBz4RJoBRWJNdmMR5UM36PyM2KNYPl1zK7x0ZofzNA/YbnqGYp
 5R89t/gSW/xwwwcZOGKvkp15q2sncoKWTDeBMQmWJZMqVVC6AXvjbUQ4U1o0A9YrfsvKGhK3+70
 oOgnrCGPyG7weDNtVUn0K1GK+0Cf1asRGYj2flj/fmLSyawJrhZl/ZgVypcvATiuZV6mASIlbmI
 TyariJYHR7YLMHwxdrztd38ugrAanYOKoqAAQaqo22XNN0/lCyzvADSplswFQFScJKSiFKosRDg
 RIAmnidR5UrCnng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


