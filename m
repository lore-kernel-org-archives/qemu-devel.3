Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B36C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9Ql-0006w5-59; Fri, 11 Jul 2025 04:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9Ia-0001bG-7x
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9IY-0008Jb-5E
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AoF1JIDsbMsiaDTM0/WCOax8sEhw0o2YGXE7jV3UCb0=;
 b=NwyXnUIO7xtHEbgl4Q4D8zZMFs/IWb0jugo42enbJXUa4pbjoEEp0ECgK0NadkqzgPdq04
 EXNz+BD9h3+t3pPD5/zgRju27olwnAnqjPWPJq2X+ODz9NcXWdDnfa/WmO+H8E/10SDE/q
 Kg5CvTA0sVqjxI7dvcH7U9qJXdshpgE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-c7GiMeBLMWen2riZ5Jd8Ew-1; Fri, 11 Jul 2025 04:39:58 -0400
X-MC-Unique: c7GiMeBLMWen2riZ5Jd8Ew-1
X-Mimecast-MFC-AGG-ID: c7GiMeBLMWen2riZ5Jd8Ew_1752223198
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d244bfabso15167555e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223198; x=1752827998;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AoF1JIDsbMsiaDTM0/WCOax8sEhw0o2YGXE7jV3UCb0=;
 b=Xed/BWF6titRGP15n1Nghl0FtIu3niIpBQtgXnAnMA1yhFhNL5rGu6NSr6WdDTGccP
 jxZV+vpUAtOxnaCles1VWmr58gQhEDPGInxLXenSK2uquhjmJrdsbPx1wu0Jlkh5Baxq
 mw+LKpbEavhQ8k4fiKvQy2E+9vlTLMW/o4tRqPL7KipEk+1FHeUBAGP4DJWk5U8us3Sl
 wVAZe9dqgBTrxTZ4TSV6QGujC1Y0pR32WRtYqCwTN2wPb+dMb4ecLFFe2Q4nZbdgDyNx
 biGl0i5v1KaAjTa7/uOsVEF7V2MOzJVfIj2AxUO9rnpMr1CMnKjCWxOdBWL576OzFpQU
 Fp7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNl1CYeVEkH6/bbr801y+lJJzXIE4Tc7gAvK2Px15FpbIuRJPLaQVnC5YnzkocA6hiKCUpSiLVWoNu@nongnu.org
X-Gm-Message-State: AOJu0YwZsw2ACBeVkzzHoTiPDktSI5hkbOkHYxtBTAt7v+kAfxT9X2+Z
 Y5p/i73WSw2pesUkyV6NoPEErTcSPc9rUacJsdsyrCaPb4BW3gN2xK9B0PZmxwX2zTaspaOfhoA
 A3jyDHIH1reY5ebD93PIa7hPhvRZ6GKp985w6ngqB40ykYYGV7kyfhi5n
X-Gm-Gg: ASbGncvghI6B31/Xmn1AUjSo29MMZqzN0tTdUzVoxlRy1L4N6aNFz0TKbYAX6beDcdk
 UGd7008603/Vbvp/0iEN/ykUhMRyc6mdDSfo5iRUHSJ/Fs+KyzUBK13175mlIKwzndwC4jlCR3R
 Wh18QMpwYiIDe9ENRJSL7EqPWsX9Wa0OPyPmuim3MoJlwd2sb75SHfiSsyDaSylUvtaXyWcCvG2
 CbpjDWk2s9erAWX+5uXI14wisp5z9teJOSy+3fuTNF6NwNrarb3FNtr7RGkeKZn40FFUqBnbRsr
 PvtIdrGc4Q/0aFYklKV3+8ooeBshe1S9JVEr1VERM06CsQQVD41v0l2MzyUeZKlP7QNF2JczBy+
 c967z
X-Received: by 2002:a05:600c:4ecf:b0:453:dda:a52e with SMTP id
 5b1f17b1804b1-454ec27e3b9mr14652135e9.33.1752223197695; 
 Fri, 11 Jul 2025 01:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLqfHAEvGgEco0IRlkVR07Lk2R0+mgHYPEdXPjrS7kz0y9orHnKg4EuJpYXRWhD8heJNazcQ==
X-Received: by 2002:a05:600c:4ecf:b0:453:dda:a52e with SMTP id
 5b1f17b1804b1-454ec27e3b9mr14651915e9.33.1752223197225; 
 Fri, 11 Jul 2025 01:39:57 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cdc4671bsm68841985e9.3.2025.07.11.01.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 01:39:56 -0700 (PDT)
Message-ID: <242f8eae-9c02-4fad-a710-2cbfa0fc7ff4@redhat.com>
Date: Fri, 11 Jul 2025 10:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/s390x: Have s390_cpu_halt() not return anything
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org
References: <20250708095746.12697-1-philmd@linaro.org>
 <20250708095746.12697-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250708095746.12697-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/07/2025 11.57, Philippe Mathieu-Daudé wrote:
> Since halting a vCPU and how many left running do not need
> to be tied together, split the s390_count_running_cpus()
> call out of s390_cpu_halt() to the single caller using it:
> s390_handle_wait().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h | 2 +-
>   target/s390x/cpu-system.c     | 4 +---
>   target/s390x/helper.c         | 4 +++-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


