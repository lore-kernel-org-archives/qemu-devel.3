Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE42C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seVcC-000789-8U; Thu, 15 Aug 2024 04:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVc6-0006tH-LZ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVc3-0002X3-Og
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723709618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+gyuA32BDRTqkRYQzKtgifrjWd83CrAf9auKLS5stzY=;
 b=B1zP0yMMNouV3URr7VcsSCGYeYZ87Gc1K732xrr8+iZ2pMdGx7OGj3tspnL8+vgRZmLD6O
 48amHbguEHqwVz6iMQGbeoaQSDParpVU7ANSX4gjqILLb+uZt/SCDE0SK0X6O9jxaQY7h9
 daYwMeO+tuIiCGYysciMUoqPiugSmD0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-O9_e4HlYO4ak-unje6wo-w-1; Thu, 15 Aug 2024 04:13:35 -0400
X-MC-Unique: O9_e4HlYO4ak-unje6wo-w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7aa56d8b14so59856766b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 01:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723709614; x=1724314414;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gyuA32BDRTqkRYQzKtgifrjWd83CrAf9auKLS5stzY=;
 b=R+bavb7iWIVB20Tu8cWF2qeUt/KTpuPdjEp9xzvWZtq0t/d+MEbgYdHWkFE7Lw1cHR
 7D6hUU1WdNsNv9f6QGQhT1yPWXUiIcJZkRHw70YGBAZ6QLtDMZWdw5vTpzZq+4/GB98G
 l3sf7EvUo4xoDV2VXN6XdXyRV7q/16+ZDQURIrWt3TNYV4o1NOHwzi8DjXbgwtJrkGt7
 vRtOj57oLGiJi5dVsq7Ga3kT9b2V50jA0Ad7Jvm9e60DHMoywaGSTsua6J3sYLgAx8SN
 OmLyaSLqriSlkPRz1ZV6CBTSKWkzBRIvaCvB35FkvGeXnAHfYYyNfiPSUAzCO9Z7XYwa
 jrKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlKnBRLylFGWAisEGaiJ7OBKB7Mls9d0pJFVqmaZ5KwU/nTdn4BwxUotUuZJCd27Jjvnt5cccaXxjFgUEmHfs9rPfCQWQ=
X-Gm-Message-State: AOJu0YxvWfwU93O1Chxi4UxEVb0FEw2PUs64g4gPmL66lujYlTKhL8Q8
 vX7aJPRxh5yZ9dtJ/LZvvHTT3t605Ek6fpjRXsMtwo1kJCMUBRMt/uz0wOfNudd897qlCiMFc5k
 yfuEnMhYoqG+DFWhdkHACPh4IMnSG90u+yV0ZKcBScZakX65JO3Jx
X-Received: by 2002:a17:907:e25a:b0:a77:deb2:8b01 with SMTP id
 a640c23a62f3a-a8366c1fb20mr383009266b.1.1723709614486; 
 Thu, 15 Aug 2024 01:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtpqBP0ylECyrtq3zexmkuHPbc1OqDRcKHd2f0RW3mRIEt5vVZCBeLmwMCgPEtxxtXsDMsvw==
X-Received: by 2002:a17:907:e25a:b0:a77:deb2:8b01 with SMTP id
 a640c23a62f3a-a8366c1fb20mr383007866b.1.1723709613997; 
 Thu, 15 Aug 2024 01:13:33 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839359f7sm63651766b.131.2024.08.15.01.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 01:13:33 -0700 (PDT)
Message-ID: <353d0b10-8a7a-4660-a22c-f3dcb35df89e@redhat.com>
Date: Thu, 15 Aug 2024 10:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] contrib/plugins/hwprofile: fix warning when compiling
 on 32bits host
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-4-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240814233645.944327-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/08/2024 01.36, Pierrick Bouvier wrote:
> Found on debian stable (i386).
> 
> ../contrib/plugins/hwprofile.c: In function 'new_location':
> ../contrib/plugins/hwprofile.c:172:32: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    172 |     g_hash_table_insert(table, (gpointer) off_or_pc, loc);
>        |                                ^
> ../contrib/plugins/hwprofile.c: In function 'vcpu_haddr':
> ../contrib/plugins/hwprofile.c:227:19: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    227 |             off = (uint64_t) udata;
>        |                   ^
> ../contrib/plugins/hwprofile.c:232:62: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    232 |                                                              (gpointer) off);
>        |                                                              ^
> ../contrib/plugins/hwprofile.c: In function 'vcpu_tb_trans':
> ../contrib/plugins/hwprofile.c:250:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    250 |         gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/hwprofile.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
> index 739ac0c66b5..ee94a74ad94 100644
> --- a/contrib/plugins/hwprofile.c
> +++ b/contrib/plugins/hwprofile.c
> @@ -165,7 +165,7 @@ static DeviceCounts *new_count(const char *name, uint64_t base)
>       return count;
>   }
>   
> -static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
> +static IOLocationCounts *new_location(GHashTable *table, uintptr_t off_or_pc)
>   {
>       IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
>       loc->off_or_pc = off_or_pc;
> @@ -201,7 +201,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>           return;
>       } else {
>           const char *name = qemu_plugin_hwaddr_device_name(hwaddr);
> -        uint64_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
> +        uintptr_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);

qemu_plugin_hwaddr_phys_addr() returns an uint64_t, so this looks wrong to me.

  Thomas


