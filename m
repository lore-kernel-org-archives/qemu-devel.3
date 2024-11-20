Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E4D6E2C9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfQF-0002PS-Km; Wed, 20 Nov 2024 02:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQA-0002OU-Qm
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:44 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQ9-0006PG-95
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:42 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so3092144a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088800; x=1732693600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRHaR9pcBAF9H3M4At6noJSbZrF61K68F3kyhCd72IY=;
 b=O37um4Fyx3sMCD/6QODtos4skTx21fc18kxLuGToLxTl3M2KfMtrrEiUC92+xVINBG
 izEJ1WDyfBJpt9B25K/PDc9nxQKtXl3sJsyXKYZXIRsbnGL4hS2ltDhYyZyjRwNUZ8Ma
 l4Bxtt3Ujs2x63RPWbTQPt+uIkmKTupwr77ERgskUF6kjc/oTeLNIOCTdsSFkzPgkuYt
 Z9ftq/kbJRCzKLKLhjiSZJUIVivIVDPLagM+alnlDMHDvvk7PS1rctD0VvKrWn/9ukV1
 i5CABcVxSt4SxSjJ2v10mXY9dLmfhRihsBITBJPurrVrn3oT8SbE3Bv/LbL7LZ8BWxyG
 j2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088800; x=1732693600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRHaR9pcBAF9H3M4At6noJSbZrF61K68F3kyhCd72IY=;
 b=WtJZYAs1du9cr211gawf97G7nKwBHjo281RczKiW7yJIc0RBvLN7u/3XpNOKFcLM7z
 LLrZWrYGQsW/4LXYIZpuke5CVPDlTXusA0AmWki6kE763z8e5BJDV7sACR08pMSw10dY
 sMimnGZaaBG/lZdtYQFNGO1+KrnwRrkmLTD+o0Mclc9RvdWDqJz5IK1rNvXrRLwjKugv
 eLQtP2CkalM8lrfn+4Z129U08Zi0V2vWTRJJyntxtUUjcaCarugDcafWQxLKVXt3hpfs
 iYptTnzVBMaFkzhMPQlSrb7HW8G+EMQyjaBCSA6z8V3qQu7Ou1pbmNsaf4JaHC3w5if0
 1NEg==
X-Gm-Message-State: AOJu0YyWzUbxQwWw2zbWjgPO0uY/B/hoPPdobeVK2iQdotrpkwxLyK7R
 AhYbVpwVTnm6r8zv7x4qW0qmO/Tjldw2SlW+jMDMnk6PDdTl34fkObQpOV1qoIc/h0z7PHumvw0
 augL+1ldD+7tTryu37jHk+p862WnQ9yOjyktJCEmrk4BXkbdBxuRXCvfHgm5PWa8wOiZN+5ZDve
 Zam3Ay+4LFEBmWTbpgjjWAQ5uGAj1StFzSbAM=
X-Google-Smtp-Source: AGHT+IHqhWv6J413TU13WsyC8gl1egXxQ/eIZHTFWmLXR4B4ToJ1WO1qNLAM8crBNbdRN1dvXXVaTQ==
X-Received: by 2002:a05:6a20:9195:b0:1db:e1b0:b673 with SMTP id
 adf61e73a8af0-1ddae2f047bmr2563194637.9.1732088799524; 
 Tue, 19 Nov 2024 23:46:39 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51fe0sm86206255ad.233.2024.11.19.23.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:46:39 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v4 1/6] target/riscv: Add svukte extension capability variable
Date: Wed, 20 Nov 2024 15:48:49 +0800
Message-Id: <20241120074854.1767780-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120074854.1767780-1-fea.wang@sifive.com>
References: <20241120074854.1767780-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x534.google.com
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..d8771ca641 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_svvptc;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.34.1


