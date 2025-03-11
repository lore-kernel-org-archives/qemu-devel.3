Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKi-0000yJ-Le; Tue, 11 Mar 2025 09:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFC-0006Gp-Cq; Tue, 11 Mar 2025 09:02:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzF3-0000Mh-H5; Tue, 11 Mar 2025 09:02:00 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2feae794508so8087751a91.0; 
 Tue, 11 Mar 2025 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698110; x=1742302910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kxho44oluW8FOSM2HZbfWLIKk4fba+N89CNPXqjPZug=;
 b=h0yZUFWMoACsS+KnfRChFOlDIlKuKy4+gwe/LBTZbNal55kHDUUxHe55ZbQMFFsZ+o
 M0mxFpx0idByjce6KDUV59slq1wql3vO7vHsI4LxLZ63hD6vZw/3k7TB8XJzHrz45Dyu
 a7nhadZaxuFbPEh/MLQLn4vrrb4X1rZRaknJztMdXa/RIS7W9OBZlxdl5wxW+Q++lb4n
 9FM956W5RGih43U1YxVawPWF1RUF15e23CQ1pngMYSDeLFesD52NBF4A+Hw2egvv4EIV
 H5NNxnRUxwEKuwYH36/dln3jOa0VTxeMuoLbPQAE9fX66EZIxQaJ6KyJ4RPP4rSM9ePf
 1AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698110; x=1742302910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kxho44oluW8FOSM2HZbfWLIKk4fba+N89CNPXqjPZug=;
 b=wNI13SH382S3menucWOkSwI4TCeEPpHoEyAimz39m1V2tzFScD2NduDCEnKPsrnZg5
 Y9ASTLu45LKmk1rltH+gca+qo50aMqAsbJV568NUfbn/fqCppmHtox5ynCo5MpLCXVuN
 3VUkttWxnLVFyok94BvJMLk7PXmSNoKkLQnVPGupg/fxqwDC/xDd89Dh2/rwlrFx07do
 nh+iGsr1wQl6EvYmAaRoMGej9RSgSaSQ3I8xZ/vOE3OOjU7GUNmMkaaLST6DGmfLDF6j
 io+1TZhTXVX3y1BlzYnE7xGiPmJ+OCama8lBlOtSn/Ey13tn6cmq1wIWEP1M1WRmG6XH
 Cv/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqjp1nNoMzWiwKpmNhpywi9NxwdSoexCxZt1r+177Mr26lcjySIzRHjo3b2SCpoztdnSOGPlOTYw==@nongnu.org
X-Gm-Message-State: AOJu0YwsQxy+oLyhTD7HiA1yD8rE0Z3ftHoXuRHit4eDd8Mc8RLXuvzU
 uLq4maEfKzqLLWDKLLN6G8dZRNw1ZQfZXgPW1Gdc12i35GEuknrAQnJDgA==
X-Gm-Gg: ASbGncsLRYeDhEKp+99iqG9WsKGxsA7kncxXybErXaCfGC+a152SdR4biJ8MEYSWGO/
 8DBsPYFRvjjwwmzrTXrblNpKL5awkXeA0C6gbacQq2ZgRuKFLKLNU/23ERDXecOxe7e0myYKCKP
 ESZHsCUorXPnTLrnD4tTO3QxYv3xMaVKHPUm0yCR52s36gYr17t1nJdsC7EJfxyfmDacgxx9BCY
 w5Qt4/Un4Ox0HEAO+hzlCDjBwAHFup5MUv4t4Kgh5gIx6ZCg6y7rF6gzeOsTgrouQG9OCw5zmWH
 hPiycqbSGSKLz1XCC6nUkfsfhGqKYjQzul4rMkWrAI7nTUUoh/E=
X-Google-Smtp-Source: AGHT+IEUtO7mbUqOQOnuiCu3c0l7NIXHWY4nXKZgBD+EBY6vpZWxOZ12LNzENerDYxx6zHjK+gg6IQ==
X-Received: by 2002:a17:90b:3c8d:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-2ff7ce6c9b5mr27223648a91.11.1741698109935; 
 Tue, 11 Mar 2025 06:01:49 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 67/72] ppc/amigaone: Simplify replacement dummy_fw
Date: Tue, 11 Mar 2025 22:58:01 +1000
Message-ID: <20250311125815.903177-68-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

There's no need to do shift in a loop, doing it in one instruction
works just as well, only the result is used.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <446bf740cbb99422be2cc5a31e51a1034eddded7.1740673173.git.balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index b02792221c..4290d58613 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -41,10 +41,7 @@
 
 /* AmigaOS calls this routine from ROM, use this if no firmware loaded */
 static const char dummy_fw[] = {
-    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
-    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
-    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
-    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
+    0x54, 0x63, 0xc2, 0x3e, /* srwi    r3,r3,8 */
     0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
     0x4e, 0x80, 0x00, 0x20, /* blr */
 };
-- 
2.47.1


