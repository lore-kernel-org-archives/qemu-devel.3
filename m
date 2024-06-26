Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB61FC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcI8-0005WD-9B; Wed, 26 Jun 2024 19:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMcI6-0005Vu-67
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMcI3-0000Iq-Hn
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719445379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2MRsBhRz3av/jkoQlN1aC+3haU3qVcXaZ5Hlj5aTWT0=;
 b=QwTmCr6thtyjXjYCTMu9ySuG9RSNI/nE46utYUSQTVGGog1TpcwAqdx8E4FyXim9e7EQsd
 aqI+yYZvHY6cx/jFKbQKTVKt5FjUWmUQFigMvBsdxfbOX3VXVb0/SDG2Jm3DbKe5diGwMu
 b+9SgYL5mHGFwd8CjHbTROjyLZjVQ0w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-eoRbCD49O5Ow593ck1WCFA-1; Wed, 26 Jun 2024 19:42:57 -0400
X-MC-Unique: eoRbCD49O5Ow593ck1WCFA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52cd90d8da1so4860406e87.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445375; x=1720050175;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2MRsBhRz3av/jkoQlN1aC+3haU3qVcXaZ5Hlj5aTWT0=;
 b=Zh3UvOHO1ksaEaZB32tOWiPnrLLLBiQkZFkCZgBqIKrzt/4zgShblGgihgC6NW8lLq
 6Uvo8b5m6PAxmRDgBz+1YDio/wFEkk/2A2xCwS71d8Ilt3rby8sDa8hbxMVflsjbr1C2
 uTrwTBStflRUZJRUiLVMoyYx0e30DL0rFk9sgLw/zZRc5nvlPMpp/6/pl/CUo0NHSV6F
 Z+Cw8zAc2iCeRwUjuJJn1IwxviXXw7Mo4kJqD6PKcjH9cYsBT1i5/v8zmhv6uVrB/Nuk
 9omUxNpMeisOnngQX2voT/ksE2b0NPgQJNyIJU9R7SRgdG847RvfgodEjzY4+9wQkeSL
 gpqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfvNhR/7sZpX8a4HBKT+wRB2UmqiU7kCckonse2Fh+peKVfNA+60EUJEcsKN+kisZDuM7SR1YyBrrySFEVGAhDyysc6bo=
X-Gm-Message-State: AOJu0YwHrADtqHiTQCDo0ExPUdTg0072gp2AuawPFvTPqWUeUvozcZay
 Zrst1b4O/6w7wPsVKWx/fhK+590fxoqXw5sijuvz77Iux15pBdUeBp8MzhBeB0lcW+WhZpc51ql
 6u12f7wRQaEtc6wGI+Ac81wW3/ZTGcnZCJLUciSWPBbniSYgDQxQ64BNMM8tl
X-Received: by 2002:a05:6512:3e1c:b0:52c:e084:bb1e with SMTP id
 2adb3069b0e04-52ce084bc12mr12477256e87.13.1719445375574; 
 Wed, 26 Jun 2024 16:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDwQ4PnVWz0p28X43mkXITWyttCuEh1r3MtUlpnew8gJ+cNFZuSGDWSK82BDgDRW5BJc6KVQ==
X-Received: by 2002:a05:6512:3e1c:b0:52c:e084:bb1e with SMTP id
 2adb3069b0e04-52ce084bc12mr12477225e87.13.1719445374194; 
 Wed, 26 Jun 2024 16:42:54 -0700 (PDT)
Received: from [192.168.10.47] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a729d778ad1sm2953666b.141.2024.06.26.16.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 16:42:53 -0700 (PDT)
Message-ID: <d2cab7e4-2634-43b3-8cb1-58172456f602@redhat.com>
Date: Thu, 27 Jun 2024 01:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: restrict SEV to 64 bit host builds
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20240626140307.1026816-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240626140307.1026816-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/26/24 16:03, Alex Bennée wrote:
> Re-enabling the 32 bit host build on i686 showed the recently merged
> SEV code doesn't take enough care over its types. While the format
> strings could use more portable types there isn't much we can do about
> casting uint64_t into a pointer. The easiest solution seems to be just
> to disable SEV for a 32 bit build. It's highly unlikely anyone would
> want this functionality anyway.

It's better style to just fix the compilation issues.  I'll send a small 
series once I test it.

Paolo

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/i386/sev.h       | 2 +-
>   target/i386/meson.build | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 858005a119..b0cb9dd7ed 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -45,7 +45,7 @@ typedef struct SevKernelLoaderContext {
>       size_t cmdline_size;
>   } SevKernelLoaderContext;
>   
> -#ifdef CONFIG_SEV
> +#if defined(CONFIG_SEV) && defined(HOST_X86_64)
>   bool sev_enabled(void);
>   bool sev_es_enabled(void);
>   bool sev_snp_enabled(void);
> diff --git a/target/i386/meson.build b/target/i386/meson.build
> index 075117989b..d2a008926c 100644
> --- a/target/i386/meson.build
> +++ b/target/i386/meson.build
> @@ -6,7 +6,7 @@ i386_ss.add(files(
>     'xsave_helper.c',
>     'cpu-dump.c',
>   ))
> -i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
> +i386_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('host-cpu.c', 'confidential-guest.c'))
>   
>   # x86 cpu type
>   i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
> @@ -21,7 +21,7 @@ i386_system_ss.add(files(
>     'cpu-apic.c',
>     'cpu-sysemu.c',
>   ))
> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
> +i386_system_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
>   
>   i386_user_ss = ss.source_set()
>   


