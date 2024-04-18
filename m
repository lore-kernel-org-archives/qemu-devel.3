Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FB4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxUQ1-0005Mq-4b; Thu, 18 Apr 2024 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUPs-0005MJ-Nk
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:15:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUPr-0007UY-7x
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:15:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so1397356f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713456913; x=1714061713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekEUSCI5vTjMceAsk5YD9S59yiatOF5vG/4pwpsjwao=;
 b=ZaIcq+RO34HpR2ZmzxNXr91uJD1JIeLZTqzYd7KCHok/EPoOXqbMy1aGr+UJMbXp73
 lLWn0ZMgAkAOuM6xxkjfMKECqWX8nH/EwF687tnHMGXc2YQBvF0UPmydDTVR31yZZa4p
 4TTPp5LDinS+XZfd23g1gZIeSLq8otxYrPvqyR+nmp9wpD+9meTG391MMCUKag0ckjIW
 NyPwxD1/WnilA4ITbiVxsCQpMbbeCSVpY6lQx8fe/nSUAfbYd+mR1HWXY6wIRGS2meYX
 eaApXVsk+PijplphCOOPUt8hxr2Nt41H6Oij0CfM38g04qntsbBc6uV8s1AzQ0EXtr67
 n7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713456913; x=1714061713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ekEUSCI5vTjMceAsk5YD9S59yiatOF5vG/4pwpsjwao=;
 b=Mg/NObzvmYIhISJc/t0kYw7hEI3KIyzpyACcpO3ujt8XcMkniLd6g2sbF8csTvWgUy
 P8IpCPY5E0/NBxh4FkrErnCqqtHMZFOM2bfiT0fZrRwwvCm4KhjTk2ah6UNNmpvUZ+KV
 vcUSjSvBXoqHArJBtgT0W042eHWjkjLl2wSgKULyzHIgYrU0wG2VSTFMKMbnlr9OVGGp
 8b/mcDqbu5jY9F+eJGCbXtEznmdvmX4MtFPLV2o7FiUJAcmh9X0dwLmRmq7Bh6xknoR4
 4ZctwksaZzxdVI7etlboZ+GnYSBhI5afn+E56QebAcVV313VFLuN63nF6N0vO0a0LvgZ
 LtdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPBnuXaSb8SGzFvMUWnjNSbOcz1ZBoc5B6XwL9j2ZgQ5pWKf4bJSgRHtrusGtk2wRR/ldys/d9YKfTeYQI/tZKkLMMOzA=
X-Gm-Message-State: AOJu0YzNpVpF2umlzyXchnA/SIsUkNZsOIVPMf+p6Ahcxm2BLigJKLS3
 VbHxWfHlrq44vxAl/EYi4H3vKFOBBPJ7E3lEu84XANOu+38jhpEweyQVb4nRrYg=
X-Google-Smtp-Source: AGHT+IEfINRze5BpluZ0jQ+KVlqHVNerHiaaIWhm7OgzgXsIq5E+noR56U7jECeQ8BW79g3IAU0lhQ==
X-Received: by 2002:a05:6000:1a45:b0:33d:754c:8daf with SMTP id
 t5-20020a0560001a4500b0033d754c8dafmr1992738wry.10.1713456913405; 
 Thu, 18 Apr 2024 09:15:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 u17-20020adfeb51000000b00347321735a6sm2154572wrn.66.2024.04.18.09.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 09:15:12 -0700 (PDT)
Message-ID: <4999f974-ea60-4c6e-b3bb-32fab39f06bc@linaro.org>
Date: Thu, 18 Apr 2024 18:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/arm: Enable FEAT_Spec_FPACC for -cpu max
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
 <20240418152004.2106516-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418152004.2106516-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 18/4/24 17:20, Peter Maydell wrote:
> FEAT_Spec_FPACC is a feature describing speculative behaviour in the
> event of a PAC authontication failure when FEAT_FPACCOMBINE is
> implemented.  FEAT_Spec_FPACC means that the speculative use of
> pointers processed by a PAC Authentication is not materially
> different in terms of the impact on cached microarchitectural state
> (caches, TLBs, etc) between passing and failing of the PAC
> Authentication.
> 
> QEMU doesn't do speculative execution, so we can advertise
> this feature.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 4 ++++
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


