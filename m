Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81322C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJ9W-000178-9J; Wed, 29 May 2024 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJ9R-00015S-Pz
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJ9P-0004An-Pt
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716988529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMHS5AqILWAeW+3AL6eDxpoqbznbIS1vP56034FIBGc=;
 b=hZSYdU8OU3sIYjqvuZYP8MG0ve89btUEmFLvAkRs8YzxPs6Na+BNFxAvdRvlH58mK7ErL4
 4xs9EE+0j0UllRWkSMtmV/Bk6D3HF1mGmneIDAINmNFahwaKBlE4fX+aZyDWvcZwGycStW
 L21cByuIbyhyYybgY7gnUuwroCI88iw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-7MV6HFOePe229wj01fMU9Q-1; Wed, 29 May 2024 09:15:26 -0400
X-MC-Unique: 7MV6HFOePe229wj01fMU9Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4211043b5easo13823285e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716988522; x=1717593322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cMHS5AqILWAeW+3AL6eDxpoqbznbIS1vP56034FIBGc=;
 b=ALV/sbgV5qo1BOizBlpAyJUzNDPqEbT7QrLaG5CwplJfv86s30kDcI+zRfVNVWnl27
 S5ZX6imhF7wZvf/LYqAQqTecI/BeMUCyA44eFdPu/iQYRI/dcfJv4/PeywVTrF3RPhTu
 y4/AfFvZwIwm+lyQCaWia9iqCozvyI4cLIcNkegqyVX/rTiqoF3BlGXyNSB/p/tzgJGg
 7VxshCzqfPwt65H5bXWz4/r99RX3+4husvf39m8OsR8MZJcVWyxIkf2fdNtdM0bYs86d
 rTP/aHF6xHtq7w3KGNcIBgs/bT1QpIXTIKevYSnJLgz6AzEbsc2i4z78pLq3vF/i01Fd
 Ymiw==
X-Gm-Message-State: AOJu0YwI57EkSaehXFjqv3g6QiaoQjowqUEcjzZJNZBVFZ78VjKKux/m
 OM3ieEMBHC5Ep3fGT9NmuOoj1R/rnQ70vRU28gErZKahC1j2rmWbXk3NVVFPzpWFbjz19NfJoVV
 6YFACPk5+tVggvEiPNXNVLEyZYyk3ahL3S47muwYXubvOZvuCqfj7
X-Received: by 2002:a05:600c:1389:b0:421:2049:5d66 with SMTP id
 5b1f17b1804b1-42120495e3amr31308235e9.21.1716988522432; 
 Wed, 29 May 2024 06:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa2XMSK8X38xqAPHeSDlUm2AqxMYOaMvupPRv/Z07AKUsy02rrt/p2Be6Z6/GvNnXlKBd58w==
X-Received: by 2002:a05:600c:1389:b0:421:2049:5d66 with SMTP id
 5b1f17b1804b1-42120495e3amr31308005e9.21.1716988522027; 
 Wed, 29 May 2024 06:15:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm212637975e9.7.2024.05.29.06.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 06:15:21 -0700 (PDT)
Date: Wed, 29 May 2024 15:15:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 03/23] hw/usb/hcd-xhci: Remove
 XHCI_FLAG_FORCE_PCIE_ENDCAP flag
Message-ID: <20240529151520.17a901f9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-4-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

On Wed, 29 May 2024 07:15:19 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> XHCI_FLAG_FORCE_PCIE_ENDCAP was only used by the
> pc-i440fx-2.0 machine, which got removed. Remove it
> and simplify usb_xhci_pci_realize().
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/usb/hcd-xhci.h     | 1 -
>  hw/usb/hcd-xhci-nec.c | 2 --
>  hw/usb/hcd-xhci-pci.c | 3 +--
>  3 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 98f598382a..1efa4858fb 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -37,7 +37,6 @@ typedef struct XHCIEPContext XHCIEPContext;
> =20
>  enum xhci_flags {
>      XHCI_FLAG_SS_FIRST =3D 1,
> -    XHCI_FLAG_FORCE_PCIE_ENDCAP,
>      XHCI_FLAG_ENABLE_STREAMS,
>  };
> =20
> diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> index 328e5bfe7c..5d5b069cf9 100644
> --- a/hw/usb/hcd-xhci-nec.c
> +++ b/hw/usb/hcd-xhci-nec.c
> @@ -43,8 +43,6 @@ static Property nec_xhci_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO=
),
>      DEFINE_PROP_BIT("superspeed-ports-first", XHCINecState, flags,
>                      XHCI_FLAG_SS_FIRST, true),
> -    DEFINE_PROP_BIT("force-pcie-endcap", XHCINecState, flags,
> -                    XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
>      DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
>      DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index 4423983308..cbad96f393 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -148,8 +148,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *de=
v, Error **errp)
>                       PCI_BASE_ADDRESS_MEM_TYPE_64,
>                       &s->xhci.mem);
> =20
> -    if (pci_bus_is_express(pci_get_bus(dev)) ||
> -        xhci_get_flag(&s->xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
> +    if (pci_bus_is_express(pci_get_bus(dev))) {
>          ret =3D pcie_endpoint_cap_init(dev, 0xa0);
>          assert(ret > 0);
>      }


