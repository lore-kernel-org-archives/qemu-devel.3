Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318DCE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdTX-0000ol-3b; Wed, 18 Feb 2026 04:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTR-0000lb-3z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTN-0008T7-Si
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqJqOaFBhQo9nD7FEbMCGjK4JwbAAf6+iYJVKsykfmQ=;
 b=N2+i+KhEheM2XjbQwChC2Uyac0HNwg/ZYIR5kVTHz/6Uhh/1c4KMZaviObWa8ViT/PNGt2
 y5k4fyilwuKdUQXdK9vWpFu9wUmYpPO4N1+WWNOdDFJjODMUWDBc/WxI3eoPoom0Hj2sGW
 +h3b9O0Me3Mq+XWs87kolgDS4f1Pvhg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-xDFImHPYPci8YE9JzIwV_A-1; Wed,
 18 Feb 2026 04:03:51 -0500
X-MC-Unique: xDFImHPYPci8YE9JzIwV_A-1
X-Mimecast-MFC-AGG-ID: xDFImHPYPci8YE9JzIwV_A_1771405430
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87BF51956094; Wed, 18 Feb 2026 09:03:50 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA89119560AD; Wed, 18 Feb 2026 09:03:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/85] qemu-options.hx: document -audiodev dbus
Date: Wed, 18 Feb 2026 10:02:06 +0100
Message-ID: <20260218090330.1476169-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Document the backend introduced in commit 739362d420 ("audio: add dbus
audio backend").

Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 15a6f82043a..4043e8ca22b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -991,6 +991,16 @@ SRST
     ``in|out.buffer-count=count``
         Sets the count of the buffers.
 
+``-audiodev dbus,id=id[,prop[=value][,...]]``
+    Creates a D-Bus backend. It must be associated with the display
+    (as ``-display dbus,audiodev=id``). (Since 7.0)
+
+    D-Bus specific options are:
+
+    ``nsamples``
+        Number of samples per read/write (default to 480, 10ms at 48kHz)
+        (Since 10.0)
+
 ``-audiodev dsound,id=id[,prop[=value][,...]]``
     Creates a backend using Microsoft's DirectSound. This backend is
     only available on Windows and only supports playback.
-- 
2.53.0


