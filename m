Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273CCC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GyK-0004ew-H2; Tue, 22 Apr 2025 12:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7GyH-0004eX-KV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:59:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7GyF-0002zW-Ao
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:59:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2255003f4c6so61486985ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745341181; x=1745945981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z0FBp2XHpP7tIx+PjzQnJcggNxUmkIPjjRlzD+Q6j+s=;
 b=u1DkQlxObpM/MRLIKu1mJ2N3f6DcIgKsNxFjQKoWavUDfnL6n4cWI5jNM+H3SQxIgX
 3Ial4q3P5CpEQ14Aq3tHtJnoxnpwEEe0UpisiThEE4uuaeLKQw2WiQ1264jpX5dH1lzJ
 4tsZKHn6s0ZO1MonuVVNauwKFoCUQvW5p2U0zOV2I3qTH47XhGRufULqzujsjJi+oksM
 HUxvRFYVYTIQLItH7Eh7IBsMTek4UU/cF+gaA1YGyqAs7J/eE+2fla0j7+6iVuIsFbRx
 1dglZfhXiy3SNlP2WGL56uJN/C/8txSyfIWuADd16rQ/5A84mu2dKGbLwBu+o0tEEnpg
 Xeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745341181; x=1745945981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0FBp2XHpP7tIx+PjzQnJcggNxUmkIPjjRlzD+Q6j+s=;
 b=m/sJWrh9TurGZN+3g0APZ6d7g4QpIsJ5iAk8E0+ztcuUkJ6BfIIUocHtOdX4m2aLM8
 DduoOGMP0+AYaTfJ54F9wBY3mcqZgk9juwvhK9r4ICyzWYHnN0z9rXGGD3MA7ZtQSN8R
 dnTPbLIKOLZxM+ViSP7Y65rRPJln/5/QALXaYazMk5TiWDQ2LZE24Eoh9Xl7E+BVDeoO
 jd/+3/EWMdbdhdcdIY/J6QqQleenaA5jNpmhN5LVkmBRmGwZsc42f/QvinlVF+9m6kTZ
 oWdbexezFEhFxjVi6UYef5KuPSeI1NDXJmZLAdaZRU5GiYNOPirJdWZDXAxRV6mEr4s8
 K/0g==
X-Gm-Message-State: AOJu0YwGf4XU0uqG1bfOnziAFwgi9RszaicdlPB0OhgHDVo7FPhA5OTz
 5yPFolKgh3LVK3zxlS7LYh6V//3y0qeypb47/kZr+uGM+NhVa72V5lXuQKEee+9mg3uf3dkpIOP
 J
X-Gm-Gg: ASbGnctShX5RVYk1WN2YiA136JNCRS3lRBbESmqayN/VrBoZL1Zvuw3YYSlrT+Uqj/h
 YijkkpPGa1RZ7dFxFEuBNnXoMB9N+2ALswA5/tfQbjk0tYRXKPTI4PIQhF1OyjQeSeyLd4eZzzA
 lkQcWALBWXIVO7png58msaVn21lJFZuRBEW+5I4r35QeSHqzbKIZdL6sr/05qPmMfe0TJhMC2E3
 vJSqb7NhSSkk2r+/RXis5MLWQlNflA0PoX0oJ8WgF4MyeOJTssefVQwRjOowQ4DvkJ3NuxfLXSL
 9yNrjTm4ut+Z5dM126faoWKoZD29VcWOJnfe9idJ2xWh/9+m3xS0VUB3yqRHRsHoj2woK0mQwIx
 7JdXGeJ8=
X-Google-Smtp-Source: AGHT+IEoWj8J26zL4aIQswvQvwBj/h2tUypb8X0tHSimcWJ2mCwy5jYP6kmiBmP0Cl1AE1lyMxmtXw==
X-Received: by 2002:a17:903:1aa6:b0:224:2201:84da with SMTP id
 d9443c01a7336-22c5356de05mr208943225ad.6.1745341181614; 
 Tue, 22 Apr 2025 09:59:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdbc53sm87821615ad.228.2025.04.22.09.59.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:59:41 -0700 (PDT)
Message-ID: <9bf4d119-3904-4210-aeea-e1f24b65e47a@linaro.org>
Date: Tue, 22 Apr 2025 09:59:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/i386: tcg: remove tmp0
To: qemu-devel@nongnu.org
References: <20250403092251.54441-1-pbonzini@redhat.com>
 <20250403092251.54441-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403092251.54441-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/3/25 02:22, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 27 +++++++++++++++------------
>   target/i386/tcg/emit.c.inc  | 20 ++++++++++----------
>   2 files changed, 25 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

