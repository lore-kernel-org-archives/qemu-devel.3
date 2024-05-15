Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19652C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79NN-0008Lm-Dq; Wed, 15 May 2024 03:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79NL-0008G6-2i
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79NJ-0000Mg-EE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso2710899b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759310; x=1716364110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puBYhI34uigvIMwKdPxu7OXATwqoJShcDnpckyqDkpk=;
 b=PxbDRFCGsqCTb7064Xn1x2Misu84yrPKKqC9bjv9jXxx48IJzwdgnW9KeF34hCnBV5
 74TYzjIzucD6OTKcupD2dH+32z6O0lkX7OehqQJr+11V+BoGOydexC+mCyZrjFHS5uoT
 o0z0iE0AXsrVuqXE8nzgbwzUgzLfqtEy8PM4ASb/rK7N4+9DA4Uhh2TRl4lzcIOl5v01
 1SY3Hmp8/8KiKgQhxNKUAoYwOCI6Z2bvN93lxLnkInuxGJafkmV6qihDXZd01Ju6Fh35
 AJvOmyqBxt0HpQupiwJLkr2NYBZGo9pyclIFHRUtG1Vsu4Kd8mbq5Dgf7IAljTnlon8n
 rmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759310; x=1716364110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puBYhI34uigvIMwKdPxu7OXATwqoJShcDnpckyqDkpk=;
 b=XLv2eEGJHTdgW3MEki6ssMwE2YMkKJ+ZJjvEt7rGM3gAmJUwEG9di5RDMf4/cfLpU0
 PDlaL4GIZEkmmB4ioZg0Io8urpJTxsuCR5cd+SuePkuf3uIS4EJxOCrS0bIga/kF3yrD
 VYwh3OKE6b7vfNA9PzSo3GkM7+5BE9tSHS98jrg4ifKANjVraLVRVonVIUPpjkxAnrLl
 SUwNSJbsRizoPMzg6kUlYUMhrWRtw3GrXPdIgYOG038P0TdzD+TH73SBgCgf+dXKrb10
 I2YnGLH/rXtc8RboYdHXzRrF9J4pHWlhlAayMWtN6oG/6EcI3Isd2h31M30Kd237o+iG
 A7rg==
X-Gm-Message-State: AOJu0YxLeTvBKaVr/HuLXfCkTjUWDWq18icyFeoFiMndq4+6oO30nx+J
 IjRPuZ0E/K1W3t2QfBkWiEHe+RVXjGF2sB6pDATYSxyUTseauspGSg6Zj4TeCoKBPIVHYsF7tL5
 5KOmoUV3izKhp5U6m2L6UzUbNCrgXVlhCVVAAUL6pEyYSf8ke2aKxcRnyXsi4sbgrCiBEhICpkz
 VKPOkgC8obMX3re4Ca8ztPqBw1FLmN3sQwvF4=
X-Google-Smtp-Source: AGHT+IEAke5BLdsYSlbnHg+sx6yNTpK5RUV1Z0Qtu6pfRwYRjeeuQyo/dCuuB7wXEnDKlIoE1giFCw==
X-Received: by 2002:a05:6a00:3d49:b0:6f3:e9bc:cc3d with SMTP id
 d2e1a72fcca58-6f4c90905a1mr27161537b3a.3.1715759310189; 
 Wed, 15 May 2024 00:48:30 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm10389060b3a.162.2024.05.15.00.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:48:29 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/5] target/riscv: Reserve exception codes for sw-check and
 hw-err
Date: Wed, 15 May 2024 15:53:36 +0800
Message-Id: <20240515075340.2675136-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075340.2675136-1-fea.wang@sifive.com>
References: <20240515075340.2675136-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42f.google.com
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

Based on the priv-1.13.0, add the exception codes for Software-check and
Hardware-error.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f888025c59..f037f727d9 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -673,6 +673,8 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
+    RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
-- 
2.34.1


