Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB000FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHVf0-0004NK-SO; Mon, 27 Apr 2026 19:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.fast2004@gmail.com>)
 id 1wHUcE-0003GB-3g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 18:39:46 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luc.fast2004@gmail.com>)
 id 1wHUcB-0003qW-Pe
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 18:39:45 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7986e538decso107286227b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777329579; x=1777934379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QR/8CAv1yHVvho2HJOnICwYccKH8BL0Tjx0osxNOLnc=;
 b=qDkOV5+eSRanDfH7+5qntBRptFwQQPMkWzWyJvmxyJBxl7q1regxb1TLKwWsmbIJy/
 /iI9EJ42aOnCxhF4vTMLsO46n2cCRFGRcDaQiuX5LU9YVx270nZDZGVWW11SfkYIQwfh
 QJGgssr1i8p0/eQ/wVwCl/VAM4GwUBIZo/rktCKcNCV2MmkWNcruAt+/WNF5Dgrg2e/r
 wzcaAWcBxe/HiJ6lwdQpJvKxyhCE99rtHvi47inWi05ihbG7HLcpmx9QIHSLiV8XhZTG
 2iYCSrPH0CyQhKRwePRT1mJLtC3+2gkwEsWD+oyvRr3J8WJb+zTMBdy4KdK+DvHbTyI3
 1z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777329579; x=1777934379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QR/8CAv1yHVvho2HJOnICwYccKH8BL0Tjx0osxNOLnc=;
 b=M0YP7KGY6E/45RiaTFP0jKUE/1d5JiOSB8AgN/l8jX2xxCK4y4a7N1rGiWYckkHcj9
 u4o+5RlOGxA0q+RqjGrynyPSC11SRWSvIM09KG2KCx3otgbMlvXH2a/JXbrcN+LsUoNL
 7xIbKhIePgoijXSwoM3BBRVT6oe4oitLNdWIuCFZ0HAY58HpXTtwiM1YTgOQihMl+Hry
 TTWyrhyETh6VjkJzBjZcE3HNPL3wZKWOOkWanzkTAGSe/CU972XmIPF/Jb80jvMbXinc
 nwXHmw8qRFgLhD5BKDgnb0yUBLYKC8/6ymwxx7DEErDnBIYCPwUuc0chkSU2JRl+HJqJ
 ga7w==
X-Gm-Message-State: AOJu0Yx2aVFsBTS7g5/VOO2WxqgDPJMSHM6XZmMgdLDHiopOdILDD6mX
 YwPyVuovEToV8qgA8jJ//GgmRvmvEDdQ6ARl1wO1U//AHDtA2N4UkT9DNo6r1iG6
X-Gm-Gg: AeBDiestqvAHIReCceY4JXsDmgtEnckDka+5/AvcTvxD+U9OlYb8ZL754i50LghLvhy
 HUqw+AFQDcnWc06DTynbV0edp51gpOPYuHwDSEMQhYqP3aJ6IiDXk3QoKxs42GJQjUWxjyKtr/9
 5RReNwlG/ZvG3QP54xORiUaF3j4r6JxtXryxsrT5bu1AGlWSUY3WW+zJLtSNm9FbyH/M5A3Ha7m
 DZGAH0ithRtrXWehTCnIRNXbNFcm9SR5OULVmrt3vpdquw0ZpkVnqAy0h+TJiKGHZsGYIe42YNS
 Axbvw6xszViRCDhh23a37WY+rmUQu/Ezrc75rGLFqwkAzLvsLA8SH3QHTmAIb/lmTbTPGKt0SMA
 GKazheuKKPtsUYPWl55Sj5psL+XZslesdUVsqWzzcqC0dD7clSTLyfE1SziM8tYzGdhvQOSbjZj
 APTeQ33fQ2kZY7qTpGXqDt4djGSiILIzDKCrHNLi9E1CWxhs4hkA==
X-Received: by 2002:a05:690c:3586:b0:7bb:eaf:5101 with SMTP id
 00721157ae682-7bcf51f5d10mr6026207b3.16.1777329579070; 
 Mon, 27 Apr 2026 15:39:39 -0700 (PDT)
Received: from lucas-Vivobook-S14 ([2804:14d:8084:8f4b:f361:41cb:cdbc:1fa5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bcf0d46735sm3890237b3.49.2026.04.27.15.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 15:39:38 -0700 (PDT)
From: Lucas Cardoso <luc.fast2004@gmail.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org,
 Lucas Cardoso <luc.fast2004@gmail.com>
Subject: [PATCH] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
Date: Mon, 27 Apr 2026 19:39:28 -0300
Message-ID: <20260427223928.2742270-1-luc.fast2004@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=luc.fast2004@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Apr 2026 19:46:40 -0400
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

In accordance with QEMU's coding style guidelines, replace raw memory
allocation functions (malloc/free) with their GLib equivalents
(g_new/g_malloc0/g_free).

Also removes the old generic error-handling code from
OPLOpenTable(), since the Glib functions abort the program automatically
if memory is exhausted.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1798
Signed-off-by: Lucas Cardoso <luc.fast2004@gmail.com>
---
 hw/audio/fmopl.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..aeefc4c9fe 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -607,26 +607,10 @@ static int OPLOpenTable( void )
 	double pom;
 
 	/* allocate dynamic tables */
-	if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
-		return 0;
-	if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
-	{
-		free(TL_TABLE);
-		return 0;
-	}
-	if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
-	{
-		free(TL_TABLE);
-		free(SIN_TABLE);
-		return 0;
-	}
-	if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
-	{
-		free(TL_TABLE);
-		free(SIN_TABLE);
-		free(AMS_TABLE);
-		return 0;
-	}
+    TL_TABLE = g_new(int32_t, TL_MAX * 2);
+    SIN_TABLE = g_new(int32_t *, SIN_ENT * 4);
+    AMS_TABLE = g_new(int32_t, AMS_ENT * 2);
+    VIB_TABLE = g_new(int32_t, VIB_ENT * 2);
     ENV_CURVE = g_new(int32_t, 2 * EG_ENT + 1);
 	/* make total level table */
 	for (t = 0;t < EG_ENT-1 ;t++){
@@ -696,10 +680,10 @@ static int OPLOpenTable( void )
 static void OPLCloseTable( void )
 {
     g_free(ENV_CURVE);
-	free(TL_TABLE);
-	free(SIN_TABLE);
-	free(AMS_TABLE);
-	free(VIB_TABLE);
+    g_free(TL_TABLE);
+    g_free(SIN_TABLE);
+    g_free(AMS_TABLE);
+    g_free(VIB_TABLE);
 }
 
 /* CSM Key Control */
@@ -1081,11 +1065,8 @@ FM_OPL *OPLCreate(int clock, int rate)
 	/* allocate OPL state space */
 	state_size  = sizeof(FM_OPL);
 	state_size += sizeof(OPL_CH)*max_ch;
-	/* allocate memory block */
-	ptr = malloc(state_size);
-	if(ptr==NULL) return NULL;
-	/* clear */
-	memset(ptr,0,state_size);
+    /* allocate memory block and zero-initialize */
+    ptr = g_malloc0(state_size);
 	OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
 	OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
 	/* set channel state pointer */
@@ -1128,7 +1109,7 @@ void OPLDestroy(FM_OPL *OPL)
 	}
 #endif
 	OPL_UnLockTable();
-	free(OPL);
+    g_free(OPL);
 }
 
 /* ----------  Option handlers ----------       */
-- 
2.51.0


