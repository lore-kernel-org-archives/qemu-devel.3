Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45456C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNDe-0005Kl-F1; Thu, 16 Jan 2025 05:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tYNDd-0005KP-8n
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tYNDb-0004PZ-Qp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737023718;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cRrHP5TPLKIZuQiVEHK9KguHylbHeuXYk0j0aKCdvg=;
 b=Dw480J1baAKYtOEwnnwQ2h/ah0wIWBO/Gxdrqda2nRbZKGSQegb40UQ35zU0MYZfjQjZY/
 CGmRvEegE2uZ+IpVWW+Se+ZCrSAWRiig0ztcTRi4lHDtlKVS/VHZ8QpLuHcowrzAIOo0W4
 helInQRH3jO2KMUN9RJT1e2KDDgf6No=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-iu0Sc-MGP6qxSYzwFavdSQ-1; Thu, 16 Jan 2025 05:35:16 -0500
X-MC-Unique: iu0Sc-MGP6qxSYzwFavdSQ-1
X-Mimecast-MFC-AGG-ID: iu0Sc-MGP6qxSYzwFavdSQ
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-468f6f2f57aso10039261cf.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 02:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737023716; x=1737628516;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7cRrHP5TPLKIZuQiVEHK9KguHylbHeuXYk0j0aKCdvg=;
 b=FTWB4zLxIR3OkSl7N3Ui5L1kwR454vFIUqHt9DRffP4I1N6buyF6AXFO4nLPCRUNfo
 LGBFyfPnKtppfKHjTlxL9wXJLCfIbEoU2ybQe+WZBcrxCSrH3tpt1zFGQFQJ77/5fw7Y
 yehWmO7FN4SZUKHWtb3rajNBae56d34R/LEsbgpDMdTeTx2fJLsXLoF3+OpBMUxN6/c1
 9DPBzRs2LXjL35+ndL8Cf7A3GjmocQHBzADHQtbMiM82d5h5jA5RfJSiR2Y9crqLzMqK
 Rm+TSxL13Shu8BkIpqP4z4PIvn+ORdjp7lZTUQNF/E5wf+j1nDnCp+8olI5kYb4U/b/3
 XwGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xfX5RwkXVgTDgS/t6twjCoXX9z/l1xbQ29q+vaGC22+cr1im2Ovik356WHx+el4yZiWHAs6V1UIK@nongnu.org
X-Gm-Message-State: AOJu0YxKs93c55acG1gHsoSnscoRqpjncIRaoHjyi5SCAjsfbpV2ZZXN
 5f8SlkAT4LJGLflyd1gVtzGGI2ePpEpiCZYXxAGXCoP94y6O7uyXMEj1JnQCEyhsrBzyKAYAxEH
 v1HAOxKC2qtw/p8zDYDEUKfRZIPuuUwXuevWXduiIGUtlIhuMnNa+
X-Gm-Gg: ASbGncvFlxJCE2+c9QX7N2mUxeIhafLv7G/LcvFex5WrukLsXf0zQaNzjYsCvLCcWc3
 KSlJ7zaEEG5phnMld8VYJOMjzq/23SFJRhjlvwUL3jSTZHiZQ+ll6nucJEBMFfC2QIwcu2jM0YB
 fQPaY4XnholzePeCCJEHAE1BrZHolM7cSnCibOgOiAZ/qUqS9yAneFq25yuChM5CQfVtsrNBqUf
 YlFPjv+LP3qWQsX034c92dXFT7f+fOXHP60oGaHFgN6GEtJopx+BCS79CQMXy8dIfsqRLrnz410
 ntk7Yim/PQpu848bY8Z2YnYMLsNu
X-Received: by 2002:ac8:5989:0:b0:467:86a9:f7d4 with SMTP id
 d75a77b69052e-46c7108eba6mr435951261cf.16.1737023715964; 
 Thu, 16 Jan 2025 02:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjCpGqWt39TbBi/vCw+G/ef3qbb1qj6oEeDgv72yUw7ad5Vr/EMM6CPEBa+miQf8yZP7uj6g==
X-Received: by 2002:ac8:5989:0:b0:467:86a9:f7d4 with SMTP id
 d75a77b69052e-46c7108eba6mr435950881cf.16.1737023715595; 
 Thu, 16 Jan 2025 02:35:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873dbf16sm74159781cf.67.2025.01.16.02.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 02:35:14 -0800 (PST)
Message-ID: <0fb13dcd-3b0f-48b2-9b8b-b829053bb74d@redhat.com>
Date: Thu, 16 Jan 2025 11:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250116102307.260849-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250116102307.260849-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 1/16/25 11:23 AM, Zhenzhong Duan wrote:
> When iommufd_cdev_ram_block_discard_disable() fails for whatever reason,
> errp should be set or else SIGSEV is triggered in vfio_realize() when
> error_prepend() is called.
>
> By this chance, use the same error message for both legacy and iommufd
> backend.
>
> Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/iommufd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3490a8f1eb..df61edffc0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -515,8 +515,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>          } else {
>              ret = iommufd_cdev_ram_block_discard_disable(true);
>              if (ret) {
> -                error_setg(errp,
> -                              "Cannot set discarding of RAM broken (%d)", ret);
> +                error_setg_errno(errp, -ret,
> +                                 "Cannot set discarding of RAM broken");
>                  goto err_discard_disable;
>              }
>              goto found_container;
> @@ -544,6 +544,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>  
>      ret = iommufd_cdev_ram_block_discard_disable(true);
>      if (ret) {
> +        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
>          goto err_discard_disable;
>      }
>  
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric


