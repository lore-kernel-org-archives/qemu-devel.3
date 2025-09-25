Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4A6CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kNw-0005YA-NV; Thu, 25 Sep 2025 07:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kNl-0005Oc-Ne
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:43:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kNe-0001dU-Tg
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:43:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46cb53c5900so9703055e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758800592; x=1759405392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDAiVucDnTwiiHSxzVHmrYEGy/lbcg0azc/QRJqtC/I=;
 b=CKWEbo3saEYKuaOR8C8cVDfr+atBl+i9ZDlVdPw8GoSzG1vv5LAORTHIBbv+kUBF56
 9TT54hIr9sPCODp+FxXcZ0EWY9iuRI9yn6LW+NXqwyXf/wDjLCXKAlUDkFCXDkNX3tCl
 qq5wHBgtDByJOxkOQT+9cpPtlRGRENuMOzTl5EmzYgLETwaqp6M5ZMx/0P5lQ3asb2DO
 RXEL16ZcwYzMqwY/X9UDTQJelld5Nzj0UZdL4KXIikO3sxH5BT2sSNJSAFvh7c1Mc1wA
 KRDgXUltypiVjZgg2+djzUzKpc4lUaiS8sKdZY0b816rNgzLl6APXYtugm5kMjVrBgFg
 76Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758800592; x=1759405392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDAiVucDnTwiiHSxzVHmrYEGy/lbcg0azc/QRJqtC/I=;
 b=pFdMkjTIh+OAZ09TDxMwYtxWPQ1gsARIXC0D0FffbzRgR9IgLd7mCHRYsqtR1BN+2o
 9SHMMxP+vWyCv/xpDlAfkHL+nFShyOEKJEVqZg74hsHJAlfnqwBqV0RZXgJHUt70gn7G
 oHn+8yzO3DqI2kOV62XW+PxwrfQ4A+i1BEhACun5H6We4sEmpKGKe7nxk1Vf4HplUxVV
 tubko676Nxv6lmVb+l7IFJ6dVCO0hyTe87xK24OHj432FlLITO06S9qAJ99Rio0WhLhR
 SjSumoT3dg3RC0lKGC3oURg+JKhr4COgTw7IbYfVbqOkH+8o+aL10HtfaI9F588sojIS
 31rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVIQYjno6cVPu0TNgj+d5SCZ6BWLn9MhVdxTQI0+nLiTtBm4Ok6MWmw1l7VgU5MR0nTwZrj8QfNi4@nongnu.org
X-Gm-Message-State: AOJu0Yxl0tYyiKtTtF1X5qCy6DZuxoQvB5XLMfJA4XGc1iB+5bC3IWrN
 aXasqNR+iePv5LkaRsTOAX7ZXm2VGfjSIXpDdofcS4Ous6Dhx8QlFPveA9JW6ylJVvK/1RJlalE
 JEcNUtL86TA==
X-Gm-Gg: ASbGncvqO2JZzz+23v6zk7YpAuLln2p7VdETYuq4yH4WyAOmp95WcVo81ZCAf+Yecom
 z/iIL/R0ms46IU8566GDDv6G707l3B+GLIwW3LRI8e9Pnr4rST0J9wXlHMk5Eug3YZ//Z3CkzYi
 n3bLiWg4rySswzNVOO6832nnbAtedg3Z1tAARfdUhSkjh4YAx1el4ntTPWzzYvQtIHuV/6LWKbf
 p4eS0vVcdAq8hnDND2c/dBZ/ZBFYuzKvkuPT8zzfnmQN6ACwUvrY4qXhGFhaMvDdMC1t8kg1O0w
 mQszlJXsn5ltliwkgMNwR31HwmXFTK2qvus0Ge7kBSD1eS0eE3UoqAOTV5FZ5nN4ADXaUhsZ+Rv
 Quz+iThvFs7Rg868NC9JiPsfqaCoM/QErTe8IVRUlZ5DH28+uARyTvyDEeWD/GyKYtf/WM3lZ1X
 Aq
X-Google-Smtp-Source: AGHT+IFaue5fvSvcPsIEl7AO3PTpHy742pLhtYXvvg1srHIoH8iPWLHMlqmnQJfOYgI1fbhgJwfHcg==
X-Received: by 2002:a05:600c:c163:b0:45d:cf5f:cff8 with SMTP id
 5b1f17b1804b1-46e329b9b49mr35907885e9.11.1758800591973; 
 Thu, 25 Sep 2025 04:43:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab6a514sm73285275e9.22.2025.09.25.04.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:43:11 -0700 (PDT)
Message-ID: <c204a427-8f08-4f5d-8eeb-ba23ce4d8ef1@linaro.org>
Date: Thu, 25 Sep 2025 13:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/36] target/arm: Move writeback of CP_ANY fields
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-30-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Move the writeback of cp, crm, opc1, opc2 to define_one_arm_cp_reg,
> which means we don't have to pass all those parameters down
> to subroutines.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 52 ++++++++++++++++++++++-----------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

