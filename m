Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A02C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1y0-00083L-Fg; Tue, 12 Mar 2024 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xx-00080x-NO; Tue, 12 Mar 2024 09:14:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xw-0006q5-3R; Tue, 12 Mar 2024 09:14:49 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so4682577a12.1; 
 Tue, 12 Mar 2024 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249285; x=1710854085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcqLLu3u5PZ1llo42lrjUzLPqI0T1odBfRlVjyR5kEI=;
 b=LObvG6SSUM1JfYe6lIp5JeczvkffgRr0jtMeyFLxwj9J9Jt5lODlTrEp8DcxWHVyAS
 by+70Vpr5cqJV58D5H2Z+lvX2rRBCUmBjLxgnzLRitulm97V5sQHiMODS5Cigqu6va6J
 4K9J22p0aoUMM51iegs6CD+vXzqZx671CcMzIlVqyncyV8Q6Z3lgsCLMdcv6DKCqjjF7
 LQzbxLqx0Xz+iEoEWXUj9yOxXlz+lyCiv8VD2WBH47WdiZ2jDeDn1oHVOKF6vgCRIq/r
 9NJj/qPt3O9nhcpSFsFII3suoK1T9AQe+tb0+9lNSzo56iVvYjnkVqSAlCXVTaViuNYf
 qXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249285; x=1710854085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcqLLu3u5PZ1llo42lrjUzLPqI0T1odBfRlVjyR5kEI=;
 b=cVZ5xvopIodAPb7l9188yl+DTWbRmFyjPhMFqVagN1Vmso5Ipl7n43CJ5XgR9ioz1s
 hVvcA0jVTDa5cwuqEx77w8O0FcdesPYpYF9A8WzaENX/IoPmuvtVasDTBWydjgHYUKpQ
 Ryv5vhBe+7C4ZsDueU5SAJijr/y+LFroSZuebo0THj9Gpon9hZe/6g2BBd+j9SxQQv4j
 frVl2WgonJXI25oX/NLjrD8LeVGr0vWDzaeNMaJ8YjBe1HbbB83QdIkvxcTNPa38JFV8
 6MmUNkIg51159BkD9nE1qwFMnZBPq97Aj/8q5uSHrO5yr2qptj3eMvU26uiPsCqzdz4N
 zrSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxnIYV9OLMJVTYwfADpDFziDpynIcUrV0zUV1bgUwHL2zVF6DdKD0kfANnmmgzxqW8x9fx6vMG8xdIdirdtyNCXm50YXk=
X-Gm-Message-State: AOJu0YyVGr1eWTTPWJYf+TqFUdqd9eW6RCqDlrAVINtGp8TjaGC1R/aq
 VTDa3+tGK6zsVz8WNwOoHE7T6/2st9MHHERlZ2XOACwVZNY9x/E9VH/X9lKEjOo=
X-Google-Smtp-Source: AGHT+IHIqkGQN7alVJE2tBmGwDOFv4IWM9iNJIQZKFYVbfKYYAeqjuulbXif2ArixTPllbBU0WMKFQ==
X-Received: by 2002:a05:6a20:7b01:b0:1a1:501e:814c with SMTP id
 s1-20020a056a207b0100b001a1501e814cmr2769845pzh.29.1710249285568; 
 Tue, 12 Mar 2024 06:14:45 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 05/10] ppc/spapr: Adjust ibm,pa-features for POWER9
Date: Tue, 12 Mar 2024 23:14:14 +1000
Message-ID: <20240312131419.2196845-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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


