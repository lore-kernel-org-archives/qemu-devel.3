Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1444CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 07:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl1GX-0008Gs-I2; Mon, 02 Sep 2024 03:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1GU-00089z-Sj
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:18 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1GS-0003hk-UM
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:18 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-82a20593e53so151605739f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725261255; x=1725866055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdpxHGAujFiCeLIq9jDNKBjdMMvfgjRI0rVz+c1fYDY=;
 b=AEcoJz6qTfnzN1LisVaShOlKxTkO+3Yimqi24G3ftebmMyNakNugOVCBzKuP2qeRBy
 1tPJuWNZXodbYeUU6hQ7iaMi5WNk57M5hCwRPRTh7o+E38bSY7GZ2M77oFOGkxydxEVe
 sIRAxUdhJl5NAITkzF0a25QsnFnS1Zn+E17z6A7CbB0lebIf/8BziMi+DtTJy47Tfoce
 nRXOvBVas8GyRJDmnr29l7imQimFJlkxJb4v1+iSTKa7Ghc1G0MtnpEFUdeYju5XquhV
 1XNbZ6sQ6lN6ZhpjfgPlJUv9LrZkDoOdeTac5AWXui41azghv8PXXrrEF6+IhzPhs7Jd
 J/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725261255; x=1725866055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdpxHGAujFiCeLIq9jDNKBjdMMvfgjRI0rVz+c1fYDY=;
 b=bKF/+jk9RSb8IlhkmrCKOO+R+j4CFA7igoIvlYTMzUET5rCRg1z8Vg45G5rOmGzwY0
 Xe8SEiJAXlICJ6BoBOkaq+RP6fT90/O0ArMLMXgTKpma+OEr3Qikj3WgBveq1Xa8sse4
 dZUeC3k1jpwodHkKutmkcU+BHu1+U6mC6o/VRbKIe6oMlwd/vETsIflil8U9m9IQpEGY
 +f3gUezyVQ/rQaKyWMW/nbiJCIYVyu9dijIygyswbLktVOWgyyIiiEgpiZo9+bTTVbmy
 8178Th8C42E0qI2rdSnIh+y9NBnHjmroyQx3vnsUaPInwh17hf/4cpGZD15vWBXAu9CB
 faVQ==
X-Gm-Message-State: AOJu0YxVVUHUOuvwLHurJhZibQk38paixB9MbNkYGxvbUtG7f1R9eNDK
 Rbhg2iCI4x5k3ZO5dOSuaG3acNDbL+4MK6fCxJnHckrFcd89wzrtMYvBRtLD0wypIyr+naCcTjq
 yc9MXEJaZtN4NWz5YHFDOWULyVW+yrAG6RijWuksYqnK7cbtNTqn7LOQIxF0rhkBfbuCgK4AZuZ
 qqlcQwFqoS13ssTQRomjLjmfP84m9SQn4wqgwncg==
X-Google-Smtp-Source: AGHT+IEIVFy3tOcTRngNnmHu/lk63dW1PlYnAmjR9tHhfs6muJKuhhw4a2rH12Ma47kEY518P9IcUg==
X-Received: by 2002:a05:6e02:1d17:b0:39f:5521:2cd4 with SMTP id
 e9e14a558f8ab-39f55213075mr46579255ab.26.1725261254939; 
 Mon, 02 Sep 2024 00:14:14 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e743252sm6793331a12.15.2024.09.02.00.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 00:14:14 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, ajones@ventanamicro.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v6 1/5] target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
Date: Mon,  2 Sep 2024 00:13:54 -0700
Message-Id: <20240902071358.1061693-2-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240902071358.1061693-1-tommy.wu@sifive.com>
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=tommy.wu@sifive.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The boolean variable `ext_smrnmi` is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..ae2a945b5f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -125,6 +125,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
-- 
2.39.3


