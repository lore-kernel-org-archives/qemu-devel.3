Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7B7D5E147
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KhT-0004kV-C7; Fri, 08 Nov 2024 03:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhN-0004jL-IP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:36 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhM-00010F-4A
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:33 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so1315029a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 00:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731055830; x=1731660630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpdTXhrfGWhzkEvHhJADXT67hFoVxXs5R31Zu4kbzx0=;
 b=T5eJBzSG/Rb74McJHHYJP+yWNZQMF/cS0P1JSKP4tRn1FGxpiTPz1wqZubjXO46SPy
 ZpJk2CTRgHu1EXyGdWRj4c1xxPrujiC4n+K/9aBl6T/OWkk0KdTARz1KHe3iUkAR066n
 AheYa/qu56nU/KfdTDN0K5EXAU/SPt3IJTru0ijmLyUsyVUqQFkx3KLyxSViWHDznwLU
 9j5eEuBA+GK3FFnygcxjXWoS81m0qZ3KLblPnztJIjoC1SjiS2hddy1vJaWtWJFFjXks
 4sxPn2HWyQIINa1sc+6buBl8w9xuDG+IS+h9kxNh9RK4blCbP3laYxAY5IIQAKmNgwVE
 VDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731055830; x=1731660630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpdTXhrfGWhzkEvHhJADXT67hFoVxXs5R31Zu4kbzx0=;
 b=Mi487bmU3XR5Q7uOHvudiRGqxtdRC26KLQzlLGPMxYTYBcV/GuKpUEWDSOvWHITFxI
 faYjxVRBHxhJ9XBIoaiGxFJrEC0CNjsF4CieHJBGqy8S4H7TfDEojzYHSqr9YSDLGfUr
 i7ompwpxSxoyrT3t8BdfJogp1vfVDbqc5pycLs+gRRNCptrHmvgSNKqSolb9RrslvDGd
 KLkFZcfihHuwvb1Zv89hvYf/j6jTsiT6MVL2hEwrLeNpbs63ZnhUPECMEdDs1gwv0rIB
 kkU3DHbB8ozanrUo4tYj5y5AAVm8IYBve1aTIDxFRt2yoOWLAu7PV0xzNjydP/Lhqt/a
 Ndfw==
X-Gm-Message-State: AOJu0YwlwhXcRv3htcPW7QYL6TXpWjjfuShJWFFNkVnOJjQ2NnsCTyEA
 IBM2zM8qKDA4unBIeFL7tG+UqiO8QCTr1Pe/6SikyWQqBg82i5l+tG/TeKkuayxxtk5KkGys2tN
 DOzbTBQDk/9t8BK5gmSQxj5/l2OytaEWRu6BlxiH0Go8KYfz5WY4tpg+nDtw/YguhhS/n6zpPkb
 u/jzl9tX2UZIzkTlziPyPhHbBTKnIYXTGNhRs=
X-Google-Smtp-Source: AGHT+IE0VWM7WItGPhD8JvrdN6o4vziLJJvWhejp67c2rShY+D1iAAXvlBzb80G3wlC4vrqAcV1Teg==
X-Received: by 2002:a17:90b:4f49:b0:2e2:d859:1603 with SMTP id
 98e67ed59e1d1-2e9b172aeb8mr2840309a91.25.1731055830313; 
 Fri, 08 Nov 2024 00:50:30 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541da0sm5540135a91.13.2024.11.08.00.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 00:50:29 -0800 (PST)
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
Subject: [PATCH v2 5/5] target/riscv: Expose svukte ISA extension
Date: Fri,  8 Nov 2024 16:52:39 +0800
Message-Id: <20241108085239.2927152-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108085239.2927152-1-fea.wang@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x529.google.com
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
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..69187c9aa1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -200,6 +200,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1595,6 +1596,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


