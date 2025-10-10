Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B661BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7713-0006pC-Pr; Fri, 10 Oct 2025 02:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7711-0006ob-7t
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v770s-0003y7-V3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760079238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+L5Hm9vf0vQ+TaXitMync4ZUehDbQwjC4xOqm8pFaYI=;
 b=SE6fyeU81V+IIl5vFBYCw+iRqGj00LlBu7xUOaHBB7l/6ZNPSgh3TQH0VCwE5Y3i66dkWg
 OVGtMHAJjfHn5pGkecNxsgPoAsW8W7lHyMa90k17+f77DMvUmnAIooutp5hPcFBuGETnj7
 i5960qju6BUwMpujUoV3l6gM/xs1Y8E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Ooje4MNQOamPblD-VgBi_w-1; Fri, 10 Oct 2025 02:53:57 -0400
X-MC-Unique: Ooje4MNQOamPblD-VgBi_w-1
X-Mimecast-MFC-AGG-ID: Ooje4MNQOamPblD-VgBi_w_1760079236
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b3cd45a823cso201550466b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760079236; x=1760684036;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+L5Hm9vf0vQ+TaXitMync4ZUehDbQwjC4xOqm8pFaYI=;
 b=vacK6/inLIb8VnrUFTjpb+66xIO2dqvfREjOAFt3YjlujOYM5e9srsS5LGf6so9/Ow
 +f4o7xfqo87z3MLjP5e0Y4D2xnU7vP7CbfqAH69RVwh6hUlrHqXtaaiJCWAulzoDWH1b
 z40wxF0sD+mhJtkkPN9SodP2r/Jj9pgKvS6qgwcrh8pLPG1ee8Eq4x8SihdWmVk8NLn/
 +DWHTpj2RcAGajCCB10SAfPcf+e/sXDUVwOZgW/+HpbHuDL1G9ZDa4uJ7/h0sr61uA5b
 vZT1MxMLhAnmvIFwem1QhJxEusRKnS6yaCU+X8RnOY2ubq4empEQlQNzmEFa6V+g/Kxq
 7Gbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOGsBD0p36naICKZbRrWZP6JvgbIOUQ1WO2qw3zhU9z/YiOIEyu6Lz174zo95klPYYeeRyhwEbeBUB@nongnu.org
X-Gm-Message-State: AOJu0Yywn4tCuLVhUz35/WfW7WxFywt2e66DUg4Wh0Vb56qBbhSMaXF5
 aqe6lnu0fD63+W6RQgJXRMhXBC5YCMr1mlelo0c1GDlFK3zxWj+eFH3m3GGTC9HnIdk3POLem5+
 MXH+uT7wgTOzOfR8cbK4jBOOxRqG6gT+gpSlCeqlMnhQ4anf03uPi03SR
X-Gm-Gg: ASbGncuit+4vBcjCDeJTyK1GQ/kLkXeSPkJWzGn0eVXhyhhw3zUlJDPwHBoIjXvE1S2
 jpzT/dG2DbejfVYqey5jmG/L5LYrMm1Oegxe5Udo4oxqGvlVmnJdemzdZ4+lnddCzbrYVrAgJBL
 wnozwKwsZRzU+SLCqS2OqXxUh0pFQy1vHHDVryixxGU5MzHBnMtvYyTVaQjQ+/C6SS0OFrARth5
 VrTdbe/sViIvjoJNZGdtAsmqhXj51NpHjF0nxZwDYypSbaAIsR4jZFFnGjid0bMv26EqTc7SxCY
 c4LHGbe4ZAZNVw4XTV5NeUbRVdAz0a8+nNS3i48Pu9XOVybgpRSAxjQ6srcQYRTyxijoxgpcsUu
 eAF5W
X-Received: by 2002:a17:907:9489:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b50ab27db76mr1029986966b.26.1760079236024; 
 Thu, 09 Oct 2025 23:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz4LYZGgIK1tMOx6X5rhb09p61zl/eez2nOtHLMnYR7PvW44k6iGMNpZdLvvFNkHIXaMfpLg==
X-Received: by 2002:a17:907:9489:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b50ab27db76mr1029985366b.26.1760079235600; 
 Thu, 09 Oct 2025 23:53:55 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d67d5c2bsm158196866b.37.2025.10.09.23.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 23:53:55 -0700 (PDT)
Message-ID: <12826e4f-7c91-4cbe-aa64-add7f9c9f57a@redhat.com>
Date: Fri, 10 Oct 2025 08:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] buildsys: Remove support for 32-bit MIPS hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20251009195210.33161-1-philmd@linaro.org>
 <20251009195210.33161-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251009195210.33161-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2025 21.52, Philippe Mathieu-Daudé wrote:
> Stop detecting 32-bit MIPS host as supported, update the
> deprecation document. See previous commit for rationale.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       | 13 +++++--------
>   docs/about/removed-features.rst |  6 ++++++
>   configure                       |  7 -------
>   3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 67e527740c0..79cc34cfeb6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -172,17 +172,14 @@ This argument has always been ignored.
>   Host Architectures
>   ------------------
>   
> -Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +MIPS (since 11.0)
> +'''''''''''''''''
>   
> -As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
> -MIPS moved out of support making it hard to maintain our
> -cross-compilation CI tests of the architecture. As we no longer have
> -CI coverage support may bitrot away before the deprecation process
> +MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
> +maintain our cross-compilation CI tests of the architecture. As we no longer
> +have CI coverage support may bitrot away before the deprecation process
>   completes.
>   
> -Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
> -
>   System emulation on 32-bit x86 hosts (since 8.0)
>   ''''''''''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index a5338e44c24..53829f59e65 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -896,6 +896,12 @@ work around the atomicity issues in system mode by running all vCPUs
>   in a single thread context; in user mode atomicity was simply broken.
>   From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
>   
> +32-bit MIPS (since 11.0)
> +''''''''''''''''''''''''
> +
> +Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
> +maintain our cross-compilation CI tests of the architecture.
> +
>   Guest Emulator ISAs
>   -------------------
>   
> diff --git a/configure b/configure
> index 6a633ac2b16..8236f43e8f9 100755
> --- a/configure
> +++ b/configure
> @@ -404,8 +404,6 @@ elif check_define _ARCH_PPC ; then
>   elif check_define __mips__ ; then
>     if check_define __mips64 ; then
>       cpu="mips64"
> -  else
> -    cpu="mips"
>     fi
>   elif check_define __s390__ ; then
>     if check_define __s390x__ ; then
> @@ -473,11 +471,6 @@ case "$cpu" in
>       host_arch=mips
>       linux_arch=mips
>       ;;
> -  mips*)
> -    cpu=mips
> -    host_arch=mips
> -    linux_arch=mips
> -    ;;
>   
>     ppc)
>       host_arch=ppc

Reviewed-by: Thomas Huth <thuth@redhat.com>


