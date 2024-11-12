Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E350D32D8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAnxn-0000hm-3q; Tue, 12 Nov 2024 05:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tAnxl-0000TD-4h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:17:33 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tAnxi-0000Ar-JN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:17:32 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cf04f75e1aso6626770a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731406649; x=1732011449; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3LE/uQCFRzD9AYK90x3fGGWlE6ZUcSfNuzikrT/rsEM=;
 b=fr22+IxmrxoOaqIyDdcRT8TvORKO8BPdM7FoM0Dl9Jz90nVaEoIOxpKdhmgoQnwipo
 mIJCGvyLUeFI8dqryXomVv45AZp2sX/8xEGnx1G1iz9NcvzHb5wyNfMt/2Sb7NywRr2B
 84GpNFmuTN8q7ZtbjU0NRTJUxim+bcaeAaLa5EZmIe3GEsrEuHGjxlT48cjT/jx8rmtY
 nahaP3D7tWDsp7a9UWP2bF85a5nR+iekLnUiKsdXWcbIrO3IjUZYCu0s6SJJwRvAE2T4
 H2Xak5bpRGu3LppYDNBseSZK3d3YuvQFlhh7pxkgZCDCW5IEuc/v7D6EoAxy43CGyqWn
 jmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731406649; x=1732011449;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3LE/uQCFRzD9AYK90x3fGGWlE6ZUcSfNuzikrT/rsEM=;
 b=XozywvfLvGwLqdDCWHlXQYH8+GfKrpNeQJrhNyC1pyXubnR99DANR2mTAS/ujLlvZZ
 XJA5GRgUZuw1oZ9/xcmkfTH0IMt2keGDZPW2iGRZGixGPibCzCGiVex8i/xZvJK6rnvS
 aI9leFXbZ4V4v6fmDANRdoowvmYMBdy+bKuiIDEgcF83aHizW6bxVkn5H9bgm1NjQdjy
 iphIE1nyDICn+LtxOH9euUJ3Zoxm4nbptYIOFUYMMJwk3BDGwpT6Edd3kH6MkxUMDnTG
 TEaZ8oOdozEsbEDZE6P0iPpokIVJ+zhDHGLHPjWiHolcPCRP2seY7zerI4S0u4RUDufz
 MMSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk9QCGrtrld+57jQ8kv08A/hRgBiLMK17pTf8ScNa2rM7fZkRCWSu5rX2qqUXcZplIG2VYcKKBHy8D@nongnu.org
X-Gm-Message-State: AOJu0YyydXLk1ff16xBN8NFqGXodL4X84o9emf5XcF+Gbjpd4JpnO1Zg
 5NMbz63O0gBHHuEWR1vcErJjpH82t9D3VwYwRwpC8EMimQpZ+iX0
X-Google-Smtp-Source: AGHT+IEb5ELpA9GlL2palg2Q4wuZ8cY7EssS8HMyUxKWbS47/oLRn+cYjuGANhR2YPA5JkbkzzkiPg==
X-Received: by 2002:a05:6402:2067:b0:5cd:5499:8dbb with SMTP id
 4fb4d7f45d1cf-5cf0a32388cmr9660204a12.20.1731406648264; 
 Tue, 12 Nov 2024 02:17:28 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:fb75:3035:4c0:20e9?
 ([2001:b07:5d29:f42d:fb75:3035:4c0:20e9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d76esm5735357a12.9.2024.11.12.02.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 02:17:27 -0800 (PST)
Message-ID: <17f00e24648b3f4f2ad5b941d848ca1d1fc075ae.camel@gmail.com>
Subject: Re: [PATCH v6 60/60] docs: Add TDX documentation
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Richard Henderson
 <richard.henderson@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan
 Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>,  rick.p.edgecombe@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Date: Tue, 12 Nov 2024 11:17:25 +0100
In-Reply-To: <20241105062408.3533704-61-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-61-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-11-05 at 01:24 -0500, Xiaoyao Li wrote:

> diff --git a/docs/system/confidential-guest-support.rst
> b/docs/system/confidential-guest-support.rst
> index 0c490dbda2b7..66129fbab64c 100644
> --- a/docs/system/confidential-guest-support.rst
> +++ b/docs/system/confidential-guest-support.rst
> @@ -38,6 +38,7 @@ Supported mechanisms
> =C2=A0Currently supported confidential guest mechanisms are:
> =C2=A0
> =C2=A0* AMD Secure Encrypted Virtualization (SEV) (see :doc:`i386/amd-
> memory-encryption`)
> +* Intel Trust Domain Extension (TDX) (see :doc:`i386/tdx`)
> =C2=A0* POWER Protected Execution Facility (PEF) (see :ref:`power-papr-
> protected-execution-facility-pef`)
> =C2=A0* s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> =C2=A0
> diff --git a/docs/system/i386/tdx.rst b/docs/system/i386/tdx.rst
> new file mode 100644
> index 000000000000..60106b29bf72
> --- /dev/null
> +++ b/docs/system/i386/tdx.rst
> @@ -0,0 +1,155 @@
> +Intel Trusted Domain eXtension (TDX)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Intel Trusted Domain eXtensions (TDX) refers to an Intel technology
> that extends
> +Virtual Machine Extensions (VMX) and Multi-Key Total Memory
> Encryption (MKTME)
> +with a new kind of virtual machine guest called a Trust Domain (TD).
> A TD runs
> +in a CPU mode that is designed to protect the confidentiality of its
> memory
> +contents and its CPU state from any other software, including the
> hosting
> +Virtual Machine Monitor (VMM), unless explicitly shared by the TD
> itself.
> +
> +Prerequisites
> +-------------
> +
> +To run TD, the physical machine needs to have TDX module loaded and
> initialized
> +while KVM hypervisor has TDX support and has TDX enabled. If those
> requirements
> +are met, the ``KVM_CAP_VM_TYPES`` will report the support of
> ``KVM_X86_TDX_VM``.
> +
> +Trust Domain Virtual Firmware (TDVF)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Trust Domain Virtual Firmware (TDVF) is required to provide TD
> services to boot
> +TD Guest OS. TDVF needs to be copied to guest private memory and
> measured before
> +the TD boots.
> +
> +KVM vcpu ioctl ``KVM_TDX_INIT_MEM_REGION`` can be used to populates

s/populates/populate

> the TDVF
> +content into its private memory.
> +
> +Since TDX doesn't support readonly memslot, TDVF cannot be mapped as
> pflash
> +device and it actually works as RAM. "-bios" option is chosen to
> load TDVF.
> +
> +OVMF is the opensource firmware that implements the TDVF support.
> Thus the
> +command line to specify and load TDVF is ``-bios OVMF.fd``
> +
> +Feature Configuration
> +---------------------
> +
> +Unlike non-TDX VM, the CPU features (enumerated by CPU or MSR) of a
> TD is not

s/is/are

> +under full control of VMM. VMM can only configure part of features
> of a TD on
> +``KVM_TDX_INIT_VM`` command of VM scope ``MEMORY_ENCRYPT_OP`` ioctl.
> +
> +The configurable features have three types:
> +
> +- Attributes:
> +=C2=A0 - PKS (bit 30) controls whether Supervisor Protection Keys is
> exposed to TD,
> +=C2=A0 which determines related CPUID bit and CR4 bit;
> +=C2=A0 - PERFMON (bit 63) controls whether PMU is exposed to TD.
> +
> +- XSAVE related features (XFAM):
> +=C2=A0 XFAM is a 64b mask, which has the same format as XCR0 or IA32_XSS
> MSR. It
> +=C2=A0 determines the set of extended features available for use by the
> guest TD.
> +
> +- CPUID features:
> +=C2=A0 Only some bits of some CPUID leaves are directly configurable by
> VMM.
> +
> +What features can be configured is reported via TDX capabilities.
> +
> +TDX capabilities
> +~~~~~~~~~~~~~~~~
> +
> +The VM scope ``MEMORY_ENCRYPT_OP`` ioctl provides command
> ``KVM_TDX_CAPABILITIES``
> +to get the TDX capabilities from KVM. It returns a data structure of
> +``struct kvm_tdx_capabilities``, which tells the supported
> configuration of
> +attributes, XFAM and CPUIDs.
> +
> +TD attributes
> +~~~~~~~~~~~~~
> +
> +QEMU supports configuring raw 64-bit TD attributes directly via
> "attributes"
> +property of "tdx-guest" object. Note, it's users' responsibility to
> provide a
> +valid value because some bits may not supported by current QEMU or
> KVM yet.
> +
> +QEMU also supports the configuration of individual attribute bits
> that are
> +supported by it, via propertyies of "tdx-guest" object.

s/propertyies/properties

> +E.g., "sept-ve-disable" (bit 63).
> +
> +MSR based features
> +~~~~~~~~~~~~~~~~
> +
> +Current KVM doesn't support MSR based feature (e.g.,
> MSR_IA32_ARCH_CAPABILITIES)
> +configuration for TDX, and it's a future work to enable it in QEMU
> when KVM adds
> +support of it.
> +
> +Feature check
> +~~~~~~~~~~~~~
> +
> +QEMU checks if the final (CPU) features, determined by given cpu
> model and
> +explicit feature adjustment of "+featureA/-featureB", can be
> supported or not.
> +It can produce feature not supported warnning like
> +
> +=C2=A0 "warning: host doesn't support requested feature:
> CPUID.07H:EBX.intel-pt [bit 25]"
> +
> +It will also procude warning like

s/procude/produce

> +
> +=C2=A0 "warning: TDX forcibly sets the feature:
> CPUID.80000007H:EDX.invtsc [bit 8]"
> +
> +if the fixed-1 feature is requested to be disabled explicitly. This
> is newly
> +added to QEMU for TDX because TDX has fixed-1 features that are
> enfored enabled

s/enfored/enforced

> +by TDX module and VMM cannot disable them.
> +
> +Launching a TD (TDX VM)
> +-----------------------
> +
> +To launch a TDX guest, below are new added and required:

This sentence is missing a subject (such as "command line options").

> +
> +.. parsed-literal::
> +
> +=C2=A0=C2=A0=C2=A0 |qemu_system_x86| \\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -object tdx-guest,id=3Dtdx0 \=
\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -machine ...,kernel-irqchip=
=3Dsplit,confidential-guest-
> support=3Dtdx0 \\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -bios OVMF.fd \\
> +
> +restrictions
> +------------
> +
> + - kernel-irqchip must be split;
> +
> + - No readonly support for private memory;
> +
> + - No SMM support: SMM support requires manipulating the guset

s/guset/guest

> register states
> +=C2=A0=C2=A0 which is not allowed;
> +
> +Debugging
> +---------
> +
> +Bit 0 of TD attributes, is DEBUG bit, which decides if the TD runs
> in off-TD
> +debug mode. When in off-TD debug mode, TD's VCPU state and private
> memory are
> +accessible via given SEAMCALLs. This requires KVM to expose APIs to
> invoke those
> +SEAMCALLs and resonponding QEMU change.

s/resonponding/corresponding


