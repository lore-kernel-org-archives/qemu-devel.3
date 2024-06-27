Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78080C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgW7-00069J-0B; Thu, 27 Jun 2024 00:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMgW4-000696-K1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:13:48 -0400
Received: from wfout6-smtp.messagingengine.com ([64.147.123.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMgW2-00006J-1U
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:13:47 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 60F0E1C0007C;
 Thu, 27 Jun 2024 00:13:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 27 Jun 2024 00:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1719461622; x=1719548022; bh=Ue
 hycH934eNIEenSua7udXYbxzD4oQLZBn10XfORSww=; b=tb+nUeCArQCafGTkcU
 EV3NPUZu9beb/aASdIvTN4gLsmWgq9YoFsY5SIIz2r3sbhSMVfppP3NYiSJ65PII
 hdqV33aCAXszVCZv+CeSyBL97jLg790c3ohubX3H2gEexp5/dUxKmwXwfukrxe0W
 aXkRC3ouTVCxFEKiyrFOizLTPIG8aW+/A/x1jdKcZd8GOJaH0hpc5j5q4G2q+J5L
 LFGbWMwnkGfIxI5dT8DvIBFaiK4GZVY/mVxomZ9jrjkqgJ9QYPEj0bo3BROqVPB1
 6MbBGx1WF2l7K+E4x04WSrktrZgxoD0g9XpqWvX/9BHxsYvsWwi3FBnX/rPlKral
 4UBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1719461622; x=1719548022; bh=UehycH934eNIE
 enSua7udXYbxzD4oQLZBn10XfORSww=; b=L3Kwcs9oh2659K8owX5NzybxY+bwy
 ATFxw9v3fUAthqP8i3HpboZmWa03vqW9ySc3IA8M8OW9HJXvWdNq0tMMXDUanlBj
 ZYEyHWDHr1Ec9/ZswHKY0hEfSdMHK37OLdQUaS8XIpxO2cgCG5sx4QUCRJg7ui2n
 OimC2KVuWI6KaUIf1yiy8IBYvp7NPPgLfxKfJGUBQgMBjVucYmFw0CTcfi+jODQD
 VxSCnA5BaW8LUg6lYJRg21A/bQJzxTm6tB6jQsD79bSrwYGg5VnN2TL4DACaYif6
 zru43T/RPm5JffzgrMgPwUbIcQGSyxWj1+GGhXa5gCzPeQoF+BFz2DZyw==
X-ME-Sender: <xms:9eZ8ZhvunFpxRfLw6m4duvX9np491ma_oO_DAEfPnkHe0yMwazkRUw>
 <xme:9eZ8Zqe_l8XckBzh_whg6aK5PgmFGWsOrFvflnLqaiTkEO5VPzbAfZ9X3AZpA5NlA
 nMix-tfUQjWwNpvTDM>
X-ME-Received: <xmr:9eZ8Zkz8IO_cXWd_DNHNGeY2a7mZ_ugM8kEpphN8aW7vwru8yURhGSB1MZ-I1jjHFPV1hmz-ggkXoWUtm9MGrasZxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdefgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
 ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
 frrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeehkeev
 udevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:9eZ8ZoMgqzYoGSaIqTN5V3-QNwbxxMEKbC6kWqlENXYHtHeTlvGUUw>
 <xmx:9eZ8Zh9OGtWBApKu2sLrFepdGWCiUXNxwhxQQ5eWE2JcgpnU_TDhHA>
 <xmx:9eZ8ZoW53cUYu1vWsXjAzi56UabNHpHM_8-l9wd_LGvfkY86IEolJA>
 <xmx:9eZ8ZicNT0PxcCRvCMLUYzGelgK5YhRl1LhYyD_7jK3zVAvjJnpNmQ>
 <xmx:9uZ8ZhwQXutjV1nAly_ajJ2lB1uGz4dAZ10iuakwwh1ESBCDWPmek4nN>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 00:13:38 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] hw/intc/loongson_ipi: Fix for LoongArch
Date: Thu, 27 Jun 2024 05:13:26 +0100
Message-Id: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAObmfGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNz3cyCTN20zIrUYl1D49TENMMkCwtD00QloPqColSwBFB5dGxtLQD
 4ukboWwAAAA==
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, maobibo <maobibo@loongson.cn>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=619;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RTN0CR0Oas/OuE+6CkVZ2YaLKCDYlQvcDw8tJ1UW6bw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSaZ5/zjwQ93vPaZUPbzpVPOl2Vd/9POny74VN+094pe
 r0P/n9+0FHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATSfzMyDC74KjvG7U/4lH3
 lT5wT9xpu8CBafHjZ1V5lhOmR/L/tKxhZJjw+6PjS63LUax7P3kr8EyZOv3Y606X1fapP6dUO53
 hlWMGAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (2):
      hw/intc/loongson_ipi: Gate MMIO regions creation with property
      MAINTAINERS: Add myself as a reviewer of LoongArch virt machine

 MAINTAINERS                    |  1 +
 hw/intc/loongson_ipi.c         | 23 ++++++++++++++---------
 hw/mips/loongson3_virt.c       |  1 +
 include/hw/intc/loongson_ipi.h |  1 +
 4 files changed, 17 insertions(+), 9 deletions(-)
---
base-commit: 3f044554b94fc0756d5b3cdbf84501e0eea0e629
change-id: 20240627-ipi-fixes-13eaf1b8815a

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


