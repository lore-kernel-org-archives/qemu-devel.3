Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE135C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgA9S-00038i-Us; Fri, 01 Mar 2024 16:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgA9R-00038L-KK
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:10:41 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgA9P-0005gr-H9
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:10:41 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so2449860b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709327438; x=1709932238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D4HeIULekpGrsrojeqSX33LBOUEmQtyGU7qBzXdm0K0=;
 b=Rktp30KP/TVJKjqlC3sAtl74LqCVfR7phu76MNTKa7zuRH43YxW/I74ET9Nlq0npHN
 +9p61fVwpaIoOvYiYRNCaxyyJpUKoktdnJtVxnBuW3di4CwFpENImrLLSKWejwoLkOqK
 rfVvYbOF8exv8kb1rU7xVP4TDskgdVmM2XTMh8qXOOi3DvPRanqEg7LjfVlaM0XJJeCG
 x3TTWM+fiZG+hKjZaLSGiNAGn4uayMsHMvRc40Y6Pj4SApMd7qbaG1073rJ5IWwRXAB3
 0iTXHIZ0gPadyebCTl/fjRtQ1tVdNrvSfs8QkQ3RM1Qe7Gq3l8tR/XbEcatMUAkg+c3q
 Ozjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709327438; x=1709932238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4HeIULekpGrsrojeqSX33LBOUEmQtyGU7qBzXdm0K0=;
 b=U2cdju4C4WSC0Ks3+dG5VBJqgwrjV+AlaHV/1tEFVNpHrpwou17JNHJ8yI/jxu0YTB
 51+/5Bz1jBgGbzNk1joIh/uIhly7wCl9pGIqI0KPRrV1FTF9CYcxeB1tOf3yTdqrwoRg
 1v2YZGvH0JY61TlcgoI8+I/Et31D3i5S5kWWE5f4kcRrhA7KFPLNRfVQvONDMgv2Nznk
 k/CwulddDWUGbEwi9bQHxzCE0gmxfRDkd5Wm6Bff/lX3QvDu+7JD/kMhk5DttD6zLDN3
 nBXgxLIz/OFiCgJNfIcplSv+EzC0OlZL0G1FCkGFSKuSb/XBI1qWliAp0P2tprIDiOVv
 lKeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlDu0y6q+2J4YnCRUTISmHlr+h6pzkXQ1pUPH11a01PA1/++rGiZNFM8VRPs5rbLfMkKeV6QtYVI6HqyD01qnC58szg0I=
X-Gm-Message-State: AOJu0Yyh0xaXSG4Ozmg5HHhp+xXZNGyrz6W3HHNX3fi+ysz7oZKsGO2W
 QstSaWw21+MLPGgh8N8Mp7JN0NYX42TZ7C0kYuDg6Jmgc3WnsjJB/B8PVIcfHx8=
X-Google-Smtp-Source: AGHT+IFoV+Wit2vUo/E9txcyE3v6GFxsiBEhcJzLhm78y73oGJULNcexTPdtt1g+UsI+hpiKxzs07Q==
X-Received: by 2002:a05:6a20:429f:b0:1a1:461a:3320 with SMTP id
 o31-20020a056a20429f00b001a1461a3320mr75693pzj.9.1709327437865; 
 Fri, 01 Mar 2024 13:10:37 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 i2-20020a17090a718200b0029ab17eaa40sm3654043pjk.3.2024.03.01.13.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:10:37 -0800 (PST)
Message-ID: <6efb383f-4655-48ff-b787-e048ca076773@linaro.org>
Date: Fri, 1 Mar 2024 11:10:34 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/arm: use FIELD macro for CNTHCTL bit
 definitions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 3/1/24 08:32, Peter Maydell wrote:
> We prefer the FIELD macro over ad-hoc #defines for register bits;
> switch CNTHCTL to that style before we add any more bits.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 19 +++++++++++++++++--
>   target/arm/helper.c    |  9 ++++-----
>   2 files changed, 21 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

