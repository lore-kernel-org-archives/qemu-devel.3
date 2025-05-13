Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A702AC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErFp-0000Qt-Nj; Tue, 13 May 2025 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErFn-0000Qc-3n
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErFl-0003lW-6p
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747148947;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsf45tDGJpQUW9ECsgv4qDKfMcOicJK49979YGwTnvk=;
 b=Yrvm6Z+ObhwB3gsARIaS/v7TZrbLvUxO/ZiI/G9MkXmfE13TXvTU1ToK3ZIBUhkllA7xNu
 5wgp/Jmzpqeq3J8bN0cSICdp2gnJNhbaPdXGoQq4KRTxlL0Xz5X+9Fs6KC8k8b+hTKxPsD
 x0xuvTLJkgrbMnZ+fA5f2jI/nMkdb+Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-sX-OK7lHPsuAqrr11qvsZg-1; Tue, 13 May 2025 11:09:06 -0400
X-MC-Unique: sX-OK7lHPsuAqrr11qvsZg-1
X-Mimecast-MFC-AGG-ID: sX-OK7lHPsuAqrr11qvsZg_1747148945
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442ccf0eb4eso42536385e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 08:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747148945; x=1747753745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tsf45tDGJpQUW9ECsgv4qDKfMcOicJK49979YGwTnvk=;
 b=Itd1WEI76G0TZbr8SI2IX3iclgkHwSM4y0WGdiYAH/O6tfnhZlKB9bUZZA6bl4+5vg
 LrjIllMJDwA26PEpv2lu7LoxUD26eg8NM40+UijxmQWT4eMklYROkGi7OM+slgcAd88s
 bcFH91zDKLQev3O/Tjz63oD+C0Ui6Whz8tpQVIgmc6fPvk7p/H3qWP0mNcdIF+5G33V5
 lMszJb6T9rzJ3uVnbHKC2lXTVogccxZCxl9+eRSRK237R0WyjRsjiCD7SdXF1gBsEmzu
 00YE8bl+C5OLlteAjDZM8YncikzBKP9gmFzyaX350xTMR27I+2NuiCMWqwRh4vLFbgJA
 /9lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFEscLz83btxq6m3xiVEH9vx4heQDxC9Hqevc3iiVNT4fHExd7/jCAmLiJvvIjzkd+gS9Zy2ndQbqN@nongnu.org
X-Gm-Message-State: AOJu0YxVdSc61Ytq/Kf5nnOrmud+YPuruM11Y293riAcYRTF3yqHQKxT
 EQVRcy1Lv7iqby4I4Hr+mNDanT7cVRzEH0yiwYe6gxbkVDmSLOdGzZSbveYg19rp7jQ8HabrIry
 dQZsfgOkOpz6atmalmRkg4OJpGWfZ43tM/VTwlAW8HRss69KDRMnK
X-Gm-Gg: ASbGncuAjYQ12rtCAuyNMOiref/kEo+DKLaqix8FsiVMAL1ob1IaowT1UvV3qXfXugr
 cmc2+JiYnu8zuU16twYy5LCjA/kkUerd43eqPMcZ1kY74RFdedxnERwsOQrZCN6ovoF3sjinYev
 vwKZ7K0MF92wU4H+JQVmIqUO76z4yVaujuBRlxxwZG5spF6fnYjEckr7cMBQsq5WN9nacAeNq8h
 14F5hR7FbK3ro46XSHzXE32T2y5XuaOTPaor8pq05aBU1eIW73nqDVLbjvECdPrLeIpVwXzyQ7k
 /G1B5wHl9cTGkrtdvvQ0o5ph5kuf9+EL5HJyZf806RzoqhqL9CiQGNQ8FNU=
X-Received: by 2002:a05:600c:384a:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-442d6dd24a4mr147700035e9.22.1747148944933; 
 Tue, 13 May 2025 08:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpRtJWlGyhg+ZesNw4pZ1+fqHD/MY1cSehn8K8lk/qRmYG1nUKTsLP1T0Aem2/15rVxgGAHg==
X-Received: by 2002:a05:600c:384a:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-442d6dd24a4mr147699335e9.22.1747148944357; 
 Tue, 13 May 2025 08:09:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687ad31sm170026065e9.34.2025.05.13.08.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 08:09:03 -0700 (PDT)
Message-ID: <131502e7-d487-48f6-84de-02a296116fb4@redhat.com>
Date: Tue, 13 May 2025 17:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm/cpu-features: document ID reg properties
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-11-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-11-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,
On 4/14/25 6:38 PM, Cornelia Huck wrote:
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
> +
> +A note on compatibility
> +-----------------------
> +
> +A common use case for providing a defined set of ID register values is
> +to be able to present a fixed set of features to a guest, often referred
> +to as "stable guest ABI". This may take the form of ironing out differences
> +between two similar CPUs with the intention of being able to migrate
> +between machines with those CPUs, or providing the same CPU across Linux
> +kernel updates on the host.
> +
> +Over the course of time, the Linux kernel is changing the set of ID register
> +fields that are writable by userspace. Newly introduced writable ID
> +registers should be initialized to 0 to ensure compatibility. However, ID
why 0? shouldn't they just be ommitted from the explicit command line?
> +registers that have already been introduced that undergo a change as to
> +which fields are writable may introduce incompatibities that need to be
Aren't incompatibilities due to changed default values only. The fact a
new writable field gets exposed does not change the default value in
general. If it was not exposed before, the end user couldn't change its
value, no?

Thanks

Eric
> +addressed on a case-by-case basis for the systems that you wish to migrate
> +inbetween.
> +
> +A note on Arm CPU features (FEAT_xxx)
> +-------------------------------------
> +
> +Configuring CPUs is done on a feature level on other architectures, and this
> +would imply configuring FEAT_xxx values on Arm. However, differences between
> +CPUs may not map to FEAT_xxx, but to differences in other registers in the
> +ID register range; for example, differences in the cache architecture exposed
> +via ``CTR_EL0``. We therefore cannot rely on configuration via FEAT_xxx. A
> +feature-based interface more similar to other architectures may be implemented
> +on top of the ID register interface in the future.


