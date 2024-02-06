Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6EFC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNkW-0008Im-GC; Tue, 06 Feb 2024 10:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNkV-0008IZ-PN
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:52:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNkU-0002UF-Cs
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:52:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fe2d3d5a9so6599525e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707234757; x=1707839557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vJNIPMWFYvxo/rqavYfU5tHLbXzkeRYSCKXwUEjXHcU=;
 b=JUFyob4g3tOsgtKSD2hPtH4LTQfqyUSonqIvicXzcRqGKqD7Np3mWcfB+49M7kaMqj
 p41QQ82bPKBvdnurhSyfBG/IQws4u7IsGD2Bw6ytT9ygDpKNHKRkeepP3Ccrp2TtFZjR
 vpbAw9BABko5RELMi39buDrQEehnwWlVe2Hr2pDYsCSwNy3oK3ejgYoe28A2Y5vu2guJ
 R327ehoEf6FJtfth9IhnVD6DN5LhlP+XHYkRdOk62PXvC1/lmFeBwi1iSITTFyNqcrFj
 NZKbhbNqy/v7j1h6EW9Rce3vrXQjahFnKkXatjjWNzS2cFzaAM0Uqoyl1Mjcq2o/TkYs
 AaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707234757; x=1707839557;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJNIPMWFYvxo/rqavYfU5tHLbXzkeRYSCKXwUEjXHcU=;
 b=XllijSQ7HvG9+eeC/OofaIJGLv0MIXxqp1tEdVJibgXfpWf+vtMXvQabIVF8bWsM+l
 Z3ubM2WFsZWXpiABOX1VYmcSAsqZYF016MgkaMDoAzwxXMc+e32YcUcDEislDCidCpE7
 nzG1DOSvn1BjYH4/wX/Agp6xdQ694kE84L7lQNB0IR4Hv/T8UutfO9kXWrfBfjAYChZn
 XQt/X+/f9uVHGU4ffM/g+UvfhhwDQFBuJy1qOQiahTRyibT+qnQ73q10Fw93gmJ3IZWr
 VzhR4dagtqvGywj5s+M4gPLP+cknQkuGfFDcSZ1H1SWMC73HLW3iHxbU4eY0I06FxjwE
 4sDA==
X-Gm-Message-State: AOJu0YyzK3RaBO9hbZE/6zCq2GAHHGXxkGQE5QA624yVmugMPUe84Ohb
 jiQbVLkCg1NRu2S+6Wu0TkJKJPN10bfmawDiy65zxXCBkulYSJ0DmFSKIES6ygo=
X-Google-Smtp-Source: AGHT+IFr2VOD/CAr0vy1VJzY+S4Xk9SgaBCyUOU6l0SDB0jf4BHRJ4KQRGJYnyLARIGlpFFCNhEAXg==
X-Received: by 2002:a05:600c:4fd4:b0:40f:dd7c:9e2a with SMTP id
 o20-20020a05600c4fd400b0040fdd7c9e2amr1926301wmq.28.1707234756941; 
 Tue, 06 Feb 2024 07:52:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWbgrlrQ6YfE8uSXzgTw6R6JSKuGfLbVP/r5KzSkDNJYdIy9srxnJ6jyp6ncvy96HWqD5ePMg9+pS/R/NpkQepMW17BWpO2RnfsyN77CHq2r45WMbMqcMuCunk=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a5d4dc9000000b0033b483d1abcsm1620571wru.53.2024.02.06.07.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:52:36 -0800 (PST)
Message-ID: <0a2dd2f1-7787-4270-8098-e6c460d5072e@linaro.org>
Date: Tue, 6 Feb 2024 16:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] hw/misc/mps2-scc: Fix condition for CFG3 register
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> We currently guard the CFG3 register read with
>   (scc_partno(s) == 0x524 && scc_partno(s) == 0x547)
> which is clearly wrong as it is never true.
> 
> This register is present on all board types except AN524
> and AN527; correct the condition.
> 
> Fixes: 6ac80818941829c0 ("hw/misc/mps2-scc: Implement changes for AN547")

Oops.
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/mps2-scc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)



