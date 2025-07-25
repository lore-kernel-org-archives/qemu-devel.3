Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D4C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 18:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMiW-0008EJ-6v; Fri, 25 Jul 2025 14:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufMhV-0006OJ-FT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:59:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufMhS-0002Q3-Pg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:59:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-75001b1bd76so1683284b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753466357; x=1754071157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i6Mw3Y1Rgetnap0DkWuLvPXM65MVB/MPxZTevfcCW1Q=;
 b=RcJELWIu5xVgQ5D5GWVwK3RaWJ2PErq+qz6+E4IHgkO1hPewTmr0Dgdyrf5d8f6aiB
 xTo4tTVdyudl69H+asp7Cf8qTrHORRFR6wpgSbvaaw7WGE7kDeWqveZaqefXBj3SAG6W
 fO2pzi2wRPTVzzARVrUOZvqYs8z1GG1hPlLQtCesGyJdTiprubIY7UegmNXQ6RFtVLAQ
 IkInXilPEwxWO6hjFUevvwYqxggesLDN1lXB9CVGIoempmtGJTgJBOYvYGL6zxscSZB1
 3qCYc79zyGCbFwMCMJDQbRSHBDm4UdsVfKFQG6TuJ/UEaUVAq4Vslg3LMoQ6+av+xZdv
 p9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753466357; x=1754071157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6Mw3Y1Rgetnap0DkWuLvPXM65MVB/MPxZTevfcCW1Q=;
 b=DRLsPr2a8FxLsVMYcywFoM2CIG8vYcVCb7amnnBRtZzWGIY5FVRAiV0t/DbfpiUX6J
 NnKuEjtQ7GIGPPEL25EOcuL0F2TXmrANhHQ84UjJ2BTYn9i3FAzohVn31RwNDsyYQzh+
 j5zVT32OFEKZ9WazcyG3pquO/gdF4/XiYH54KPukqz0eretH8Ox27pQN7LiidXcPSmKb
 2UBrgW8mo1Z4hAL6KgUlFjHBMTyo5AbqXa2fELrLq0vdprwQLY3BzcuxA1bQu5mVmkMT
 DXHWB5icyucVXtuxkLvq9bzwHarf+RnMA4HETRfbdkD9HzpOqTzD0Tc5mlCTzA3Ko6/k
 8QfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqpRal6elEyK7w8hx7+lmLhwn3PdeFuzaPqj5FGqCWK8La3skK1TY8+dEHecNxVoxaXnr5TVvP6rog@nongnu.org
X-Gm-Message-State: AOJu0YyX3YXkrIctyCeqGWMxYeiEBqLy/AxRVf7c7RmGkH+wO2iTcjLe
 eogB4Sw9Pz+2DqlWpRWMG2VpjP3dE/3Tq+p4ck0Mn+JmiI5docMONhHL9kx0ldfJjqg=
X-Gm-Gg: ASbGncuRcM2FrOEx13X8tGujyFwtiCNYw2GJxf+2Lbt4S6MQxIrVUNXWbR49vlDTjDM
 2XGJE9VVfkyl0JcldpyFL3i5azcsR4IDC1WsaLmEDjSY+81+4EnfVdD13sXdMUgSbwwv1x4+p3i
 HTAOXa2NJCd1zFLWJxFn5mxIvlOEntQNIvH9xXJF8UkAAcb0zwaMXPf8bJMP1UN3xRo7j1SKl6T
 6r07wMzE3AnkGYdVmVIw30iw44tbXKA2F19s/GLeCS9S4JcxzgKqo5FPz7Tp+2+/JWw77IW6gKW
 FWVfPT5oiu99FrP6LLe0u+AJIu39umW4DUteZR7hsBwndf1bK/ZA8Ejx4DEAx+c8ElmDjrWuFut
 +jUWva3t2Ug1dr7IXmZ7ygPaNi8kvIwtwvQc=
X-Google-Smtp-Source: AGHT+IHUc6Ox0a12wAN7XVO3vKdX93YSHKWVIVCpm8GdNJXRiNzotvLF4wuYT4I/4jFPFWZE0cOlag==
X-Received: by 2002:a05:6a20:734a:b0:1ee:8435:6b69 with SMTP id
 adf61e73a8af0-23d700528admr4588560637.1.1753466356999; 
 Fri, 25 Jul 2025 10:59:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6d6312sm303063a12.62.2025.07.25.10.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:59:16 -0700 (PDT)
Message-ID: <48fe453b-02a5-4606-be2d-c00e45f72efd@linaro.org>
Date: Fri, 25 Jul 2025 10:59:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.1 3/3] linux-user/aarch64: Support ZT_MAGIC
 signal frame record
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250725175510.3864231-1-peter.maydell@linaro.org>
 <20250725175510.3864231-4-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250725175510.3864231-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/25/25 10:55 AM, Peter Maydell wrote:
> FEAT_SME2 adds the ZT0 register, whose contents may need to be
> preserved and restored on signal handler entry and exit.  This is
> done with a new ZT_MAGIC record.  We forgot to implement support for
> this in our linux-user code before enabling the SME2p1 emulation,
> which meant that a signal handler using SME would corrupt the ZT0
> register value, and code that attempted to unwind an exception from
> inside a signal handler would not work.
> 
> Add the missing record handling.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/aarch64/signal.c | 93 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


