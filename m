Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E662DC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUB-0004Nn-92; Tue, 07 May 2024 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IU9-0004NK-JT
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IU7-0001vD-Nz
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHTbP7iyf17mW67FCQda6llcG4kMpqTKrpunGsoLQ9I=;
 b=RjXezAK4V+EpIjkSg/o+uYqRvpg7AJNp/j3vrphVmuBN2OYKCPVRviqA5LmM8b6YkfQ6k0
 qpMfixHSUlNFrobX2UEdRlDVod+hau4fk8YUOy488q7I5J0G3cPRWWwJlgDTbkh1Z1CfAt
 oCMjyyXe5BLxx12JkaQhT0FD0JnemQU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-DVMDf8Q7PUKQ1wxzL_GkZQ-1; Tue, 07 May 2024 06:55:45 -0400
X-MC-Unique: DVMDf8Q7PUKQ1wxzL_GkZQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c69844aaso135871266b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079344; x=1715684144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHTbP7iyf17mW67FCQda6llcG4kMpqTKrpunGsoLQ9I=;
 b=SD8QaHw7UhpwjFuVXytT2u0PGoWu3Z99915guPcL7lDQt5UxeU7KFpf04VDMmy4EAt
 ew5kWF1V7HuaMcSD6zJWseVQyhWG+gveiMJmgtPYLF3xtpsG73OEKCdoIL/mvAbc5ijD
 Ge1KqfdZAXF+3uwub1fYBsg6B83hFEC3B+ejyCcg64x6cuzkhaY933Au1GhMfIbLMj36
 hhrXjAjlbK7ZdcYhcBshixX6teWTOEnh2b3+R6DuQlHPskuvXJsPMO1gYUTvdIGi1PaC
 FcpmzPuhyV/xfLvwMIajh2dVlsV6WJpKXl3rikPaYvWDYbM6Pt5CAuEnNY3Epn3+rhVm
 gCew==
X-Gm-Message-State: AOJu0Yxm3cRfxgzNaqLbbUah3uZOgfDZuW1ru0uJop3Z8ic4Q7XMZcN3
 oRg09BK3C5uCur9w6IwwrAbdZ+2/DVwge4k4GrpcXIwSHKwNIbZ1H1KREGPZ4V3L7diB2N9gyDM
 uF6th3IBIDItXb9lAurCCyHiWhbW4U21cS0AyZjNHxbIRv/pcyNSQZK9Wc985IXR8MRoGxAPiad
 Cu+ASWv1v1J4fGdFaMOMFMx+OXiy5A7hThg14L
X-Received: by 2002:a17:906:358b:b0:a59:a8a4:a5a7 with SMTP id
 o11-20020a170906358b00b00a59a8a4a5a7mr5975581ejb.30.1715079343935; 
 Tue, 07 May 2024 03:55:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuYYkXfAPkPwh04hQLIPRFmSdnQnK33KuZ361dQwQMRYpju4877fTzitiYjEASuAg3GJ0SWA==
X-Received: by 2002:a17:906:358b:b0:a59:a8a4:a5a7 with SMTP id
 o11-20020a170906358b00b00a59a8a4a5a7mr5975564ejb.30.1715079343476; 
 Tue, 07 May 2024 03:55:43 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 le5-20020a170906ae0500b00a59d5f879d2sm1863551ejb.32.2024.05.07.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>, qemu-stable@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/26] target/i386: Fix CPUID encoding of Fn8000001E_ECX
Date: Tue,  7 May 2024 12:55:13 +0200
Message-ID: <20240507105538.180704-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Babu Moger <babu.moger@amd.com>

Observed the following failure while booting the SEV-SNP guest and the
guest fails to boot with the smp parameters:
"-smp 192,sockets=1,dies=12,cores=8,threads=2".

qemu-system-x86_64: sev_snp_launch_update: SNP_LAUNCH_UPDATE ret=-5 fw_error=22 'Invalid parameter'
qemu-system-x86_64: SEV-SNP: CPUID validation failed for function 0x8000001e, index: 0x0.
provided: eax:0x00000000, ebx: 0x00000100, ecx: 0x00000b00, edx: 0x00000000
expected: eax:0x00000000, ebx: 0x00000100, ecx: 0x00000300, edx: 0x00000000
qemu-system-x86_64: SEV-SNP: failed update CPUID page

Reason for the failure is due to overflowing of bits used for "Node per
processor" in CPUID Fn8000001E_ECX. This field's width is 3 bits wide and
can hold maximum value 0x7. With dies=12 (0xB), it overflows and spills
over into the reserved bits. In the case of SEV-SNP, this causes CPUID
enforcement failure and guest fails to boot.

The PPR documentation for CPUID_Fn8000001E_ECX [Node Identifiers]
=================================================================
Bits    Description
31:11   Reserved.

10:8    NodesPerProcessor: Node per processor. Read-only.
        ValidValues:
        Value   Description
        0h      1 node per processor.
        7h-1h   Reserved.

7:0     NodeId: Node ID. Read-only. Reset: Fixed,XXh.
=================================================================

As in the spec, the valid value for "node per processor" is 0 and rest
are reserved.

Looking back at the history of decoding of CPUID_Fn8000001E_ECX, noticed
that there were cases where "node per processor" can be more than 1. It
is valid only for pre-F17h (pre-EPYC) architectures. For EPYC or later
CPUs, the linux kernel does not use this information to build the L3
topology.

Also noted that the CPUID Function 0x8000001E_ECX is available only when
TOPOEXT feature is enabled. This feature is enabled only for EPYC(F17h)
or later processors. So, previous generation of processors do not not
enumerate 0x8000001E_ECX leaf.

There could be some corner cases where the older guests could enable the
TOPOEXT feature by running with -cpu host, in which case legacy guests
might notice the topology change. To address those cases introduced a
new CPU property "legacy-multi-node". It will be true for older machine
types to maintain compatibility. By default, it will be false, so new
decoding will be used going forward.

The documentation is taken from Preliminary Processor Programming
Reference (PPR) for AMD Family 19h Model 11h, Revision B1 Processors 55901
Rev 0.25 - Oct 6, 2022.

Cc: qemu-stable@nongnu.org
Fixes: 31ada106d891 ("Simplify CPUID_8000_001E for AMD")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-ID: <0ee4b0a8293188a53970a2b0e4f4ef713425055e.1714757834.git.babu.moger@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  6 ++++++
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 18 ++++++++++--------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 565c7a98c37..1e0d2c915f5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1994,6 +1994,12 @@ struct ArchCPU {
      */
     bool legacy_cache;
 
+    /* Compatibility bits for old machine types.
+     * If true decode the CPUID Function 0x8000001E_ECX to support multiple
+     * nodes per processor
+     */
+    bool legacy_multi_node;
+
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 08c7de416fd..46235466d7a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,7 @@
 GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "true" },
+    { TYPE_X86_CPU, "legacy-multi-node", "on" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ef30a765c1..1058b6803fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -398,12 +398,9 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
      * 31:11 Reserved.
      * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXXb.
      *      ValidValues:
-     *      Value Description
-     *      000b  1 node per processor.
-     *      001b  2 nodes per processor.
-     *      010b Reserved.
-     *      011b 4 nodes per processor.
-     *      111b-100b Reserved.
+     *      Value   Description
+     *      0h      1 node per processor.
+     *      7h-1h   Reserved.
      *  7:0 NodeId: Node ID. Read-only. Reset: XXh.
      *
      * NOTE: Hardware reserves 3 bits for number of nodes per processor.
@@ -412,8 +409,12 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
      * NodeId is combination of node and socket_id which is already decoded
      * in apic_id. Just use it by shifting.
      */
-    *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
-           ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
+    if (cpu->legacy_multi_node) {
+        *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
+               ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
+    } else {
+        *ecx = (cpu->apic_id >> apicid_pkg_offset(topo_info)) & 0xFF;
+    }
 
     *edx = 0;
 }
@@ -8084,6 +8085,7 @@ static Property x86_cpu_properties[] = {
      * own cache information (see x86_cpu_load_def()).
      */
     DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
+    DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
     DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
 
     /*
-- 
2.45.0


