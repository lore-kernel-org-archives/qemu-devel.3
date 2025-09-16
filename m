Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB62CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQoK-0001tW-3G; Tue, 16 Sep 2025 04:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQoI-0001tA-Fx
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQoE-0003eM-6l
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758010382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0QsD5tpPo2p7tpbaEPg/LzZZv/yOvDJ/y5vGEFrWNBE=;
 b=F05N+rA3avo0H30fohk1GP1v76n9q64A2FQIRrAcCv+coLh/ARem4GJFjgXUldH22YTc/k
 A8/TFnvQToFxBgFrYaECBzwoWc3M93xVkyN1J7NSqndOuvi+v+uKJls9dxv7l0D8TajrUC
 YoAGjEtGU78OyFyy2cHXMAsFlI95Wog=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-8jbBcsgvOA2RT5zPQvhFbA-1; Tue,
 16 Sep 2025 04:12:59 -0400
X-MC-Unique: 8jbBcsgvOA2RT5zPQvhFbA-1
X-Mimecast-MFC-AGG-ID: 8jbBcsgvOA2RT5zPQvhFbA_1758010378
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1644819560B0; Tue, 16 Sep 2025 08:12:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CAE21800447; Tue, 16 Sep 2025 08:12:54 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:12:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hector Cao <hector.cao@canonical.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] target/i386: add compatibility property for
 arch_capabilities
Message-ID: <aMkb60m0cbFJvv-b@redhat.com>
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
 <20250910115733.21149-2-hector.cao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910115733.21149-2-hector.cao@canonical.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CC Paolo as maintainer

On Wed, Sep 10, 2025 at 01:57:32PM +0200, Hector Cao wrote:
> Prior to v10.1, if requested by user, arch-capabilities is always on
> despite the fact that CPUID advertises it to be off/unvailable.
> this causes a migration issue for VMs that are run on a machine
> without arch-capabilities and expect this feature to be present
> on the destination host with QEMU 10.1.
> 
> This commit add a compatibility property to restore the legacy
> behavior for all machines with version prior to 10.1
>

Can you add a 'Fixes: <hash>' line to refer to the orignial
commit in 10.1 that introduced the regression.

> Signed-off-by: Hector Cao <hector.cao@canonical.com>
> ---
>  hw/core/machine.c     |  1 +
>  migration/migration.h | 12 ++++++++++++
>  migration/options.c   |  3 +++
>  target/i386/kvm/kvm.c |  5 ++++-
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 38c949c4f2..8ad5d79cb3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -45,6 +45,7 @@ GlobalProperty hw_compat_10_0[] = {
>      { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>      { "ramfb", "use-legacy-x86-rom", "true"},
>      { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> +    { "migration", "arch-cap-always-on", "true" },
>  };
>  const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index 01329bf824..5124ff3636 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -510,6 +510,18 @@ struct MigrationState {
>      bool rdma_migration;
>  
>      GSource *hup_source;
> +
> +    /*
> +     * This variable allows to keep the backward compatibility with QEMU (<10.1)
> +     * on the arch-capabilities detection.
> +     * With the commit d3a2413 (since 10.1), the arch-capabilities feature is gated
> +     * with the CPUID bit (CPUID_7_0_EDX_ARCH_CAPABILITIES) instead of being always
> +     * enabled when user requests for it. this new behavior breaks migration of VMs
> +     * created and run with older QEMU on machines without IA32_ARCH_CAPABILITIES MSR,
> +     * those VMs might have arch-capabilities enabled and break when migrating
> +     * to a host with QEMU 10.1 with error : missing feature arch-capabilities
> +     */
> +    bool arch_cap_always_on;
>  };
>  
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> diff --git a/migration/options.c b/migration/options.c
> index 4e923a2e07..3a80dba9c5 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -203,6 +203,9 @@ const Property migration_properties[] = {
>                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
>      DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
> +
> +    DEFINE_PROP_BOOL("arch-cap-always-on", MigrationState,
> +                     arch_cap_always_on, false),
>  };
>  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
>  
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 306430a052..e2ec4e6de5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -42,6 +42,7 @@
>  #include "xen-emu.h"
>  #include "hyperv.h"
>  #include "hyperv-proto.h"
> +#include "migration/migration.h"
>  
>  #include "gdbstub/enums.h"
>  #include "qemu/host-utils.h"
> @@ -438,6 +439,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>      uint32_t ret = 0;
>      uint32_t cpuid_1_edx, unused;
>      uint64_t bitmask;
> +    MigrationState *ms = migrate_get_current();
>  
>      cpuid = get_supported_cpuid(s);
>  
> @@ -508,7 +510,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>           * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
>           * KVM sets up.
>           */
> -        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
> +        if (!has_msr_arch_capabs
> +            || (!(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES) && (!ms->arch_cap_always_on))) {
>              ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
>          }
>      } else if (function == 7 && index == 1 && reg == R_EAX) {
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


