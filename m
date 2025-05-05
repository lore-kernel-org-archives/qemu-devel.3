Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B95DC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs0y-0008GT-2Z; Mon, 05 May 2025 05:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBs0q-0008Ek-6u
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBs0n-0000XP-NP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=73NXrLSdcVj93SspApSGJKVSIn8QTdEKgPRzQQsvRAg=;
 b=QQsk2XoJ+uv0rJbUJSXEdhNgSeZ9ItXmcJpi8a9FF5ZKhhAOg9erDTRW8HzQFdEEuyzDNq
 1J7P1RguGVy/Vryhb21FhDZZv/r9ascMw9oSxOSku1ZupZqfl/JR+WLcw06a4izkw4+i/K
 EcWjGVHEhNu+WBYnESL2TsuUUinvXzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Ip7Y356qM62vMLMOHBxYKA-1; Mon, 05 May 2025 05:21:18 -0400
X-MC-Unique: Ip7Y356qM62vMLMOHBxYKA-1
X-Mimecast-MFC-AGG-ID: Ip7Y356qM62vMLMOHBxYKA_1746436877
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so24506795e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746436877; x=1747041677;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73NXrLSdcVj93SspApSGJKVSIn8QTdEKgPRzQQsvRAg=;
 b=Z9oXAU5oEPRCYhex0WQDLsQcR1NxwhmH5aTBqyk+1WnPKGYESyMGcuOHrnO+snEWh8
 +SA1SivEcMw/zAFL8ii8Y5faQXKTSKubSuNnnds9T7B+cRvUsXX0pSoh3KffLNt9lgF6
 J5KScFDCqMyFJGB7YNDYck55PrtNNIhp8WdFiv4FREYFZEd6jel+hB+obQ5oEmR2g7VW
 uahkcIQApIl1oGsXZ00nu+ct+G//T4q/YepZbOHSOrBfFIHHKBSZMwnDylWBAXHeTyDx
 jH77mHX2PYLpnqkxpfyhctmoafGZ8de1Btw28oVgWAeoMmpjdO0awhglILiT2PvenVlt
 /DxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVbt4ibs0gKfOATrHDn+OTzPu8gYp1dxOKMD5jQIvZPxSQKRJvMXfyU1MihY/99bfU5UX1G1ZrcnHh@nongnu.org
X-Gm-Message-State: AOJu0YyH2sffXO5Y5mxR3G7sas+mPoUzV0VDlKOcidNL3TqSNY9+oz8D
 zKqbR+yh4oAZgT7mU+W7isgq3IBAXno+yi+2ZfqHs9CruqPCxyDCzwKB0BpjOJ1GdUCaUhrBl1t
 FrDF1pWX0+961T2gppxw5UZi+f8D/bpqXoS7lg30g8nRDqg+JERpW
X-Gm-Gg: ASbGncvjBRqppUPx9LpWw3yXp6+QmuVrV6fc+KAsqDAg8tReM+SGJJOIiyXpZnCSld3
 kaasMSkcxV+uVtH+S9Sqo3nILJo/M3BAO+1VMv/50km3MtN8GPLLJ3zt5jgzrUqbRc/okmFXu6k
 4IFxD3i5RGJVaStiIFNi4BGEHKOyc8BJiD8bcDa/WIKH7guXHc108k0aDAOiVpgJDY4vOo8PDkq
 m8jH7/nZpiAiC91eXhApEytllKwps9ruu4byblRoxnAhCtA6jn5CcWe/P/w3lgRz6EILc30Mldk
 crSvtTA/Rl1Bw9RgYDh3nLfmgK/lGhNMwwBT/Ull
X-Received: by 2002:a05:600c:5027:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-441c4948315mr47481405e9.28.1746436877230; 
 Mon, 05 May 2025 02:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsI90qglqcNTka4r2HR1TAQbnYsvaOpJxy/5zGO3t+WMddaxvMzdSdSpy4b4s7yD051sDo4g==
X-Received: by 2002:a05:600c:5027:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-441c4948315mr47481265e9.28.1746436876929; 
 Mon, 05 May 2025 02:21:16 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc67fsm129475395e9.5.2025.05.05.02.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:21:16 -0700 (PDT)
Message-ID: <3af89f1f-4bda-4ed5-bb94-46df48f321c0@redhat.com>
Date: Mon, 5 May 2025 11:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] hw/i386/pc: Remove pc_compat_2_7[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-10-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250501183628.87479-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 01/05/2025 20.36, Philippe Mathieu-Daudé wrote:
> The pc_compat_2_7[] array was only used by the pc-q35-2.7
> and pc-i440fx-2.7 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h |  3 ---
>   hw/i386/pc.c         | 10 ----------
>   2 files changed, 13 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 4fb2033bc54..319ec82f709 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
>   extern GlobalProperty pc_compat_2_8[];
>   extern const size_t pc_compat_2_8_len;
>   
> -extern GlobalProperty pc_compat_2_7[];
> -extern const size_t pc_compat_2_7_len;
> -
>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                    const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7573b880905..ee7095c89a8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
>   };
>   const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
>   
> -GlobalProperty pc_compat_2_7[] = {
> -    { TYPE_X86_CPU, "l3-cache", "off" },
> -    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
> -    { "isa-pcspk", "migrate", "off" },
> -};
> -const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);

Missing clean-up patches for l3-cache and full-cpuid-auto-level?

  Thomas


