Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99266C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYVy-00070N-Sz; Mon, 10 Mar 2025 04:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYVx-000701-JU
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYVu-00064P-EB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741595369;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9IUHSXAtOcyBX6406ivSQAj3+/L2kwNFrYXokmmlkw=;
 b=UHqDqT6Yuw4l456vMUg9fQf7UJsOYraItR/R3erETQw5EwILATFJA0CViH+PZ0O0WgvIjQ
 hiWoXpS/dRoGH31pwjqSnfhNENpf0EkfDSCL7xdreRVdjjPHv1MC4T8dOWG+D7JEN1UZDP
 9dJqxb3wfUQtimcBUlLrpeUwW1RLaDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-aPievjI4Po-TBIPuDoC2rQ-1; Mon, 10 Mar 2025 04:29:28 -0400
X-MC-Unique: aPievjI4Po-TBIPuDoC2rQ-1
X-Mimecast-MFC-AGG-ID: aPievjI4Po-TBIPuDoC2rQ_1741595367
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so691096f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741595366; x=1742200166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9IUHSXAtOcyBX6406ivSQAj3+/L2kwNFrYXokmmlkw=;
 b=FwOlWfvGCHdMm+AmQCRnzh9UTT4099mu4T6ydmz+GYBvmYA+yaS2vbiHH3h3m8OsLf
 AL7DI6MMxBeOXOyLZmbyElUSMSc4jTYhJKTY8ioyfsGMW5gpeqDmXf3eCyt83d/sOpzX
 rsPIlY/AvKDCHfcUKpFMO2XNQwWCAxElAXamYLB17uyWnFdJUVYojk9xFDRGXfs1ev0K
 Ood15zL6H3DEmoeyAnk90TQ93J+H7qel+vFkD4mYMv8o1938bvvS4umpqRA14oH+fUsx
 j7w8senJtd9OC8pIXs5Ls5TJZip0BPJ0RGL+XBvKIzgo5x4zrf0KJUP2FKdBEX52XqJM
 54ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLb10uFVs4bVmuSBNJs1oShmrfmc5D8gep4vriyTMs4Qr0qz9ZSLRfJDJlP/LKxSwsPAbZSUOHL2Ha@nongnu.org
X-Gm-Message-State: AOJu0YzAsSJ4h4DNbtNECSObiTxY4ciRnX7T3jzxyisk7asn4gFOKy9f
 muRGlUdP0hHwxK2yOsIwsJ1qdciiE1Il6dfS1lO9ptSbFJYG7fpTm6Ib+nOZkjbZHGK0esxxqqq
 FLidJhiBk2w5Pp/Tcki5ZAwlOxHk8CE+d8z43EQI/KQclzQ+Yh3td9POdTIrD
X-Gm-Gg: ASbGncv+A65k0mc63DsJSp9FJHM4xp0PJ6Bp2SkwO/ZRqwULRSYEtYFw8KqgyZDjCxQ
 Xi6dHcHlT2l9rAQN102QHOETTYwaH3A6AQS4g7e3TVrQ4pLHJmNajSPkDGRp5VwYshEJUTlZtBS
 6VPnxPbSSYuTr3z4HOudfeM48vNnSdgDkkweQ+euN4qGtUZLY+18a2ODVSL7EeRnm7VAUh4bTJ/
 ZwDIcdF6RhGZ0iiW8sbAb6adlT6QEYH2+10T0O8PcXoycZm9DM7NU2/0DA9rcm+ZB9e3cJEacc5
 NDgbPrxjxhlbmpTV5g7v41jgVRO/XARTcnkQ9wtvGB/rU/Zi0hz5JZx53q5V6Eo=
X-Received: by 2002:a5d:6c66:0:b0:391:4763:2a with SMTP id
 ffacd0b85a97d-39147630139mr2479781f8f.47.1741595366694; 
 Mon, 10 Mar 2025 01:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNJntjpr3gMQ8m9M8Z5B8/nqI3UcZG0kOxTXkmBrWyewceDf0RpQnBesTDqtsAR+C/l5M/A==
X-Received: by 2002:a5d:6c66:0:b0:391:4763:2a with SMTP id
 ffacd0b85a97d-39147630139mr2479753f8f.47.1741595366332; 
 Mon, 10 Mar 2025 01:29:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f57sm14175885f8f.91.2025.03.10.01.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:29:25 -0700 (PDT)
Message-ID: <1671aad2-ab9e-4462-88c1-11389d299c76@redhat.com>
Date: Mon, 10 Mar 2025 09:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/21] hw/vfio: Compile display.c once
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
 <20250308230917.18907-8-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> display.c doesn't rely on target specific definitions,
> move it to system_ss[] to build it once.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
> ---
>  hw/vfio/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 5c9ec7e8971..a8939c83865 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -5,7 +5,6 @@ vfio_ss.add(files(
>  ))
>  vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>  vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> -  'display.c',
>    'pci-quirks.c',
>    'pci.c',
>  ))
> @@ -28,3 +27,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>  system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
>    'iommufd.c',
>  ))
> +system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> +  'display.c',
> +))


