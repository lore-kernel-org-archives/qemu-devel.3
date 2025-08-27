Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8682CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNXP-00031e-Q0; Wed, 27 Aug 2025 17:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNXN-000311-3h
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:18:33 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNXL-00012A-5P
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:18:32 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-327771edfbbso317862a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756329507; x=1756934307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9csC/GBzJf55038pfldGMLLbABT0YJOLmsEk9jtNrRc=;
 b=UP2KRN0tYAIrzhCFz9lkd/ZvbAHgUBcrzqabEhopKD5tpj3BpNZ6GSwn+1USUO2+lb
 s8g5G4DPNKxXpev3rxYfeuBLqXkh26yfkg0cnCCVc+ZCWlN4ADoW9gXt4hpv0mp79gwF
 /SsEpgspWUh/A/y/0YSEche94X84j1iYzbqYJGsEh+aaCampqnhiTPnGZYLhRtDDkmyz
 Fja4X3nkT03QUuNhQU1Okzk++X5qTtmoc+smVSzBpHmX5uqH1scxiiMlH1JlTzI50zKb
 /3j10YXn9Oq/6zm//rcFxVd2+6tI6etvX0Nu928FWYvj/WaRLX6BRHr7XCbbLXlxVjgf
 lcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756329507; x=1756934307;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9csC/GBzJf55038pfldGMLLbABT0YJOLmsEk9jtNrRc=;
 b=T4tCACw1N0USNbHekG0rGTKIGI/Ji1HBcueJ8fQ13XccJ0sBTbSnpFT/KFY6zNrxlQ
 x3WDFVaqIW2tVpqkcBMpp9yd12NTCw5FPEdcsnu8n5TP/VmLTbLB8oxv4bdVqfq4LeAF
 zB9iw/mw98kxusTLLvf667vrf63bhWbuKt8Iry84UvABxX6mTBvsndPdolEW+Ib6okDh
 VKG+7pATxJ1tUTlZVRlNtEBicZ8bQRmpL0ANcw2t87vWVWchrY/8I6JcRYxxOc+Mb8xk
 WvtNbBundrLUm9gnHJcEVpSIXfnjAGFsQAMuk0q33Q4uZte8aY2WZi9dPdt7+UT5yzYY
 HLNA==
X-Gm-Message-State: AOJu0YyAFQtLPjxe7osem7HHoNuvaYnrSd3X6Mi0BZtyXoWQqSsJF/Xe
 sBfBKmw9QpL0UP8TL2xcTj6F459fhv6mnDNknvWQqHSQzZwcOhgo+GJQO9iC4KyW1CIEWyM5hLn
 lxPZzbmU=
X-Gm-Gg: ASbGncsVsgR4KGGbGGi6VHzOo75wQNp5oWJNusBq5EcjpY2aGrb+M8hs25hq8LDoe4q
 fHYOAKQRs0xWZ6TT3Js+ajoKqCTr+nbINo6gw1n5q5TR9Yq+lnaWsNM3HkAszr05aCCtptnx710
 zXTpraqAjMW88X0ez4fIZ1VEOiqLQfRQwHeZzG2phRGPedN+fkx85juThpmTpnTkpFEbr9JRj6i
 Ebo5t4VyME1BhQ8V0Zk4H8M6LGumVt8u2jxJR4hlAjCUh96DvxCN36SOxpPLa99WcW/V1jQR7EB
 f4y6Y/PAJMMw7T+CkbA42y4lpKzUbn/6WkbzgGmeZBHtCyeL079wuJ5NIA0ICRU3EyUtgKID5VF
 Xykuh7L4kXsE/LrthJvDuA42DCR2CwKmD06QbOHvAnsdMt1eYwS3qpf58NA==
X-Google-Smtp-Source: AGHT+IFAREtfiyQOYHLgFpHVB+xyfiUddXk1zW49GRLT0FgxC8klsHLyaOKrDKPiwa8pk19vX8PJIg==
X-Received: by 2002:a17:90a:d403:b0:327:add2:4f31 with SMTP id
 98e67ed59e1d1-327add25000mr179120a91.33.1756329507502; 
 Wed, 27 Aug 2025 14:18:27 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327ab094f7csm177495a91.5.2025.08.27.14.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 14:18:27 -0700 (PDT)
Message-ID: <dcb3ddc6-4c6b-4691-b9e7-cfb25bd5e252@linaro.org>
Date: Thu, 28 Aug 2025 07:18:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add strace for rseq
To: qemu-devel@nongnu.org
References: <20250826060341.1118670-1-joel@jms.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250826060341.1118670-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/25 16:03, Joel Stanley wrote:
>   build/qemu-riscv64 -cpu rv64,v=on -d strace  build/tests/tcg/riscv64-linux-user/test-vstart-overflow
>   1118081 riscv_hwprobe(0xffffbc038200,1,0,0,0,0) = 0
>   1118081 brk(NULL) = 0x0000000000085000
>   1118081 brk(0x0000000000085b00) = 0x0000000000085b00
>   1118081 set_tid_address(0x850f0) = 1118081
>   1118081 set_robust_list(0x85100,24) = -1 errno=38 (Function not implemented)
>   1118081 rseq(0x857c0,32,0,0xf1401073) = -1 errno=38 (Function not implemented)
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   linux-user/strace.list | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index ab818352a90c..51b5ead9696c 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1719,3 +1719,6 @@
>   #ifdef TARGET_NR_riscv_hwprobe
>   { TARGET_NR_riscv_hwprobe, "riscv_hwprobe" , "%s(%p,%d,%d,%d,%d,%d)", NULL, NULL },
>   #endif
> +#ifdef TARGET_NR_rseq
> +{ TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
> +#endif

Usually the strace comes with the implementation.  But considering that we'll never be 
able to implement rseq in qemu, this seems reasonable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.


r~

