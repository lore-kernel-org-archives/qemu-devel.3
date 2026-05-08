Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D70DCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHpQ-0002x6-U1; Fri, 08 May 2026 05:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHpI-0002tw-2O
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHpE-0007Mj-VO
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so21332955e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233731; x=1778838531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I4tBkpd2G3M3jUrwfXSsOcWBNXPeyhH6e4+UOK5U0mA=;
 b=dJSZwneuAXWW2JTlwAXfudrrpusfHgQdoIizMuRY2UIWFxcv13b2Mqi43oZOuJfD/M
 x5jaqWo3uvkW0FzxfiFhJs+rW8mEHxxP0Jhqv+MMRLU0mIicQ+2kI2cG3RmCA3dDm3ac
 8fHvorJwgaRsADOclIIggZ4h6Q/I5yvYkn6ogVx5wR/buRgdZic6ILaofBdg9hkjHNo8
 bTmtYomToz11jsnd7dRMQaehLrS+tYwevJKMY9meEPitMU6DJuufSxKmUjkSjSqvLBU0
 CUSr1HHFd/oU0IEE6s1Umbi8YgWA8WXdeDYghWUdYC4eYzgGpxVqI6UBaEzOeuGfZ7Oy
 STwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233731; x=1778838531;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4tBkpd2G3M3jUrwfXSsOcWBNXPeyhH6e4+UOK5U0mA=;
 b=eZHVDIlzKsWU1rr3A329+F4P6DY2wP3GL1SOk0KRkMD1zlf+SONyvasBdmfSuF2h4A
 5y3hylH4ltBMT3E/KqjuoSGS2dwqYn+7wVLo4QWG6lSs2OJxmwQsvwDWZVOkI4CseVPf
 oWWGC3++db+gOwQpo77hsxEZNgjoCjyjJRLIOKtidFAE2qWKvrCXW7fJiy4naNv2lGAG
 PvW4VI1aTOPq9S1pfhcUlyi9jzk8phghzIz2evj2tR49tomELggedxX1qD6gH0EM39Cd
 KQFqgFwZT8hTT22O+3uu+/+QZ40ZICFkZjU36kWO666J7zptn+pwoj8Zn61vA1ihvTw6
 YIbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iGrAX+CR8wSE2pQpzy65M3R4piY5tjTDSeJIlfzy8WHrVvhfG9YGaCTpjUS/nxebD1XqGzeZI0zAj@nongnu.org
X-Gm-Message-State: AOJu0Ywynp7dF20J6hNDnuAtyx6tFovGAZvSuGt3MuJR872kOl1i0Wh+
 GUqryhBwP3U7YTlwj9mR295j0C2oLbtSV6XiHiFt9Z8OD5eFb2iTl+gcaVTmzSda2Vu0Mw4+H5H
 uikr+tB0=
X-Gm-Gg: AeBDiet8u7/73PvKOZbRQ5fDD5OXTKm7Go2K37i0HMG2q24f+3sq21puB06H5Ac3F5C
 sEnV2ny4M0AgUWMYtm2MwmGDz5hfEZ21jP59jRvX0R1puWPb+l1mjD6e9P55yMvUkYms+WfwO6h
 antjSFjKW9wqBYxIF135u40KscHwfyxANLdGk0DqQpmmDd1NKlR1DmDCTjeMfHmGzGCXHnpILLl
 Op42bZagtTpHIN7dmBPpEiHuSops+hqAEp2sFFC9ZXPSYd7o2ZIPCYBZGeNanjSRcLmhBfTzOrr
 3lbrkoCJq+57cxw6dQf3UYAgtti61O24GEsLXWZplwkIdHbJjzUlKzBTKINHeGJ0+i15C/Xi+yg
 0neJ5p58m7+Bas3lEedSapSmW9YDYvzWeFCpNySpAWIsFIlvbLMww1RNEhoyKZD/YqZ7WldEqxd
 wA8p14SQXj8GHniOTEJwHSEetY7uBg0Phqm+JcPu5jrhcwuLK8cDIb5zN4Sh7yMc6iFYQseYm86
 JLTlxxh
X-Received: by 2002:a05:600c:4f45:b0:48e:6262:3df7 with SMTP id
 5b1f17b1804b1-48e62623e1fmr78947285e9.28.1778233731239; 
 Fri, 08 May 2026 02:48:51 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm3005348f8f.20.2026.05.08.02.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:48:50 -0700 (PDT)
Message-ID: <bf3edecd-b161-4811-8efc-fd2fd2290dd5@linaro.org>
Date: Fri, 8 May 2026 11:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] fpu: Use get_float_3nan_prop_rule in
 partsN_pick_nan_muladd
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

