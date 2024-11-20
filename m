Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE6D6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfQP-0002V8-FS; Wed, 20 Nov 2024 02:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQN-0002Tt-8V
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:55 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQJ-0006RO-8e
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:55 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so47596565ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088809; x=1732693609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+R6CJpWjdehLs2i3GXP/SYVc9nAzma44ryk0pnQCtdQ=;
 b=nYTuI36SxaqsV0WIqZiHJmLYjaRpSmNphkBv4oKim28y0mXXRsvZc4BAvrPUISaI7F
 Zzj2pjTHbtkcV3cnD6ceOo+81ivFFXMGhXEH4gbSZeCzQph5sLR/uR8Cp1sz/m0dTXIs
 qzkDNVWlkfpoSQ3SVJ83b1vna0iXtg4MUCCO/JCDsY7KeiVm5UIg7NUOm2tNC7K3CIlK
 MNz0XBF9BP5JtommtLVhBjYlkMZWJFGvp0LQCVdJ4XcnOQ8gaeTMA8gMdjOgCEF314Xp
 yDW6ObRJHkHQyLTTN+jpHPnDubXxc/+dxrY6uT0K+4DLqrizGJo/hWWyxgaioecZE1kR
 EbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088809; x=1732693609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+R6CJpWjdehLs2i3GXP/SYVc9nAzma44ryk0pnQCtdQ=;
 b=N7RsqvkJtKWA82aFn2HSMkLwDJctlxwy7gaiAcZpRMt6TP92fh2fzIyosrvKfkVcZg
 p3Iule6DhVOwSSR4EJSBFrs7F6/bEjPUPwQpmYj9+/mH2ccXJRr//KZ5AZqcgR9qIg7I
 ztZ8gug8tUme6zqzjgUSSkn80wYMvkhUg3du9p4fUENnqJJLRQZGIKEw/hmKqyt2Xm3I
 4oZoPmJL+UiCPaBCe9aRFsRnpHy/liR9UDETyFTYlIGX4QRfCkp44pS/b5qcEvULNehu
 KKOYVbLF/FjSThXD+ZgyJSlkWzpsro+jx6dFjWTatcNrB/clQdYirYPYLrnhjC42aLlH
 UJCQ==
X-Gm-Message-State: AOJu0Yxmv1RlCKZR6tCJFjl/vyKIbYLmkwAPhlzlJsHogpyxffMAm1IJ
 ysgJqD/addls9omzXuxObML1AIoaMsy9b1sP51M37e4JznCn2fjgwacHTsWi0pNWFOHIpMTInxT
 WH1G6eTDPprub1oOWcw3LNDZYIxYP+ALpsW26A9PCw14JPrqyqzg5A4URHDHG85yC91ARB9HRDo
 j17bRyzuRIqiywqWLi+6HGm/McbZViF5DDEmo=
X-Google-Smtp-Source: AGHT+IHWMsNukUswGtL8YTBKYdPAr8BlKcsivdEBg7eYa5hUCD/qQnIhE8Z2bVDT9MO2AVC3gDZ+Cw==
X-Received: by 2002:a17:902:e804:b0:20c:bbac:2013 with SMTP id
 d9443c01a7336-2126b04804dmr23848095ad.48.1732088809490; 
 Tue, 19 Nov 2024 23:46:49 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51fe0sm86206255ad.233.2024.11.19.23.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:46:48 -0800 (PST)
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
Subject: [PATCH v4 5/6] target/riscv: Expose svukte ISA extension
Date: Wed, 20 Nov 2024 15:48:53 +0800
Message-Id: <20241120074854.1767780-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120074854.1767780-1-fea.wang@sifive.com>
References: <20241120074854.1767780-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x634.google.com
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

Add "svukte" in the ISA string when svukte extension is enabled.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..6d3e9d563d 100644
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
@@ -1595,6 +1596,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


