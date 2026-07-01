Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82505C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetws-0007Zm-K6; Wed, 01 Jul 2026 08:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wetwq-0007ZH-RS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wetwp-0006GV-AB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782908506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yeOIfhuA4RPtJKlJYeZDFX68YuNf/Zw9w1HH1eJpJkM=;
 b=VWWsByaIg8zkcQOJwdLA6nRSuBiZULNDNm7z6PK7LTsBNpbcJGkN1vLsLoSwQAjIm5EGF9
 vP3hjjCidrBtXzymwIB1TS/qUjpF2CnLglPpN2fkb4eWmGwZdRJ6Dg0ufnOvfU7uHjAoWP
 sE35JckWNrN/Zku+Ahl8psoSDW5UgjM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-H-tEf-4QPxyatpl6KnUYvA-1; Wed,
 01 Jul 2026 08:21:44 -0400
X-MC-Unique: H-tEf-4QPxyatpl6KnUYvA-1
X-Mimecast-MFC-AGG-ID: H-tEf-4QPxyatpl6KnUYvA_1782908503
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C14188E6C0; Wed,  1 Jul 2026 12:21:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23F271686; Wed,  1 Jul 2026 12:21:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: vkuznets@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] docs/hyperv: fix misleading hv-crash shutdown description
Date: Wed,  1 Jul 2026 16:21:35 +0400
Message-ID: <20260701122135.3168729-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The documentation stated that writing to HV_X64_MSR_CRASH_CTL
unconditionally causes the guest to shutdown. In reality, it triggers
qemu_system_guest_panicked() via KVM_SYSTEM_EVENT_CRASH and the
resulting action depends on the generic panic action policy
(-action panic=...), which defaults to shutdown.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/system/i386/hyperv.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 1c1de77feb6..e1babffb0f9 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -71,8 +71,11 @@ Existing enlightenments
   by the guest when it crashes, HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 MSRs
   contain additional crash information. This information is outputted in QEMU log
   and through QAPI.
-  Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL causes guest
-  to shutdown. This effectively blocks crash dump generation by Windows.
+  Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL triggers
+  ``qemu_system_guest_panicked()`` via ``KVM_SYSTEM_EVENT_CRASH`` and the
+  resulting action depends on the ``-action panic=...`` policy (default:
+  ``shutdown``). With the default action, this effectively blocks crash dump
+  generation by Windows.
 
 ``hv-time``
   Enables two Hyper-V-specific clocksources available to the guest: MSR-based
@@ -304,8 +307,9 @@ currently implemented Hyper-V enlightenments with the following exceptions:
   ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
   behave differently when different Hyper-V version is presented to them.
 - ``hv-crash`` must only be enabled if the crash information is consumed via
-  QAPI by higher levels of the virtualization stack. Enabling this feature
-  effectively prevents Windows from creating dumps upon crashes.
+  QAPI by higher levels of the virtualization stack. With the default
+  ``-action panic=shutdown`` policy, enabling this feature effectively
+  prevents Windows from creating dumps upon crashes.
 - ``hv-reenlightenment`` can only be used on hardware which supports TSC
   scaling or when guest migration is not needed.
 - ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited
-- 
2.54.0


