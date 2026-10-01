Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C2ECA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJ8A-0005oR-No; Thu, 01 Oct 2026 11:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ7E-0004lP-2X; Thu, 01 Oct 2026 11:54:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ7B-0005Zb-9C; Thu, 01 Oct 2026 11:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nkYkSGfN1pD++4jmG1v1QhxL26UrZEZF2cfjdMHZqd4=; b=VQpwgHd7CC+ui0x
 FdZWI+cI2ScYnARnrzfTqe6nWrCRA4B9w+vFaH7TdkKOSolOrvILmpt29ZLNWcycd5HKglQxcZ6fB
 LjAv1QmPwxwrRHzgvSZxZePfvmqW9qTor/LW5/jq5N3VhQSCa3HNg6EHjfG5r1QWbmE+4mHHyt/Dz
 58=;
Date: Thu, 01 Oct 2026 17:59:33 +0200
Subject: [PATCH 10/18] target/riscv: Compile cpu.c once for system-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-rv-dedup-v1-10-ea69b07afd31@rev.ng>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
In-Reply-To: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790870392; l=779;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=M8wPAD0VrrMS7VrrQBP9MtLmfLGrzEUjWNBoCiUi7AM=;
 b=EA9WuRNcQaN4pFFntVzNlKGc8EoJH8Mgor/ctFToihv7qqj9KLRHnilxekTHs3CDBho6TK0JT
 PqTyY96jyKeAOuhRnVb+b9Xiux8hkpvT3Zqg+A3W6+u67nB8Mqo80G5
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 3cdff11f75..ba38e421c5 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -15,7 +15,6 @@ riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		     if_true: files('common-semi-target.c'))
 
 riscv_ss.add(files(
-  'cpu.c',
   'gdbstub.c',
 ))
 
@@ -33,6 +32,14 @@ riscv_system_ss.add(files(
 riscv_user_ss = ss.source_set()
 riscv_common_system_ss = ss.source_set()
 
+riscv_user_ss.add(files(
+  'cpu.c',
+))
+
+riscv_common_system_ss.add(files(
+  'cpu.c',
+))
+
 subdir('tcg')
 subdir('kvm')
 

-- 
2.52.0


