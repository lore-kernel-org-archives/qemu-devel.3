Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC57F54ADA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w559O-0006i0-Cv; Tue, 24 Mar 2026 13:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w559M-0006hZ-LK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w559K-0001Nh-Nf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774371757;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ieuV7lGd4eCsU/pyXDsr8lPONGdhfmYX1g6NYVWP87k=;
 b=getxeTSQ2uyVxpBoxEyy5z4f+EpxETuF4vpynwabn1Y7iL/e0bwRT8EmCLDoqqB9+/aXPF
 Tt8dQKJ+DbSxFwI15JAUelIiVXh1yn1b0AZLj31BHNWKgqxe1z/wUqKEkC4TLQAfFxEM+I
 TXdK1lw9++sRLRmrBcwxHadJiEjFq+0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-zgawfDQ2PSeumiaVtgZPIQ-1; Tue,
 24 Mar 2026 13:02:36 -0400
X-MC-Unique: zgawfDQ2PSeumiaVtgZPIQ-1
X-Mimecast-MFC-AGG-ID: zgawfDQ2PSeumiaVtgZPIQ_1774371755
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348311954B10
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 17:02:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB7541955D71; Tue, 24 Mar 2026 17:02:33 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:02:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
Message-ID: <acLDpimgjedofUgE@redhat.com>
References: <20260324165705.785605-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324165705.785605-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 05:57:05PM +0100, Paolo Bonzini wrote:
> The version is never set on 2.5+ machine types, so qemu_hw_version() and
> qemu_set_hw_version() are not needed anymore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/core/boards.h  |  6 ------
>  include/qemu/hw-version.h | 15 ---------------
>  hw/ide/core.c             |  2 +-
>  hw/scsi/megasas.c         |  2 +-
>  hw/scsi/scsi-bus.c        |  2 +-
>  hw/scsi/scsi-disk.c       |  2 +-
>  system/vl.c               |  4 ----
>  target/s390x/cpu_models.c |  2 +-
>  util/osdep.c              | 12 ------------
>  9 files changed, 5 insertions(+), 42 deletions(-)
> 
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index f85f31bd90d..b8dad0a1074 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -197,11 +197,6 @@ typedef struct {
>   *    used to provide @cpu_index to socket number mapping, allowing
>   *    a machine to group CPU threads belonging to the same socket/package
>   *    Returns: socket number given cpu_index belongs to.
> - * @hw_version:
> - *    Value of QEMU_VERSION when the machine was added to QEMU.
> - *    Set only by old machines because they need to keep
> - *    compatibility on code that exposed QEMU_VERSION to guests in
> - *    the past (and now use qemu_hw_version()).
>   * @possible_cpu_arch_ids:
>   *    Returns an array of @CPUArchId architecture-dependent CPU IDs
>   *    which includes CPU IDs for present and possible to hotplug CPUs.
> @@ -297,7 +292,6 @@ struct MachineClass {
>      const char *default_display;
>      const char *default_nic;
>      GPtrArray *compat_props;
> -    const char *hw_version;
>      ram_addr_t default_ram_size;
>      const char *default_cpu_type;
>      bool default_kernel_irqchip_split;
> diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h
> index 730a8c904d9..a40a6c204a6 100644
> --- a/include/qemu/hw-version.h
> +++ b/include/qemu/hw-version.h
> @@ -7,21 +7,6 @@
>  #ifndef QEMU_HW_VERSION_H
>  #define QEMU_HW_VERSION_H
>  
> -/*
> - * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
> - * instead of QEMU_VERSION, so setting hw_version on MachineClass
> - * is no longer mandatory.
> - *
> - * Do NOT change this string, or it will break compatibility on all
> - * machine classes that don't set hw_version.
> - */

I feel like we should be keeping a comment statement that
this must never be changed due to ABI compat.

>  #define QEMU_HW_VERSION "2.5+"

Also, is there any better place this can live now that this
header file has a single #define and nothing else ?

>  
> -/* QEMU "hardware version" setting. Used to replace code that exposed
> - * QEMU_VERSION to guests in the past and need to keep compatibility.
> - * Do not use qemu_hw_version() in new code.
> - */
> -void qemu_set_hw_version(const char *);
> -const char *qemu_hw_version(void);
> -
>  #endif
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index b45abf067b2..d6719dbf31d 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2660,7 +2660,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
>      if (dev->version) {
>          pstrcpy(s->version, sizeof(s->version), dev->version);
>      } else {
> -        pstrcpy(s->version, sizeof(s->version), qemu_hw_version());
> +        pstrcpy(s->version, sizeof(s->version), QEMU_HW_VERSION);
>      }
>  
>      ide_reset(s);
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index f62e420a91e..0276886d594 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -782,7 +782,7 @@ static int megasas_ctrl_get_info(MegasasState *s, MegasasCmd *cmd)
>  
>      memcpy(info.product_name, base_class->product_name, 24);
>      snprintf(info.serial_number, 32, "%s", s->hba_serial);
> -    snprintf(info.package_version, 0x60, "%s-QEMU", qemu_hw_version());
> +    snprintf(info.package_version, 0x60, "%s-QEMU", QEMU_HW_VERSION);
>      memcpy(info.image_component[0].name, "APP", 3);
>      snprintf(info.image_component[0].version, 10, "%s-QEMU",
>               base_class->product_version);
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 9b8656dd832..1a6b181b9d6 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -703,7 +703,7 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
>          r->buf[7] = 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* Sync, TCQ.  */
>          memcpy(&r->buf[8], "QEMU    ", 8);
>          memcpy(&r->buf[16], "QEMU TARGET     ", 16);
> -        pstrcpy((char *) &r->buf[32], 4, qemu_hw_version());
> +        pstrcpy((char *) &r->buf[32], 4, QEMU_HW_VERSION);
>      }
>      return true;
>  }
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index a5201855352..5ba5b46c4f4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2543,7 +2543,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>      }
>  
>      if (!s->version) {
> -        s->version = g_strdup(qemu_hw_version());
> +        s->version = g_strdup(QEMU_HW_VERSION);
>      }
>      if (!s->vendor) {
>          s->vendor = g_strdup("QEMU");
> diff --git a/system/vl.c b/system/vl.c
> index 38d7b849e0a..246623b3196 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2212,10 +2212,6 @@ static void qemu_create_machine(QDict *qdict)
>  
>      cpu_exec_init_all();
>  
> -    if (machine_class->hw_version) {
> -        qemu_set_hw_version(machine_class->hw_version);
> -    }
> -
>      /*
>       * Get the default machine options from the machine if it is not already
>       * specified either by the configuration file or by the command line.
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 954a7a99a9e..0b88868289b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -955,7 +955,7 @@ static void s390_qemu_cpu_model_class_init(ObjectClass *oc, const void *data)
>  
>      xcc->is_migration_safe = true;
>      xcc->desc = g_strdup_printf("QEMU Virtual CPU version %s",
> -                                qemu_hw_version());
> +                                QEMU_HW_VERSION);
>  }
>  
>  static void s390_max_cpu_model_class_init(ObjectClass *oc, const void *data)
> diff --git a/util/osdep.c b/util/osdep.c
> index 000e7daac8b..4a8b8b5a90f 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -31,8 +31,6 @@
>  #include "qemu/hw-version.h"
>  #include "monitor/monitor.h"
>  
> -static const char *hw_version = QEMU_HW_VERSION;
> -
>  int socket_set_cork(int fd, int v)
>  {
>  #if defined(SOL_TCP) && defined(TCP_CORK)
> @@ -533,16 +531,6 @@ ssize_t qemu_send_full(int s, const void *buf, size_t count)
>      return total;
>  }
>  
> -void qemu_set_hw_version(const char *version)
> -{
> -    hw_version = version;
> -}
> -
> -const char *qemu_hw_version(void)
> -{
> -    return hw_version;
> -}
> -
>  #ifdef _WIN32
>  static void socket_cleanup(void)
>  {
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


