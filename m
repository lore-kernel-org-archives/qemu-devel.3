Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4C1C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virb5-0004n3-Gt; Thu, 22 Jan 2026 05:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viraY-0004gR-2i
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:06:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viraV-0006Yc-Li
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:06:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so6978515e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769076410; x=1769681210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ryXn2iL1QShQqA0FrFJvskhO30HC2CRBKZgbR2o4KA=;
 b=EPueJzlHHI1n+YMngl72ljwIYtv9NOvjAJ5z4RXYO13S/OzfPomymwWbrb1w3RxfkA
 N7mw04r4jTwsN+ZMAZXDHNRsKFN0EiI5JI7JI9+fUf/spVogfNjIVpcAX5hiE6x9W/pK
 m54Uhqtix2+0YYAoKJskjP5DKuFW6ONL3K/j01L9/WPjby8DvgWKMsA3JJwNmPoiMORs
 FwLCVMc/pgdGv/GZ4PILk6i3h1esr2p5Ar48SPC5MgDrbUVKDVJ3t5LPaop3LHc7Hn+k
 7nFD+G5L81M2Vr5czg8LBI/wi3OyBHDS7/vp/HiCtOsRQkbywo6AmgeLc+5OsLDnoQWu
 u2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769076410; x=1769681210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ryXn2iL1QShQqA0FrFJvskhO30HC2CRBKZgbR2o4KA=;
 b=P94DetWyOb4ezaB0w6lMtHuDTd49UNbkT2evtPc/aU+2FGMWApCo0fKKNyOIXV3ykN
 J2gciTLh8YGueZXsJCM73rRlO69VJIdG/qk6niV/QKOJkxrQO8N9Y/B/NgEUABFUAl6A
 zw2R7ahEV7kAk8p3gbG3lcjX772mn1umK08ZV+DYnVxwDHvY6UtY78ZEXAJt2vHQ4qKP
 WBqzz8G5k8t0s5UY8n6SHRBgr4jOGLzzYRV2mwoF3/l2WTF2dbRuq+tbFUBdeZazB4J/
 W7apqtHfMNPmoDHFtOk0XjA3NNMMXdzc4MW93QkNOZuzpnZD35iNBA2dSKlAofZvR1wM
 vXxg==
X-Gm-Message-State: AOJu0YxbMD498OpF8Py5HIv+BdF5Ebl2nOLXPCNO4y2cmwbiOIFJMm9C
 nVx1HDJPyNc0ut8pwugIjk55KgaX6WEX05+a6q95FIps2WPX8NwgnOifVneapnMXLMJa1IZjszr
 F1fKVOC4=
X-Gm-Gg: AZuq6aLmPkdhC9UyFsND65o7qs8xD8jTSRCT+C/b0gTnonc9sjH2DdNyZfPh2c4tl7N
 7yYwq+gFxHIEh4k3u9WHzTy0BxVNjQQT+TshUFt9pLKyKeT8MZYIRVbQKprVdAABXiNyDeQuF/A
 VyB6Wl159m95MD6W23YlrVFLHyIGab26deD8UpaZO6KjJFieF4dEvWhPIANyLee15k1xYiuLZB1
 JQzQkwazBR+S+SDu7fFJxYCW8fAnItad6kQL/Q8mt35dW4f+JbIfCLAK+YgO+RGgFVdXTHJi9o1
 hpTbO8vodNdiurwXPxEdFwvuM3ebZGhNWilOcSNoUzqgtkSrwljfCGCidXVnWK3aGGELowRa8f7
 BiwVDG4lnjZZoXx32lXC0w4XnQUCaN83+kNG5g279deWwHFPNu24sfLn+Jzk8bqGUXtsoUv8+/K
 F6q+NwrCK6di6Px4gAjNkBfQrU0deQmDmIeMjCsWnDRg8TeG3axqOv6w==
X-Received: by 2002:a05:600c:4692:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4803e7a4b90mr111035445e9.13.1769076409635; 
 Thu, 22 Jan 2026 02:06:49 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1e381sm47648305e9.11.2026.01.22.02.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 02:06:48 -0800 (PST)
Message-ID: <181a4d15-fcdb-43b1-bb14-3d9f99ce9a04@linaro.org>
Date: Thu, 22 Jan 2026 11:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 00/22] accel/tcg: Remove most MO_TE uses in
 cpu_ld/st_data()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
References: <20251126202200.23100-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 26/11/25 21:21, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (22):
>    target/hexagon: Use little-endian variant of cpu_ld/st_data*()
>    target/i386: Use little-endian variant of cpu_ld/st_data*()
>    target/riscv: Use little-endian variant of cpu_ld/st_data*() for
>      vector
>    target/rx: Use little-endian variant of cpu_ld/st_data*()
>    target/tricore: Use little-endian variant of cpu_ld/st_data*()
>    target/hppa: Use big-endian variant of cpu_ld/st_data*()
>    target/m68k: Use big-endian variant of cpu_ld/st_data*()
>    target/s390x: Use big-endian variant of cpu_ld/st_data*()
>    target/sparc: Use big-endian variant of cpu_ld/st_data*()
>    target/sh4: Replace cpu_stl_data() call in OCBI helper

Queueing reviewed patches to shorten v4.

