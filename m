Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0C5C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1qi-0005JO-AM; Thu, 07 Aug 2025 10:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1pJ-0002ez-4f
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:42:43 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1pH-00018U-IR
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:42:40 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id C2415201BC8F;
 Thu,  7 Aug 2025 07:42:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2415201BC8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577748;
 bh=8/mtb2eWWn+SXc7DzCHe6kt2AAzBbP3Jai1V55zbYYQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r2a1pXtBo3B+gNZRjZigkzXxLkmdBdkTPa0MT3Z393hNfq12ypaWzaQLPwzyXUx5S
 BJEpelQ5OIiL841QtFsDFpyk9n8n0Ek2a4YZUAgw5ZuwWFtiAiTjDNtijjsbX3W9Kh
 fY8+2bCNN5qyvmZQkVwh5P5N22liE6JXkwarbC+w=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/26] MAINTAINERS: Add maintainers for mshv accelerator
Date: Thu,  7 Aug 2025 16:39:50 +0200
Message-Id: <20250807143951.1154713-26-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Adding Magnus Kulke and Wei Liu to the maintainers file for the
respective folders/files.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..7527264f30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -546,6 +546,21 @@ F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 
+MSHV
+M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+R: Wei Liu <wei.liu@kernel.org>
+S: Supported
+F: accel/mshv/
+F: include/system/mshv.h
+F: include/hw/hyperv/hvgdk*.h
+F: include/hw/hyperv/hvhdk*.h
+
+MSHV CPUs
+M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+R: Wei Liu <wei.liu@kernel.org>
+S: Supported
+F: target/i386/mshv/
+
 X86 Instruction Emulator
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
-- 
2.34.1


