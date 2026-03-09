Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C961DEFCD99
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzYIl-0006T2-G9; Mon, 09 Mar 2026 06:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzYIg-0006SL-Uf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzYIf-0001fI-0i
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773053843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzWMi2bEgKrncJO3lTfiEM+qGAZYh6Eg7WNZJq+9DzU=;
 b=IV+DyOISWdzouiryNr2oZvDDiC9E6q8S6k8WhYryr6uxzFrsz3M1KVa0UhHSa3oyTO0ZQ6
 DPJSeOBfNHs/qk3xM+LRxnTO3/B8bIDZ9jYRw7Jd6mdT6Y0xbXEOg5GZkMidx3HIwJ6Ic5
 76F1ZGbIF5NlB/AQ+GLjCqJKYHRd0p8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-CCleJcmDPMO3FAM0yVzkcA-1; Mon, 09 Mar 2026 06:57:22 -0400
X-MC-Unique: CCleJcmDPMO3FAM0yVzkcA-1
X-Mimecast-MFC-AGG-ID: CCleJcmDPMO3FAM0yVzkcA_1773053841
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439da07c5bfso2402896f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 03:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053841; x=1773658641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzWMi2bEgKrncJO3lTfiEM+qGAZYh6Eg7WNZJq+9DzU=;
 b=Q+ehlADr6Uin73g5id+lwY54YxyvVW6pSFwtqoC699N9vMe6Du6P/1kGN6FPeUm8Iq
 ah4kxDaCkUDn9yzNa7yCm7Xg1meQEqCdlukZIepU+otrhXLveNqcDnIyJeX1ZICJQ72T
 dQ9M+K3Lb4OYBOQmjsQvItYXhXvNsVuQY661MB7siLGK3+YdanCBDnWrFUuAfwmUGpNT
 rny+/AfR3yFvUWf80THjPK3SBz7pPwYxLM+IDc0E/QPZHpI6d7KrX9rZzNNe8GVUvMj8
 hnASKiNqx502AED3u0W5EnXwLBp3rGguRqF69aO21msLe3SJc9nm648EgaI+H/BPG7Dm
 aajA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGeC8ortqun6+iP2+iHLj+fzR1lxgYZaq146ocPP5ZFadH5leDAr2JCSs3VOzYBcKL3Id36A/dlnP7@nongnu.org
X-Gm-Message-State: AOJu0Yx+wYfaOLmj3BCue2pvxlZUdXM06TCGOKwxPSk795UpMKmFz7CE
 ukRwqbPXpaljNfj7olqz4GbEIWKJz41euKGJGFy8JDsH9A/lAdwWWMyFggd7rmNmjHUEDrtUSaI
 Y9nnF7TxLn0L3U/ckbKbPh1vCev4pWBlyLA7j60zOsQ0Q6MWvdyc7Nao/
X-Gm-Gg: ATEYQzz12TM72fp4w2OsqQuTpCtPO3vgwjACWR9aRUZG/82b5rNl/i1m2XPZ+CSmoAW
 xFDi8705qK2OxuRj64GgchRBJoNkQAG06OvxlCTClkunmFcccBEaBA1VlOSmklNyJHgydsjUhGo
 iIHRUvhioQgr2dR1G2ey7VVJiam/MDCQyZg68fjZ/nLjUTZHGmJyHbwA0Q+pcIALq5Bc3ahBF0t
 SNbTKEUtuXeDJPrM4hkHgAQ7CCdPRpbUTvUUkKBVm8cau8z3bUr119Hcf7uNHjBmS3Hwn7QzAZ8
 ieO2av/fBK1iccql3D+CHFySrh+tiyzMsyNnC5LjpgqJKzOZf2xp0BPNivVvwU6AGcYNcL1T2Mu
 aXJHjm4UlBhIQqdzstnX1lbzs1KhN8mGmyfezB9viPhsC3m9u2pUwElmx7IikP8kx4BQpcQ==
X-Received: by 2002:a05:6000:2003:b0:439:a72e:bb1f with SMTP id
 ffacd0b85a97d-439da683f72mr17807301f8f.50.1773053840990; 
 Mon, 09 Mar 2026 03:57:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2003:b0:439:a72e:bb1f with SMTP id
 ffacd0b85a97d-439da683f72mr17807253f8f.50.1773053840533; 
 Mon, 09 Mar 2026 03:57:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8dbb3sm23079670f8f.4.2026.03.09.03.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 03:57:19 -0700 (PDT)
Message-ID: <fe7b9b8e-3f4d-49bb-9edd-a68136075e40@redhat.com>
Date: Mon, 9 Mar 2026 11:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/32] hw/arm/virt: Link SMMUv3 CMDQV resources to
 platform bus
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-13-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-13-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> SMMUv3 devices with acceleration may enable CMDQV extensions
> after device realize. In that case, additional MMIO regions and
> IRQ lines may be registered but not yet mapped to the platform bus.
>
> Ensure SMMUv3 device resources are linked to the platform bus
> during machine_done().
>
> This is safe to do unconditionally since the platform bus helpers
> skip resources that are already mapped.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/virt.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 292e523664..c75a8d6e9e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1833,6 +1833,24 @@ static void virt_build_smbios(VirtMachineState *vms)
>      }
>  }
>  
> +/*
> + * SMMUv3 devices with acceleration may enable CMDQV extensions
> + * after device realize. In that case, additional MMIO regions and
> + * IRQ lines may be registered but not yet mapped to the platform bus.
> + *
> + * Ensure all resources are linked to the platform bus before final
> + * machine setup.
> + */
> +
> +static void virt_smmuv3_dev_link_cmdqv(VirtMachineState *vms)
> +{
> +    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
> +        DeviceState *dev = g_ptr_array_index(vms->smmuv3_devices, i);
need extra line
> +        platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
> +                                 SYS_BUS_DEVICE(dev));
> +    }
> +}
> +
>  static
>  void virt_machine_done(Notifier *notifier, void *data)
>  {
> @@ -1849,6 +1867,9 @@ void virt_machine_done(Notifier *notifier, void *data)
>      if (vms->cxl_devices_state.is_enabled) {
>          cxl_fmws_link_targets(&error_fatal);
>      }
> +
> +    virt_smmuv3_dev_link_cmdqv(vms);
> +
>      /*
>       * If the user provided a dtb, we assume the dynamic sysbus nodes
>       * already are integrated there. This corresponds to a use case where
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


