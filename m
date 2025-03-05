Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0668CC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxK-0001r6-06; Tue, 04 Mar 2025 20:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxG-0001fK-Me
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:50 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxE-0008P9-3D
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:50 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2238d965199so61656465ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139626; x=1741744426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ1xsd6qDsGvTqpQSwZK3MlmyX0e733FFZG9e2F/Nac=;
 b=JtZH09Bd0bvVlhQers7QKf721f6TZ6aiyc4mWHHWOFkebh8ErduSROu6UIpoSa/Zd9
 01iRWdhQDk8DzAidmBekTJqNuru6BNjMEfg6vFJT1xe4MSrRwkZuyFlE726YAM675Wnp
 I1s9o5qDc3Rt59inY7TnwHyKYblp4fYPbBc5ueXK+gAdsb3z6hHsx5+cNVDkN7QMxQxG
 Pz3ojhsCbm/X8aOVNeBWvimNye7C0P9toEXsOdiJptkDqKXkkNKL5bupn/ttPPXAwUyB
 H29hYCf5PNKn7N57b+0Or15j2HNZhF7o13zxkWFHw+fHIxUTItmYSjbUyBiFDmUJ13kH
 Q0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139626; x=1741744426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ1xsd6qDsGvTqpQSwZK3MlmyX0e733FFZG9e2F/Nac=;
 b=bnujT0kOZE22XATu9GoH5M4fk4hxbmGBKwhLHMqmmxCR+rDLQX+rKOTyBTYW6hzNbD
 yxXDbeSpU1Qvh+Ryv14IUZm3TQxScn/hsAi0AHfIQegK9Wx+ceI7uY9tdk1qkdLFjsfb
 Fi+cbNQRldheOkqumtpRc/YtEghJr/UWgHr9QIWB3WWR29AmJ8y9cjxcLGpxaX8lreok
 zrROhoGV3/nPMvvLvvf/KQqAfuA7aX4s5YHgAj0FmaouvHaXIYL4/3hdGmcibDXFbUha
 EZs92C4CYz58osAlqdfSGI6aFRZKg/CBrMrZwvcL/ZKFmmr2pBmPXWarJgD6RMwmIDjX
 uAgw==
X-Gm-Message-State: AOJu0YyMamN3SWf5sHzqyxNBIvdvpuMNYflsi0R1JYVfGXmPl3TKkv43
 27/uVVN8A6ZL8cknzYFTr2usRmySRaOXSH6m4W3uNeR8R1D9f5kvUkk/3OwKB10=
X-Gm-Gg: ASbGncuQWFVsTWZdPy6hM8QUdATkHZ50uzvbbYJkCzMnPGGDU8bNRC8ldp4Cff+P7vw
 f0OU8V4ERZWhgafklTf2VAqoTW0Hki9vo6Tf1pJxS2w5HrPjsMZNtNHoVmR8mphXao95OSWVuAy
 yIVU+MyFTkosc2Zogi5ClnVRoUO9ThFlgFBOkDCAi27rxBPxRaDQ13/7vPQt7tVaqa8hQXIxzAr
 mzPgUn0vb6eScH46naUZlOMeZT+BEfoAoNdcjCCfXRn5H0tZn6etxZyWsKdoeq1GVtssBNfSfDW
 si3R+41OiVoR8tKhlbLOK0XNZM5kJ27/245zdCK/aRoj/W+JzE7GVZgZvRdreEzmmV9FsLCmHBM
 h7Lai9++Fj69Q+M67eccvrLpMGzYXtFntXuaP2IWorjD6O1Z72qs=
X-Google-Smtp-Source: AGHT+IHCp/x7puKoCfDULU2fhfbx1ZH6xyx7T8XFwt8Lp+Mj20l6/6Vii7dNr79LzZK2WCw57x1WRQ==
X-Received: by 2002:a17:903:41d2:b0:223:4ddd:bce9 with SMTP id
 d9443c01a7336-223f1c9616cmr21791035ad.21.1741139626423; 
 Tue, 04 Mar 2025 17:53:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/59] target/riscv: add ssu64xl
Date: Wed,  5 Mar 2025 11:52:19 +1000
Message-ID: <20250305015307.1463560-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

ssu64xl is defined in RVA22 as:

"sstatus.UXL must be capable of holding the value 2 (i.e., UXLEN=64 must
be supported)."

This is always true in TCG and it's mandatory for RVA23, so claim
support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115184316.2344583-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 398 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 99436f1750..4f5e13a759 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -213,6 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 695022d56c..b14ec15e55 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


