Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E8CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs79-00057K-9Q; Wed, 17 Jun 2026 11:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs77-00056o-Rp
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs76-00042X-Hv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSjfDgNCiY45fveQ2h8VwKHwe+m8EahSQRaPM8gB4pM=;
 b=FHZ5s5OCPlM3iDvz0gHSDhxRio91rp6ORyTIaczYo3ZPwYH4TDS/aG/D1hD7OCaryuVbpe
 fasHAvi2UbkzgHN5EE1JdfAVvNkc87lCoEx00oC7fDmpOKFVTzi8aRcrnnG3xxyTp7B51G
 ETOaP1qJCb8Uf1jCZ3ujtVNC1p9HHX4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-WL-jo4UfPLu61Uo4zQjFGQ-1; Wed,
 17 Jun 2026 11:23:33 -0400
X-MC-Unique: WL-jo4UfPLu61Uo4zQjFGQ-1
X-Mimecast-MFC-AGG-ID: WL-jo4UfPLu61Uo4zQjFGQ_1781709812
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B23B195399E
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:23:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 112FB3008B3D; Wed, 17 Jun 2026 15:23:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:22:58 +0400
Subject: [GIT PULL 01/27] hmp-commands.hx: fix button_state doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-1-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IKyF0Qb3TuwUu8Bcrf8zMjPpRwd+JPEGfJAb0qTJfLI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvo+fXtF+xKiR75JawSjfwtSRRty4h/5rEyo
 NPKNPwWQm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5RWaEACC53Z7z2UxPJM1615yAfOC2tSbUF1oi/jcqhuF9XIUE73G4ZV0Cn7ELYY5/PNYkyiD3n9
 NLEWK+jIMkPv6a0RLbtQCbSO5uWPpH+IsXqAX9DJ5LvcVhNxcSX0VS/U/LJqniJCSQsLsFGGxPy
 v7nuRWaKgSkgyAus1dhTni3M3bJJW71KFRg2j9ufNlnDgpQ9AeFUPMT12ga/OOlZAdzKWsfnyB7
 WapZZlYteYgYzi7B8D3UVPKZrukHJp+PPezoNXo5Z1fvYyTDQWUeMUad6tTB5p1zIKVugvV2vCh
 gNA+IJDjJ9sagnVN+BfMNocvOXzyvggZPY84mlW7qHSwAJjaEtc/4qZddfbisSi+VhYzZHfTmbq
 WuvPACNjJzOxunQ9O47DjB4WxCg4TPQEcQ+7iWOqXM+9pEY8GJbwZkfwtADahm5UKs65gJ4s6tE
 AFR+7hUyqPAcpfB7P7R+VW+p0NfGvl1ij2Uw8Udjwyom6Rwqhzbq0d2zNS6u+/HNw4k2hgJVHdO
 /AI3eLG6KjqJ49Q45gd1C4GbHR9zeSxJrRJIrHN8UqHU11lAmfJq8Ht8Zv40VC5oY2sWOyNurvL
 u08uZ78UCRMZ7E4E+5ww1FyRfXXLebh1hnQLqpx300FIaXssRIYfKEdO1p2JpX0yxBPVCS2WGHK
 PCJUjxerEIELKZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


