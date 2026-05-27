Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A05CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYA-00035R-LX; Wed, 27 May 2026 06:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBY2-0002lu-Et
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBY0-0000n5-6z
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4904fd4f6aeso38560985e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877894; x=1780482694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HV1vLCcK7EUtwQJdCR08qfhnxGmTJJ9Sq5FVJYpXV8g=;
 b=KaKKzafwHgOXwsDU6qIsa4ehmhDAOBH74L3DQWuK3vTF2UThSv3aw4eMJJZ4xUtHDH
 1TCFDh8qzSP4Ka/uOZM8q0zIeppe0fzUVXBI9LTZ5dhrZ/7FeiA6kfTSPabLnccY9iMd
 XQ2g0tKq7UtvoudViwjX5dmsGy7+l3RFPNSQdzP4dkaBnpvXWpYZ2XL/Z3z9R/fjss/X
 VAggttLZLUdrMl9HtltEhGnXyN/wBONJtj/YyyEhxCy7VUi5dMTKgM8eynTFDktMKUp0
 PHsL0K4Hpo7P3z9s5PwImLK/mQMkrFCk1ren4VI0xwNEO/y1N852GwCRLZJiXvXhOBVo
 X5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877894; x=1780482694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HV1vLCcK7EUtwQJdCR08qfhnxGmTJJ9Sq5FVJYpXV8g=;
 b=cJDLNIdOrmQPtK458qRqerjWcsyas2uVqzehR3qRpEaUxwXlccNITN83uAGYohXmBB
 BkWdvzPMjImrr+2u+X6+3v2nxg4PyZwSO582RVrgd796Q2hcKHxEqFVEIFgY9clR3wjQ
 AaG/qjr93eOnkcqPrZ5OSnV1hM+sZWdbCUWhEt9Xw3+DM0Wr1x8WQRvfhHdrZ+GczT5D
 M5xhEgR1I6Tm1X01pg1JRvxWZXBPTIf/YaO1DhDzl9Uf7He+M+XAYkMqdLrKVKivtOwz
 EejGzh+vkzZrRWepcSsO1VHRfsOWxezuaM+O1U4VyUpIwIj4BQTjzi8re/PCYRv2z4Dg
 tbWQ==
X-Gm-Message-State: AOJu0YxjyU3wyDgrA1wgupEqALvHDsnL/tjPq8TtdMImorFXphCya6ki
 6sTZ3VwRmCQn0IcPKshkN9vla9+XDB0Ll60qV6+U3jTqtqQ2w7h58xnSmwwcHLg7jP2FL3nmlOs
 e5zBWvvnJuQ==
X-Gm-Gg: Acq92OHzrXruA9RF9Gc/+2B7kakmOUngPVnJ35NXey7+mj/IFNg62Wmj3754PWmttuG
 xqyqe+wUQd1dfC456tyGe+p0zdQyFkWEksWBprfJDPUrsSjuCl1VvwMXy4wMgxB7Vw0RvqCS/Fe
 HBsduJKN+5RdTvbOMwEJCs8GzmnHL6CiAsgX22fl+dDU/IeX9wB1RNcSYEjI7lWrxw6r62hi3R8
 JGF3OWhi8y2qXra9A80nqk40rnUS0han6yl5/dzzdwTRzPTXHeM5cEVFH2hnEhCAC/oyWpSO+CT
 bCndf6vHxBfr0I4Do+dAsBG1slHPFw8JuUTP98856zp+x4VSLWeh+6AEqkoJpnG4UZNWh8fowta
 5K02wWCsyWutQFZKaOO0MqGlpRHLUDbLxRz6HTBzFpdzDLYMyMTYNR5mag7uBdq/SHzRwALEnfF
 jAKP75e7wyTVaY9rbvZNd+G4wmsQdq085rnjLgzI5bzbZeahFrB6o7nTM=
X-Received: by 2002:a05:600c:c8d:b0:490:6869:46d2 with SMTP id
 5b1f17b1804b1-490686947f8mr177121815e9.0.1779877894146; 
 Wed, 27 May 2026 03:31:34 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908099800asm21192215e9.5.2026.05.27.03.31.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Date: Wed, 27 May 2026 12:30:12 +0200
Message-ID: <20260527103037.4461-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add the RISC-V privileged ISA defined bit positions for the Supervisor
Big-Endian (SBE, bit 36) and Machine Big-Endian (MBE, bit 37) fields
in the mstatus register. These are used alongside the existing
MSTATUS_UBE (bit 6) to control data endianness at each privilege level.

The MSTATUS_UBE definition was already present, but SBE and MBE were
missing.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260527083151.17876-2-djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7c..3f146a43fe4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -629,6 +629,8 @@
 #define MSTATUS_SPELP       0x00800000 /* zicfilp */
 #define MSTATUS_SDT         0x01000000
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
+#define MSTATUS_SBE         0x1000000000ULL
+#define MSTATUS_MBE         0x2000000000ULL
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 #define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
-- 
2.53.0


