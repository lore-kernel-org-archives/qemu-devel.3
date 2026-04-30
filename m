Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B777FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJLg-0004TJ-9K; Thu, 30 Apr 2026 00:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJLc-0004Oo-3W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:50:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJLZ-0000in-Mx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:49:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso2869355e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524596; x=1778129396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=720Bx1bKlVjFNst/T9lTike7WOGhI8gorlmW7itupxU=;
 b=K+BxbAham7LWDYUoNR1kQf8WFQUCJwhCAaFaZ/Jcw10iW6iTmgMu+Uj8QxCWfH6eEr
 SI2jgkVpCSwIe2Bp8gbniG1Y65fxBvDVzW3Qe/qEikdQeJc/sT9+cM6PVa89+Kld6GmK
 C5rjlGIBfySv66lbquGSUsduSv9JeQLOcCR2DizkT/UsqniHpUHwfidRRJav/PE82k3T
 lDc+vWP+s26kIAxOa1TCOkmfXJpTXprZEIybeHeFdDCPMIEBX4VqVVVE4Lx3a1ITPkGz
 w+Z70Ol3mdrzInSWlTuqS9r3ps3RkYrYuSMw541OH2VROO7aDf2vPydE0n4qAWxS9kT3
 YiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524596; x=1778129396;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=720Bx1bKlVjFNst/T9lTike7WOGhI8gorlmW7itupxU=;
 b=MsHHmXg44P3q/lLmDBLJ/r5pfMKx1OP5yXtOH/hzuB9CzhbpAvnV+2Z5y27B1McJMJ
 BRwhRSpTFOwNo21FzFmPZT5u1YFqb5ygGm6qIAQBlv4TO0mx9kAfXTlCTokCXmV7L9ED
 uyslW1HW6lXRZd5msOiUSIavnpzJ2oGoWDrM7TXZhN1j9NDpZwve9Z0GEEPMgbrW+WMh
 KWffxgGPtrjH/CRC3ZwJwdBkauhz4iYLcM/omAXIgGbwDLsEdORsrY6RN6LL+Vd8ylHh
 n/7nbWmi1n/IN+HxLsS0HOc/6a839K7b7KzJ52HIfxstdR9xVhuaitl6n9rAXKWVgOVW
 Yblw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8r7w+kXqhKMM+Rp1RCAYVfmAyqLGgE6ApGqRGK2XDjcBdF2oeJDytJgd/jM7N4HNkiGdHodlH8/eny@nongnu.org
X-Gm-Message-State: AOJu0YyiBNnv12937emCOPxhTJJCKD27MfKw0G+skgA+ZNx/UuZkDR9w
 Hw8NzNw2eMPpB1ddXxMA38rw63gGB/rjM5Odm9j4srBOld2rIytm8GSTLBpleetUbVZ222hzEoV
 nM+vB6iw=
X-Gm-Gg: AeBDieu6qL/ig1nk0YNgsmITt+bYNeqRFyoa4on3v6tAqbQSbKdDm2X7sJbUSQcViV7
 kXNnOlJTaZ+bRrFk8uZl7AmlpEMF2uYRhTUyTDe9AUvSdfkpN9iMQ7jxXr86IjeSaPKd7E/8kx3
 1Uk1aCwoUc1q73UNXVYSGwp0OpPMOZ3n20tZwmpzyq1dQCUU1tjZbgtws1cs5V3Dn5G8sNjaOm5
 GYseEsW+lq5Smj62bmu5uPTQ2AUaEYhva3PsTfTaO6QcCrF4kakH6BScDf66GBNYSycU/pcoivu
 Ib9xy2ROoQwOZ6fyoOKlzWHlOeWFjOgH12RdGv3me5NqwsqOZLv8eMtcKy1X8jUu30Dj6UuCIL4
 7jl/D5fXHDi7BucdAMq9xdbA+scKBJ3MJ0t/Y3foJYEiTzpWqZkEnpH4SscKL7eb4VxXSn9lu/M
 KhUT3JrnD00uY9gJhNJw74dQnRBx4OoVRoQ4lPPB995GckGIAMn9ggChXOWEVKrun4zTYz3/HsB
 +1e
X-Received: by 2002:a05:600d:6:b0:48a:7a10:4f3d with SMTP id
 5b1f17b1804b1-48a83d031fbmr17544235e9.0.1777524596323; 
 Wed, 29 Apr 2026 21:49:56 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b91285esm35001465e9.5.2026.04.29.21.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:49:55 -0700 (PDT)
Message-ID: <d680f1e7-69fd-4c4d-bc3d-0c8c31783fb7@linaro.org>
Date: Thu, 30 Apr 2026 06:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/40] fpu: Inline float32_pack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-6-richard.henderson@linaro.org>
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

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

