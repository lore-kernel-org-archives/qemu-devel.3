Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C061C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKih-0000Yj-FH; Fri, 12 Apr 2024 13:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKie-0000YT-2p
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:29:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKic-0003T7-HW
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:29:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41804f10c68so4213235e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712942980; x=1713547780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cbRPCFTmbo1GHhkVQNr3btHsSV+Q+Iyig62nJWvBNN4=;
 b=oIajfy0N0f+fc7/L3OuwTUg6jAsfyN2wxd91v5YRrx33xN88bjWzfuENbx8B3qCpu/
 so/sNVD1rAmTpV8uNwBIW1HJxU0LpfqiCkc4qRaORGkjG4P9iJEKeser3lwa1tPYAcPh
 YILcBznQIlvUTVUaMzq0oq4vzg+HKyxRsqnd1FCGcb+DMDlDQb+q/3M5OtHmq9ctcjmO
 gocLhsaqQL7buiT+zuqM63w7gTtMPVsLyCHTeDjozy+9cCUDEvsD03GIaCSf5HcbdwlZ
 UaIcsfYPSi0XKrGVomGrmjEPdylkAh8rWOlspQRDKhU6t67yKyvi/OghEMjZJrb3PkC2
 dLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942980; x=1713547780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cbRPCFTmbo1GHhkVQNr3btHsSV+Q+Iyig62nJWvBNN4=;
 b=iVHDYVORcQ2I3WRVvs3NMAflV0bKGQeU1GOLfm+iUOT8y+iavSHZ1J0K02eKYr7wnc
 RyHy2oNaZ25VaDZQAfCHgNOMKiDjOjTA1vCItjUtZxITtc627dgC3PJcBb354nBH5O4d
 hz+c7MerAGGLmF+TAMeVPfHQVQFDyv3FFWEdZGQzniCXEWfj1ZuMsVCCnfSxa7871SBK
 dKUl5X9siPHjv7/UKiyjBqi97UErsNkmR59T3xTG0wfqhwK/maej7tsQLirm4okZEN0y
 bcxlUAnFdw5BidNCdFLQBItmrp111RuWb+BuBFofDI34jxfRfhR3riMuVo+3c+nG/8Eb
 FX/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1LUDvqyEidgd+EYHeo5YOXuoAAGeN0LO1b0wn9wFx6pvf3HnhikeNIr6jdN0IzSukGuPI2ieKdQhkr5BPvDle1D03Xu4=
X-Gm-Message-State: AOJu0YxfnEghchMx5qPIkslDw+AZcVX8CRABBhxrmEZz5A0t7ZSLNx0O
 HdVBm2p/Xc2Iy6Gkek8kk0vbh4D9TQqJMk0sk+lez06yOQO68NfQEzXXMkBbRKSF2hfZ4XUsUsv
 M
X-Google-Smtp-Source: AGHT+IH11FaBPs8NY1tfO5g9battm8z7h2O9XdARZakoTPcW5cswgTMIrfopr+bRcw3brlAygc/hbw==
X-Received: by 2002:a05:600c:1c1b:b0:416:9af9:487c with SMTP id
 j27-20020a05600c1c1b00b004169af9487cmr3080286wms.29.1712942980042; 
 Fri, 12 Apr 2024 10:29:40 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b004171f151a5csm6194970wmo.16.2024.04.12.10.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:29:39 -0700 (PDT)
Message-ID: <83d338e5-b370-48d6-b215-7fc821440f94@linaro.org>
Date: Fri, 12 Apr 2024 19:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] docs/devel/reset: Update to new API for hold and exit
 phase methods
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412160809.1260625-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/4/24 18:08, Peter Maydell wrote:
> Update the reset documentation's example code to match the new API
> for the hold and exit phase method APIs where they take a ResetType
> argument.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/devel/reset.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


