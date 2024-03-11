Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F4AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklL-0005FK-4N; Mon, 11 Mar 2024 14:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklE-00056q-DB; Mon, 11 Mar 2024 14:52:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklC-000503-Oz; Mon, 11 Mar 2024 14:52:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd84ecfc47so12023715ad.1; 
 Mon, 11 Mar 2024 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183149; x=1710787949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCtRTqlehmWFfvspfl6T/mb2Q9OSyra/0KqMOq/ICUE=;
 b=A9nG+taKXDdSzFzeBgR5Ct5LBJ1KxEU9VXSClsXk0da9X3d/h4JdfcCeK5iIioFWyT
 qK5CWoJ5JYY6ScSJ5mAbb7jo3Qn/xngHFt9zr0qMXE8xvlr760iZKa+4vWcjNRdju2qh
 E3iBheJmXmYtdts26pBK7eGILxkApAh5ETt7yO+InRMqmOyxoKNs+oj7eeQQhx/Rsy0m
 68KaNZS47kxXS7uB4QscbLoSCx0IuKXKhNv7QPhL4ruXKTTOwTMsoHK7Yk0xaYCmAPBw
 W/RB3zwL7xHmqMADjT3MdJ2MzKdic6zsnzyrzbkXf/pbybBakWSleFJ/yYNoNKFek+UA
 tP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183149; x=1710787949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCtRTqlehmWFfvspfl6T/mb2Q9OSyra/0KqMOq/ICUE=;
 b=Cd5DBKmujt/6oZWXF1XgTxTH0OUQu+0kRns2w8/b85HCPK9/EKySrO0PidgqvZZXI4
 sdLs+9jYE8e+MhuG3asU/PN/koaWVXAG7JMTjmVtiSn8dXRp8kUN8iQEnVqJMSY/eLQy
 cmtGkSODRF3Fe+FZRHQEXDXvwMreXf5NUMF3Milun8rqOI1AkDd23G4N+wmJKM4WNBJb
 4IQI6N6OGVdn6YPZ24Be/Ui8O8xlzgTNcLiHQb2YInkTciUUqkgNlDs9mBoMg5H22TLo
 XdN9gLpY6YJuwEOhhvWd9Ft4mOSCh04g/k/s5wlzkmugP2LtXP48saLmO7BAq1P8Cec7
 qwVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ThUlEwTaCnJokYCgvRtim3LpYnEJMV5c8kg1jpUsUM3nyUTYzYgwMQ1hQ4BBsWQ2vdOjpduVD0v8Ho8M5Djr3SoQpA0=
X-Gm-Message-State: AOJu0YzeVgRQ+vKxqprerGXOCeQiXZaDlFFaur7dx5jMD3KiU+4YHzhP
 CYkxOCk/qqBIMdZPfNXdevAuS9Ies8l/e5NCHN1E3fG3S+G8mkX/JVisB8xVgLw=
X-Google-Smtp-Source: AGHT+IEkOxpn9fYx37nK+gdoN3oN/IvNdto+GIS1KUMPie/AEWQ5g1soTFZEJqdZjD2aCo2mttFcQA==
X-Received: by 2002:a17:902:f705:b0:1dd:8a1b:2131 with SMTP id
 h5-20020a170902f70500b001dd8a1b2131mr5902360plo.25.1710183148782; 
 Mon, 11 Mar 2024 11:52:28 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
Date: Tue, 12 Mar 2024 04:51:48 +1000
Message-ID: <20240311185200.2185753-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

From: Benjamin Gray <bgray@linux.ibm.com>

Add POWER10 pa-features entry.

Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
advertised. Each DEXCR aspect is allocated a bit in the device tree,
using the 68--71 byte range (inclusive). The functionality of the
[P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
bit 0 (BE).

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
[npiggin: reword title and changelog, adjust a few bits]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 247f920f07..128bfe11a8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         /* 60: NM atomic, 62: RNG */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
     };
+    /* 3.1 removes SAO, HTM support */
+    uint8_t pa_features_31[] = { 74, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 40: Radix MMU */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
+        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
+        /* 72: [P]HASHCHK */
+        0x80, 0x00,                         /* 72 - 73 */
+    };
     uint8_t *pa_features = NULL;
     size_t pa_size;
 
@@ -280,6 +310,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
     }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_31;
+        pa_size = sizeof(pa_features_31);
+    }
     if (!pa_features) {
         return;
     }
-- 
2.42.0


