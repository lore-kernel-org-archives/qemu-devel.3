Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED396C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQJB-000888-4E; Thu, 21 Mar 2024 17:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQJA-00087j-7p
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:50:44 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQJ8-0005rh-OH
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:50:43 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e6ad82cf17so806596a34.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711057841; x=1711662641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RQiwwpF4GBt4EuIrXVlpsYZPnPQQiUvhcbbqjSqKpMM=;
 b=e4BwZxiNHWhrmj7dorcgi9xzpX+2dCXidzzz58rJEZjyAiv4o+lHlNOzcvW9OiYCyv
 Z2U9mM2grIDjeZi+Xu8VKTRzipnyT/e0jEKkiKie+SX0Rb6IVsUcbQFRIXnuH0HTnj0t
 8xxF6gPlQFP393JFIfVL2UUuTJ0gmebmIF+n7O8iPMdQfq7WgbNX8jMlO3n4WXv7j3nY
 +0HrcWfrijme7XoPbWD9GwNBuauVxWbqgv3W/5OxmUXz/yaoU15eFnjmwH1OdzoU/DJr
 n2D56bBOycXfbOHhEBwXxdBl13s2Fq5dgKB+8v53cl0Rr3vcv0IP4TdRHc/4hRajramu
 6PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711057841; x=1711662641;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQiwwpF4GBt4EuIrXVlpsYZPnPQQiUvhcbbqjSqKpMM=;
 b=tmo8ohiRCVuoYw79UHMxG7lnXC2NrLBZsgNnO3tIjupfFhh7WvMrSbUs+uShlzvR8w
 s4VKKoGc6pEjbtK1MAOgxJnxrecXA6Ty4qxtqx0tZ+A1ciMx0BdKrdqhLQ3MTw1G8+H4
 dcQUP3I4Nfd7U29rh0UpsKj3JN1enwlSCQF/BxPKjI4YF+3fNGpWgddn99zkRNy14bzf
 LHzK3OVeZkg5qNsBHGFbSHmGfJNQ6BC2FRznln1f3es67yCbdvnZVitTRyfXYjiVTwAP
 NsZtl6Z9dZvi9aX8O08tmXN9AggHYxbxViC6zt3ZigGcGc/efOT13J9CfOFeOr/LwUdH
 cp7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpJ1F2lfNUbp9vAm30653oxV3veec0DUn6q+F2r66KPHXSKowi4aevUzDVXD5sNYk6O742nevzBXLPuEYei0euDyh11iU=
X-Gm-Message-State: AOJu0YwVJu0aVwKEXsmMWBXWd1yMvi22vX76tu/7ldwM2ef4y03uiK/d
 kXwcTuS1TpSfMSAJpJRjrVhuI6Dy1G/t51iaU0M58Hg7H8cJXOAL90rf2zQ2zsw=
X-Google-Smtp-Source: AGHT+IFsAqwBygwZoYu6fkqG9jUkoCvb+lmlkXonEMfVelcqGWG1rgO4UrOUws7b0CYqk2SqAy176A==
X-Received: by 2002:a05:6871:4099:b0:220:bd1c:6d48 with SMTP id
 kz25-20020a056871409900b00220bd1c6d48mr508794oab.49.1711057841589; 
 Thu, 21 Mar 2024 14:50:41 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g3-20020aa79f03000000b006e6b7a88e64sm314923pfr.73.2024.03.21.14.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:50:41 -0700 (PDT)
Message-ID: <ae88e204-1a05-4dea-9b3d-0d32366923b1@linaro.org>
Date: Thu, 21 Mar 2024 11:50:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 07/21] target/m68k: Move MMU monitor commands from
 helper.c to monitor.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> Keep all HMP commands in monitor.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/cpu.h     |   3 +-
>   target/m68k/helper.c  | 222 -----------------------------------------
>   target/m68k/monitor.c | 223 +++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 223 insertions(+), 225 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

