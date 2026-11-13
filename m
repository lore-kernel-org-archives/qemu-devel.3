Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48818606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TfHShXJp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjG-0001X3-Qa; Fri, 13 Nov 2026 08:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnta-0004N1-Pg; Fri, 13 Nov 2026 04:48:34 -0500
Received: from smtp47.tsinghua.edu.cn ([101.6.4.71] helo=tsinghua.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRntY-00072W-Rm; Fri, 13 Nov 2026 04:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=uyB2d7JldGTrGzC0YCKTHJcf0w2QHiOdrC
 M0jtxiBRA=; b=TfHShXJpw5nq3aIrXupXvTMO7Bq6j5SSPoLf30YI+RCR634oMG
 xBGMsM+IP7EJuzo+bqHYQN+Y5YTkRfvFSCIOaVKXs6IrHGjIsbwLfjmux4xYp6zA
 uoMzo0NvTCEYB32LcYYd2UvGcMZFj8s9PFsO2KMmhTYgQW4+NMaJewl/U=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S5;
 Fri, 13 Nov 2026 17:48:29 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 03/20] target/arm: report SMCCC v1.1 support
Date: Fri, 13 Nov 2026 17:47:37 +0800
Message-ID: <220bd78f343a5d9d85a03e20c26ece7152a0feb4.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1DCw4DXF47uF47KF48Zwb_yoW5JFWkpF
 W5Xrn8GryxX343Ga9xArWUZF15Ga9YkFn0yr47t3W8Wws8Jry5CrZ0g3ZakFZ8K39xua9r
 AF12vr13KFWkXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
 c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeJPEUUUUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=101.6.4.71;
 envelope-from=w-yf22@mails.tsinghua.edu.cn; helo=tsinghua.edu.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:52 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

Guests use the SMCCC version call to select the conduit for firmware
services such as SCMI.  QEMU reports PSCI 1.1 but rejects the SMCCC
version call, so a guest running with the SMC PSCI conduit never
initializes SMCCC and cannot use SCMI over SMC.

Advertise SMCCC 1.1 through PSCI_FEATURES and the SMCCC version call.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 target/arm/kvm-consts.h |  5 +++++
 target/arm/tcg/psci.c   | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 9fba3e886d..ab64c91888 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -88,6 +88,11 @@ MISMATCH_CHECK(QEMU_PSCI_0_2_FN64_CPU_ON, PSCI_0_2_FN64_CPU_ON);
 MISMATCH_CHECK(QEMU_PSCI_0_2_FN64_MIGRATE, PSCI_0_2_FN64_MIGRATE);
 MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 
+/* SMCCC architecture calls. */
+#define QEMU_SMCCC_VERSION_FUNC_ID                0x80000000
+#define QEMU_SMCCC_ARCH_FEATURES_FUNC_ID          0x80000001
+#define QEMU_SMCCC_VERSION_1_1                     QEMU_PSCI_VERSION_1_1
+
 /* PSCI v0.2 return values used by TCG emulation of PSCI */
 
 /* No Trusted OS migration to worry about when offlining CPUs */
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index d8e01df762..81ca2fbb44 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -95,6 +95,20 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_0_2_FN_PSCI_VERSION:
         ret = QEMU_PSCI_VERSION_1_1;
         break;
+    case QEMU_SMCCC_VERSION_FUNC_ID:
+        ret = QEMU_SMCCC_VERSION_1_1;
+        break;
+    case QEMU_SMCCC_ARCH_FEATURES_FUNC_ID:
+        switch ((uint32_t)param[1]) {
+        case QEMU_SMCCC_VERSION_FUNC_ID:
+        case QEMU_SMCCC_ARCH_FEATURES_FUNC_ID:
+            ret = 0;
+            break;
+        default:
+            ret = QEMU_PSCI_RET_NOT_SUPPORTED;
+            break;
+        }
+        break;
     case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
         ret = QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED; /* No trusted OS */
         break;
@@ -177,6 +191,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
         case QEMU_PSCI_0_2_FN_PSCI_VERSION:
+        case QEMU_SMCCC_VERSION_FUNC_ID:
         case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
         case QEMU_PSCI_0_2_FN_AFFINITY_INFO:
         case QEMU_PSCI_0_2_FN64_AFFINITY_INFO:
-- 
2.53.0


