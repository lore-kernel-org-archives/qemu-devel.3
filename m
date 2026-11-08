Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F925606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKk4kubZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ9ft-0002gr-4p; Sun, 08 Nov 2026 15:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpaulma23@gmail.com>)
 id 1xQ8f4-0003oY-2y
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 14:34:42 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jpaulma23@gmail.com>)
 id 1xQ8f2-0004PY-O5
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 14:34:41 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-99c0c1d07feso119704241.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166479; x=1794771279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6KalWw/c+MMt99Z9wsOeaHPjtkI2/IYHXI11RjoarlM=;
 b=PKk4kubZKfKfchjnpkOQc64u359SaUcSWILTjqQvfBeDon1kaSkradVU4JuEEz+Xg2
 6hJMpAhr8CLrAZBW1dsbABIQO1XOOV6H2LHuf53iyFmHMX/7FzR2tTbtNvL0aGinKOL9
 sXSN4U/YPS4okkIP0IlHZyxeUqtWCqFMzYIubwT43RYaWUnpl80TJdTFg42kiXl/OtHV
 c3z2IpsNxYSBKJCncHCtmIPD+u0RyUtbYUU91VtBGcsXnsfGX1mQ3GsErHUBNclM39oT
 HEPPA4fPYvx+IgeB0e1xlVg/Azd7ovwhppmDyQ6GkGUUSXfbnca5qFPP1elo2SSkLT8X
 ZN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166479; x=1794771279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6KalWw/c+MMt99Z9wsOeaHPjtkI2/IYHXI11RjoarlM=;
 b=Ps5rNCJBj/088aPFfRsTLy2ccbX03kooewyJ77GOiq9GcBfQ8+yBMI/tEgx+C+O8Mi
 WXSAVh11drwf/4yMs+OX3nAgfHxus3ciywnFM8D7thQ9xlLtylfvxXd+iiBE/lrFAHGX
 00pjBjHD6X0CL26kuF3JpiVHevV/tnxdUlsvrGkHMpWfyZzODWkoKqnhMuruehiUnSIQ
 QTuY69wbAbmKlWECecCte6eJ1PqZpGEN/yXMrPKqetxXfsG0hQZqVGAMroBwbQn323EP
 Rgn8BH+A1uo85+3QAsU4RfbOlr689aWgNZzQn5xbddDMOqKkgAy+qSjh2tuiy/5qGQ38
 gaLg==
X-Gm-Message-State: APuU4Z+xUCh2866H0WZF7/gS2lG0BTNv6ypmKTR/uqbNlgmmqCKZBTDY
 12hE9QC76jcEgBdE4ITYxWdNBqXLRZYYfAwHO6siGmRehfcoDTSPbp+zw8HsGHzL
X-Gm-Gg: AYBFou2v78lglDbyzoAa38ly8WmY0+n327tm8/tVretkaKLHvYHqMgsiWOMEfNbQskO
 oLiP23SRg2NHvf09jp3N2o739z/M1U+gmUu+biAesvorP/Dw5zb6eAeVgt9eMEHQzW8UgifCIxn
 ZIvxcOg9Q+cpB71dQpdUTwkJaaCOZW+cW220OYtqDN9ZgiOaUo2ojHmOa+lZ2/Hr/20ZMeaz8yp
 sFOw/5DPZ0C9VUOcMcdj8rqYMj/asCEqePUWcgzMfsWB6ENdQsnI02OD6iSxQJfqt4xgdTxdKKK
 ZvqDRrljOibjt7rTmqKt7a97k5m8ojDS8UbZhe0SqxGqdagRxc7+cDDU2NclflolIwYm4fDcQ82
 4yxK7fw36pagjC5Zc6DBxTMIXNnUTgWaUwy0GeC0IcfrzSw/VV48hBSIIScpRfKtx7cng/2UBXa
 JptnKUk1fZgTVz1wpAjLmync3swmfgpvcizwNUJOcRym70ap+XpXhfALuxeKsVxAdLcxT+emNKW
 +yfMD0iGjP3RcBOO7CiXNPeLkBg2Y0IT5+KtqkXDe6aCOw2gxUnJtsacXyeo/Zf4NEQjGLXXY8E
 ZrtiSDv6n3rSUBdLyEwdg8sRWY8GrATMQ/t+
X-Received: by 2002:a05:6102:54ac:b0:7c3:1898:e8e2 with SMTP id
 ada2fe7eead31-7d2db169d6bmr609705137.13.1794166479412; 
 Sun, 08 Nov 2026 11:34:39 -0800 (PST)
Received: from jiputer-laptop.. ([2605:8d80:6c29:aa12:5c76:8909:6da4:b5f3])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d2db57903esm2304187137.3.2026.11.08.11.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:34:38 -0800 (PST)
From: jiputer <jpaulma23@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	sgarzare@redhat.com,
	jiputer <jpaulma23@gmail.com>
Subject: [PATCH] contrib/vhost-user-bridge/vhost-user-bridge: Convert calloc
 to g_new0
Date: Sun,  8 Nov 2026 14:34:33 -0500
Message-ID: <20261108193433.225841-1-jpaulma23@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=jpaulma23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:39:15 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the function, vubr_new, calloc was converted to g_new0.

Signed-off-by: jiputer <jpaulma23@gmail.com>
---

This patch belongs to this issue:
https://gitlab.com/qemu-project/qemu/-/work_items/1798

 contrib/vhost-user-bridge/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
index a6f7ec226c..e3b979b462 100644
--- a/contrib/vhost-user-bridge/vhost-user-bridge.c
+++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
@@ -540,7 +540,7 @@ vubr_accept_cb(int sock, void *ctx)
 static VubrDev *
 vubr_new(const char *path, bool client)
 {
-    VubrDev *dev = (VubrDev *) calloc(1, sizeof(VubrDev));
+    VubrDev *dev = g_new0(VubrDev, 1);
     struct sockaddr_un un;
     CallbackFunc cb;
     size_t len;
-- 
2.43.0


