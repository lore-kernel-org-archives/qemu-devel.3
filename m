Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E500C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Tj-0004qn-C4; Tue, 12 Mar 2024 12:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TS-0004mD-R5; Tue, 12 Mar 2024 12:59:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TQ-0007z1-VV; Tue, 12 Mar 2024 12:59:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e55731af5cso3022828b3a.0; 
 Tue, 12 Mar 2024 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262771; x=1710867571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcqLLu3u5PZ1llo42lrjUzLPqI0T1odBfRlVjyR5kEI=;
 b=kj6IpqmogIbVH8ZHZ9ln0KZOIsdM0yCS4bPOtptK+7R1tCkmf9NhjaeT0gI5VEYLvu
 lIRnRwEXE2vmaz/D1je9cUWbMalVm9ZYitPe2WxiR+S9utzpeQ0WhXD+e8L4/6+CpR5k
 Kre2soHO24Gxn8WII4cQXrHunT1eiIjfpf5mqyLl2fYk+FJilmCSa2GgdIfsNDjgyHnb
 BEnnfs58vevzCEPEAzcBTC6LsY4SNfbqhYEQVjADB076YV3id9JT/5n+ic1Bp2UpA+qH
 Qvy1YAceTaJ7FUW7YD3Wa9aNGV7M1BihonvSpgrJufLKSMWn3YMCeqirAXo5S5C2ZsQz
 9/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262771; x=1710867571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcqLLu3u5PZ1llo42lrjUzLPqI0T1odBfRlVjyR5kEI=;
 b=hIrmKFKfs5jI9rULfACVzSIcUVQs+jNkBY07VD4qbAdcxYD3mx2B9XadkCfTCpBjPA
 24wBbqY5EK3whp801r/C1MMvTUnwXBHtuEH95ZaHe80j4+rvEyGoLoFHMdbBTbUVlLXD
 J+nPJQLbFqKh5yyMuZSQ67p3/X3Ec+cjXyvf+tuxMxX1AfFZexoS3SavsIuyVXL7THzf
 yqgldRXkrqe7CvTvYOIPMmvwDhofQdJTyYFcmFngqb2MYXhQlQEHfriS08Y4ETytR/Sx
 pwH45ZeUIxXeEusxEncoEhaFB6IUsOS4lH5UvJRCdj1AjzZjcJRQ5BZ1WEKxv2M2MlsH
 dptw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgRSMWWODP4NuyUNBFyZLAl7t5lzZjhotIaKEP/JxmlVYaaHN5azh0DCUdZiTb+3QmCmAnZ/AqVxM5j6tKKX1T8il6
X-Gm-Message-State: AOJu0YybjFkXx3Z2g0rYrFJc730oC05YxMn/wy45emQPh5L/5xDyfkHg
 QUIHdy2msp7C3eafEnHZBuDiPRNVkFU5RpHzNyVWTQOhnQElLARvPOwhwmUDx0g=
X-Google-Smtp-Source: AGHT+IHKYY55vw/e3nunZ/pBaebhhFimXzjk3cW/BrNnJDjU4cAXY0Yjo+VZYzsCDjgPRpOzhG+brg==
X-Received: by 2002:a05:6a00:2309:b0:6e6:8dac:5c74 with SMTP id
 h9-20020a056a00230900b006e68dac5c74mr48509pfh.12.1710262770995; 
 Tue, 12 Mar 2024 09:59:30 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 08/38] ppc/spapr: Adjust ibm,pa-features for POWER9
Date: Wed, 13 Mar 2024 02:58:19 +1000
Message-ID: <20240312165851.2240242-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"MMR" and "SPR SO" are not implemented in POWER9, so clear those bits.
HTM is not set by default, and only later if the cap is set, so remove
the comment that suggests otherwise.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4192cd8d6c..5bbd0d7a04 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -258,14 +258,14 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
         /* 16: Vector */
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
         /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
-        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
-        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
-        /* 36: SPR SO, 40: Radix MMU */
-        0x80, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 40: Radix MMU */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
         /* 42: PM, 44: PC RA, 46: SC vec'd */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
         /* 48: SIMD, 50: QP BFP, 52: String */
-- 
2.42.0


