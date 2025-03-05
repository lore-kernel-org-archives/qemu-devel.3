Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0C2C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkgq-00005R-2G; Wed, 05 Mar 2025 04:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpkgo-0008VK-8W
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpkgm-0006q0-0J
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mpmrctgQoEbnVAJGhV4oLqcUw6ECuXoLd9MjYPBrQEc=;
 b=JuNSXr01JY/sOQtGIk+k7RCmeDCSaSwCJITyDLMnL2RPIq60IUn2EW0P3hYooe4mRbJp2T
 DxH4eu/zcVOuShdQdHkWAIUDNkXpR7oPf+Mpq72hPai5uRiOcz+PIrHjFyLKgriHa8nfyC
 q8HASqPn6iBqu8m/u8DY9hzSyh9aPdI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-F5BW6cCNM9SQamQLGBRiHg-1; Wed, 05 Mar 2025 04:05:01 -0500
X-MC-Unique: F5BW6cCNM9SQamQLGBRiHg-1
X-Mimecast-MFC-AGG-ID: F5BW6cCNM9SQamQLGBRiHg_1741165501
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bcfd1cefbso3877685e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 01:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741165501; x=1741770301;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mpmrctgQoEbnVAJGhV4oLqcUw6ECuXoLd9MjYPBrQEc=;
 b=S//zuKCQn3HaAq5E4nTg7jB+BBcgRjbljD6ANCMc3GnWuLzLejPQPhN6tEo3IbeLow
 pNASwf5HGB3VgdQ1kaFdbUAKrszUZkxJgvzwxHAqoGPOvx5SVPMP/fHZff+kI1vPlaiF
 cQxvkymhNmE0tlunQyf2AHD770K6Jt8dxHSNfA+/zxCFEbfVBAlq9C0anngkmyjt7Ik/
 wL/NHfWxpS4lJRrVK3pdthvD0CZyY8nDbmE/bhtV16gMzpmEaCKXE/DeXX7qPOOJF/xw
 9XsF6YbkkBFwhLWNE8n1mXdft2wwDCrKrQBcFG2pJzBiIrCccJ08eRuW6G0NTxUvvYU/
 W3gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtN4TMMw+zmfBArR2UXgynTjbisvPCyHdusCiqLfPS6DVB9ODaAMO7BQpe0OHOvxgD3xr8S7lOfizX@nongnu.org
X-Gm-Message-State: AOJu0YwVw0rAnZGFFHO8Ebr1RfPH5YIBQckCm1yTv+HrepkHcbk6izXh
 RR2IJJecbN5bsYrwHzZG8TgnDJ1OmxgzvK00ZL+/BgWxgR5KdbkU42gGmP2RCSJVDEFg4UnPmug
 38iwwNERT82Za6IxyaC8qwU7UhTtdC1NEhTWdptA98/k64CtYEHGy
X-Gm-Gg: ASbGncuhWkysPDRuxv9UWLxWeZD7lUgdY8Q79Xq/RpJIsnQcKFYcKULFU7EMz5/V+Ve
 SIDUOlx1+iPjPthK+/9LQMG4rOUmdOnDgtzFkR3dxbO3w8Zi/U2Ba6LHjzFz1Lv9vuhn+2AgNLb
 ScPTEpUHxDfangO0UpUrRCBM1/ScGm527wM6cy+LUGR0zMnjmHv0BdsEa0jHyDkAx/ZY2OKT4SU
 Oj9iQ7g5REeS8yehFMFnyShIocucbIPcB2bV8LS6VTnnBL79rj1jw5dP8B/hQ54V1dQ3AHn9wwt
 jxZ72er98gtjBgj6U+47e1ZuAZTRJBQKridwNLQl+sF2fUc=
X-Received: by 2002:a05:600c:4ed2:b0:439:987c:2309 with SMTP id
 5b1f17b1804b1-43bd29d410bmr13961195e9.27.1741165500762; 
 Wed, 05 Mar 2025 01:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8/ABUPdIkI2ycUJIhutuvNiwcWPqs6CZOIJd00QscomeghLXFcqY9YlKuWR8yCJMUMB7d/Q==
X-Received: by 2002:a05:600c:4ed2:b0:439:987c:2309 with SMTP id
 5b1f17b1804b1-43bd29d410bmr13960815e9.27.1741165500315; 
 Wed, 05 Mar 2025 01:05:00 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c88esm10997075e9.36.2025.03.05.01.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 01:04:59 -0800 (PST)
Message-ID: <dcab2fd6-8443-4ae1-a3cb-91c0e6875520@redhat.com>
Date: Wed, 5 Mar 2025 10:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] tests/functional: drop unused 'get_tag' method
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250228102738.3064045-7-berrange@redhat.com>
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

On 28/02/2025 11.27, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/tuxruntest.py | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
> index 41a4945a14..ad74156f9c 100644
> --- a/tests/functional/qemu_test/tuxruntest.py
> +++ b/tests/functional/qemu_test/tuxruntest.py
> @@ -24,17 +24,6 @@ class TuxRunBaselineTest(QemuSystemTest):
>       # Tests are ~10-40s, allow for --debug/--enable-gcov overhead
>       timeout = 100
>   
> -    def get_tag(self, tagname, default=None):
> -        """
> -        Get the metadata tag or return the default.
> -        """
> -        utag = self._get_unique_tag_val(tagname)
> -        print(f"{tagname}/{default} -> {utag}")
> -        if utag:
> -            return utag
> -
> -        return default

A remainder from the avocado days... can be removed now, indeed.

Reviewed-by: Thomas Huth <thuth@redhat.com>


