Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC18CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdXi-0002CR-Da; Thu, 28 May 2026 12:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdXg-0002CC-DM
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:25:08 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdXe-00065h-Nj
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:25:08 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c85067c9ccdso3397545a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779985505; x=1780590305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AKsCzg1YnalKungbz0SZIVGmZD3PE7YYVqHRtYlqvRY=;
 b=lZC4mGq+JOHyBorSNzL9XsEcdGFpU3Pvq2gsdYvytlVS0TD6dYQKm1tAuZDMxcDCKN
 PLkV5oxuoMMpF0OG0bWfLoksZb1CYEWefblKQ2G+B6s3vEN/Zp40sCuoLHi7OTrtfe2H
 no9K4qg4rkcPcw014nHGwtqKwGYeM4KAyVWLsEOMmrWmtysU3tTUPPevGa9iG9b3v4Cy
 KQpM2YT2UdTBfMSy4vBVPbYL1SfAwnVlEudY4hc9UFZ3L2d2xbeUca9fr6kMkG4BcGkW
 685OfG3ykiO7UKJx77Qa0fGlJUfi8oRLqzRvDwYA2cSqWZe8r1YIvyZnxZ99FR1oEBJ9
 jYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985505; x=1780590305;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AKsCzg1YnalKungbz0SZIVGmZD3PE7YYVqHRtYlqvRY=;
 b=hilcLxkXpN8OE4Uyy49yLFmDXpDaC8Dvm3GT7zq5O8QGXlsbc7dSbMl1ZKBDiRN8ya
 Sq8v7j+bEfCOFau651IlgptECB6l4Z6WNpIaUCYjMTngzIE/BrLMkVPYl82/UJmK7YtE
 MWWqII4lk6K/YfLNsZdjdMb8XoOtSSOT23f8IzpfHBHJTVCISNqGk9cgWB80+gn4z0zt
 7rBGzRj/vmNaVzeDIbyziD6iCROuBo2NK8BBMs8rbkwF/oks22AzOWphAjLf+7JcYXsN
 iiiNf/b5PIvOWWhH5+2MAvNKygeW0x55H9xCr35dhMb5jeAubZsZ6XdBYkwFznC84rPP
 OoyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j3HKDu6o8YUmUNeZOlbWX2qr9A+RcYk+l30QrzZBdm22HpuRU7rk+Y2MqDCfM4jHMgoKIs1Cmobi7@nongnu.org
X-Gm-Message-State: AOJu0YwLhIuBUahweZDE4DdXbsFGDhgZHajB9hKDlY1BvdGRM5cen6uO
 CYvyF+LdZwI5DMPYg2DAZBEhrkFyjePVmjUhZsFUGzo42w1Lo3AgwsBMRgi0SZQlJh5Z52IE6SS
 XkvdkfSg=
X-Gm-Gg: Acq92OFrbJ6IrY1PzVlvEQgYTGmO7rYO6VbqrgTx8pj3ggZFVWyDdF16iRQYy2pc7Kn
 P5pUArnlfRrKIzP5zPpIqmVTYbqoqYyBTpY/NqhOC7bYfmpy5gVe3z+f9WcnKA8wtRKrXHlk+5M
 x3zfDBlinkWIs6wYbLKvwDXAxjGNaKR9EfcE4ti2iR3qS3J8MKZP5+bFwumJFq8XMNsVVri4SwM
 97lDLcOOPrjEyYnZ6uu5hBxiqfgFqrxAzWXG221Leor6ieRPWm0c2JiHPauA723JjgC+MZ+yTr7
 gLMYuDdW62jHD8F7OZw6J1WF1foBiXS38zyk5T/xhbY+TIlBrK8XmKUAwNtG+iWFDRiUJH4XM6q
 jQ3tUFXBQ0eN5dF+rwRJFFGzJzzn6ZEgwKc+Xe4oiHUtyTpb7rxZzlMOYTwdl+0N0FbR7d/+BGW
 OcPZiNezm+GCixyd6WSQcR4b0jeVdUxfwpCVDXhq2xjgmX1fg=
X-Received: by 2002:a05:6a00:915a:b0:841:71fd:6480 with SMTP id
 d2e1a72fcca58-84171fd6714mr20992390b3a.24.1779985504873; 
 Thu, 28 May 2026 09:25:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d6ed19c2sm5189000b3a.25.2026.05.28.09.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 09:25:04 -0700 (PDT)
Message-ID: <6c218eca-bc37-426e-9b85-9c67796eba57@linaro.org>
Date: Thu, 28 May 2026 09:25:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/microblaze: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260528161450.3564396-1-peter.maydell@linaro.org>
 <20260528161450.3564396-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528161450.3564396-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 5/28/26 09:14, Peter Maydell wrote:
> The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
> x86 and microblaze.  Convert microblaze to the newer
> translate_for_debug method, as a step towards being able to remove
> get_phys_addr_attrs_debug.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c    |  2 +-
>   target/microblaze/cpu.h    |  4 ++--
>   target/microblaze/helper.c | 16 +++++++++-------
>   3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

