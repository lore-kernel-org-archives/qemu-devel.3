Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ADBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whuJg-0007yG-Om; Thu, 09 Jul 2026 15:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1whuJe-0007xe-VR
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:21:47 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1whuJd-0000Jx-9M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:21:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 59E6C4360D;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B444C2BCC7;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783624903;
 bh=d+rI6ZCwzrWvq6NTyqDlNbyPUKqlc1rQVyrkBIqG/Bw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PdjiSr6oYI5npLLJosDyssq66Ln8c5yiHa5BmVoCKiL7ElgwQuF8R+Q03Qe6FFm9t
 h7ixaTwA/j0Qy56q6HA0itPRQ4lksExnZtEvbazha6L9g9GpfterB+oQZehXlHGh+I
 WsXg/SBYCCOHbqhvSulHrDo13Q1tK5wg//+YMgGzy3bJXhY5N/4KsxMaUOLwGZbe8X
 vN04LFQAVE1erLDPneAfCmGm8tHLjtWxUCjzNihp60SB0bipXpW/uh3N9Ww9a3o8j0
 xWLP9GEnBBHK7ilHfb2wu3UEyaEvf8DlL92UNX+tZM71pOeKscMBab+C3/P+4lt0V+
 cK43I1F2vkmvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 28409C44506;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Fri, 10 Jul 2026 03:21:40 +0800
Subject: [PATCH v3 2/2] pvscsi: add a comment to explain the endianness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pvscsi-endianness-v3-2-27fe1c4d1f6e@gmail.com>
References: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
In-Reply-To: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Arvind Kumar <arvindkumar@vmware.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=ilFQcJu1FqULtEwtbouLfW4e6TfQJNaWKZ3bD1ZIn78=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqT/TFKjL0nmPHCRwaa0V1BJ3JVJNwT/k9Zxj5+
 zlhY0nfzXuJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCak/0xQAKCRCwMePKe/7Z
 bpXEEADRXXAQvPJlLCB69LrkHODV3wVmKAHt6lMCBwtFvfcvLvfdkjC+Q6NiAfAQLOf7seQ7vhj
 CTfIQEH4D9VHRPAH0n4MdLxSlioFBCVi41IJ49hFPsZecwIlCmDz+sX0hr7aKtuQ6Ftk0p8cmzt
 232eG58P3yBWtUlOzBU+FP4hiPIcW9oZJR2b/wdVvKhmeIfTIgWQZVBe8ihj3oWuj2rUYO1ybge
 oChplst5yikQhbKFWnaH/jRQxwDmgy/NwUzv2u5O8v/zoV3P/hP2NNu1+6oAsXSv6i/lMFD+vNn
 WaqEwiEzG769p1UyqjHg1MVRifs1egv2Xzobf65p0nIn7HO+cXspXeav8+6Q97LIHWZz8oWpz/5
 JTzJ3p6CeZlpSOL+9v4rXecUymJfQPu7dWBvp3Nz9E63tsYglfu01pkkZg1D7qBcIFFT5MGx6kk
 LHDoNaxgN6iIKc1ut+3TqQHlmksoiz8/3uUGuS9kZe3+pObXBg+AWH/kI8m3p25ik2AItz2bayT
 uUKQad9O06PI9d8wg3aLzsXFG8KnJpHU0Dv1tfZHdUG2eLWGILsJxJ8CFMlZu/GGsxE5gaQB7kw
 vwajCcNxmrNPsOqjoYMqR/USmIw5d2snRs6CzoWIqvWqdi1Y7ccRcii43jIrwcMh5w7sS8qhRY4
 EyS/Oo61gViPtlA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

Add a comment to explain the endianness of the pvscsi device. We have
no information about the endianness should be little-endian or CPU
native endian because the current driver code is designed to work only
on x86 and is not endianness aware. We assume that the pvscsi device is
implicitly little-endian.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 hw/scsi/vmw_pvscsi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/scsi/vmw_pvscsi.h b/hw/scsi/vmw_pvscsi.h
index a3ae517e19934c2377cd84efe993264917ecefde..defff9e179ecbe888194e3f31547ecbee801f432 100644
--- a/hw/scsi/vmw_pvscsi.h
+++ b/hw/scsi/vmw_pvscsi.h
@@ -108,6 +108,20 @@ enum PVSCSICommands {
 #define PVSCSI_COMMAND_PROCESSING_FAILED     (-1)
 #define PVSCSI_COMMAND_NOT_ENOUGH_DATA       (-2)
 
+/*
+ * About endianess for the below structs:
+ *
+ * These structs are used to describe the data that is exchanged between the
+ * guest and the PVSCSI device. The endianess of the fields in these structs
+ * is not defined by any standard. The current implemented drivers are designed
+ * to only work on x86 architecture, so there is no endianess awareness in the
+ * drivers and thus we have no idea whether the fields should be in little-
+ * endian or target native endian format.
+ *
+ * Considering the above, we assume that PVSCSI is implicitly little-endian and
+ * expect the fields in these structs to be in little-endian format.
+ */
+
 /*
  * Command descriptor for PVSCSI_CMD_RESET_DEVICE --
  */

-- 
2.49.0



