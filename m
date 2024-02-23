Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D539C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY29-0008BZ-LV; Fri, 23 Feb 2024 11:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjy-0006Tj-CO; Fri, 23 Feb 2024 10:45:34 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjw-0006fE-U8; Fri, 23 Feb 2024 10:45:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so3957495ad.2; 
 Fri, 23 Feb 2024 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703131; x=1709307931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MgGrqvKSu+YKIpZl9V799cCN3k/dXGAwCukmkEClIQ=;
 b=X2i0XT10cF2tJCJfj5uRfnORNppRKGuJ46hxLq/oRw+N+m0iP0ZcIBgqTui0L1tEFl
 vQhEGzXkyO08R7WBjrV8jDyXiLjaM9Jc+vG7AeMA0zNAnz5NCD1n9o6U6jMX4rQhbAiv
 yGTT1+srzzlDNNyHq7F+XuA9MR5lrN65GTJ/eG0Vlu1MeqVesLgpTBLwz/iRqg7sL10N
 fXTXVkH1SHE0EuF6yWB7RXpmVMuNML3J1lNObIzLPO3R0fYyDRZmGLN1YpqdAkxjYGIb
 EGF1eYoipxlExcvn6FkPNoO39+kXxeRLhvd99I0KCqRyZr7ksPzCl5HDt3flQSXpYepf
 4W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703131; x=1709307931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MgGrqvKSu+YKIpZl9V799cCN3k/dXGAwCukmkEClIQ=;
 b=heLvD+y7AdkYeymsJKKcjfiOhCS3KJliZfR38dznpeDfr20/9noI8muT6nCNkE/aFw
 OTJyj3UtY6WohfmxUD6dGM+mXIzq7ZJhlpHC75BPkNyDZjPy0Jig+aMW5JgC/ZlxdZtT
 6fvs8uo7SJ1+nVauyO5K+pjIlEE2hLM1lZp8VmLiii13G2VsVl6B5xzhKfjLvOetpRnG
 RJi6IzlmeN7yboG9zDh7NVXrLpQHgmGDDjrk4B+qNVXZbypjk68LM9J8zzUT/mS7uip1
 rI8cBboW1BfWxogZQVD0eJNobJrfSYoaH4CrPXFeCQ4pYJeU+u9Sb4z1MrzhfPruYo+2
 rx3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzXSkY0UfC5P1bsAdQwmth2V+XFb0HjH1E7UBvwkQHQj6pT0RM63lcSDJyE72yzOkRBtqSHhJM46yw6ZIGiLGeP6Ys
X-Gm-Message-State: AOJu0Yzx81eYh+65fXv/Eh8gNc5yNiWtXXHCn/ODfAGHhqppOYp6BbyX
 6NJ8t6RDtOXo+1ITAfRWrLEKYUjoUWPs8eCDLc3SGWlH5MsnVBvLIkmLCWYq
X-Google-Smtp-Source: AGHT+IG53qQwPw/Vv/VnvVzAGsgkgqB/l4SfNOFBPoMJIYBeyoe7HvaLFoYIRyD73/8Ag2t81f648w==
X-Received: by 2002:a17:902:7c92:b0:1db:c3cb:b088 with SMTP id
 y18-20020a1709027c9200b001dbc3cbb088mr188724pll.35.1708703131003; 
 Fri, 23 Feb 2024 07:45:31 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 36/47] target/ppc: Fix move-to timebase SPR access permissions
Date: Sat, 24 Feb 2024 01:41:55 +1000
Message-ID: <20240223154211.1001692-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

The move-to timebase registers TBU and TBL can not be read, and they
can not be written in supervisor mode on hypervisor-capable CPUs.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 94c9a5a5c1..410b39c231 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -468,18 +468,33 @@ void register_generic_sprs(PowerPCCPU *cpu)
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_WR_TBL, "TBL",
-                 &spr_read_tbl, SPR_NOACCESS,
-                 &spr_read_tbl, &spr_write_tbl,
-                 0x00000000);
     spr_register(env, SPR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_WR_TBU, "TBU",
-                 &spr_read_tbu, SPR_NOACCESS,
-                 &spr_read_tbu, &spr_write_tbu,
-                 0x00000000);
+#ifndef CONFIG_USER_ONLY
+    if (env->has_hv_mode) {
+        spr_register_hv(env, SPR_WR_TBL, "TBL",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, &spr_write_tbl,
+                        0x00000000);
+        spr_register_hv(env, SPR_WR_TBU, "TBU",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, &spr_write_tbu,
+                        0x00000000);
+    } else {
+        spr_register(env, SPR_WR_TBL, "TBL",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     SPR_NOACCESS, &spr_write_tbl,
+                     0x00000000);
+        spr_register(env, SPR_WR_TBU, "TBU",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     SPR_NOACCESS, &spr_write_tbu,
+                     0x00000000);
+    }
+#endif
 }
 
 void register_non_embedded_sprs(CPUPPCState *env)
-- 
2.42.0


