Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B282CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxXa-0000un-BN; Tue, 09 Jun 2026 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXY-0000u0-LS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXX-0006f8-2T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J05f+bE9SwoDxfDDfEZA9+fpURVNCN5SQ3H6FwQT3Os=;
 b=CdvgKH4O1fvEGtKvhIrEgVXhLdFUqRtcrj6z+GcCMsK5PP+PzyESJNtG4yLEIdkATkp7Z5
 mMiueqC6EZW6uYOzuvMOPhVPE45dl5PUh13JmlNs47fcze8i3wzf5MLtrBg7rhxIBXUHwC
 +FcLWvPhF9BW+6Gsao5sOSWdF+KJvJQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-Ti1uM9bhOWuZxux6vL-2VA-1; Tue,
 09 Jun 2026 10:34:49 -0400
X-MC-Unique: Ti1uM9bhOWuZxux6vL-2VA-1
X-Mimecast-MFC-AGG-ID: Ti1uM9bhOWuZxux6vL-2VA_1781015688
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F0DD195DE70; Tue,  9 Jun 2026 14:34:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7CB81954102; Tue,  9 Jun 2026 14:34:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:20 +0400
Subject: [PATCH 01/17] hmp-commands.hx: fix button_state doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-1-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V64EOjBSOTAn1sUIaQNU77xWo/UlHxIn8zY8KgAhomk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR2amQct5/efasTzGej1QRa5b4WZDxG1dbB/
 ztIGnIJ8vmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkdgAKCRDa6OEJdZac
 5aJ7EACKpNV/ne7Rye1CsvbWOZPih1ag/hzCA4BlXcoJrifRiStCD7Kuh3ouclQyauaeZO+YDXw
 arET5rItSIenr5nh7JUkyVFyncl/hqhcfTVVOqRjmUzb//5MkNpzmZ4LSecZ+hthp6dSYmPETR5
 vKPNy7WAWJpOQf+2B2vIpbE2GcSMANi9ytNAh64hdFDpcFJzAW4tPszLrzov4nhs5mxkBav0Mwr
 DU6cIcRXi5tl1fBudk7HC1dThpZxB+Ci76VhLq72CBAMD+I6wNvuiQrKJEzZc+gIQv8cS1Q308Z
 6zkN8uJ30BD4lh8bOnDt8bxCxz/3H0YVxWdv0sBNqG9JRUtffl2nQm9vXp46yVSnASc9kh6U5sX
 3kVJMQ60L2KcPczE6FxXSCL94KIFtRfCS7ewycun6wzqrrd6srDI90pMDcbxePzx5i0SZRWwGxw
 yzVeOp8r23Ye7ehw3rOQEGcQ+D+VODmA5RILgO+cr4sMVPqBKUgzsHZgeWeHqBC8VW9DaoQb6Jh
 63NpKDhQrL0RR0mteLNoH2MGajXwA+GVaq4weXS1JNksYG39v4diZL4vvy8FrDXEXIOT1+2EFSE
 SacgpPAudd+JI+gkklHa8G6NoYdm5zxaOVrWeRD0CspYBRpzGnY+WSyxzJuQxKeGiAncdr3Q8p3
 Wl8ikmEU80I8XAw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Right & middle buttons are inverted (see hmp_mouse_button)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0d780e6da30..7ae2468a3d9 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -752,13 +752,13 @@ ERST
         .name       = "mouse_button",
         .args_type  = "button_state:i",
         .params     = "state",
-        .help       = "change mouse button state (1=L, 2=M, 4=R)",
+        .help       = "change mouse button state (1=L, 2=R, 4=M)",
         .cmd        = hmp_mouse_button,
     },
 
 SRST
 ``mouse_button`` *val*
-  Change the active mouse button state *val* (1=L, 2=M, 4=R).
+  Change the active mouse button state *val* (1=L, 2=R, 4=M).
 ERST
 
     {

-- 
2.54.0


