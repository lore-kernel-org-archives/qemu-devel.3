Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE46BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5vv-0002Qi-Bq; Mon, 03 Jun 2024 07:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE5vs-0002Q6-RP
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE5vh-0001t2-0k
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717414364;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IddhYRwfNp0Iv6OVqlMM8dW7bdY2npUpHIFGUauKeoA=;
 b=ZFcndT5deiTM1nOMANKAdRfwwNwZ+v7sEa5RPxDyfgBnRWyG94WDevhW1Ja3ebGkLXMGzK
 7czVC5zhvTXPBXWatLOPvrTlpyXtZLSABNbZBT3oQYeBOZeki9340WVxVAmVX4y6r4XWyE
 CEaf6tsSi9qViscxVyyWKpJvQCoKvjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-TYMHOflDNEyaq2PcDRh4fw-1; Mon, 03 Jun 2024 07:32:43 -0400
X-MC-Unique: TYMHOflDNEyaq2PcDRh4fw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42120e123beso37561405e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414362; x=1718019162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IddhYRwfNp0Iv6OVqlMM8dW7bdY2npUpHIFGUauKeoA=;
 b=aSYPwSBb0itLEhI5qLT+KHJvADq/Nyszl3tiBvPRrrf/baHVb8VzLsF8rsLathX/BB
 1lNc0yKMcnNPLXPLhikOLwJPu8Nml1OvVKyUg9inuh9prXkug/qGHGUKGcj94ldJOknp
 RlL633VcLyL6fBE1kwUCMF2CGoEN5zoxFWPW57AaMG25BirQCr/uMQf30E8Dq9ktu0FV
 mbN30HeoOQ03gt59wKeHVRxhjmo75p+9njGjOZANbvD32SwfIJqGzica7IXqav5C+Mxd
 8exBbzom1Mt+NG+Wh7X9CkFackvFeHaIp0GHpe6wiKkPchsKDiwjGvqHEfvQIgmyQsV8
 JowQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeCMRWe1ZnO1kdYA+7bVE7V7ciIEkzpannlwOM1acI6T1RFaR0ji/wJMuEIo/x+JjNvum6KyoIXPRGt0Z/xuOEs0CTz2c=
X-Gm-Message-State: AOJu0Yzo7WBwEqAH+bwCka5nevXs5CPd7LlQu6+p+RTdip5ugfoXx/Al
 fZuR4WGGdbQ+BBJUgSndGWYofs8Wnx+toZ/2Z2T1VqzAP1fTgD8gnG4v7sJmFDxzKa9LHUsUVuX
 j8MbWW1DMisq4tV0bkb6bd0cVn/aAl1qEYBFDQEKne9GdkO7ZhqAe
X-Received: by 2002:a05:600c:4744:b0:421:2990:7f9b with SMTP id
 5b1f17b1804b1-4212e050597mr92771395e9.14.1717414361884; 
 Mon, 03 Jun 2024 04:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtqTdEYm3rApdycw42Nu4OrKrShGiDK3mZ+oVY+AHZ55KgaAFBBS678LScviNqVRlX7bOZBg==
X-Received: by 2002:a05:600c:4744:b0:421:2990:7f9b with SMTP id
 5b1f17b1804b1-4212e050597mr92771195e9.14.1717414361536; 
 Mon, 03 Jun 2024 04:32:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212f0f9660sm104391905e9.39.2024.06.03.04.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:32:41 -0700 (PDT)
Message-ID: <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
Date: Mon, 3 Jun 2024 13:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 6/3/24 08:10, Zhenzhong Duan wrote:
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  backends/iommufd.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index c7e969d6f7..f2f7a762a0 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -230,6 +230,28 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>      return true;
>  }
>  
> +static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    switch (cap) {
> +    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
> +        return caps->type;
> +    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> +        return caps->aw_bits;
> +    default:
> +        error_setg(errp, "Not support get cap %x", cap);
can't you add details about the faulting HostIOMMUDevice by tracing the
devid for instance?

I would rephrase the error message into No support for capability 0x%x

Eric
> +        return -EINVAL;
> +    }
> +}
> +
> +static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
> +{
> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hioc->get_cap = hiod_iommufd_get_cap;
> +};
> +
>  static const TypeInfo types[] = {
>      {
>          .name = TYPE_IOMMUFD_BACKEND,
> @@ -246,6 +268,7 @@ static const TypeInfo types[] = {
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>          .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .class_init = hiod_iommufd_class_init,
>          .abstract = true,
>      }
>  };


