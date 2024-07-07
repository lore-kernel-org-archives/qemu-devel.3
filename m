Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7112C3DA44
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 18:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQWLz-0002VG-Vp; Sun, 07 Jul 2024 14:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sQWLw-0002Uf-EN
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 14:11:12 -0400
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sQWLu-0008Ap-R8
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 14:11:12 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 467IAwCu2793340
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sun, 7 Jul 2024 11:11:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 467IAwCu2793340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024061501; t=1720375862;
 bh=iXGMbjpQTWpMUQvwW757TRbDez+R7EpXv1gocfpAutg=;
 h=From:To:Cc:Subject:Date:From;
 b=Md7V/HIcTSHmfDKkFRXnd7SYigqbttPoJq03G43zYJpmMjnhP84UX8Fzxi1gYeQR0
 /UiaM5NY2ymRV9k6Rwvf1kxjdb9Mcu0AXgQk6qkcCGHf9fKS0NthzouyT1LcRsmO1g
 528Z+wSS+UdIMet+eJJcLYbyol2hWSKkPveotKhGjkK/h4vZPYzyvrKQxDBzgJdn8+
 3/ZhZ+8iJtUv4OuwM06w/bKBP5rDhABR34IYu580c1DzMG8njhBrdzcyytVuW2zq3+
 FQlS5lUqk+MGt0Vh0XirmZvOBzgI+2HG+zIttgmgTI60tuDbwGCMrOzlPxIh2NvnI3
 UFRwOUcrAy6wQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xin3.li@intel.com
Subject: [PATCH v1 1/1] target/i386: Add VMX entry load FRED control name to
 VMX feature words
Date: Sun,  7 Jul 2024 11:10:57 -0700
Message-ID: <20240707181057.2793329-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
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

As VMX entry load FRED control is required to enable FRED in nested VMX,
add it to VMX feature words.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c05765eeaf..84a09c19cf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", NULL,
+            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },

base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
-- 
2.45.2


