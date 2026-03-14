Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12130D58B21
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 12:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1kuj-0002qT-VG; Sun, 15 Mar 2026 08:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raghavendraaadhya@gmail.com>)
 id 1w1hN7-0008Q1-47
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 05:02:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raghavendraaadhya@gmail.com>)
 id 1w1hN5-0006Si-FI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 05:02:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso1987433b3a.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773565369; x=1774170169; darn=nongnu.org;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLi4fHtc94ZOaV2+k4cXgPZo2Q77amdrgeIWUHhmgh4=;
 b=K2oz8BZHde+7gDR9CN+HvSca7rLpRqT0m4cpxoCDuBtQV/8PFMQQ4V+mwz362wEXb5
 Cmuf8grOLI2jNxpPM6YDzo/KSYwXNHyNUeHqp3l2D0zxURs65HF9HicT/2Qdf0uD/xvr
 PVgZk33/SZjp6yndGyxHanpjyx6zx9GL6JzQzHQ2D4+bsjuY515J+l71Nm9/xtQOV2XK
 Jhj5VIUvVK4WlKVxc3dvIJsZ5+ksVnEXpN+He7WHj8ozPdAJ5lJ2oMYWeO+90BzgtTco
 vYXUVhe1m1IPHShZz2bZ7YelTri/oisyJeQUlF/e2JWzNZROm7YgIAjw8+6k1Ub3HMID
 POAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773565369; x=1774170169;
 h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xLi4fHtc94ZOaV2+k4cXgPZo2Q77amdrgeIWUHhmgh4=;
 b=aJilIa7auRoKs48C0a+aV3CFlSdPFSaYXBEc5aX1OmaootHcDBR37f5o23t6ww+zG7
 qD7uPgNJHjtdisUXOLzGKOrLAvNhModyf0QNd+lLP+rDpWZ409A1+Q/zjy9GVUUe0EAk
 tyRiweHL62u+7/qgLgSjfA5E2jLSqd5s917/UvYLo9OcK3e0CfuzBmMek5e071RtDpR2
 LlI7fKnurz2diWxH6I66IiIIHkOEvKidfACTFjVP6r06BuYjH+mbEp/T/BRt4YYwhp4/
 XaH6flBvZR8HGgnfWiAGib7Kth3sOvaCPr1FYhPuVVfuWLA3P8KZOsoawPm25S5PrOPp
 jbgg==
X-Gm-Message-State: AOJu0Yx78H7bskIhwz/SWfroNLsIYawht4FMX9W7NeMZz58HmJtECUUg
 4/MdId6sVfR6DYgSDu8/5gKpTrmQhn511QZHvWG8WRDSGf92rljtvbwn
X-Gm-Gg: ATEYQzzZ7ZD7WAjpB6Urbmq1f+rQRBUilg9TK2L5Q9yCLHKeU6ZvNtovNINinig8Wl5
 1FIvFhQdRgNFc0oKPQbPl2+4seGT7mj+aCSjbFfmZsptv8FreR0lT616IyevlYv2a2uspGxBrZi
 8rVWyhytQvOwCvXpxX9n71yG9tj8bVvnjOCYrSoisQV082Wf46Ie7NLv9DA+f5xIjhQX+Z6X8iD
 mY9KxLANDmh6gigN3M7prSJDVO+/ll8yBcKol2IdZAzPRLrfYpBBHKZnweIq2mzPaja88Q5sDwy
 rvUf5ZOJwg+zPozvZqxIXOQ0GHgwH329Q9aNaAJU3pC5uEP3Xlsuox1FridWQJY55HjD0RoA6vR
 kP73k09y2XQqjJNhWdVKxpM92pH/acuikhPC9abvMHtbQ5/AbinOrjlUP4+YmviFiKvW9YOZC6H
 WE1MAKJqntp0sAoTqwrSPbLGdZRQc1zGZfg68sGgqYARmhe8kwi6ehC1wuCL6HVowoqEYjlEovm
 CLsVqdBz/fWdO9RpNO0rEPhsw==
X-Received: by 2002:a05:6a00:3c92:b0:82a:13ef:5abf with SMTP id
 d2e1a72fcca58-82a1993a1f2mr8807276b3a.57.1773565369359; 
 Sun, 15 Mar 2026 02:02:49 -0700 (PDT)
Received: from Obsi.localdomain ([49.43.240.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725bfd0sm12594101b3a.14.2026.03.15.02.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 02:02:48 -0700 (PDT)
Message-ID: <69b675b8.050a0220.3c467f.19ff@mx.google.com>
From: Aadhya-R <raghavendraaadhya@gmail.com>
X-Google-Original-From: Aadhya-R <aadhyar.cs24@rvce.edu.in>
Date: Sat, 14 Mar 2026 08:22:51 +0000
Subject: [PATCH v3] hw/audio/fmopl: Convert malloc/free to g_malloc/g_free
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=raghavendraaadhya@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Mar 2026 08:49:47 -0400
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

As per the QEMU coding style guide, replace standard C malloc()
and free() with GLib's g_malloc() and g_free().

Since g_malloc() safely aborts on out-of-memory errors, the
redundant NULL checks and their associated error-handling paths
have been removed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1798

Signed-off-by: Aadhya-R <aadhyar.cs24@rvce.edu.in>
---
 hw/audio/fmopl.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..79e43d5410 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -50,7 +50,6 @@ static int opl_dbg_maxchip,opl_dbg_chip;
 /* attack/decay rate time rate */
 #define OPL_ARRATE     141280  /* RATE 4 =  2826.24ms @ 3.6MHz */
 #define OPL_DRRATE    1956000  /* RATE 4 = 39280.64ms @ 3.6MHz */
-
 #define DELTAT_MIXING_LEVEL (1) /* DELTA-T ADPCM MIXING LEVEL */
 
 #define FREQ_BITS 24			/* frequency turn          */
@@ -607,26 +606,10 @@ static int OPLOpenTable( void )
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
+    TL_TABLE = g_malloc(TL_MAX * 2 * sizeof(int32_t));
+    SIN_TABLE = g_malloc(SIN_ENT * 4 * sizeof(int32_t *));
+    AMS_TABLE = g_malloc(AMS_ENT * 2 * sizeof(int32_t));
+    VIB_TABLE = g_malloc(VIB_ENT * 2 * sizeof(int32_t));
     ENV_CURVE = g_new(int32_t, 2 * EG_ENT + 1);
 	/* make total level table */
 	for (t = 0;t < EG_ENT-1 ;t++){
@@ -696,10 +679,10 @@ static int OPLOpenTable( void )
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
@@ -1082,9 +1065,9 @@ FM_OPL *OPLCreate(int clock, int rate)
 	state_size  = sizeof(FM_OPL);
 	state_size += sizeof(OPL_CH)*max_ch;
 	/* allocate memory block */
-	ptr = malloc(state_size);
-	if(ptr==NULL) return NULL;
-	/* clear */
+    ptr = g_malloc(state_size);
+
+    /* clear */
 	memset(ptr,0,state_size);
 	OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
 	OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
@@ -1128,7 +1111,7 @@ void OPLDestroy(FM_OPL *OPL)
 	}
 #endif
 	OPL_UnLockTable();
-	free(OPL);
+    g_free(OPL);
 }
 
 /* ----------  Option handlers ----------       */
-- 
2.43.0



