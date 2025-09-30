Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC58CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3a5u-0004Tn-Jw; Tue, 30 Sep 2025 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3a5n-0004R4-Hk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3a5b-0001S2-MH
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759237695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q3DYhintTZNpucWNVkLjGSpk4kr3rdPsCtp6+rnXoYk=;
 b=LnZ374uvvdRiyOWbj9dXULJfYYSGn/Ax78ZV8BNogCek9j4uw708a5VuWD2rhOgN/E/wIe
 9XYB7/fSO7gwJ7QVOGX+VYgl9XG4y9cVduLl5PnYzMgw7y35zbKflCEIFG9TALmT/F+ZyE
 T+rWA30YxleFkhynvzKl7ycOvaVnOb8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-aEkYGQ9jOjyu3IEtjQdWbA-1; Tue, 30 Sep 2025 09:08:14 -0400
X-MC-Unique: aEkYGQ9jOjyu3IEtjQdWbA-1
X-Mimecast-MFC-AGG-ID: aEkYGQ9jOjyu3IEtjQdWbA_1759237693
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3af78819so22021585e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759237693; x=1759842493;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3DYhintTZNpucWNVkLjGSpk4kr3rdPsCtp6+rnXoYk=;
 b=BfDGIiP+izn3G8cf+ouq9qyKmHI9nezp0MI1++zWOXreLFY/mPUOAUkmSjCSH5vKwK
 FoqxMEYgrHk9eWV5oU4tt3aLMX1ZLWU1u8huso8ICLLsL27qtff2bkpYm4bvMn8xGnqW
 sM15jNJ815FNJR3GsL7yBNZL+J6u6iaturvvoX6iLXulOfsfXgmjBw8qtCWSxLHtTONP
 kUsrrT6FvG+BFln0CVa/ADenAsd/dp305eIZz9uezIokpLJft17BorzY3gRLeioqJpRE
 2JSx5yCWuJjLDgEuysJfzm8L2FHeA4tdGZKN87Oy4ost5MwZYzArHpX3WmrIBngVxXTT
 Lu6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAvs4aCH6ELceiip7RcFmQ81KPHCd4xBNbZ9PhzN/uCX9znLedS4r8R/yenY3QBLlEuvyXGAdPrMR1@nongnu.org
X-Gm-Message-State: AOJu0YyWWvzZ9g5up4XPB4pXRq/hPGJw/lZ5NzHi/S27xjEwBda73xVO
 a9hHLBI9MzvXhf3XSK6db0tsfGU9zC3tZ6cO6xLqeO2+ffe42CmDXf897AU90UFZL48S5OPovvl
 /5TYeZ4WJIJ3xqlMUqMo7Ua8pZmfIflZsmHog/5KEMkYt9Ld+M7Tsx52y
X-Gm-Gg: ASbGncueutpfjDIKjJpRUr436Uv9+NcCdXAMcDZq5e5d08R5wQ+SLjc6/zTn9TIaXvP
 R8D/jPUIUmZcqvB3x7gt7wEb1UljfofuBPIPQ/fpuG09kv9o1r/ZyoWkBT7DjsRVZz4C3GqeNLj
 ea50g0BsY4Ztv903k/hFnH3EGljCv3CYtS98tK5yOU5/eqpyF8NokHnSWvN9uIsYLIXZuSaMiiJ
 HoJMo7+L5LfCz1yEnZNajIOXHH08V7iFl9sXQIWcp9f/68nkZCXSdmVSiopeY5S9Ahx8Jc4amzx
 jY4CAB//nZOEqSQFKZwMMUuqI5mInqec8PLvrTtPaqkCzLe8Tx6GBE02now0BdWrHjeeFh7Cn/c
 rbUlP0V3jyw==
X-Received: by 2002:a05:600c:4743:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-46e329eb11cmr194310715e9.24.1759237692687; 
 Tue, 30 Sep 2025 06:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPVTYUAYdWHZCvd4QkvKhtCryTq4VNChEhFNpWMACfqBoTJqU5QhveONeYaa4yH6jYycwbww==
X-Received: by 2002:a05:600c:4743:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-46e329eb11cmr194310305e9.24.1759237692250; 
 Tue, 30 Sep 2025 06:08:12 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602dfdsm22471371f8f.33.2025.09.30.06.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:08:11 -0700 (PDT)
Message-ID: <a12dc871-0b50-4719-b9c6-9fcdbd3ebef5@redhat.com>
Date: Tue, 30 Sep 2025 15:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/28] s390x/diag: Introduce DIAG 320 for Certificate
 Store Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-6-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> DIAGNOSE 320 is introduced to support Certificate Store (CS)
> Facility, which includes operations such as query certificate
> storage information and provide certificates in the certificate
> store.
> 
> Currently, only subcode 0 is supported with this patch, which is
> used to query the Installed Subcodes Mask (ISM).
> 
> This subcode is only supported when the CS facility is enabled.
> 
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
> 
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
> 
> This feature is available starting with the gen16 CPU model.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst     | 12 ++++++++
>   include/hw/s390x/ipl/diag320.h      | 20 +++++++++++++
>   target/s390x/cpu_features.c         |  1 +
>   target/s390x/cpu_features_def.h.inc |  1 +
>   target/s390x/cpu_models.c           |  2 ++
>   target/s390x/diag.c                 | 44 +++++++++++++++++++++++++++++
>   target/s390x/gen-features.c         |  3 ++
>   target/s390x/kvm/kvm.c              | 16 +++++++++++
>   target/s390x/s390x-internal.h       |  2 ++
>   target/s390x/tcg/misc_helper.c      |  7 +++++
>   10 files changed, 108 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag320.h
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 9b1de5c604..30ddc81c2b 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -13,3 +13,15 @@ will keep track of the number of certificates, their respective size,
>   and a summation of the sizes.
>   
>   Note: A maximum of 64 certificates are allowed to be stored in the certificate store.
> +
> +DIAGNOSE function code 'X'320' - Certificate Store Facility
> +-----------------------------------------------------------
> +
> +DIAGNOSE 'X'320' is used to provide support for userspace to directly
> +query the s390 certificate store. Userspace may be the s390-ccw BIOS or
> +the guest kernel.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
> +    subcodes block (ISB). This mask indicates which sucodes are currently

s/sucodes/subcodes/

Apart from that, the patch looks fine to me.

  Thomas



