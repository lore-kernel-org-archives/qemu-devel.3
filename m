Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34476C47DA9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaY5-00064N-S8; Fri, 26 Jan 2024 23:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaY3-00064A-I8
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:44:07 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaY2-0008SJ-3Z
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:44:07 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e114e247a2so295444a34.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330645; x=1706935445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qL+FRnn1a3AvWCUwhwsLLcOY40ey9gVZzyhyPt0XUY=;
 b=WpbXvBwR+3OA0gI2OFEfyCfWiVfGw0TIdXtJgHMekuiCv/Hds/pu/tVIexfSlV9105
 YmpJV3BBYlS5oeP9QIFmX5QGQBEr/eP3W8gM2gfufek0jT7SwnN8a/HwZarnV8rVdmor
 P16MdlLRnC79wt+1Cg4V5e+s9rDH6Px3XQyDlJ+E9mrNEuYGghu0g8B0U96Hr2Wbu7V5
 CwCjTK2/FBLDN8G6yPbyVHfEYzDbsTlIXhcUGXDRZqFHewz6kAuNIu89lt3VKOBMOALl
 Mwa/qsl04Jx4Y2zDEab+QJerph48odGCfuW7eVkvc2BA4mYW6sP8eciJQ9IupbZeWJ2d
 Fdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330645; x=1706935445;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qL+FRnn1a3AvWCUwhwsLLcOY40ey9gVZzyhyPt0XUY=;
 b=T/V88rddhTOWeLARqfBNfp38Gn7vWfEIu0UzG/ubzEg66NGPRmMvVwsmcNb272Bd+A
 b/ZL6YOx3HdZK6jcCnK8IWkXQVAmz+RyfYY2CXY2ihnfheAp4w8hy8SEpzhgvOb8P7NA
 YEYsyliwVPUL7YOGLSvMBAbb98p5A6Q9+lMZHA255VJRJP86gDKhq0rCp5ryJPbe93S1
 M6QIGbDXafQPi2V6Iu2BrlmdKbN1+pWv252ExHp9tmyP/KMm97wT9OymNLKn7HqJWqo3
 0E8Lqrx5tf2IjkWgsha3hvM1BSyhiw6jbyWYQzslG9bFtaSy+hKiRa71rXPPYpUOaO09
 HR5Q==
X-Gm-Message-State: AOJu0Yy0vEX3leaHAN0C7HKKmI4Xcj68Gx3NnxAlQ7OnMz5CZh4JlBSR
 G6iZaA96wxzjvE5UIRS0PBtgFmhpWuqkwxxFcOU36BwQudVZE6uHUrGtkjAOYnQ43cznOWuG2Sr
 yc6o=
X-Google-Smtp-Source: AGHT+IFH4X0Iknp8kcBlQxwN/F/7YgMbufUyN+HYa0IwuY1LTqfOoAMc3wCsAK0Zqfy9GwtC1swLYQ==
X-Received: by 2002:a05:6830:11cc:b0:6e0:e7b4:4cc2 with SMTP id
 v12-20020a05683011cc00b006e0e7b44cc2mr984848otq.28.1706330644782; 
 Fri, 26 Jan 2024 20:44:04 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa78c18000000b006dddd283526sm1885981pfd.53.2024.01.26.20.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:44:04 -0800 (PST)
Message-ID: <d784a15f-20ae-4586-a5e3-eb6213306837@linaro.org>
Date: Sat, 27 Jan 2024 14:44:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/23] target/rx: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 1/27/24 08:04, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/gdbstub.c   | 6 ++----
>   target/rx/helper.c    | 6 ++----
>   target/rx/translate.c | 3 +--
>   3 files changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

