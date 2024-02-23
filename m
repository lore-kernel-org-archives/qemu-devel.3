Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXrq-0006V1-EY; Fri, 23 Feb 2024 10:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhV-0004kX-0o; Fri, 23 Feb 2024 10:43:01 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhT-00063m-Cp; Fri, 23 Feb 2024 10:43:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so7508495ad.3; 
 Fri, 23 Feb 2024 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702976; x=1709307776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShLSid0lWwDAPWdEt6CxaC3vrH2IH2n6pSaKvP23E60=;
 b=DE6/N/tSMeVTivDXrK0RYaspOzQ+i6WNi6k9SMHX9CFTUUYlHJWfamK0lWyOWDQ074
 Nlj5JatAOd+BpO5jluXdCEUV6la7m6ZI0OD0MudKBbCY+Vi1lIbQsCk159gNRYUGpFmt
 D2i2SjeISjyaoARWOdsNzvGTtLnLVOGKXbiYgELbqjS4MJFRMiSd6Lf++HQsaHgKBgGg
 OgIrGd8Y3i3pcz67eQMYmGvS12Ry2KE6tRVZhrilNRWTsk+4k4+SNpEhgcDBpHDINRMV
 Bf/vKL7Rs/hh/+fMPzQ+FlzXfVT18SSCQdfKWVCCo+8RLRklyVxU7q2kRTB+akC5gueu
 8+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702976; x=1709307776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShLSid0lWwDAPWdEt6CxaC3vrH2IH2n6pSaKvP23E60=;
 b=VPicrWyclFLA5kBDt8lgh+Q3JfXnFEt7kmMES4uiybnbDeNSgGd99GCl8PypETJKtD
 iaWUwOEARlW0N3nI3UI3DPJYSvD24vYSiUtzrskd3EtBulCx19Nszw8LgI+KEHh/gPG2
 FpD7xAy+OtAwuDE/SoHv+BXL+bwieUU+8dK2f5NyrSK4RWPAcpENJhMviuR7+L4FzM/T
 b7VSZsOGNlx6F9WKSrjAs6+TwXHSloObGN+KppHkJe4ONGiajyc/4zlNrejHEh3flwdF
 PYUjeBPE+iddkP1D6ZrKFUJtRzzwv0UbFSn3YyHtRmQRLlBVod/13HLSMdm/56oK1oNg
 GFHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUEiuKqyTMTYNydfuYtvwEfjvv4IA7xRKFj6jW8kFlYfUL1YUFnrtTMw1NtifeSbvIom4eGQiVCgscWlcQFxsxlUoaQrq+Fn0DrWgXubuIYfuqQThmKvwAglRJ
X-Gm-Message-State: AOJu0YyOHfh9gV2VIfqSQqbF5HrgobUD77UdKWIBCRRzuEaxoCCYa2OW
 BVUe61+263fy7vg0qRVf5RqGEY+k5Lb/AehHgOag194Q8Hjo4FiWJyX+ueVO
X-Google-Smtp-Source: AGHT+IEX6sKvQGrmZQMep5w9ibyIF7sZbbgrJM9S4oHctiQM22nd1d8WKb2G6JJxzUbE7LvJ5ISrUQ==
X-Received: by 2002:a17:902:bb89:b0:1db:4c13:b67b with SMTP id
 m9-20020a170902bb8900b001db4c13b67bmr135477pls.61.1708702975851; 
 Fri, 23 Feb 2024 07:42:55 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:42:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 01/47] target/ppc: Fix lxv/stxv MSR facility check
Date: Sat, 24 Feb 2024 01:41:20 +1000
Message-ID: <20240223154211.1001692-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

The move to decodetree flipped the inequality test for the VEC / VSX
MSR facility check.

This caused application crashes under Linux, where these facility
unavailable interrupts are used for lazy-switching of VEC/VSX register
sets. Getting the incorrect interrupt would result in wrong registers
being loaded, potentially overwriting live values and/or exposing
stale ones.

Cc: qemu-stable@nongnu.org
Reported-by: Joel Stanley <joel@jms.id.au>
Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1769
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Tested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vsx-impl.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 6db87ab336..0266f09119 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2268,7 +2268,7 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
 
 static bool do_lstxv_D(DisasContext *ctx, arg_D *a, bool store, bool paired)
 {
-    if (paired || a->rt >= 32) {
+    if (paired || a->rt < 32) {
         REQUIRE_VSX(ctx);
     } else {
         REQUIRE_VECTOR(ctx);
-- 
2.42.0


