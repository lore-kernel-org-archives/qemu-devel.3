Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F1CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGJl-0003sD-EN; Thu, 04 Jul 2024 02:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPGJk-0003rt-0e
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPGJQ-0003c0-SV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720075881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/AVilcDu8v/3xKecAEhUmXHTQ27Du9KXpdz07eQ/YQ=;
 b=SAAvjSsbtZ5jqXTjG1+3j5xD27Wzb6lRfXLfQJ/2A1daeRVpl9KfCzZw1ZgV9oLXXL9zoa
 aTThVnUlSbbkib5I9XA40JrOiHI0JUWV0v/iSaafyUY0eRdCzSiazOTMc5IG/rfG+gL/la
 V9fC314v5+vSQ4O/wxrw7bvGzGKU42s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-tnelzKONNFi9kH8I1PvHow-1; Thu, 04 Jul 2024 02:51:19 -0400
X-MC-Unique: tnelzKONNFi9kH8I1PvHow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36794fcfdd6so208890f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 23:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720075878; x=1720680678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/AVilcDu8v/3xKecAEhUmXHTQ27Du9KXpdz07eQ/YQ=;
 b=h0rOEOWrWzCwi1UfFEP4/uk+RQWihpZzudj5BkP2ibES56KD36gkNktB1AFJmS6Ogn
 ihlTYz68feypmdrNtz1UPhXDWfxEl+Zt6JeBagD5zw7FkqyIb1yitNpEhkssQMuBaXLS
 EiBJ9MstyknoOa6rcRI0Dt0drfHDxG8HQmXmG0SAkvIujJE9TFZFwl4D57QpbBKeK9QS
 t/9qD3ud8U2P/0VqlPMo5whvFT9lbFnu6gMWxiniEbEcerqYqyGqVFXrF3hNIh7c2omB
 c+p6XZfSL3HAdY9xr+2RzAlXn+X68xe/QhdvbNcWKPjyAsiLZnMziL/1FTo/UQAgzdwD
 xJzg==
X-Gm-Message-State: AOJu0YzXpuWBlJirrztiPa9/pEASTOj3Y35TKBcpjIz+rQ8YY574BFyz
 zsyZckCvqHODtm9Ob0KGEICDqkII+3Z2iVnFKDK4a3xU9JZPaz/yX/MUKdv6OyAu7/sX6D3ApF+
 h3O535VaLrzU8kcscvCdwGMVqoarFdjZBVVX7SYARq1FxDwiXqV3ucJy3+krkm+UbXAFCKguBD4
 sPaNFkwHqBN7CB2/gXPZWUHV9Ztp4=
X-Received: by 2002:adf:f043:0:b0:367:980a:6af with SMTP id
 ffacd0b85a97d-3679dd718fdmr683387f8f.59.1720075877997; 
 Wed, 03 Jul 2024 23:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5yI3p6ZTbveCHvrG7CXdXgJkbt2ZxrfLmKKgB7cdkvlItFYJusQWTUeG6QgDhMqVhz4m4jpfoK1Yj8l6nfi4=
X-Received: by 2002:adf:f043:0:b0:367:980a:6af with SMTP id
 ffacd0b85a97d-3679dd718fdmr683367f8f.59.1720075877618; Wed, 03 Jul 2024
 23:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240704000019.3928862-1-michael.roth@amd.com>
In-Reply-To: <20240704000019.3928862-1-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Jul 2024 08:51:05 +0200
Message-ID: <CABgObfYX+nDnQSW5xyT3SjYbQ72--EW5buCkUuG_Z_JPFqfQNA@mail.gmail.com>
Subject: Re: [PATCH] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 4, 2024 at 2:01=E2=80=AFAM Michael Roth <michael.roth@amd.com> =
wrote:
> Currently if the 'legacy-vm-type' property of the sev-guest object is
> left unset, QEMU will attempt to use the newer KVM_SEV_INIT2 kernel
> interface in conjunction with the newer KVM_X86_SEV_VM and
> KVM_X86_SEV_ES_VM KVM VM types.
>
> This can lead to measurement changes if, for instance, an SEV guest was
> created on a host that originally had an older kernel that didn't
> support KVM_SEV_INIT2, but is booted on the same host later on after the
> host kernel was upgraded.

I think this is the right thing to do for SEV-ES. I agree that it's
bad to require a very new kernel (6.10 will be released only a month
before QEMU 9.1), on the other hand the KVM_SEV_ES_INIT API is broken
in several ways. As long as there is a way to go back to it, and it's
not changed by old machine types, not using it for SEV-ES is the
better choice for upstream.

On the other hand, I think it makes no difference for SEV?  Should we
always use KVM_SEV_INIT, or alternatively fall back as it was before
this patch?

Paolo

> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> cc: kvm@vger.kernel.org
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/qom.json     | 11 ++++++-----
>  target/i386/sev.c | 30 ++++++++++++++++++++++++------
>  2 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..a212c009aa 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -912,11 +912,12 @@
>  # @handle: SEV firmware handle (default: 0)
>  #
>  # @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating th=
e VM.
> -#                  The newer KVM_SEV_INIT2 interface syncs additional vC=
PU
> -#                  state when initializing the VMSA structures, which wi=
ll
> -#                  result in a different guest measurement. Set this to
> -#                  maintain compatibility with older QEMU or kernel vers=
ions
> -#                  that rely on legacy KVM_SEV_INIT behavior.
> +#                  The newer KVM_SEV_INIT2 interface, from Linux >=3D 6.=
10, syncs
> +#                  additional vCPU state when initializing the VMSA stru=
ctures,
> +#                  which will result in a different guest measurement. S=
et
> +#                  this to force compatibility with older QEMU or kernel
> +#                  versions that rely on legacy KVM_SEV_INIT behavior.
> +#                  Otherwise, QEMU will require KVM_SEV_INIT2 for SEV gu=
ests.
>  #                  (default: false) (since 9.1)
>  #
>  # Since: 2.12
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 3ab8b3c28b..8f56c0cf0c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1347,14 +1347,22 @@ static int sev_kvm_type(X86ConfidentialGuest *cg)
>          goto out;
>      }
>
> +    if (sev_guest->legacy_vm_type) {
> +        sev_common->kvm_type =3D KVM_X86_DEFAULT_VM;
> +        goto out;
> +    }
> +
>      kvm_type =3D (sev_guest->policy & SEV_POLICY_ES) ?
>                  KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
> -    if (kvm_is_vm_type_supported(kvm_type) && !sev_guest->legacy_vm_type=
) {
> -        sev_common->kvm_type =3D kvm_type;
> -    } else {
> -        sev_common->kvm_type =3D KVM_X86_DEFAULT_VM;
> +    if (!kvm_is_vm_type_supported(kvm_type)) {
> +            error_report("SEV: host kernel does not support requested %s=
 VM type. To allow use of "
> +                         "legacy KVM_X86_DEFAULT_VM VM type, the 'legacy=
-vm-type' argument must be "
> +                         "set to true for the sev-guest object.",
> +                         kvm_type =3D=3D KVM_X86_SEV_VM ? "KVM_X86_SEV_V=
M" : "KVM_X86_SEV_ES_VM");
> +            return -1;
>      }
>
> +    sev_common->kvm_type =3D kvm_type;
>  out:
>      return sev_common->kvm_type;
>  }
> @@ -1445,14 +1453,24 @@ static int sev_common_kvm_init(ConfidentialGuestS=
upport *cgs, Error **errp)
>      }
>
>      trace_kvm_sev_init();
> -    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) =3D=3D K=
VM_X86_DEFAULT_VM) {
> +    switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
> +    case KVM_X86_DEFAULT_VM:
>          cmd =3D sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
>
>          ret =3D sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
> -    } else {
> +        break;
> +    case KVM_X86_SEV_VM:
> +    case KVM_X86_SEV_ES_VM:
> +    case KVM_X86_SNP_VM: {
>          struct kvm_sev_init args =3D { 0 };
>
>          ret =3D sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_=
error);
> +        break;
> +    }
> +    default:
> +        error_setg(errp, "%s: host kernel does not support the requested=
 SEV configuration.",
> +                   __func__);
> +        return -1;
>      }
>
>      if (ret) {
> --
> 2.25.1
>


