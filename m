Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A32C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYrkb-0005T4-CE; Fri, 17 Jan 2025 14:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tYrkX-0005NW-Ns
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tYrkU-0006fi-Bm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737141077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvEhB10MKdW+zBjcxEVbRCxFxxGMJvJPPmtcutQRq9w=;
 b=AJYCHdzWSuKTIA3tcjWP3L9zbBirOm0AwjVEnkOULyEvhbL5kqR5ZAElbUXx/Y1tVpiXKD
 IAAwDa8ThHqUOiYiIlMasp32K664CcJTf9Rzgm1tMh9+2CnCNGX18F17+uRJh9xofn988u
 VfHwg553EsyjEFU/jEk2MYSy7OC6348=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-99mNBFePPKaHn0zBxIZQqg-1; Fri,
 17 Jan 2025 14:11:15 -0500
X-MC-Unique: 99mNBFePPKaHn0zBxIZQqg-1
X-Mimecast-MFC-AGG-ID: 99mNBFePPKaHn0zBxIZQqg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEB6F195608D; Fri, 17 Jan 2025 19:11:13 +0000 (UTC)
Received: from gezellig.redhat.com (unknown [10.39.192.203])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F03919560BF; Fri, 17 Jan 2025 19:11:11 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, maz@kernel.org, sebott@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH 1/2] docs/cpu-features: Consistently use vCPU instead of VCPU
Date: Fri, 17 Jan 2025 20:11:05 +0100
Message-ID: <20250117191106.322363-2-kchamart@redhat.com>
In-Reply-To: <20250117191106.322363-1-kchamart@redhat.com>
References: <20250117191106.322363-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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
index a5fb929243c..78f18c87a81 100644
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


