Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qs-0002k7-NW; Thu, 09 Jul 2026 22:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Ql-0002Cn-Ok
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qk-00007b-5c
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8454160043aso382299b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652252; x=1784257052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gcGJEAtnepMpUZxOeYdxA0flnG4QP3imNssCsJBk514=;
 b=AJnrn1frn4hoAKCufj8M9+x35idYFtWekbH+aUi5JhPVoXzYsMLh/EdH9Z7m3zfWnt
 IqIrD1fSdeZ75LtmHvOOuAgNGj5qbEj3UWnVIH0UnxXOjPXwv0JIbVoFlCAKhiZ04IrZ
 KTpvcSpG+2jJKwD9g89cKH0GbC5tWtYJNNMI5GviyJwiOntLFqpD3OfEcmom0fwIVgx8
 E7VvMtHCrh7+exGHGHirbwM9XSDDg58Lzo5xMiiKtsbbSBqi3994QCd7unVIVSvirrXb
 2s78TH/gBMs3zQIuDRGIyt6WxbkMxToF2UjhRuu+XXzQjdbcZ+5oLvX8Bj+lmhU4a5z4
 BZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652252; x=1784257052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gcGJEAtnepMpUZxOeYdxA0flnG4QP3imNssCsJBk514=;
 b=l56Tooja+vL1/2wC7sqgvfXlk3f/Fa8wNbQK7MXg0O+33f6rSWLJ1iy/P1dHBts48A
 dzzhg2/vpBGuuSL7D1bxOfX1mqBXphQNpYcmhr8ewMCCVkf8k75zcC392jhDyVGZy84R
 tvjbp7CTI3VaCmja8B80KiMM6AQRmhhDd7j5qOrN2JGAPtx1YtcSLpxkTfP3LLGqpry5
 /gcCFh8/79BWCC6d+mdF3UYr9PXIvOFIvqUIYSnObAF5cLxY+jvCe27lnqAmHSI9IGsS
 cXWqxLSWIDI71fFF0V4Fspp5nZHNBvBQiVJK/PVWRyVPfwkEqHoxhLwnF9jqz0lHvnVi
 imWQ==
X-Gm-Message-State: AOJu0YzvcXe0IpNYsLXKr4DS5/Hiq4T+YrbEqmbg4IPpDUcFRdLLBMrQ
 n/f/QynRY4H7ougN3lhOFEyDiw2Owk79m0sbpKXcjfyk8aZeSKvnHlbTfejQgg==
X-Gm-Gg: AfdE7clZ7i9kaMs3jDTlYXuIe+KanlesACJUWH+rCqXsL23O0NUA+Xwk/Y/0cB+/Jhn
 ILuiJyD6+cUvBq4VE2nwuyMH7tRobAh5z7qFYYWyXjzeGAikGXv8MjxtvFmXdSDXO6I2qBs72Jn
 FUnFLxc+iVOvDeCiVUr/Sfd924YXvm01yIOlJDy4wCwRmhEG31WmGUJmTlDLIHiT2CgdrfrtrNQ
 BiHAirEmH+NS/jdbGasK9TCLNFLqkpFJNYw75TyJRhPniftz4cuZA1fZvdTQFnKwaYMrAqg+pdj
 l569h+ZniN+5R36ygUUlpn1gzwyKwrR4UYZNOsq6tZcpSoNdhSlckud2qTm3kOcjAzcOSrxfwgO
 55pAewYZUDLfR6ziESkQy+EMyjR0wSU6lVlO4CTVoDpxdPwWy8/iHDeGHto7Lfca4YGmJ4a+BGk
 DLh65TmsPqGwcWQvwfY8bByIP9mmspvDU=
X-Received: by 2002:a05:6a00:1a91:b0:848:76af:db37 with SMTP id
 d2e1a72fcca58-84876afe05amr863914b3a.7.1783652252441; 
 Thu, 09 Jul 2026 19:57:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Wang Yechao <wang.yechao255@zte.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/40] target/riscv/kvm: add extensions after v7.1-rc4 update
Date: Fri, 10 Jul 2026 12:55:21 +1000
Message-ID: <20260710025525.1704417-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Wang Yechao <wang.yechao255@zte.com.cn>

Expose zilsd, zclsd and zalasr.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260707072610.403595-1-wang.yechao255@zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index dfcd6e3c77..495cb42dc8 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -303,10 +303,13 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zilsd", ext_zilsd, KVM_RISCV_ISA_EXT_ZILSD),
     KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
     KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
+    KVM_EXT_CFG("zclsd", ext_zclsd, KVM_RISCV_ISA_EXT_ZCLSD),
     KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
+    KVM_EXT_CFG("zalasr", ext_zalasr, KVM_RISCV_ISA_EXT_ZALASR),
     KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
     KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
-- 
2.54.0


