Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE53FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDAP-0007h6-6V; Wed, 14 May 2025 10:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFDAN-0007gw-FB
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:33:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFDAL-0006nX-Rj
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:33:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a0b7fbdde7so6777775f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747233180; x=1747837980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gOkDOHuT9yRPQObNGiISzCDO48nXgG6/L+agRWL4kpA=;
 b=FYuVBCmuVxXLPHmeiSbxSC2JzbCeELw8Izj64hi+QRfcrsB3yVT97O8VYCM9pSdSoA
 UjknZiWlAuac4Dh+v2MQ+G/NZOCez96J9Yju+TaI4KNEUuQXA0EwhSOOzMn46M+RuM4K
 CWmxmElvZ6ANNTnU8ZAEEUIojC98zcrwrjaYbIi/jJJdbfx8yXubXvg6v0Yo1PF8nP6i
 RjMORJjEQVWUBRqJddK8wd653iWYitlA3SReUiQPCaz72l9wpTFJuyoeE8wVeQroNgfe
 WiWdo/oWgrjdIwMHrc4/RcwPjsWqq7Rifz3PaonxGOU5IgNFeLP0YLWFLVtUAzdoiGB4
 TR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747233180; x=1747837980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gOkDOHuT9yRPQObNGiISzCDO48nXgG6/L+agRWL4kpA=;
 b=pvzstRGlMQ7NIQA+3Q2mkLjYChfiWOCjz/RFAOdGY/vI/ROY6UDxJe6Tao6UeIVogf
 KQPt+6xAdJ6vicR6htPWhOLzmUjJdhGyn2U8tpw3RlahKfxBuRPNIxo0YicAQPwSVq99
 mX8vD4GDV1bahLBkVbeAn9cKpSsvfb1nIOBLwX1cmIXflgd5jATF3oHELw1oRQU9EcvP
 y7pz1XFaqtWGvOYak6ULg5vkLgLa16Ss4XgYGPbh+OhyaMUOvM3/pDtCe/P5fxotVJaX
 srGPvFZTpWejcaC2vHHVuIsVa4fcvjwA2HURRbXXmRIKHRxa5xZmi4FawJZA6sEmFLxD
 7m0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcCp1USjevyMGs3vB1/2PXG4NdLIKnemNH+T5mwTGxRnXOHWWzGxPSjAhgFEsx1DyC+TqcS5wwJrAf@nongnu.org
X-Gm-Message-State: AOJu0Yzk/i13/4pjgvw7r2Sm1ImvmFw0Z2ElOQTID0Wdl+J5k6IvkyCi
 6rmVInbNm2LD8wGsZqi7rQ1xVQb8Wj/odLec6hAQkSfNcrmhaLRiDrWxdG+nEOg=
X-Gm-Gg: ASbGnctqyle6Oezxvmf5aI3gm0/lm9TGoWimZNYjkrDyYlMHlcInE3q/NrlwuNrzsCE
 6dra92PwgCQb7Be6hlceI1WmtIUUWKPVQXKZ9UzZdZ2viXzVLPNAFA2N+fwyEWxtY9uiKgpkfjZ
 XTUYkgEVfKcSXLXpQ98guiFMV+AVyAI2rHW153xSIEdFf+IWerqnK4U3wZNPhAtnC8hgIwW2PGl
 J2QAQxVq5hTEd1X9XGrNniNneqJ8M/DxzpW6IW66XMIM3R4CmsF5g2mOE8cwMpmzu+EnlbEf0n3
 LKl4TPqK5eWkXcQoLhjwuMmRoK3e/IuWlw3lmw9TZVS1utTztNWcgJaHo7pQ4+R4za1OSSpYJ3D
 r+Q7Y5KbKlEzN
X-Google-Smtp-Source: AGHT+IFSFRYzE81n96oeRvJqDjjfVViCu5uF/4N3UfIiD0+6iCYpAfOEx+3lrcQCxWqC4bikeuNF6Q==
X-Received: by 2002:a05:6000:1cc9:b0:390:ee01:68fa with SMTP id
 ffacd0b85a97d-3a3496bfec7mr2483440f8f.24.1747233179730; 
 Wed, 14 May 2025 07:32:59 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db3bsm31340665e9.9.2025.05.14.07.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 07:32:59 -0700 (PDT)
Message-ID: <312d6556-5d77-4101-908a-fa686ff24e9a@linaro.org>
Date: Wed, 14 May 2025 15:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ui/vnc.c: replace big endian flag with byte order
 value
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250514111931.1711390-1-berrange@redhat.com>
 <20250514111931.1711390-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250514111931.1711390-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 14/5/25 13:19, Daniel P. Berrangé wrote:
> It will make it easier to do certain comparisons in future if we
> store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
> flag, as we can then compare directly to the G_BYTE_ORDER constant.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ui/vnc-enc-tight.c | 2 +-
>   ui/vnc-enc-zrle.c  | 2 +-
>   ui/vnc-jobs.c      | 2 +-
>   ui/vnc.c           | 6 +++---
>   ui/vnc.h           | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


