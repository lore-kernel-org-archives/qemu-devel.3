Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9716ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so20F-0002NP-6j; Tue, 10 Sep 2024 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so207-00022J-Dg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:37:51 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so200-0001tE-OJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:37:50 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso33164466b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979063; x=1726583863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WHNDNhx0ko4aE9mmdBQTF2QSMKeZiaVeCZriv3zVQUs=;
 b=eyo33NknFH43sSQ1JkLkgnF5o01wbk4SSFyTNK4HvBwXuOOocHJonJ94EJYVyFryse
 nxNiPaRWY4NlwtA+FeyK5FQE4z30DpwBmvEC9e9lVdM3klf6I2PrXgBzcp9Ec159Flmx
 nEqTMEOPOS3vvH1jvSoizXWq2F+HPBJP1vRxj+lGAMmPoIQsejGHPnr2x3eBcomf3Ven
 zlxVIbi+G5QO52W/58m4iuHIoGLY2uCfI0UPsTJMFHkZGRpl3ikZxlW6As1qJP8Kau+3
 G0h+ykmcXLKVWVEhipsnyOwIwsZ6tfN8Uj65V2McloTHzhnikYKbHWuuK5tFsRDFh826
 eg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979063; x=1726583863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WHNDNhx0ko4aE9mmdBQTF2QSMKeZiaVeCZriv3zVQUs=;
 b=YQqQdv71KT8mltP6OdZrPw/fJEnJAcI33T2W/LXR/K3v1KdHMBqhJhu9vftVBOCh9s
 9Z34Y2N8xqd9bC0hnnaNZMoXjG33p/AiY0Lg+rRNvqAL5WibOwPEldUyEMGELg1oyg7i
 VkHjNn98vt0iBFq8z1VZtt9ezUyTWz+g+Jsl/LaOjsIQ6tMxEBYp7zdw1NosUHESlxwO
 1hqD5G55GETiWhbnu/ajgLo9MaFdAfz/Oy5AX55oKneoUhd6bLx2jfxRXCULYYcIGmu2
 Ph4YaU6nK+GRBn31kRo2Qk8K6TC2VN6FTKiIxTXrJKt+hvx4GNmvDjb9RwZErlMQA/zr
 bnzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMcme59Lp2xoBBzEL0ZWEpqPkUH0NUAHy1IHm1ZMzu5MdDJItkNYDcBH7xLHH1/TUOnq8iiIGEvIZZ@nongnu.org
X-Gm-Message-State: AOJu0YwiKdOTrveK2mSPCQZvhFKmcpDEWM7YS6OUnFUiGyIyqxUIAVcE
 iRVUufxu4I6TqtBjmkoAYwdyw732pmB4qU3NHv50ZG6EOSpZVxGuvlY9vODwPUA=
X-Google-Smtp-Source: AGHT+IHG52nZjN5MBkmwV42eKNHWjl/0wb3NPJNv5zS/vOLz3vGmf5uupVrfskAHLl3p6G6HSjmXbw==
X-Received: by 2002:a17:906:f58e:b0:a8d:29b7:ece3 with SMTP id
 a640c23a62f3a-a8ffb2dfb12mr137982066b.33.1725979063264; 
 Tue, 10 Sep 2024 07:37:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cea3eesm492236466b.145.2024.09.10.07.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:37:42 -0700 (PDT)
Message-ID: <b8e13ef7-9c3d-412f-92f2-8725073de779@linaro.org>
Date: Tue, 10 Sep 2024 16:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/29] target/arm: Fix whitespace near gen_srshr64_i64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909162240.647173-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/9/24 18:22, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/gengvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

(https://lore.kernel.org/qemu-devel/d86b4c48-dcb0-4651-92c4-8117f9f50543@linaro.org/)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



