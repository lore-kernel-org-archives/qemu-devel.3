Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A0AC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 19:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcsfT-0007K5-33; Wed, 21 Feb 2024 14:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby825@126.com>)
 id 1rcsfS-0007J9-90; Wed, 21 Feb 2024 14:54:10 -0500
Received: from m16.mail.126.com ([117.135.210.7])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bobby825@126.com>)
 id 1rcsfN-0002gp-1F; Wed, 21 Feb 2024 14:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DtmZ3
 beYDhPgRkDo2uOLN8mhU0rXC+dqtTwCGAwFEAY=; b=CpgtBRvtbbwld+sjGdLFY
 /GMfDu7Q1N30BgN3OvCm05aswuftRiHGBP25cQtJ7R1RCkTV5VWinCgstT0x9SFJ
 7oz28va3Y6Pnko38ezz/W+sDnVtk9MvRlVivN9CMpuwiy6SNgi+eK0e6dQFIYWY3
 ULcavo1DkZkSGFH//UUmoo=
Received: from localhost.localdomain (unknown [101.88.177.236])
 by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wAnLoHJVNZlICNbAw--.46376S3;
 Thu, 22 Feb 2024 03:53:52 +0800 (CST)
From: Tianlan Zhou <bobby825@126.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Tianlan Zhou <bobby825@126.com>
Subject: [PATCH v2 1/2] docs/system: Update description for input grab key
Date: Thu, 22 Feb 2024 03:52:09 +0800
Message-Id: <20240221195208.462-2-bobby825@126.com>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20240221195208.462-1-bobby825@126.com>
References: <20240221195208.462-1-bobby825@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnLoHJVNZlICNbAw--.46376S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrpnQUUUUU
X-Originating-IP: [101.88.177.236]
X-CM-SenderInfo: xereu5qysvqiyswou0bp/1tbiHBSLUmV20XxRYAAAse
Received-SPF: pass client-ip=117.135.210.7; envelope-from=bobby825@126.com;
 helo=m16.mail.126.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Input grab key should be Ctrl-Alt-g, not just Ctrl-Alt.

Signed-off-by: Tianlan Zhou <bobby825@126.com>
---
 docs/system/keys.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index 2e2c97aa23..59966a3fe7 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -29,7 +29,7 @@ Ctrl-Alt-n
    *3*
       Serial port
 
-Ctrl-Alt
+Ctrl-Alt-g
    Toggle mouse and keyboard grab.
 
 In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and
-- 
2.38.1.windows.1


