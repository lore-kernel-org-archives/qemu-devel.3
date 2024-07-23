Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875A5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMZz-0004md-Tu; Tue, 23 Jul 2024 16:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMZv-0004dU-Ry
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:57:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMZs-0007Uu-3J
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:57:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so2870672f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721768260; x=1722373060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WgGHxjZPhlctoelwvMgxWGChoJau4/Y6c8l3JtInLWo=;
 b=SjTbYhRn7Zd33Gwg+u8xEwAF5QoDci2elvQSIykESUxk0b1lWvuhSEAicTuZ61sL7V
 xZyHUV0li2gIY2xkHUlG3nx2eAkOQJ/DWRYx3iTausZp+eXkVHdok1dLyAWYxGwjHdZv
 inwDdn4ODV2drSgCvzme9dFpxX/asXpe7TthIIKO47ZHgh18wv+ApHIdVwCSrzA3WbW3
 u+YpzH0Ns9s934RKMAliKJxeBarhhIF5VVugxgGqYQhfseu0+0TxVlZJUZI2GkiR/nFn
 rvXkVnBPCRZUlamPeYilDC9ZeDph3uXpjxkdCRRP13JWyPFwJay54e90kLGBG+Q7Rkfj
 KxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768260; x=1722373060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WgGHxjZPhlctoelwvMgxWGChoJau4/Y6c8l3JtInLWo=;
 b=oKIFaRbkBGh1uA4xPQNxKnAjLCxvuHuf02LhW7PrlzJtPHxYz7843YAcRsCSLHaYrP
 oL0pQr//5xRlVkUsrbJ7DDIrCMsgEKQxpi7/7VhvLr+MkSJoVvHkrZ0s5AGwkrE+qdvB
 svnbA8jU2Z+q0WE+nkjcjPgo9mbXoqp/tOZIzky08nCY9DOoxTDUO5FJ8vpHOW7eGcnp
 eQmT9szGrn6dcG6WNl6hghaZnbe2EuhaS3bnYDq8A5LK6sUHKNRDh1caiDLl5QoPDZAF
 4Puq48gAEoR3wTASxBdM2Px51zUGNji4/CszTSnwZPX8j6vW59/9xS2l5vMJfGN0j4nc
 c8Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqk6CvKjH8JjNX3p/sSxUXlqpEDf/Aac5jZ9Pvlk5MVzvfyPbdpinWBCVnFbeymoOgR0qW/nPm2tb37h14pV40GGF3618=
X-Gm-Message-State: AOJu0YwDMuByUQhP5DQggQm7dGdC6x5o3XrnNXO4AJCUipZrVMHcoyCz
 OQ3zp/HsF0mbSxxE9TpOk3Gx4LqQ41Kz2ArSYOQacY1gFI17QXgQB3CjkiooOkA=
X-Google-Smtp-Source: AGHT+IECoLRmK3EenYxNHRXDQlG8Q9XPjW9yvDtAMrOaj/+fkVq/e4Pw6HrWCZ5A8Bl1kw/gNMjtLA==
X-Received: by 2002:a5d:6350:0:b0:367:947a:a491 with SMTP id
 ffacd0b85a97d-369f5b1a2d1mr46980f8f.26.1721768260267; 
 Tue, 23 Jul 2024 13:57:40 -0700 (PDT)
Received: from [192.168.69.100] (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr.
 [176.184.50.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9372a6asm997335e9.12.2024.07.23.13.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 13:57:39 -0700 (PDT)
Message-ID: <3741f4e6-34ad-4d2b-8ff0-92534f7e248e@linaro.org>
Date: Tue, 23 Jul 2024 22:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: Avoid shift into sign bit in update_itlb_use()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20240723172431.1757296-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723172431.1757296-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 23/7/24 19:24, Peter Maydell wrote:
> In update_itlb_use() the variables or_mask and and_mask are uint8_t,
> which means that in expressions like "and_mask << 24" the usual C
> arithmetic conversions will result in the shift being done as a
> signed int type, and so we will shift into the sign bit. For QEMU
> this isn't undefined behaviour because we use -fwrapv; but we can
> avoid it anyway by using uint32_t types for or_mask and and_mask.
> 
> Resolves: Coverity CID 1547628
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/sh4/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


