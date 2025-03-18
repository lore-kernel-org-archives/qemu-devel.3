Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C929C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuffj-0005rp-8E; Tue, 18 Mar 2025 18:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuffS-0005qP-Io
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:44:16 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuffL-00029f-2Q
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:44:13 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so7030699a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742337844; x=1742942644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOVNEjfmFvFaGr73ny22aVzhc1cEgsoNeJFbAEdgGWE=;
 b=m0qhbXigNXU78L9+u1dzgmV/0FRwNLQTDBrhdCX3rOfwdpZ9FS4HAJVooWVZhEXJSR
 h2KQsDCnYv/gSBilzLHPOqaMsz4DcDdyf+5N5j/8NoxTrEZShs/RSNX7IOWQXvUk23HD
 UoOjvt3HVM1lcknOyNPBwqqxe9iA9E+aCrq1T74CuoGR2il/W1AmB2TMfZ+oHp+71G+D
 Z9sZ49Hpit5RM0fCSNV0s6xCvIoChwojzVOMRQL2pha6S1S5KD/2mzH0g2EkWyEhHTCA
 /bfJEfSAXZ26GuNoLhTyL0Ex9kDmaNLdjSTFOJbr7L7y1pyWnCpVAclyTiLamNH1bN7N
 uJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337844; x=1742942644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOVNEjfmFvFaGr73ny22aVzhc1cEgsoNeJFbAEdgGWE=;
 b=v7N9TTzF3Srv5p81mv0j/S/EZjf7Xh7ORDYwcvLa/VwTQvDEfg5M9n4bxHRGvN752b
 0AJMqSUQnJzAqGT8jubErEuYR085bJn5QEV/FOxVfOz3rArGl3nadhWTzriIBguKZKa6
 IL4Fk69UG3xtyNr3wI3BGYGM3gNTA7HnrsBfCJmYdeYAXqapzol8s7VgB9Bqh/AqF1Ll
 UQqKyn86kT2Oy5Xs5tJWK6GcmSTxxdbXjJjy7S5kx8Qk5pgc+ds7Ph8lkvJOCGwyxnty
 8iVtKJ0lE6YSj5uHhOYShJc0zsc+5kh6GB+yXlTYX2e833kBiUpi3QFu2yYNTtJ1lLuC
 oD1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKm9t7PBGyErMeA+xI3yDez0JOAt57ubsKxc1L0VTjS1y5yzEvHUFkFYnrwh1h86q0Eo8jzV1aFD3@nongnu.org
X-Gm-Message-State: AOJu0YxFi/CNxUX2CMZYC7zJqAHTx0uWKgzANG9eEdk4s+RMcLXG50Yh
 sbBOFLXC4lXWAOOQCtfB2KPWy/qjten9d27ebdl75XLiIfQGSaPyNNoll4NJFSU=
X-Gm-Gg: ASbGncu5p2q+9NXzzC9nT4T9WNfdCfoWD1lTw3SZDmQjJJ0RbpEBD/g+5eyvnJ8FR0k
 H9MtmqrD+MhltAUfl0rxoJLHTKCyGqhnNC2rfhr3kXgUw+ZHx1smDPA201o3EF0Ps34E3sUnQ6Z
 5fouVka0HjpF1sG1K94yd/FWdGaoi0MaWaMp6XYnhzRWSFdx9l49ZGPIwPXh9mK2tr2NRQ0xCTh
 cZwIm5JMpnBZ/L8zB6rgVswwTcsNjaNOtl8HrGzHLoy3B32qEfeFCMEBQH9mC51w0sXh9PJmEnZ
 vw5OO/i78qU8/Bf/Gcm/8dF7SxWxzm1lqixQnf72ebHF58IqZZ9KUBNat5k9xIRtx1mVAB+cAdl
 mb5F9DusB
X-Google-Smtp-Source: AGHT+IFyxI6FD/xN+KIxUzJPTwzCWqBluNiU/Pz5vcaoPz3M5Hxd1qYrSVE4IjPJNZKkULxY2fHDBA==
X-Received: by 2002:a17:90b:2dd2:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-301be1e72dcmr768418a91.24.1742337844092; 
 Tue, 18 Mar 2025 15:44:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf61b525sm37172a91.35.2025.03.18.15.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:44:03 -0700 (PDT)
Message-ID: <e8881e57-abfb-46e7-bf2f-e9cad988d547@linaro.org>
Date: Tue, 18 Mar 2025 15:44:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/arm/cpu: define ARM_MAX_VQ once for aarch32
 and aarch64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> This will affect zregs field for aarch32.
> This field is used for MVE and SVE implementations. MVE implementation
> is clipping index value to 0 or 1 for zregs[*].d[],
> so we should not touch the rest of data in this case anyway.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

