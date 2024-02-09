Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAECC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOga-0003GX-Dp; Fri, 09 Feb 2024 06:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOda-0007c3-9v
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:47 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdV-0000ut-9L
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:39 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso210267b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476495; x=1708081295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXWAMAPfHdjndhTJ2+sVBLvm/k8lldonIPSwLRjOMK8=;
 b=EQVUWGoGUzWwZHcLsWn2ji1reJz1d2P+hGcZ2hZhG7F/Bwq7OhqH6Sv5EVp2qyqkvA
 kBvhmiejkmNLGHnIqdlKoq5LAjs+53kLUHqaIXhfzRHq9VyUxAriNOw5POVveqS5gF8C
 q1pWYT92fuxw98J1hgFOYuuwKkYUy8qal9vg/jprxnAuHdlOu8Q/4VjiwDoNng6zv6zI
 G4LVRfy2asFyLSSmvPPnwXrJeJ5Y/PHhsJvh9TfT+EewDcR0VbWyEPikhN2eO2Em6A4v
 +IMqd6TzmOZo6/BQTv6fIaRscqDBGuLMlCZpDQuNgXB/BmjJ+w8AF1kPMPC7pqT4oLtD
 hCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476495; x=1708081295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXWAMAPfHdjndhTJ2+sVBLvm/k8lldonIPSwLRjOMK8=;
 b=cPjUVdpDsSubcRAA3l1r1UerBLwKZkBCoQZCrKMXzzbgPsbXtsypMVZsAmHV7H8Ctx
 1pjeOgCCZFEuJlEVBOnk2PakHvPAMS6MnnMfWb4a7llqi3LInxkDMGVS2lsklGh/4dUZ
 R4cMm8VGZb+K0gcpyCC49DkRk628OzsIdz9k87y/EgY8NeXHR8ucJUkYmuETAGw1sAMt
 /FUnhGMhKe52+14GNFb9w3F0HlRo4hNXDtqdJOhd/vPNDJQuCcx8J4TuUG3VXhVrWiZL
 yBpDRG3jCiU4dqcdVIfB0SaqmIuBV1LufILY2z3aBPxRWwfF5U1NQ0iZ8VDdV7II+FGf
 9j9g==
X-Gm-Message-State: AOJu0YzJx9GEhkdpJiHBSn3sGnwkDXIJQIxAX+4i5hPxFFAttSwFjibs
 h2ZaVvE12KB1vDAHCNm2E1FOK8j793Qtvd7e99wUdi0CSbb9beVA9g2MnO2gHd3+Hg==
X-Google-Smtp-Source: AGHT+IGmHXUp7HVceudny4bf5ldaY9FuwZlsAMZKZWSYhF/XQcwOcanw3ymFpm3QmTjISr5CR3OY/Q==
X-Received: by 2002:a05:6a21:2d06:b0:199:cecf:9f5d with SMTP id
 tw6-20020a056a212d0600b00199cecf9f5dmr1584570pzb.29.1707476495471; 
 Fri, 09 Feb 2024 03:01:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUKmviTQoXhdt1HmzGXgYKV1p3TCcXeDISBFTc6CfZtm6HPtOiZg8jcnirkgQu30N/HP0hvzoafEvzcCpa6GkQq3dQiEhn25o+qHYI+ZymvjXTrIRnyaabpVaju33Sf+/EoS7jdQdF+BLF2ZkMsTQcfdElw0NNCVNolzgU11rK2EuUT1VwMaVDVou47BfiAa8ERaiyvk3CxGX4zKxAAEyo=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 58/61] qemu-options: enable -smbios option on RISC-V
Date: Fri,  9 Feb 2024 20:58:10 +1000
Message-ID: <20240209105813.3590056-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

With SMBIOS support added for RISC-V we also should enable the command line
option.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240123184229.10415-5-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 78fceae4c1..f7c83362d1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2697,7 +2697,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 17 fields\n"
     "-smbios type=41[,designation=str][,kind=str][,instance=%d][,pcidev=str]\n"
     "                specify SMBIOS type 41 fields\n",
-    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH)
+    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH | QEMU_ARCH_RISCV)
 SRST
 ``-smbios file=binary``
     Load SMBIOS entry from binary file.
-- 
2.43.0


