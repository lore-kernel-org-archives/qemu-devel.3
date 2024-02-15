Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF398C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 11:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZcg-0005ZR-1b; Thu, 15 Feb 2024 06:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZce-0005Yn-Ec
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 06:09:44 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZcc-0005G3-4g
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 06:09:44 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3122b70439so84526066b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707995380; x=1708600180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uoXAxn0yxpUW4HQVuTENxtjqV2RS/NYwgwcHZY+wN5c=;
 b=JCN6oWDUfQqFzTIXqelmiQ+VUHn0aMFVI7vDMr/R1C24aEpa+nofZmKeOWB02DvEWy
 iz+Y1Y2cidSYOfpbL57kuLoodLN/qEcnf14zIu3COoUFovTFQJTA0i2ae9fg4Cl5ZLZ+
 TBdLRr4sYY+wfdZz5RHxdmay0AWTzgev2Z03RkFS1103o4wAZzrMg2nqz2nL3RK2PJVV
 pDOkuBna9FPv/+dXJlsPcL34aJXqipLRYY11FQK+EsDs5SLmHqU8sIZXISrBSFBfYhEx
 uPA4GzSMSUyppvlXtTVMzimbjI8J35zSpaU8wkDvd0RpYkdaqWvwZPegiDmyiFFiTm7n
 25JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707995380; x=1708600180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uoXAxn0yxpUW4HQVuTENxtjqV2RS/NYwgwcHZY+wN5c=;
 b=S7MkwdVOX0MrZYLEUaAIfUUEK1CU5seLgYr0UQEKx6rVlRX3wcxHlO+lE7duoML0Ib
 YZyNUT+ZE/2cHdFdXQZeu7VjSMsZsCbCqTqxptzxlgDUcih5Ct8sGqzUcWTW8JYsfgYT
 VT714eiCGy3PlPbJdAeE2shQomvlX1e3e4V/0p3duXlNonC4/HY5FyqgmPP5SEpcDxv1
 0WTGmd1OuXzk1dALD06460C9O5fV7bH8vLrmqACCkUNHXK7RzAP+b7v+gpKzIy1N0Md9
 RM1xZSVFW+RCMxPMZXZ4vdhAKPiNjxeimy/w3XOMvhRjE2s4nZwhHANz+WlnNrP7dd2k
 TmZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNGFt5fT5brGUTRURDgn4gWUM+9As2p562ED9UKK1SVvG4PaTzu5zPpRwfKT0CmUTXHmn1AvnQu45/38BvveKYS3C3jdA=
X-Gm-Message-State: AOJu0YwTCcKK06EDHfHbk82daOWbpPqvnSXCSnuM9TOerh/viH/SSC0Z
 8yjY6neTfwa0B1tzGz2wbUcxsWuWqW2NF3Dduo0Vhbu5WFAZwFDaRTgOJNDKYW0=
X-Google-Smtp-Source: AGHT+IGbVznLzh8XObjnbcM+mLm+zgYvLH2FV/BI8+eFRctA7GXLY7awGpWC5bXGJjIeiKhXrExxuw==
X-Received: by 2002:a17:906:2498:b0:a3c:c8de:9cee with SMTP id
 e24-20020a170906249800b00a3cc8de9ceemr1056143ejb.62.1707995380473; 
 Thu, 15 Feb 2024 03:09:40 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 vh2-20020a170907d38200b00a3d784f1daesm426921ejc.132.2024.02.15.03.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 03:09:39 -0800 (PST)
Message-ID: <9cafaeae-78a2-47e6-b2f4-4ea89c2ab1a4@linaro.org>
Date: Thu, 15 Feb 2024 12:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: remove redundant arg reassignment
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240215091506.1932251-1-manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215091506.1932251-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/2/24 10:15, Manos Pitsidianakis wrote:
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

Better update the declaration in the same commit:

-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 177be23db7..bf4db3b374 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2960,7 +2960,7 @@ MemTxResult flatview_read_continue(FlatView *fv, 
hwaddr addr,
                                     MemTxAttrs attrs, void *buf,
                                     hwaddr len, hwaddr addr1, hwaddr l,
                                     MemoryRegion *mr);
-void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
+void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr);

  /* Internal functions, part of the implementation of 
address_space_read_cached
   * and address_space_write_cached.  */
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


