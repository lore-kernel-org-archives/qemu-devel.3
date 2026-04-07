Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803C4FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABpF-00056i-KS; Tue, 07 Apr 2026 15:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABpC-00054s-9E
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABpA-0002qR-SS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43b9d3ebed5so4477578f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589055; x=1776193855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxGfp9hWtCVNZq+ooxKwN2pXkG74tC8/mmam00LC3tA=;
 b=MDSN5qLzklO0WSxDBryWRICBTpLWAtlW8ikOwblpHcAucyiBC+mszq/hQvUT/hnTFB
 XPhb6rKQBLfFVHSiOlkwO96nUkvbznGxSYxnW11Tgn+AzHhvr8kTO8Gop31bk9swPQS2
 sV/eYpZg5g6N7tTdPMOXObNIXkM/FJMzJ6LGlSHGbTpEqVoUgQzTxD4MxeLLINO0obeZ
 DX2EFU5n2OIGe7sE01zD7jM7+9eA/2codowJRc16Rbxi6g/2R6paF/brKPk4J4ECln0t
 emAHcVMy0ozVx7Lwwev6bbTNRGyUoPensMDZGCCr5ykV/7FDFW8yv/AZiRBzAOTO3C3L
 ltTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589055; x=1776193855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxGfp9hWtCVNZq+ooxKwN2pXkG74tC8/mmam00LC3tA=;
 b=V6KcmJ/BxZvJpIPhOHNuhHPs3QzAwAjSLvvzmKYPzwBfe8sDGdrdeWk0UP5OvVxUT4
 RiuVIKbAWG9vo5aTkvfjIeJTgBOkyo3q5tRcEf/Nq0ZDfrpqHd0xNnOXJf/i0v+GhUr4
 irmlQ7XJTroN9Ah6g1lbRn5MDlxsZTx50IPcv4L9Msi2KEj2gdxrAEq0qFI+DYxoulvi
 8495vXeruEaUQh1uC+rS9RRe4LYlGYQoJ15duV1smPBZIAqdNUk9yQHfrl42xrjPHdD6
 0TRds3vdopdK5zypbntTWhKmfGdmgS7L1MoDINwB/FvwOxjyW0saG8ouGWljeoVo9aP5
 Lj1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJeoJYMKUA/TfJfPOJ8HLvdP01JQI3O1yAgudw5KNEVp9gyPFI0YvonsYICVQQuqlgPkdF25b4yT/+@nongnu.org
X-Gm-Message-State: AOJu0Ywm8rq1+e2n6hzGVTWBmxhvBjw2kYacVuQhmiK8vW1dEbUzpFxJ
 2zeAunIdkjO1mXZaXD/LO9o0Fh6JXfWtUD8xNSaI7EJ4yvdDVN7RXZfqM78xHwzT7YM=
X-Gm-Gg: AeBDieuI7y9bGOT9R05xiPDvvIFP6Jx+I+tYHgImdzobBtJRQx9/dDHmgtTejUstr7H
 Ppja565B8nwu6a77NgglV7DCKOGXPGzDJhFjfxoMhgiqZt5UD4JfEGd3AtZACpwsgxYMmK4E4sI
 jd2dyGJT6IoLFeM3gmss8NBW/B1qT/cBzcG5HgJQw0NgG25deJg/mjCGBwByz0juJXUDvurK8E4
 MWV6X+dabMvxt1/7spSdII5yhw/iee/BYQ1phS17D/XBD9gfptegCdh0WS1CzJoDdiu74a91KIe
 LQ+mBaerXvetN4DwLU7RDy2uWcMsQQVFxfzCfNmnaJ9KWI1mqv+7GDTjHfuFCSLbcX+h1TunDFT
 Org1v3Mevwb4ivJuXgSV+SMVbKb5nKtUji43Mx2bKcwdq43uQyx+Jp/mAYsRqx+DoXv7U6JUMvK
 ukqFlwD3vt6RZCllcfXGTWQv0W4UiT8+vrOLv8evw1NxXXjHsNq5cSa5kQKJ3IF4aHLQ==
X-Received: by 2002:a05:6000:2586:b0:43c:f8ee:c630 with SMTP id
 ffacd0b85a97d-43d292db10emr25342824f8f.35.1775589054552; 
 Tue, 07 Apr 2026 12:10:54 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c60a2sm50512253f8f.10.2026.04.07.12.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:10:53 -0700 (PDT)
Message-ID: <e6121182-9213-46ba-9ebf-7cd72d1fa304@linaro.org>
Date: Tue, 7 Apr 2026 21:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/20] target/arm/tcg/gengvec.c: make compilation unit
 common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-11-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

