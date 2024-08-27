Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA252C54743
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5Tf-0004lg-LO; Tue, 27 Aug 2024 19:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TP-0003vV-MH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TO-0000wm-6G
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-204eebfaebdso6639165ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800777; x=1725405577;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkHD6ktn6nmHSyL5ZN67NLJg9JbIK8JaSh/uuJiIwag=;
 b=rz55DhfN5CdsdChc6fmaVit8DtgMgNYuJxxomgpXqJ9LiPL1fmvpmnY2UEmildNc+t
 etlI0yEjbheBtDYpsyKmUjNN5bIY8IRwZKJDTfTUSGSp7HxE6p/SxQgsxjmQNcW+Tho8
 hnd3Zy6oPfLrh0jFGjHoSnN0WqrlublDEg7CHE8A3grcIhrFlLhnsco040KqjcENkwQ1
 OFOGxvvWm2OwYFuhkTmAXV+dHmDpEzpEviZjh/QP/Hy584MYaCy2ztoc1zggAJgI+Q0s
 VKc4Z1GldT2FCWHn5mxudJMDZHyRX9xhEhxd3eJFkrcyKUY/GTlCooJzDMxQ8rv5U8oV
 r1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800777; x=1725405577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkHD6ktn6nmHSyL5ZN67NLJg9JbIK8JaSh/uuJiIwag=;
 b=exlkrW1FqHNe1mCkwzvp5ztTDbF75h1mNgNzDOrp/uoPc24xaNa5fjGMpav59BgheM
 SydGfeaGWG3L8V6NBwQIcLVj2zL7C5n0mnkmog6z939+OUoDJjc8i9aggeuNXirysuUZ
 EeyyEm4OTiQH6Ye9kCL+wJ98DOmbcYBO82/8O3277gRwXkMnihh4ee98aXYXymJovntL
 3GMugIrEu89+W1EeaPQnZszSxOVNeDXE/FlQoq3/bpw4g9JQxebz7GAef7LiVEklzlLd
 f9pVV26QGT1IJyJCA72Ix0/OtwhjNdStEgthEpS7EemUMoC9SWONXC4o8vtxg8vZAVQG
 Xlpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLpPIgN1QppQ4L7axIAJA5HlAGQoAVFKiNKqAbO3+ajXi9PbRZvWJYewvMBgs6/FSZRXP3U8G37Ukr@nongnu.org
X-Gm-Message-State: AOJu0YyJYoD/JAx1i4Mx67VQfEt5o9drT0QF1+jVcqKYYfuvhBvl0EHa
 jWyuKmUnqOiXfvwhHvZPsiLya0lad228iLamQpdW5bOmZ53neYpSqKCjOpPcaUw=
X-Google-Smtp-Source: AGHT+IHBSz27Qp5zxFrjlgeAl0s8oUyUBtGaWP0GS4xrjaawqTc79oQufHeAQVtnq+wIVJI1b5Yyyg==
X-Received: by 2002:a17:902:f54e:b0:1fa:fc24:afa5 with SMTP id
 d9443c01a7336-2039e4890cdmr159817575ad.27.1724800776540; 
 Tue, 27 Aug 2024 16:19:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v10 21/21] target/riscv: Expose zicfiss extension as a cpu
 property
Date: Tue, 27 Aug 2024 16:19:05 -0700
Message-ID: <20240827231906.553327-22-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d6cdd81fd8..66dc5af20c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1481,6 +1481,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.44.0


