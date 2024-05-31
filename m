Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247C7C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD690-0006XW-Lv; Fri, 31 May 2024 13:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD68y-0006X2-Q5
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD68w-0005GD-RM
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717176857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTQBsLoLFyr/bsxrazI3Wdm6raiglGew9Gxd8uS7dnE=;
 b=PeiXhMgC94a6t60648oDyX87DOtFz9gmIY8sP/xq9hnaV2M5jvPJpjXF7tSMtayzbd9sw9
 +tEF06PlXIF8SGvTswtpKhKS6psQPYTQmWjB4LQBYbLVPyg8DoyG+wNBoMSN/9Crp7Kx5K
 xTS3FKxtGJ8PHdVlvhP+ueA+q/bdpps=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-s83FXaC4M42-RpfzIUls8g-1; Fri, 31 May 2024 13:34:16 -0400
X-MC-Unique: s83FXaC4M42-RpfzIUls8g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dc060e68aso1420367f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717176855; x=1717781655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTQBsLoLFyr/bsxrazI3Wdm6raiglGew9Gxd8uS7dnE=;
 b=DVqWKDjHGrFO7GGm72gNOhiO59zPbIdEjARBMIQyG3dUYskcOXrSP9bSeV790Jzd+o
 HBPbzo6nd3bQ/byiA/UvTO5Jw2LLiRIrahPA2Y7xgee+fSlVJl28LHr453876Ii8V/1d
 nymHj7IKpVQnVnIae66TU2WwDE83I1Kmf9pu15GhULazO2S5DjHv/QF88qPW686+w/c5
 Q44cLsgDXqR5wT8qOixnU0PTGu6T4fF/RlJQZHseGD7g19z3c3ew9voQpBuQ64bMKRWX
 bopbgjKnVpRVKwiHY/PEYrvNLkccv3hKN70UDBBArgHGrQYt1JwChRfSQkiFhEg/bFo3
 BIRg==
X-Gm-Message-State: AOJu0YxWUWw02IbNtfnHeiXO/GXM3GPzB4X5M62NYmVYyWYMk2cW4YMR
 80NgqZX10j5Epf43S2LHmOOW+WZukMW2h7p37TFF3cGopm8HquLXe0cP92PMC5JDjd2DkHK3wgL
 g3FXtB9UzV8t9BFa3D+YfkiARsT8qVOflMyz4w1IrVYkMiPD7EAPP8C85+mav3+WihR4lgFB80u
 DEX2Op/6yFqF1M0aalU8tQ3/B7R3g=
X-Received: by 2002:adf:f44d:0:b0:343:ef64:e0fd with SMTP id
 ffacd0b85a97d-35e0f30a89dmr1803388f8f.52.1717176855024; 
 Fri, 31 May 2024 10:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGDV1OH7Fl/Fo5KeMbK3huL5FBB8TDYOad1c8EHRVl8vG5i24CYXQ+/f0EkiCdmKIbgXwxYY1z1V3BGTcSQEs=
X-Received: by 2002:adf:f44d:0:b0:343:ef64:e0fd with SMTP id
 ffacd0b85a97d-35e0f30a89dmr1803373f8f.52.1717176854663; Fri, 31 May 2024
 10:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <CABgObfYFryXwEtVkMH-F6kw8hrivpQD6USMQ9=7fVikn5-mAhQ@mail.gmail.com>
In-Reply-To: <CABgObfYFryXwEtVkMH-F6kw8hrivpQD6USMQ9=7fVikn5-mAhQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 19:34:03 +0200
Message-ID: <CABgObfbwr6CJK1XCmmVhp83AsC2YcQfSsfuPFWDuxzCB_R4GoQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] Add AMD Secure Nested Paging (SEV-SNP) support
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Fri, May 31, 2024 at 1:20=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Thu, May 30, 2024 at 1:16=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.co=
m> wrote:
> >
> > These patches implement SEV-SNP base support along with CPUID enforceme=
nt
> > support for QEMU, and are also available at:
> >
> > https://github.com/pagupta/qemu/tree/snp_v4
> >
> > Latest version of kvm changes are posted here [2] and also queued in kv=
m/next.
> >
> > Patch Layout
> > ------------
> > 01-03: 'error_setg' independent fix, kvm/next header sync & patch from
> >        Xiaoyao's TDX v5 patchset.
> > 04-29: Introduction of sev-snp-guest object and various configuration
> >        requirements for SNP. Support for creating a cryptographic "laun=
ch" context
> >        and populating various OVMF metadata pages, BIOS regions, and vC=
PU/VMSA
> >        pages with the initial encrypted/measured/validated launch data =
prior to
> >        launching the SNP guest.
> > 30-31: Handling for KVM_HC_MAP_GPA_RANGE hypercall for userspace VMEXIT=
.
>
> These patches are more or less okay, with only a few nits, and I can
> queue them already:

Hey,

please check if branch qemu-coco-queue of
https://gitlab.com/bonzini/qemu works for you!

I tested it successfully on CentOS 9 Stream with kernel from kvm/next
and firmware from edk2-ovmf-20240524-1.fc41.noarch.

Paolo

> i386/sev: Replace error_report with error_setg
> linux-headers: Update to current kvm/next
> i386/sev: Introduce "sev-common" type to encapsulate common SEV state
> i386/sev: Move sev_launch_update to separate class method
> i386/sev: Move sev_launch_finish to separate class method
> i386/sev: Introduce 'sev-snp-guest' object
> i386/sev: Add a sev_snp_enabled() helper
> i386/sev: Add sev_kvm_init() override for SEV class
> i386/sev: Add snp_kvm_init() override for SNP class
> i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
> i386/sev: Don't return launch measurements for SEV-SNP guests
> i386/sev: Add a class method to determine KVM VM type for SNP guests
> i386/sev: Update query-sev QAPI format to handle SEV-SNP
> i386/sev: Add the SNP launch start context
> i386/sev: Add handling to encrypt/finalize guest launch data
> i386/sev: Set CPU state to protected once SNP guest payload is finalized
> hw/i386/sev: Add function to get SEV metadata from OVMF header
> i386/sev: Add support for populating OVMF metadata pages
> i386/sev: Add support for SNP CPUID validation
> i386/sev: Invoke launch_updata_data() for SEV class
> i386/sev: Invoke launch_updata_data() for SNP class
> i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE
> i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP guests
> i386/sev: Extract build_kernel_loader_hashes
> i386/sev: Reorder struct declarations
> i386/sev: Allow measured direct kernel boot on SNP
> hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled
> memory: Introduce memory_region_init_ram_guest_memfd()
>
> These patches need a small prerequisite that I'll post soon:
>
> hw/i386/sev: Use guest_memfd for legacy ROMs
> hw/i386: Add support for loading BIOS using guest_memfd
>
> This one definitely requires more work:
>
> hw/i386/sev: Allow use of pflash in conjunction with -bios
>
>
> Paolo


