Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295CDC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0J5-0001e7-KY; Fri, 31 May 2024 07:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0J3-0001dp-3Y
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0J0-0003Ii-7z
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717154417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S+C2lwFRABkA7b/yNrzv8UAxWC5/SnV83op21vezLg=;
 b=TDnp1w+cjav2Ju7ZtlTpsDvIZBd8un/FNklWPwi97gO1MMV9Y13aWKcRSf8utxIQo6TFtX
 XWNLp/8zk15J9A1j6dq1tQ9lda3rK94SFw8eeMY4tsh9d4ZNEjYqGT5RIr3/Xc2DtLtiOp
 3M0kcun46ZasP71mEP4roe3nEFcvBqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-roslZAS4M-OLMMZujHUQAA-1; Fri, 31 May 2024 07:20:15 -0400
X-MC-Unique: roslZAS4M-OLMMZujHUQAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so1158569f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717154414; x=1717759214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S+C2lwFRABkA7b/yNrzv8UAxWC5/SnV83op21vezLg=;
 b=uH5GL/1b9vywFafWT6zjdReUAFzCdarJCPMKtmZEM8WbjSR1Ed+ODtDL5Xn46DQRx5
 qFA8zsb+bTcmzuDEmTGashJYMcNdJFRMzY6kgCGriN+mAOlO1r1FecaZeL8RhWFWwANu
 AKmg/OoTzN8fPKBO9aTqJr7qXdpvyWwnC14LAA5zIyW8IxCjLjr91jsurYv72u4C3h9Z
 pQ2vIGrH5D/k5xMOWPSGDPrnnYfg2xZUsCPt+mP5giyB+PxGiFXrtECyc1F41ILvY2Km
 ybEEv5FqfpI1K+8G6yuJEc9NxT+v6ieA0N69qTGO83fbfDOLrtAJRkoJCBl0A7kE084R
 stOw==
X-Gm-Message-State: AOJu0Yx+iRVgZMG+tpAW045sw88IUwQe55hS3q4kP/p/zf6nOFxWdGbE
 YHpLe1O3rk14EgV+natMYdozBbDdNrNVGyQJBDJlAWOFiQwemkz05EFZQpTmNVkFQBLoblSjdih
 RL6hp+pN6/KOk7Y64eyPNPZP6ZzaGmPv7sfYck9ueD4LXnQIPBrPNZYZ2t/GuFmzpRNYmy0nA7+
 Mv2+X3Y5n+/45gIPS7Qf9B6k+xCxY=
X-Received: by 2002:a5d:5485:0:b0:354:f142:65b0 with SMTP id
 ffacd0b85a97d-35e0f28858fmr1309267f8f.37.1717154414283; 
 Fri, 31 May 2024 04:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYp6xUGQT7bi8LdHr2e9yWbwlbI5+B9hJbVUhizSshOYnjvKEPDgyMxtG7hIxlGQurdYpeKMkLSRIu2kER3AY=
X-Received: by 2002:a5d:5485:0:b0:354:f142:65b0 with SMTP id
 ffacd0b85a97d-35e0f28858fmr1309244f8f.37.1717154413770; Fri, 31 May 2024
 04:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:20:02 +0200
Message-ID: <CABgObfYFryXwEtVkMH-F6kw8hrivpQD6USMQ9=7fVikn5-mAhQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] Add AMD Secure Nested Paging (SEV-SNP) support
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 30, 2024 at 1:16=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> These patches implement SEV-SNP base support along with CPUID enforcement
> support for QEMU, and are also available at:
>
> https://github.com/pagupta/qemu/tree/snp_v4
>
> Latest version of kvm changes are posted here [2] and also queued in kvm/=
next.
>
> Patch Layout
> ------------
> 01-03: 'error_setg' independent fix, kvm/next header sync & patch from
>        Xiaoyao's TDX v5 patchset.
> 04-29: Introduction of sev-snp-guest object and various configuration
>        requirements for SNP. Support for creating a cryptographic "launch=
" context
>        and populating various OVMF metadata pages, BIOS regions, and vCPU=
/VMSA
>        pages with the initial encrypted/measured/validated launch data pr=
ior to
>        launching the SNP guest.
> 30-31: Handling for KVM_HC_MAP_GPA_RANGE hypercall for userspace VMEXIT.

These patches are more or less okay, with only a few nits, and I can
queue them already:

i386/sev: Replace error_report with error_setg
linux-headers: Update to current kvm/next
i386/sev: Introduce "sev-common" type to encapsulate common SEV state
i386/sev: Move sev_launch_update to separate class method
i386/sev: Move sev_launch_finish to separate class method
i386/sev: Introduce 'sev-snp-guest' object
i386/sev: Add a sev_snp_enabled() helper
i386/sev: Add sev_kvm_init() override for SEV class
i386/sev: Add snp_kvm_init() override for SNP class
i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
i386/sev: Don't return launch measurements for SEV-SNP guests
i386/sev: Add a class method to determine KVM VM type for SNP guests
i386/sev: Update query-sev QAPI format to handle SEV-SNP
i386/sev: Add the SNP launch start context
i386/sev: Add handling to encrypt/finalize guest launch data
i386/sev: Set CPU state to protected once SNP guest payload is finalized
hw/i386/sev: Add function to get SEV metadata from OVMF header
i386/sev: Add support for populating OVMF metadata pages
i386/sev: Add support for SNP CPUID validation
i386/sev: Invoke launch_updata_data() for SEV class
i386/sev: Invoke launch_updata_data() for SNP class
i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE
i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP guests
i386/sev: Extract build_kernel_loader_hashes
i386/sev: Reorder struct declarations
i386/sev: Allow measured direct kernel boot on SNP
hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled
memory: Introduce memory_region_init_ram_guest_memfd()

These patches need a small prerequisite that I'll post soon:

hw/i386/sev: Use guest_memfd for legacy ROMs
hw/i386: Add support for loading BIOS using guest_memfd

This one definitely requires more work:

hw/i386/sev: Allow use of pflash in conjunction with -bios


Paolo


