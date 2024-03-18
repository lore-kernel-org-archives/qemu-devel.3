Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4589C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDyI-0003Xz-9Q; Mon, 18 Mar 2024 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDyC-0003W7-Ck
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDy7-0001mC-Tu
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710772082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eB+TbMW7Irvz7hKTC16oT//XnPoSt6ghTnGVhEFLUBc=;
 b=WwMCl0qFJHPiubPw62S04CF/ztDPsI+0RWAQvC/t6ayY0BbFiSPa95bGsvETCadr3Z4uIV
 iMXEuGl/y4XsAF2vNZHeg0bj9luvD4nLhMIbB3q+FuoKDtnhJlqSKDa2nd0j+M4f6oFJi+
 pz5G5rdbRYO9b14MECqZUlM1ix/PF6c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-lmlauYQyPYeoo1AX8Uf_LQ-1; Mon, 18 Mar 2024 10:27:59 -0400
X-MC-Unique: lmlauYQyPYeoo1AX8Uf_LQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-789d981ae87so564939985a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710772079; x=1711376879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eB+TbMW7Irvz7hKTC16oT//XnPoSt6ghTnGVhEFLUBc=;
 b=v0D91tVAEIMEFDFZouqNByZJQpSgzezWxYJlDmlTnJtdKcvYCfDM+j4jUu2+8jeH91
 z9Epef1JbKJbBlnG01tew7LYwHS0almsM+CjeGXKMC2P7PwBQ7hSy2uN+qjBNha2k+br
 xKgh3frcxzNZrDfSLgNx1eQMHEICLPp5QkExyvodiqYvMnAKWqWEnrtvracvW+dVDjuI
 gSPgNLk7NZAnMh3OiW8knlsT1zaz+b8ocz5ui3KB6XL+9EFW6CbTnyV4X0I4lP65Cfwg
 yQ1l18SmfQ01ge9Iif7hLH5uxbV7WDTLymuD+GUQ2O1/sFmAflB8miaYR1Jg/UQcu0Vz
 6RjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4DfCttgKuSiUGf3wzORmwmJfS7jt7agCx11c1O9YQLObUtRuJlloXRoPRmBLj2/IxR0wUNCMP/rpCFZKHfNBSBbfk82o=
X-Gm-Message-State: AOJu0Yw3QbBe2ulxO7civRyQuP6UjfCha40fu6uoFpNRveOnMMKAX5zM
 OiPu3bfnqeQ8gYJiVHJF14uJP3TGTHBNAsoENdpcH/H3b2Q+PDzUMRMbeRf8/CRDSVZiJ2aMydo
 UUeU3UOzo4mdtjyghn+g5UEdpOpQKSi7OuAsVBCfQNyOxePKIRfj8
X-Received: by 2002:a05:620a:1a24:b0:78a:ef:fcb8 with SMTP id
 bk36-20020a05620a1a2400b0078a00effcb8mr4190329qkb.67.1710772079235; 
 Mon, 18 Mar 2024 07:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBlw75w6oGcD83rrds1VHg6R4fvRdGJs9w2NNyF/cNG3qCe+uLpdq36GEX0tuK+58qzzpdvA==
X-Received: by 2002:a05:620a:1a24:b0:78a:ef:fcb8 with SMTP id
 bk36-20020a05620a1a2400b0078a00effcb8mr4190299qkb.67.1710772078977; 
 Mon, 18 Mar 2024 07:27:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 pi20-20020a05620a379400b00788406f9c7dsm4595947qkn.101.2024.03.18.07.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:27:58 -0700 (PDT)
Message-ID: <750d1d70-37cd-4e00-a092-204f0dbbe61c@redhat.com>
Date: Mon, 18 Mar 2024 15:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/11] vfio/pci: Allocate and initialize
 HostIOMMUDevice after attachment
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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



On 2/28/24 04:58, Zhenzhong Duan wrote:
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa387f043..6cc7de5d10 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3006,6 +3006,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> +    /* Allocate and initialize HostIOMMUDevice after attachment succeed */
after successful attachment?
> +    host_iommu_device_create(vbasedev);
> +
you shall free on error: as well

Eric
>      vfio_populate_device(vdev, &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -3244,6 +3247,7 @@ static void vfio_instance_finalize(Object *obj)
>  
>      vfio_display_finalize(vdev);
>      vfio_bars_finalize(vdev);
> +    g_free(vdev->vbasedev.base_hdev);
>      g_free(vdev->emulated_config_bits);
>      g_free(vdev->rom);
>      /*


