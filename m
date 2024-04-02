Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB2CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrXKG-000776-Hx; Tue, 02 Apr 2024 02:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrXKF-00076U-8O
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:08:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrXKC-0005OF-4u
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:08:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ead4093f85so4436750b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712038126; x=1712642926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xP96bUne/yBUdh/70KjFeSi0Mxm4OILPmM+kEHJGn/Y=;
 b=qoOEFK7bfe2fLLIqSzZh9rhOF5hyj6+BWPVDBZHsXDzERCtGx8U+dWwjSZKPNsWDWw
 o4nrmsN2qseuvC0zN0BJq7namPdfiL2xU/LFlTHSXZBVoGL/aTwqq8INE22cvAJv21vF
 0Zf0oZDJNKjuIg6z/RIQ3WKZLtHHuGKc5uvL40gYPuVWnWVgZeI9LWdKwR8cb46kM0t5
 Zrqdrijvfn3gNCrmecgNuFG+eIa72IMiD7qzxnVvtuZiA16XHn9+tIrfIMBtRESRTMYN
 80pfeGWXf/jsGQyPXohBzHTggiQBiH3Z7DdqtCtyKAd240++iRvdqmd2gPCNofi7Di+r
 jdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712038126; x=1712642926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xP96bUne/yBUdh/70KjFeSi0Mxm4OILPmM+kEHJGn/Y=;
 b=ecU3hxB1cVTFk2jyjG/ATdNMoaHnqGX/aBxzEcb3UYpsxoUZ2Yz1MlJzobapsJyj6D
 9kKYJuUqjIimuB3MZPCafL5PMJtnvWFB7VRBhGSMe+mefoh/PUGEvrs6uK+Y4YZDWNkA
 kTtRdqaCJDqoZNm3g3k25gRcE+H/XYESh68bSXw6vZVUwjoT61jC3azusPHj7RcOt+Sg
 wnWRzwrXP5HJzg1azc5sLvfgn5UukHbRYRDLxN/XgOU2svI6pmClIBvUyrhU4KijuOvq
 e1pq6VfPJyubcoWrVg8dT4xUFu7Msg1yicMD1p+SfpZZ7aSeosStnBQcPGGGcwkcIDnS
 ehSA==
X-Gm-Message-State: AOJu0YzIYA6077JjfNBXhQw5uV85LUMZeZnX2sBbhxgetBL4RUmlAi4f
 oU+RR8CQ6MkYcvVent1fcAiCTXExNEBhPD5KFY2hDdcnU/NrbGqmW9UxaeDutTHtFDs/yARJn3f
 S
X-Google-Smtp-Source: AGHT+IHuPqtocXPtRuRBYgF1qYnmHC3vOSiNXjveHctyf32YYwI4QYD3oTsDeCJfO2AjgTndOfRMQg==
X-Received: by 2002:a05:6a00:2d81:b0:6e6:9552:cf33 with SMTP id
 fb1-20020a056a002d8100b006e69552cf33mr10459832pfb.31.1712038125991; 
 Mon, 01 Apr 2024 23:08:45 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 kt1-20020a056a004ba100b006eae6c8d2c3sm7214171pfb.106.2024.04.01.23.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 23:08:45 -0700 (PDT)
Message-ID: <a8130b3e-c80b-481d-970c-880353d22e23@linaro.org>
Date: Mon, 1 Apr 2024 20:08:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
 <87jzlm1334.fsf@t14.stackframe.org> <87sf04xpzi.fsf@t14.stackframe.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sf04xpzi.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/1/24 20:01, Sven Schnelle wrote:
> Implement dr2 and the mfdiag/mtdiag instructions. dr2 contains a bit
> which enables/disables space id hashing. Seabios would then set
> this bit when booting. Linux would disable it again during boot (this
> would be the same like on real hardware), while HP-UX would leave it
> enabled.

Pointer to documentation?


r~

