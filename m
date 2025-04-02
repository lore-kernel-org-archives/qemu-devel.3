Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB08C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvgK-0003Ss-Ef; Wed, 02 Apr 2025 06:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzvgA-0003RM-Oq
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzvg8-0004Ne-Ew
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743591038;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Iw1XXBBNJGti8PUnLIHX2A3gXqMJYM5Coj1I5LRXsFw=;
 b=GgPNlz0J72DmfWRbLU3qbbUFl+ejcqJzhrH/3D/BjAMAc+ib2Ams0SroLAVrMS1by2GrGE
 bKMC3ZYCBMCfOtYobOqK3F8H9HwyfdyBlKLHps03a/Kqezw5xS6dw3PfKQUqkcgmpfIT42
 lDBFPLEC1Bl4duDLOCMGasqmDWJxH8Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-wygLxmHjNKyolOAzlS822Q-1; Wed,
 02 Apr 2025 06:50:35 -0400
X-MC-Unique: wygLxmHjNKyolOAzlS822Q-1
X-Mimecast-MFC-AGG-ID: wygLxmHjNKyolOAzlS822Q_1743591034
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B042919560BB; Wed,  2 Apr 2025 10:50:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C47991956094; Wed,  2 Apr 2025 10:50:29 +0000 (UTC)
Date: Wed, 2 Apr 2025 11:50:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 devel@lists.libvirt.org, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v8 55/55] docs: Add TDX documentation
Message-ID: <Z-0WclTZ-e-sTjzO@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-56-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-56-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CC libvirt / Jiri, for confirmation about whether the CPUID restrictions
listed below will have any possible impact on libvirt CPUID handling...

On Tue, Apr 01, 2025 at 09:02:05AM -0400, Xiaoyao Li wrote:
> Add docs/system/i386/tdx.rst for TDX support, and add tdx in
> confidential-guest-support.rst
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
>  - Add more information of "Feature configuration"
>  - Mark TD Attestation as future work because KVM now drops the support
>    of it.
> 
> Changes in v5:
>  - Add TD attestation section and update the QEMU parameter;
> 
> Changes since v1:
>  - Add prerequisite of private gmem;
>  - update example command to launch TD;
> 
> Changes since RFC v4:
>  - add the restriction that kernel-irqchip must be split
> ---
>  docs/system/confidential-guest-support.rst |   1 +
>  docs/system/i386/tdx.rst                   | 156 +++++++++++++++++++++
>  docs/system/target-i386.rst                |   1 +
>  3 files changed, 158 insertions(+)
>  create mode 100644 docs/system/i386/tdx.rst


> +Feature Configuration
> +---------------------
> +
> +Unlike non-TDX VM, the CPU features (enumerated by CPU or MSR) of a TD are not
> +under full control of VMM. VMM can only configure part of features of a TD on
> +``KVM_TDX_INIT_VM`` command of VM scope ``MEMORY_ENCRYPT_OP`` ioctl.
> +
> +The configurable features have three types:
> +
> +- Attributes:
> +  - PKS (bit 30) controls whether Supervisor Protection Keys is exposed to TD,
> +  which determines related CPUID bit and CR4 bit;
> +  - PERFMON (bit 63) controls whether PMU is exposed to TD.
> +
> +- XSAVE related features (XFAM):
> +  XFAM is a 64b mask, which has the same format as XCR0 or IA32_XSS MSR. It
> +  determines the set of extended features available for use by the guest TD.
> +
> +- CPUID features:
> +  Only some bits of some CPUID leaves are directly configurable by VMM.
> +
> +What features can be configured is reported via TDX capabilities.
> +
> +TDX capabilities
> +~~~~~~~~~~~~~~~~
> +
> +The VM scope ``MEMORY_ENCRYPT_OP`` ioctl provides command ``KVM_TDX_CAPABILITIES``
> +to get the TDX capabilities from KVM. It returns a data structure of
> +``struct kvm_tdx_capabilities``, which tells the supported configuration of
> +attributes, XFAM and CPUIDs.
> +
> +TD attributes
> +~~~~~~~~~~~~~
> +
> +QEMU supports configuring raw 64-bit TD attributes directly via "attributes"
> +property of "tdx-guest" object. Note, it's users' responsibility to provide a
> +valid value because some bits may not supported by current QEMU or KVM yet.
> +
> +QEMU also supports the configuration of individual attribute bits that are
> +supported by it, via properties of "tdx-guest" object.
> +E.g., "sept-ve-disable" (bit 28).
> +
> +MSR based features
> +~~~~~~~~~~~~~~~~~~
> +
> +Current KVM doesn't support MSR based feature (e.g., MSR_IA32_ARCH_CAPABILITIES)
> +configuration for TDX, and it's a future work to enable it in QEMU when KVM adds
> +support of it.
> +
> +Feature check
> +~~~~~~~~~~~~~
> +
> +QEMU checks if the final (CPU) features, determined by given cpu model and
> +explicit feature adjustment of "+featureA/-featureB", can be supported or not.
> +It can produce feature not supported warning like
> +
> +  "warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]"
> +
> +It can also produce warning like
> +
> +  "warning: TDX forcibly sets the feature: CPUID.80000007H:EDX.invtsc [bit 8]"
> +
> +if the fixed-1 feature is requested to be disabled explicitly. This is newly
> +added to QEMU for TDX because TDX has fixed-1 features that are forcibly enabled
> +by TDX module and VMM cannot disable them.

This is where I'm wondering if libvirt has anything to be concerned
about. Possibly when libvirt queries the actual CPUID after launching
the guest it will just "do the right thing" ? Wondering if there's any
need for libvirt to be aware of CPUID restrictions before that point
though ?


> +
> +Launching a TD (TDX VM)
> +-----------------------
> +
> +To launch a TD, the necessary command line options are tdx-guest object and
> +split kernel-irqchip, as below:
> +
> +.. parsed-literal::
> +
> +    |qemu_system_x86| \\
> +        -object tdx-guest,id=tdx0 \\
> +        -machine ...,kernel-irqchip=split,confidential-guest-support=tdx0 \\
> +        -bios OVMF.fd \\

I don't think we need to show 'kernel-irqchip=split' now that we "do the
right thing" by default


This surely also ought to include '-accel kvm', as IIUC there's no
TCG support for TDX.

And presumably '-cpu host', since QEMU's default 'qemu64' CPU model
is likely a terrible match for what TDX will force set.

> +
> +Restrictions
> +------------
> +
> + - kernel-irqchip must be split;

Can append

   "This is set by default for TDX guests if kernel-irqchip is left on
    its default 'auto' setting."

> +
> + - No readonly support for private memory;
> +
> + - No SMM support: SMM support requires manipulating the guest register states
> +   which is not allowed;
> +


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


