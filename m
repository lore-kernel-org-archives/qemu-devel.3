Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCFBC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8bE-00060c-OS; Mon, 03 Jun 2024 10:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE8bC-0005sE-Sw
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE8bB-0003Go-6s
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717424624;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4dOFUGvuWUT6GfEY9yJdHEE3meFeaBpFGLzxbYoJA4=;
 b=jCDI+l8YZCPwHpUG4rhslg+He7E8A7b4kKAbji+A0zjD3x1Xq7uuMoFTBbAQSMGzPFGflu
 lx0+S7PZWKjmJDz0K2cpTB608SwGd8hQem890BbVDR0UO44DKfPJFdjOloBp+fgoH5wYCD
 n1yNjR6Myjj6lg2+hRux7plaj6mF7nE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-vsfcmJbiNfupUUxQuWIGCQ-1; Mon, 03 Jun 2024 10:23:42 -0400
X-MC-Unique: vsfcmJbiNfupUUxQuWIGCQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35e0f8bcc3cso1648665f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717424622; x=1718029422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4dOFUGvuWUT6GfEY9yJdHEE3meFeaBpFGLzxbYoJA4=;
 b=KDaLchbAngiiHbvDs2fSZMx612qKfdd6TPB8tuGSRxEIerDjn3nBha8lz8U1Roa7+J
 bJgHjNeLZCxAOivrkoOdg8FDRfPGcrBf563VtveGI/ERIBPDKLSWq8Mre61yxZwH+yfh
 iGGdDTvqj9JEw4D0S/B4iR4qg7dhGjQ9kb9GkurmhOW1SttIfD1P1T1uL7qqc4jJZY+L
 OXucB5c7JDwydsW2XOFNzNSHcNH4o6vhVHU1GD2tdlMSY1TOHesLM1mCNwcLBVsXZN85
 nQyhlLjSdgeKpFZ3WwDNDDoS4GU04tXq0k1AjDBLiKSUpCwu6Z3nlHGmrHQfbyrDT/Xd
 H/TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJSHbwuXB45UKyvA324xvAWK+mQ/n6efjRAuPI3kmxjdMMV9HII2t7egt8fpzeA8paD3Bx07sy9lJ8tgrKw0tg2x211bA=
X-Gm-Message-State: AOJu0YxKx91Pt4RS+LKDgzyaEpVRC9wLoW9G33LOfR/YIpi31PljVIKJ
 tvoWgIgjYwez1GAR4cJizAMLrmR7VgJdp83pZOSFKP3NHu9qIALJyzJoD59PAzihrhmmDkQxB2q
 FekdCE0o8P64UDCDGk1379RrgWKDes/dv+bLVeE+TZS6li/5Dx7/M
X-Received: by 2002:a5d:6d05:0:b0:354:fbb6:1b16 with SMTP id
 ffacd0b85a97d-35e0f30a906mr8973382f8f.52.1717424621805; 
 Mon, 03 Jun 2024 07:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNgZyzg4Vrawz/lVNivWG/YU165NivQhUTt1Ba51w9/Or6Ji7NbMNU3PGwWZc/o3/dH2IyVw==
X-Received: by 2002:a5d:6d05:0:b0:354:fbb6:1b16 with SMTP id
 ffacd0b85a97d-35e0f30a906mr8973350f8f.52.1717424621409; 
 Mon, 03 Jun 2024 07:23:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e57474921sm3922411f8f.80.2024.06.03.07.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:23:41 -0700 (PDT)
Message-ID: <0d612695-09ed-4ef1-8994-4091803779fb@redhat.com>
Date: Mon, 3 Jun 2024 16:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-20-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/3/24 08:10, Zhenzhong Duan wrote:
> If check fails, host device (either VFIO or VDPA device) is not
> compatible with current vIOMMU config and should not be passed to
> guest.
>
> Only aw_bits is checked for now, we don't care other capabilities
we don't care about other caps
> before scalable modern mode is introduced.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 747c988bc4..d8202a77dd 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3819,6 +3819,30 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> +static bool vtd_check_hdev(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +                           Error **errp)
> +{
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    int ret;
> +
> +    if (!hiodc->get_cap) {
> +        error_setg(errp, ".get_cap() not implemented");
> +        return false;
> +    }
> +
> +    /* Common checks */
> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
> +    if (ret < 0) {
> +        return false;
> +    }
> +    if (s->aw_bits > ret) {
> +        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                       HostIOMMUDevice *hiod, Error **errp)
>  {
> @@ -3842,6 +3866,11 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          return false;
>      }
>  
> +    if (!vtd_check_hdev(s, hiod, errp)) {
> +        vtd_iommu_unlock(s);
> +        return false;
> +    }
> +
>      vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
>      vtd_hdev->bus = bus;
>      vtd_hdev->devfn = (uint8_t)devfn;
Eric


