Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEAE107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15J7-0002yp-8y; Fri, 13 Mar 2026 12:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15J5-0002vT-TM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:24:11 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15J4-0007bi-Fv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:24:11 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35a1c6081a5so711592a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419048; x=1774023848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CNh6V8QYtjJtRQBHSKRWOmI4knFO8YKCvecMqNI7YL0=;
 b=e92k+4OonydOJ+y5hpYLbEuR6gdbAUh91MJAdUF4dW4BZM1HprCPO/w+d1zH0Afltt
 cbP+GJHZLSMFYGKuhL4Ba94zmMpBFnfh1MS85C6axXL/rgMm3kAeRr0aRc/8co13H4IZ
 KUJsm51aR1qsIxa/mmRBzPTUGOh438MciYftqeRCbBvuumKs4Wt4WyfkXWSHa/aElzTX
 QdOuoNqQtKD8vE+ZLKsYehAcN5S/+PyYgncQwpvcdr9t7lg6zXr6QIt1632R2CCg7Ioi
 X0KGCNR7/5JDGFnjcyFT+3vFmvzCiPaM7u3D+BBWtFtBGMqsAwD9POYqpluP5HhGtzOP
 EvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419048; x=1774023848;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNh6V8QYtjJtRQBHSKRWOmI4knFO8YKCvecMqNI7YL0=;
 b=bfo9mw6/m9JNltgiKZdaUNVKGfClxOAVmwnrsUPMwK6SY/joSnjVV+L722ewh2jZBe
 xfYh98/vZUXlJda+JR+3dD6prkwVJwO3Hw8qg9unGevqBt/Z8FeFEF5/00gZxtl6b0c+
 vIAEOMCF987xbdfJq2SBiUIPBw/204L0sQIsHvk6HvDqTEmVVpHPIZRjPcyQ3krEMAbv
 DrPp1mNSA2RVA43XYdxJZ01BwGq14WAjWdN0xlvCtVZQTVqBYWWgTheoReZkefrqOdEW
 coP8hX9lKO5fEnjrgPXzsKLQkHSYB/AZ2ZAeIaGx00/Ic4FCMl/9ZFTwHgpRa4NnGG2n
 UOew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6qEDrqlrpc8zXHNATI0X2DMyetDQG2lTBmDztnwwxoCSLVqKfObgCrdEHHMT9W+JIy4e87spjPPOU@nongnu.org
X-Gm-Message-State: AOJu0YzLp7GLTJqCRLxY8Wz6//PM/ABKJ5ssvM1zn8/YLWf/SiB/nwP6
 6i3ADPzCCipUyXJAQZRwQrLlQIz/mNT+tK8RnWbKUTSJ0uvEkwI6XLNiuFCsg+VxVQk=
X-Gm-Gg: ATEYQzzRZlSGJYiKzINeNlG0t50ny5pwPt3dxB3br1VnTqdT3MahFAWhZlzYzqjT2X2
 x5bDy9wksruAUGEX91+OffADbmmS8U8sRxJpjLFo9Jq0VQkJQj/zdK9iW6/GjUd428T5AvMReAe
 YzYoXy186SQhdNK+HnZ3nTSBO5XeHYVMlFJddpvj3Pic1zgwOp9FR0z5tWWETw5EeAH+TTw8KSO
 F8/6OvGWGtPNWoSI8qAR/TQaV3r6/Z8Qs9IOxj6ayqtzFgETWv+fyDc5m+94D+EbGmRRZ75b1PR
 72WgZUhaxj8RP61izsUzp+MWDY43PnZ/KqM2VZMket8wUG6lrIEAs5RJ8piwrac24+Q2UdarBGL
 B1/WaWkqzD89q2pizNqVzlJIKoRRRSfYwFn3A2E4zOOEFxGanxMNi9GaIqA1MQmect82DVaqzzk
 9cw+P9rHWR3+sVLDUXrQ8eqWlIGAi9PaS6XcLKMqMbVoRMjSbqB7+jkkDCPbjBTcMiWvTo
X-Received: by 2002:a17:90b:580c:b0:359:8df1:8553 with SMTP id
 98e67ed59e1d1-35a21fd7ac6mr3106663a91.9.1773419048482; 
 Fri, 13 Mar 2026 09:24:08 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a23d9f29fsm3021717a91.10.2026.03.13.09.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:24:08 -0700 (PDT)
Message-ID: <41c86b41-9a24-4859-9611-75111aa33c29@linaro.org>
Date: Fri, 13 Mar 2026 09:24:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/38] target/ppc: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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
> Get the target page bits at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/mmu-booke.c   | 3 ++-
>   target/ppc/mmu-hash64.c  | 3 ++-
>   target/ppc/mmu-radix64.c | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

