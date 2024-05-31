Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB11BC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6Ra-0007o3-3n; Fri, 31 May 2024 13:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD6RY-0007nv-Ng
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD6RT-0000dc-TY
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717178006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2o6F1Dc2l7bB8BlqlMqsKWJyXsVc7vftxsgjVAHDhno=;
 b=fqLkRtyTWSh00Bd0JAKd7Wa99Ds5lYOijgYOdQkrBqfvRlmdW5JscKUmzqPOhwgqQuj/sA
 VLhyaExduLnVo+bBFhiipkz2lPV+mOOCUfm2gfrX4jpqaFGh/DNo1XQk1aN4w91zNT6ZCx
 hY76TawC02Xl42CNOKJO/BhroRo9THI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-j7aIRxUyOD-P9Ro63HIKwA-1; Fri, 31 May 2024 13:53:24 -0400
X-MC-Unique: j7aIRxUyOD-P9Ro63HIKwA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dcb90989eso1342490f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717178003; x=1717782803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o6F1Dc2l7bB8BlqlMqsKWJyXsVc7vftxsgjVAHDhno=;
 b=QQ4NK816XCMZAbb681RCwgfRSfFZ93M4yHftnOPR+ljVsrlNzUXNnzf0+p618I0DYX
 AhxgvOi9F+tlPjMhgsWcc8pUKgF8axchoxjHbLqr7FTRWctGoyvyAn9wRRTv9nyICjdB
 W6d5o/fGFS7ZCmVo1kzJjIGmUs3iAPkos5bgHJrCLLTI4/SSqaEqfJ+hiqoH3I8DOZNm
 aF7xvkfrtvOONbFA5mUPApVKyuQ3dZIdrOjzIB0Qsr/ODDnSGUadp5JmZ19a5wR4SjJ1
 3BDXTDjQ8u1HSjgjEpWI2zYmBcyZTooprPiyY1Sn7CsfyeKXNT2UjVhpUbahzdFz5ID9
 sHTg==
X-Gm-Message-State: AOJu0YwOR2yYBqMJ2EMdNjz+ZettuTq2Q3DpBSDnz+BI3N5+cmqUx98s
 CbTwXaUN2AUoklfY7ZlswZ8/bBjpwpIY4Wgdifh6n5NKZbZy4vD1rRN9r1VxNVu+uADTBOkE3+k
 lbFo+yOHAyfRy19FezAWXodg5N6KDut7M3z0ZdTRHmX6nsVXJ3VQDThjQTQXEdw0SaH/h9L3bSN
 86XUgpqdnxEX3GVtJ001vUvWPNhdg=
X-Received: by 2002:a5d:6986:0:b0:354:d773:60f3 with SMTP id
 ffacd0b85a97d-35e0f3633d4mr1994927f8f.71.1717178003514; 
 Fri, 31 May 2024 10:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUvQqcyiIkwtnOP7/4Ts5GzZAhN3CWLl+H/JLDGqzfx/fyaJ12bWqKoeI3fh+g+da9P7IIA4lAnJO7gs4gvR0=
X-Received: by 2002:a5d:6986:0:b0:354:d773:60f3 with SMTP id
 ffacd0b85a97d-35e0f3633d4mr1994901f8f.71.1717178002821; Fri, 31 May 2024
 10:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <CABgObfYFryXwEtVkMH-F6kw8hrivpQD6USMQ9=7fVikn5-mAhQ@mail.gmail.com>
 <CABgObfbwr6CJK1XCmmVhp83AsC2YcQfSsfuPFWDuxzCB_R4GoQ@mail.gmail.com>
 <621a8792-5b19-0861-0356-fb2d05caffa1@amd.com>
In-Reply-To: <621a8792-5b19-0861-0356-fb2d05caffa1@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 19:53:10 +0200
Message-ID: <CABgObfbrWNB4-UzHURF-iO9dTTS4CkJXODE0wNEKOA_fk790_w@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] Add AMD Secure Nested Paging (SEV-SNP) support
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 31, 2024 at 7:41=E2=80=AFPM Gupta, Pankaj <pankaj.gupta@amd.com=
> wrote:
> > please check if branch qemu-coco-queue of
> > https://gitlab.com/bonzini/qemu works for you!
>
> Getting compilation error here: Hope I am looking at correct branch.

Oops, sorry:

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 96dc41d355c..ede3ef1225f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -168,7 +168,7 @@ static const char *vm_type_name[] =3D {
     [KVM_X86_DEFAULT_VM] =3D "default",
     [KVM_X86_SEV_VM] =3D "SEV",
     [KVM_X86_SEV_ES_VM] =3D "SEV-ES",
-    [KVM_X86_SEV_SNP_VM] =3D "SEV-SNP",
+    [KVM_X86_SNP_VM] =3D "SEV-SNP",
 };

 bool kvm_is_vm_type_supported(int type)

Tested the above builds, and pushed!

Paolo

> softmmu.fa.p/target_i386_kvm_kvm.c.o.d -o
> libqemu-x86_64-softmmu.fa.p/target_i386_kvm_kvm.c.o -c
> ../target/i386/kvm/kvm.c
> ../target/i386/kvm/kvm.c:171:6: error: =E2=80=98KVM_X86_SEV_SNP_VM=E2=80=
=99 undeclared
> here (not in a function); did you mean =E2=80=98KVM_X86_SEV_ES_VM=E2=80=
=99?
>    171 |     [KVM_X86_SEV_SNP_VM] =3D "SEV-SNP",
>        |      ^~~~~~~~~~~~~~~~~~
>        |      KVM_X86_SEV_ES_VM
>
> Thanks,
> Pankaj
>
> >
> > I tested it successfully on CentOS 9 Stream with kernel from kvm/next
> > and firmware from edk2-ovmf-20240524-1.fc41.noarch.
> >
> > Paolo
> >
> >> i386/sev: Replace error_report with error_setg
> >> linux-headers: Update to current kvm/next
> >> i386/sev: Introduce "sev-common" type to encapsulate common SEV state
> >> i386/sev: Move sev_launch_update to separate class method
> >> i386/sev: Move sev_launch_finish to separate class method
> >> i386/sev: Introduce 'sev-snp-guest' object
> >> i386/sev: Add a sev_snp_enabled() helper
> >> i386/sev: Add sev_kvm_init() override for SEV class
> >> i386/sev: Add snp_kvm_init() override for SNP class
> >> i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
> >> i386/sev: Don't return launch measurements for SEV-SNP guests
> >> i386/sev: Add a class method to determine KVM VM type for SNP guests
> >> i386/sev: Update query-sev QAPI format to handle SEV-SNP
> >> i386/sev: Add the SNP launch start context
> >> i386/sev: Add handling to encrypt/finalize guest launch data
> >> i386/sev: Set CPU state to protected once SNP guest payload is finaliz=
ed
> >> hw/i386/sev: Add function to get SEV metadata from OVMF header
> >> i386/sev: Add support for populating OVMF metadata pages
> >> i386/sev: Add support for SNP CPUID validation
> >> i386/sev: Invoke launch_updata_data() for SEV class
> >> i386/sev: Invoke launch_updata_data() for SNP class
> >> i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE
> >> i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP guests
> >> i386/sev: Extract build_kernel_loader_hashes
> >> i386/sev: Reorder struct declarations
> >> i386/sev: Allow measured direct kernel boot on SNP
> >> hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled
> >> memory: Introduce memory_region_init_ram_guest_memfd()
> >>
> >> These patches need a small prerequisite that I'll post soon:
> >>
> >> hw/i386/sev: Use guest_memfd for legacy ROMs
> >> hw/i386: Add support for loading BIOS using guest_memfd
> >>
> >> This one definitely requires more work:
> >>
> >> hw/i386/sev: Allow use of pflash in conjunction with -bios
> >>
> >>
> >> Paolo
> >
>


