Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A116606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7y4mV2V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejk-0008RI-8F; Thu, 26 Nov 2026 14:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWejB-000838-Fu
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:55 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-0005DG-Hu
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:52 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c5127c7abd5so1129404266b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719704; x=1796324504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/2eG+ft6HISlNKo2P344ky+Xu4IplgTfjqoGwGVa/yI=;
 b=D7y4mV2VsPnZ/649pf7uYT/PAmf/yP7MidYns7BYGb4mjJm6fxwGJFPZ4K+zWD/nR7
 erYxQ+UmZeSsmugS7crJDT7MqkxTpePPHio1HBmwBclNfIhLunqPetsN7oB0fZ1rh4BP
 gE/8W/zbajKb3YNY6p+/gF6buwbYFN7HTCdqDm2vErB8VN5UNZ58AjSrxLKb1MfPszO6
 YyZrOhi8RWrPyiI8CGOKQfjemAWXnmq6NQGPBowfZtingyqW7X3WUtb251Q58nk5mT24
 auWbf5iFcLWZsMK9SnLwiE/WsQmqXxCFQUnmv5EK0f15Kil9KVAXOh05zO9KdyBYA+aS
 vF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719704; x=1796324504;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/2eG+ft6HISlNKo2P344ky+Xu4IplgTfjqoGwGVa/yI=;
 b=EIIqQLK+HKJ2JHwg0IMYcwtpmm1me4jLiXanxBp3dg51P+r3c0crYxXUDWCtb8xuoZ
 iE8fgoQaw0m61PAnOX8/CR7u5wSqsSmKzGNycewqAGla8SFSk8sr0Y5WSpgTfvVfh4eT
 Fmu2b+mDQdk7WsBpww/uutL2fl8/1F5MvwFp8G37EYMuEONiVf4UaBtnM7P10a6zVVis
 ycLncc0SRSCaFwNDQni3GxgsJ7o1bby3zQDt+Cm649L/ly7muUGruEssCq3rSwWG0Kvo
 zqUv+HGVmbnUE5S+d+7KM12dZ2GfLP5dGl/w4vBB8pJiGzksmp9ofLgczSbTDwxbb6Lz
 2COA==
X-Gm-Message-State: APuU4Z/Nlb9C5+t4kXLtusF26Jf/5DL3ayxpiguQS2WceT/VGUOPDK8P
 4c02rAqKAFlJpLRyEIPslawHvKEEbY7dxPQiGqis0vz2+cFIGDfKz6SUYftDqQcjvtI=
X-Gm-Gg: AZFdTZdTnbf2cnIkc1F7NGeiLlNibnQw3MKvTRGe2xbJRkm0HTP4IjmStJo+tamxca7
 3HBe6/G+jW8rA3UYJx5w5qztO+ru7CPKpH2D4OkKZnbxtrCI5KqhLg6dHRafxdSLDfK9s5qobFo
 HReHG9GNPmYIr+wqyqwY1dRnXTDNUCwTRDVXxByCLM6R6uLHNaHAEjjic9nMqTsQ2+E4OvAXA/D
 IOQGhMXoj5iAUNnRrfLakQYhPLeqGYPOc40g5Jtfx17VrRD5LbmbhnWUQZhd3dsQftjLYCPZ+L/
 F3QlW1kepAgi+YL9DGCEAHxpur7K7Ovbfb8hAdoi2DWwBqbGdFNIX2TfUIT/TuhWHFLU10kAE1X
 RhHJul9TJKQc4fwtVScUNYD92hznullfYxSrmT3o06ViYYtMTH1Fo/Ydh9TSWYs5hSXjsCrujW6
 05EdOPG+o3Z2oadN/g0JG7C4/vEvmWXHcmUP6pBcmGnWIuTA2f8sHwSw3sorUNyp5jvJu2290ed
 mq4U1JULRiglIj+M1yXFNP5epxqXgfvQqxroRO3Osp0nSeQAEr8IwzoT4CnXZrniE0ANclb7330
 YL0xfKAEtbuaOVZtRSatp/C+ScSULE3WQ8Gq
X-Received: by 2002:a17:907:9403:b0:c51:bc21:9fe3 with SMTP id
 a640c23a62f3a-c51bc21a0acmr413078866b.33.1795719703628; 
 Thu, 26 Nov 2026 11:01:43 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:43 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 06/10] iotests: mark 149 as Linux-only
Date: Thu, 26 Nov 2026 20:00:49 +0100
Message-ID: <20261126190054.40844-7-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test 149 requires Linux specific dm-crypt and cryptsetup,
so mark it supported only on Linux.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/149 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 6dff39a28a..7b7afbd539 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -404,7 +404,8 @@ def test_once(config, qemu_img=False):
 
 
 # Obviously we only work with the luks image format
-iotests.script_initialize(supported_fmts=['luks'])
+iotests.script_initialize(supported_fmts=['luks'],
+                          supported_platforms=['linux'])
 
 # We need sudo in order to run cryptsetup to create
 # dm-crypt devices. This is safe to use on any
-- 
2.56.0


