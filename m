Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8718C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZU-0002N3-Nh; Mon, 24 Aug 2026 01:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYn-0001Uf-Nz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYl-0001zD-57
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2d58efc7356so34133965ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550566; x=1788155366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zVHz1vI4ZmKFiVEVtHQt6VWbe6dmqIzbriZ7N5663A=;
 b=hGaC2Pmcf5GTK37GlsV80CdVqtiDeQoDYpfRkBjLQqqh8O77hrVhkB0VmJvJEIQWjO
 9q/jpeppc5gfwToOz7xs04rjep3aMbR9PHbg4AMDHI/ampmgSHihF/ruhGNcurtnzr9C
 AMJqT0ZVegoEK8IP0piqLmK5uMHPsMsS7PMF0N2a6QlHNYEvywNwZcmy8WHvE5P1zxaS
 7XWEmjMkTsjywDLZ8iF7ddWmDkvat+lSvZixMmIrfIemZR7mGaTLHzAhMlBl9oqoswvd
 RzzWZQm2tyrMImlUIOhmdmj0fyS01dyZp8gn76sHn1QSYXukB44vsPE91C++LwZEEpa2
 mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550566; x=1788155366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0zVHz1vI4ZmKFiVEVtHQt6VWbe6dmqIzbriZ7N5663A=;
 b=HYqVttWfA/hVCy+VdWSENJFm4fPj40a8kAq8Lj0xaCHUUqUIFa+KuC7TaSeZsH9WrO
 orEED2hzStBGfzVDxebHZrq5mi5sy3xKXoQXoq2I46pe+M6QhRP2P7BQi3gtAtroMhZY
 3nqBVXMGG0HoMWbS3P4Pm8Mtv4cIYYKTvFUFDx0idDhTNzizRqUg8IImaivI5VBzY2Th
 54iJUNLBY1TArXFSVm5R1EbEhDobfKrvJHPP215Kpfgi6ZwLB9BWCPAmOuxSzUEO3Zb9
 4UgpzePXSAyxYzphLbLjeUQZyqX8UayUm7QtjKgyT2uFYbedRKvwaac8AX0a3c8JxWBm
 7+3A==
X-Gm-Message-State: AFuF++kOl69hB9l/0EFvWbR9IW93UCQjmBxJLsrPRI5cftiWBsd+bDSi
 EcuxNT8QHNc5beAG7KB4wEWz8Xu2crVg6mw8iiYk2YLm75XGgiKe1zImxCgjlg==
X-Gm-Gg: AR+sD11DHogLQ70zkDGcPaaAHacm2Yv+psIKZ+tImtx8F14eO49aePHseDliN41Orcc
 s+KAGaMH7365gfHOY5VKb0EfF5ze8PiDcD3I7fK5EctzRu8mDyZV7nXrwbUsEnhoNhYnIa5D5dz
 dAyslHR8jxedzF8lPAxrS2AswkZVdG74g/b6whmbW/4X4mACCefB69+JTutkB7xMMFa/04hoF4R
 zg6FPWuGXigNOdxxtXShXPxKBOezywanhuTF0kS6QGYi1IFzr4Hprscz2/tMttNCHzxOOl/x2fE
 67XdMRTQHhWt5kt1Xntlh4ziCr60qUwQKv9kHs2x/wwsOsEv6uOciOfAzNlu/Jfp5gJQN+UStWg
 Q7YX/yvSxVIT15AV2qSx6GUGEGMF6oe42g1X9XE3OmjBdH030KBLyH3MT6aL8ly8cG/YnwXdKHa
 G7yNY2Yc7EVjzWBkc+9ljdxk+NtDgwcB8dHGLf5YDwEDW4NdkqrSN0aCCADiT6e6NCbf2gsy9/c
 CJyKQ==
X-Received: by 2002:a17:90b:2cc3:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-395df29666cmr29922276a91.13.1787550565576; 
 Sun, 23 Aug 2026 22:49:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 21/96] target/riscv: Expose Zicclsm as a CPU property and
 update RVA22U64 profile
Date: Mon, 24 Aug 2026 15:46:51 +1000
Message-ID: <20260824054806.2790041-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Update Zicclsm ISA string and expose it as a CPU property to allow user
to turn on/off Zicclsm extension.

In addition, Zicclsm extension is mandatory for the RVA22U64 profile.
Previously, Zicclsm was enabled automatically when has_priv_1_11 was true.
Now that Zicclsm has been converted to an explicit CPU option, it must be
explicitly added to the RVA22U64 profile's extension list to ensure the
profile remains compliant with the specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-7-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b2693f4c20..d8f239e41d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -165,7 +165,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -2316,6 +2316,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
         CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(ext_zicclsm),
 
         /* mandatory named features for this profile */
         CPU_CFG_OFFSET(ext_zic64b),
-- 
2.54.0


