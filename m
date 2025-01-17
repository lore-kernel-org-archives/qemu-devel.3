Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D0C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLD-0004fS-0a; Fri, 17 Jan 2025 00:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLC-0004fF-C3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLA-0005up-TK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso30652695ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093379; x=1737698179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zV0PNDPeScw2HlnjKQUWWEpZ0yhT4uhtyof3bf4X0I=;
 b=PpG2HgjXPpf8GS4rz8aKh4Z4+2pIe43ocd44pNxYhZoBqTuup1nWXDzmgEBB7BetTr
 Za07UxBFwoUczEeBzD5cz49fpZAj7j3MlGhN6vjAzj2s4LEWBh67HEr1t7oyzO6RqgWs
 oLhh04oyWMFVJenhUrrxjtHOPp0gvPcSdGoBg9BhiciXnT+bxeVILbAKFUhcNuDOyZbR
 tALSBu3Zpo5YEh7PbURLaCn70izeG60Hw4MdwXh87dk3Bh4vdXiCKlsiGWeDJsnh4qjl
 xA0la5gvehMgvsCzUx7nZPYEsPrQAGRq0R/t2FN4PXOFX94pAmH3PEJEOxNRLyl52v6M
 grQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093379; x=1737698179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zV0PNDPeScw2HlnjKQUWWEpZ0yhT4uhtyof3bf4X0I=;
 b=ZdTxFpFFOr90R5rCgCp4GEznqYsa0Z4xM1/cMYext08tObHPx/sXrGX5/t0qnpQAl0
 eDF6ZASBuHHtis5RT8b7aL5w73QuG55hKHGvE2cu4L5Cu4dMNrfvkEB6jVVy40meZ9sp
 excXU+1Y6i6i7dL0XkBy3Jir5Vf5/8U56jOpZOuMpCXG702hDyE8l5ZAu+yLPCozIC7T
 5k86q0vn9phmOSJstcMqTNko3TCQwCrdhKNbzOdg6W+y0X5EOphrbGgx6dTxryRnB3Jv
 XplVMaf6PYClpzD24o9m3csF9515woWfpnb9NQKe51zVs0P+q+is87nzCjrsqqSB9+Z+
 bfCA==
X-Gm-Message-State: AOJu0Yzh7SgOXQNnSv5i+oHcmFEZl3JMfUjLWWO9geBqePDDmQY3yPt8
 TMHb7T+B00o/pv2yXBPgSILXPC05Pbycz8ZiSElyVwYqKJZu4NE9acn3bQ==
X-Gm-Gg: ASbGncuvi0A5PVHtvK9yr80MVTTyJGIVKjSbH1BnSFbeAPI1musX9rjXHDMsVLyErMZ
 lqzEaocEvGW3aVQubDnstO8WXXbmSVnU9bvbyF37Wi6JX1S66CGKWfZC/0Y2SGBHdlXanw2SmFv
 jxXPsqFmEzdgpSQTxRdcc5dPl045vmX82tJY/nO5qRBGOhjnmundfpCCSiZwbmu57NbepORh7uf
 8mS3sfj8VyhRBY5t3xKTh67fmEpkyBtl7DjAU3ruptrLyN9oYAOVDzP1/8oU3xIbsc9xtUAQpid
 rLKHTO+kY478L+gtREopfyV7ZaVAtaAtXK28GTaMqrKy+TFqQ7oFNFhJzwCl
X-Google-Smtp-Source: AGHT+IG+yoIM8aEvzHh8eBp2JTO0+/ZnUqZuRPS/fay0xneZgjeWpQ0PL2zZRpv1sk4mcWRyDsZaOg==
X-Received: by 2002:a17:903:2406:b0:216:3c2b:a5d0 with SMTP id
 d9443c01a7336-21c3560f348mr19836935ad.51.1737093379386; 
 Thu, 16 Jan 2025 21:56:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/50] target/riscv: add shvstvala
Date: Fri, 17 Jan 2025 15:55:07 +1000
Message-ID: <20250117055552.108376-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shvstvala is defined in RVA22 as:

"vstval must be written in all cases described above for stval."

By "cases describe above" the doc refer to the description of sstvala:

"stval must be written with the faulting virtual address for load,
store, and instruction page-fault, access-fault, and misaligned
exceptions, and for breakpoint exceptions other than those caused by
execution of the EBREAK or C.EBREAK instructions. For
virtual-instruction and illegal-instruction exceptions, stval must be
written with the faulting instruction."

We already have sstvala, and our vstval follows the same rules as stval,
so we can claim to support shvstvala too.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 346 -> 356 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 07bcf96e86..4f76efc298 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 460808d017..15b82b5bb1 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.47.1


