Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6650C3ABA0
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbM-00007y-Qg; Fri, 21 Feb 2025 09:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWu-0006Wa-TD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:04 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWs-00015v-P5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:04 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 244332053686; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 244332053686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126990;
 bh=fCHLMSx0k0Dka9n2Ye+wmkJEZwzMqBQDPD8yM1c8zGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cY6fyB9Kfr2GsYKntWn6TYkcdHIsgUtIuhCwsZSzW/7jD8d7HeuMlHvo+Le74ydBO
 K5Y5TUohphAH/6pjcQXoxlrY0YW7bXbGIY7QFaYMFwwCCDNCMEwtXSjC5f05bRO0ej
 1H8ldnMrPQ9viMTLQzL8HfUp1J0Z2b4XNRJJwkTo=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 17/19] target/i386: add a directory for x86 instruction
 emulator
Date: Fri, 21 Feb 2025 00:36:25 -0800
Message-Id: <1740126987-8483-18-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:18 -0500
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

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/meson.build               | 1 +
 target/i386/x86-insn-emul/meson.build | 0
 2 files changed, 1 insertion(+)
 create mode 100644 target/i386/x86-insn-emul/meson.build

diff --git a/target/i386/meson.build b/target/i386/meson.build
index 2e9c472f49..e93c1c20ca 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -31,6 +31,7 @@ subdir('whpx')
 subdir('nvmm')
 subdir('hvf')
 subdir('tcg')
+subdir('x86-insn-emul')
 
 target_arch += {'i386': i386_ss}
 target_system_arch += {'i386': i386_system_ss}
diff --git a/target/i386/x86-insn-emul/meson.build b/target/i386/x86-insn-emul/meson.build
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.39.5 (Apple Git-154)


