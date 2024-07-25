Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E63CC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8IN-0003Ex-Dy; Thu, 25 Jul 2024 19:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IL-000379-ST; Thu, 25 Jul 2024 19:54:49 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IK-0000Z7-5x; Thu, 25 Jul 2024 19:54:49 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-71871d5e087so301190a12.1; 
 Thu, 25 Jul 2024 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951686; x=1722556486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQJi1PrM5zA7kCEnyW3c73oAAhgPkkSN6T49J0Hm5N0=;
 b=kNJ4eFg7DDY1t3+HedTR62ME5OaL+nHP1iJHmg/8E0rhS0J7JosE3D6nQQCrY7l4Ky
 4Sj5gidEs9lLuB9nvA9D/ihDHf3rk4qhzAF9LQgqBOIPGjvQ8mwsZBAp/9MoDt8k0ZMd
 pTD2f8AyujaQFcFvozH89ZwrxpPrN0fADCyHFR1QhCFtdjNlmf6eZcTP6VQ3pb3fkC2P
 xoGBQcyh0gGiokLHnu3nkqya6vHDU/zxP5xgqCUSjwpNu1uEJJEcb3cIAfhxcRzBzNSq
 noUZZ0SFb7ksMSirFvVvlDa/bX2xYw5iV8s6aBMUJXlaqeIib68prhhN7ZVDCT59nc44
 tNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951686; x=1722556486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQJi1PrM5zA7kCEnyW3c73oAAhgPkkSN6T49J0Hm5N0=;
 b=XjxUkUEceLcpQIcNmLZHNUEZ9rHPWx1nbyUI5UTn7Y+YpyjUHViW7xlIWgk6owLmii
 q2zNR2zTLLYscOlKVYLfM9dePXuNZUkUxTNgDVIOSP8mFUVtvppNUy4DLtHPOVw95Kg+
 NRPGCAmTSx7LC5WZHY5wYNb0rsVwEoO2AoLkad+EexbaSGvknjPRlI5/ysPWc1eDWWip
 /BtV71EooxC9G9SLsQIslf3Kwb17yRXKQjojPcwoFFLHHck4baJq6MVyBLZCeXMdrfSo
 k/4lV5qpSoWAZhPmyP+rOOruw+yjFL/ubRLG1SvPI8kLlEK8taziBny0fjZnGjyoLWxr
 6o6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWciQMdmnq/cushPqmYYTtuNmOeCGvWS0/1dCLv+AhwkUUUEhXG4wMgmqsNehuSuf/SDaeiAl4uek5vQZSt2kxewOji
X-Gm-Message-State: AOJu0Yz2867QEdlCWJQ0iJWUfysiFEUX6GqOr6ExyghiIJMeWhzf6Uhj
 eiVxVilbOOk2lz15whCe3p0+2ULs0Imua3mXck+ZyOxg5VG44ZwXpVbcKQ==
X-Google-Smtp-Source: AGHT+IGf9iKrIGlsvpREiwxDr8lnd2RdSFmq5PHDxjTuuNkG5zTzj8mXbzV59QfCmgTtVQ8N8AOcJw==
X-Received: by 2002:a05:6a20:244f:b0:1c3:ce0f:bfb7 with SMTP id
 adf61e73a8af0-1c47287a935mr5716337637.21.1721951686325; 
 Thu, 25 Jul 2024 16:54:46 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 04/96] ppc/vof: Fix unaligned FDT property access
Date: Fri, 26 Jul 2024 09:52:37 +1000
Message-ID: <20240725235410.451624-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

FDT properties are aligned by 4 bytes, not 8 bytes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/vof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index e3b430a81f..b5b6514d79 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
     mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
     if (sc == 2) {
-        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
+        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
     } else {
         mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
     }
-- 
2.45.2


