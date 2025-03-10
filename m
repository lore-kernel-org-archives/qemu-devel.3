Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D4EC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYPw-0004Uj-DY; Mon, 10 Mar 2025 04:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYPt-0004Tg-AS
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYPp-0004nW-VH
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741594991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m83jpOl/EWHljK2jRZk5Ena/wZkPmU1eHW5FSSTGYDw=;
 b=WbljNxSjUT8tx/YX5lwjkh+Y6D+nlaEa5qtJf3Orj3Xgu0qh0a9jvZHLJJnaLNviM1iYMi
 E6J/ILf1tNkPQxCDfUCa2m2WiDSgxXohMjsbtMxPSv2hk+XejfknM7Mj5wUxzDa+Esk2KN
 zXHGlguU2+PAczdn5cW1q/8ZeaMT5wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-9GIhbc-FOqugT5yVRne7AQ-1; Mon, 10 Mar 2025 04:23:10 -0400
X-MC-Unique: 9GIhbc-FOqugT5yVRne7AQ-1
X-Mimecast-MFC-AGG-ID: 9GIhbc-FOqugT5yVRne7AQ_1741594989
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so7117295e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594989; x=1742199789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m83jpOl/EWHljK2jRZk5Ena/wZkPmU1eHW5FSSTGYDw=;
 b=pS4IJfE0UIcZlq5QoystDHhhLAjkDlGBK3csgkqp5xu+TDZy62DgvUWsSshJcZdsYQ
 W/sF8GA+i4xOjhwl1+aTTD8lvyDiOTodbjY6NwrXGzL/YTqx47VQzB/yrYhtoga698jS
 4VSKaX8V3z2mFgrWHPhhp+WG4I/GhapxJmMFzTHCJLkuKg25/rx9Oh9J0lsVaYX4aprx
 bjvA1ArYMdbzp1koeeggT6EHMuVxYH441KrSe+yhUUJKOUObxSxsPGlbtF0Ta9nSdAMY
 tJFnenKIP81lqYmryAyMGa7InRr3njVu5XeyfRygH0xFi/dku2MPd1XkfFQ4i84x+mu8
 /okw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrqrIffVggq7Y//huG+EKJJlnUnnU2a0nDAPkBB7QMuBqmS06zX3IXSDMj88NB/io1OXgPfjDLpOij@nongnu.org
X-Gm-Message-State: AOJu0YzjfieID8XFC3UHG5H0ZJZfvjUdd7JLITtnfQo91diwVC3m5erv
 eclo/CO8wh1cM/vfMl+ieGIewhR2+2UWaBhxRMgF9L559E/MMD3J0ZuU+pm0Xpju8h8bpWBf29g
 L/CCB3dhb/s2q+1QoM6+UilNX3NDGZACNQU0RKI3jP4U4qbvx33P3
X-Gm-Gg: ASbGnctIk5UVz8fmznQ+inqoVjtE2Um+7vN/zroIqQ8qZncMnNLhn+jHJb0XHBVukcQ
 d7jKUWrpC+GhZMKtNc0oidUJ9Tx0reUe817Q+rc2ljxc2auTQqcNZCrtQG3tAacNFyhLNSFZIKq
 89RmR2DITx18WsboJTt1Ua9m1H7W/gbL1LIETjuCciVa7xoxLKwd2esIwSS1q8hs0xubUKoVS7s
 k0jTQ5Du2cVbrJLjl1b7p55fhzsA59kaDPL8zoLJcSu/UhJJlMN+5gGG2Vj7TC319/qwdAB5WLt
 bKrLle2OGM3GEFL3ADX+GvUVUizOh6MFLJBZvQzpxBi1HKhDo014kaCbf153qeI=
X-Received: by 2002:a05:600c:5103:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-43c601cf53amr103539135e9.14.1741594988959; 
 Mon, 10 Mar 2025 01:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPYuDPxYvwsEdUAyUty/LvN9lj+wxRwyT8RvxMe+vpY6KYM+aaGBrQ+ugbdV06I0XimUBZxQ==
X-Received: by 2002:a05:600c:5103:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-43c601cf53amr103538705e9.14.1741594988461; 
 Mon, 10 Mar 2025 01:23:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3250sm14213927f8f.61.2025.03.10.01.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:23:07 -0700 (PDT)
Message-ID: <446a5657-9926-43f6-9592-adce2399e5a9@redhat.com>
Date: Mon, 10 Mar 2025 09:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] hw/vfio: Compile iommufd.c once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-6-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> Removing unused "exec/ram_addr.h" header allow to compile
> iommufd.c once for all targets.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/iommufd.c   | 1 -
>  hw/vfio/meson.build | 6 +++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index df61edffc08..42c8412bbf5 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,7 +25,6 @@
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
> -#include "exec/ram_addr.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 784eae4b559..5c9ec7e8971 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -4,9 +4,6 @@ vfio_ss.add(files(
>    'container.c',
>  ))
>  vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
> -vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
> -  'iommufd.c',
> -))
>  vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>    'display.c',
>    'pci-quirks.c',
> @@ -28,3 +25,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>    'migration-multifd.c',
>    'cpr.c',
>  ))
> +system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
> +  'iommufd.c',
> +))


