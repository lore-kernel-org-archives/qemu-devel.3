Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E9ECEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdcC-0008Es-Fz; Tue, 01 Oct 2024 10:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svdc0-0007ok-9A
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svdbr-00038t-Pg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727791932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHGZqlVbW7MCScvkF1IowomfSd7QuTBgUrlyUTAquM0=;
 b=GscK21ALxdWsvvV59tj6nvxJbWSZjY+LYL/k9r69kVmGb8/OmudAnLC7/B3AOgiH3YY4lf
 sGgp6x04H2DckFZsIjfYRkrn/kfu3r3J4XFdYgAJm5gzf9/iZ9n1TT/L8H1ObFUfkl0Bsi
 fYIeEzC7UXSgT+an8c2n2oPVzJMfISI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-lZzZc48APCuOhaQkbSHOGA-1; Tue, 01 Oct 2024 05:53:43 -0400
X-MC-Unique: lZzZc48APCuOhaQkbSHOGA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-20b583a48f4so43936145ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 02:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727776422; x=1728381222;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHGZqlVbW7MCScvkF1IowomfSd7QuTBgUrlyUTAquM0=;
 b=nZBimEMcAs1QRm1O81P49gFirqyzGdJBIOpQoXIaicD5XvsflZQEA8D8qRX+bFW6KI
 oHXVtZSHlHxGdlOoQkUtDkz1kHJ/3ej20nnN4llNyWAJGHvfIVs8mdlGtxPVlKMurLGG
 RyjPQy8rIYf/O31cISzagfzlmC1f8QhvweCXMQdgNawYxHAu0kv0hmQN4xFmSuSkFACq
 bk7Uq9dhitW2+eWGCdVQhb+3A7yWBRB0fVrqK7TtpcYNoYGYgVBvBAfm53W8YkavQD8m
 AMpYd8Y4AXWlBXeamxRAmrbjbrj02pCOSsePFXUtJeRwvPbhxKxchg7FvWiWfRPJbXAi
 nGkQ==
X-Gm-Message-State: AOJu0YzUk0nM/J9DPZ6+WshkCeElVcsmtiNXl2boGgJWFmvNCWhw1jCw
 W4j6JVSzRd6T7DiWHOxrRQfRGuyRnCpZbEZvfTgzFHhwTDYg/PuxBHtCjkTtXa2g3WpPT2lTsX5
 ra/RMGxPiBFovSYHhsw4vCVuWFzGg/TwMCof1LM5QvWeorH6wvbLw
X-Received: by 2002:a17:903:110e:b0:206:fd9d:b88d with SMTP id
 d9443c01a7336-20b37bdb78fmr187873145ad.61.1727776421932; 
 Tue, 01 Oct 2024 02:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJyPS8jiSDIefK69rHM9l/vXArFcDMjlSeAyHSI9QO/iTbyxcgzwZVvH3ECPV9p3jIajveAw==
X-Received: by 2002:a17:903:110e:b0:206:fd9d:b88d with SMTP id
 d9443c01a7336-20b37bdb78fmr187872915ad.61.1727776421435; 
 Tue, 01 Oct 2024 02:53:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e2072fsm66391385ad.128.2024.10.01.02.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 02:53:40 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:53:33 +0200
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
Subject: Re: [PATCH v6 04/16] hw/i386: Add igvm-cfg object and processing for
 IGVM files
Message-ID: <zgjym2u5k4p7h5bwi6nef62vvs6snzw6defg5la7yey6oub5kg@ile7murbz3mt>
References: <cover.1727341768.git.roy.hopkins@suse.com>
 <9506d5c8954c78d5890d48129156abfb93691397.1727341768.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9506d5c8954c78d5890d48129156abfb93691397.1727341768.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Sep 26, 2024 at 12:41:53PM GMT, Roy Hopkins wrote:
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
> qemu-options.hx       | 28 ++++++++++++++++++++++++++++
> 5 files changed, 63 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index 8d84c22458..695fc1dbfe 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -1843,6 +1843,18 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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
>index 2bf6865d40..5adf7da6f4 100644
>--- a/hw/i386/pc_piix.c
>+++ b/hw/i386/pc_piix.c
>@@ -360,6 +360,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
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
>index 8319b6d45e..483e0a0a40 100644
>--- a/hw/i386/pc_q35.c
>+++ b/hw/i386/pc_q35.c
>@@ -324,6 +324,16 @@ static void pc_q35_init(MachineState *machine)
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
>index d94e2cbbae..66292c160b 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -5927,6 +5927,34 @@ SRST
>                  -machine ...,memory-encryption=sev0 \\
>                  .....
>
>+    ``-object igvm-cfg,file=file``
>+        Create an IGVM configuration object that defines the initial state
>+        of the guest using a file in that conforms to the Independent Guest
>+        Virtual Machine (IGVM) file format.
>+
>+        This is currently only supported by ``-machine q35`` and
>+        ``-machine pc``.
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
>     ``-object authz-simple,id=id,identity=string``
>         Create an authorization object that will control access to
>         network services.
>-- 
>2.43.0
>


