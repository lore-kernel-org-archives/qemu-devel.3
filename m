Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966FDCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6Gs-0002Xo-Em; Tue, 26 Mar 2024 08:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp6Gq-0002XG-QO
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp6Gp-0003nA-1J
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711457473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JlMSmLkcTMlylmW5uZLLXGFw0hS3xSZAZYREd5/BcF4=;
 b=PRjfdyv8mWFig1iFteLSJl9tTQvwnxqNCOaKqw8JWxIAMsrtpXRqG24ay//uHeWfzUREdw
 /EfV4af6YkhCspWSBxpWDgzVMQs7EQQBaOfkopxM1cq3LpzbHWbGLD7rojRcMA2SRo21pU
 kIjbFHgT4k8vqeTAa9iRiYytb6BtwT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ImfVzm7RMkiZ0Qe3zQx44w-1; Tue, 26 Mar 2024 08:51:07 -0400
X-MC-Unique: ImfVzm7RMkiZ0Qe3zQx44w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81491800262;
 Tue, 26 Mar 2024 12:51:07 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F15E492BDC;
 Tue, 26 Mar 2024 12:51:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, devel@lists.libvirt.org, richard.henderson@linaro.org,
 mst@redhat.com, thuth@redhat.com, qemu-trivial@nongnu.org
Subject: [PATCH for-9.0] docs/about: Mark the iaspc machine type as deprecated
Date: Tue, 26 Mar 2024 13:51:04 +0100
Message-ID: <20240326125104.90103-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

ISAPC machine was introduced 25 years ago and it's a lot of time since
such machine was around with real ISA only PC hardware practically defunct.
Also it's slowly bit-rots (for example: I was able to boot RHEL6 on RHEL9 host
in only TCG mode, while in KVM mode it hung in the middle of boot)

Rather than spending time on fixing 'the oldest' no longer tested machine type,
deprecate it so we can clean up QEMU code from legacy fixups and hopefully
make it easier to follow.

Folks who have to use ancient guest that requires ISAPC can still
use older QEMU to play with it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/about/deprecated.rst | 7 +++++++
 hw/i386/pc_piix.c         | 1 +
 2 files changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..5708296991 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -226,6 +226,13 @@ These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
+``isapc`` (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+These old machine type are quite neglected nowadays and thus might have
+various pitfalls with regards to live migration. Use a newer machine type
+instead.
+
 Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba076609..96f72384dd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -921,6 +921,7 @@ static void isapc_machine_options(MachineClass *m)
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    m->deprecation_reason = "old and unattended - use a newer version instead";
 }
 
 DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-- 
2.43.0


