Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C37FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlBR-0001vC-Rn; Tue, 28 Apr 2026 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.fast2004@gmail.com>)
 id 1wHlBQ-0001uZ-Cj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:21:12 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luc.fast2004@gmail.com>)
 id 1wHlBO-0006yl-Ow
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:21:12 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64e87a81639so10586490d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777393269; x=1777998069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CKPpYdl5J5ki2kTMbn/T2wAohH8knYa1gzHgRuUyn5U=;
 b=dDl/hCH3lVZehl9+AgDCuBd5kR9NTcYRTqtMS0sc8hYrYwt7j+qLsts6miZ/OEwCSe
 RRb6B/3aR7q9rkk6qx9HdX5Hze0TqLdWdzcX8kltCB3hnz+0HApml7LOCISsjc9ONZzA
 jx2VKY59Yt+vHQ8vpxGR1uEjWbHUWMPdxIx6oo1KXF7KrZn8eljkHtZb4hDvc+Re506W
 ljHgLk1id7k1TGsBF61dSzXx3j+prm96B59Ipp8ZU7B3oWXhzRvOsGHaGWJ8UEMMpGLn
 GGYgLQfaK2FGoaCZYmfTBafUQ0k57nJiIgNi5jfKNg2B02dg7RSibo44TrnudPxNUFxl
 fh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777393269; x=1777998069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKPpYdl5J5ki2kTMbn/T2wAohH8knYa1gzHgRuUyn5U=;
 b=rD/YwjkwDi7D4QzMNlFWpFVvrOHqFQtzZhKpxKS72QQyb4ytDi2n7LRorkrYr2xxoF
 7obn8upQdCe5y7X0jeum+8oX3edIywc1StaSR765AMR7jsSfD6K3ADGs1nSoWsvnFlqe
 VvLIcNwOOhGz+HsB8FdGSwdfl8pljgjWtpQKqDabgzShvAYAjBqON4jAkYS7hljkDAiB
 UL0pGxJyeEbGYT64Uu7R8Ijre94anbXcPEDcXJhgnUXrWvb3n6kpQ3rEJFhqgelCIbVv
 H5JRHZOzgiqTpgPKb+Iqh7Y1WTkIbgGUPlofTa0gVlNVXsd0XlHnKrQvnSsrfa5mx2lJ
 lqKw==
X-Gm-Message-State: AOJu0Yw5ApqtLVW1deqhtH5kotDryiGjbYSDPmk9bVaDQAathElL9B5d
 qEH59mZRrJsN/s//KXRuffGc5Z3sBRFeQ9XvF1RUkVwxA1EVkjBExpqMgMZwnPB5
X-Gm-Gg: AeBDievu+LS+MRv7RUaHZEOAujZAW9ypXMaU+7TJNd8BcTrY1q2JeyxHT+oupz3cT+E
 TYbpbb5cWJseIgC/SKtAefOtMAI/jwN5jK8kRN3S4R1NIvxsqwce5ebwbrCOat2tXZwfYziWFiD
 h8hK8tXbVr2zwBfjdQ1F0HjI5Y86gYh7UuXPnFVfsFlApKWXX32bAFrCIiAVBqJ2WiiMogtTvOq
 dYy3UE5K641IM0BvhvFl3jCvQ+2cFsfn7iiRt+cZV0ekGxkynTZeCGXyk7uc8tENtwTHRTUzJ5i
 9FZZ5lz03rpNb4LBn4ox/+cTr4CCfo0eCyvSWLm1z2SVbwHfqCfnvnkL7uhB0uz1FfklGOFUjzU
 W1lt0h3RE9ly6sdEzdFkO/2hwg5iK3bVgfOaG8TckgB6AQ39wX+ei5PERSzEXSJhJX+mgQO//gy
 CEFOg42jRmK4sLNLM3VVEIqUQoa/QbFcinHJlwwdtonGlP8TIjP82IVZZB
X-Received: by 2002:a53:de0f:0:b0:652:ec6c:e2ea with SMTP id
 956f58d0204a3-65bfb7051f4mr306082d50.50.1777393269452; 
 Tue, 28 Apr 2026 09:21:09 -0700 (PDT)
Received: from lucas-Vivobook-S14.ufscar.br
 ([2801:b0:20:59:e35a:fdf0:bf7c:590a])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65bee29f1b4sm2099215d50.5.2026.04.28.09.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:21:09 -0700 (PDT)
From: Lucas Cardoso <luc.fast2004@gmail.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org, marcandre.lureau@redhat.com,
 Lucas Cardoso <luc.fast2004@gmail.com>
Subject: [PATCH v2] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
Date: Tue, 28 Apr 2026 13:20:48 -0300
Message-ID: <20260428162048.2995097-1-luc.fast2004@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=luc.fast2004@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In accordance with QEMU's coding style guidelines, replace raw memory
allocation functions (malloc/free) with their GLib equivalents
(g_new/g_malloc0/g_free/g_clear_pointer).

Also removes the old generic error-handling code from
OPLOpenTable(), since the Glib functions abort the program automatically
if memory is exhausted.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1798
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Lucas Cardoso <luc.fast2004@gmail.com>
---
v2: 
- After some studying, I decided to follow Marc-André's feedback to use g_clear_pointer() instead of g_free(), on the OPLCloseTable function.
 hw/audio/fmopl.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..91fe806fd6 100644
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
@@ -695,11 +679,11 @@ static int OPLOpenTable( void )
 
 static void OPLCloseTable( void )
 {
-    g_free(ENV_CURVE);
-	free(TL_TABLE);
-	free(SIN_TABLE);
-	free(AMS_TABLE);
-	free(VIB_TABLE);
+    g_clear_pointer(&ENV_CURVE, g_free);
+    g_clear_pointer(&TL_TABLE, g_free);
+    g_clear_pointer(&SIN_TABLE, g_free);
+    g_clear_pointer(&AMS_TABLE, g_free);
+    g_clear_pointer(&VIB_TABLE, g_free);
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


