Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A49BC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ik-00057v-6M; Thu, 25 Jul 2024 19:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ij-00053m-29; Thu, 25 Jul 2024 19:55:13 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ih-0000no-H7; Thu, 25 Jul 2024 19:55:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb566d528aso319302a91.1; 
 Thu, 25 Jul 2024 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951709; x=1722556509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeqMVWru/YDNxRRHVnu3pLowSIqilhuOUjfYu/akPaE=;
 b=Susa1QNhk3xfFYkwn+DzTuOMr6SHNq1RmyOqfPNgSedvXyYtRF4LS5kGKboq4HMG3j
 Bi+jiOLiMUfCfAyG+IydoNv73otbIol6G+xHRxxar28jVBh5r08I8Im59BPqdaraq3mO
 PzsmT35gF7yG5WEBH7HxTqwr9UoEJlKYDT0IpBaryD+TSkeu0x5rPC96Yk/k6YHz+JM5
 OmNLiAYlNGNffWoril38GCbvP1jgxa6aTnwnA25QkAubFAZHHG+9igH3i6RmUlFigN0E
 smXNzgwkM7TFeQJJ38+NUs2lyIIuqcpM8h5jaMU4fQUVuO5I/j5PpTs45sxIQ+se5Wub
 R8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951709; x=1722556509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeqMVWru/YDNxRRHVnu3pLowSIqilhuOUjfYu/akPaE=;
 b=IwA+6KUopA7yD3en1WkYL/brs078tWCiZrrBwyd8KNTeTkfgXj3VZw6oq9fCuOOQaF
 BMl0lMCLEWFI25IEXLOp6DPiBI8mul8VP7oQkbjVXBhXyA7TOCUP4P6MPKYzCH7ZHrrP
 xTb6waGogNWCI4dGfjyajs+yOb4jox8IvTzKEq7M/ybDItGhAIDdZxWIonRLy8eBkTpG
 nyRLo/DBo79p01QEWWHEE8jlgAdbrDw8BkLZPa3mQzEoVI5FwMBH2tFfFLERT/WBT3BL
 VjzBhAmW388jdtvtra47qGEqKjOkeJgc3BkvF1khFIo40daxNrU2tuS8Pm+fT8Rw8TWT
 l6lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3/RLjFirP1hd/TBWpy1SiLvC+AR9p2tQmYrTP4Xo6d14UUQhWkGXDLse3JlJxA+J1TQloA3tU6Qd1TGan0bMj3pGj
X-Gm-Message-State: AOJu0Yz8mAco6qhyyw4cGHsPAP1TbaTV327Kqy2de9y8xyE3OF0RUWze
 CkSTPaMOqEz5TKA4ZetkFIqS4RsXL8hZF9+Yusy9pGcCWXLiWI5xnI7k7A==
X-Google-Smtp-Source: AGHT+IH7wDHNCmtUf2XNPuPx+cnoY8XIyyze+s75u3+stWAsvILqNv6sHs/s3/Jwpvo11ck0X3HEeQ==
X-Received: by 2002:a17:90b:4c05:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2cf2e9fc0fcmr3919284a91.14.1721951709457; 
 Thu, 25 Jul 2024 16:55:09 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PULL 11/96] target/ppc/cpu_init: Synchronize HASHKEYR with KVM for
 migration
Date: Fri, 26 Jul 2024 09:52:44 +1000
Message-ID: <20240725235410.451624-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The patch enables HASHKEYR migration by hooking with the
"KVM one reg" ID KVM_REG_PPC_HASHKEYR.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7c3ee80661..d311b190c1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5873,10 +5873,10 @@ static void register_power10_hash_sprs(CPUPPCState *env)
         ((uint64_t)g_rand_int(rand) << 32) | (uint64_t)g_rand_int(rand);
     g_rand_free(rand);
 #endif
-    spr_register(env, SPR_HASHKEYR, "HASHKEYR",
+    spr_register_kvm(env, SPR_HASHKEYR, "HASHKEYR",
             SPR_NOACCESS, SPR_NOACCESS,
             &spr_read_generic, &spr_write_generic,
-            hashkeyr_initial_value);
+            KVM_REG_PPC_HASHKEYR, hashkeyr_initial_value);
     spr_register_hv(env, SPR_HASHPKEYR, "HASHPKEYR",
             SPR_NOACCESS, SPR_NOACCESS,
             SPR_NOACCESS, SPR_NOACCESS,
-- 
2.45.2


