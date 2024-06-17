Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0DCC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEGQ-0000hX-Kg; Mon, 17 Jun 2024 11:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEGP-0000e5-18
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEGN-0006zz-Gg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718638037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B75N52/Zuz5zvoVADxuka7xygfObk/zfNnVRPqPyskk=;
 b=aNlDZxj9Tv8vnWmHhvcXgJX1SDB2TymzLKl6IPKoNIisemyuaGdr9IrXc1j5SF1ekRFCxO
 yy7zAWmORqLkHlI1sZXIPG3MsdyrbAEkq8wkxWGQzphCyzbknI4jFEqO80OWdUu21FPdu4
 YVpSqfNxJmbG9LwroEraoeOb6Sh3TA4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-EQZx_6opNWOLbThMAzNgxQ-1; Mon, 17 Jun 2024 11:27:15 -0400
X-MC-Unique: EQZx_6opNWOLbThMAzNgxQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4404d05602eso52307171cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638035; x=1719242835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B75N52/Zuz5zvoVADxuka7xygfObk/zfNnVRPqPyskk=;
 b=nKY2Lnb/BITQeDzk7G0uP8xiI4RKUGYEn6GQQxixBX4tHlxHK5J1GHEcoQviOI1WN+
 Gi/4o8slZVIjPdDxJPhJheDSHQba7Z9M1SIWs9n11I0l36PycUoaeRFlrSZnvWt+qS7S
 QSLylO2q/WNDgYUUEpHgCIrz6VRR8iAsFSOTT8J7Fhmo4irbDgq9tmiTUK2AwownmGmi
 /p+5boOAlPDbT0RA6iknjVmDwAY3O0VjWa2aNabHMXX/31OGf0Ld6ouDENvuFNyvFmBj
 jrOmAAG16qATx/GC+HtnR/LJaVBMvc6FDoVFZl63u+eo7SWVhhBfn1f+WjTrIqfJ1xgn
 1Xyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwyAqZvjvC+rUQxG/uFVcVKQT6qBOboNApOmuci9M6afcwliXaYFiL26pGRD5GdWSsFe7ouP7mqQqgY3F+rljVh+37bs0=
X-Gm-Message-State: AOJu0YxuCjcwVQ8Q8q/FEvUBFXNmsc7qM5onES0b7wJudnCbEE+m+n59
 60pMBjpWD4Rm1MQ5EH/IaozqpiGxVxzxfQeER6ySL91uHXa5wOeFQ8Ufb+d8wSAaqBtp1bYOWhR
 gV+TljRgBJB7ydMRaXUKPoe26gAD8gm2F+Yb95pKl1GQUy1SoCMu/
X-Received: by 2002:a05:622a:20f:b0:440:f54d:1bb3 with SMTP id
 d75a77b69052e-442168bf216mr77561811cf.23.1718638034513; 
 Mon, 17 Jun 2024 08:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkZlV/v3GQdiq3frxfgOcquyCCGGTlDbNTY9R/OVBUuf/mOx5Ls5w7pM4nJr5j/MRyrknY/Q==
X-Received: by 2002:a05:622a:20f:b0:440:f54d:1bb3 with SMTP id
 d75a77b69052e-442168bf216mr77561681cf.23.1718638034130; 
 Mon, 17 Jun 2024 08:27:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d89c7sm47256291cf.20.2024.06.17.08.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:27:13 -0700 (PDT)
Message-ID: <da52879f-62b6-438e-9cb1-b74466d80fbb@redhat.com>
Date: Mon, 17 Jun 2024 17:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/17] vfio/container: Introduce an instance_init()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-14-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-14-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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



On 6/17/24 08:34, Cédric Le Goater wrote:
> This allows us to move the initialization code from vfio_container_init(),
> which we will soon remove.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/container-base.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 98c15e174dd78df5146ee83c05c98f3ea9c1e52c..3858f5ab1d68e897f9013161d7c5c20c0553029d 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -75,12 +75,6 @@ void vfio_container_init(VFIOContainerBase *bcontainer,
>                           const VFIOIOMMUClass *ops)
>  {
>      bcontainer->ops = ops;
> -    bcontainer->error = NULL;
> -    bcontainer->dirty_pages_supported = false;
> -    bcontainer->dma_max_mappings = 0;
> -    bcontainer->iova_ranges = NULL;
> -    QLIST_INIT(&bcontainer->giommu_list);
> -    QLIST_INIT(&bcontainer->vrdl_list);
>  }
>  
>  void vfio_container_destroy(VFIOContainerBase *bcontainer)
> @@ -99,10 +93,23 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
>      g_list_free_full(bcontainer->iova_ranges, g_free);
>  }
>  
> +static void vfio_container_instance_init(Object *obj)
> +{
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
> +
> +    bcontainer->error = NULL;
> +    bcontainer->dirty_pages_supported = false;
> +    bcontainer->dma_max_mappings = 0;
> +    bcontainer->iova_ranges = NULL;
> +    QLIST_INIT(&bcontainer->giommu_list);
> +    QLIST_INIT(&bcontainer->vrdl_list);
> +}
> +
>  static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU,
>          .parent = TYPE_OBJECT,
> +        .instance_init = vfio_container_instance_init,
>          .instance_size = sizeof(VFIOContainerBase),
>          .class_size = sizeof(VFIOIOMMUClass),
>          .abstract = true,


