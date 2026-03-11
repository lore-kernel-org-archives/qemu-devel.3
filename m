Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B001049523
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GG4-0003E7-6u; Wed, 11 Mar 2026 05:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1w0GFz-0003Dt-ED
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:53:35 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1w0GFw-0006wB-LZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:53:34 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 7B122EC008A;
 Wed, 11 Mar 2026 05:53:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 05:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1773222808; x=1773309208; bh=T35/pHyYPS70b8ic0/kKg
 iGDEA2/xcvof0QAFQ3O5ew=; b=0pJhXHuQjbByY7qiApc92CsoUiHttW+kbei3J
 dk2ViTQfOMwhE5hZJmmcF21UEf0lPOClqePlcddGvl3Y3RHUH8z6BR9G58BP90lj
 VktXzPxf71dZHFnjIK0+VF5/s31psjeOjLe86UW2f1s8T5x5OvI2kH3nkqhp99q3
 wYAlRvaIQ5TJDLm/LCZKfY5QvhuVkyAN6I+aR/rkmUEp1CC3ifY6xB0w2SVOdM8B
 zFmlcC7anCQeT6YCj4W9hGdMUCbrQYDY0ZVBHQoRy4Y3YmNYc6UoUDThOn3BDaF4
 H1p8fx/Et02FR0EcGbCK/6KIrrUPgF5CDbdBcXw30NsYuCsoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1773222808; x=1773309208; bh=T35/pHyYPS70b8ic0/kKgiGDEA2/xcvof0Q
 AFQ3O5ew=; b=gI1wRbZLeYw3gGf+I+rDjKq6/ZsxFq4z9XgSfzbmtsYz0f2TZqZ
 /oqr3aYRPo95HWZbwEneRms0UZmujqB4tC3d3WPLCd0S40fyJcb7CUdNMDRHWk1V
 Zj5M/JF6iG0gco0ZWxWrQpAzA9wvCByu9Jg9tRhAV0bFJL/dTfvr54O5ioA6DoUD
 YV+TtO3d4yAKyAi5g26X5UyB18M6Y6SLbxVvCv9tigtdV5/exyTPONwpLShR3aag
 jursZcvJ3P0BDk/tVxQ0jKe2xoXXglieKLpckeHjTa1iaNMv/G9fqSYCpRK+6g70
 gzuRdxJLv3+eTN4Wsrt8pCQK/SdM5Lw8XKw==
X-ME-Sender: <xms:mDuxaeRA80nXfUaRUm5YObdwKIn17weCjNMMLMBDb6w2dn4axCtOaQ>
 <xme:mDuxabNw4USKpXqHW-aenG4u_W0_cfNHtc1bIFk_y1dZ1NUXn9CEROVDbbAIYJgv6
 2pYnrsjnjZPzZ7DFeb-SkqfFdCj4T46xnI_QU6P1_pf8NBX_ecJ>
X-ME-Received: <xmr:mDuxaZPWvzITlBCF9aTfoR8qXp6j8wvQVDbJIhV_pyXTyHmTCy1N3UcrhO-uGbm2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcutfho
 shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehvdffgffhte
 eijefgteeftdfghfdvheeuhedvjedugfeggfeljefgleefvefgfeenucevlhhushhtvghr
 ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
 dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgv
 mhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpsghonhiiihhnih
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdr
 ohhrgh
X-ME-Proxy: <xmx:mDuxaTvyxCgnzxkjUuedZcBiiNJvKLO1VFvB96FCc3c-7i2AnTnXvg>
 <xmx:mDuxabWgQTDbsSAfb3OOJCi6q7W8wb8HFgZg1QZAtFeIFKLa9VpewA>
 <xmx:mDuxaTuMwalHFL6VyuEuovTto6twygXUK7tTWwCsaC82C3YKLAXO1g>
 <xmx:mDuxafXAnAnJFEMnnaYbHvyMNuJTLfeiw3tdPmdwv0PweiclTfGfUA>
 <xmx:mDuxaVZceeB7RcdDjpgi3h-LE2_1rmRuootjeMGrH5i1stkirwLiWnAl>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:53:28 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 085D87706AD2; Wed, 11 Mar 2026 10:53:25 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH] accel/kvm: fix typo in variable name
Date: Wed, 11 Mar 2026 10:53:15 +0100
Message-ID: <20260311095315.25013-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=hi@alyssa.is;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

Fixes: 94a8d39afd ("kvm: Consolidate must-have capability checks")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 984db97779..774499d34f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,7 +111,7 @@ static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
-static const KVMCapabilityInfo kvm_required_capabilites[] = {
+static const KVMCapabilityInfo kvm_required_capabilities[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
@@ -2992,7 +2992,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         nc++;
     }
 
-    missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
+    missing_cap = kvm_check_extension_list(s, kvm_required_capabilities);
     if (!missing_cap) {
         missing_cap =
             kvm_check_extension_list(s, kvm_arch_required_capabilities);

base-commit: ae56950eac7b61b1abf42003329ee0f3ce111711
-- 
2.53.0


