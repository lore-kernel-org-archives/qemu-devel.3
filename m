Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE752CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfmD-0003M3-Gr; Wed, 20 May 2026 08:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPfmB-0003KS-P1; Wed, 20 May 2026 08:11:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPfm9-00076Q-3y; Wed, 20 May 2026 08:11:51 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K9utCR091476
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 18:57:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SjYFtJsb0FRA58h9TXRtEmlQ3hZoNWJPwC9HoIYv5D4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779271023; v=1;
 b=YC9v3xTxNlN5vGDB2xJjtJdKpcUi49u4UiPMRKMS4FB3YuBXvy4GRCImREkZGFJd
 PWbA0DOQioTEkDWCnawQLt1OSxaNw0b0TwPPMnoBG/L3TBBlZPU+FU+l/98b5Q1b
 XrHICXd9VxHZhy6wtnC3+VzfZlMoTe0cQuu8Ypg+Hp/gkCmtZmjh7raE9zSYB9oO
 A/Lw8sH21YhddkouQzlCkiR2zh8xkeI37SW/nWeHskuMWIjulC59oXnngYS9mSEx
 PBbdKUKw1vX58QVTguyR2xS7worEEAgxcwJOkVSgpztCz0zBVt09g1JXQE/y+lOx
 Kpmwt1nWSpjHk5MzHCS5tw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 18:56:31 +0900
Subject: [PATCH v6 2/4] test/acpi: aarch64/virt: Allow DSDT and MCFG
 changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-virt-v6-2-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=L/SGCbMPDXlwLMU2o6k2QfWIShKkV4IZn/KCNSNhtoA=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZva877y0HaJ1b5L47nnH6+mtXMjrFX/ZXNd26W2vuPE
 /+p+NZ0lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATMRciuGf3rv5c27PqHp+sWvO
 577bd37tauQ9++Y118yN0Ukzv3kU1zH8z4lvfq6Xq+7AGOxswfa6dx2fgMyUi+x3slo4fO/XPzr
 CCwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..efb00724d09f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,12 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
+"tests/data/acpi/aarch64/virt/MCFG",

-- 
2.54.0


