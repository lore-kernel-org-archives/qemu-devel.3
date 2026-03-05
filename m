Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6659BF30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Ke-0002d0-J4; Thu, 05 Mar 2026 05:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Kd-0002Qm-3G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Kb-0005Yw-Je
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF6Dso2itn/3ESk+NM4HgSMdzC4V7xHqiWg2my0AHdc=;
 b=H0skHejlCm79XzowpS55ymCaIxXTfWn5fbQMEEKl4XjBYjLSsLycvlmkAsERMVOYC84SOf
 lrsDjWxkH3dqTHUXWjYV1ppzQRwpRnRngvF00TdkrRXd5nFt6buv6Ohda484w+9M8hzbR4
 EJt9d3Tg+PW4sgVTm59KKkbsa8jd5Do=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-CnmvxvKPPT6O_mzJ7GqUvA-1; Thu,
 05 Mar 2026 05:53:21 -0500
X-MC-Unique: CnmvxvKPPT6O_mzJ7GqUvA-1
X-Mimecast-MFC-AGG-ID: CnmvxvKPPT6O_mzJ7GqUvA_1772708000
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7D11800283; Thu,  5 Mar 2026 10:53:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CF063003E9E; Thu,  5 Mar 2026 10:53:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 19/28] hw/i386/pc: Remove deprecated pc-q35-2.11 and
 pc-i440fx-2.11 machines
Date: Thu,  5 Mar 2026 11:52:06 +0100
Message-ID: <20260305105215.302571-20-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501223522.99772-6-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c |  9 ---------
 hw/i386/pc_q35.c  | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 64927b47d92..8a4b6509444 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -686,15 +686,6 @@ static void pc_i440fx_machine_2_12_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 12);
 
-static void pc_i440fx_machine_2_11_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_12_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 11);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index ad40e9045b2..60a1b75b450 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -632,13 +632,3 @@ static void pc_q35_machine_2_12_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 12);
-
-static void pc_q35_machine_2_11_options(MachineClass *m)
-{
-    pc_q35_machine_2_12_options(m);
-    m->default_nic = "e1000";
-    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
-}
-
-DEFINE_Q35_MACHINE(2, 11);
-- 
2.53.0


