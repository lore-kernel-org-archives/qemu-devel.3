Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1917C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGay-0003X1-83; Tue, 21 Jan 2025 10:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taGak-0003K1-FU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taGai-0001i5-KC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737474899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rCtFm/ew0i1YQbv+SgRMsVRj9a3nGFlwy4gWWr3PWzo=;
 b=bqWIa0feY9pokvKgjPEZfJFjwLChPi7PQGF2cOt/MoPaHArVTF/FQ4ZsdO6CIdaq9ZOOcu
 XhS2et0vA9uIlr+CsRFhJguvt59qxapHW3APLcWXN7MGS74mPFs1Mhgqrrxdkzll1Uc87q
 ShTcvgTUZQUI14dLU0MQ2ig8MiyclDA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-j2Ar_-t7Ng6pcaI4N60p0Q-1; Tue, 21 Jan 2025 10:54:57 -0500
X-MC-Unique: j2Ar_-t7Ng6pcaI4N60p0Q-1
X-Mimecast-MFC-AGG-ID: j2Ar_-t7Ng6pcaI4N60p0Q
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aafba50f3a6so459841666b.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474896; x=1738079696;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCtFm/ew0i1YQbv+SgRMsVRj9a3nGFlwy4gWWr3PWzo=;
 b=DPzEsbxuawWzpdzgtWgYlUo+VoBk2oARmaNaZtLFpTG7sQISV/o7PAjOTxxI/v5ihg
 WKFO50hXv7luoAe2K8FvyjigU9SsJDqIxCV/xpjyFobOSD2ZpzkvJ3TSc2sxCV/duqqH
 9rhNCLf506DZRuK6/E6OMSxSCgd10sCuRUa65rSZi/phw+xVVG0TyGQALew7UGsk1yVO
 0RPFbf1FV2JlADdHEsrj9P/opdSokEh5d2xNpHblvbSsECYAl4AfgIYPdDfH4/18AxD/
 yRLBDs+u0BvCi11X9fTlm+3QkNSzzt+xYFz8SAHoPfJeDmQX0XE/C9DUyQoEIu1M7H7I
 QWyg==
X-Gm-Message-State: AOJu0YyGTBv0ixUSoxjg0CO4XbFNTJS52k/DRpf9PaTH8RG38fzZvhB6
 QgzpcLyz8dsY3F1aLNb8NZ4ejm/ZyTEZkh0p5nAqfNFErFb2ZAwB1RAjehW5iSMlNebQ6AVcf0v
 nfOwvgisXo5+9sb6zQTdrDTsEYe4Gd91viqMqAnBYy1FT7B4AAKre
X-Gm-Gg: ASbGncuDRcFSpJXD4JH5KJQCHgzpLSCrX85T5enMOYyAd3EMxWXu/AaecpRBRfcLU+D
 aZDqy1Dwpr0P4b/qhqoaDd1bgfr5uQFDV6uIgH8OJKS4balJtJNf1kOWLBA1rl9QnH7O5Wkb5kT
 uAtapnx+DiIbZyx3oaKa20p8Rbyi2McqUF+foWhAeRNDakt1uRCj66U+Y60D1Wa1dMDU2LZG3ok
 Oodq+2POuINnMaac89YBK6r2oLGqUnr8BKYYNUygwV1v8B/yLKERGxXTpSCQSmdNsZPlq5WMA==
X-Received: by 2002:a17:907:6ea9:b0:aae:ebfe:cedb with SMTP id
 a640c23a62f3a-ab38b3db509mr1783508066b.51.1737474896468; 
 Tue, 21 Jan 2025 07:54:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlS2ZN9Qf2r5ZXbsgGbYR4GGElmqq9C1u2I/VJE8t2QjHIZBRR6J80qz4YVuJpeFmQ7WzUUw==
X-Received: by 2002:a17:907:6ea9:b0:aae:ebfe:cedb with SMTP id
 a640c23a62f3a-ab38b3db509mr1783505066b.51.1737474895971; 
 Tue, 21 Jan 2025 07:54:55 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab384ce21d7sm773455166b.69.2025.01.21.07.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:54:55 -0800 (PST)
Message-ID: <525436d7-e857-4ed7-9d53-462c7f28a893@redhat.com>
Date: Tue, 21 Jan 2025 16:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stub: Fix build failure with --enable-user
 --disable-system --enable-tools
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20250121154318.214680-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250121154318.214680-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On 1/21/25 16:43, Zhao Liu wrote:
> Configuring "--enable-user --disable-system --enable-tools" causes the
> build failure with the following information:
> 
> /usr/bin/ld: libhwcore.a.p/hw_core_qdev.c.o: in function `device_finalize':
> /qemu/build/../hw/core/qdev.c:688: undefined reference to `qapi_event_send_device_deleted'
> collect2: error: ld returned 1 exit status
> 
> To fix the above issue, add qdev.c stub when build with `have_tools`.
> 
> With this fix, QEMU could be successfully built in the following cases:
>   --enable-user --disable-system --enable-tools
>   --enable-user --disable-system --disable-tools
>   --enable-user --disable-system
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 388b849fb6c3 ("stubs: avoid duplicate symbols in libqemuutil.a")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2766
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   stubs/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/stubs/meson.build b/stubs/meson.build
> index e91614a874dc..a8b3aeb56450 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -57,8 +57,8 @@ if have_user
>     stub_ss.add(files('cpu-synchronize-state.c'))
>   
>     # Stubs for QAPI events.  Those can always be included in the build, but
> -  # they are not built at all for --disable-system --disable-tools builds.
> -  if not (have_system or have_tools)
> +  # they are not built at all for --disable-system builds.
> +  if not have_system
>       stub_ss.add(files('qdev.c'))
>     endif

Matches

if have_system
   qapi_all_modules += [
     'acpi',
     'audio',
     'cryptodev',
     'qdev',
     'pci',
     'rocker',
     'tpm',
   ]
endif

Queued, thanks.

Paolo


