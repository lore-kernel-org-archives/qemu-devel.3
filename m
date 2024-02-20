Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5AEC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSOo-0005el-Im; Tue, 20 Feb 2024 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcSOk-0005d0-NL
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcSOg-0002uu-Iv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708444265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf1K9wpq7CrpSQKonZJe1RFbE+Eyk2pVnvy64jXhzdQ=;
 b=DV+mr10YkEQ4Dt+6aLx2BU2flLtI0MW9P51xn3JRFUrdVwREtN/YNonLe6yMtJJAzldEyI
 WD3OptadG+ojRT1DoO6LkxdMUwdCqhbZ2EwBlpuhgmkBGEUWaISiwXHm1af3Iw/tcIXxMH
 ztaljskSsyKM+wexeiG4+I824umwrpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-47JbfY7JOTajejEIFoCxVw-1; Tue, 20 Feb 2024 10:51:02 -0500
X-MC-Unique: 47JbfY7JOTajejEIFoCxVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75D8185A781;
 Tue, 20 Feb 2024 15:51:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6AF1400D783;
 Tue, 20 Feb 2024 15:50:59 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:50:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <ZdTKYV5AuhYxvi1Q@redhat.com>
References: <20240220154204.29676-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220154204.29676-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 20, 2024 at 09:12:04PM +0530, Ani Sinha wrote:
> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> enabled in the kernel. At present, QEMU has been tested to correctly boot a
> linux guest with 4096 vcpus both with edk2 and seabios firmwares.
> So bump up the value max_cpus to 4096 for q35 machines versions 9 and newer.
> Q35 machines versions 8.2 and older continue to support 1024 maximum vcpus
> as before for compatibility reasons.
> 
> If KVM is not able to support the specified number of vcpus, QEMU would
> return the following error messages:
> 
> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> Number of SMP cpus requested (1728) exceeds the maximum cpus supported by KVM (1024)
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Cc: kraxel@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc_q35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Changelog:
> v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
> See RH Jira: https://issues.redhat.com/browse/RHEL-22202

That bug indicates a dependancy on a EDK2 patch

  https://github.com/kraxel/edk2/commit/7a03c17f0f4f4a9003d77db2660c8e087604b2f0

we'll need to rebase the EDK2 ROMs in QEMU to get that included.

Meanwhile, plesae at least call out this EDK2 commit as a
pre-requisite in the commit message, so people know the
EDK2 ROMs in QEMU won't work (yet).

> 
> v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
> the commit description.
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d..ae60e6b919 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -366,7 +366,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_nic = "e1000e";
>      m->default_kernel_irqchip_split = false;
>      m->no_floppy = 1;
> -    m->max_cpus = 1024;
> +    m->max_cpus = 4096;
>      m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> @@ -387,6 +387,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
>  {
>      pc_q35_9_0_machine_options(m);
>      m->alias = NULL;
> +    m->max_cpus = 1024;
>      compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
>      compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
>  }

Assuming tweaked commit message

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


