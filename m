Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC7FE65D18
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 03:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEKFe-0005VL-Td; Thu, 21 Nov 2024 22:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tEKFc-0005Tb-IY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 22:22:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tEKFb-0003wN-1S
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 22:22:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-212583bd467so16350105ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 19:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732245749; x=1732850549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ete+ZJB8URbofv6Sb72yOCLqH3KqEk//Slye3l6+Ywk=;
 b=ReYY0V14yx7limW5OhkEIqMDkrcvla4NKGieLXG5C8GEphe3eTB0naP/L6HUfUuVFK
 HMPCrxu9vkeJd3QEgqN8Z4MzXrpweGd0EGCPvEHYnBVtCeCoNkwr+tbD3l6OIV7knyu1
 8Ua/DT0RYocKCwhbOXKEQ9B5vlgV6Q+ysvpdypxM4FETP+OpEGr+E9mjc15zinI/LQUm
 PxcfRNxSi9I6pEFy/Cyge7NjfTTD0h15tOUoZ8a3uROuxK01nDWZseyjJoB/+uYk9eIs
 FTKXlm/NbqsCPe0GMEWHgg4/67dbE4QVrSGR7jIz65w3jK0Ni2Yi9vRpiTF+bavgN/4a
 +RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732245749; x=1732850549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ete+ZJB8URbofv6Sb72yOCLqH3KqEk//Slye3l6+Ywk=;
 b=JKkVs6063lVRDd/sBEqBVWN9WX9J3Xn0pTQNmiZ8/RFxvMH+N3R7KsdO0O4qbhw110
 cPq2Zv7QueUtnheNDmEf74nB/2u61ptJ/Oj2tuuPtghF1tMdf6yCBTJjgk6PJYIkpxNp
 hPCwv3Z1yGHViUApdAJ5LcgTI3himPMY1gj4ItQujNqo4Lv/FggJ3f4QOqn20sp8poA/
 9NpFNegGrPf16w9FRmLRx8ExC36JgXb5yn5gJ6pJnQAkSUvzK8EAr693suFnjuKzI81p
 t692hX1W0Nf6rUjSfPIf4zB2zovvhjyzNAJLsVVZjSj+bzzVAZvNPQbkUMUi5HYw5c1W
 lHhQ==
X-Gm-Message-State: AOJu0YwjefhUikaLaf+brjcxulhErARNthfKoJf4Ma7T53pwEtiDtqfJ
 MRAzKpH1K9kq3Asd4bpxtqA4W5614CyYXVSjzupCR3/UfwVTGK6t+qzlnCTSTjT4M7d8imuqjGl
 HigBPm/X9BasyuA/jS2z0lJvArb6IgpL7zbYsVRbompvrQA6HGhFfXov3Cp3EbI/Ya/LFgsoCnf
 h+E0fpAac2mnpXviXANQnW8tsoSNVGR/a7lDog1iYBFJpZ
X-Gm-Gg: ASbGnctt/vB5Lgm/AkRAxWShfx+1OZPnF0ReR54ATRu6Cap5wq9TpvPq/LLTLaGx8+n
 dxwt9CQkxFhNHUPBxn4hBCMXntSuvdfs14CAUDVYZlbi1HkEXk0cpAS92jCpx5Jg7/aUPcLtCZJ
 nqrV4+vGYooWFCAbgCMx3XhBQi5cyhWv4we9HzosVm3fniFFQx8+GJ9HMf8StcerHrt8m9LQcYi
 Vi2jUnLboqKEOmcF+a4Uug8v82VGEueZO8YFDkYa0jYJAL47vTJ7cjwyzDxp8eNLu4yvKOTyAxv
 shx7tA==
X-Google-Smtp-Source: AGHT+IHBEVnFrbzMXecQHh/nZ+GmGIm98FgEFEm1Vd5Gh6Yy+xQdDvnKgQD8iOmlfoA0OndNvUSyYQ==
X-Received: by 2002:a17:902:e742:b0:212:4e37:204b with SMTP id
 d9443c01a7336-2129fd74184mr13294575ad.51.1732245748842; 
 Thu, 21 Nov 2024 19:22:28 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc157f3sm5506905ad.203.2024.11.21.19.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 19:22:28 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 1/6] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Fri, 22 Nov 2024 11:22:12 +0800
Message-Id: <20241122032217.3816540-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122032217.3816540-1-frank.chang@sifive.com>
References: <20241122032217.3816540-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..321f64fd72 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -128,6 +128,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.34.1


