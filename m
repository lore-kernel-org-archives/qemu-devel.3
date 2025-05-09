Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1734C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPoC-0005Sl-Rd; Fri, 09 May 2025 11:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPo9-0005Rs-Qi
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPo6-0001CJ-3R
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746805117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nacOks2riggVWBsNA+mzbNQsW0rVzzTbedwggtXVT54=;
 b=R0zSpsHrMzU6jkuWCozproO9X7gVrBl1ekZEObgTn5Gr4qCw/GAjXbOU54gmS8JrS7MzeO
 xxeCsg8KMa4K5eLBw+RQvsDYy1hnLHD3qOYd1Ra03l469hRJDjN2KsieSHkpFYWFkKPo5B
 2eowud7EEbbmZXfD0CkcjJys+Mf8iRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-ea83MnB4Nz2HeeVO3Gy2FQ-1; Fri, 09 May 2025 11:38:35 -0400
X-MC-Unique: ea83MnB4Nz2HeeVO3Gy2FQ-1
X-Mimecast-MFC-AGG-ID: ea83MnB4Nz2HeeVO3Gy2FQ_1746805114
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442dc702850so10015e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805114; x=1747409914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nacOks2riggVWBsNA+mzbNQsW0rVzzTbedwggtXVT54=;
 b=qbyO3RARbTPmT1BhN4SChZXQmrPDl/Q+SXxh5ZYsGIWDePrjg0SQS1j2ATowF5MN8k
 4UlI8wQ77/sHRULf3zfljJzetCyCZ49ndtyD7weWs0bFPdDG961ZxTzjcscmVvan54Ct
 4Y5kfOV2PfSaMbBqRI8t1NqgnFQFGOjjFuZAeNXOOIemqBol0RVT6Aj8fKssGXRycuZ6
 QZoeHbYgQ9VUI+vncaD3X3wwhxJmjt1KTkayDkZjbiF3cLAEPX3b7JBhsn5BuwaRgK2O
 WMEgqajbVyZxc30kKPDdf6UEU9FhJo8sfdx29VhSatMqzUY/JAXE/zp+4NVyNarHbEhO
 ZzYw==
X-Gm-Message-State: AOJu0YxNaTJ4d03Fiva6i1Wd/olXHQ2YhcMg9AgpDX89QRoBUgBqbgKT
 PNGIV3ryER2/bzKC6Z/1nK88GTRh8DoO+JMm+rnu1rvYMh4sBHNq6xJ2/zb/+MyPaYNy9Iz2ikK
 qWef5kDpTopLryjL61ONiOYCatqrdOcxDoPBGlmnwkiMtUPDg4lyU
X-Gm-Gg: ASbGncvWpPIU0oFoC1xsQOXQjl0WZfbRqN7+8ourpd1jyqzSFMfR9Rzq2edb/jdsnGd
 r/i2p6Zhc0yOoSS0sb097GhiVMWSrpZ7iZKkmTF+9AGMUpMYGxI46qR2S4KP0G8OjhPcvSX0Y3k
 1zJZ9RwvwMbzgRYp2RnzSZ6D8CHOw+DMmcpCXw09l1j3leanGfcKasIGeosR8wD2hIH5duVMVhI
 +c9Civ9JUpYiEnrnj3WyCbQWk12RlXdYe2cbBKarOp1j0+++1v3POGAls24k2xR09X0oYvfPvRo
 6Ipl3jGWaNNxmN9iqjkmCuKMnqDgK2NF
X-Received: by 2002:a05:600c:1da8:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-442d6d1f997mr36589135e9.9.1746805114263; 
 Fri, 09 May 2025 08:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBEcV+/MRGEimFQAdvMHfUPN89iu355oNKXju8PihTLwzByIgEtqzNodbo9ktiTe49ZmDRCg==
X-Received: by 2002:a05:600c:1da8:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-442d6d1f997mr36588685e9.9.1746805113892; 
 Fri, 09 May 2025 08:38:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bc2esm75445085e9.20.2025.05.09.08.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:38:33 -0700 (PDT)
Date: Fri, 9 May 2025 17:38:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 05/27] hw/nvram/fw_cfg: Factor
 fw_cfg_init_mem_internal() out
Message-ID: <20250509173830.65d0fde7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-6-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-6-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  8 May 2025 15:35:28 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Factor fw_cfg_init_mem_internal() out of fw_cfg_init_mem_wide().
> In fw_cfg_init_mem_wide(), assert DMA arguments are provided.
> Callers without DMA have to use the fw_cfg_init_mem() helper.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/nvram/fw_cfg.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 10f8f8db86f..4067324fb09 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1053,9 +1053,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uin=
t32_t dma_iobase,
>      return s;
>  }
> =20
> -FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> -                                 hwaddr data_addr, uint32_t data_width,
> -                                 hwaddr dma_addr, AddressSpace *dma_as)
> +static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
> +                                            hwaddr data_addr, uint32_t d=
ata_width,
> +                                            hwaddr dma_addr, AddressSpac=
e *dma_as)
>  {
>      DeviceState *dev;
>      SysBusDevice *sbd;
> @@ -1087,10 +1087,19 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>      return s;
>  }
> =20
> +FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> +                                 hwaddr data_addr, uint32_t data_width,
> +                                 hwaddr dma_addr, AddressSpace *dma_as)
> +{
> +    assert(dma_addr && dma_as);
> +    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr,
> +                                    dma_addr, dma_as);
> +}
> +
>  FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
>                                    unsigned data_width)
>  {
> -    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL=
);
> +    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width, 0, =
NULL);
>  }
> =20
> =20


