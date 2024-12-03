Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D15E6C5F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJjz-0007xz-Vh; Mon, 02 Dec 2024 22:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjx-0007wX-Oy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjv-0005a5-V4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:21 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2156e078563so18085525ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733197098; x=1733801898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG3P8sWTJ54W6skoaY1t1xd3E7zmiL03Dx51lEImsvQ=;
 b=ENBVvGVswUdRG0iSOpaJmVkm5mKOZxJwVLTwr3MenoxxGi5Zi7QVAZdGyzI+SVRkTa
 Ys+3vbKAB5H2vFNMPupuWXJVIfiWF8/8goJPoRcIQ5AwIkRbtqL6EchACEMafaRDENJy
 1BT6/pIVy+7L94QY621mhlhHxhMUyXd8zT6srxppH+j+lPmVNbEkX/l0JJoyBZ9jPcaZ
 JDbKKVlXld0KZeNFF+cJi964fIfM4QaTdNWnFNv476LEkTgG4WMawmh+S7Udo9jV9Kxw
 ln+CLHbCqU5/3bw9raov69F8x39MaUGvnfDo0vjftMLCi/T5sDLSRcWmrhscTSMBqmSm
 5Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197098; x=1733801898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zG3P8sWTJ54W6skoaY1t1xd3E7zmiL03Dx51lEImsvQ=;
 b=sTjgXW6vJqB8b8J+A7RFccRgxPZaiMxgAHE2/TT8fPeusVDskDIHMLMv5ALtvRhJ+R
 oRmGZzqEo6r4GpfBzHDC5wDdgIZAKxpROjTVDLJocyykb2vWIGWdLZOxaBTwz+eTMua8
 /kkyfTwOTB5UmSwXmZrrakmc01LFj13fUlMi8XNxVlJ2R3pYGs8UoVdFep+rBai5HSZA
 UfiQ4jj2p6QELYSEngsoQoZUx0Efhl51DdT8JcYmdOq9klDvjbRhv2qN6uzpI4ut0Tzx
 B6onaeuq2v5FJWbACTh0dZZAAhj6amhVcVh6F07yRggtr4AbeQUk863RJf7gQqhWmd2C
 qOpw==
X-Gm-Message-State: AOJu0YwBH0ZekvJFyj7/KApFUG8aIvp2Wv9UYkoOaK1wtr04lOarg7l8
 AmkmL8xB9044Ux8Xe99HIgDQ1f6J48b+b/R84U4QRff4WmxsN5G+HYK1MZZRsHx9BdyAMdmMutP
 85VLU8QUkVskYMzIFwPp2kdxQ0zDD1xlruIeTRZI9hxwDm4CPomBXOcF1JEU07vuI2lw1j/r2an
 uYHCpnJW/vFN6J2/UoS18eISpOpkQB5hfh5JCRSA==
X-Gm-Gg: ASbGncvPD3d73h5f7mQ1P0asiFRihgEDoY9heOzgoiy1mZ4YnVrR09j6wK0V71MvAJL
 gCcT1EeyBFKYchXcKYmGlLKWpsesRed7LEfEVfOdEuhXCBguKkYpy3Zio2vSlUUJ+eflCVsIIG/
 djMNYsr3XNS8GY0nyGFUaX4fCi8JfuQ7bqMk7acof7/kbm6buEPodLveNU54ZeV6DgdFamiY9va
 eJJxnjpkWQX6C9Su1vMu4CIus08meeAIIU27KfKjWPg/3kyc9oGMDEC3UUIgCEtk+dopZSYZS/L
 PBgLZoVz
X-Google-Smtp-Source: AGHT+IEpV2YVstExh60DlC/JmmsYebJZFXHzs6amPgyrOb478bEiin5HHyYAmLyQOP8GqG7+TQlBVA==
X-Received: by 2002:a17:902:db06:b0:215:7dbf:f3de with SMTP id
 d9443c01a7336-215bd2005a9mr14010545ad.28.1733197097796; 
 Mon, 02 Dec 2024 19:38:17 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566732e1fsm47111135ad.134.2024.12.02.19.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 19:38:17 -0800 (PST)
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
Subject: [PATCH v5 5/6] target/riscv: Expose svukte ISA extension
Date: Tue,  3 Dec 2024 11:49:31 +0800
Message-Id: <20241203034932.25185-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203034932.25185-1-fea.wang@sifive.com>
References: <20241203034932.25185-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62f.google.com
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

Add "svukte" in the ISA string when svukte extension is enabled.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8447ad0dfb..e10240c02a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1661,6 +1662,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


