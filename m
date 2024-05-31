Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD300C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0E0-0008Pl-MT; Fri, 31 May 2024 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0Dy-0008PK-Ta
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0Dv-00027k-Vj
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717154101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jXYYD4cspJOQ9jiYJKbwem/EX2NyyJObMUsqoU6/W0=;
 b=AUww8ZOQpvaeSe1deQspoG/riqP0Eh03efTZ0ehIALHf2lbVFieu2iF6MWs82XhLDrDN5J
 N+TFYSIt2BlLyFp70nHV7sP8STadGd9dT04RnDV1RJsVMeDY2XzFwmgOa/GWSyXNa/OZ23
 jOXVLCf7x/Stx1Opk1n9QN+aR1ugBRo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-o4WZA5wWOhS8x4VUogtSEA-1; Fri, 31 May 2024 07:15:00 -0400
X-MC-Unique: o4WZA5wWOhS8x4VUogtSEA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dc5934390so923586f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717154099; x=1717758899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jXYYD4cspJOQ9jiYJKbwem/EX2NyyJObMUsqoU6/W0=;
 b=q3k48WGlSujKbaBTzFHS+TRF0Bk4yZjIoTGUFbC8v1JAhtRQnWivymZVYhUp9bWYh3
 ap7P1hGMdbFaiB8TUzn+7jbDB7oWw8LDVhAxiSB46J/+dw3DGTFY81TVHfP4hnydc7Q/
 k5jfz8poWWbW2fcgQ7DuVf1qa+dVavlJRDszWaChp5NdpragscpWhNHmQmXBTOTqrgtb
 8aPKZQdarjBm6j2AEdSU8S3vq84h1hi5gm+cC+v38/m4OybdobArY8hZTCy8YwLJGu21
 Z+cLE9x7vLBoFgy8oPwllpug2KArMpsb28K87N2kF7zHmT3FQ5A25jjfXzJkqekAIamR
 8GSA==
X-Gm-Message-State: AOJu0YzP3MK6rkodUTtQlE3FQbyZ1xMp17JYW9u51swllzR1cc0holVS
 NNs2Orlk3gLIEUhspTjlMoG53siUeSpTS60yNmJz8v0TI7BylhX0MMmsQoahwKvCx8cG8WWpOOL
 xPmJP0pevOdNNBWs7DK+AB6AAQ/J0EjGDWqvSmpKVQK+eZL61mmbzs+RMz3RxJpT01PIorBf5vk
 ponul+35/m/uOHqdcb04nqlTRhcWQ=
X-Received: by 2002:a05:6000:1052:b0:354:f7b9:75bd with SMTP id
 ffacd0b85a97d-35e0f30aacemr1292510f8f.47.1717154099257; 
 Fri, 31 May 2024 04:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+52y8MtfKNErYDc3147gk2kO8zuDtDGsX5IsUfjhiIZcf8DvdYxXgSFh+DwIZyfBtHizpAuij4Gou4STJFB8=
X-Received: by 2002:a05:6000:1052:b0:354:f7b9:75bd with SMTP id
 ffacd0b85a97d-35e0f30aacemr1292489f8f.47.1717154098896; Fri, 31 May 2024
 04:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-24-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-24-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:14:47 +0200
Message-ID: <CABgObfaL_OBwWvPbRAocKSprqPZVFsPMamjFNWris3UB5Az0zQ@mail.gmail.com>
Subject: Re: [PATCH v4 23/31] i386/sev: Allow measured direct kernel boot on
 SNP
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> From: Dov Murik <dovmurik@linux.ibm.com>
>
> In SNP, the hashes page designated with a specific metadata entry
> published in AmdSev OVMF.
>
> Therefore, if the user enabled kernel hashes (for measured direct boot),
> QEMU should prepare the content of hashes table, and during the
> processing of the metadata entry it copy the content into the designated
> page and encrypt it.
>
> Note that in SNP (unlike SEV and SEV-ES) the measurements is done in
> whole 4KB pages.  Therefore QEMU zeros the whole page that includes the
> hashes table, and fills in the kernel hashes area in that page, and then
> encrypts the whole page.  The rest of the page is reserved for SEV
> launch secrets which are not usable anyway on SNP.
>
> If the user disabled kernel hashes, QEMU pre-validates the kernel hashes
> page as a zero page.
>
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>  include/hw/i386/pc.h |  2 ++
>  target/i386/sev.c    | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c653b8eeb2..ca7904ac2c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -172,6 +172,8 @@ typedef enum {
>      SEV_DESC_TYPE_SNP_SECRETS,
>      /* The section contains address that can be used as a CPUID page */
>      SEV_DESC_TYPE_CPUID,
> +    /* The section contains the region for kernel hashes for measured di=
rect boot */
> +    SEV_DESC_TYPE_SNP_KERNEL_HASHES =3D 0x10,
>
>  } ovmf_sev_metadata_desc_type;
>
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 1b29fdbc9a..1a78e98751 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -145,6 +145,9 @@ struct SevSnpGuestState {
>
>      struct kvm_sev_snp_launch_start kvm_start_conf;
>      struct kvm_sev_snp_launch_finish kvm_finish_conf;
> +
> +    uint32_t kernel_hashes_offset;
> +    PaddedSevHashTable *kernel_hashes_data;
>  };
>
>  struct SevSnpGuestStateClass {
> @@ -1187,6 +1190,23 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void =
*hva, uint32_t cpuid_len)
>                                    KVM_SEV_SNP_PAGE_TYPE_CPUID);
>  }
>
> +static int
> +snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr=
,
> +                                void *hva, uint32_t len)
> +{
> +    int type =3D KVM_SEV_SNP_PAGE_TYPE_ZERO;
> +    if (sev_snp->parent_obj.kernel_hashes) {
> +        assert(sev_snp->kernel_hashes_data);
> +        assert((sev_snp->kernel_hashes_offset +
> +                sizeof(*sev_snp->kernel_hashes_data)) <=3D len);
> +        memset(hva, 0, len);
> +        memcpy(hva + sev_snp->kernel_hashes_offset, sev_snp->kernel_hash=
es_data,
> +               sizeof(*sev_snp->kernel_hashes_data));
> +        type =3D KVM_SEV_SNP_PAGE_TYPE_NORMAL;
> +    }
> +    return snp_launch_update_data(addr, hva, len, type);
> +}
> +
>  static int
>  snp_metadata_desc_to_page_type(int desc_type)
>  {
> @@ -1223,6 +1243,9 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_s=
np,
>
>          if (type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID) {
>              ret =3D snp_launch_update_cpuid(desc->base, hva, desc->len);
> +        } else if (desc->type =3D=3D SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
> +            ret =3D snp_launch_update_kernel_hashes(sev_snp, desc->base,=
 hva,
> +                                                  desc->len);
>          } else {
>              ret =3D snp_launch_update_data(desc->base, hva, desc->len, t=
ype);
>          }
> @@ -1855,6 +1878,18 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderC=
ontext *ctx, Error **errp)
>          return false;
>      }
>
> +    if (sev_snp_enabled()) {
> +        /*
> +         * SNP: Populate the hashes table in an area that later in
> +         * snp_launch_update_kernel_hashes() will be copied to the guest=
 memory
> +         * and encrypted.
> +         */
> +        SevSnpGuestState *sev_snp_guest =3D SEV_SNP_GUEST(sev_common);
> +        sev_snp_guest->kernel_hashes_offset =3D area->base & ~TARGET_PAG=
E_MASK;
> +        sev_snp_guest->kernel_hashes_data =3D g_new0(PaddedSevHashTable,=
 1);
> +        return build_kernel_loader_hashes(sev_snp_guest->kernel_hashes_d=
ata, ctx, errp);
> +    }

This is effectively a new method:

    bool (*build_kernel_loader_hashes)(SevCommonState *sev_common,
                                       SevHashTableDescriptor *area,
                                       SevKernelLoaderContext *ctx,
                                       Error **errp);

where the four lines above are the implementation for SNP and the code
below is the implementation for sev-guest.

Paolo


>      /*
>       * Populate the hashes table in the guest's memory at the OVMF-desig=
nated
>       * area for the SEV hashes table
> --
> 2.34.1
>


