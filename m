Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB2606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wwC9fmys
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0HL-0004Yp-5H; Thu, 05 Nov 2026 11:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xP0HI-0004Yd-SO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:25:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xP0HH-0000Vm-4V
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:25:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso11906115ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793895925; x=1794500725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hy8wyHuQK69vkTr/xS4f3XZmHdKtKMXsoOiOZWJqCnY=;
 b=wwC9fmysqKXzFZajLpyJC/Yahg6fykXpUtU0UgzaGD59jqpiPN2utvXbk9CG3NuTQ+
 +zRGTJ7ESF77pNDZuEtXptrWEL826rdIiddhIG6w9WU6h5QP+ob+C2FfeydK1il0Anvi
 sShhlarXsAQWSbqrBQicyyA0FMyJvFzVnIqf4u/MoisxRXmzhaHP72SUu7bLROXEF/WY
 S43ZmyGVYiM+/7hc5WvvP8s/voDTKSKG+6Iyg0JRXPIpyqQsRjmffH2yhNns9P8ekrDy
 CXVex5qLTRt8+kVW6wKeTl+3NKR9JAymg1lGdXS3WTM0Q0dFqmy9ln6HvRRQ6NiHfnm1
 PwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793895925; x=1794500725;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hy8wyHuQK69vkTr/xS4f3XZmHdKtKMXsoOiOZWJqCnY=;
 b=akeBVC0eT8RDQR9v2M82m3leb3l3cH2h/E78DYW2+FgAqlxN3kIjEhXfYm2GkDLOS7
 Y5xcYL+3++Fxm6ToSqopXToiXUPBzl2cjusGgcVi3n0/xA17+Lv65+kimPpkm21oR803
 1upFfo82C46EeK60fCUVIeaaPIAGnT7SPM1z4fXI/Jf4gi9K1OmV0ZXm8YyhRyit6Sm3
 wsUge+a/Q5rh0r9ccv51W7mHeiNACcTXgIdIDOoGXS1MbJ7UERs1eNMflFZtA2Ar7sln
 0Ti4AERVLtuHxAQVaodGnhT9U+dJoBM0xrH6iv2QhLD84YOIQ3NVnCJLCT3m2unGHVPW
 6TJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwF3h45YH5iW75yIcElhB/GP2GWwmaai9mex0hbAO2vmAMFp5luTZtwosudFMW+BI91Ut5LEFz5ATD@nongnu.org
X-Gm-Message-State: APuU4Z9dzNwTaQ07ktz24kJy+GqweIryVlEDVkOvWPB4O2ggINlmMZeI
 GrCX68i7xApLRGPfbPv4g5wTZidhIF1aHiLjQwlaxMjAOQyfBaCHuFgiNFQTM9vs15w=
X-Gm-Gg: AYBFou0FKeMlaNPXJgAZSgC7MtB1vFtC1beaWOI7aPDjh4p/zPuh35NlC7cQyYNzQQN
 QN6nIl4kvCJnPZCqhPwRL2LXtiGwOfrhcTwiHWdym+A1yEG3fnSnoW0MXJmxL14NeyC2Z20nRqf
 PtEeOoziWlWY5KzuOEb0DX1EKmSrFG7PpyBYDMQVsJ7fdsVyA2ELYwyIOhr9V0gVdGhj/RSVHeb
 /sffxiJojsQi6gTjc/uEgXbxGh8L/mVQEkdm8mya3JBtFh+j3W9p39VPE/IJdvS2u/d19UVGC+v
 sndRyCrLEWbnwQg2ZlzhmTf0wXsW2aPEma/Bcbar1GJc7iqFZL3MgNYLxfLlNoKXWeWDMXrj2yC
 KMRWy96q0IaMuT4jfamjh2TKmnQlFkJCk6+hk41RmIHYM4mgtb9eHiD9M0IEJXu0QbJxyoWLuzU
 PPg3T9ti/D2WelVETZjUXFt8WFPS8LJo0dNfdpZ20U3zZew3+HYkAmjQwoZ5OUhcnNIG8Oov9YT
 QYDup0LSKHMWjgc+rsM2Bd5uDrLAwHOrT1+aeRJrs9woeW1frjQDiFvfNP8gJ90K/38BZ2feaVJ
 7TfkzQ9U7g3zaC/WcPvt80zEGDgNIesplb0KxASLGBbNYe0qebiq8X7AVYvqPyZRS9SfaA==
X-Received: by 2002:a17:902:cf03:b0:2e9:8e0a:cc4d with SMTP id
 d9443c01a7336-2ed41c0ae77mr77295ad.41.1793895925398; 
 Thu, 05 Nov 2026 08:25:25 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed09144348sm20334335ad.54.2026.11.05.08.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 08:25:24 -0800 (PST)
Message-ID: <b2f25e39-914c-432e-a7b1-8544ed2475c6@linaro.org>
Date: Thu, 5 Nov 2026 08:25:23 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] pull-loongarch-20261105 queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20261105065345.966691-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 22:53, Bibo Mao wrote:
> The following changes since commit f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5:
> 
>    Merge tag 'pull-11.2-misc-fixes-031126-1' ofhttps://gitlab.com/stsquad/qemu into staging (2026-11-03 14:44:10 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20261105
> 
> for you to fetch changes up to 07a4c09e4c1c9de78b3ee287b3ac7b5badc0277b:
> 
>    target/loongarch: Clear PAGE_READ when PTE.NR is set (2026-11-05 14:50:32 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20261105 queue

Applied, thanks.

r~

