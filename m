Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FBBC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQo1-0002bQ-3v; Wed, 26 Jun 2024 07:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnx-0002Si-4e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:27:13 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnk-0001ri-0L
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:27:12 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d55cfebcc5so739564b6e.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719401219; x=1720006019;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=heud5oPL9PguF+0Dl89or/td6O7yLCDZcvUAaJnUzns=;
 b=ENduLumLh3dpWpwJP/ImfR33f325OkiC2M2SCFgaBOkw1sklcSEnn0TNb56/zjDtSH
 egDlZxOqdGe6TCfmEseA26SKP+GPP2qKlORNtuL2sp1YigoUP7PYT8WNRs0rmW1ovgk3
 hwQYmlzoNoc9mG/4MrR0KY1ruXXu8aOBHsMJi2zUswykHB4wsJGyi/CActN9xL12SZZ+
 +cVYfZ3NXWstw15UVT5ySsWvuSoXE/LX3qK2dtDmC0yAgOyxqBMigSyw9UFvXfy9H/0w
 1EL/UfE2O76rHmacxB+bFgUFutx3rd6wqSwB/S8u/oYR0pIQNtyIl0G16BpGcjDpYypM
 O6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401219; x=1720006019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heud5oPL9PguF+0Dl89or/td6O7yLCDZcvUAaJnUzns=;
 b=ZMHJnu5/PryaDiwr0/4YhbLZJ4ojzs6Njv89brnM53XKE4MgtILYGvPtWqGqP7ohzx
 V0u8W6PdC3FCTBwX1w1NTharQfFWKeK5fFNtLLjPgwuxOK7UPCHphJ00sDcuElPmVYhl
 m8pCBZ1INcrDA0ep9DN9NIAdp00oa6bTe7s5BmLu9TZYq4ef9sLLbjNMsU2cuiqLj3NK
 McxtHun+XcL16KVY1OK0wOfWe1RonZvmPxX7vaUH9p3IIjoe5G7JkhTA8p0s6Lhhm4sU
 gs6Vf2k7PenZ3lrX0DdwVdqHa85Rxystpo0go5ESll0DxqoK2uqmmggAiXBBq0G8WUK3
 ekpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWhziZoEcXaUydF12R4f1gAQ3D9TMOgDh7XKiURqvGEmKbVK6XhF3HeMHxaiPcI1KdAJK1PLrVKgZ2QhRIf4KhOFKjp8c=
X-Gm-Message-State: AOJu0Yx6l4jEKvbh2n7O1V3TfEFZfOVJR+dXZYzjMFvuBs51H91NOxZ8
 LTkyieBs0l/4ssKm1N+wARPmHUjem3+gvR7G5NVssHj52fZr+Afw8akHAT6E2jY=
X-Google-Smtp-Source: AGHT+IEYtOUNCZM7u0F0K7AoErqPOaXuviOsCSK5mAYT/zAYqsi6n3oC/A885BhTa4UubPmhUnzYGg==
X-Received: by 2002:a05:6808:21a6:b0:3d2:277e:45e3 with SMTP id
 5614622812f47-3d545963c54mr11397740b6e.13.1719401216857; 
 Wed, 26 Jun 2024 04:26:56 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706a9b3dbefsm965412b3a.55.2024.06.26.04.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:26:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:26:25 +0900
Subject: [PATCH 4/6] tests/tcg/aarch64: Fix irg operand type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-tcg-v1-4-0bad656307d8@daynix.com>
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
In-Reply-To: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

irg expects 64-bit integers. Passing a 32-bit integer results in
compilation failure with clang version 18.1.6.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/mte-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
index 88dcd617addc..146cad4a0499 100644
--- a/tests/tcg/aarch64/mte-1.c
+++ b/tests/tcg/aarch64/mte-1.c
@@ -15,7 +15,7 @@ int main(int ac, char **av)
     enable_mte(PR_MTE_TCF_NONE);
     p0 = alloc_mte_mem(sizeof(*p0));
 
-    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1l));
     assert(p1 != p0);
     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
     assert(c == 0);

-- 
2.45.2


