Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073AAC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 07:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLos-0005E8-Jr; Tue, 03 Jun 2025 03:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMLol-0005BX-0j
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMLoj-0007Qf-5G
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748934731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nyUDjE8AiGvOJmFM9FI+4PU9IZTOPQhPpsBbbtijHto=;
 b=Smg20K61B5OEh9qr7SYZQp0/ku6t+iK4RUsN2EpcvkebxJNSE5Fyxm7tUbaYopdU0o/Dya
 PLpFf5T7S2qxaqx40FEsAvT4O+Z5XDijeGmDQU1Z1eLfnXIkMNKJGXNqtFrRXJQIRwAyAS
 h4EBqAfDOLU6o1JQMa3XrbUCxKRhdk8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-8hPGoQ9wMguGcmIBzVycTw-1; Tue, 03 Jun 2025 03:12:10 -0400
X-MC-Unique: 8hPGoQ9wMguGcmIBzVycTw-1
X-Mimecast-MFC-AGG-ID: 8hPGoQ9wMguGcmIBzVycTw_1748934729
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eee72969so3268629f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 00:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748934729; x=1749539529;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyUDjE8AiGvOJmFM9FI+4PU9IZTOPQhPpsBbbtijHto=;
 b=LlyX2HeL14DTINmoQ8mKLcOBv7H5uKKBbz6Y9z895hMC5vGkTLzcrtHiILzUq6SyO9
 RXReJqPVTosfATJm2gK7jMdcP3nBMjHwmEO5uEEMlpHk/bBovG3f+/NJmHijGUZrH4y3
 j/tOnxUeoUhTJ1j6cLFYUrvlMUYOe+B/tMDSlSGPasnwPe6DuGOWhMbRvlNs1bTlTvg3
 Ue16+Hr4JMEKep86+0bIH2OVUjawaq2ICXq5/KGEwTvBubyKyeotGl2brI62NYIglGwb
 6xBP+AMX+XnU+Xr/YccG/sFLylZEPmfPCGjOcfhoiP+K0COKqxHIHQGJE7oixofezsqI
 LRYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX0LWWQxUrteWSo4tp64D/5eEaT9uLGNjgD/1jm6PrrtP2TI+vC0tc2ixRFS1khS5syxMsHZ83U7Mm@nongnu.org
X-Gm-Message-State: AOJu0YxUtRC+y3a37iA88dvdwmu4Ts7YdWl+tiQ8Dzi+h8XwEQt6DCsK
 h6D7x+HMcEoGU7g+sWY9FMovBx7jytWrFE8CqgLwmfwXzHQBlBqFQL4m81bptNIJuekdLPMpMYh
 UzxwN1UZu9iUaokXPmNmLqBI3hxsI283McNYUOdM2FIVa8YyUrvqWoxnG
X-Gm-Gg: ASbGncvknwYVROZE3l7hm2RCZxjX/EQszrF6qGEN4EGHyjkOQV/wocSjb59x72FYRD+
 dsCBnpt5XGxNquAIh/BcILnU93Hlsu0dRc9HK7V4XNnfVJYBkv3AhtjQzjTiUH/iLX+gTpR/KsQ
 CaSFtMGJ3fH59whGAttbz6N7FtdtdmJ9CfXNR4Oa1mBmowaDxV0wxwFLnTQQdPA10ufz4V7ZmVF
 xwCyLe+5EPw7bpi17CTgjaLrALbHwpC62zMmha2vS5+OtKzR9H/Hpctry47c75z5RzBvfuVj3nG
 02aT4Yd1H+X5CVNc0bpAIR2c8UBIC4R9nr6oSxRWoIKclt/JmhjpUiyfbQ==
X-Received: by 2002:a05:6000:430e:b0:3a5:1222:ac64 with SMTP id
 ffacd0b85a97d-3a51222ad7amr2374750f8f.38.1748934728662; 
 Tue, 03 Jun 2025 00:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAV7z6aHe9fRKX8HisNsQ4w9TCLH0/oOwNJyXhRhjhiVaPv5cYN14UZJQCb6aXFCWoxLuwVQ==
X-Received: by 2002:a05:6000:430e:b0:3a5:1222:ac64 with SMTP id
 ffacd0b85a97d-3a51222ad7amr2374729f8f.38.1748934728263; 
 Tue, 03 Jun 2025 00:12:08 -0700 (PDT)
Received: from ?IPV6:2a01:cb1a:26:f704:85f7:e4c6:1cb:c089?
 ([2a01:cb1a:26:f704:85f7:e4c6:1cb:c089])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8ed27sm155935655e9.2.2025.06.03.00.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 00:12:07 -0700 (PDT)
Message-ID: <e7b64b27-f6b8-4a63-b92d-63fb49e26c92@redhat.com>
Date: Tue, 3 Jun 2025 09:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use config_base_arch for target libraries
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: nabihestefan@google.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/3/25 01:38, Pierrick Bouvier wrote:
> Fixed commit introduced common dependencies for target libraries. Alas,
> it wrongly reused the 'target' variable, which was previously set from
> another loop.
> 
> Thus, some dependencies were missing depending on order of target list,
> as found here [1].
> 
> The fix is to use the correct config_base_arch instead.
> Kudos to Thomas Huth who had this right, before I reimplement it, and
> introduce this bug.
> 
> [1] https://lore.kernel.org/qemu-devel/c54469ce-0385-4aea-b345-47711e9e61de@linaro.org/
> 
> Fixes: 4fb54de823e9 (meson: build target libraries with common dependencies)
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   meson.build | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 2df89006f8b..ad9cef99ed9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4142,13 +4142,12 @@ common_all = static_library('common',
>   target_common_arch_libs = {}
>   target_common_system_arch_libs = {}
>   foreach target_base_arch, config_base_arch : config_base_arch_mak
> -  config_target = config_target_mak[target]
>     target_inc = [include_directories('target' / target_base_arch)]
>     inc = [common_user_inc + target_inc]
>   
> -  target_common = common_ss.apply(config_target, strict: false)
> -  target_system = system_ss.apply(config_target, strict: false)
> -  target_user = user_ss.apply(config_target, strict: false)
> +  target_common = common_ss.apply(config_base_arch, strict: false)
> +  target_system = system_ss.apply(config_base_arch, strict: false)
> +  target_user = user_ss.apply(config_base_arch, strict: false)
>     common_deps = []
>     system_deps = []
>     user_deps = []


