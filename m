Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B6AC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 22:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLVTi-0001Gm-5m; Sun, 23 Jun 2024 18:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLVTg-0001GG-Jy
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:14:28 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLVTe-0007yU-Ar
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:14:28 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7163489149eso1963577a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719180865; x=1719785665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9TneE55gbTEibJnk14UYPKBOrvXUxHY43edJW15YNIE=;
 b=JtTNEnfyee3exfNT42DPum5F3k39EaArFcDtoty1H9Iv60HNkTQAP2HuO0iAeaudX5
 pL+9CoYWM2HEKQaXHChpSnFp+h5aHAtBm/7fuWYKmIJ2eFMxeGCovIhNOQQilQCIps1K
 ZHWHCHjsnJ5SuIjBjrmqCW0EWCdcr3U3L7N+DvAi+6lxO1v+RMH/140sOdUajzKh4OPS
 +g9jqMpFsCDgNeyPJPJS0ZL0V3D89yxdCYEaF/zFNN/fMV/of3MawEF1frtnnifMttwB
 s5zx2w1YYYP9DYG0cYul8Fkr9/Qq9Sw99VurkPhCsTkubXtOhx0tehzkRWt9TWjxPkWr
 UBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719180865; x=1719785665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9TneE55gbTEibJnk14UYPKBOrvXUxHY43edJW15YNIE=;
 b=dKudM2tqNJseYqkj1wqCQaX9+EYA1NvTqVurFG+5bVGOToupCiyKm10wPqI/HJBvOO
 0iESYcIRfeHlKTKwKL5PScMtTWKUyCHoJWCg/MEY7+ToELXsxr4GlFIFKoYrUgs0fqG7
 H95zGF4veUSHnFT5HMg/iwsYWYulJygqH7BnUYbLl4Xbc5hnjxV7ZNoGrmL7Ojm96lZr
 euaaqHWTMpwe0O5hSWXdQIYZvtlQ2HxMHMI74Mb7H7Q4CORmif+slO3ABZiFV22Znm9q
 vR/xwgHhAw8TX+3vUyoMpT3gq+U79l2vC1ZTeIFgvsqZRuGwt7HVbWQWlVyvoAXu11Hj
 mA8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXH9dG8lMkYI3MvCEFw+f1z8k9MnXF2xC/1vCiJU6dhdWz9uOrLZItqoiwlQYCNl8ypQGfADxWoE+iJqATZEElMFDDfJ8=
X-Gm-Message-State: AOJu0YyVHhjeD21Fy9Yx4T5GEnocFYsxMwJ9sm8Byx889OaUAC7VQgCH
 03OKNdZbvP+tyUxtZ0FyrgAnZhwbKQ/tN/P2+/vhPu8cc9vo9oGJi1UnzYxPTxdLy5w8W1qOPUx
 3
X-Google-Smtp-Source: AGHT+IE8R8715+cKvF4pawaSPFotGjo8Ky5A7vCVfdMoiqSq6TKwKd0TwRE6VP9QRkIM2a9y7r+nGA==
X-Received: by 2002:a17:902:e88d:b0:1f9:ec9b:3dd7 with SMTP id
 d9443c01a7336-1fa23f06636mr35746075ad.66.1719180864721; 
 Sun, 23 Jun 2024 15:14:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e64ac485sm7303631a91.57.2024.06.23.15.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 15:14:24 -0700 (PDT)
Message-ID: <8c18ad88-6926-4e98-9ff1-d99ea123661d@linaro.org>
Date: Sun, 23 Jun 2024 15:14:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: Alexander Monakov <amonakov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <972212d2-969d-263c-1ae0-84409703a8ce@ispras.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <972212d2-969d-263c-1ae0-84409703a8ce@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 6/23/24 14:27, Alexander Monakov wrote:
> Hello,
> 
> On Wed, 12 Jun 2024, Paolo Bonzini wrote:
> 
>> I didn't do this because of RHEL9, I did it because it's silly that
>> QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
>> compute the x86 parity flag (and POPCNT was introduced at the same
>> time as SSE4.2).
> 
> I do not see where the 2% figure is coming from: even considering that
> the 256-byte LUT may take an extra cache line due to misalignment, 320
> bytes is still less than 1% of 32KB L1D size.
> 
> More importantly, the way this comment is phrased made me think that Qemu
> eagerly computes PF. But the comment in target/i386/cpu.h is saying that
> all flags are computed in an on-demand manner. Considering that software
> pretty much never uses PF, why would the parity table be resident in L1D?
> As far as I can see, the cost is rather a cache miss and perhaps a TLB miss
> when PF is computed (mostly when EFLAGS are accessed all together on
> context switches I think).
> 
> Is there something I'm not seeing?

We delay flags computation until they're needed (since flags are often overwritten by the 
very next instruction), but when we do, we compute all of the flags.  So PF is computed at 
that point, even if PF itself will never be read.


r~

