Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CF606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f1rTY8it;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rgs+nFn5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwS1-0005sc-CP; Mon, 16 Nov 2026 08:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xSwRw-0005sA-G3
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xSwRt-0004xT-PE
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794834520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKqzYimtubYSB/eBl6qW1PTm/LVekRz3ukBISdf/xP8=;
 b=f1rTY8itoWk/qVk1Hek23EBYDJjtfLZaokjdfeToC/e33XWST8mKC01cTlS9BHhHAtxoow
 Dp6GoPOhFDCNAtSBPkM1XJf4z3tBisZ9B/A6Bdjj212TS3rQj0YUzK0MNxfCIBAmC+6E5A
 BXLegIRRURrTQqxBdQ3mW1Wgv2nFe+E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-U171gaWcNT6u4GanLlk4Xw-1; Mon, 16 Nov 2026 08:08:38 -0500
X-MC-Unique: U171gaWcNT6u4GanLlk4Xw-1
X-Mimecast-MFC-AGG-ID: U171gaWcNT6u4GanLlk4Xw_1794834518
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2eaae62796dso30878235ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:08:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794834518; cv=none;
 d=google.com; s=arc-20260327;
 b=N5ai348vB/et3+GJIKRm9aNSiBbxrdruMW2ZVaSgo4cjEVgrviTeSf7U70k1m72kZ1
 VkLKLAOLNm2/CwM+x/dzhBS+Qe4JMYTFRRarBGI87mVx8xVA2vxj3aGrIBc9Ld7UlqoD
 ZSQ1Ekz1ob+39CMtTrljBWbPIl3VJLTJU5y12Q8jStnExSsE40dB4/sVx5fd4uj9EkQA
 MSD9sbSz5KmolS3bWLqOVUG/JBf/OWaEVCl+bU55Kpzi1UljztlfP8g1SuInzLfwwE4y
 BxNZO6eM94OMClWMsuW0I7r5FYbveElTInxY04ITlwI3iVu8qVX7RAXUqYbCUlRtLASH
 N02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tKqzYimtubYSB/eBl6qW1PTm/LVekRz3ukBISdf/xP8=;
 fh=rS1pn/k2gdC5sgZCgfzyWPyrYuvkWRUlCeVjIbXB8Tg=;
 b=Qexb+z1QIix4VDJSRSSCVOONf/9jztmyvcFqx05MEFJcsmqzJr0Qf1mjSA/RrmvGij
 FR2RoCYDMul59UgRWKyheh/IhwAlvy6fts52bknS5NVgP/wHO/f1l967gNacxL674/HP
 avlqBAg65mZdnE+kA0NW6K4V6x6wDld0x00Uc/yLQ58aTTKPUIrSGaY+uaNiwa6EiENV
 PdEHp5LU80FyR6JsjMA5lHDeqlGmFnUiMdJoURP0jAUWv9fUcOsk759MH5OJetkUI0P5
 YLnX3oZKC1NGR7OcCO92sw6R6GqO/L/r95Uil+XVxwZDD2N0czwmDhMk31mfPCY6OhyE
 A7Cg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794834518; x=1795439318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tKqzYimtubYSB/eBl6qW1PTm/LVekRz3ukBISdf/xP8=;
 b=rgs+nFn5qGuYhXZd1GHBfWXWN+DILhGOe931YcvvVUqcB3UYObGaRpIDWlzRve4cY9
 WS/B9jtzkbDZR573RwTj9560cZnoXBrOhq6bwYOw6xXdAAVskKDKV3360SmbJkBEX5h7
 Me67pAHVqWAYx5Udtw2yWzft0XaJEAtE3Ra1/TuFhuK50L+zlQEN91Maq3EjrYeRXMgT
 i1pdh4iVboHlBj/A7ZWTkCMVadAxwA42Zav/T6WS5j1FByndW7XSjQRZUT8AvRz6fO9r
 TfT+Dm+vYogxNn24WNjR5IVkN/9yeMdZvIi3ZVPR/O35HWKF/+mYBIkObzY4AD6Q6kbf
 uoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834518; x=1795439318;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tKqzYimtubYSB/eBl6qW1PTm/LVekRz3ukBISdf/xP8=;
 b=O8vAubGH/pS5xiO2S4pLEC95e0jG1wmudyRwFcIvsradlJ+dKEvvVvXGCBXIfWvH+E
 z6DCtq7T5ZyBscDyxaK+C6HHocSYR+IiKIPUFSMTfli3cKzLn7L3QmR81z+zUV91kFLF
 F1H4Zl+rg8yPOz7iL3gR66Aey78O8DniA51CVw/lb+c2q5wvOfWzZNNrHiyLqhcKYenD
 h3cWNYoCbSDG/ti+9/NFtnD0PEOFbsBIsIMGCCmhfQOCr9AJlIze58Vh2hx1aL5qQrbC
 ymukrTLv9/opD3cUdNPofhrrXqkFOJJTXNHOAXlCsXSsYp/FZTqrF62H2XyloygY4pZR
 My7g==
X-Gm-Message-State: APuU4Z8ulV22+QNQWf3SPAhCAyot+7ynHktiwHL3ZXrtN5f6g1uaES3l
 /ND8VblM9ir11E8nYs+DNVtXxmFa+VNcR6jzXDK19qXyny6lv2jjWknB2znaZrAmUG/2tQcfglZ
 XhZ+RBqTiEIqYNANkeD4LKEILYBFyIVadE3TSytjxjB6Y+KvDNgD9TzECVDQQo0jBeQ9FQJekuN
 9zxS0PzMGLnqiAg/cSyv2L6J4cCOPojJI=
X-Gm-Gg: AZFdTZcpQa/juzxtRsDW8mbGlbS3Y5pZvtMo72PHggd8v6+uLxRDjT4+IfBrp13ndoC
 E5MGp2jNi/YVggmrqjxQNeF7/hiF3SvjOz0Q/M4AJxX/66sPhnXOtPDLc3HfbA24R5ea0xBQwCd
 KDgMZVWDVC4PvFmtzPDfvLLoImfzB/mdteQZa067tjXwWtiA8fFhJTOX7YYg4MYQHhgngVD3yVR
 uidWBoWC/WZNJQw/0XSFgtDfpGRKWp3WipsZlmMTlZ7rDQM7YkFmwOxyclYo8RWdyVz8+xLpOu3
 ug==
X-Received: by 2002:a17:903:1a90:b0:2e9:7719:40fe with SMTP id
 d9443c01a7336-2ee0d66f9ccmr107365195ad.2.1794834517634; 
 Mon, 16 Nov 2026 05:08:37 -0800 (PST)
X-Received: by 2002:a17:903:1a90:b0:2e9:7719:40fe with SMTP id
 d9443c01a7336-2ee0d66f9ccmr107364815ad.2.1794834517038; Mon, 16 Nov 2026
 05:08:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-2-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Nov 2026 17:08:25 +0400
X-Gm-Features: AclHuK_rK1_giQ82BY-iu682wW3Jm2sKgJMD2Cj1J4J3oeLb95tatUs22oUJGgM
Message-ID: <CAMxuvazFrX28pnoHFudx_+KFrVSm10-WkRzqCk1+CTyU44fwZw@mail.gmail.com>
Subject: Re: [PATCH v3 01/26] hw: mark most virtio PCI devices as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 10:43=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> These are all intended for use in a virtualization scenario and must
> provide a security boundary. This can be done for almost all virtio
> PCI devices by modifying the common type register helper.
>
> Exceptions are made for the virtio-gpu-gl, virtio-vga-gl,
> virtio-vga-rutatbaga and virtio-gpu-rutabaga devices.
>
> Despite being intended for virtualization use cases, the complexity
> of support for 3d acceleration is such that QEMU can't offer security
> for these devices at this time.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

thanks
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-pci-gl.c   |  2 +-
>  hw/display/virtio-vga-gl.c       |  2 +-
>  hw/display/virtio-vga-rutabaga.c |  2 +-
>  hw/virtio/virtio-pci.c           | 17 ++++++++++++++++-
>  include/hw/virtio/virtio-pci.h   | 10 +++++++++-
>  5 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-pci-gl.c b/hw/display/virtio-gpu-pci-g=
l.c
> index c8923795dfa..dc67516b377 100644
> --- a/hw/display/virtio-gpu-pci-gl.c
> +++ b/hw/display/virtio-gpu-pci-gl.c
> @@ -51,7 +51,7 @@ module_kconfig(VIRTIO_PCI);
>
>  static void virtio_gpu_gl_pci_register_types(void)
>  {
> -    virtio_pci_types_register(&virtio_gpu_gl_pci_info);
> +    virtio_pci_types_register_insecure(&virtio_gpu_gl_pci_info);
>  }
>
>  type_init(virtio_gpu_gl_pci_register_types)
> diff --git a/hw/display/virtio-vga-gl.c b/hw/display/virtio-vga-gl.c
> index 178e4c71725..029d288c035 100644
> --- a/hw/display/virtio-vga-gl.c
> +++ b/hw/display/virtio-vga-gl.c
> @@ -42,7 +42,7 @@ module_kconfig(VIRTIO_VGA);
>  static void virtio_vga_register_types(void)
>  {
>      if (have_vga) {
> -        virtio_pci_types_register(&virtio_vga_gl_info);
> +        virtio_pci_types_register_insecure(&virtio_vga_gl_info);
>      }
>  }
>
> diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rut=
abaga.c
> index 1e07ee0b0d3..8ff715f8a35 100644
> --- a/hw/display/virtio-vga-rutabaga.c
> +++ b/hw/display/virtio-vga-rutabaga.c
> @@ -41,7 +41,7 @@ module_kconfig(VIRTIO_VGA);
>  static void virtio_vga_register_types(void)
>  {
>      if (have_vga) {
> -        virtio_pci_types_register(&virtio_vga_rutabaga_info);
> +        virtio_pci_types_register_insecure(&virtio_vga_rutabaga_info);
>      }
>  }
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c73f1f546cb..fe2e545c302 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2510,7 +2510,9 @@ static void virtio_pci_non_transitional_instance_in=
it(Object *obj)
>      proxy->disable_modern =3D false;
>  }
>
> -void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
> +static void
> +virtio_pci_types_register_internal(const VirtioPCIDeviceTypeInfo *t,
> +                                   bool secure)
>  {
>      char *base_name =3D NULL;
>      TypeInfo base_type_info =3D {
> @@ -2527,6 +2529,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
>          .name =3D t->generic_name,
>          .parent =3D base_type_info.name,
>          .class_init =3D virtio_pci_generic_class_init,
> +        .secure =3D secure,
>          .interfaces =3D (const InterfaceInfo[]) {
>              { INTERFACE_PCIE_DEVICE },
>              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> @@ -2562,6 +2565,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
>              .name          =3D t->non_transitional_name,
>              .parent        =3D base_type_info.name,
>              .instance_init =3D virtio_pci_non_transitional_instance_init=
,
> +            .secure =3D secure,
>              .interfaces =3D (const InterfaceInfo[]) {
>                  { INTERFACE_PCIE_DEVICE },
>                  { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> @@ -2576,6 +2580,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
>              .name          =3D t->transitional_name,
>              .parent        =3D base_type_info.name,
>              .instance_init =3D virtio_pci_transitional_instance_init,
> +            .secure =3D secure,
>              .interfaces =3D (const InterfaceInfo[]) {
>                  /*
>                   * Transitional virtio devices work only as Conventional=
 PCI
> @@ -2590,6 +2595,16 @@ void virtio_pci_types_register(const VirtioPCIDevi=
ceTypeInfo *t)
>      g_free(base_name);
>  }
>
> +void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
> +{
> +    virtio_pci_types_register_internal(t, true);
> +}
> +
> +void virtio_pci_types_register_insecure(const VirtioPCIDeviceTypeInfo *t=
)
> +{
> +    virtio_pci_types_register_internal(t, false);
> +}
> +
>  unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues)
>  {
>      /*
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pc=
i.h
> index ee50fb0d551..f033237035a 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -239,8 +239,16 @@ typedef struct VirtioPCIDeviceTypeInfo {
>      const InterfaceInfo *interfaces;
>  } VirtioPCIDeviceTypeInfo;
>
> -/* Register virtio-pci type(s).  @t must be static. */
> +/*
> + * Register virtio-pci type(s).
> + * @t must be static.
> + *
> + * Since they serve the virtualization use case, most virtio
> + * devices are expected to be classed as secure. In the rare
> + * scenario where this is not desired, use the second method.
> + */
>  void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
> +void virtio_pci_types_register_insecure(const VirtioPCIDeviceTypeInfo *t=
);
>
>  /**
>   * virtio_pci_optimal_num_queues:
> --
> 2.56.1
>


