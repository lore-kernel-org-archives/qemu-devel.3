Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEA606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sl/ppAOQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ9ff-0002c0-0Y; Sun, 08 Nov 2026 15:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpaulma23@gmail.com>)
 id 1xQ8ep-0003ng-Qg
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 14:34:27 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jpaulma23@gmail.com>)
 id 1xQ8eo-0004Oq-6z
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 14:34:27 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5ecde8e8e5bso62079e0c.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 11:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166463; x=1794771263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PcVAu7/pV9oB/9602LpRmKIj9gOg7zdvjO8RyGyTOds=;
 b=Sl/ppAOQBDyBfZvoRoh1tGUNW8RhYc6E7PiAasSQqakVhSG+bTUeHJ1zhQJpNiYi2A
 wCd4g481IdeucqWQsm652L/HZGDr+lJoV/ONvxT9L6l7/6BRtkDXIkLoz7Q0pOfD6IyE
 z7naOp9tPmI75gsBUEOBmYv8W1zqGQ87xPMwLw5IadS7BaoLPO+jtriK28Rc8At+yHeR
 5b+a42Pa10IRi71Djr8NnD/QXxg7CoPNcRey1saysX6Ogfu3VIZwzLsxBXVsVBSRjDJs
 3SU49hD3XWPHgpxwLT74Y9Vym1huA0j9F1wfnNjb8dj57WmRO/TDhsrK3kKozCjnqsh1
 LIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166463; x=1794771263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PcVAu7/pV9oB/9602LpRmKIj9gOg7zdvjO8RyGyTOds=;
 b=hal3wlD795xCyi//KcQsxm3fALdOQJ7xueE4cjvfVFiT7d/gHtcIplBToAdPeBVRdF
 SEwWQ4pbDzdae0VoKKmDM9K4JBTHBr0RdfMtoMmewWHzlu+N86SukNsY2z4NvZgonnLu
 4wnbiKv8H+7cob8td4/TnDMAhHRJcO2LMhYgVCOkRFMiyUoo7H/M5cngKizNT9Jeb7gU
 wqhWZxE/64usqZHCoTSH2YT+gw5ZAO2DJOyi1LVxMvpSuPYcwKgjzFB9qSGI60Mt3y9K
 6UnY9Kl8bgaIIXrmtPJwxdAdirRTVV/TxGnbMVlz67QE4NIG4wTmJb/4YgQA8C062Upq
 1kUg==
X-Gm-Message-State: APuU4Z8IUfx+vnjZo24k0nlBVxFK+CyQccWOz5ZQ+9DqByalx/8e3uLe
 QOsQK2iOChKzKJCXjdu/FuTcFpxBLLZcRPTEu6t2PWV0BMlilUrHNytnyhN0Yw==
X-Gm-Gg: AYBFou3cXd/OOoMWpa7zgxaGT70ha/YIGVpZnVV64jXgCF8CpN7HHV4hrQOik6cCfup
 LoPfW9xjsSgjIWJIglTTnPFeehOfWyMI+30+2FTzkDNCK7OZXxY54gnvUePrMZUm/4kA3xoMH8K
 t1/WuJfmxAh9BGq1tMiJ5CrOv7ssVwc0+z/6ocgAJ8o5We5E/sWN220QbM0szPeWB4nxpHKVTMB
 qGT8weR2JDf1Hn8sr5CTfza+nmNpCmNwPeKj+pCOHG5ZM43JuZaHrEfddlNuWNE+TxwqK7qH5dL
 d7/wrnMlTOrVmTPvftRseqqptMBVc8G3TZNGagNGvQeiLL2X4qJCjEKX1rtzsWey8saPjo1r5Kh
 osycaZMQ02yTT3fBdtRGrBxXWBMuTrYxKrY9LEGgzxzx6qENllDBZaUmRQ2JgTtUs7JJ6tR1cfT
 dt30tIuucsrOCGlPWIx6ptT99e6Vmgge5oc9DcU2ijGHeoZJmdJDiE97awbzuxAbitnBdBclkv4
 sdV+kNVxNcN1PsehuZVASVIrhixjA5kaiiQE1nHrdMjTWBJynxZ1Eq8ZqW67n0R9uk3I27rHXce
 YKTPuMiv8eKz6O2B/wtRN7mXjJn1TXHUoDWn
X-Received: by 2002:a05:6122:e210:b0:5ea:e197:43ee with SMTP id
 71dfb90a1353d-5ece7369db1mr682071e0c.19.1794166463284; 
 Sun, 08 Nov 2026 11:34:23 -0800 (PST)
Received: from jiputer-laptop.. ([2605:8d80:6c29:aa12:5c76:8909:6da4:b5f3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ece60eec58sm2480800e0c.10.2026.11.08.11.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:34:22 -0800 (PST)
From: jiputer <jpaulma23@gmail.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	jiputer <jpaulma23@gmail.com>
Subject: [PATCH] hw/audio/fmopl: Convert malloc,
 free to g_malloc0/g_new and g_free
Date: Sun,  8 Nov 2026 14:34:18 -0500
Message-ID: <20261108193418.225672-1-jpaulma23@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=jpaulma23@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:39:14 -0500
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

In the function OPLOpenTable, replaced the usage of malloc with g_new
and removed the NULL checks meant for malloc.
In OPLCloseTable and OPLDestroy, replaced the usage of free to g_free.
In OPLCreate, replaced malloc with g_malloc0 and removed the NULL check
for ptr, and the now unnecessary memset.
The program will now abort when memory allocation fails instead of
checking if the pointer returned is null.

Signed-off-by: jiputer <jpaulma23@gmail.com>
---

A couple things to note, in the function OPL_LockTable, it checks the
return of OPLOpenTable but in the case of which memory allocation fails
it will abort before reaching this branch.

This patch belongs to this issue:
https://gitlab.com/qemu-project/qemu/-/work_items/1798

 hw/audio/fmopl.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..6bf4e74e80 100644
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
+    /* allocate memory block and set to 0 */
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
2.43.0


