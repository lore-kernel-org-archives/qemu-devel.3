Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F01EF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSk-0006oa-PI; Fri, 10 Apr 2026 15:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSi-0006o5-PM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSg-0002LX-7k
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpll6YX+O+2Ns3q47yqepmDMW6ivubkbADkky21Sx8Y=;
 b=i2wy4NBFTtw3rOHBMHJSDnjKmhagAXWeBvQKGHzpt/esP2fxZrhqiqF7XtBylqQ0aCT1Pk
 BV6osB3Fcinfypx2ps1axuoZQtlnyLL/Htmv7f2BMJt1gW24xWJ4gAtXsKilHEqsRwTmqd
 E4+vrfkrTqJvoE65DRZPDVg1SuBu93k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-4DV-SAq9OfmPcUsYZt-iFw-1; Fri,
 10 Apr 2026 15:24:12 -0400
X-MC-Unique: 4DV-SAq9OfmPcUsYZt-iFw-1
X-Mimecast-MFC-AGG-ID: 4DV-SAq9OfmPcUsYZt-iFw_1775849050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 740FD19560AA
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:24:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56E121800357; Fri, 10 Apr 2026 19:24:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:15 +0400
Subject: [PATCH v2 53/67] ui/vnc: remove left-over dead code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-53-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CqHLiX8tGa6Hx6kmExwugSms02HGkuRScDrfwgow37M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WqDRv0gPu6MpPVpnIxCrJsCnGRhCgr5KZj
 WJDiWUefXKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5cj7D/0WEpZ7YbKdUdieoIzmiphxic55Bb4GtFZXjf35GLXdtjEGW/tkP/q8saTvdb3D6Nik+fi
 1nhu5PjY/R2kgasGPTEWw8eOd2tnVr220th6acGdsYMk+O7DQXxiHScZVtyO6yHit805A1REWHt
 5/U+E4/WIfDoYBjSQieRqV2aTXM1CUNeilASkySJkn/3j8V45BuldgTF1qQecUgfX5/iKOelTL3
 d9A8yNoXLdu5DI9f/I0bOnpwoJZDtz/MVgem0zb2yN/Zw+yrv7U8DNsPiWhjIW8/Wutwlf3LGvo
 LUxHGGPaF7HqlCVZOpWKm+i8SenXfyTD9KLuSpyGAW7UonlYV7QE5bbmF7fu7hDQt6lX+lfyoRK
 6wRP71gh5B+K8rIKR9/2AmPrvscF3DST3u87ls7WOXiZttqyhBdSf42WWFI2m7yAn1pIYb8ZGMF
 rK9pZCHAlBJQKS9Xse3o3DuBUeeUIrydKdTh3iKQcldIswCjaE93lT1SndzV2jDivC9zmVwhzRV
 iXzyUmnfHAckbMZt52ORc/GBehJGeolfsUJoyt91h1Cyi9XTPn2UvSqnQAxdHBrGIMpTY7zMX1B
 dbB/+3ZLhzvly3d+U1fcTAea3w4c4UoP7PGjY+TsB95TphY0+5PebqWIH0vEAYNp6XJZLYtl26R
 AcgiXY+CLGcHUiQ==
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

Since commit 5994dcb8d85 ("ui, monitor: remove deprecated VNC ACL option
and HMP commands"), this field is no longer used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 1 -
 ui/vnc.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 794341265b3..993ec022e52 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -180,7 +180,6 @@ struct VncDisplay
     bool non_adaptive;
     bool power_control;
     QCryptoTLSCreds *tlscreds;
-    QAuthZ *tlsauthz;
     char *tlsauthzid;
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
diff --git a/ui/vnc.c b/ui/vnc.c
index 6fef80e98c4..e7ec1fb7f68 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3493,10 +3493,6 @@ static void vnc_display_close(VncDisplay *vd)
         object_unref(OBJECT(vd->tlscreds));
         vd->tlscreds = NULL;
     }
-    if (vd->tlsauthz) {
-        object_unparent(OBJECT(vd->tlsauthz));
-        vd->tlsauthz = NULL;
-    }
     g_free(vd->tlsauthzid);
     vd->tlsauthzid = NULL;
     if (vd->lock_key_sync) {

-- 
2.53.0


