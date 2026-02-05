Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5818CE83F05
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 05:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnrtD-0003n0-II; Thu, 05 Feb 2026 00:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnrtB-0003mE-Bh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 00:26:49 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnrt2-00071s-W9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 00:26:49 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso363534b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 21:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770269043; x=1770873843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxnlAUuxnjDHLFk0e+gb0k3U+YILpwvjY2YuoJasMAg=;
 b=yK6kG/qLd7HMGeGcob0Kc5YPNjLCk8YHg3HLkPmOjX2jzvcL3S4XHNTNtwZTgndJ9o
 LQRrWqmDm7Hrlm8e6MCh2q8PXuSt935S7qs641CYbTuSEqqewazkW9o3vc8OC8CXKFPQ
 VC8G9OPuC5XdqH0IqXrQpk5OcGv/4+nEovkTr98Cbs3ID+rzi6RcJguXnzFw/35cxL/Y
 HnoGFsC1vVd81x/TzrespJhDb3Ox4KXMErfiribFDx4Cfv1Q/FiEvL5Z/5vlRN7IyoXu
 qNhr+VT4vjcwdZmAb8LglN1A9LucDCzNxpCEEmdTtmIjur2aCQ8knq5AgH+Yxt8+oID4
 w2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770269043; x=1770873843;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxnlAUuxnjDHLFk0e+gb0k3U+YILpwvjY2YuoJasMAg=;
 b=t0ehLN6SmaX2UTyCfcjJRuoNvfQnLCaW/5DUqjScqGaKyfwA6cNtUdsp49oMt/lrqd
 6tLYg28/Fiwm7Jwz67oXLABA2nhFHzgkfvbieIcCSZvhE7G7uLmG8zzjYFO0fMuQ1uKp
 x8deXPXBenhgdeDxy7dfIt+/GgMuyf/awS5pyJlCBDTsVdyo14KrlKsPrgog08v2158p
 PJQSUKB8pwSwyyDhDU5NK2He9LMkvyTb0LlRO7E3k6deGrNb2OmUyKTw+sSFCqrQNrPm
 5Lm1XDtWcKyVepEJtGEbkFaJvd7EOPP8hqAtWOqoSJtBM5hySxOui8OK5m4MVUPPqTjV
 HM2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcYLBHhWDmhu2R/NaoigiMLOWWqF3uU6nclEF93ZjQjxnrsECXqgbowWphaR5+4uTuOEm4Jdiwhjp0@nongnu.org
X-Gm-Message-State: AOJu0YywkAzzt7QCJSVtFYt7BGFknmZBaZf06LYWTlbAPKtu/ioJUMzn
 tpbFxhSR8NQXBtpW97YYdqatCkNjo5y+Zi/9IrJOLmxF/4ZYO1JJFnrfI7GcEif/Y6a6MvtKCmT
 7RbkU
X-Gm-Gg: AZuq6aLYGDVYUHEwRDylfZnY36Vu3PDnY45N3O9W3w0eJOjyouoXmKygWXE3CmjlaS/
 niqGBJTtNWSXyczQFyzwiEd1d5cZMh8rr1/tgSQ0PhcIQ3N/eQaEtcyPS2QsXQqIrKfT3LHWVi+
 sWzboCJVrpqAoKih1tm3dWStY0sJYbuIWFBdluIL1gifq1Z9yXsVRZy+VkEXfhajwQqhUS4odCm
 UnDfU7fRCH0/23L3QIhmjrlzLguLtE2zDMUaOQk7vL7Qd71U2w6DaoPZF6Q8DstaIYE/jfOGhs6
 vhYC1O3XYlYx0iXJa3X2HXMZPJ/3mLij9FPr2W9vDz47WI4X3u/UPm1lTDACDtA44DIgqw+pbl2
 mV6mlQX3b7GItOIczS5nHZtKbF/19TUZ9Hl8kNiQwq52XJh9vCuVtI9XRh3Ikk3DiCqs8I3iEUG
 xHughocJZrmw74LZ0OwAsSJ6VVU1orrt6y93RSD6pIr7CNc8QdL+JAbOtP
X-Received: by 2002:a05:6a00:2987:b0:823:c4dc:d20 with SMTP id
 d2e1a72fcca58-8241c659acbmr5367812b3a.53.1770269042804; 
 Wed, 04 Feb 2026 21:24:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d45b068sm3970629b3a.46.2026.02.04.21.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 21:24:02 -0800 (PST)
Message-ID: <82cd621d-bd02-4819-9368-ea3db4ccde22@linaro.org>
Date: Wed, 4 Feb 2026 21:24:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target-info: Statically initialize target_arch
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260205030617.266625-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/4/26 7:06 PM, Richard Henderson wrote:
> Use TARGET_ARCH and token pasting to initialize
> target_arch from SYS_EMU_TARGET_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target-info-stub.c | 2 +-
>   target-info.c      | 8 +-------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

