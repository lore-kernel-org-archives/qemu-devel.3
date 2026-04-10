Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9198F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHOg-00043f-Rq; Fri, 10 Apr 2026 15:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOg-0003yt-1a
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOc-0000rO-TQ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXrhTuQ3t10ZXdWYsa32uGbpBKnwKNjPxFVhMgq4Awc=;
 b=S63mqq5T5c5muSHYfyymYzCRqEJJu5nd979AUFKhe2DMZsquYGkJ4SJp3RgFQ6TZHZC7dI
 3u19Dz5rqfEYwSJhAtb1mijr1+5UIQhdbKVhl7o0CLgTIcjH6iZ3XNZILmCoF16dbabFPZ
 PMwK8bGHGLj7la4r6+kc8oKS/Hy2Vc0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-_z6XIPJVOROCuSKrEQVINA-1; Fri,
 10 Apr 2026 15:20:00 -0400
X-MC-Unique: _z6XIPJVOROCuSKrEQVINA-1
X-Mimecast-MFC-AGG-ID: _z6XIPJVOROCuSKrEQVINA_1775848800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E65A61955DE3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 930E6180057E; Fri, 10 Apr 2026 19:19:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:33 +0400
Subject: [PATCH v2 11/67] ui/console-vc: fix comment shift-out/in comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-11-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=958;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kh0P9x+noWu4Ywj5nXZfasH2un/SYGYaOt5dLCPeL0o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UHLhNwOECcaML/lGcjd4GYMQGLoa2IgQ57
 qZdRC/wkWeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5ZPRD/0Xf2fPnoG7czj9LmtxZC/oUWijyLam90b+yY2ICBzBX5zgRUs6cRjKOumhElF/g2haKlE
 1ty0Od3LobC6DtPoo3Z91O+IfEuMZaBTkhdWRADnGjdz8XycoHDX73+FFXEos8RdLW0qCyF1Wqz
 lWzR4O2SogKx2UsJmeAitd1LEAg05sZki0+ZYYoHPFdQOMrQxEZMAG/8vQh7qROPzCzsNYtNfZz
 7UfIDPRrPEpFwwj9UlqT/ZKXoD1WBmvG7qhVKQTPIFIBpVUWpsde+wVV9gm+Bh638mPpx2giZ6I
 scku/5eT42eriKNdnAlcHyo1i/i5qlLJX8mhgSvT5HpNVtltfGVM9AKIHJRIb/CUqiWHYHEvpl8
 oRiSomOhJRkqhCyeUfxI66tKm6FeKd2pCiBfe4+G4pC8BUMueLKVASCQLYo/AG66AAPYogCMmJ4
 oaEidRV0p6UhvtULdisjGZdZ/CwiSD17LipreoUEPD/IPUG0jbIvYD28bfxENPNAcOuIAseelBp
 McK2XHPzwN0ZELxEe77HwFkVCnHNnX+95X4rRE6GpfTvH3fdyhK+AjdtJwNeCUqV8HnQ6HyYmPt
 UEW3eNnLtSQcosRYD4LZSChuakflqphg9oHR5DbCQ/wVGpPzyS/OoIigSXouIl2NtSJDn6vk3Ns
 1a86zURUFNPtcOw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

14 is shift-out
15 is shift-in

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index f1d38ee8ada..bd816d45759 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -846,10 +846,10 @@ static void vc_putchar(VCChardev *vc, int ch)
             /* TODO: has to be implemented */
             break;
         case 14:
-            /* SI (shift in), character set 0 (ignored) */
+            /* SO (shift out), character set 1 (ignored) */
             break;
         case 15:
-            /* SO (shift out), character set 1 (ignored) */
+            /* SI (shift in), character set 0 (ignored) */
             break;
         case 27:    /* esc (introducing an escape sequence) */
             vc->state = TTY_STATE_ESC;

-- 
2.53.0


