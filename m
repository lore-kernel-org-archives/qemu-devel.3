Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682C9C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 06:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWqZV-0000kP-Eq; Wed, 02 Jul 2025 02:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWqZH-0000j5-Gq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWqZC-0004fS-IF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751436208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BL4N4vQUHRolZ4DvmG3fojJiew3wsR9YAjpgmgCVCXk=;
 b=QU/jnSoV54snMBzis0DcxlseTJySkUePmEqMb1aM04hIe08R6pXpN6HozvzD+O8F0KUHIc
 HUMcSQAd2wMC9CkE05+kYE4DfsndFqsbUvPB0W+6etRKSh9y5SJ3fKXbP6r3VdcY+NWUI4
 AIkye+lMXPa/Hjc32sW/QPR2uVPPogE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-WQ_eRFWENs2ee4mZhZ6sXw-1; Wed,
 02 Jul 2025 02:03:26 -0400
X-MC-Unique: WQ_eRFWENs2ee4mZhZ6sXw-1
X-Mimecast-MFC-AGG-ID: WQ_eRFWENs2ee4mZhZ6sXw_1751436205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 779421955D4E; Wed,  2 Jul 2025 06:03:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.120])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24BAB18003FC; Wed,  2 Jul 2025 06:03:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-stable@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH] accel/kvm: Adjust the note about the minimum required kernel
 version
Date: Wed,  2 Jul 2025 08:03:19 +0200
Message-ID: <20250702060319.13091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel 4.4 to
be able to use KVM. Adjust the upgrade_note accordingly.
While we're at it, remove the text about kvm-kmod and the
SourceForge URL since this is not actively maintained anymore.

Fixes: 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/kvm/kvm-all.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d095d1b98f8..e3302b087f4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2571,8 +2571,7 @@ static int kvm_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     static const char upgrade_note[] =
-        "Please upgrade to at least kernel 2.6.29 or recent kvm-kmod\n"
-        "(see http://sourceforge.net/projects/kvm).\n";
+        "Please upgrade to at least kernel 4.4.\n";
     const struct {
         const char *name;
         int num;
-- 
2.50.0


