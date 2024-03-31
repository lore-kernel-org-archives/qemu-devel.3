Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA5DCD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqphu-0002si-HF; Sun, 31 Mar 2024 03:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqpht-0002sD-8Z; Sun, 31 Mar 2024 03:34:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphr-0002Ak-Q2; Sun, 31 Mar 2024 03:34:21 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e88e4c8500so2493971b3a.2; 
 Sun, 31 Mar 2024 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870458; x=1712475258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99NXL3dTZGdgRT6sIcLJ+0pMc+4T2LlgrASZ20/p80E=;
 b=SzidvXBqQALpRvt0chUbGDe6rq+vOCUvzn7GRW5O+PV+d8mifdSvtQzkb+AOa+9WW0
 mpskyK6wJh+izn3T/H8XhqVke/6DwJiFqunAFaQOtPjh5R8LX62zh+M3Bz8rIOqvrlVy
 z8k04dVCZvjrl+Qb0sYSnLbx0vmIiL64lyljbM1UPkHYDBEKrevbTF3rwnLeUjJbCyio
 KBplMpQxe3o2pHiBZj9E54VveL5TTpqU9XBW7Dq8mzdT1CgLRtMYjj9WNglabseetjp4
 aoFUczTUXOWhIZu9NmGoiuSXA4XWcoxRa6FqaJoVLtJ3N2dBri50sXNFm8HLA9+mv9Oi
 LKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870458; x=1712475258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99NXL3dTZGdgRT6sIcLJ+0pMc+4T2LlgrASZ20/p80E=;
 b=A45m+vTVCQsr5lnfBKI8JfObQocM2HGWwdQ+3F7/ntRIlNSDcP7DdsX1lKwQwAEuqd
 rq4DB0eMC38jokLtoZxf1qOrt9DObuWgsW1vAdVMeB89NR6vJ+hySxyLWLsZpQq6RfvG
 8d5DTaFee3GohsSchRZYuvbxOdXcp3zpkQES/hMUlz15PnSWkDW1uti2qauXy8tGAKsG
 gUX3kyTn1R9kkAwFsg/7YwNJ1IgLHzmo8NHfUrW9i8rFdluT5A8cmetT6SknHbuxcxmz
 8D9edTRVW83jVuvu9GgzFlNcUk+OhpuBby8Z+kzQVA7XvB7oZNE4dc3vyuYdx/qh4aLD
 SU9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWtKUCr35eR6HGDDV1+XeSu29FU9xgIM74wb+gSRrbM9U/fL2bKRQuGAq0sFVwkdCty+9TxDlhvvowtBDxDVypP7XO
X-Gm-Message-State: AOJu0YxfHUrNohFZ8CcYxHd7BPLmFu6InSSFQUHiw4SxEzosQhLQCOzR
 wPYVYAi2IzTQeftYvSeMrqTKsmyyEHlT0D2FB4Z+u/MrUpxjDTCIP2DTkhpHelY=
X-Google-Smtp-Source: AGHT+IHecu38bkXj3ZPpQ1hXMU9MmuN2FuavIqbLNa7kNPrBpwUYI33Nn8b5jKp/FwNeA5fep/Qa7Q==
X-Received: by 2002:a05:6a00:3cc4:b0:6ea:acbe:5188 with SMTP id
 ln4-20020a056a003cc400b006eaacbe5188mr6891189pfb.32.1711870457625; 
 Sun, 31 Mar 2024 00:34:17 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Benjamin Gray <bgray@linux.ibm.com>
Subject: [PULL 4/8] target/ppc: Restore [H]DEXCR to 64-bits
Date: Sun, 31 Mar 2024 17:33:41 +1000
Message-ID: <20240331073349.88324-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Benjamin Gray <bgray@linux.ibm.com>

The DEXCR emulation was recently changed to a 32-bit register, possibly
because it does have a 32-bit read-only view. It is a full 64-bit
SPR though, so use the corresponding 64-bit write functions.

Fixes: fbda88f7abdee ("target/ppc: Fix width of some 32-bit SPRs")
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7e65f08147..22fdea093b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5820,7 +5820,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
 {
     spr_register(env, SPR_DEXCR, "DEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic32,
+            &spr_read_generic, &spr_write_generic,
             0);
 
     spr_register(env, SPR_UDEXCR, "UDEXCR",
@@ -5831,7 +5831,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HDEXCR, "HDEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic32,
+            &spr_read_generic, &spr_write_generic,
             0);
 
     spr_register(env, SPR_UHDEXCR, "UHDEXCR",
-- 
2.43.0


