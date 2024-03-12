Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2CFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8b7-0007fN-Ei; Tue, 12 Mar 2024 16:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8b2-0007Y3-0N
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:19:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8az-0001st-VG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:19:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4132f780ee2so1428415e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274771; x=1710879571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmJAz0tUdRKzAA89iohXxx77amlVkHrF67iVurtn1+w=;
 b=sWTsn21J53m7tbkPjwP679GAw5D9F6TizYh50jvEttLIGz6+8qI4AKGYy1eiirkr+z
 /xE46R5KKqVJ5oI4BTWGzfzvajef0hCr56WMTR3YcxAyNBsDer8r+BimPLoTZ9wKyWkN
 vLP9laAZWWO1141K/OODDkWI+Beu4RdJR5hm0oJssW+044n5HMz6bAfz8bh+b1XWd2nQ
 ZjHbKkyvKjL6Iahj80h40+5nh2z77TqE4ep368VGH82BEp18y6Vp85GGibJjdrW28luP
 41LiEjQ3az2zhUNFvDeXm7XTYmR11HnEy/C89ZZbPBSeurmhwEqpeqQkfcLSPMctpGKt
 7vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274771; x=1710879571;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmJAz0tUdRKzAA89iohXxx77amlVkHrF67iVurtn1+w=;
 b=nSPlJHyFsIDFue0uBc5YG820mXEnV52Z+DnijHAWKaxU61MHvr0FgndT2+fC4vDtIE
 QsAgE/ug4CY8VZwP814aEmX3WZwajiUJACIVPvoLIFwBcUHNBF+9/4w8+hUYicNxoorJ
 qWnGIZ3p5bO6mKKhCvpe7Z7RAQFEkNTDc9jiDwssLbModRm5zOP8oDTs4A8rMuvp5uHA
 YB/vXZX6Mgq5TQeH1CD24HK1D/aLJKsyYAediyKPvuFpv3bG6fo81fm0/5+PoXVMjFzk
 7LjdT86lM5i/e2+5TQyeHDE8fTZg7PpMo6oSqWJNPZfEKHYK20Ef4tVmmt/TLeY/9KbV
 Nfvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3gSBfq5OuyHnTaBsBwBN20Eei5P8lDx0AM+iwcDe5/wC1UOanbOHwKqwtt9TWKZsrpL/fyeI/Jqqr1gGHJQXMNuFHE6Q=
X-Gm-Message-State: AOJu0YyUpy2oLeW3uNGGcrKwX9eRn/bhUdZ2u4OkjKZxDaA0N+tJEmDW
 SrM3siiNK7Udr6DCk1YNu/AlGMyEgLagXMeH3W8TSWyXn5ArD3ykk6Wf0ru5sL6rs4slmfJUvqw
 o6co=
X-Google-Smtp-Source: AGHT+IFSLacifdzdfBvkYErRPRzUUbn//ubM6q5zsDAXf1f57XezzBL50g78tAgpkE92dgOH0NG+Wg==
X-Received: by 2002:a05:600c:450b:b0:413:4299:ec9f with SMTP id
 t11-20020a05600c450b00b004134299ec9fmr589736wmo.5.1710274770798; 
 Tue, 12 Mar 2024 13:19:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c458d00b00413e6a1935dsm621722wmo.36.2024.03.12.13.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 13:19:30 -0700 (PDT)
Message-ID: <206b4d2f-e3be-4961-b0b2-c08fd801195a@linaro.org>
Date: Tue, 12 Mar 2024 21:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/nvram/mac_nvram: Report failure to write data
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240312183810.557768-1-peter.maydell@linaro.org>
 <20240312183810.557768-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240312183810.557768-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/3/24 19:38, Peter Maydell wrote:
> There's no way for the macio_nvram device to report failure to write
> data, but we can at least report it to the user with error_report()
> as we do in other devices like xlnx-efuse.
> 
> Spotted by Coverity.
> 
> Resolves: Coverity CID 1507628
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/nvram/mac_nvram.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


