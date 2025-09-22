Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1E5CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 07:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0b87-00011C-98; Mon, 22 Sep 2025 03:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v0b84-00010x-Rk
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v0b82-0008Mg-RB
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758526707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kl++CN+1SHtYSOai9N36kU8ons3Vl667QYHv5T/vt88=;
 b=EV6pg1wEYUcomt4k8imsllZQqxXdZxiknXK/55RAAGoGmeFPAd/CzImcQHzLizYn0E+wXp
 Gj82027fx1soPnN3Tn6vjJh9hE/RQcGspXgEb/gdpNT+/lgx8IYpp1bJgZzT5C9f9uCR8m
 OCCJWfmstpkXpPfGMTzdsxzMlrbtkPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-5aBPm4txPYC4tWqwcRlllw-1; Mon, 22 Sep 2025 03:38:26 -0400
X-MC-Unique: 5aBPm4txPYC4tWqwcRlllw-1
X-Mimecast-MFC-AGG-ID: 5aBPm4txPYC4tWqwcRlllw_1758526705
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de07b831dso25322875e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 00:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758526705; x=1759131505;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kl++CN+1SHtYSOai9N36kU8ons3Vl667QYHv5T/vt88=;
 b=Ft+jOU9YgJ2RTfrO0yiT4rdBKe4PAfBPbdSu1XErnqVVXivkx81xrniwLNLHqcn3PB
 pfv1Z9nKIlXFiTRa0B68VjqXaLFCINNDv+w5V2ZpXdkqmQYkNqrnM6SofYJI0atytLm7
 3lPQpjHWydmtk/N26cmxMXp3gHKpMZv0+XkTmxPHruwRzkfcZxOGT9OE9U3XTiyQLU2A
 MRDBSNvVyxf6xcdds8/jCVP4MPRi6+bZJfOQc1ji+PSTup1qCd57f+moQcuTx302fbsE
 9FOvYSrwye6+phUPy7K01i0xjdJOQ2+9TG3CKq9F/BnCjFvaOX5QdzJz8NAMCpRomWZL
 VsfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVDNkpQZCoSIwGm5TpSthJS5GOjw0R8WEb8zi4R0egtEMJhLXEv/Wac981YgUk3MteeFXO9lShz0aK@nongnu.org
X-Gm-Message-State: AOJu0YwlngbXzwPLv+eOFbcdQXuoyPf1e3YS1JNzUJ6CZZqux1c5zths
 RherFXzvOP/fdpKFDjJlKF+Lq2RJWtsp0mVaHbNQSoUrOW3ndYe/AWZehYOJlGP7Eb25JM8IiII
 RBcsQNlXdFp67Vi7ytFPwjgdp16rMFsYDQXYb/XfK9PDKZGTLUjkno3MU
X-Gm-Gg: ASbGncuTqJ7ZAi19bUlUawI/k6/poW6FLYgmw5yFthCUWNbpls3TzqoHqQs7XyAE7GH
 4mb8FAKSSRBb+kNCjw8UJqKQseeSz7dQ4LNTPiLFu/QoNMT3O9egsjUcDbUPTxw5qbrvbzFQr7F
 1gSXqR8Mgu4XHqxUuIsf9nm1uf6EJMRW5e/5dt5Ox7WIjS8iZXkETDAsXpuESna81o7d0tKNWUa
 BvoSjry68RzOZFAHg+aeJcG0E55eot99hV9vMXWW7rPnQIc5+icbg3xMBaVNPl8lrLrbfcm3gW3
 uYx6/65MkPC8HSMoMugjjnsg2iPQZ51Kz7lc8jlgbT5kkDQXbT0xjqBBOfm7jta21KibACAKpct
 Jxr1kQA==
X-Received: by 2002:a05:600c:1c84:b0:46d:9d28:fb78 with SMTP id
 5b1f17b1804b1-46d9d29042bmr13575795e9.8.1758526704729; 
 Mon, 22 Sep 2025 00:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1C9q1/ex/K8W1aA+0juqwCrs6dUgaRZS7I8wU6Pk4Q/gWUyGb5Q0dz/pqq0xhxCS+u6vMSA==
X-Received: by 2002:a05:600c:1c84:b0:46d:9d28:fb78 with SMTP id
 5b1f17b1804b1-46d9d29042bmr13575435e9.8.1758526704215; 
 Mon, 22 Sep 2025 00:38:24 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f0e28c83d6sm13155438f8f.56.2025.09.22.00.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 00:38:23 -0700 (PDT)
Message-ID: <617415c9-f51c-48c3-846a-97f0a5d6ddb8@redhat.com>
Date: Mon, 22 Sep 2025 09:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Correct uefi-vars-x64 device name
To: nanliu <nanliu@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250922065714.93081-1-nanliu@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250922065714.93081-1-nanliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/09/2025 08.57, nanliu wrote:
> The documentation for UEFI variable storage in uefi-vars.rst
> incorrectly listed the device name as `uefi-vars-x86`.
> 
> The correct device name as implemented in the source code is
> `uefi-vars-x64`.
> 
> This commit updates the documentation to use the correct name,
> aligning it with the implementation.
> 
> Signed-off-by: Nana Liu <nanliu@redhat.com>
> ---
>   docs/devel/uefi-vars.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/uefi-vars.rst b/docs/devel/uefi-vars.rst
> index 0151a26a0a..b4013b5d12 100644
> --- a/docs/devel/uefi-vars.rst
> +++ b/docs/devel/uefi-vars.rst
> @@ -34,7 +34,7 @@ configures the shared buffer location and size, and traps to the host
>   to process the requests.
>   
>   The ``uefi-vars`` device implements the UEFI virtual device.  It comes
> -in ``uefi-vars-x86`` and ``uefi-vars-sysbus`` flavours.  The device
> +in ``uefi-vars-x64`` and ``uefi-vars-sysbus`` flavours.  The device
>   reimplements the handlers needed, specifically
>   ``EfiSmmVariableProtocol`` and ``VarCheckPolicyLibMmiHandler``.  It
>   also consumes events (``EfiEndOfDxeEventGroup``,
> @@ -57,7 +57,7 @@ usage on x86_64
>   .. code::
>   
>      qemu-system-x86_64 \
> -      -device uefi-vars-x86,jsonfile=/path/to/vars.json
> +      -device uefi-vars-x64,jsonfile=/path/to/vars.json
>   
>   usage on aarch64
>   ----------------

Reviewed-by: Thomas Huth <thuth@redhat.com>


