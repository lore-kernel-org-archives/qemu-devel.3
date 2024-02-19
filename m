Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95250C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3j-0001hp-66; Mon, 19 Feb 2024 03:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3W-00016K-TF; Mon, 19 Feb 2024 03:31:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3V-0002JK-BL; Mon, 19 Feb 2024 03:31:18 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso19279555ad.2; 
 Mon, 19 Feb 2024 00:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331474; x=1708936274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUiOJ1pK7QPyHQ5yGzK2wb+2Id3GEQyb+loYbOgfWOI=;
 b=edqL7Fh5SH19B6SRFjzgJQ8uK9YJg1WzVez+P+uQNz1BmJAzK7BUvxCvMMpdxLX6E9
 D4GXzKFvVmTehyB9X8jkqmTIQvjAxSRc+qxbE7lxGuhJAJAeuorZg2Y/ZCJDZS+FtGO8
 dghqv+ID4OOesuKzrAkeA16Iv1+asfpp/VJxOm6cbb/xtONJA27RajOWMI6zbcdAYoJx
 hDW5y+qsQLwMKYIkfQUJj8d6yXjooZMfxtlWjR7hTmxnjGoviR/zJOlNve+S1AQny7YW
 wDcg20cuW4GZ/85XVu8SjOOS/0BA0FCXLhmkJtY/aH8tE15vSe4ffT6mnpwABTN1MTTr
 nGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331474; x=1708936274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUiOJ1pK7QPyHQ5yGzK2wb+2Id3GEQyb+loYbOgfWOI=;
 b=XXUsAzDtuiHfyt7Xoaaf8JxpScCZbEBqI92zGvnHyPyFFEBUvdfC9ybkg/RLnxD1Tm
 HYILouisgJFn+yi+8mv2B2awDVX99dw7PrYU68LSk4SL1lVeDDIW7tShStP6rupcV7PX
 X1kntu4byPZZqCQKrUrPjxKbYWmUKsNzegeF+sGarNBcPeeN0pjozX6e3dxhEZ3NUDFG
 SabeiqzrxHJju/XGqLjSYufNzuc4oc7kbQR/+1lCF7uFVZ6lgqVJlRHrx4Zg06roij+v
 Y7Yx8rRiOM2xlZkrJaXodoWqgl1Zjl69RV0iY7dTyKcohjfki3Egwgn5aVyZqpJKnddZ
 U0zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrhj8VBTvPQ1Qw+4H2PxnEBa3DoYwMe4kD4ii7M4vrzZh0DBt0t5+3s4RyD5JA8ZUZgbAafOM6IFSfEUi9GFle16f8
X-Gm-Message-State: AOJu0Yx0MV5HsodzHApLMQizt9zxZm3/WQv5u/e/2Fx5OqHWUbi0QWaJ
 izzORRwyLWJIGeb7TbIgWRK0kXDvBpDBwt3644tuyqS2GzfFjYvlRmLbKFG4
X-Google-Smtp-Source: AGHT+IFwTJrDt4oyiSF2RdxwVXgu999xLOa5WFdME6dx3PIoT/D7BACy7AktkgNG+B8i3li7Nxq+8g==
X-Received: by 2002:a17:902:d54c:b0:1db:a0f1:0 with SMTP id
 z12-20020a170902d54c00b001dba0f10000mr12094328plf.28.1708331474152; 
 Mon, 19 Feb 2024 00:31:14 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/49] hw/ppc/spapr: Rename 'softmmu' -> 'vhyp_mmu'
Date: Mon, 19 Feb 2024 18:29:05 +1000
Message-ID: <20240219082938.238302-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

To reduce the use of the term 'softmmu', rename spapr_softmmu.c
to spapr_vhyp_mmu.c.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[np: change name]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/meson.build                           | 2 +-
 hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} (100%)

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index eba3406e7f..30bd2aaccf 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -31,7 +31,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'pef.c',
 ))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
-  'spapr_softmmu.c',
+  'spapr_vhyp_mmu.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 if host_os == 'linux'
diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_vhyp_mmu.c
similarity index 100%
rename from hw/ppc/spapr_softmmu.c
rename to hw/ppc/spapr_vhyp_mmu.c
-- 
2.42.0


