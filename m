Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03565CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGcj-00020G-02; Wed, 10 Jun 2026 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGch-0001zk-M8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGcg-00031F-62
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+A3CjySeWiUBIwx/5Ejy0I8M65/hPwoFqdYUDVzQ5AU=;
 b=f7LyH9QBvBiWl3DLtDfCQfSszociBdgJGWOs6MHmUIGIQHTcCKPboZnkG8I82WRTF7lZzR
 qlXmSDDg/4U2lPRvtZ96GSiMQO6oDU5pTIxU2wXuMZkvvFPDZmxPr1IJTmiZ7zSOvUKyHv
 IDuQ6jpmkb32uxM5ZjDE+viqRSobegk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-MRtjLSlYNm6iqjJeGSlo-A-1; Wed,
 10 Jun 2026 06:57:22 -0400
X-MC-Unique: MRtjLSlYNm6iqjJeGSlo-A-1
X-Mimecast-MFC-AGG-ID: MRtjLSlYNm6iqjJeGSlo-A_1781089040
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DCBC19540D4; Wed, 10 Jun 2026 10:57:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEAD1195410A; Wed, 10 Jun 2026 10:57:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:43 +0400
Subject: [PATCH v2 01/22] hmp-commands.hx: fix button_state doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-1-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qQ/BvHJ5VIbWedapc4EUIeb1zU6j8azH3TstM5me0hI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL+ZuSzqzCnm+/y3ZZkssHILLqT6oDwd49ZH
 iTipKTTEv+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/gAKCRDa6OEJdZac
 5VitD/0SO6Fy5beLMKI299G1FQlHLJajEEzCLAb6uDvE6HKKwtbtv2MbKWeoAGD9AH0aQVp/ofH
 WhqBhDSprUOOPR9jFbaeNdbKqGianfZj5DttDnb29mRhMtoVC9PVZaP6IySRH+lRlodkfYIab/q
 +lAWq9CJrikI+PE8/nUuGAK7WclrfK7UNqNWxVo2r3OzJB/N8a0kM5+UORzAHuSgqXzZCyw8GFF
 NYFs8gz4qiPl+WT8mfj09ys+xpSR9Pe4uZGHjsg9pzaAx+AYgdwmKNX0iRKjdMTAgMimecxLV4L
 1vJMHAOeswK8u0N0+GTMnOsYCEbVX8ztgOGHo7/ZiGe6PnyMz+mDiEliUH7WWyvKIL4QUwAOSrO
 64J3YRwusXtmARmtdvG3vp44GYBlH1pIcMZ6Lb6bRr7is4pPWODMXwXKI+OTN4ssB6WTgf3ZMdO
 dFryVdy6sT1CHspSX4ipa/kPpubl+fL1XN03vywaA/1Z+asFMOXZo9jaQfVVAlsU5bcom3dM+AZ
 meRBKoiqGbvjlQngTX1WnV3YEMR5ai8jAMhWwY1nNmJmiPkXoVQRz/kw/Rc1/5knex+D8ez4Hrn
 Erc1Xx/zQrOr25LL+auAJfAcr76n8s/jKooXTLSocmOUn8/0H1bq8EfT9kCiNA9xKhFd+ZNdtt/
 Dt7BcKQlg9Lo6xA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
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


