Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B587BEF8FEB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTn-0007k1-OF; Wed, 04 Mar 2026 08:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSz-0007AF-9F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:51 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSw-0005IP-JG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:45 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-824ac5d28f9so6912197b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631641; x=1773236441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LACcDLnSDVOU4mmrdJm1ulEQ5YYKsvz3PueFzvvC3bw=;
 b=JYwYRKypCCNZPqTCPKOSO0CYnkP1RebZGAxggOAa+3vldK1rnEgWrtlqYMiuVD9MoW
 IYNDCBGAMPcJl+6EuoHJrOcusYQMiaCNwUb3BD9wwFIXsYB5ddq6zAPU7n52QFPxfmYc
 oqTBmy8BoFe7MPMtqCytH4kDid267ybGlReV+WBbnyGfXbece8CvF3rfhPJwayTXxDQj
 abxNERkVvJwMZe9Lb6XZoYIzykAVcmZoIWdWVfvIVEWz7H8dqkdfjL3HpLQ91eA8pNp3
 85OAjIBQARsnh3HYXRLIfb+CM6rArCZjWukUZWkieteExlQE/yrjgGF24RPvTb9WPntd
 BDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631641; x=1773236441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LACcDLnSDVOU4mmrdJm1ulEQ5YYKsvz3PueFzvvC3bw=;
 b=kWh6aEHRNnqEBDECyYKqO/LlUNV4emC/f/LV/7yOLhXFm9O1YfStOa8PG0Qmanbwj4
 LyBUw1REgKGLzo6jK2Ch6AqgxX7hvtzc2bv7EAx6Nr9kfIy4/P+xpwvTRKEdUDnfQe7l
 Cqzv25Jcda7h+ia96DwWEZT63sqqI9Ws4Dqk6O5p+JfbX4oI9EnrLbyWRklF1IgVlgK/
 3xTu/cBGPh3+o3X5o+NdxlSZ/D0ckft/WU/C7H/WOSGJZNHuU8SL7RVIxvXl674tmUgd
 6LfOUptZrhsMibidKBYPypN7tNTnw7Vg8AGAncMEftTRhaAxIDtHxlJMmqhXIshM3fLH
 csqA==
X-Gm-Message-State: AOJu0YxQBFemQixuhvFZJD8ykboDm0g7te4tUhvLFhCSOj/vYTSEorSb
 S2HNHIK+oZCTTZkIWqoJz6kpmWC1Iep4Q5+7TgEDqRsmnswr1cekRdYSVKOJ4j+UGcQldUUm6SO
 +z8oiCyJ4lNWbOoiVyItCwGb8mzYksSpNVT4t14TJTEjups9MP7k9zWbacWTAP94hnYCmNeOxY0
 /D56miO9aZn+guT83kEDFvvLcU/gklyarpYjclYBjyjw==
X-Gm-Gg: ATEYQzw4gMHGzXFKBNMC2A65W3NUs56aswdz4OAYhwJztA/4AOC0PY+jc/yb4SC2uol
 +0PM/3w1kV8MjVUlT2pW9uXa7Sz0klJQzuq976YKX3zX9TaAr1klBXRZA61bO0GxHUn+hreThQp
 Kh0nOJLOSlEb0fdBNGcSm6JtBW/I5q4iZcKJgBOCmr50bcAFklsjtlLL3JkDPHd+V35ZNvOuWat
 VSSdWnaFUdzDqFUTCDplKIlPdMi2zteXm2gZtIIiDzzEVmlC1tTI3RnEzvpAGfB5Cq9p6QCnAe3
 XwJmKQ4zoW68TcAhngLDxviUVCXS3Vmep2aHzE1JL0OvXBVGQaTkXdftlWqE4IvlZYaVzLOeD+o
 0j2V20el28uP+phLigGLClpoEZIheVtoCX4RoLuwD6YwN2w4aCbUKv6n6nSN5F2GxY+daMe2HWI
 y9Ago9XcdPhp8AwEG/OyWC1I/NjuXTQ/t7aWF13MRyMgRjM0ib1e7U2UCNaQmoAUVy3hy8ZlUN2
 qdi1TDYER6/X0U7+Q4bVAgshmc=
X-Received: by 2002:a05:6a00:14d0:b0:81f:3d46:ca07 with SMTP id
 d2e1a72fcca58-829729096ecmr1992799b3a.13.1772631640917; 
 Wed, 04 Mar 2026 05:40:40 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:40 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 08/14] target/riscv: Expose Zvfofp8min properity
Date: Wed,  4 Mar 2026 21:40:00 +0800
Message-ID: <20260304134006.2908449-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1cd74f01b7..9b98e18189 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1382,6 +1382,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
+    /* Zvfofp8min extension for OFP8 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+
     { },
 };
 
-- 
2.52.0


