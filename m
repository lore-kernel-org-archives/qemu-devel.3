Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A72C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsP3-00006z-H7; Mon, 08 Apr 2024 13:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsOz-0008U7-QP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:03:26 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsOy-0004sX-A6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:03:25 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-36a14c1de0bso11943695ab.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712595802; x=1713200602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0graTNEdq+iBZlF2oks9fsW6xkH2LN39jV7CT36JB8=;
 b=gc7lY+Cd2Pz97CaOvHORikGxSdxb/1PrW0vhCt7JqWuglY1/CotH0lGUqxbQN+Lvv8
 0R8DGl78+dGUDlGwq45V/NbykUEhMaDbO03rbsRQ+UR7zuuXlDeegEUKU+HJXWoRqm1D
 RhByRPjbkFHV1kemP+vUqcUjKopxLGWoZhCuyt4BVd7kGdtIPwFTW1QnVWY8KGhIeUqV
 avDBWAGWArTtxRa5eOeUDwKcRgLcmO3iGTwKUptBxrFoOtTwEppR8aBWT4Rhlo6ils9P
 XvCIMBTcwLDq/ImJ+ic9eqOXZQaOLC8apUYqjnzT7y7aFLKnnECvTuJCTqQ1XkNz9eRv
 zVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712595802; x=1713200602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0graTNEdq+iBZlF2oks9fsW6xkH2LN39jV7CT36JB8=;
 b=hL3EIPyqMzhwo1pkmtDCu6Ehb5eo63I7MBF/P4iQHddrceuv8bCtueIp1hfxVOWqTj
 sKNCvZ7LvsogcPSu5z0AvXwErAa80jw0N/35YTR8CuJ8D8IX7msZApQ/i02vwWWkC/SS
 khS/I/nbVo1gG7L3j5m0Yy1U0HWSbwpzB5/iTKqkhE3JHnkjc+r1F1p71NY4eoXCO9sx
 hAr/MUl/pAwZUe9jQsJ8MlM0tJ3WU41OTFcGiRtRwYkTlhKA4OuprqSjKAhCyi+SoIMU
 VjFWPzokImfFSAAP61GRFMuFDMkuqkYwvVNBun8sfoQEUSTjwDVlED8NtqIn/8/O1pQm
 LmAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo1H8Gf3PGLwy+VpSWVBmw8JPPgi7ugrth946XVetPUNfAjG0E8W4sze+TyPIz25HMaFgQaiWdys2Kc2455kPiRNw0kos=
X-Gm-Message-State: AOJu0YzkEyhxKGWPv6ReaCvh3vaMUVWauIw8tjZCbrezDkWqgL255Ye7
 DHVxaB4BdrgSq8DvGZvu+xjIGhH8UFSvNu3rhCha+S8smQ8Lg+9PIYLXGQzwL9s=
X-Google-Smtp-Source: AGHT+IG3ccz+IutaEuGFfi9m1XNbWtyjZpnk2lSYSaslRe/pF5RFQq092jMcxrte+6Vwv3pjBze++A==
X-Received: by 2002:a05:6e02:b21:b0:368:efa4:be07 with SMTP id
 e1-20020a056e020b2100b00368efa4be07mr10143836ilu.18.1712595802530; 
 Mon, 08 Apr 2024 10:03:22 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a63e256000000b005dc8c301b9dsm6786446pgj.2.2024.04.08.10.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 10:03:22 -0700 (PDT)
Message-ID: <4e7210d0-b95f-40fa-96c8-a387de297d80@linaro.org>
Date: Mon, 8 Apr 2024 07:03:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] tests: only build plugins if TCG is enabled
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> There is no way to use them for testing, if all the available
> accelerators use hardware virtualization.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   tests/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

