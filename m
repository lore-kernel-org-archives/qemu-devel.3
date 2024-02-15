Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25F6C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYBH-000847-4W; Thu, 15 Feb 2024 04:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raYBG-00083x-FK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raYBF-00068B-15
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707989840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XIEw1WjJ36L91kydq1ACUsC3+tZQacuGQ32hyl/p3GY=;
 b=JSTTMCBYENvKbxmJ1o6jASdgMffytDJxqME4NVCWpe+9dn7P1ofbXm6eyybOpD0eIF8a2h
 Ywcy6URPkmTXiBa6g38rDeTYM8wNVFmqV8vMU400v1XZfV346W4EMq2TE+uNzqSgxVuy+E
 d7nJh2XfPMtuewctirTxTzv5HDBcxlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-ldlxrJZdPnSp6J6FGGfjcg-1; Thu, 15 Feb 2024 04:37:17 -0500
X-MC-Unique: ldlxrJZdPnSp6J6FGGfjcg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d00a999cdso272594f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707989837; x=1708594637;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIEw1WjJ36L91kydq1ACUsC3+tZQacuGQ32hyl/p3GY=;
 b=vZzrXzvqsKZzYUxbJmc+OCTYf9rRfwnA5iIDcnPkL8P1Av82C275n4xVm1vAPM0NMC
 FaUt/chP1ttR+3n6Qepqp+YrOCb4wUh4f8o/XUNbo5EQNS6tGKyyX6323Z4UhDh2KnaW
 BMl0DiTk/0KSrwrf5XoLcqF4jjfuBpFb1PV5znkgDN4mDtdrgV5oaDy5Ylrqh2/y/Ehs
 Tj5OwhG94Em9FlXdtTq5GqYXjIsUFnofe9nmDWj+gkhZtmTdbnVaJLpeif8MCYaffYAN
 RKYyjgFY1lcQ9e4tZhSHnMqDNkQlpnfOMnfpN17qYno1W7oUqMbPuH5YDak0HRvbnks2
 xLpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsn5UCwrKNCdA1cUZ+O+b1XW9eqlhSc3bPsu1jDm3sKg3iYh+EsY9/6DLzAGfR/pADA8U5JOy0lMHB5dqsV7H9FmjtGlQ=
X-Gm-Message-State: AOJu0Yza5WhE0HljWyzWCV/svH0aVvJHNFNqWfAEOGAwqrnGQhVgf3ua
 0vaV0lW9MOFjT1uWniI5uEv50/sDZD8ackg4DQ0uPae2PStLcIlX/uYBmEvjrlmJcoeOVTk/R6z
 91dn9Vnsncq7aWb5dRYjlzzHoj8iNRabX2o5rXbB/lmCZIhJXCLs6
X-Received: by 2002:adf:f58c:0:b0:33b:649a:19f6 with SMTP id
 f12-20020adff58c000000b0033b649a19f6mr1034514wro.35.1707989836817; 
 Thu, 15 Feb 2024 01:37:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWrmbSCKue4DV87SJTfW9Yr8zBmIkrCL9di/9AokSM/mjRxRM9VND5BkZb6OaYLE9hDP0M3A==
X-Received: by 2002:adf:f58c:0:b0:33b:649a:19f6 with SMTP id
 f12-20020adff58c000000b0033b649a19f6mr1034498wro.35.1707989836389; 
 Thu, 15 Feb 2024 01:37:16 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e?
 (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de.
 [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
 by smtp.gmail.com with ESMTPSA id
 g11-20020adff3cb000000b0033b1c321070sm1209066wrp.31.2024.02.15.01.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 01:37:15 -0800 (PST)
Message-ID: <c44b25e2-a56d-4965-aad7-b011fae4c6c6@redhat.com>
Date: Thu, 15 Feb 2024 10:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: remove redundant arg reassignment
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20240215091506.1932251-1-manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215091506.1932251-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15.02.24 10:15, Manos Pitsidianakis wrote:
> Arguments `ram_block` are reassigned to local declarations `block`
> without further use. Remove re-assignment to reduce noise.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   system/physmem.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 5e66d9ae36..d4c3bfac65 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2154,10 +2154,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
>    *
>    * Called within RCU critical section.
>    */
> -void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> +void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
>   {
> -    RAMBlock *block = ram_block;
> -
>       if (block == NULL) {
>           block = qemu_get_ram_block(addr);
>           addr -= block->offset;
> @@ -2182,10 +2180,9 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
>    *
>    * Called within RCU critical section.
>    */
> -static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> +static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>                                    hwaddr *size, bool lock)
>   {
> -    RAMBlock *block = ram_block;
>       if (*size == 0) {
>           return NULL;
>       }
> 
> base-commit: 5767815218efd3cbfd409505ed824d5f356044ae

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


