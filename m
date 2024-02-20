Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1E6C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsc-0000Y1-Bz; Tue, 20 Feb 2024 03:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsY-0000PM-Ig
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:30 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsU-0008ED-55
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:30 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-512a96e44e2so3309992e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419204; x=1709024004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvdV9IUyScfXO/aRp9jIGXOMeWvG9ot2GraQaMTkQfY=;
 b=dzV2vMc+QOtvV4BfBPrvWTL0rxE2c/3icEwOm4Eb3FH6vRY8mHK7xCWxbPr9GP3+iL
 L2YfUb1SmyEiHeE9Ow7NznSHyAW9pBrVIakFC3riGnWz4n2xwKKX6ojhPx3FNut7zh3M
 Dfrf1hMejt8KL+yR4erlSq/vjeWw+zGDerrAaSyfiIKA4rs7fQit4RjYxzuT6BQzM90l
 ku/04+CzZMRPw2gcLQR1f+/EiRZR9Vnxh5/Fy2Wg8LfqFGGdmsGLWE/6vdwD1+gA0zxL
 k/eX2V4hUANz2nlM0KRtZVcVPmQbUsMPLlcIRD/L2Z3HCppa/FwaNxGYO0LF2a5tM7D/
 aaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419204; x=1709024004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvdV9IUyScfXO/aRp9jIGXOMeWvG9ot2GraQaMTkQfY=;
 b=NB+77pPYKjHwKxQ2czD63pJtGx/l0gVGwvAJWvtJqNaygq+MOLB3BiTNMybwInwqss
 RN1mur5EVrwzXuTirCMNl9GAb8D5MherhcbeQd0r55ItfRBPUEDD5OMT1OQdx43JExcM
 kShQGt1M3t4HN485dwFP/9p/aWYBRNr+ugsNJVsvKk9mKdNkl3B4wAfx7eYMFFOgGQZD
 djfrD79Os2sS2DQUtl554eHlHwFvIyFR6WD3lzPz8yKUEsNFsaphHfZFQLdCKJDcDKTZ
 9t3cA7w/sEHuNLlJbDlFpjoO3jJlAcfxw33c13/uTIVgubJBSwWioLkm7BqiZhYJTt5z
 ZRDQ==
X-Gm-Message-State: AOJu0YwMNE5Mxo9nITzAHYLTypbBaSjJ6cDN2OexMo486373wEjrZeus
 4/1OM+Ib+lRz0hJWZffwGf9OIGGhIGS36x6pa+t5A1cqpSxiGVESGpoARtBWt5Q=
X-Google-Smtp-Source: AGHT+IEbySSjHls8NAbeQTB2ZfhggNPAIhoEucwffA6V5Q2r6kGdNic7nNDc9SWPtQ5Y0X9uH6FaMg==
X-Received: by 2002:ac2:5dee:0:b0:512:a987:13ee with SMTP id
 z14-20020ac25dee000000b00512a98713eemr4549873lfq.50.1708419204300; 
 Tue, 20 Feb 2024 00:53:24 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:24 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v1 13/21] hw/riscv/virt.h: correct typos
Date: Tue, 20 Feb 2024 10:52:20 +0200
Message-Id: <c391076e9958561b3294ba922e69e38d36b8a9b5.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/riscv/virt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index f89790fd58..3db839160f 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -144,13 +144,13 @@ uint32_t imsic_num_bits(uint32_t count);
 #define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
 #if VIRT_IMSIC_GROUP_MAX_SIZE < \
     IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
-#error "Can't accomodate single IMSIC group in address space"
+#error "Can't accommodate single IMSIC group in address space"
 #endif
 
 #define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
                                         VIRT_IMSIC_GROUP_MAX_SIZE)
 #if 0x4000000 < VIRT_IMSIC_MAX_SIZE
-#error "Can't accomodate all IMSIC groups in address space"
+#error "Can't accommodate all IMSIC groups in address space"
 #endif
 
 #endif
-- 
γαῖα πυρί μιχθήτω


