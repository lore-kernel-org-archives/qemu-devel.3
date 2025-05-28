Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436C4C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 07:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBfa-0000wr-Ap; Wed, 28 May 2025 03:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKBfU-0000wG-Hq
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKBfS-0002bx-CA
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748419054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R6LaWX7syv0whEJnfjjPjQSY8hZa7TjdC6oVKq3FDOA=;
 b=OuscsV+0NWjIQPPPvabyFBBpML7en8zMAKkTfh31pPeFyTw4tR3u5oIKdHPSDH7MupwyuU
 wq2A5IBtDNKABHPF/4fuIN2rYFhkgtDjHETIi7/nUgxB4V5mecd3wKz3931w4emMMf3G9A
 BqM6K/rBQhbABfLmbCbAxoWH87nnBxU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-wEZLKqXyMlSAoMGh071Anw-1; Wed, 28 May 2025 03:57:32 -0400
X-MC-Unique: wEZLKqXyMlSAoMGh071Anw-1
X-Mimecast-MFC-AGG-ID: wEZLKqXyMlSAoMGh071Anw_1748419052
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso418016866b.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 00:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748419051; x=1749023851;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6LaWX7syv0whEJnfjjPjQSY8hZa7TjdC6oVKq3FDOA=;
 b=S5+IgKK5r8/RIUh3+uJMIqxgyRAGowlF856JOlGWa+eIVJ8uVKdg4GTdynvg7fCa1r
 T+YnQaoqNVi9jjnE5KYZoNtxwsa7XACiEtu0JvsY1sNm/dE0Ghdqz38icLY9JTzIlhsi
 OwguSyjoCV/Z4hQ3KKvdXWpPdxt/DZFKFWVu2+u4ZkaItwUM/4Y+KrxVUw1IASPnARgQ
 iG0P3Tn+9tRkKOCDSQTaOjAVM916WceZhMNoCeY6q0Jx11pn7PBaU5yOE7wSMqUArRQP
 flqhnh1FSexqdGyD75I/Gp1tG0JE4ukBI5QHPGkHPnUR0y9XIKJERfZxTXZwUSbCeZ+i
 DVzw==
X-Gm-Message-State: AOJu0YzTakpmJl23M1/YgktobeAsJIGcCDaOEiaZMDrkN6IVRksLcamn
 dwPhGfP+sWYJwFc2g3muznPd/fv4g9ENdsUBWmWgnC5ckxr3CJAJYuhuODpYCg3NrqpLT5plZft
 1rfua2QRhNuA/EFUJN0mrVsgkkQaN043C74O3E5VvEoAPFAC39vb0arKN
X-Gm-Gg: ASbGncsqLd5rfWa5gj9QLEWXG9wMjz5BN4MvX98uMKNNZF0znZUeux1uW1G6KCONjwl
 rGUjGP0I3FxDJpkhxi3e9Vw0492qFi6zxDTAmeJl4NTavsKqnuPFXYExhTDOh8s/JfYYaRAwQ1u
 UR3eT3STh8ERKyOHEt1h4Y47KDCJGRkjaqC6F8CEiqhOzeavjF81QhQ1gheKBegpF//lQbnMMMJ
 yM2njZlIMnrCwReyTYJ/W0StsljnszbEWeBkrF/Zdh+XthqYRhZ2xYxJYj14OpdtOEqluUnDWsH
 k2UyAdgJeCvKrcOkqn1/FrgwIyU1ajZlAL6hhmBt04iT0iMfb9wc
X-Received: by 2002:a17:907:72ca:b0:ad8:91e4:a937 with SMTP id
 a640c23a62f3a-ad891e4ab46mr453180066b.57.1748419051545; 
 Wed, 28 May 2025 00:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErSqTdmDkBagqTgMSkDmR1O4rnngPzKRc2sGr8e9XlKNiYxctM6xEpIl2tOUrDTSHum6lvWg==
X-Received: by 2002:a17:907:72ca:b0:ad8:91e4:a937 with SMTP id
 a640c23a62f3a-ad891e4ab46mr453178266b.57.1748419051093; 
 Wed, 28 May 2025 00:57:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19c9a18sm63778966b.42.2025.05.28.00.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 00:57:30 -0700 (PDT)
Message-ID: <f79878fc-b5d3-4b5c-a717-0173f9c50056@redhat.com>
Date: Wed, 28 May 2025 09:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_aarch64_hotplug_pci: Update images
To: Gustavo Romero <gustavo.romero@linaro.org>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250528014737.1630668-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250528014737.1630668-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 28/05/2025 03.47, Gustavo Romero wrote:
> The current links for the Linux and initrd.gz images are not truly
> immutable, so let's change them to point to immutable versions, to avoid
> having to keep updating their SHAs.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/test_aarch64_hotplug_pci.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> index fa1bb62c8f..2cf5c28b9f 100755
> --- a/tests/functional/test_aarch64_hotplug_pci.py
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -19,13 +19,13 @@ class HotplugPCI(LinuxKernelTest):
>   
>       ASSET_KERNEL = Asset(
>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> -         'current/images/netboot/debian-installer/arm64/linux'),
> -        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
> +         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
> +         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
>   
>       ASSET_INITRD = Asset(
>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> -         'current/images/netboot/debian-installer/arm64/initrd.gz'),
> -        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> +         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
> +         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
>   
>       def test_hotplug_pci(self):
>   

Acked-by: Thomas Huth <thuth@redhat.com>

Since the original patch is still sitting in Alex' queue, I assume that 
he'll squash it into that original patch before it gets upstream?

  Thomas


