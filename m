Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CEEC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDNP-0001gk-Eh; Mon, 18 Mar 2024 09:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDN7-0001e9-Ij
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDN2-0002Lm-Ua
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710769783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cA2NQ35D2N52uv049hiZv0mb5GFF7nd/kvH9k2tw/w=;
 b=bNvIaQts6+gN54G5Z8kv1SFbkDQkV1Tar5F5FsuUSmF0sl/VgWUqoq7nEffusCGbnhLXu1
 ApSeCTOxmMaXCM9g1z8ylSOOFJ6aLEOmKO3z5HQ3IVu8K+IJgueELjRG3fzVI3te3hVZwj
 eY2TYLFNqvK5/j2gzNFXvZ1cbJ8bCn0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-REIBwjV8P7WXn1G8_4M82g-1; Mon, 18 Mar 2024 09:49:41 -0400
X-MC-Unique: REIBwjV8P7WXn1G8_4M82g-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c388a9eae6so1261103b6e.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 06:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710769781; x=1711374581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cA2NQ35D2N52uv049hiZv0mb5GFF7nd/kvH9k2tw/w=;
 b=aiv2YqcLU6/STkVHd2hpzmXWIZyjw1fMpDlzyj/+lzM3j5I0vwTxNoprAH7HQFdBBB
 oG1y1R3ksNfO08l8vFhZ+FlzFSNVIe68QdCzsRDdy88ulGrWknl6wkUaxW0z9QKonnxx
 GdvSrb0SQ+4do+AxFZxaYKzDOpfR2dTtk0k3g8FXc+99oJxCk2/G2ElEaq1GoAe4tlU/
 1hgrd87W+r5XzXI+NCZrR2Nf7phLcCFs7yMkTBRiUmgiHE+57FQuGrxf3xs3uagu2oUp
 VQTvArJgSvZIzO8Q4vYmx4D/a7pgYEVHzyB032GgoKUa2dGBmsEHxx5XnJD19XVpakuc
 JImQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEDkgwE2nQpcgjVHYRDk51mAUa8kJn6kk3RObQZYNYcAy8RfA8K+xSdQ/S/SNtqR70jrVBRZ//xuZ38Q2djb3D9HYAlvs=
X-Gm-Message-State: AOJu0YxmcwbIN/eSog1gTL5w1u9L3pfllG0g5vb3xCaoWdqzKdSxWVv/
 Yrx12QZdQCN9gRu5xr/vyy3gV3kRp/BEEcbttJgvhIst2uWm9L+suyOzBqm8fst09mSa0VaDhSz
 bpCZfGtadZBEx1kaey11xSsKDm/FziJHJwy8NBHPuZq+A2MGIFrXo
X-Received: by 2002:a05:6808:1315:b0:3c3:80d9:77da with SMTP id
 y21-20020a056808131500b003c380d977damr8238018oiv.42.1710769781127; 
 Mon, 18 Mar 2024 06:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzvPBQBThEKEpZrI/dziaB9Sw8oq4HZP3WRfzDpxXoBFFL7ap6kss5C/gLieUJKFrmFlHZWQ==
X-Received: by 2002:a05:6808:1315:b0:3c3:80d9:77da with SMTP id
 y21-20020a056808131500b003c380d977damr8237998oiv.42.1710769780838; 
 Mon, 18 Mar 2024 06:49:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a05620a221a00b00788481cdf4csm4550731qkh.111.2024.03.18.06.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 06:49:39 -0700 (PDT)
Message-ID: <44415979-ca17-4f85-9092-aff2f50745b1@redhat.com>
Date: Mon, 18 Mar 2024 14:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] vfio: Add HostIOMMUDevice handle into VFIODevice
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
> This handle points to either IOMMULegacyDevice or IOMMUFDDevice variant,
> neither both.
I would reword into:
store an handle to the HostIOMMUDevice the VFIODevice is associated with
. Its actual nature depends on the backend in use (VFIO or IOMMUFD).

Thanks

Eric
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8bfb9cbe94..b6676c9f79 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -130,6 +130,7 @@ typedef struct VFIODevice {
>      OnOffAuto pre_copy_dirty_page_tracking;
>      bool dirty_pages_supported;
>      bool dirty_tracking;
> +    HostIOMMUDevice *base_hdev;
>      int devid;
>      IOMMUFDBackend *iommufd;
>  } VFIODevice;


