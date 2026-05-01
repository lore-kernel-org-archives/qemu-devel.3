Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FF9FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkhj-0007Q7-CZ; Fri, 01 May 2026 06:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkhg-0007Ph-Vo
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:02:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkhf-0002aX-Co
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:02:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-834f1075805so1312015b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629752; x=1778234552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=72k6oD6ZKq8J+BDF/omWyRkWe3QKHoNnh/AMEk59d78=;
 b=mlujd3lrTzERRx1yYWl2N7ZwghN+fNcUtKPpBCFKRSQ3tDURMgBnbPL7n1LyJie3+x
 k6m/MI0tB3N8b5pmyGSLGn5yFwIomi6nh9J2UC9TKv9Vd/VGes+VIj7g+TIbJCvNvvP0
 fRA7CBGotL3BUWammVkpPlAWWO/B5NqDobfIBRpXeEHdujJjoN3pGg/A8t5LEYm3DKBq
 02OdilyU6R1ybKnfYmWChOFSgGfSmDc2gwwFaIynCCPI/ueIxC9RVwqjNS4hcNn4Pq/L
 nkxTo0kpDhEt3ln1FaAZw4mvSe6IlfP1v5MFUqAYRnRUc4g7wW594JEm2MwQBkh3ZAAg
 tDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629752; x=1778234552;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72k6oD6ZKq8J+BDF/omWyRkWe3QKHoNnh/AMEk59d78=;
 b=HMuTQ8oMrDyzTmP4d0JVC8DZ4s5Hm/zGlX0y8m/wwUssbEJ8yxiD+YmbXNJXXcad3+
 WqOrLx83HBjHWXD/nu6Bj0ibMtLmFW1KDRU/GIv2CfHnpxqbJpMmZMSk1bu+ArDuFVJ9
 HtjEKQDI8+0Rnx3y6lBIaf+K9qBVi3kh88A/mobOh7ZLNwXrDPyRk6mTa2+IV6AOm0Ev
 0Akgf789uzBsgYNzY2jGQd2TVPRNsRd/mfxmI9thfH+tTaMwpKJiVsk7PCh+HW+TRtJM
 ptDdT5JCQ6GpSGx7leVmLD8SKHy115hA1o3l1SQbMfp50MLeFHU1PF2Cs5ifuSowf+Zy
 pzSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y+NLHk3BBuGEw71LB71JtPWWkHHlQvfuBBk/RnwrI3ow9oCkAdZTTs3Y0QpHDLcxwOA6S++zod+gL@nongnu.org
X-Gm-Message-State: AOJu0YzP/PyCTzmtvGZJzyesbZw8Kn8NkN6tT5F3jg92W9q/GIy5FA2W
 imzUCPQra67UtWHu5PKlrWpqYLdwj4bwgZc3TADLlehTDizJqBx9dnGsajzorJbYYws=
X-Gm-Gg: AeBDievv5lV7o+2P4WNkOD/1qH9tKlQiO/ZD9lrHtXIdOK3E7AeGw9ziO1NtO/FeAL7
 a/exaRwn8y//wM3OfRIavgMwDOd3InwhzGkJY3sR5turYsbHxVDnqfVXyMuQsptzuQI2/OwUfzi
 +LkfOUn75nbyiJBg2ij6/6uFhwtePmE6VU9ZbaEow21Blo4APRV08nfHb2A9feIwlYIid+/zgvY
 gPzdgWWYIkREkwVjTfWII3k2b0i8u27b1GngxW7Ua/tbdKQP5jlExI23eeq3d/96P8CaKCBWqc9
 uqtP5K+ObPIFw8JxAwjjzrAgh+3khNr09j1MtAJuqhzAjv4jwKX9VqMfJ9/0IMjGmNNuo6R73bG
 YWdZ2wELk0gQO3cCyp5MHecCiMvxgNlgd0IcfuSAtAC4StTmgL6gep8NUpygkfgT4Bw+h93Toh2
 zYsMUqWo/U1iJAWMMLvSX9adpQke5azOzwNCPv3rPQAzfbG5Ox+WwB
X-Received: by 2002:a05:6a00:1c9e:b0:824:adf4:5a2f with SMTP id
 d2e1a72fcca58-834fdc5c2admr7425050b3a.43.1777629752088; 
 Fri, 01 May 2026 03:02:32 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351582edf9sm2203666b3a.12.2026.05.01.03.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 03:02:31 -0700 (PDT)
Message-ID: <7522ada9-caa8-4335-b471-955fc8c4cc06@linaro.org>
Date: Fri, 1 May 2026 20:02:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] plugins/api.c: Use cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-25-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/30/26 19:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> plugin code to use cpu_translate_for_debug() instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   plugins/api.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

