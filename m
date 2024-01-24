Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B048FC47DDC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 00:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQvt-0000kl-By; Tue, 23 Jan 2024 19:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQvn-0000hw-E4
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:15:56 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQvj-0000Wz-Rr
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:15:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d5f252411aso28018435ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 16:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706055346; x=1706660146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rQs+pmcUiXFaCJyRrfUVWqHDXfXOckOQF3zJd4W/muo=;
 b=yNtZrxxbhYIw82llEpDWjoSXnGGM8Qqu92YEJ85myWyUY9pcuWDO0Rzi8yZ4ZxtSb/
 O5Pui61fJe13slyDQU25oz4R7JRJQcRrJdMXeEFQN8SlrCY70jSVpBY2UcU/PXExQJxm
 ajJMPiwkyjtsuNjf0Ms3YFvDtpC41Nh9wdNKZaNvAr8tfGNETnYuG+81N1Amq9HpBe7/
 9XHHT1vO9F97jMPb8vW/xrCiD8+Gw0dJ7CEufm6TJ/0mf2sT5JwubqP2OzAoB0Q8jywz
 HmzWbkvA0cd9N8lxzF+wfpAPA4d8KyRxJkTBo3rWdOdoJYhxi3iDd77+9uYSzKaqbQXF
 yXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706055346; x=1706660146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQs+pmcUiXFaCJyRrfUVWqHDXfXOckOQF3zJd4W/muo=;
 b=EiSAxQUBTkfjRrVlFd1tAJ1b9g1iB5ZgjI3FOEZeoQHxUds29CECWFcm5BDJWn+Hl6
 xyagdE4CAsrSECYYk3OgQoFE2rDNhd77FSPTLwl7WiIGEyV8Ty6ufud1bhkdILqWCy08
 rfDyq8VoZlbcjGBgZfEYchQUd8/zjoEkpkFsdKexAGCC9KuCqItspeWZkCQrfk7Ing2D
 BcG6czbxFhIjH0KFW2nwB/s0GOBA2UjIV8uyRxk0mj/4um2MKHPeGQozrekvY23908PY
 BeWHp8SMFfBddTwNOHErfzzvqyI7qyhlUynAaZzB1ftwtIEXT9AgDDxASF/D71wQYvg6
 Kkzg==
X-Gm-Message-State: AOJu0YxHZNoV7Bwu9y/T8z1XAQGHQpNDJF78ssTky4kfcB0Y5RddVqlN
 EoMulFVOrRkefs144Vvc4apM6TNddCMg/Fd20vPM7KYni80mJzd1sPEDDuczJuU=
X-Google-Smtp-Source: AGHT+IHO375k/P0lvGALb0Di0VnmnUzb2sWgtSJ/5/NXyKgqvthTi5X4dcwUHzeOmVz/71ab9gIRLg==
X-Received: by 2002:a05:6a20:bc89:b0:19c:4ebb:ea40 with SMTP id
 fx9-20020a056a20bc8900b0019c4ebbea40mr18094pzb.108.1706055345945; 
 Tue, 23 Jan 2024 16:15:45 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a170902ed4600b001d73ac05559sm5178275plb.184.2024.01.23.16.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 16:15:45 -0800 (PST)
Message-ID: <9c9336ec-b346-48b4-8e51-423c6f3e86f3@linaro.org>
Date: Wed, 24 Jan 2024 10:15:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/34] exec: [CPUTLB] Move cpu_*()/cpu_env() to common
 header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-17-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-17-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/20/24 00:40, Anton Johansson wrote:
> Functions are target independent.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-all.h    | 25 -------------------------
>   include/exec/cpu-common.h | 25 +++++++++++++++++++++++++
>   2 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

