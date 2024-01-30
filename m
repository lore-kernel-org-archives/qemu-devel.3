Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08029C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 16:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrHL-0000q9-0F; Tue, 30 Jan 2024 11:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUrHH-0000pu-7Z
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUrHF-0007cU-Io
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706633280;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFdsOWSPeNtrox5lEStOmOkO2Q9e6A/LC5tsnlQJZfg=;
 b=RRKd1NzNORLDQ0thpsbH84/il+KsrP71qW4GS9ZPzgZYRXKVQlcs8vCGHy0mGIC4aPGWiz
 0KsfgX4hlQNZ9nAeUG9OFdiqjKm5pMaL+jzp+/UOv46vrkvcsmdU8tGr2GpL4gmKTx7K4Z
 fuJviEr49YOEMyfkTuoZGIzGj1LPawM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ebgMphT2OsmT2Ho48_nxJw-1; Tue, 30 Jan 2024 11:47:56 -0500
X-MC-Unique: ebgMphT2OsmT2Ho48_nxJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30A16800074;
 Tue, 30 Jan 2024 16:47:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3E4B492BE4;
 Tue, 30 Jan 2024 16:47:54 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:47:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 1728 vcpus
Message-ID: <ZbkoOAPo7gmFZw4g@redhat.com>
References: <20240130164428.35955-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130164428.35955-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 30, 2024 at 10:14:28PM +0530, Ani Sinha wrote:
> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> enabled in the kernel. QEMU has been tested to correctly boot a linux guest
> with 1728 vcpus both with edk2 and seabios firmwares. So bump up the max_cpus
> value for q35 machines versions 9 and newer to 1728. Q35 machines versions
> 8.2 and older continue to support 1024 maximum vcpus as before for
> compatibility.

Where does the 1728 number come from ?

Did something break at 1729, or did the test machine simply not
have sufficient resources to do practical larger tests ?

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
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc_q35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index f43d5142b8..bfa627a70b 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_nic = "e1000e";
>      m->default_kernel_irqchip_split = false;
>      m->no_floppy = 1;
> -    m->max_cpus = 1024;
> +    m->max_cpus = 1728;
>      m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> @@ -396,6 +396,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
>  {
>      pc_q35_9_0_machine_options(m);
>      m->alias = NULL;
> +    m->max_cpus = 1024;
>      compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
>      compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
>  }
> -- 
> 2.42.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


