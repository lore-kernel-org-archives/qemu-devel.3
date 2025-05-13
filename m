Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC1FC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 16:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEsQ1-0007pM-1D; Tue, 13 May 2025 12:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEsPx-0007ou-2T
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEsPu-0003x0-Rk
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747153421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8/O3L74GuKzo/TjHS1Hrvth01wGf5AOef3YEOHWTqhA=;
 b=QIgvwijNwP2KM4P0Q/9v7Kv1TNwDLG9Bsj+ISinwNH6J2+B+BG8Xd0OkJSDJEXvOSrEULZ
 pCmdq/xLJBR1O9q2HyiT7sF25NvR9vZ8vuRCxDpXT6cTHxmvC3Mk2qxpu3DEJvrEtz5iMX
 mSm43dc2uiSaHyqbd82243hNUV6jZLI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-cYDl4VDJPni-SiULaYn4YA-1; Tue,
 13 May 2025 12:23:38 -0400
X-MC-Unique: cYDl4VDJPni-SiULaYn4YA-1
X-Mimecast-MFC-AGG-ID: cYDl4VDJPni-SiULaYn4YA_1747153416
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B08D31800875; Tue, 13 May 2025 16:23:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 614281945CB4; Tue, 13 May 2025 16:23:30 +0000 (UTC)
Date: Tue, 13 May 2025 17:23:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 10/10] arm/cpu-features: document ID reg properties
Message-ID: <aCNx_1EyWmRoZU-_@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-11-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414163849.321857-11-cohuck@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 14, 2025 at 06:38:49PM +0200, Cornelia Huck wrote:
> Add some documentation for how individual ID registers can be
> configured with the host cpu model.
> 
> [CH: adapt to removal of the 'custom' model, added some more
>  explanations about using the ID register props]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst | 104 ++++++++++++++++++++++++++++---
>  1 file changed, 96 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 37d5dfd15b34..22faefd76edd 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -2,7 +2,10 @@ Arm CPU Features
>  ================
>  
>  CPU features are optional features that a CPU of supporting type may
> -choose to implement or not.  In QEMU, optional CPU features have
> +choose to implement or not.  QEMU provides two different mechanisms
> +to configure those features:
> +
> +1. For most CPU models, optional CPU features may have
>  corresponding boolean CPU proprieties that, when enabled, indicate
>  that the feature is implemented, and, conversely, when disabled,
>  indicate that it is not implemented. An example of an Arm CPU feature
> @@ -29,6 +32,16 @@ supports the feature.  While ``aarch64`` currently only works with KVM,
>  it could work with TCG.  CPU features that are specific to KVM are
>  prefixed with "kvm-" and are described in "KVM VCPU Features".
>  
> +2. Additionally, the ``host`` CPU model on KVM allows to configure optional
> +CPU features via the corresponding ID registers. The host kernel allows
> +to write a subset of ID register fields. The host model exposes
> +properties for each writable ID register field. Those options are named
> +SYSREG_<IDREG>_<FIELD>. IDREG and FIELD names are those used in the
> +ARM ARM Reference Manual. They can also be found in the Linux
> +arch/arm64/tool/sysreg file which is used to automatically generate the
> +description for those registers and fields. This currently only has been
> +implemented for KVM.

Whereever they are referencing 'host', the docs should also
mention 'max' CPU which should be a drop-in functional
equivalent.

> +
>  CPU Feature Probing
>  ===================
>  
> @@ -124,13 +137,20 @@ A note about CPU models and KVM
>  
>  Named CPU models generally do not work with KVM.  There are a few cases
>  that do work, e.g. using the named CPU model ``cortex-a57`` with KVM on a
> -seattle host, but mostly if KVM is enabled the ``host`` CPU type must be
> -used.  This means the guest is provided all the same CPU features as the
> -host CPU type has.  And, for this reason, the ``host`` CPU type should
> -enable all CPU features that the host has by default.  Indeed it's even
> -a bit strange to allow disabling CPU features that the host has when using
> -the ``host`` CPU type, but in the absence of CPU models it's the best we can
> -do if we want to launch guests without all the host's CPU features enabled.
> +seattle host, but mostly if KVM is enabled, the ``host`` CPU model must be
> +used.
> +
> +Using the ``host`` type means the guest is provided all the same CPU
> +features as the host CPU type has.  And, for this reason, the ``host``
> +CPU type should enable all CPU features that the host has by default.
> +
> +In case some features need to be hidden to the guest, and the host kernel
> +supports it, the ``host`` model can be instructed to disable individual
> +ID register values. This is especially useful for migration purposes.
> +However, this interface will not allow configuring an arbitrary set of
> +features; the ID registers must describe a subset of the host's features,
> +and all differences to the host's configuration must actually be supported
> +by the kernel to be deconfigured.
>  
>  Enabling KVM also affects the ``query-cpu-model-expansion`` QMP command.  The
>  affect is not only limited to specific features, as pointed out in example
> @@ -167,6 +187,13 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
>  properties have special semantics (see "SVE CPU Property Parsing
>  Semantics").
>  
> +Additionally, if supported by KVM on the host kernel, the ``host`` CPU model
> +may be configured via individual ID register field properties, for example::
> +
> +  $ qemu-system-aarch64 -M virt -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> +
> +This forces ID_AA64ISAR0_EL1 DP field to 0.
> +
>  KVM VCPU Features
>  =================
>  
> @@ -466,3 +493,64 @@ Legal values for ``S`` are 30, 34, 36, and 39; the default is 30.
>  
>  As with ``x-rme``, the ``x-l0gptsz`` property may be renamed or
>  removed in some future QEMU release.
> +
> +Configuring CPU features via ID register fields
> +===============================================
> +
> +Note that this is currently only supported under KVM, and with the
> +``host`` CPU model.
> +
> +Querying available ID register fields
> +-------------------------------------
> +
> +QEMU will create properties for all ID register fields that are
> +reported as being writable by the kernel, and that are known to the
> +QEMU instance. Therefore, the same QEMU binary may expose different
> +properties when run under a different kernel.
> +
> +To find out all available writable ID register fields, use the
> +``query-cpu-model-expansion`` QMP command::
> +
> +  (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
> +  {"return": {
> +   "model": {"name": "host", "props": {
> +   "SYSREG_ID_AA64PFR0_EL1_EL3": 1, "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0,
> +   "SYSREG_CTR_EL0_L1Ip": 3, "SYSREG_CTR_EL0_DminLine": 4,
> +   "SYSREG_ID_AA64MMFR0_EL1_BIGEND": 1, "SYSREG_ID_AA64MMFR1_EL1_ECBHB": 0,
> +   "SYSREG_ID_AA64MMFR2_EL1_CnP": 1, "SYSREG_ID_DFR0_EL1_PerfMon": 4,
> +   "SYSREG_ID_AA64PFR0_EL1_DIT": 0, "SYSREG_ID_AA64MMFR1_EL1_HAFDBS": 2,
> +   "SYSREG_ID_AA64ISAR0_EL1_FHM": 0, "SYSREG_ID_AA64ISAR2_EL1_CSSC": 0,
> +   "SYSREG_ID_AA64ISAR0_EL1_DP": 1, (...)
> +   }}}}
> +
> +If a certain field in an ID register does not show up in this list, it
> +is not writable with the specific host kernel.

On x86,   "-cpu help" will list all feature names too. It makes the
output pretty huge, so not sure if we want to mirror that on arm ?
It is at least more useful to humans though, compared to QMP.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


