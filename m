Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17CFC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3K-0000oo-DB; Mon, 19 Feb 2024 03:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3I-0000f2-JJ; Mon, 19 Feb 2024 03:31:04 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3G-0002I4-EG; Mon, 19 Feb 2024 03:31:04 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d7881b1843so34361745ad.3; 
 Mon, 19 Feb 2024 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331460; x=1708936260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/uWlpyLjbwpL//Tp94l/d17ZDvOpZ1Q/CQ+bpb2Coc=;
 b=UxHLBKPoNiCMNkIahUPVG5YDuXnq98rXNI1mkMcvk2F1vsD0Ia5yTTMGqVCrJouVDv
 PcI0SjA/tjVz3OP09h8Yo0/Ve+QPgUs8noDc/R919nm54JVHZ42AlVZNMVxkFKx1Gmnw
 YCa/zhSNtwkbIbeLqOzUpkXgatHMJKrn2BGMDVtGPlV1SNl7Oa94nERaTGX+Lvi6Pxce
 iannIkzkCWzcGcBP/8AHroN3pq3zqj+qrbD9vHILUDEgOEurh5Rp3vHjCnddf8I0RHn6
 wwAdfN0o4oBd0v21pjEdw8/jz3JeQ7qjPzK+Z5L1zbruVUidj6D7LfdxLQOYaUgVHWOP
 mvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331460; x=1708936260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/uWlpyLjbwpL//Tp94l/d17ZDvOpZ1Q/CQ+bpb2Coc=;
 b=w1QUG4SwSEkomn9hi5b1IjFcsUoKy9jL5vPZ2rzlxdxDMD9LRkB1vu1tWFco8lQ1ic
 Ns5bqpRHIw+uj5cYAANW+47UE3OlQslUOwcdeayYW7At0ypmiBBu4+KiUoD2Voz0Y32j
 2438X3ZFt00viT+seQLnTPoELDL4+HKE6TiwRS2cxVR41W5gCCK33lGso2wWDsLezsme
 AEZkSG980M61Y8BL+BlZwj4i59QR8/TRBvjP/oCssimVvVVv1h2XDS+xvPz7CFlDrXb8
 IoqxXJpjWEcfc16wbD1s/Stylm2akezBMiS4h74rZRwDi8RbiO1g6oJF91ZPfT62Ed7V
 vnQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0l9L+SYWXdXvgEOmpkvWE3ECNTuow7PA99+MyjpC71s0j6cq+x+/4jzh5eLuEmIQwRTn+2hLh+4wyuJ/CYh0AFn0C
X-Gm-Message-State: AOJu0YyHiUoqjuUUyzjzMqAYdLH8e2g56Lr3V6uwNy/cZVzUX1CuCEJz
 W7kuJVKxt8aRTERXUL+kLgiRPGC0LVxHcdaB0lzKtmJcl1ZWlMCCL9vKe1zF
X-Google-Smtp-Source: AGHT+IGZLyRyanmlFnSd38S3hVTI4WiH/IUaTylEbqNM2pFHeEI46KY3/ExzKoiWvrdUdwmQMuwhAw==
X-Received: by 2002:a17:902:db0e:b0:1d9:b9da:ea8f with SMTP id
 m14-20020a170902db0e00b001d9b9daea8fmr16265356plx.2.1708331460007; 
 Mon, 19 Feb 2024 00:31:00 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/49] hw/ppc/spapr: Add missing license
Date: Mon, 19 Feb 2024 18:29:02 +1000
Message-ID: <20240219082938.238302-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 9fdf0c2995 ("Start implementing pSeries logical partition
machine") added hw/ppc/spapr_hcall.c, then commit 962104f044
("hw/ppc: moved hcalls that depend on softmmu") extracted the
system code to hw/ppc/spapr_softmmu.c. Take the license and
copyrights from the original spapr_hcall.c at commit 9fdf0c2995.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[npiggin: Update file description.]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_softmmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_softmmu.c
index fc1bbc0b61..2fade94029 100644
--- a/hw/ppc/spapr_softmmu.c
+++ b/hw/ppc/spapr_softmmu.c
@@ -1,3 +1,12 @@
+/*
+ * MMU hypercalls for the sPAPR (pseries) vHyp hypervisor that is used by TCG
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2010 David Gibson, IBM Corporation.
+ *
+ * SPDX-License-Identifier: MIT
+ */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
-- 
2.42.0


