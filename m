Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0402C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjURc-0003M4-Mb; Tue, 14 Jul 2026 00:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURJ-0003Ku-W6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURH-00083c-Jq
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:12 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-388b404ea89so497453a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784002090; x=1784606890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e+FKafERtewdflmiwwRoIFyp5qa6SrhFattQ2cDKqSU=;
 b=Jr33Dr1ktDWZOkpPHdXrLvVFDyGiR2WcwXYa3WcMG4twcDy+f3orxdLw/pvfuTl4Cj
 +qVTkDdlUx6cj1shfNDZX7CZ81nT9h4EKawcY9VR+eil3wsLAMxvOoBrjI5YQnsT/U5Z
 /kbjpcS8mrmrvO4oPdcjuA0cKOsYdU/h0PBF6wtL/dAnVT/hrDyZVua+XDLKKY8safI0
 i/BzaYBnosB5dQfW0lZpru5HkwXw9ny+dry0EQV0NHJCC8Zn02gUNhNt07bLhfnQS1DL
 gdXrqDC/ldJO4SlcId0W4g9+tVVVoOFV3/JmoryG6hjtC+d81kwbBXOE92bPlaD+f57b
 wmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784002090; x=1784606890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e+FKafERtewdflmiwwRoIFyp5qa6SrhFattQ2cDKqSU=;
 b=IgMbs27e3PAXRX+h2AaHfWcd10uO9O9xjnvF88PZG69Rol9Ky73vcc1TqNuSVb9s2w
 SRmbAaMnQ79oFPM+HOFIxsKlxSQdhlRzyCNPDlwK3OyTbrk5uEj2/+MAZeAVQPx4iBat
 zGhqvPFBrovlx55y28rWQYNVbR2/Y4XrhGWv/qkY/nXi+GCrl/nuGMC6MC03umEt5YOm
 GIZO6g4+i+KIXXZK+uhtVnhQpH4cFkWCsX7Y4fJBXEJLzVS3uP1pWSyrhvg9gRlMk0fm
 YraXoR5EF1X0bMF0sBg6va6P1siNHVsmrPUCrDXz/f2UI2z6gPvcHel+ZgsWDGKkQ/mR
 HQ3w==
X-Gm-Message-State: AOJu0YwiHFaRbdyG6MoiuQ0zZ1RusLGJVH3+M2oZOWXMT2yClB49lnLh
 N0ZbkbPYlGFbBOd8AUyH0GXLwOHalB0Q1UXmjXtemi9YifSkQwb0dpzUJXuleQ==
X-Gm-Gg: AfdE7cmCacvvKLki4c1Rbn2eXcJjq9XAbN4/Qjcfr2mAax74dBnQyEOvtcipppVAGyc
 CbAIW8N2BUtCCCkq1N33SMY/Ubtm3yphAX7PPmA6meQ5j2GBM5cVesoPnLy8BQZM45fH/axUgiO
 8DaprZ9WQ531ZVL44u+UdIcwsrWv54MRPDPGKFFsyvvT4kJD/ZO6VrQcwrTwklfQiWMSbvoeTKh
 cLxW27glbrClicHJvNTrp7otMELms6o/UZiJmAR8Lcr7cZvMFOELYpRJMdwrFKrmihRuCbTYvyY
 TqN2X12tkfm70wojMUXSYJb7mdyDTsadMwnvsZOydirDnB+rQQjDk98NrtT44QQttWdO6xpEY9O
 PJQt8ONzNjVisd7kgyYROzxfz/+ZeIyoVI1sJTxPcJXUqUtayiQ7yHDu6AjtDFd3F8Xfmhz7god
 2hrBZLsu7yZbOy87Fu2GAzYVELr2E2aaHvf1H72bJNqA==
X-Received: by 2002:a17:90b:57cb:b0:36b:769c:c037 with SMTP id
 98e67ed59e1d1-38dc81978ecmr8690298a91.5.1784002090042; 
 Mon, 13 Jul 2026 21:08:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6cfbsm778840a91.3.2026.07.13.21.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 21:08:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>
Subject: [PULL 1/4] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Date: Tue, 14 Jul 2026 14:07:55 +1000
Message-ID: <20260714040758.28332-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714040758.28332-1-alistair.francis@wdc.com>
References: <20260714040758.28332-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
Conor and Sebastian as people to help deal with the fixes.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260513023859.518484-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e25df9493c..611845c626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1760,8 +1760,10 @@ F: target/riscv/xlrbr.decode
 F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
+M: Conor Dooley <conor@kernel.org>
+M: Sebastian Huber <sebastian.huber@embedded-brains.de>
 L: qemu-riscv@nongnu.org
-S: Supported
+S: Odd Fixes
 F: docs/system/riscv/microchip-icicle-kit.rst
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
-- 
2.54.0


