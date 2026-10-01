Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB62BCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJ84-0005aj-3U; Thu, 01 Oct 2026 11:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ7G-0004lx-MF; Thu, 01 Oct 2026 11:54:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ7D-0005aO-Jx; Thu, 01 Oct 2026 11:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=r8fnV16K49SGouDVlx/nUjg2i1XnIcexpJjMjpfT1+s=; b=rsQL1+Z/ZNkxmpq
 G+v/76DPwZIl8u/bYbylvs0ZVrD8OfMM7pfDNWAInMKhFKo1kVBZ6yHj3B+tdj/rGfuywbn53WO/h
 Pe/OjiF3K4gyIBZFJG17ykCNJwQzWghDH0A6lo5TiZupngZmcZM3W4LCB+cOnX5v/BismON7ay7kX
 MM=;
Date: Thu, 01 Oct 2026 17:59:36 +0200
Subject: [PATCH 13/18] target/riscv: Compile riscv-qmp-cmds.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-rv-dedup-v1-13-ea69b07afd31@rev.ng>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
In-Reply-To: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790870392; l=691;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=Brf8Jld6v/iW4XafY2JsD/f8ENHSENhpUxK8FMUJb4s=;
 b=0cD43CxXpHrYwr0NcPebrk+TC+K1nEp6BDplDK0e5dDVn9d1J44phf8igUhm0celf1dSiHpdl
 FdjxX4umNARAIrboSWhr3b28mcvaRJaDromSpyc0vHk61JlyyS1cNwg
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

File is already agnostic to target specifics at this point.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index ba38e421c5..8d0b3ed4ce 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -26,7 +26,6 @@ riscv_system_ss.add(files(
   'monitor.c',
   'machine.c',
   'time_helper.c',
-  'riscv-qmp-cmds.c',
 ))
 
 riscv_user_ss = ss.source_set()
@@ -38,6 +37,7 @@ riscv_user_ss.add(files(
 
 riscv_common_system_ss.add(files(
   'cpu.c',
+  'riscv-qmp-cmds.c',
 ))
 
 subdir('tcg')

-- 
2.52.0


