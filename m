Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DE606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Scv0Ursl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNkfl-00004w-P0; Mon, 02 Nov 2026 00:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNkfk-0008WG-Oe
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 00:33:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNkff-0006XZ-N6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 00:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793597605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8RgOOxtzxc6Zh1YOYdrPLzsqvByv98iZkzyVTwU5k+Y=;
 b=Scv0UrslxyrKYk6nSPyoUGIefg67ptU0Ya3jdqHNYZAmD0yoe1rl9zmQ5GepTPmz9HKb7V
 aP3uZEXn0pH1+HNL56thVP/aUsYjq/ykW0vJBBAnF6/jDCrL/1/JRdh7A8rdzUC9CYQ7zV
 ZokmvKU6q+pSLrwxPfUTIFasnJ7EJ30=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-xcalRqM8P2yphSKYUXepDA-1; Mon,
 02 Nov 2026 00:33:23 -0500
X-MC-Unique: xcalRqM8P2yphSKYUXepDA-1
X-Mimecast-MFC-AGG-ID: xcalRqM8P2yphSKYUXepDA_1793597602
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92514195605B
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 05:33:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9608F195608B; Mon,  2 Nov 2026 05:33:20 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 14/56] qom: New object_property_add() etc. parameter
 @qapi_type
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261101201717.3911097-15-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-15-armbru@redhat.com>
Date: Mon, 02 Nov 2026 09:33:15 +0400
Message-Id: <179359759593.3177668.4375922821610706196.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=97156;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MkvLL0EK6ysj/EiNtuAYkHR0Aw7U/WURfWdbTK/p/JU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6CCdfnB+ohs8x0gDjVCGwqaE1r9rAM69Bme0a
 PdaWYEU/2OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauggnQAKCRDa6OEJdZac
 5X9xD/9OiO4YozR+DzBhF9QT0vRIGCV9D4nMEWpF1lYxM90yRIKP0hAcESIfTEzvc7N25RzmoUE
 yDIfrDYHQKIpCXHEVuJRJZib5NctYrsEcDrqa2lDCZP5mELAq1jdItuYKW8KqyqplNUdystihHz
 zGe7NwJYN/92fDv4SMzjuWOr9Df3eS3R30aMu/5ZXXXAv9jTSzqLH/IPWRuYlZHK0aprIEDpFmT
 UQRIBDFRlObuFlP7He9c0YnpncUVg72LccalVxGrjOIvyRbjxiIG1rbG+5HyvE8IdsEtmtAWJA4
 nAvMdggt/xqs8wf+Ly181CE3pmk+bqPfl0OEPqKzp+uIXJEhF+EX3sZYXjBxDYEYDrNHPB+PuYq
 208yaa7m2Rl8GnOAWkUYQ3pNPx+r2YpCSLzjHtEblUjCCpaOHQH/DCd3WGtz2xFzGfXl1tcT4FS
 IPVvhWQ1nkDBOFA9sS6iIp3ko3LYHRUccFo8ObHHTzAMv8YYGAA1NWumtkzURaswPdZqz8j5SyQ
 7SkpC5TP3e0lxFH0iSxGfRFJhy8mZTpN7Loz10DIBNORqaBugk55jGLM1r5sCBhVM2AgiJTKzZF
 hdLQdTlLqw6hrsjhhGODEf3DUT48vwTIhqsHf0tKBOHWhUqfGpzD/OWgXzTuoySzMjAdjygM+y9
 n1hyNSAkXGYFNew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This permits setting ObjectProperty's optional @qapi_type.  For now,
> all callers pass null.  Callers updated with this Coccinelle script:
> 
> @@
> identifier fun = {
>     object_property_try_add, object_property_add, object_class_property_add
> };
> expression obj, name, type;
> @@
> -    fun(obj, name, type,
> +    fun(obj, name, type, NULL,
>      ...)
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261101201717.3911097-15-armbru@redhat.com>
> ---
>  include/qom/object.h                |  5 +++
>  accel/hvf/hvf-all.c                 |  6 +--
>  accel/kvm/kvm-all.c                 | 19 +++++----
>  accel/nitro/nitro-accel.c           |  2 +-
>  accel/tcg/tcg-all.c                 |  6 +--
>  accel/whpx/whpx-common.c            | 12 +++---
>  authz/list.c                        |  2 +-
>  backends/cryptodev.c                |  6 +--
>  backends/hostmem-file.c             | 21 +++++-----
>  backends/hostmem-memfd.c            |  4 +-
>  backends/hostmem.c                  | 24 +++++------
>  block/throttle-groups.c             |  7 +---
>  chardev/char-socket.c               |  2 +-
>  crypto/secret_keyring.c             |  2 +-
>  event-loop-base.c                   |  6 +--
>  hw/acpi/ich9.c                      |  2 +-
>  hw/acpi/pci.c                       |  8 ++--
>  hw/arm/virt.c                       | 10 ++---
>  hw/core/clock.c                     |  2 +-
>  hw/core/machine.c                   | 29 +++++++------
>  hw/core/qdev-properties.c           |  5 +--
>  hw/cpu/core.c                       |  6 ++-
>  hw/cxl/cxl-host.c                   |  4 +-
>  hw/gpio/aspeed_gpio.c               |  6 +--
>  hw/gpio/aspeed_sgpio.c              |  2 +-
>  hw/gpio/pca9552.c                   |  4 +-
>  hw/gpio/pca9554.c                   |  3 +-
>  hw/gpio/stm32l4x5_gpio.c            |  4 +-
>  hw/hexagon/hexagon_dsp.c            |  2 +-
>  hw/i386/microvm.c                   |  6 +--
>  hw/i386/pc.c                        | 27 ++++++------
>  hw/i386/sgx-epc.c                   |  2 +-
>  hw/i386/x86.c                       | 23 ++++++-----
>  hw/ide/ide-dev.c                    |  2 +-
>  hw/intc/apic_common.c               |  2 +-
>  hw/loongarch/virt.c                 | 18 ++++----
>  hw/mem/nvdimm.c                     |  5 ++-
>  hw/mem/pc-dimm.c                    |  3 +-
>  hw/misc/aspeed_lpc.c                | 36 ++++++++++------
>  hw/misc/aspeed_sdmc.c               |  2 +-
>  hw/misc/npcm7xx_mft.c               |  2 +-
>  hw/net/ne2000-isa.c                 |  2 +-
>  hw/nvme/ctrl.c                      |  2 +-
>  hw/pci-bridge/pci_expander_bridge.c |  2 +-
>  hw/pci-host/i440fx.c                |  4 ++
>  hw/pci-host/pnv_phb3.c              |  4 +-
>  hw/pci-host/pnv_phb4.c              |  4 +-
>  hw/pci-host/q35.c                   |  8 ++--
>  hw/ppc/spapr_caps.c                 |  2 +-
>  hw/ppc/spapr_drc.c                  |  4 +-
>  hw/remote/vfio-user-obj.c           |  2 +-
>  hw/riscv/microchip_pfsoc.c          |  1 +
>  hw/riscv/virt.c                     |  4 +-
>  hw/s390x/s390-virtio-ccw.c          |  4 +-
>  hw/s390x/sclpcpi.c                  |  6 ++-
>  hw/s390x/virtio-ccw-mem.c           |  2 +-
>  hw/sensor/adc128d818.c              |  8 ++--
>  hw/sensor/adm1266.c                 |  2 +-
>  hw/sensor/adm1272.c                 |  8 ++--
>  hw/sensor/emc141x.c                 |  8 ++--
>  hw/sensor/isl_pmbus_vr.c            | 18 ++++----
>  hw/sensor/lsm303dlhc_mag.c          | 24 +++++------
>  hw/sensor/max34451.c                |  4 +-
>  hw/sensor/tmp105.c                  |  2 +-
>  hw/sensor/tmp421.c                  |  8 ++--
>  hw/usb/dev-storage-classic.c        |  2 +-
>  hw/vfio-user/pci.c                  |  2 +-
>  hw/virtio/virtio-balloon.c          |  4 +-
>  hw/virtio/virtio-mem-pci.c          |  2 +-
>  hw/virtio/virtio-mem.c              |  7 ++--
>  hw/xen/xen-pvh-common.c             |  8 ++--
>  iothread.c                          |  8 ++--
>  net/colo-compare.c                  |  6 +--
>  net/dump.c                          |  3 +-
>  net/filter-buffer.c                 |  2 +-
>  qom/object.c                        | 64 ++++++++++++++++-------------
>  system/bootdevice.c                 |  2 +-
>  system/memory.c                     |  4 +-
>  target/arm/cpu64.c                  | 10 ++---
>  target/arm/kvm.c                    |  2 +-
>  target/arm/tcg/cpu64.c              |  4 +-
>  target/i386/cpu.c                   | 20 +++++----
>  target/i386/kvm/kvm.c               |  8 ++--
>  target/i386/kvm/tdx.c               |  2 +-
>  target/i386/sev.c                   |  8 ++--
>  target/i386/whpx/whpx-all.c         | 18 ++++----
>  target/ppc/compat.c                 |  2 +-
>  target/riscv/cpu.c                  | 12 +++---
>  target/riscv/kvm/kvm-cpu.c          |  6 +--
>  target/riscv/tcg/tcg-cpu.c          |  6 +--
>  target/s390x/cpu-system.c           |  1 +
>  target/s390x/cpu_models.c           |  5 ++-
>  tests/unit/test-qdev-global-props.c |  6 ++-
>  ui/console.c                        |  2 +-
>  util/thread-context.c               |  6 +--
>  95 files changed, 377 insertions(+), 327 deletions(-)
>
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 8bd9154a50b6..213ee15b4aa6 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -277,9 +277,9 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>      ac->allowed = &hvf_allowed;
>      hvf_kernel_irqchip_override = false;
>      hvf_kernel_irqchip = false;
> -    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> -        NULL, hvf_set_kernel_irqchip,
> -        NULL, NULL);
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split", NULL,
> +                              NULL, hvf_set_kernel_irqchip,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "kernel-irqchip",
>          "Configure HVF irqchip");
>  }
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index db8fba53f339..9cc1e4b0a977 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4303,21 +4303,22 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
>      ac->has_memory = kvm_accel_has_memory;
>      ac->allowed = &kvm_allowed;
>  
> -    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> -        NULL, kvm_set_kernel_irqchip,
> -        NULL, NULL);
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split", NULL,
> +                              NULL, kvm_set_kernel_irqchip,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "kernel-irqchip",
>          "Configure KVM in-kernel irqchip");
>  
> -    object_class_property_add(oc, "kvm-shadow-mem", "int",
> -        kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
> -        NULL, NULL);
> +    object_class_property_add(oc, "kvm-shadow-mem", "int", NULL,
> +                              kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "kvm-shadow-mem",
>          "KVM shadow MMU size");
>  
> -    object_class_property_add(oc, "dirty-ring-size", "uint32",
> -        kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
> -        NULL, NULL);
> +    object_class_property_add(oc, "dirty-ring-size", "uint32", NULL,
> +                              kvm_get_dirty_ring_size,
> +                              kvm_set_dirty_ring_size,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "dirty-ring-size",
>          "Size of KVM dirty page ring buffer (default: 0, i.e. use bitmap)");
>  
> diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
> index a1e97a9162e9..597027438c63 100644
> --- a/accel/nitro/nitro-accel.c
> +++ b/accel/nitro/nitro-accel.c
> @@ -238,7 +238,7 @@ static void nitro_accel_class_init(ObjectClass *oc, const void *data)
>      object_class_property_set_description(oc, "debug-mode",
>          "Start enclave in debug mode (enables console output)");
>  
> -    object_class_property_add(oc, "enclave-cid", "uint64",
> +    object_class_property_add(oc, "enclave-cid", "uint64", NULL,
>                                nitro_get_enclave_cid,
>                                nitro_set_enclave_cid,
>                                NULL, NULL);
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 767e8805552f..ed314e01cbf3 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -270,9 +270,9 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>                                    tcg_get_thread,
>                                    tcg_set_thread);
>  
> -    object_class_property_add(oc, "tb-size", "uint32",
> -        tcg_get_tb_size, tcg_set_tb_size,
> -        NULL, NULL);
> +    object_class_property_add(oc, "tb-size", "uint32", NULL,
> +                              tcg_get_tb_size, tcg_set_tb_size,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "tb-size",
>          "TCG translation block cache size");
>  
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 247e12db8128..f82e60774580 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -528,14 +528,14 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
>      ac->pre_resume_vm = whpx_pre_resume_vm;
>      ac->allowed = &whpx_allowed;
>  
> -    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> -        NULL, whpx_set_kernel_irqchip,
> -        NULL, NULL);
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split", NULL,
> +                              NULL, whpx_set_kernel_irqchip,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "kernel-irqchip",
>          "Configure WHPX in-kernel irqchip");
> -    object_class_property_add(oc, "hyperv", "OnOffAuto",
> -        NULL, whpx_set_hyperv,
> -        NULL, NULL);
> +    object_class_property_add(oc, "hyperv", "OnOffAuto", NULL,
> +                              NULL, whpx_set_hyperv,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "hyperv",
>          "Configure Hyper-V enlightenments");
>  
> diff --git a/authz/list.c b/authz/list.c
> index 17aa0efd80e8..72aedc6ac407 100644
> --- a/authz/list.c
> +++ b/authz/list.c
> @@ -126,7 +126,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
>                                     qauthz_list_prop_get_policy,
>                                     qauthz_list_prop_set_policy);
>  
> -    object_class_property_add(oc, "rules", "QAuthZListRule",
> +    object_class_property_add(oc, "rules", "QAuthZListRule", NULL,
>                                qauthz_list_prop_get_rules,
>                                qauthz_list_prop_set_rules,
>                                NULL, NULL);
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index e8f2b18f2017..cc323014cc80 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -622,15 +622,15 @@ cryptodev_backend_class_init(ObjectClass *oc, const void *data)
>      ucc->prepare_delete = cryptodev_backend_prepare_delete;
>  
>      QTAILQ_INIT(&crypto_clients);
> -    object_class_property_add(oc, "queues", "uint32",
> +    object_class_property_add(oc, "queues", "uint32", NULL,
>                                cryptodev_backend_get_queues,
>                                cryptodev_backend_set_queues,
>                                NULL, NULL);
> -    object_class_property_add(oc, "throttle-bps", "uint64",
> +    object_class_property_add(oc, "throttle-bps", "uint64", NULL,
>                                cryptodev_backend_get_bps,
>                                cryptodev_backend_set_bps,
>                                NULL, NULL);
> -    object_class_property_add(oc, "throttle-ops", "uint64",
> +    object_class_property_add(oc, "throttle-ops", "uint64", NULL,
>                                cryptodev_backend_get_ops,
>                                cryptodev_backend_set_ops,
>                                NULL, NULL);
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 7efecf71f565..aec38bac2f9e 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -281,14 +281,14 @@ file_backend_class_init(ObjectClass *oc, const void *data)
>          file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
>      object_class_property_add_str(oc, "mem-path",
>          get_mem_path, set_mem_path);
> -    object_class_property_add(oc, "align", "uint64",
> -        file_memory_backend_get_align,
> -        file_memory_backend_set_align,
> -        NULL, NULL);
> -    object_class_property_add(oc, "offset", "int",
> -        file_memory_backend_get_offset,
> -        file_memory_backend_set_offset,
> -        NULL, NULL);
> +    object_class_property_add(oc, "align", "uint64", NULL,
> +                              file_memory_backend_get_align,
> +                              file_memory_backend_set_align,
> +                              NULL, NULL);
> +    object_class_property_add(oc, "offset", "int", NULL,
> +                              file_memory_backend_get_offset,
> +                              file_memory_backend_set_offset,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "offset",
>          "Offset into the target file (ex: 1G)");
>  #ifdef CONFIG_LIBPMEM
> @@ -298,8 +298,9 @@ file_backend_class_init(ObjectClass *oc, const void *data)
>      object_class_property_add_bool(oc, "readonly",
>          file_memory_backend_get_readonly,
>          file_memory_backend_set_readonly);
> -    object_class_property_add(oc, "rom", "OnOffAuto",
> -        file_memory_backend_get_rom, file_memory_backend_set_rom, NULL, NULL);
> +    object_class_property_add(oc, "rom", "OnOffAuto", NULL,
> +                              file_memory_backend_get_rom,
> +                              file_memory_backend_set_rom, NULL, NULL);
>      object_class_property_set_description(oc, "rom",
>          "Whether to create Read Only Memory (ROM)");
>  }
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 666593ff6c0b..15dc8814ba11 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -195,7 +195,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>                                         memfd_backend_set_hugetlb);
>          object_class_property_set_description(oc, "hugetlb",
>                                                "Use huge pages");
> -        object_class_property_add(oc, "hugetlbsize", "uint64",
> +        object_class_property_add(oc, "hugetlbsize", "uint64", NULL,
>                                    memfd_backend_get_hugetlbsize,
>                                    memfd_backend_set_hugetlbsize,
>                                    NULL, NULL);
> @@ -203,7 +203,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>                                                "Huge pages size (ex: 2M, 1G)");
>      }
>  
> -    object_class_property_add(oc, "guest-memfd", "OnOffAuto",
> +    object_class_property_add(oc, "guest-memfd", "OnOffAuto", NULL,
>                                memfd_backend_get_guest_memfd,
>                                memfd_backend_set_guest_memfd, NULL, NULL);
>      object_class_property_set_description(oc, "guest-memfd",
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 8782c8b1ea98..299a3b90fe58 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -528,10 +528,10 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
>          host_memory_backend_set_prealloc);
>      object_class_property_set_description(oc, "prealloc",
>          "Preallocate memory");
> -    object_class_property_add(oc, "prealloc-threads", "int",
> -        host_memory_backend_get_prealloc_threads,
> -        host_memory_backend_set_prealloc_threads,
> -        NULL, NULL);
> +    object_class_property_add(oc, "prealloc-threads", "int", NULL,
> +                              host_memory_backend_get_prealloc_threads,
> +                              host_memory_backend_set_prealloc_threads,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "prealloc-threads",
>          "Number of CPU threads to use for prealloc");
>      object_class_property_add_link(oc, "prealloc-context",
> @@ -539,16 +539,16 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
>          object_property_allow_set_link, OBJ_PROP_LINK_STRONG);
>      object_class_property_set_description(oc, "prealloc-context",
>          "Context to use for creating CPU threads for preallocation");
> -    object_class_property_add(oc, "size", "size",
> -        host_memory_backend_get_size,
> -        host_memory_backend_set_size,
> -        NULL, NULL);
> +    object_class_property_add(oc, "size", "size", NULL,
> +                              host_memory_backend_get_size,
> +                              host_memory_backend_set_size,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "size",
>          "Size of the memory region (ex: 500M)");
> -    object_class_property_add(oc, "host-nodes", "[uint16]",
> -        host_memory_backend_get_host_nodes,
> -        host_memory_backend_set_host_nodes,
> -        NULL, NULL);
> +    object_class_property_add(oc, "host-nodes", "[uint16]", NULL,
> +                              host_memory_backend_get_host_nodes,
> +                              host_memory_backend_set_host_nodes,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "host-nodes",
>          "Binds memory to the list of NUMA host nodes");
>      object_class_property_add_enum(oc, "policy", "HostMemPolicy",
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 37814b84fe09..cfe2ea67e3dc 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -984,17 +984,14 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
>  
>      /* individual properties */
>      for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
> -        object_class_property_add(klass,
> -                                  properties[i].name,
> -                                  "int64",
> +        object_class_property_add(klass, properties[i].name, "int64", NULL,
>                                    throttle_group_get,
>                                    throttle_group_set,
>                                    NULL, &properties[i]);
>      }
>  
>      /* ThrottleLimits */
> -    object_class_property_add(klass,
> -                              "limits", "ThrottleLimits",
> +    object_class_property_add(klass, "limits", "ThrottleLimits", NULL,
>                                throttle_group_get_limits,
>                                throttle_group_set_limits,
>                                NULL, NULL);
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 81bac42a1587..6ce9c2a50bc3 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1568,7 +1568,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
>      cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
>      cc->chr_get_filename = tcp_chr_get_filename;
>  
> -    object_class_property_add(oc, "addr", "SocketAddress",
> +    object_class_property_add(oc, "addr", "SocketAddress", NULL,
>                                char_socket_get_addr, NULL,
>                                NULL, NULL);
>  
> diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
> index 3b332276ef5b..e9cb222bf8fb 100644
> --- a/crypto/secret_keyring.c
> +++ b/crypto/secret_keyring.c
> @@ -107,7 +107,7 @@ qcrypto_secret_keyring_class_init(ObjectClass *oc, const void *data)
>      QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
>      sic->load_data = qcrypto_secret_keyring_load_data;
>  
> -    object_class_property_add(oc, "serial", "int32_t",
> +    object_class_property_add(oc, "serial", "int32_t", NULL,
>                                    qcrypto_secret_prop_get_key,
>                                    qcrypto_secret_prop_set_key,
>                                    NULL, NULL);
> diff --git a/event-loop-base.c b/event-loop-base.c
> index 23f554d92ce8..42bf09d58b28 100644
> --- a/event-loop-base.c
> +++ b/event-loop-base.c
> @@ -104,15 +104,15 @@ static void event_loop_base_class_init(ObjectClass *klass,
>      ucc->complete = event_loop_base_complete;
>      ucc->prepare_delete = event_loop_base_prepare_delete;
>  
> -    object_class_property_add(klass, "aio-max-batch", "int64",
> +    object_class_property_add(klass, "aio-max-batch", "int64", NULL,
>                                event_loop_base_get_param,
>                                event_loop_base_set_param,
>                                NULL, &aio_max_batch_info);
> -    object_class_property_add(klass, "thread-pool-min", "int64",
> +    object_class_property_add(klass, "thread-pool-min", "int64", NULL,
>                                event_loop_base_get_param,
>                                event_loop_base_set_param,
>                                NULL, &thread_pool_min_info);
> -    object_class_property_add(klass, "thread-pool-max", "int64",
> +    object_class_property_add(klass, "thread-pool-max", "int64", NULL,
>                                event_loop_base_get_param,
>                                event_loop_base_set_param,
>                                NULL, &thread_pool_max_info);
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 6d421b990cef..f3e248c8daca 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -379,7 +379,7 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
>                                     PM_REG_FIELD(acpi_pci_hotplug.root),
>                                     object_property_allow_set_link,
>                                     OBJ_PROP_LINK_STRONG);
> -    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
> +    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32", NULL,
>                                ich9_pm_get_gpe0_blk,
>                                NULL, NULL, NULL);
>      object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index c82924be8620..abd1071f497e 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -139,8 +139,8 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
>          acpi_generic_initiator_set_pci_device);
>      object_class_property_set_description(oc, "pci-dev",
>          "PCI device to associate with the node");
> -    object_class_property_add(oc, "node", "uint32", NULL,
> -        acpi_generic_initiator_set_node, NULL, NULL);
> +    object_class_property_add(oc, "node", "uint32", NULL, NULL,
> +                              acpi_generic_initiator_set_node, NULL, NULL);
>      object_class_property_set_description(oc, "node",
>          "NUMA node associated with the PCI device");
>  }
> @@ -253,8 +253,8 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
>          acpi_generic_port_set_pci_bus);
>      object_class_property_set_description(oc, "pci-bus",
>         "PCI Bus of the host bridge associated with this GP affinity structure");
> -    object_class_property_add(oc, "node", "uint32", NULL,
> -        acpi_generic_port_set_node, NULL, NULL);
> +    object_class_property_add(oc, "node", "uint32", NULL, NULL,
> +                              acpi_generic_port_set_node, NULL, NULL);
>      object_class_property_set_description(oc, "node",
>         "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");
>  }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d56197dacee..4dc2ec1830f5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4207,9 +4207,9 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>      mc->default_ram_id = "mach-virt.ram";
>      mc->default_nic = "virtio-net-pci";
>  
> -    object_class_property_add(oc, "acpi", "OnOffAuto",
> -        virt_get_acpi, virt_set_acpi,
> -        NULL, NULL);
> +    object_class_property_add(oc, "acpi", "OnOffAuto", NULL,
> +                              virt_get_acpi, virt_set_acpi,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "acpi",
>          "Enable ACPI");
>      object_class_property_add_bool(oc, "secure", virt_get_secure,
> @@ -4260,7 +4260,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>                                            "Set on/off to enable/disable high "
>                                            "memory region for PCI MMIO");
>  
> -    object_class_property_add(oc, "highmem-mmio-size", "size",
> +    object_class_property_add(oc, "highmem-mmio-size", "size", NULL,
>                                     virt_get_highmem_mmio_size,
>                                     virt_set_highmem_mmio_size,
>                                     NULL, NULL);
> @@ -4268,7 +4268,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>                                            "Set the high memory region size "
>                                            "for PCI MMIO");
>  
> -    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
> +    object_class_property_add(oc, "virtio-mmio-transports", "uint8", NULL,
>                                     virt_get_virtio_transports,
>                                     virt_set_virtio_transports,
>                                     NULL, NULL);
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> index 3fc98a0c65d5..d46c888f5c0c 100644
> --- a/hw/core/clock.c
> +++ b/hw/core/clock.c
> @@ -185,7 +185,7 @@ static void clock_initfn(Object *obj)
>      QLIST_INIT(&clk->children);
>  
>      if (qtest_enabled()) {
> -        object_property_add(obj, "qtest-clock-period", "uint64",
> +        object_property_add(obj, "qtest-clock-period", "uint64", NULL,
>                              clock_period_prop_get, NULL, NULL, NULL);
>      }
>  }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d9ac4b419a36..50422750beed 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1118,26 +1118,29 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>      object_class_property_set_description(oc, "dumpdtb",
>          "Dump current dtb to a file and quit");
>  
> -    object_class_property_add(oc, "boot", "BootConfiguration",
> -        machine_get_boot, machine_set_boot,
> -        NULL, NULL);
> +    object_class_property_add(oc, "boot", "BootConfiguration", NULL,
> +                              machine_get_boot, machine_set_boot,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "boot",
>          "Boot configuration");
>  
> -    object_class_property_add(oc, "smp", "SMPConfiguration",
> -        machine_get_smp, machine_set_smp,
> -        NULL, NULL);
> +    object_class_property_add(oc, "smp", "SMPConfiguration", NULL,
> +                              machine_get_smp, machine_set_smp,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "smp",
>          "CPU topology");
>  
>      object_class_property_add(oc, "smp-cache", "SmpCachePropertiesWrapper",
> -        machine_get_smp_cache, machine_set_smp_cache, NULL, NULL);
> +                              NULL,
> +                              machine_get_smp_cache, machine_set_smp_cache,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "smp-cache",
>          "Cache properties list for SMP machine");
>  
> -    object_class_property_add(oc, "phandle-start", "int",
> -        machine_get_phandle_start, machine_set_phandle_start,
> -        NULL, NULL);
> +    object_class_property_add(oc, "phandle-start", "int", NULL,
> +                              machine_get_phandle_start,
> +                              machine_set_phandle_start,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "phandle-start",
>          "The first phandle ID we may generate dynamically");
>  
> @@ -1212,9 +1215,9 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>                                            "Set RAM backend"
>                                            "Valid value is ID of hostmem based backend");
>  
> -    object_class_property_add(oc, "memory", "MemorySizeConfiguration",
> -        machine_get_mem, machine_set_mem,
> -        NULL, NULL);
> +    object_class_property_add(oc, "memory", "MemorySizeConfiguration", NULL,
> +                              machine_get_mem, machine_set_mem,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "memory",
>          "Memory size configuration");
>  }
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 34d7b26a7303..61dca80c95eb 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1150,7 +1150,7 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
>  
>      assert(!prop->info->create);
>  
> -    op = object_property_add(obj, prop->name, prop->info->type,
> +    op = object_property_add(obj, prop->name, prop->info->type, NULL,
>                               field_prop_getter(prop->info),
>                               field_prop_setter(prop->info),
>                               prop->info->release,
> @@ -1176,8 +1176,7 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
>      if (prop->info->create) {
>          op = prop->info->create(oc, name, prop);
>      } else {
> -        op = object_class_property_add(oc,
> -                                       name, prop->info->type,
> +        op = object_class_property_add(oc, name, prop->info->type, NULL,
>                                         field_prop_getter(prop->info),
>                                         field_prop_setter(prop->info),
>                                         prop->info->release,
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 26e488f3d8e3..f430befad870 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -82,9 +82,11 @@ static void cpu_core_class_init(ObjectClass *oc, const void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      set_bit(DEVICE_CATEGORY_CPU, dc->categories);
> -    object_class_property_add(oc, "core-id", "int", core_prop_get_core_id,
> +    object_class_property_add(oc, "core-id", "int", NULL,
> +                              core_prop_get_core_id,
>                                core_prop_set_core_id, NULL, NULL);
> -    object_class_property_add(oc, "nr-threads", "int", core_prop_get_nr_threads,
> +    object_class_property_add(oc, "nr-threads", "int", NULL,
> +                              core_prop_get_nr_threads,
>                                core_prop_set_nr_threads, NULL, NULL);
>  }
>  
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e279ce5fe3ae..2ddff574d1aa 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -610,13 +610,13 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
>  
>  void cxl_machine_init(Object *obj, CXLState *state)
>  {
> -    object_property_add(obj, "cxl", "bool", machine_get_cxl,
> +    object_property_add(obj, "cxl", "bool", NULL, machine_get_cxl,
>                          machine_set_cxl, NULL, state);
>      object_property_set_description(obj, "cxl",
>                                      "Set on/off to enable/disable "
>                                      "CXL instantiation");
>  
> -    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
> +    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow", NULL,
>                          machine_get_cfmw, machine_set_cfmw,
>                          NULL, state);
>      object_property_set_description(obj, "cxl-fmw",
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index 1cf6f5df5505..4463cf7c9ff9 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -1481,7 +1481,7 @@ static void aspeed_gpio_init(Object *obj)
>              int pin_idx = j % GPIOS_PER_GROUP;
>              const char *group = &props->group_label[group_idx][0];
>              char *name = g_strdup_printf("gpio%s%d", group, pin_idx);
> -            object_property_add(obj, name, "bool", aspeed_gpio_get_pin,
> +            object_property_add(obj, name, "bool", NULL, aspeed_gpio_get_pin,
>                                  aspeed_gpio_set_pin, NULL, NULL);
>              g_free(name);
>          }
> @@ -1489,8 +1489,8 @@ static void aspeed_gpio_init(Object *obj)
>  
>      for (int i = 0; i < agc->nr_gpio_sets; i++) {
>          g_autofree char *name = g_strdup_printf("gpio-set[%d]", i);
> -        object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
> -        aspeed_gpio_set_set, NULL, NULL);
> +        object_property_add(obj, name, "uint32", NULL, aspeed_gpio_get_set,
> +                            aspeed_gpio_set_set, NULL, NULL);
>      }
>  }
>  
> diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
> index 7d2f73699520..aeaef4f102fb 100644
> --- a/hw/gpio/aspeed_sgpio.c
> +++ b/hw/gpio/aspeed_sgpio.c
> @@ -300,7 +300,7 @@ static void aspeed_sgpio_init(Object *obj)
>  {
>      for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
>          g_autofree char *name = g_strdup_printf("sgpio%03d", i);
> -        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
> +        object_property_add(obj, name, "bool", NULL, aspeed_sgpio_get_pin,
>                              aspeed_sgpio_set_pin, NULL, NULL);
>      }
>  }
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 719149b7174b..7e5fda4980ea 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -567,12 +567,12 @@ static void pca955x_initfn(Object *obj)
>          if (k->has_led_support) {
>              /* LED variant: expose the LED selector state as led%d. */
>              name = g_strdup_printf("led%d", ix);
> -            object_property_add(obj, name, "bool",
> +            object_property_add(obj, name, "bool", NULL,
>                                  pca955x_get_led, pca955x_set_led, NULL, NULL);
>          } else {
>              /* GPIO variant: expose the pin logic level as pin%d. */
>              name = g_strdup_printf("pin%d", ix);
> -            object_property_add(obj, name, "str",
> +            object_property_add(obj, name, "str", NULL,
>                                  pca955x_get_pin, pca955x_set_pin, NULL, NULL);
>          }
>          g_free(name);
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 904698cdce85..0dd063f93a67 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -280,7 +280,8 @@ static void pca9554_initfn(Object *obj)
>          char *name;
>  
>          name = g_strdup_printf("pin%d", pin);
> -        object_property_add(obj, name, "str", pca9554_get_pin, pca9554_set_pin,
> +        object_property_add(obj, name, "str", NULL, pca9554_get_pin,
> +                            pca9554_set_pin,
>                              NULL, NULL);
>          g_free(name);
>      }
> diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
> index 92fa397fbafe..a31999323ab9 100644
> --- a/hw/gpio/stm32l4x5_gpio.c
> +++ b/hw/gpio/stm32l4x5_gpio.c
> @@ -409,10 +409,10 @@ static void stm32l4x5_gpio_init(Object *obj)
>  
>      s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
>  
> -    object_property_add(obj, "disconnected-pins", "uint16",
> +    object_property_add(obj, "disconnected-pins", "uint16", NULL,
>                          disconnected_pins_get, disconnected_pins_set,
>                          NULL, &s->disconnected_pins);
> -    object_property_add(obj, "clock-freq-hz", "uint32",
> +    object_property_add(obj, "clock-freq-hz", "uint32", NULL,
>                          clock_freq_get, NULL, NULL, NULL);
>  }
>  
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 05b95f39aa26..abccf10c005a 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -153,7 +153,7 @@ static void hexagon_sim_set_subsystem_base(Object *obj, Visitor *v,
>  
>  static void add_dsp_properties(ObjectClass *oc)
>  {
> -    object_class_property_add(oc, "subsystem-base", "uint32",
> +    object_class_property_add(oc, "subsystem-base", "uint32", NULL,
>                                hexagon_sim_get_subsystem_base,
>                                hexagon_sim_set_subsystem_base, NULL, NULL);
>      object_class_property_set_description(oc, "subsystem-base",
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index a49de3374979..c679b3b17713 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -673,21 +673,21 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
>      hc->unplug_request = microvm_device_unplug_request_cb;
>      hc->unplug = microvm_device_unplug_cb;
>  
> -    object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
> +    object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto", NULL,
>                                microvm_machine_get_rtc,
>                                microvm_machine_set_rtc,
>                                NULL, NULL);
>      object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
>          "Enable MC146818 RTC");
>  
> -    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
> +    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto", NULL,
>                                microvm_machine_get_pcie,
>                                microvm_machine_set_pcie,
>                                NULL, NULL);
>      object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
>          "Enable PCIe");
>  
> -    object_class_property_add(oc, MICROVM_MACHINE_IOAPIC2, "OnOffAuto",
> +    object_class_property_add(oc, MICROVM_MACHINE_IOAPIC2, "OnOffAuto", NULL,
>                                microvm_machine_get_ioapic2,
>                                microvm_machine_set_ioapic2,
>                                NULL, NULL);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index dbfd55de3017..1fce96f5ec36 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1722,15 +1722,16 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>      mc->default_ram_id = "pc.ram";
>      pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
>  
> -    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
> -        pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
> -        NULL, NULL);
> +    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size", NULL,
> +                              pc_machine_get_max_ram_below_4g,
> +                              pc_machine_set_max_ram_below_4g,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
>          "Maximum ram below the 4G boundary (32bit boundary)");
>  
> -    object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
> -        pc_machine_get_vmport, pc_machine_set_vmport,
> -        NULL, NULL);
> +    object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto", NULL,
> +                              pc_machine_get_vmport, pc_machine_set_vmport,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, PC_MACHINE_VMPORT,
>          "Enable vmport (pc & q35)");
>  
> @@ -1758,15 +1759,17 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>          pc_machine_get_default_bus_bypass_iommu,
>          pc_machine_set_default_bus_bypass_iommu);
>  
> -    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
> -        pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
> -        NULL, NULL);
> +    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size", NULL,
> +                              pc_machine_get_max_fw_size,
> +                              pc_machine_set_max_fw_size,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
>          "Maximum combined firmware size");
>  
> -    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str",
> -        pc_machine_get_smbios_ep, pc_machine_set_smbios_ep,
> -        NULL, NULL);
> +    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str", NULL,
> +                              pc_machine_get_smbios_ep,
> +                              pc_machine_set_smbios_ep,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
>          "SMBIOS Entry Point type [32, 64]");
>  
> diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
> index 29cda843c942..a1b55c2ec36f 100644
> --- a/hw/i386/sgx-epc.c
> +++ b/hw/i386/sgx-epc.c
> @@ -159,7 +159,7 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
>      mdc->get_memory_region = sgx_epc_md_get_memory_region;
>      mdc->fill_device_info = sgx_epc_md_fill_device_info;
>  
> -    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
> +    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64", NULL,
>                                sgx_epc_get_size,
>                                NULL,
>                                NULL, NULL);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f8ba3244e221..1b7740a97eb6 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -391,26 +391,26 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
>      mc->kvm_type = x86_kvm_type;
>      nc->raise_nmi = x86_nmi;
>  
> -    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
> -        x86_machine_get_smm, x86_machine_set_smm,
> -        NULL, NULL);
> +    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto", NULL,
> +                              x86_machine_get_smm, x86_machine_set_smm,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, X86_MACHINE_SMM,
>          "Enable SMM");
>  
> -    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
> -        x86_machine_get_acpi, x86_machine_set_acpi,
> -        NULL, NULL);
> +    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto", NULL,
> +                              x86_machine_get_acpi, x86_machine_set_acpi,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, X86_MACHINE_ACPI,
>          "Enable ACPI");
>  
> -    object_class_property_add(oc, X86_MACHINE_PIT, "OnOffAuto",
> +    object_class_property_add(oc, X86_MACHINE_PIT, "OnOffAuto", NULL,
>                                x86_machine_get_pit,
>                                x86_machine_set_pit,
>                                NULL, NULL);
>      object_class_property_set_description(oc, X86_MACHINE_PIT,
>          "Enable i8254 PIT");
>  
> -    object_class_property_add(oc, X86_MACHINE_PIC, "OnOffAuto",
> +    object_class_property_add(oc, X86_MACHINE_PIC, "OnOffAuto", NULL,
>                                x86_machine_get_pic,
>                                x86_machine_set_pic,
>                                NULL, NULL);
> @@ -435,14 +435,15 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
>                                            "The string may be up to 8 bytes in size");
>  
>      object_class_property_add(oc, X86_MACHINE_BUS_LOCK_RATELIMIT, "uint64_t",
> +                                NULL,
>                                  x86_machine_get_bus_lock_ratelimit,
>                                  x86_machine_set_bus_lock_ratelimit, NULL, NULL);
>      object_class_property_set_description(oc, X86_MACHINE_BUS_LOCK_RATELIMIT,
>              "Set the ratelimit for the bus locks acquired in VMs");
>  
> -    object_class_property_add(oc, "sgx-epc", "SgxEPC",
> -        machine_get_sgx_epc, machine_set_sgx_epc,
> -        NULL, NULL);
> +    object_class_property_add(oc, "sgx-epc", "SgxEPC", NULL,
> +                              machine_get_sgx_epc, machine_set_sgx_epc,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "sgx-epc",
>          "SGX EPC device");
>  }
> diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
> index 5d478588c614..7bb06088a5f3 100644
> --- a/hw/ide/ide-dev.c
> +++ b/hw/ide/ide-dev.c
> @@ -174,7 +174,7 @@ out:
>  
>  static void ide_dev_instance_init(Object *obj)
>  {
> -    object_property_add(obj, "bootindex", "int32",
> +    object_property_add(obj, "bootindex", "int32", NULL,
>                          ide_dev_get_bootindex,
>                          ide_dev_set_bootindex, NULL, NULL);
>      object_property_set_int(obj, "bootindex", -1, NULL);
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 0f0f37d45734..ee5f6cb4c33e 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -442,7 +442,7 @@ static void apic_common_initfn(Object *obj)
>      APICCommonState *s = APIC_COMMON(obj);
>  
>      s->id = s->initial_apic_id = -1;
> -    object_property_add(obj, "id", "uint32",
> +    object_property_add(obj, "id", "uint32", NULL,
>                          apic_common_get_id,
>                          apic_common_set_id, NULL, NULL);
>  }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 9c5371af9dee..8ad327b8ddb0 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1483,18 +1483,18 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>      hc->unplug_request = virt_device_unplug_request;
>      hc->unplug = virt_device_unplug;
>  
> -    object_class_property_add(oc, "acpi", "OnOffAuto",
> -        virt_get_acpi, virt_set_acpi,
> -        NULL, NULL);
> +    object_class_property_add(oc, "acpi", "OnOffAuto", NULL,
> +                              virt_get_acpi, virt_set_acpi,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "acpi",
>          "Enable ACPI");
> -    object_class_property_add(oc, "v-eiointc", "OnOffAuto",
> -        virt_get_veiointc, virt_set_veiointc,
> -        NULL, NULL);
> +    object_class_property_add(oc, "v-eiointc", "OnOffAuto", NULL,
> +                              virt_get_veiointc, virt_set_veiointc,
> +                              NULL, NULL);
>      object_class_property_set_description(oc, "v-eiointc",
>                              "Enable Virt Extend I/O Interrupt Controller.");
> -    object_class_property_add(oc, "dmsi", "OnOffAuto",
> -        virt_get_dmsi, virt_set_dmsi, NULL, NULL);
> +    object_class_property_add(oc, "dmsi", "OnOffAuto", NULL,
> +                              virt_get_dmsi, virt_set_dmsi, NULL, NULL);
>      object_class_property_set_description(oc, "dmsi",
>                              "Enable direct Message-interrupts Controller.");
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
> @@ -1525,7 +1525,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>      object_class_property_set_description(oc, "highmem-mmio",
>                                            "Set on/off to enable/disable high "
>                                            "memory region for PCI MMIO");
> -    object_class_property_add(oc, "highmem-mmio-size", "size",
> +    object_class_property_add(oc, "highmem-mmio-size", "size", NULL,
>                                     virt_get_highmem_mmio_size,
>                                     virt_set_highmem_mmio_size,
>                                     NULL, NULL);
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index cf8a4d8c5f2a..8d6e8d0bd93c 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -99,11 +99,12 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
>  
>  static void nvdimm_init(Object *obj)
>  {
> -    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size",
> +    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size", NULL,
>                          nvdimm_get_label_size, nvdimm_set_label_size, NULL,
>                          NULL);
>  
> -    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
> +    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", NULL,
> +                        nvdimm_get_uuid,
>                          nvdimm_set_uuid, NULL, NULL);
>  }
>  
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 68862926ee2d..7250146c10d8 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -176,7 +176,8 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
>  
>  static void pc_dimm_init(Object *obj)
>  {
> -    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_size,
> +    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", NULL,
> +                        pc_dimm_get_size,
>                          NULL, NULL, NULL);
>  }
>  
> diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
> index 7f7e4f1a0985..a73df0733217 100644
> --- a/hw/misc/aspeed_lpc.c
> +++ b/hw/misc/aspeed_lpc.c
> @@ -417,29 +417,41 @@ static void aspeed_lpc_realize(DeviceState *dev, Error **errp)
>  
>  static void aspeed_lpc_init(Object *obj)
>  {
> -    object_property_add(obj, "idr1", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "idr1", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "odr1", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "odr1", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "str1", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "str1", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "idr2", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "idr2", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "odr2", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "odr2", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "str2", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "str2", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "idr3", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "idr3", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "odr3", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "odr3", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "str3", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "str3", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "idr4", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "idr4", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "odr4", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "odr4", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
> -    object_property_add(obj, "str4", "uint32", aspeed_kcs_get_register_property,
> +    object_property_add(obj, "str4", "uint32", NULL,
> +                        aspeed_kcs_get_register_property,
>                          aspeed_kcs_set_register_property, NULL, NULL);
>  }
>  
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index f8fbaebee6ab..427816b83899 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -259,7 +259,7 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
>  
>  static void aspeed_sdmc_initfn(Object *obj)
>  {
> -    object_property_add(obj, "ram-size", "int",
> +    object_property_add(obj, "ram-size", "int", NULL,
>                          aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size,
>                          NULL, NULL);
>  }
> diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
> index 742166c4e828..3ce92fad3afc 100644
> --- a/hw/misc/npcm7xx_mft.c
> +++ b/hw/misc/npcm7xx_mft.c
> @@ -491,7 +491,7 @@ static void npcm7xx_mft_init(Object *obj)
>      s->clock_2 = qdev_init_clock_out(dev, "clock2");
>  
>      for (int i = 0; i < NPCM7XX_PWM_PER_MODULE; ++i) {
> -        object_property_add(obj, "max_rpm[*]", "uint32",
> +        object_property_add(obj, "max_rpm[*]", "uint32", NULL,
>                              npcm7xx_mft_get_max_rpm,
>                              npcm7xx_mft_set_max_rpm,
>                              NULL, &s->max_rpm[i]);
> diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
> index 673c785abc94..02300eaaa6fd 100644
> --- a/hw/net/ne2000-isa.c
> +++ b/hw/net/ne2000-isa.c
> @@ -131,7 +131,7 @@ out:
>  
>  static void isa_ne2000_instance_init(Object *obj)
>  {
> -    object_property_add(obj, "bootindex", "int32",
> +    object_property_add(obj, "bootindex", "int32", NULL,
>                          isa_ne2000_get_bootindex,
>                          isa_ne2000_set_bootindex, NULL, NULL);
>      object_property_set_int(obj, "bootindex", -1, NULL);
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 578421c21761..405010af4bf1 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -10612,7 +10612,7 @@ static void nvme_instance_init(Object *obj)
>                                    "bootindex", "/namespace@1,0",
>                                    DEVICE(obj));
>  
> -    object_property_add(obj, "smart_critical_warning", "uint8",
> +    object_property_add(obj, "smart_critical_warning", "uint8", NULL,
>                          nvme_get_smart_warning,
>                          nvme_set_smart_warning, NULL, NULL);
>  }
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 40ffbc4e0821..1b22f5e383e1 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -103,7 +103,7 @@ static void pxb_bus_class_init(ObjectClass *class, const void *data)
>      pbc->bus_num = pxb_bus_num;
>      pbc->numa_node = pxb_bus_numa_node;
>  
> -    object_class_property_add(class, "acpi_uid", "uint32",
> +    object_class_property_add(class, "acpi_uid", "uint32", NULL,
>                                prop_pxb_uid_get, NULL, NULL, NULL);
>      object_class_property_set_description(class, "acpi_uid",
>          "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index c1982f7962a6..bf4b6c425345 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -388,18 +388,22 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, const void *data)
>      dc->user_creatable = false;
>  
>      object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
> +                              NULL,
>                                i440fx_pcihost_get_pci_hole_start,
>                                NULL, NULL, NULL);
>  
>      object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
> +                              NULL,
>                                i440fx_pcihost_get_pci_hole_end,
>                                NULL, NULL, NULL);
>  
>      object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
> +                              NULL,
>                                i440fx_pcihost_get_pci_hole64_start,
>                                NULL, NULL, NULL);
>  
>      object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
> +                              NULL,
>                                i440fx_pcihost_get_pci_hole64_end,
>                                NULL, NULL, NULL);
>  }
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index db061c134e95..c45401d9dd96 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -1164,12 +1164,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
>  
> -    object_class_property_add(klass, "phb-id", "uint32",
> +    object_class_property_add(klass, "phb-id", "uint32", NULL,
>                                pnv_phb3_root_bus_get_prop,
>                                pnv_phb3_root_bus_set_prop,
>                                NULL, NULL);
>  
> -    object_class_property_add(klass, "chip-id", "uint32",
> +    object_class_property_add(klass, "chip-id", "uint32", NULL,
>                                pnv_phb3_root_bus_get_prop,
>                                pnv_phb3_root_bus_set_prop,
>                                NULL, NULL);
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 9acaf4c0c2f5..6727cbc3813a 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1761,12 +1761,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
>  
> -    object_class_property_add(klass, "phb-id", "uint32",
> +    object_class_property_add(klass, "phb-id", "uint32", NULL,
>                                pnv_phb4_root_bus_get_prop,
>                                pnv_phb4_root_bus_set_prop,
>                                NULL, NULL);
>  
> -    object_class_property_add(klass, "chip-id", "uint32",
> +    object_class_property_add(klass, "chip-id", "uint32", NULL,
>                                pnv_phb4_root_bus_get_prop,
>                                pnv_phb4_root_bus_set_prop,
>                                NULL, NULL);
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index f4556ad03a04..027ae02066de 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -226,19 +226,19 @@ static void q35_host_initfn(Object *obj)
>      qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
>                           Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
>  
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32", NULL,
>                          q35_host_get_pci_hole_start,
>                          NULL, NULL, NULL);
>  
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32", NULL,
>                          q35_host_get_pci_hole_end,
>                          NULL, NULL, NULL);
>  
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64", NULL,
>                          q35_host_get_pci_hole64_start,
>                          NULL, NULL, NULL);
>  
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64", NULL,
>                          q35_host_get_pci_hole64_end,
>                          NULL, NULL, NULL);
>  
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 0d659e9b0251..b8c48bca8a15 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -1069,7 +1069,7 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
>          g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
>          g_autofree char *desc = g_strdup(cap->description);
>  
> -        object_class_property_add(klass, name, cap->type,
> +        object_class_property_add(klass, name, cap->type, NULL,
>                                    cap->get, cap->set,
>                                    NULL, cap);
>  
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 5c2150b71c86..a33f0949d1e3 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -584,9 +584,9 @@ static void spapr_dr_connector_instance_init(Object *obj)
>      SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>  
>      object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
> -    object_property_add(obj, "index", "uint32", prop_get_index,
> +    object_property_add(obj, "index", "uint32", NULL, prop_get_index,
>                          NULL, NULL, NULL);
> -    object_property_add(obj, "fdt", "struct", prop_get_fdt,
> +    object_property_add(obj, "fdt", "struct", NULL, prop_get_fdt,
>                          NULL, NULL, NULL);
>      drc->state = drck->empty_state;
>  }
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index a0498d218faf..c4b3cb0b7b87 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -931,7 +931,7 @@ static void vfu_object_class_init(ObjectClass *klass, const void *data)
>  
>      k->nr_devs = 0;
>  
> -    object_class_property_add(klass, "socket", "SocketAddress", NULL,
> +    object_class_property_add(klass, "socket", "SocketAddress", NULL, NULL,
>                                vfu_object_set_socket, NULL, NULL);
>      object_class_property_set_description(klass, "socket",
>                                            "SocketAddress "
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index edd29626fa07..04c48a4eda93 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -744,6 +744,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
>      mc->default_ram_size = 1537 * MiB;
>  
>      object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
> +                              NULL,
>                                microchip_icicle_kit_get_clint_timebase_freq,
>                                microchip_icicle_kit_set_clint_timebase_freq,
>                                NULL, NULL);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index de1c92463ad4..65f4c67bff97 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1184,13 +1184,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>          object_class_property_set_description(oc, "aia-guests", str);
>      }
>  
> -    object_class_property_add(oc, "acpi", "OnOffAuto",
> +    object_class_property_add(oc, "acpi", "OnOffAuto", NULL,
>                                virt_get_acpi, virt_set_acpi,
>                                NULL, NULL);
>      object_class_property_set_description(oc, "acpi",
>                                            "Enable ACPI");
>  
> -    object_class_property_add(oc, "iommu-sys", "OnOffAuto",
> +    object_class_property_add(oc, "iommu-sys", "OnOffAuto", NULL,
>                                virt_get_iommu_sys, virt_set_iommu_sys,
>                                NULL, NULL);
>      object_class_property_set_description(oc, "iommu-sys",
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fda5ecc9ad3c..7d4392d73fa2 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -908,7 +908,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>      object_class_property_set_description(oc, "dea-key-wrap",
>              "enable/disable DEA key wrapping using the CPACF wrapping key");
>  
> -    object_class_property_add(oc, "loadparm", "loadparm",
> +    object_class_property_add(oc, "loadparm", "loadparm", NULL,
>                                machine_get_loadparm, machine_set_loadparm,
>                                NULL, NULL);
>      object_class_property_set_description(oc, "loadparm",
> @@ -916,7 +916,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>              " to upper case) to pass to machine loader, boot manager,"
>              " and guest kernel");
>  
> -    object_class_property_add(oc, "boot-certs", "BootCertificatesList",
> +    object_class_property_add(oc, "boot-certs", "BootCertificatesList", NULL,
>                                machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
>      object_class_property_set_description(oc, "boot-certs",
>              "provide paths to a directory and/or a certificate file for secure boot");
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index ec4bdf23509b..90cb36aad6f2 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -195,12 +195,14 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
>              "name of the cluster which the VM belongs to, if any"
>              " e.g. \"PLEX    \"");
>  
> -    object_class_property_add(klass, "system_level", "uint64", get_system_level,
> +    object_class_property_add(klass, "system_level", "uint64", NULL,
> +                              get_system_level,
>                                NULL, NULL, NULL);
>      object_class_property_set_description(klass, "system_level",
>              "distribution and kernel version in Linux e.g. 74872343805430528");
>  
> -    object_class_property_add(klass, "timestamp", "uint64", get_timestamp,
> +    object_class_property_add(klass, "timestamp", "uint64", NULL,
> +                              get_timestamp,
>                                NULL, NULL, NULL);
>      object_class_property_set_description(klass, "timestamp",
>              "latest update of CPI data in nanoseconds since the UNIX EPOCH");
> diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
> index dea30aacfb32..1dc19ca9146e 100644
> --- a/hw/s390x/virtio-ccw-mem.c
> +++ b/hw/s390x/virtio-ccw-mem.c
> @@ -205,7 +205,7 @@ static void virtio_ccw_mem_instance_init(Object *obj)
>                                OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
>      object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
>                                VIRTIO_MEM_SIZE_PROP);
> -    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
> +    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size", NULL,
>                          virtio_ccw_mem_get_requested_size,
>                          virtio_ccw_mem_set_requested_size, NULL, NULL);
>  }
> diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
> index c65508cba144..14d79d395834 100644
> --- a/hw/sensor/adc128d818.c
> +++ b/hw/sensor/adc128d818.c
> @@ -642,14 +642,16 @@ static void adc128d818_initfn(Object *obj)
>      for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
>          char *name = g_strdup_printf("ain%u", ch);
>  
> -        object_property_add(obj, name, "int", adc128d818_get_ain,
> +        object_property_add(obj, name, "int", NULL, adc128d818_get_ain,
>                              adc128d818_set_ain, NULL, NULL);
>          g_free(name);
>      }
>  
> -    object_property_add(obj, "temperature", "int", adc128d818_get_temperature,
> +    object_property_add(obj, "temperature", "int", NULL,
> +                        adc128d818_get_temperature,
>                          adc128d818_set_temperature, NULL, NULL);
> -    object_property_add(obj, "ext-vref-mv", "int", adc128d818_get_ext_vref,
> +    object_property_add(obj, "ext-vref-mv", "int", NULL,
> +                        adc128d818_get_ext_vref,
>                          adc128d818_set_ext_vref, NULL, NULL);
>  }
>  
> diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
> index 37d1cffd57a9..7927845e328c 100644
> --- a/hw/sensor/adm1266.c
> +++ b/hw/sensor/adm1266.c
> @@ -217,7 +217,7 @@ static void adm1266_init(Object *obj)
>      for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
>          pmbus_page_config(pmdev, i, flags);
>  
> -        object_property_add(obj, "vout[*]", "uint16",
> +        object_property_add(obj, "vout[*]", "uint16", NULL,
>                              adm1266_get,
>                              adm1266_set, NULL, &pmdev->pages[i].read_vout);
>      }
> diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
> index 0aa2a8655683..6a7ff02617fc 100644
> --- a/hw/sensor/adm1272.c
> +++ b/hw/sensor/adm1272.c
> @@ -493,19 +493,19 @@ static void adm1272_init(Object *obj)
>  
>      pmbus_page_config(pmdev, 0, flags);
>  
> -    object_property_add(obj, "vin", "uint16",
> +    object_property_add(obj, "vin", "uint16", NULL,
>                          adm1272_get,
>                          adm1272_set, NULL, &pmdev->pages[0].read_vin);
>  
> -    object_property_add(obj, "vout", "uint16",
> +    object_property_add(obj, "vout", "uint16", NULL,
>                          adm1272_get,
>                          adm1272_set, NULL, &pmdev->pages[0].read_vout);
>  
> -    object_property_add(obj, "iout", "uint16",
> +    object_property_add(obj, "iout", "uint16", NULL,
>                          adm1272_get,
>                          adm1272_set, NULL, &pmdev->pages[0].read_iout);
>  
> -    object_property_add(obj, "pin", "uint16",
> +    object_property_add(obj, "pin", "uint16", NULL,
>                          adm1272_get,
>                          adm1272_set, NULL, &pmdev->pages[0].read_pin);
>  
> diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
> index a51fc44395ab..128d721b7bef 100644
> --- a/hw/sensor/emc141x.c
> +++ b/hw/sensor/emc141x.c
> @@ -251,16 +251,16 @@ static void emc141x_reset(DeviceState *dev)
>  
>  static void emc141x_initfn(Object *obj)
>  {
> -    object_property_add(obj, "temperature0", "int",
> +    object_property_add(obj, "temperature0", "int", NULL,
>                          emc141x_get_temperature,
>                          emc141x_set_temperature, NULL, NULL);
> -    object_property_add(obj, "temperature1", "int",
> +    object_property_add(obj, "temperature1", "int", NULL,
>                          emc141x_get_temperature,
>                          emc141x_set_temperature, NULL, NULL);
> -    object_property_add(obj, "temperature2", "int",
> +    object_property_add(obj, "temperature2", "int", NULL,
>                          emc141x_get_temperature,
>                          emc141x_set_temperature, NULL, NULL);
> -    object_property_add(obj, "temperature3", "int",
> +    object_property_add(obj, "temperature3", "int", NULL,
>                          emc141x_get_temperature,
>                          emc141x_set_temperature, NULL, NULL);
>  }
> diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
> index 0fad04def773..1af0f2af35a1 100644
> --- a/hw/sensor/isl_pmbus_vr.c
> +++ b/hw/sensor/isl_pmbus_vr.c
> @@ -136,63 +136,63 @@ static void isl_pmbus_vr_add_props(Object *obj, uint64_t *flags, uint8_t pages)
>      PMBusDevice *pmdev = PMBUS_DEVICE(obj);
>      for (int i = 0; i < pages; i++) {
>          if (flags[i] & PB_HAS_VIN) {
> -            object_property_add(obj, "vin[*]", "uint16",
> +            object_property_add(obj, "vin[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_vin);
>          }
>  
>          if (flags[i] & PB_HAS_VOUT) {
> -            object_property_add(obj, "vout[*]", "uint16",
> +            object_property_add(obj, "vout[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_vout);
>          }
>  
>          if (flags[i] & PB_HAS_IIN) {
> -            object_property_add(obj, "iin[*]", "uint16",
> +            object_property_add(obj, "iin[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_iin);
>          }
>  
>          if (flags[i] & PB_HAS_IOUT) {
> -            object_property_add(obj, "iout[*]", "uint16",
> +            object_property_add(obj, "iout[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_iout);
>          }
>  
>          if (flags[i] & PB_HAS_PIN) {
> -            object_property_add(obj, "pin[*]", "uint16",
> +            object_property_add(obj, "pin[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_pin);
>          }
>  
>          if (flags[i] & PB_HAS_POUT) {
> -            object_property_add(obj, "pout[*]", "uint16",
> +            object_property_add(obj, "pout[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_pout);
>          }
>  
>          if (flags[i] & PB_HAS_TEMPERATURE) {
> -            object_property_add(obj, "temp1[*]", "uint16",
> +            object_property_add(obj, "temp1[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_temperature_1);
>          }
>  
>          if (flags[i] & PB_HAS_TEMP2) {
> -            object_property_add(obj, "temp2[*]", "uint16",
> +            object_property_add(obj, "temp2[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_temperature_2);
>          }
>  
>          if (flags[i] & PB_HAS_TEMP3) {
> -            object_property_add(obj, "temp3[*]", "uint16",
> +            object_property_add(obj, "temp3[*]", "uint16", NULL,
>                                  isl_pmbus_vr_get,
>                                  isl_pmbus_vr_set,
>                                  NULL, &pmdev->pages[i].read_temperature_3);
> diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
> index cd5773ae64e8..f362686b69a5 100644
> --- a/hw/sensor/lsm303dlhc_mag.c
> +++ b/hw/sensor/lsm303dlhc_mag.c
> @@ -509,21 +509,21 @@ static void lsm303dlhc_mag_reset(DeviceState *dev)
>   */
>  static void lsm303dlhc_mag_initfn(Object *obj)
>  {
> -    object_property_add(obj, "mag-x", "int",
> -                lsm303dlhc_mag_get_x,
> -                lsm303dlhc_mag_set_x, NULL, NULL);
> +    object_property_add(obj, "mag-x", "int", NULL,
> +                        lsm303dlhc_mag_get_x,
> +                        lsm303dlhc_mag_set_x, NULL, NULL);
>  
> -    object_property_add(obj, "mag-y", "int",
> -                lsm303dlhc_mag_get_y,
> -                lsm303dlhc_mag_set_y, NULL, NULL);
> +    object_property_add(obj, "mag-y", "int", NULL,
> +                        lsm303dlhc_mag_get_y,
> +                        lsm303dlhc_mag_set_y, NULL, NULL);
>  
> -    object_property_add(obj, "mag-z", "int",
> -                lsm303dlhc_mag_get_z,
> -                lsm303dlhc_mag_set_z, NULL, NULL);
> +    object_property_add(obj, "mag-z", "int", NULL,
> +                        lsm303dlhc_mag_get_z,
> +                        lsm303dlhc_mag_set_z, NULL, NULL);
>  
> -    object_property_add(obj, "temperature", "int",
> -                lsm303dlhc_mag_get_temperature,
> -                lsm303dlhc_mag_set_temperature, NULL, NULL);
> +    object_property_add(obj, "temperature", "int", NULL,
> +                        lsm303dlhc_mag_get_temperature,
> +                        lsm303dlhc_mag_set_temperature, NULL, NULL);
>  }
>  
>  /*
> diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
> index 4d64434f3af4..6c2f7311ff77 100644
> --- a/hw/sensor/max34451.c
> +++ b/hw/sensor/max34451.c
> @@ -727,7 +727,7 @@ static void max34451_init(Object *obj)
>  
>      /* get and set the voltage in millivolts, max is 32767 mV */
>      for (int i = 0; i < MAX34451_NUM_PWR_DEVICES; i++) {
> -        object_property_add(obj, "vout[*]", "uint16",
> +        object_property_add(obj, "vout[*]", "uint16", NULL,
>                              max34451_get,
>                              max34451_set, NULL, &pmdev->pages[i].read_vout);
>      }
> @@ -737,7 +737,7 @@ static void max34451_init(Object *obj)
>       * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
>       */
>      for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES; i++) {
> -        object_property_add(obj, "temperature[*]", "uint16",
> +        object_property_add(obj, "temperature[*]", "uint16", NULL,
>                              max34451_get,
>                              max34451_set,
>                              NULL,
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index ece0650d703f..98f45a49b7c8 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -408,7 +408,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
>  
>  static void tmp105_initfn(Object *obj)
>  {
> -    object_property_add(obj, "temperature", "int",
> +    object_property_add(obj, "temperature", "int", NULL,
>                          tmp105_get_temperature,
>                          tmp105_set_temperature, NULL, NULL);
>      object_property_set_description(obj, "temperature",
> diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
> index 127edd0ba568..8e6823dfccc9 100644
> --- a/hw/sensor/tmp421.c
> +++ b/hw/sensor/tmp421.c
> @@ -350,16 +350,16 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
>      dc->vmsd = &vmstate_tmp421;
>      sc->dev = (DeviceInfo *) data;
>  
> -    object_class_property_add(klass, "temperature0", "int",
> +    object_class_property_add(klass, "temperature0", "int", NULL,
>                                tmp421_get_temperature,
>                                tmp421_set_temperature, NULL, NULL);
> -    object_class_property_add(klass, "temperature1", "int",
> +    object_class_property_add(klass, "temperature1", "int", NULL,
>                                tmp421_get_temperature,
>                                tmp421_set_temperature, NULL, NULL);
> -    object_class_property_add(klass, "temperature2", "int",
> +    object_class_property_add(klass, "temperature2", "int", NULL,
>                                tmp421_get_temperature,
>                                tmp421_set_temperature, NULL, NULL);
> -    object_class_property_add(klass, "temperature3", "int",
> +    object_class_property_add(klass, "temperature3", "int", NULL,
>                                tmp421_get_temperature,
>                                tmp421_set_temperature, NULL, NULL);
>  }
> diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
> index 977151c4a087..dfd568da5edc 100644
> --- a/hw/usb/dev-storage-classic.c
> +++ b/hw/usb/dev-storage-classic.c
> @@ -122,7 +122,7 @@ out:
>  
>  static void usb_msd_instance_init(Object *obj)
>  {
> -    object_property_add(obj, "bootindex", "int32",
> +    object_property_add(obj, "bootindex", "int32", NULL,
>                          usb_msd_get_bootindex,
>                          usb_msd_set_bootindex, NULL, NULL);
>      object_property_set_int(obj, "bootindex", -1, NULL);
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 983e1d4ad470..4c76a3fe5d83 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -471,7 +471,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
>      device_class_set_legacy_reset(dc, vfio_user_pci_reset);
>      device_class_set_props(dc, vfio_user_pci_properties);
>  
> -    object_class_property_add(klass, "socket", "SocketAddress", NULL,
> +    object_class_property_add(klass, "socket", "SocketAddress", NULL, NULL,
>                                vfio_user_pci_set_socket, NULL, NULL);
>      object_class_property_set_description(klass, "socket",
>                                            "SocketAddress (UNIX sockets only)");
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 07d519cf6d77..995b1a41efde 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -1036,10 +1036,10 @@ static void virtio_balloon_instance_init(Object *obj)
>      s->free_page_hint_cmd_id = VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
>      s->free_page_hint_notify.notify = virtio_balloon_free_page_hint_notify;
>  
> -    object_property_add(obj, "guest-stats", "guest statistics",
> +    object_property_add(obj, "guest-stats", "guest statistics", NULL,
>                          balloon_stats_get_all, NULL, NULL, NULL);
>  
> -    object_property_add(obj, "guest-stats-polling-interval", "int",
> +    object_property_add(obj, "guest-stats-polling-interval", "int", NULL,
>                          balloon_stats_get_poll_interval,
>                          balloon_stats_set_poll_interval,
>                          NULL, NULL);
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> index f592eb1a7849..6349337bf42f 100644
> --- a/hw/virtio/virtio-mem-pci.c
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -211,7 +211,7 @@ static void virtio_mem_pci_instance_init(Object *obj)
>                                OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
>      object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
>                                VIRTIO_MEM_SIZE_PROP);
> -    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
> +    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size", NULL,
>                          virtio_mem_pci_get_requested_size,
>                          virtio_mem_pci_set_requested_size, NULL, NULL);
>  }
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7130ed852d9c..fcfd9fa18ab9 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -1533,12 +1533,13 @@ static void virtio_mem_instance_init(Object *obj)
>  
>      notifier_list_init(&vmem->size_change_notifiers);
>  
> -    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
> +    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", NULL,
> +                        virtio_mem_get_size,
>                          NULL, NULL, NULL);
> -    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
> +    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size", NULL,
>                          virtio_mem_get_requested_size,
>                          virtio_mem_set_requested_size, NULL, NULL);
> -    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size",
> +    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size", NULL,
>                          virtio_mem_get_block_size, virtio_mem_set_block_size,
>                          NULL, NULL);
>  }
> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index cca37202ffb2..ddeabe30f26d 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -413,7 +413,7 @@ void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
>  
>  #define OC_MEMMAP_PROP_BASE(c, prop_name, name)                           \
>  do {                                                                      \
> -    object_class_property_add(c, prop_name "-base", "uint64_t",           \
> +    object_class_property_add(c, prop_name "-base", "uint64_t", NULL,     \
>                                xen_pvh_get_ ## name ## _base,              \
>                                xen_pvh_set_ ## name ## _base, NULL, NULL); \
>      object_class_property_set_description(oc, prop_name "-base",          \
> @@ -422,7 +422,7 @@ do {                                                                      \
>  
>  #define OC_MEMMAP_PROP_SIZE(c, prop_name, name)                           \
>  do {                                                                      \
> -    object_class_property_add(c, prop_name "-size", "uint64_t",           \
> +    object_class_property_add(c, prop_name "-size", "uint64_t", NULL,     \
>                                xen_pvh_get_ ## name ## _size,              \
>                                xen_pvh_set_ ## name ## _size, NULL, NULL); \
>      object_class_property_set_description(oc, prop_name "-size",          \
> @@ -458,7 +458,7 @@ do {                                                                      \
>          OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
>          OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
>  
> -        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
> +        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t", NULL,
>                                    xen_pvh_get_pci_intx_irq_base,
>                                    xen_pvh_set_pci_intx_irq_base,
>                                    NULL, NULL);
> @@ -468,7 +468,7 @@ do {                                                                      \
>  
>  #ifdef CONFIG_TPM
>      if (xpc->has_tpm) {
> -        object_class_property_add(oc, "tpm-base-addr", "uint64_t",
> +        object_class_property_add(oc, "tpm-base-addr", "uint64_t", NULL,
>                                    xen_pvh_get_tpm_base,
>                                    xen_pvh_set_tpm_base,
>                                    NULL, NULL);
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e9b380462ded..84b273e53545 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1163,6 +1163,7 @@ void object_unref(void *obj);
>   *   defined.  Sub namespaces are constructed by using a prefix and then
>   *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
>   *   'link' namespace would be 'link<virtio-net-pci>'.
> + * @qapi_type: QAPI type info descriptor
>   * @get: The getter to be called to read a property.  If this is NULL, then
>   *   the property cannot be read.
>   * @set: the setter to be called to write a property.  If this is NULL,
> @@ -1188,6 +1189,7 @@ void object_unref(void *obj);
>   */
>  ObjectProperty *object_property_try_add(Object *obj, const char *name,
>                                          const char *type,
> +                                        QAPITypeInfo *qapi_type,

should be const QAPITypeInfo *

>                                          ObjectPropertyAccessor *get,
>                                          ObjectPropertyAccessor *set,
>                                          ObjectPropertyRelease *release,
> @@ -1203,6 +1205,7 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>   *   defined.  Sub namespaces are constructed by using a prefix and then
>   *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
>   *   'link' namespace would be 'link<virtio-net-pci>'.
> + * @qapi_type: QAPI type info descriptor
>   * @get: The getter to be called to read a property.  If this is NULL, then
>   *   the property cannot be read.
>   * @set: the setter to be called to write a property.  If this is NULL,
> @@ -1220,6 +1223,7 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>   */
>  ObjectProperty *object_property_add(Object *obj, const char *name,
>                                      const char *type,
> +                                    const QAPITypeInfo *qapi_type,
>                                      ObjectPropertyAccessor *get,
>                                      ObjectPropertyAccessor *set,
>                                      ObjectPropertyRelease *release,
> @@ -1237,6 +1241,7 @@ void object_property_del(Object *obj, const char *name);
>  
>  ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
>                                            const char *type,
> +                                          const QAPITypeInfo *qapi_type,
>                                            ObjectPropertyAccessor *get,
>                                            ObjectPropertyAccessor *set,
>                                            ObjectPropertyRelease *release,
> diff --git a/iothread.c b/iothread.c
> index 76eea6df3861..7084d336a400 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -315,19 +315,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
>      bc->init = iothread_init;
>      bc->update_params = iothread_set_aio_context_params;
>  
> -    object_class_property_add(klass, "poll-max-ns", "int64",
> +    object_class_property_add(klass, "poll-max-ns", "int64", NULL,
>                                iothread_get_poll_param,
>                                iothread_set_poll_param,
>                                NULL, &poll_max_ns_info);
> -    object_class_property_add(klass, "poll-grow", "int64",
> +    object_class_property_add(klass, "poll-grow", "int64", NULL,
>                                iothread_get_poll_param,
>                                iothread_set_poll_param,
>                                NULL, &poll_grow_info);
> -    object_class_property_add(klass, "poll-shrink", "int64",
> +    object_class_property_add(klass, "poll-shrink", "int64", NULL,
>                                iothread_get_poll_param,
>                                iothread_set_poll_param,
>                                NULL, &poll_shrink_info);
> -    object_class_property_add(klass, "poll-weight", "int64",
> +    object_class_property_add(klass, "poll-weight", "int64", NULL,
>                                iothread_get_poll_param,
>                                iothread_set_poll_param,
>                                NULL, &poll_weight_info);
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 5986fb1e8800..7d4a2db522ad 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1373,15 +1373,15 @@ static void colo_compare_init(Object *obj)
>      object_property_add_str(obj, "notify_dev",
>                              compare_get_notify_dev, compare_set_notify_dev);
>  
> -    object_property_add(obj, "compare_timeout", "uint64",
> +    object_property_add(obj, "compare_timeout", "uint64", NULL,
>                          compare_get_timeout,
>                          compare_set_timeout, NULL, NULL);
>  
> -    object_property_add(obj, "expired_scan_cycle", "uint32",
> +    object_property_add(obj, "expired_scan_cycle", "uint32", NULL,
>                          compare_get_expired_scan_cycle,
>                          compare_set_expired_scan_cycle, NULL, NULL);
>  
> -    object_property_add(obj, "max_queue_size", "uint32",
> +    object_property_add(obj, "max_queue_size", "uint32", NULL,
>                          get_max_queue_size,
>                          set_max_queue_size, NULL, NULL);
>  
> diff --git a/net/dump.c b/net/dump.c
> index 0c39f09892c2..558115b9c9e3 100644
> --- a/net/dump.c
> +++ b/net/dump.c
> @@ -238,7 +238,8 @@ static void filter_dump_class_init(ObjectClass *oc, const void *data)
>  {
>      NetFilterClass *nfc = NETFILTER_CLASS(oc);
>  
> -    object_class_property_add(oc, "maxlen", "uint32", filter_dump_get_maxlen,
> +    object_class_property_add(oc, "maxlen", "uint32", NULL,
> +                              filter_dump_get_maxlen,
>                                filter_dump_set_maxlen, NULL, NULL);
>      object_class_property_add_str(oc, "file", file_dump_get_filename,
>                                    file_dump_set_filename);
> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index 427da24097f2..f56b2cfaf0b1 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -182,7 +182,7 @@ static void filter_buffer_class_init(ObjectClass *oc, const void *data)
>  {
>      NetFilterClass *nfc = NETFILTER_CLASS(oc);
>  
> -    object_class_property_add(oc, "interval", "uint32",
> +    object_class_property_add(oc, "interval", "uint32", NULL,
>                                filter_buffer_get_interval,
>                                filter_buffer_set_interval, NULL, NULL);
>  
> diff --git a/qom/object.c b/qom/object.c
> index c34b47312f29..0fbd4a7edfbe 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1340,6 +1340,7 @@ void object_unref(void *objptr)
>  
>  ObjectProperty *
>  object_property_try_add(Object *obj, const char *name, const char *type,
> +                        QAPITypeInfo *qapi_type,
>                          ObjectPropertyAccessor *get,
>                          ObjectPropertyAccessor *set,
>                          ObjectPropertyRelease *release,
> @@ -1357,8 +1358,8 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>          for (i = 0; i < INT16_MAX; ++i) {
>              char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
>  
> -            ret = object_property_try_add(obj, full_name, type, get, set,
> -                                          release, opaque, NULL);
> +            ret = object_property_try_add(obj, full_name, type, NULL,

Propagate @qapi_type to the generated name[i] properties.

> +                                          get, set, release, opaque, NULL);
>              g_free(full_name);
>              if (ret) {
>                  break;
> @@ -1379,6 +1380,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>  
>      prop->name = g_strdup(name);
>      prop->type = g_strdup(type);
> +    prop->qapi_type = qapi_type;
>  
>      prop->get = get;
>      prop->set = set;
> @@ -1393,12 +1395,13 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>  
>  ObjectProperty *
>  object_property_add(Object *obj, const char *name, const char *type,
> +                    const QAPITypeInfo *qapi_type,
>                      ObjectPropertyAccessor *get,
>                      ObjectPropertyAccessor *set,
>                      ObjectPropertyRelease *release,
>                      void *opaque)
>  {
> -    return object_property_try_add(obj, name, type, get, set, release,
> +    return object_property_try_add(obj, name, type, NULL, get, set, release,

This should pass @qapi_type also

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


