Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8996DC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZct-0001gM-0L; Thu, 13 Feb 2025 08:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tiZcn-0001fQ-De
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tiZcj-0001Ob-Fj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739454673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i61uZKOUpSCeJlTNk3nSmeaPm5pItDiwyvp2HBiI56Y=;
 b=OB4jJ4GIMA5t9w6LUcmQubf5TrHizrZdr9AhWer/CY2NderZAGBJEr4CZvbGu+gm5K7o2v
 aEMEoYZTw4ymgwfBAiMMllh9c/uScJm1bWF9qhM7YXheRly6LKJksn4qApX1OLSUUpmXcF
 HtrU/LAyOQN6sfLbhtyTffFJGeNLCrQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-Uay8ptp2NqaZ5swOhTHFVw-1; Thu,
 13 Feb 2025 08:51:09 -0500
X-MC-Unique: Uay8ptp2NqaZ5swOhTHFVw-1
X-Mimecast-MFC-AGG-ID: Uay8ptp2NqaZ5swOhTHFVw_1739454666
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7288C1800992; Thu, 13 Feb 2025 13:51:04 +0000 (UTC)
Received: from gezellig.redhat.com (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 928733000197; Thu, 13 Feb 2025 13:50:52 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: maz@kernel.org, Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 sebott@redhat.com, Steven Lee <steven_lee@aspeedtech.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2 1/3] docs/cpu-features: Consistently use vCPU instead of
 VCPU
Date: Thu, 13 Feb 2025 14:50:29 +0100
Message-ID: <20250213135032.2987289-2-kchamart@redhat.com>
In-Reply-To: <20250213135032.2987289-1-kchamart@redhat.com>
References: <20250213135032.2987289-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 docs/system/arm/cpu-features.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b..a596316384 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -27,7 +27,7 @@ disabled, enables the optional AArch32 CPU feature, is only supported
 when using the KVM accelerator and when running on a host CPU type that
 supports the feature.  While ``aarch64`` currently only works with KVM,
 it could work with TCG.  CPU features that are specific to KVM are
-prefixed with "kvm-" and are described in "KVM VCPU Features".
+prefixed with "kvm-" and are described in "KVM vCPU Features".
 
 CPU Feature Probing
 ===================
@@ -167,22 +167,22 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
 properties have special semantics (see "SVE CPU Property Parsing
 Semantics").
 
-KVM VCPU Features
+KVM vCPU Features
 =================
 
-KVM VCPU features are CPU features that are specific to KVM, such as
+KVM vCPU features are CPU features that are specific to KVM, such as
 paravirt features or features that enable CPU virtualization extensions.
 The features' CPU properties are only available when KVM is enabled and
-are named with the prefix "kvm-".  KVM VCPU features may be probed,
+are named with the prefix "kvm-".  KVM vCPU features may be probed,
 enabled, and disabled in the same way as other CPU features.  Below is
-the list of KVM VCPU features and their descriptions.
+the list of KVM vCPU features and their descriptions.
 
 ``kvm-no-adjvtime``
   By default kvm-no-adjvtime is disabled.  This means that by default
   the virtual time adjustment is enabled (vtime is not *not* adjusted).
 
   When virtual time adjustment is enabled each time the VM transitions
-  back to running state the VCPU's virtual counter is updated to
+  back to running state the vCPU's virtual counter is updated to
   ensure stopped time is not counted.  This avoids time jumps
   surprising guest OSes and applications, as long as they use the
   virtual counter for timekeeping.  However it has the side effect of
@@ -200,15 +200,15 @@ the list of KVM VCPU features and their descriptions.
 
   When kvm-steal-time is enabled a 64-bit guest can account for time
   its CPUs were not running due to the host not scheduling the
-  corresponding VCPU threads.  The accounting statistics may influence
+  corresponding vCPU threads.  The accounting statistics may influence
   the guest scheduler behavior and/or be exposed to the guest
   userspace.
 
-TCG VCPU Features
+TCG vCPU Features
 =================
 
-TCG VCPU features are CPU features that are specific to TCG.
-Below is the list of TCG VCPU features and their descriptions.
+TCG vCPU features are CPU features that are specific to TCG.
+Below is the list of TCG vCPU features and their descriptions.
 
 ``pauth``
   Enable or disable ``FEAT_Pauth`` entirely.
-- 
2.48.1


