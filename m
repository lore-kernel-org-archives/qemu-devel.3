Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3A0C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9ws-0007yH-3P; Thu, 23 May 2024 11:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wj-00076K-RV
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wi-0004u6-1h
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHCUPvn1Si9c0g9Vgq43/WNne2Jx2ZEuJMMlB1q2KHs=;
 b=M87NlbDLhYRvlTiqed2SFVlWjQAWHOm3+PCpFgFlk14KO0x4g4e3MYi3+Mp77zyW+fhD+y
 YvIgFANmMp2xXWO6m4hMiHR5YDdTI+iU7E3eNdiJhTyLuliHUeCy2BKPs2EzuRAPVJN/dS
 8hYepua2aB3z3jwbYgdS4rC5Gf+wHss=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-4XcV9T0VNG25jdnWPLM0ag-1; Thu, 23 May 2024 11:01:29 -0400
X-MC-Unique: 4XcV9T0VNG25jdnWPLM0ag-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-578282c81bcso1284510a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476488; x=1717081288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHCUPvn1Si9c0g9Vgq43/WNne2Jx2ZEuJMMlB1q2KHs=;
 b=nSiickyxU8mffXu+8QbTpI9XeZugwGOI+/H2cFbAz40DHy7fUkXKRKapUff43DG55d
 0mIvmsYY0TXbjEc+HxBFOpYcX7q6L4wb0GDap1xeOFPycKQC2CYfGjV2J9T5JwC0/F3O
 Je0cpVEakSo1e5/HTdw2FtIHcJuNnP/av7Pq3RJhgYAN6KEtB32SDfpAoGWfvv1zzaa/
 vnXuF2WWj5oNG6g1E/bVSNSiP7RQyNresBncB0vzdpzV7c3u54yfLzYqi4GNR2uLvke0
 bti3RYcUws+uDjJZrcQFw88NzNUjePilKt2BERrTbnjTdIEmVQ/RcusuIdBy+MGRpqUH
 q7Vw==
X-Gm-Message-State: AOJu0YwOtrqbQw7iou8Rs/hZkHwMa93+3PvVKM3vXG9xNOS5zn4SIisN
 xc2PBinVhZxxo7Yz3BHdPDlqFp48Oo5i7bOSJ2pdJwl3ZPoP0C+LrqNJExMm4DFz+uqpWhFHey5
 BBaABQwKVcY93vw0s7IUcYCSb09nI+K9b6wHLlKT4cDhkLyKdZSeAPHJe7sCBma3v4067/ODDI4
 etLYZ3qDJEUi9fT7pyJPk3hGohqPgwhBcJJ0Vy
X-Received: by 2002:a50:d789:0:b0:578:25c9:b990 with SMTP id
 4fb4d7f45d1cf-57832a3a1b2mr5199791a12.20.1716476487262; 
 Thu, 23 May 2024 08:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbcF3+fXwCypRxfjpnpXkUjfvuUquXjGrPBlxFwUFEA1MK2JR/HBw1JlM9goij8dgyS1SoMQ==
X-Received: by 2002:a50:d789:0:b0:578:25c9:b990 with SMTP id
 4fb4d7f45d1cf-57832a3a1b2mr5199756a12.20.1716476486788; 
 Thu, 23 May 2024 08:01:26 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c34fed1sm19885745a12.96.2024.05.23.08.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PULL 19/23] hw/i386/pc: Support smp.modules for x86 PC machine
Date: Thu, 23 May 2024 17:00:32 +0200
Message-ID: <20240523150036.1050011-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As module-level topology support is added to X86CPU, now we can enable
the support for the modules parameter on PC machines. With this support,
we can define a 5-level x86 CPU topology with "-smp":

-smp cpus=*,maxcpus=*,sockets=*,dies=*,modules=*,cores=*,threads=*.

So, add the 5-level topology example in description of "-smp".

Additionally, add the missed drawers and books options in previous
example.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-19-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c    |  1 +
 qemu-options.hx | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6126bfdd2a7..7b638da7aaa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1843,6 +1843,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
+    mc->smp_props.modules_supported = true;
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 4d196603368..8ca7f34ef0c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -281,7 +281,8 @@ ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
-    "               [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
+    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
+    "               [,threads=threads]\n"
     "                set the number of initial CPUs to 'n' [default=1]\n"
     "                maxcpus= maximum number of total CPUs, including\n"
     "                offline CPUs for hotplug, etc\n"
@@ -290,7 +291,8 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "                sockets= number of sockets in one book\n"
     "                dies= number of dies in one socket\n"
     "                clusters= number of clusters in one die\n"
-    "                cores= number of cores in one cluster\n"
+    "                modules= number of modules in one cluster\n"
+    "                cores= number of cores in one module\n"
     "                threads= number of threads in one core\n"
     "Note: Different machines may have different subsets of the CPU topology\n"
     "      parameters supported, so the actual meaning of the supported parameters\n"
@@ -306,7 +308,7 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "      must be set as 1 in the purpose of correct parsing.\n",
     QEMU_ARCH_ALL)
 SRST
-``-smp [[cpus=]n][,maxcpus=maxcpus][,sockets=sockets][,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]``
+``-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
     Simulate a SMP system with '\ ``n``\ ' CPUs initially present on
     the machine type board. On boards supporting CPU hotplug, the optional
     '\ ``maxcpus``\ ' parameter can be set to enable further CPUs to be
@@ -345,14 +347,14 @@ SRST
         -smp 8,sockets=2,cores=2,threads=2,maxcpus=8
 
     The following sub-option defines a CPU topology hierarchy (2 sockets
-    totally on the machine, 2 dies per socket, 2 cores per die, 2 threads
-    per core) for PC machines which support sockets/dies/cores/threads.
-    Some members of the option can be omitted but their values will be
-    automatically computed:
+    totally on the machine, 2 dies per socket, 2 modules per die, 2 cores per
+    module, 2 threads per core) for PC machines which support sockets/dies
+    /modules/cores/threads. Some members of the option can be omitted but
+    their values will be automatically computed:
 
     ::
 
-        -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16
+        -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32
 
     The following sub-option defines a CPU topology hierarchy (2 sockets
     totally on the machine, 2 clusters per socket, 2 cores per cluster,
-- 
2.45.1


