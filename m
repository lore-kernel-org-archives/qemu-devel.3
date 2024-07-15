Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D92C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIN0-00083G-RD; Mon, 15 Jul 2024 05:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIMy-0007tu-D6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:51:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIMw-0007AT-U1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:51:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42726d6eca5so29361305e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721037101; x=1721641901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pyo+vVixtiK5sC6vw7weQucbIltlfjpB1cudgOLC1EA=;
 b=V4/9W/1vVNTq/fJA1ISmDAtBe5sBWTLxt2eN44Q/hYPJ8d+H2c0pKcBBJqh42S66QE
 S0MeAm8VmW0s960amznvWzfNpL+UV0OvXDdQBfuXoq1YTNseGur1FoVdyGybXGTVM6LJ
 JZUWp/z8KEMaCMJADhSgOkjxXdHo7i0ktmXwJBNYfgyo0X5I3pLVGadyI4u+oZUfLHTJ
 k8c7mLx7lLxbiwDrXFoq4DXqPQ0OypuYnkluBj2t1eOiQ4tio0nFgruQefw6UCONi+J1
 OtY4SCCk86V7x7jT6/zdCfhJJirXHJ2zlVOw2/2Wui/6fiaUMSEWjp8Lc+a2kpAvn6y8
 pJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721037101; x=1721641901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pyo+vVixtiK5sC6vw7weQucbIltlfjpB1cudgOLC1EA=;
 b=Ee9jSY18je7i72cDEUBS6LDheOgQc2LNaXeCuBsDmKGv0QsFdl7H3i2TKEjiYfQGan
 0l9kcKl6stTItLG5JB+qu1pK4RO137+8s+8ZMvvMwC4KXEpdS0DM1WO917dBTamXUnPs
 30j+zpG0pHc3M6FRpcP8cgrZZy9q24THfdNBazyMF7E8B3x/mi1X8I9lOTqouAhqEiA6
 g+VSoYDCJL9JZozG3PEYfBJxoScUtVyMZzKi5AMps7S4bfgdXKxiBBZY8cENL2SBY/YT
 GsD/5W0qKkZnWGxIam48gWyCI03iYrV804Hf6Xz0afnw2KGckrrC4GoodWlGX7ZFN/fL
 BoQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSEdV7nEzMadmquuyTgkZ+1tZ+WGT/lceDHJ85C19GkqGQZrI/PaCtpWtsqo2JzcxKfXlIr5VwOCMVLXJbMWh28DHMO30=
X-Gm-Message-State: AOJu0YyrKMQtHWTsVo8m99URhICKyzT8pLmIJ69I/wmHAK2zyJqRUFMi
 S5Fsf5jd+tqPOhs2IimD79+9uD7P0yRFu3ReRYW698TWPaBULxx89GuztQqeoAs=
X-Google-Smtp-Source: AGHT+IGcSCqJUfWyRPsyqd9Xkz3OoP6eVCmTAMTzwStatatRbyMkt4oIvf5csQ0Ee7TRRhvs70r/dg==
X-Received: by 2002:adf:e647:0:b0:367:90a7:b72 with SMTP id
 ffacd0b85a97d-367cea73d28mr10771015f8f.25.1721037101128; 
 Mon, 15 Jul 2024 02:51:41 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0489csm5866483f8f.104.2024.07.15.02.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:51:40 -0700 (PDT)
Message-ID: <b0cf1415-0d01-472a-adc4-06625b1ffee0@linaro.org>
Date: Mon, 15 Jul 2024 11:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loader: remove load_image_gzipped function as its not
 used anywhere
To: Ani Sinha <anisinha@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <20240711072448.32673-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711072448.32673-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 11/7/24 09:24, Ani Sinha wrote:
> load_image_gzipped() does not seem to be used anywhere. Remove it.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/core/loader.c    | 13 -------------
>   include/hw/loader.h |  4 +---
>   2 files changed, 1 insertion(+), 16 deletions(-)

Patch queued, thanks.

