Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84945C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0pA-00067P-9O; Mon, 05 May 2025 14:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0p8-00066R-4t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:45:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0p6-0006Z7-Hy
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:45:53 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so4288483b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470751; x=1747075551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWTftBhQdOlFYtj6OF8kiijXsH+rAoychvoACwsGJw4=;
 b=IxlJlHPC96RkiRCoSFaOK0mzJaqE49WckKrU/eLuigA81VxXlsp250T+ODkaS/pgwM
 wbiID1VPvC/wGnP9IQkMGj/wqI0fHPSjlTLMsfxBDiOdmKVn38oUGFGLcsa6Oem9UkN0
 XxJBD/qeJY84DMvuHVdgyTz5E7/i42bUeLNl78ywczua9CGbQiYDxGoOEQqpWljJ4Xnt
 GnmyRgPTJ/QGXvUyqDHVejr7emsptWvJoJYbmnZFHSmcyspfCgqbI2XcyrIf7oxmEz6K
 HnRG5p+ZMIpJhxs+DlWBUSzwc1xu18GcXtybJziLXYtOy+hx504zJ5d/yhz9LHKzPV+/
 T10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470751; x=1747075551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWTftBhQdOlFYtj6OF8kiijXsH+rAoychvoACwsGJw4=;
 b=SRMXyvFn6ZIEqilSes80TG/Ko7xQ91Fpm7c4hxWbW107gak1yuO2FQ+iO00A59NUG1
 30FVbk70S1hUjWHaDNNZ3GltAwwcATe9oA7jrQv9TgiDbRLjmMC+6MgTD8SaSIclk3eR
 5OTFu+N2hGIiAY97MEjDpjO762j7eE+TGoK18TgmuRjd9P1zog26BrwEv7wpkmO+1FSF
 qCZ9VsdCDisCLSExgdNxaa95a2jUpQK0v0A/qI2l193LgG5jgvxAueE9vmlI3VRZaiat
 pazhvMeihZ4j2XiQfIaK0Q37mgiwXVL24+dlKOvjsiXkkcE7J2hzxtH0gcTvV78a5Bq6
 kmQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD4X4bH5YuZocVcNEXyyYINOJatc7PNSuqplH3m8CHKJqiSh9Mtrt54gLJgOYQtbppYBjOCzGmDue4@nongnu.org
X-Gm-Message-State: AOJu0YwmvxFQ/miSBUvr7Hs/MIr59wvXleQyaEAPi3uXPhaxCrK3ZH7o
 IAIPmz526lGcCe6+8Z+ZPKgN98w1kY1cnAp2Togf/frfsVfRwEY7occuO1vQVHc=
X-Gm-Gg: ASbGncverwU4qn50Og+lCb4N8TGb7JLgLh2GcVST7t/d9w5WxQWaB2r4wUn0CH681nE
 oTi5bpZ3tQO4/lOjRS5IhVhQttz/QDYACGrv1zZH5Rc+TtR+Mxfbcp9CAjnysBL5ziJvfSB9I8S
 ZdNmALWkoJm1O+6rlbx3bPjj7+1CmvkiHF1KNspTACIxwQ06NQxAeMi+A9LSPQfxUaTZNARpuWb
 h5cbOjWmkMMAzCRErNGpzaNsmWBOQP4PxenWI2Ix4kUTBH2f6i6wWlJFlpS3SC+W/khmLSQYjH1
 wvJdTFl8uEVFH9ioJQj2M+hj1qPG+n9QzkY0QCrCTxu8XBh8C5N6EFvUHdypgZLo+2vOUmZF1/X
 N/R3Rkxg=
X-Google-Smtp-Source: AGHT+IFBOsH5CpfTxma1JoQvpcL77zl4kO0LTsZyBNW1tuAbC5hqFDV3tzQd3HoxiOwVaQVcEYEh3A==
X-Received: by 2002:a05:6a20:1589:b0:1f5:6c94:2cc1 with SMTP id
 adf61e73a8af0-20e96ae6ab0mr12225551637.21.1746470750828; 
 Mon, 05 May 2025 11:45:50 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020faesm7445748b3a.95.2025.05.05.11.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:45:50 -0700 (PDT)
Message-ID: <fa968652-f8ad-48a7-a320-c38c01a6bcc2@linaro.org>
Date: Mon, 5 May 2025 11:45:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 45/48] target/arm/tcg/tlb_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-46-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-46-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/tlb_helper.c | 3 ++-
>   target/arm/tcg/meson.build  | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


