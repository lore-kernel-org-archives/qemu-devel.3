Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1882C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsk5-0006ix-0x; Wed, 19 Jun 2024 06:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsk4-0006hu-1Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:40:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsk2-0001Lc-JQ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:40:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3629c517da9so1441344f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718793636; x=1719398436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QCM/5Wuvw1kMp9E+vqBLzgz736JjECRqns4n9Ozz6YQ=;
 b=CrUtk1Em7/4FXwBFsKLAGnSxBI9EouwEaTnTfGu3HSNk7ekFcpz5VL/GMlWnJ4d7QO
 qkhztjbFuQapuWjodLY5hON+WtHJS2gr0MZt0EDtxn51sQHj7/LKb5p2X8X+TG7cOChU
 GHGdzLXzAtH95nbgY7thCdjjd0Umo3Q9BlqSs6Iu83dQ/4Ixm5WtL2OvAtoVhbM/8es4
 AnaxbCrrNMaPfmerN5p/tgWjzahNmZsRHnjgapo3MpGgWTY+wqr1XAToDh1/uBIc0jNi
 ix68ERf4khFiqsNrDVPPHbvoCH44WztMv5wna3IVqE1/aXUb5oYM/xyTQiCaoi2S4XMO
 7hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718793636; x=1719398436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QCM/5Wuvw1kMp9E+vqBLzgz736JjECRqns4n9Ozz6YQ=;
 b=YaqCpQIBJnVnvWjd8z/os/ZMvSIcUnVpZWA8XxnEOD5QyEjK3aDXHn3dvO1Vz16TIk
 LRdalB+KgLAPSr9TYIDRUcqIoFnNtMTKDu+bZGmywDg05IRZfqKwS2vPHSDf64/ZNJ1z
 2+xEb15dm/+mtLmrmiOAV1X9fHS1323kYPnGI1dTH0AH1oV0bPguGR83vdV7lcwiFeZ5
 xgVWHU/B4WgGyT4itAwPBT+Gyedhi28G0IZDDuvXDDMiYSf+URTwgUUkO+rESUmm9qXA
 0fElLNJLfm2uok87lSdk7q/iX46+iLODmPaaNUPm4+/aEoHD6ahj/fwBWD8SmkylkLj/
 vgVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXORguos6vjrmFYjdIquxuS1TtyiS+ZxXrpsQskaFGfqHju9XNPNOIn9Ccs8Lhod+zWc5jnvj2Wo0MNxEzNm2w6I9CJD1A=
X-Gm-Message-State: AOJu0Yw2nmrBKzVKcML4fKI4Z5JlUW9LdJ27PBmf86CF9FbI2R5rqsnn
 nndFSTCdyb8iQ2PtOhuwQGQR+VIUNLGGbkV+G5GP+V4sOFkKIpCEa36V31dVM4M=
X-Google-Smtp-Source: AGHT+IFYAMQYHPWMmF54Afr0CGsiLM5O2JVAvZjvOPGtV8ufZpPnj2dCTDHGo217cU1E4wS1QFP3qQ==
X-Received: by 2002:adf:f144:0:b0:360:8911:a7b2 with SMTP id
 ffacd0b85a97d-363192d063cmr1802142f8f.55.1718793636054; 
 Wed, 19 Jun 2024 03:40:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362907048b0sm3334346f8f.24.2024.06.19.03.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:40:35 -0700 (PDT)
Message-ID: <4e725d93-01fe-42ae-9873-d7324c30e50f@linaro.org>
Date: Wed, 19 Jun 2024 12:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] exec: Make the MemOp enum cast explicit
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224528.878425-1-rkir@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618224528.878425-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 19/6/24 00:45, Roman Kiryanov wrote:
> to use the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: I785f2e65d192287f1f964d2840131b653755648c
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   include/exec/memop.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

