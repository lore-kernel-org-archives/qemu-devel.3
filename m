Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF4CC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJiX-000450-5k; Tue, 23 Jan 2024 11:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSJiK-00044R-Vr
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:33:29 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSJiI-0001q6-Ec
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:33:28 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6dd7deb57d4so583926b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706027603; x=1706632403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JzfTUmUVx4D7HEnd6YIJXkXY20l9mcZwVc6tk4Jj/pk=;
 b=i1hnA7UYGBKcK9ivcH6JUtkrhWQfmYoSBqLcpBjQmENpW9IXV/1Rz29SEpOVNzw6TY
 G7OCqSORccFG0GTsbpN0F01kk/Qs0qHceF2VUj3CGOAwSm0mPBenXQ4unVdtF9asH125
 37UHTjLf1AZFH8oD98IBNPmU1t79spycRA3CrETLD3n9uxvSLd4DhIMaGlYXDvgAijd+
 Mg3qp+VLLwVCGAzOaPr5fwKLDfmr5oaGZYeQ/96sRGiPToqRufw7u47e0p2Eya2w0dFD
 CLpS04OzPmRb8qws8L42QKvSspksJEfsTU0yzMi+KsFQUlkQLwbOlXSdTDg/nGJ1MwNQ
 6C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706027603; x=1706632403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JzfTUmUVx4D7HEnd6YIJXkXY20l9mcZwVc6tk4Jj/pk=;
 b=NIWrOPU6bYTzYJsVoLVdVb7HSPvU4pRII+O5MMQTlT3ihWHLzdzECgWz/yBrQo+iP6
 7igwQEELHb5mqCClCKWlYD7xpRPllZcFSBbMBn8+xmlyG3/D2xVmwJFclK4Vycbrnylb
 aRSTOVGx8IuKTxE7UKHbnMU4NW99jZwQh8LR3BrQeArgQytgw9VvX5I1XvCsMfnm72P1
 Id0Alcp739zVfdyHf1Kofft3eN4F+EI1x+eKk1wU+6vGU9FdNfNyvegXeIw/uQKNl2i7
 teSn1usfa30dWfYzBkv0ia8PyCOSSvc0rqJxzrT0e9HEI1TWM3xJM9u4tEXp0LyebFLR
 wRZA==
X-Gm-Message-State: AOJu0YxhU1QhpJmaQch2RaWjrQcnMnNZK9O1kjrutdurj7tE+F7UOtwY
 Ak+ksIoHzP7uQ3Lb2WIlnW6jK8io0m3d/nTXcbjLyXvuICr0fdzSahDYMNN33eEETjdCLFHGefV
 Mcds=
X-Google-Smtp-Source: AGHT+IHpapGE/wah6BBnhwMv6w1/khfDx2/axY8O3VGRpN7dMJC053lmBUn6hKNuCwmmPoIUFrTAvA==
X-Received: by 2002:a05:6a00:4656:b0:6d9:d506:3afa with SMTP id
 kp22-20020a056a00465600b006d9d5063afamr3812281pfb.60.1706027603599; 
 Tue, 23 Jan 2024 08:33:23 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:94f0:22fe:dda1:1842?
 (2001-44b8-2176-c800-94f0-22fe-dda1-1842.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:94f0:22fe:dda1:1842])
 by smtp.gmail.com with ESMTPSA id
 37-20020a630a25000000b005ceb4a6d72bsm10064271pgk.65.2024.01.23.08.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:33:23 -0800 (PST)
Message-ID: <70ad1d52-2dc6-46b1-82a3-983840ab8861@linaro.org>
Date: Wed, 24 Jan 2024 02:33:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/34] target: [PAGE_VARY] Move TARGET_PAGE_BITS_MIN
 to TargetPageBits
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-3-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> TARGET_PAGE_BITS_MIN is now defined as target_page.bits_min when
> PAGE_VARY is used, similar to other TARGET_PAGE_* macros.  We still pick
> whatever minimum the target specifies, however in a heterogeneous
> context we would want the maximum of all target_page.bits_min.

Do we?  Or do we need to reject different minimums as incompatible?


r~

