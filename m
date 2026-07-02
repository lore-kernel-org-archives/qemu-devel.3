Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226A3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLRV-00020j-7j; Thu, 02 Jul 2026 13:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLRS-0001zz-FB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:43:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLRQ-0003jQ-Vb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:43:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84780c95e2eso1467333b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014189; x=1783618989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+SEgVaS30zcPCy1/WePqpHdfBL2tDBdJ71pMNUlM8M=;
 b=Cha+Xys/X2SBXFYTug2xChMZVPjVruJ/3D+AyiDYL2aRGoThTcHmvrd95YaJJJxULh
 1hxZQ6gcq8Y4MzzFE9xqbrs8QJ/exS/Qpj4DDe9bEGypxSatp8ji9xUu10H5FSIkS4ad
 hy0Hrn/eQYmOXZ1OVrYulu3J4716LmnhNm1dBZ+ibu8I1mRr+wmsTAPuz9Aw6gD5yx37
 Dd6w+7tn4qtr3DCGwrAPYRyAlK+PkbvO6+QzkkfKQR7IllBkUdoo8LtHgUXb0lNJkZZg
 Ihqv4C9cuOSoQYXPG00P6YBvr9Ep9g7jibJRsk9X71MJgRp/PJ61IWMxxIWo3rjunoWh
 jybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014189; x=1783618989;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+SEgVaS30zcPCy1/WePqpHdfBL2tDBdJ71pMNUlM8M=;
 b=WS23JUAdPMTSvGbK2Md2CRgSxQ4gI3B1Oe8c2U9fha2Lj1n5GDoBlKloQWHm0K8XMJ
 MLe2sbfVA/jtNHJKq4lNj1C32fKGe0yRSO7z7xPAfpIf26m4TSITW+Xq5hxACySeegpr
 /9MfQmqnz5fMmUox2jS0fWo88kT1tVV3M/CNWh4FFsp9QdYh8pXA0XGege0dvltoZGCT
 1PWWKuciBfkf5tMhRuvoXJfOqI49h3tJASISboErdQW2q/UawsZBg4/aZzfqO0RXRFj1
 iH+et3IXQ7J1clP5k9d/Qx2t9R5W5/Cc1dB7FtxVzRdhVS6uqCXo0tAz+T1XPgs/PIGM
 8XTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TznbTtfYTrRNYSLMJNbKagCguPtGRQsopWVA2CdKnEByrN6C/9m4ekbejkC0G0jnJ8FtRZUlnw39r@nongnu.org
X-Gm-Message-State: AOJu0YzP4orPt6RiQLp0ciRq/A8Pt0oeCD4g3eg54Ta78UkFI8Nk9KXz
 sg2OfYOaxutk4bK8bUE2gFMHz+kqxGUdsR3r4Kd01HUelBj+vJGmWxRnES1Be57lE/4=
X-Gm-Gg: AfdE7clFIlntM6xQlm+A3yJEDcm8ovTqTaPQuPEIko3cbkK6Y/UiEzxw+S+xLOTNJyA
 +aYnGUqeZHanIumHXxcvQ41MvewEMRNNHJiDqO5d33kCzMiGDD0dcWVOcDbaxd4FlDNkff9nQSO
 hCHQyUlfJgzq9vZjvwNJdSnC6T021yc88IIJyuQRtpXOXdmOyebYkR16N/pjx7KyuBA1N/XrRLj
 wWn+5vWYTsQy7fIg/HyJ9h0VgCGI0bpoiR/Ibx4fn6wUWY+11Rb2ER8bKvcgI5ti/rgH64LAplz
 IFmRoKTz7dDSE9T4jirUwvnqObjk0aO35eQQT037Qx5Bvco4yHaBguLXsluj6+xb9DmZJXqo6Ts
 uChSCP88i/ZXJ6P7u/eTVzKQy8L2+GlaMd8VgcH54WwAC2agz9u0aQJLUc79oxv1c5yPLc9H4sx
 5oRYJjh2m283n/ZmknUsV3Ewyly3LmFNyQQ0BWCkhIgfqBMA7uTI+5sfV6Xg==
X-Received: by 2002:a05:6a00:2293:b0:847:9188:e497 with SMTP id
 d2e1a72fcca58-847c50057e2mr6445907b3a.13.1783014189399; 
 Thu, 02 Jul 2026 10:43:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6e3281sm1734683b3a.5.2026.07.02.10.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:43:09 -0700 (PDT)
Message-ID: <1e2e20de-78f9-473e-acbe-03b568cff937@linaro.org>
Date: Thu, 2 Jul 2026 10:43:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] cpu: Move BREAKPOINT definitions to
 'exec/breakpoint.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-18-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/exec/breakpoint.h | 14 ++++++++++++++
>   include/hw/core/cpu.h     | 14 --------------
>   2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

