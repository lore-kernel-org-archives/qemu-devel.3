Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EAECD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7my-0006Cl-Kj; Mon, 02 Sep 2024 10:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7mw-00069J-Ls
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7mt-0003lJ-5s
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725286327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYVbaX/Sll6j0eX4FBzduRWID60WMh6IhL4nj0tSB2M=;
 b=DMyDbVYPXt3MTh9OmHAlCUPiMc6Y6wybQi1dJsGWknYiPWCnKhkVwVT1CCFELZsieKfmoT
 4K9GddUZsAp0w91v2CtR/c5nTlJy7m/rz02D7BVtgDsyG3H6e14UbWhCyq/y60Tr8MaKmj
 dbsJmWEruIxlWxek4TEqHwVnlG9q2iA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-G9JqbUPBP9WzZjfDwUg9Yw-1; Mon, 02 Sep 2024 10:12:06 -0400
X-MC-Unique: G9JqbUPBP9WzZjfDwUg9Yw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374b69e65e8so1901063f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725286325; x=1725891125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYVbaX/Sll6j0eX4FBzduRWID60WMh6IhL4nj0tSB2M=;
 b=BSUNcMMYLz8iUCDbH7cJIapowI7eMIExtefL/I2ZONGpOVEyjOXN5OA6m1tbFn8iCY
 aYEn/HWneKBCo5EGJVk07Zzk97W/sHgNtvfDYoC9NO8iyEihBemV4smvEPZEeeXaCqzi
 C4BCVw/TFNL7mVpldFiJ/5qLtwvvrG5nLsDos09Kzgjd6ufGh7qio2+PxWrrjfHerlaD
 xbz9w6d5MbPS5NJqZrQRPwJbywsV1oENsE7QRQPcE7xFo4o4MwTmvClh6JVLzKFiEjht
 OaJhdRF22ClcuL9HMj11T4K0SVhUgspY0/lwPTr874tMxvJZAOA1S2YbX8ZD4rgGvFHd
 TXIg==
X-Gm-Message-State: AOJu0YxqQFUcDTys/wGCrleyfD53IoukhAFudsEYnzWHMM1ZoF0eXEMc
 KzoLvcHYuRLc9csqF2Ee4KQklqD3ETNBWC7qFIVaWlSX7hXmw8kyIeYfq0UeNyGY0oADlQW2pwn
 WvP9PF3YmkyqivZvCZzBF3LhX2m7g+SpKuGFt4CoUyAPB93lF+pZT
X-Received: by 2002:adf:9b93:0:b0:374:badf:966f with SMTP id
 ffacd0b85a97d-374ecc67b7fmr123878f8f.7.1725286324964; 
 Mon, 02 Sep 2024 07:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH45u9KWnZljjBw1aO+rZ5n6CeKShmIUZ6TpY/xCxfhuiB01W4eBgkFyJAysS6HOJxaUFDe6w==
X-Received: by 2002:adf:9b93:0:b0:374:badf:966f with SMTP id
 ffacd0b85a97d-374ecc67b7fmr123830f8f.7.1725286324021; 
 Mon, 02 Sep 2024 07:12:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4d391sm11629396f8f.3.2024.09.02.07.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:12:03 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:11:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 04/16] hw/i386: Add igvm-cfg object and processing for
 IGVM files
Message-ID: <kepnqxwheef5qe4c554afufh72u7vcsvqvsmpw35mmvneb6gfq@2qsaerfuapnn>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <f3f4667c5aa7729c1bb2b28a596dabbd42482d56.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f3f4667c5aa7729c1bb2b28a596dabbd42482d56.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 13, 2024 at 04:01:06PM GMT, Roy Hopkins wrote:
>An IGVM file contains configuration of guest state that should be
>applied during configuration of the guest, before the guest is started.
>
>This patch allows the user to add an igvm-cfg object to an X86 machine
>configuration that allows an IGVM file to be configured that will be
>applied to the guest before it is started.
>
>If an IGVM configuration is provided then the IGVM file is processed at
>the end of the board initialization, before the state transition to
>PHASE_MACHINE_INITIALIZED.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>---
> hw/i386/pc.c          | 12 ++++++++++++
> hw/i386/pc_piix.c     | 10 ++++++++++
> hw/i386/pc_q35.c      | 10 ++++++++++
> include/hw/i386/x86.h |  3 +++
> qemu-options.hx       | 25 +++++++++++++++++++++++++
> 5 files changed, 60 insertions(+)
>
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index c74931d577..30bbe05e3e 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -1827,6 +1827,18 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>     object_class_property_add_bool(oc, "fd-bootchk",
>         pc_machine_get_fd_bootchk,
>         pc_machine_set_fd_bootchk);
>+
>+#if defined(CONFIG_IGVM)
>+    object_class_property_add_link(oc, "igvm-cfg",
>+                                   TYPE_IGVM_CFG,
>+                                   offsetof(X86MachineState, igvm),
>+                                   object_property_allow_set_link,
>+                                   OBJ_PROP_LINK_STRONG);
>+    object_class_property_set_description(oc, "igvm-cfg",
>+                                          "Set IGVM configuration");
>+#endif
>+
>+
> }
>
> static const TypeInfo pc_machine_info = {
>diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>index d9e69243b4..78367985b4 100644
>--- a/hw/i386/pc_piix.c
>+++ b/hw/i386/pc_piix.c
>@@ -365,6 +365,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>                                x86_nvdimm_acpi_dsmio,
>                                x86ms->fw_cfg, OBJECT(pcms));
>     }
>+
>+#if defined(CONFIG_IGVM)
>+    /* Apply guest state from IGVM if supplied */
>+    if (x86ms->igvm) {
>+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
>+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
>+            g_assert_not_reached();
>+        }
>+    }
>+#endif
> }
>
> typedef enum PCSouthBridgeOption {
>diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>index 9d108b194e..08ef8dc17a 100644
>--- a/hw/i386/pc_q35.c
>+++ b/hw/i386/pc_q35.c
>@@ -329,6 +329,16 @@ static void pc_q35_init(MachineState *machine)
>                                x86_nvdimm_acpi_dsmio,
>                                x86ms->fw_cfg, OBJECT(pcms));
>     }
>+
>+#if defined(CONFIG_IGVM)
>+    /* Apply guest state from IGVM if supplied */
>+    if (x86ms->igvm) {
>+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
>+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
>+            g_assert_not_reached();
>+        }
>+    }
>+#endif
> }
>
> #define DEFINE_Q35_MACHINE(major, minor) \
>diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>index d43cb3908e..01ac29acf6 100644
>--- a/include/hw/i386/x86.h
>+++ b/include/hw/i386/x86.h
>@@ -25,6 +25,7 @@
> #include "hw/intc/ioapic.h"
> #include "hw/isa/isa.h"
> #include "qom/object.h"
>+#include "sysemu/igvm-cfg.h"
>
> struct X86MachineClass {
>     /*< private >*/
>@@ -97,6 +98,8 @@ struct X86MachineState {
>      * which means no limitation on the guest's bus locks.
>      */
>     uint64_t bus_lock_ratelimit;
>+
>+    IgvmCfg *igvm;
> };
>
> #define X86_MACHINE_SMM              "smm"
>diff --git a/qemu-options.hx b/qemu-options.hx
>index cee0da2014..b6eee49075 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -5927,6 +5927,31 @@ SRST
>                  -machine ...,memory-encryption=sev0 \\
>                  .....
>
>+    ``-object igvm-cfg,file=file``
>+        Create an IGVM configuration object that defines the initial state
>+        of the guest using a file in that conforms to the Independent Guest
>+        Virtual Machine (IGVM) file format.
>+
>+        The ``file`` parameter is used to specify the IGVM file to load.
>+        When provided, the IGVM file is used to populate the initial
>+        memory of the virtual machine and, depending on the platform, can
>+        define the initial processor state, memory map and parameters.
>+
>+        The IGVM file is expected to contain the firmware for the virtual
>+        machine, therefore an ``igvm-cfg`` object cannot be provided along
>+        with other ways of specifying firmware, such as the ``-bios``
>+        parameter on x86 machines.
>+
>+        e.g to launch a machine providing the firmware in an IGVM file
>+
>+        .. parsed-literal::
>+
>+             # |qemu_system_x86| \\
>+                 ...... \\
>+                 -object igvm-cfg,id=igvm0,file=bios.igvm \\
>+                 -machine ...,igvm-cfg=igvm0 \\
>+                 .....
>+

Should we mention that this is supported only by `q35` and `pc` machines?

>     ``-object authz-simple,id=id,identity=string``
>         Create an authorization object that will control access to
>         network services.
>-- 
>2.43.0
>


