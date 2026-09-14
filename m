Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DB3C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63AR-0003ns-1b; Mon, 14 Sep 2026 05:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AP-0003n4-T1; Mon, 14 Sep 2026 05:40:02 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AN-0001Pw-2P; Mon, 14 Sep 2026 05:40:01 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9ddbv024283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:39:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hnY5juUKKLeN7q7Z1an1/ZnVzgZhXgFoudwqtE4kTJg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378783; v=1;
 b=sh15EVDhEAW+d1xjwv44NeSg7zJ3mf/g1cSRIRaptLyAQPK85r5343kdCEsfT/1E
 RhBHx91WMsl6ZcnnhW2HF8/YTgWKc1KznbfDd74OPFDU3K20XOEnGtzCJecXBzNi
 KbhMFeSzBLZjQAL+wpCR9pJsKJoigKegtq6PTeEImGilsIw4YxcFtm4YVPszIon2
 4zq49xXKOpb/Bw2DfdRRCZjgI0dgQV6dHXOZQ/z9nJkfB6HlJx2ru+KvDvIv1ZgD
 117qY8FvSRwu8NiYV3V1Wg7l7P7b4uz+bTMXRqEvo/T5CGvvORoX5iLisDMBf2sS
 KQ/B0jpVWVk541WTQejLdw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:39:23 +0900
Subject: [PATCH v8 2/5] test/acpi: aarch64/virt: Allow DSDT and MCFG
 changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-virt-v8-2-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=PYL5iTDv5M8n1DKYRxxC12CHmqkO3Dh3t7PBls2RQ9s=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byAzcS7x0UVrLpvf86hDU/Zb5mSdnWk0UKySeeLj/om
 mGl01LUUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBE7U4Z/9nnb1hbPSn5fca0+
 /bBz4ymDO1+6ryr+tViX+fTM5nlvDjAyrLF+uSLE/9yqGyfeZ2fGyof+2TdDSNaAQ/NRinryulJ
 2NgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Igor Mammedov <imammedo@redhat.com>
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
2.55.0


