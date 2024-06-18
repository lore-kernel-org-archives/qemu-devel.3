Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhST-0008Nu-UZ; Tue, 18 Jun 2024 18:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhSR-0008Lh-Lv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:37:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhSQ-00086q-4t
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:37:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70625e8860cso726457b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718750260; x=1719355060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U4C7D4C7spFAWGzmhfwTd3vPD3M6x7333ekIsBAjomw=;
 b=xcGwwNN/jjGna/fT4qKiPXDfSx2c12wCxd6Eep09sTHxpmdsBlDwDArS/KNHU6HK8S
 YqU6brrnvWS0pGD0pvHI/yHNxBOe3dsH7QuIbJIkWWTiuMKw9nl88EEBY5J5fovvevaC
 WIy7mGUcfe+sf/rOcB1u8Qml9OaGRdOcBxOyEXthfMc//LBiBE/njRMzM9bqph7KDk3F
 zc2qOdEm8ex/3+A7ArbE9jbYG5PxvMxnvMtk/aEVtBfhOlxNIWMh7Rgr4HA10rsyo6+l
 4U5D5JqVHQzGhH7d17p/xGAeCPZfyqDHokajBpcj3H8lVLz7ac/WiJFuO9F4Rwa8FVzi
 GTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750260; x=1719355060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4C7D4C7spFAWGzmhfwTd3vPD3M6x7333ekIsBAjomw=;
 b=dUUlJcvCUaRmFpw/+dZyYitBIiZtrrwUTmNxfQ5IMKOJ5VISh82sOQjRvIDRGQmzC6
 2zR1Zlz8adY3hPjPK5yolGQ0SMuwEl0fwswszjbEXVHTC2vIgsh7mOtcf45nu53Tmid+
 cth+Ge2J8IMzeEWguYmaswz5uz8Z2OMyVZZ0Q2WSV9pZ39b44pNKmtj4Ge06YOOlsFWD
 wMrMoWuaDDc0yWcFMBGkqSCf2dVJFv+VG/zphItQWcB79tlri3X5Aq/tYwOYM1pNUO9L
 VVBwf+FO0Lgdq4OfgVN8sdaZ/54deBlW3XxZYmF0INcDJ0P/I01nPVGTUly+dEcq9/1q
 /ogg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYQQwXO3zIq+Jf75a7H/noUuRzrBPMsK+lbNt7u8NrXErfZOIDjJ+44F4fgy2X7RWCaBKh0lFptcN0D0w7SKsMB5S+85U=
X-Gm-Message-State: AOJu0Yzhy8jDvAcdBiGz8hZbiSOg2qd4nvcAGIBo9W4sG55axLudC0c7
 Un3Ooi7t/vdX3P0uFgcrUFP3AeYj/iEGjHIbU7PyXX22K9VFrnNjASBWPAtuaUQpN1xIXiz90xb
 f
X-Google-Smtp-Source: AGHT+IG5hwR+QPQwhAAV4jpPx9naaxrpPex3TuW7lxP3ra11+eWZKp6cWS3dB4EPI2WDP0YW9z8sbA==
X-Received: by 2002:a05:6a20:4c8f:b0:1b5:d143:72f2 with SMTP id
 adf61e73a8af0-1bcbb60f7f3mr811275637.57.1718750260494; 
 Tue, 18 Jun 2024 15:37:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc9669ecsm9401886b3a.46.2024.06.18.15.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:37:40 -0700 (PDT)
Message-ID: <22ff123b-a63c-41e9-bef7-7e51ac73f1ef@linaro.org>
Date: Tue, 18 Jun 2024 15:37:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] Add ARM AArch64 signal trampoline argument setup
 for bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-20-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-20-itachis@FreeBSD.org>
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

On 6/17/24 11:58, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> function to set up signal handler arguments it populates
> register values in `CPUARMState` based on the provided
> signal, signal frame, signal action, and frame address
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 53 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 bsd-user/aarch64/signal.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

