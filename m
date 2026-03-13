Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB71107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15WM-0007F1-0C; Fri, 13 Mar 2026 12:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15W2-0007ED-Tq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:37:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15W1-0001j3-AR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:37:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2aaed195901so11896815ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419844; x=1774024644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YnT/M49Uz0jeGINCijZjItumY583FmltMl80ZhVB1L0=;
 b=UWpEImmxrVot/tdQuMQV5AJ8dOJ/jDHWeVzCLiQOZJRB+3Cbr7WgRVEEHkACM2NzO0
 yVQMc8O1kpBqBx7l8M9IvpM6KeL8JAJUKFoOodrTBWWkA+Mu0vZQ+D2bRe0hztDevUfU
 b4qsKw1PnZ/eYolSeJzrhiCHVKFG5AJ6pUCwrnj9QIVpkSF0tPhiINqbTz6eVg+HlVA0
 R5x3hhQbv7pH2ovBQ07zh7ZJ8bYQHP6c5W9nuUhKRamKcaoPr6kYAQ5iu02wsgapshNp
 nJr7O197QfeqIWEU2X0RSfZAXFKgAxtLVxC2pO+I98HwYkdFnysC0L7U78qHIZUFY0xi
 kNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419844; x=1774024644;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YnT/M49Uz0jeGINCijZjItumY583FmltMl80ZhVB1L0=;
 b=D5qBx21ovawLlXl33Mpdz7zSGNpWbST13Kxf3f9tw96LrMaXlk7GbaN4ii+mx95BPL
 eUM2X2u0RYPS7uGbnRP3y/SEftcAS1lsbYeBUiK18VGEfSsNukj31odjvoNkd7IMy881
 kI1AlQnjo1C3UxAnbFH2g3PTzd/EfWs7DFrq9hcklu2qr94NyascBFm3BbOOC5qkdcZy
 NID5NbwnH5dt1Hsdu/xmY1+t5jcg1ZEPph8Iw7Xlid30mQf+SURjnGN2ZWLVYuDOMc+n
 HC661pKXyqMnm1AnT7D/qSRNpzf8pG/Gu+k/T8Bhs4c7EpA5YqLdTJucXC+50SF9SCii
 U4jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJno4an9iRDCNKcg1MF3WDms0SUuXP/hqZNKCMSS60a74slKpOrobOdQ9LrT0PaIYCds4fqmKFtdt@nongnu.org
X-Gm-Message-State: AOJu0YyTRvrq61c/JxTaneTbRoXRf1zR2GLshBwMsjVqRJgMtGYctu5g
 rntBZF/BVdcEBUQ05oHiyC+DLjtTfzrc/7eFb0MgU2dbWVjiWqTms8tV2sEceUdUc9c=
X-Gm-Gg: ATEYQzxOXwqE+292uUf2qsesHRiVLZOMi/PJE4IXeRixTGVCxxYeWgxEp9sizhGzzo9
 DawXl9r6bHyV9escGJl/GS1UHfIjA0VhJY/QZZt2Rt/8NVRssWw1RvDMOTzslbL8TxJIUCZCPMW
 HRzFc45dErqqsZvQl0mMvDd2BUqiFICuvOY7aaujX/AabSN8s2Vekmm/RHuwwf+U/QkxM+5Xe/w
 EKN4YlutsnsobUWNr0wRkxx7OUENx9A/6y4Qu72QQtRmaV3PltxKuZyFyuJhlv5tXrTpQyV7zGO
 lFmPYbtom/1D/dG8gxhPvxAvEiy7seV73I8j4Q1vUifJTwEp+w5fDNKY718hGb1e8KaU8PZ3ynn
 xjrlDSlwpeEAa/J6i/t73N5A0/6lfkbrQJLIrr6IUXFPXzuhc+c8xhbXpO6ObjeAYxYVHh2MDQs
 /g0wx/dQrxo6YNbds1p9X8cWm4Ijisvw+hdQAbZkibC2Duo5S+4CVto50UYZsCV5Y0xM9w
X-Received: by 2002:a17:903:41cb:b0:2ae:3b9b:db34 with SMTP id
 d9443c01a7336-2aecaad8054mr39281865ad.42.1773419843781; 
 Fri, 13 Mar 2026 09:37:23 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee3ecsm37606855ad.42.2026.03.13.09.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:37:23 -0700 (PDT)
Message-ID: <03d7c3ea-39ff-4b5c-964e-cb60d1e7e304@linaro.org>
Date: Fri, 13 Mar 2026 09:37:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/38] target/m68k: Include missing
 'exec/target_long.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "exec/target_long.h" header is indirectly included, pulled
> via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
> when removing the latter:
> 
>    ../target/m68k/m68k-semi.c:53:5: error: use of undeclared identifier 'target_ulong'
>       53 |     target_ulong args = env->dregs[1];
>          |     ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/m68k/m68k-semi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

