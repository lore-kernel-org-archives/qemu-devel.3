Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525BECCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uXp-00014V-5h; Thu, 09 Oct 2025 13:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uXf-000142-IX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:35:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uXc-0004Eb-D4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:35:02 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b551b040930so736813a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031297; x=1760636097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r06PVhndK3n832whWGmolmU2NJTHOC8i8TktkX8MhK8=;
 b=mI9wemJY7/uUAbRHdqOjTINmVVFAQDx60pxt4WXEw0EXsx7t8GuQgEkleLP7hmLZYo
 e2PERUupBKJPW/JDd2f03Gda6x0h5zEPYezAW9scNpCpp1+VdYCDBQNeNHLDjEIp/Wm4
 PFMqpqnCAHlMwawnq++QaC0LsVGGKG758CcQcZ37H9H0TQKxSbokPAA/HvZ5nh9FjWYm
 Z1QLb5o4fQ06cVL1UkFk5TA8N0qZ1yQA5iG/io8qoEZtKVLp2Rurav3BXRvIi9fyIO/S
 Am+4vRSm1CBSfb6Z4qCRHIa5BNmUic33RaEihr5x93HHqHZdpALyXBOjpbTXXvDzZGVN
 kQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031297; x=1760636097;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r06PVhndK3n832whWGmolmU2NJTHOC8i8TktkX8MhK8=;
 b=Lwdx8bPEMn4PjSZotIICqOgjgu9JYM6Ea419p8FXlZKGG6xP2Q8I3WMZ2jkXrsU1AK
 70L1ZCLdi56EnaNDKKMOcnJLFQRSTpYUELzTpBZGLSYA22Xtrv6Z4X4WZvUAbphH8bvH
 T2kapTTITxlNEMGn21bVBLSTX8uaJezmpmPCvCwdz0egXRlktLXRYd3qMwhc8OpOJPk9
 JpokDiQiRjUAepGaf8mxMT8CC5U42eRBIkLMHpuQIUtDCJ5u0vKm+XfkA4pm3la0f499
 iOrcjoOQG3ewr5SgEPSDIQKW3bzYxrTOehdM25z7d2vPrTRt03iD2gOCVZcz4QdYmUfl
 i17g==
X-Gm-Message-State: AOJu0YzLVX1lUQ+CcH8BDJpr6vY2TX9qidSH1qUfJ/g1nWrT31/bUpdR
 CfKD8sF/dtfgXek+PU8G9jWHTc0fGTVkF+IHcp6dc99SgotSiuE5LNbvOmbBseNiLma6uOxid6j
 f4CERjQ0=
X-Gm-Gg: ASbGncug/Fw+jJh61ZLWJ5EqNgrXBrgX+Rl6DPP9nVFBrThoiMZQdqyx2REOzqVuWtn
 sX8/8vprIhk5TYfKbSdmz3VR0qQtse2ZW8xZnuFmsex2f7nUt7q5dyl27erLV77t1Bfv6fxRkrv
 188sOTPisbsS5vB2cf+Lge73ve1flELnw64MhQNNhwXf1w+Yn8CY394ctevZuc3b8D+Lovhdhf0
 Wgzn8EnKaKgubz3DDE8sv8o2oHV17Nd/n//CiHc4iwZRQtOrlKyrIonFPEZitFIgvc+bbTa2+84
 7upkUCIy2PORs5mCyWoc9LgFCS8delrgctIPFsoNGj12TYGfgTt7k8t/EysuLPvZZ/d+fLcoBwr
 GYk0PzXEpAQA0KTztoCYUcqlp1uODlwIK5ROXl1MbSRRazpzEwsL2Va5gkoccKMJdbXiys0bOtz
 E=
X-Google-Smtp-Source: AGHT+IGXvMef1X7hfWl4k7fTRhkRS39ZKozNZDmiXFLkvyOqqmIw7+8EpJVeU1exi/0SmbTDzfSylw==
X-Received: by 2002:a05:6a21:6da8:b0:2f5:1e1b:33a9 with SMTP id
 adf61e73a8af0-32da80b8365mr10990059637.5.1760031297011; 
 Thu, 09 Oct 2025 10:34:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d09a87asm292566b3a.46.2025.10.09.10.34.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:34:56 -0700 (PDT)
Message-ID: <f69ef519-2a76-44b3-bd84-c3527af1e156@linaro.org>
Date: Thu, 9 Oct 2025 10:34:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] target/rx: Factor mo_endian() helper out
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/translate.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

