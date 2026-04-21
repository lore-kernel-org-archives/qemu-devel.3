Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28E2F327BE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5xm-00045j-1V; Tue, 21 Apr 2026 03:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF5xk-00045Q-Dw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:56:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF5xi-0007NW-RH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:56:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso52508775e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776758160; x=1777362960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hfeCQxXzUb7/1vGj3jsoC38KlTMcQWEr8IVJJz9CAm4=;
 b=I6GXhumj9hZyWEYqhnJpuVbJmxx/JbR78UaRWMzoHYmDJOi8ScLsewuAIBtmHtziT9
 7ljgxFpBdsVklWmyz3+CLQdoREhryxOf5NDxl1lu5DaiV4ZKHX7vpH37f0gdVn215Pdx
 MAzrEnRLGF+sZ+IasoFrdhPyBcck+mOQClybiYRsPGZVg3RhivYu7LFtxsVYsTcoRdUP
 2nivr5FUmjscLHO5dW85CNpgSu6TfAqmmbdlX0Z9gBWLVzY8j6ER5OwLYDTC1wSicPT3
 NwUT1gqCu0Hq6YrfnnzsdkUFVjODeB+8agnvCnRmv5xwHpubQ6CT8t/kaiCPUV/YjBxj
 vPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758160; x=1777362960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hfeCQxXzUb7/1vGj3jsoC38KlTMcQWEr8IVJJz9CAm4=;
 b=D7U2G0M8LbaRJFGGwNwur8DbnXrheIv7QgKUp0/L5JkqMUKMdwti8i+nTvsEb/SIwT
 1wETJnho8fB/vjIWqLV7zQHULzAneCJzaFUF38Z6GfFpBk3rB5KDviG8JSR/Mw7aq86r
 4PuhkbhTRumgg6DT2Vhrdy6l4f9xnlY6wI6lGzznPCwghkaFx617M9dayyvHPicZE0EQ
 Fj3e+l128Zyy9NX3yPdhqxz9grGTIJcwCS0wIxQ3oc8+c1h9l60tQhklD+r2r3sAbIH2
 arzIecZt1udieWlsovSE6v5eUoNjDlnK3iQAt4chXa3VurEoq6oGb+IcpNvacPoO22Mr
 sdiQ==
X-Gm-Message-State: AOJu0Yx+YZK+elwHcrl1RZ3CnuCXtf6csTGyAdUhqSesGYpDqHCMfYk9
 jGVeW6F7T1F8ovjGTJN1P44+EmHFlaCoW4PdoTFqivk0ME+Uuozofbk6ipDnpFElWxaG8IW/6BH
 91a1aWjI=
X-Gm-Gg: AeBDieus8GrRLhsSdgLADOiuj29mH6aFwJV1KSKkq2cgCkX7cCi6g0Ib6qnx6dUYBRj
 D4bbVl+MkYYTWv0rZpmv5punxeuhuHBSpE1+F8wpTXnN1NoDUxVF17dN89rJDqVt1+Rybq3sUoH
 O9OWjhU+8ByT4eOjaBZTmmA2m/0d1gesnaekYr1v4TWJR2zQ+5Np4Kbpzq3ik5u5fNh4WpU9Ov+
 B6pGnqHxpktAi6eKk8eBD0jtC6dTYpiqpn934y45nv4KzTmMXt5c+mZrt/LwJqCxKpP2keBfMRm
 isu9BV3TAY8Z7eSkGgiTUdydNQSHTtr7v+I1bI4s7yFZv+HF9BMu9MHu4pNkoFrh/FxmLRSWv32
 8Zv+p2z24n3a2BRP0Gyvr77LlOa2Dle5tUmz6e4vTT13nZwCkhuI6ZkqLkUlV4T0+FZFhYb4GQF
 eM8jQ7ojbsNTn5p3uN6qvg4+9wgo5eb8eGglx/zRiJUbaFIHwQirNDwSRt/pziadnl9sjLPKatj
 aZt
X-Received: by 2002:a05:600c:a30b:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-488fb74dff1mr166560315e9.9.1776758160052; 
 Tue, 21 Apr 2026 00:56:00 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7c0eacsm110423895e9.35.2026.04.21.00.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 00:55:59 -0700 (PDT)
Message-ID: <9cc562a2-7c0f-4a00-b5cb-81441f8a54cb@linaro.org>
Date: Tue, 21 Apr 2026 09:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>
References: <20260417042620.35329-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417042620.35329-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 17/4/26 06:26, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    target/mips: Pass MemOpIdx argument to Linked Load/Store helpers
>    target/mips: Inline cpu_ld/st_mmuidx_ra() calls in Atomic LD/ST
>      helpers
>    target/mips: Inline translator_ld[uw,l,q]() calls
>    target/mips: Remove last MO_TE use

Series queued, thanks.

