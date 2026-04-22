Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04651F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4b-0003xt-Kt; Wed, 22 Apr 2026 06:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4Z-0003lQ-Nb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4Y-0003Qz-3W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30wKoTw0eS9rMYTfd9ysK/qPScw7v7+PEpE6b6P9DFY=;
 b=Zpo4mdWXf7czrEThyrMtoT4xsp8UaR46BlXx0/aSzGBcKrYUq/HnM10GgQmtNur4ntA26l
 GqRbLwLd80RHGeY+RqvxVtnWpiQOrWgjFcxZRQIvBFBCGAuiPWWOVYi/+EWI8F/iFbOUcg
 41jswPsBtgdUnCsF4ajzjQqMoAyUzyM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-QoM8He3nNMi64ubjST1mUA-1; Wed,
 22 Apr 2026 06:44:44 -0400
X-MC-Unique: QoM8He3nNMi64ubjST1mUA-1
X-Mimecast-MFC-AGG-ID: QoM8He3nNMi64ubjST1mUA_1776854683
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 853231800367; Wed, 22 Apr 2026 10:44:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E155180047F; Wed, 22 Apr 2026 10:44:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 38/40] ui/vnc: remove left-over dead code
Date: Wed, 22 Apr 2026 14:40:39 +0400
Message-ID: <20260422104042.3936506-39-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commit 5994dcb8d85 ("ui, monitor: remove deprecated VNC ACL option
and HMP commands"), this field is no longer used.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 1 -
 ui/vnc.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 110c2bd4600..472a55f7b5f 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -178,7 +178,6 @@ struct VncDisplay
     bool non_adaptive;
     bool power_control;
     QCryptoTLSCreds *tlscreds;
-    QAuthZ *tlsauthz;
     char *tlsauthzid;
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
diff --git a/ui/vnc.c b/ui/vnc.c
index 947ebd89471..ad8d58a23d7 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3491,10 +3491,6 @@ static void vnc_display_close(VncDisplay *vd)
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


