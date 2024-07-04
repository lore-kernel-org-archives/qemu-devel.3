Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2912DC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPJ0-0007NG-Ia; Thu, 04 Jul 2024 12:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPPIy-0007Mr-MZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:27:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPPIp-0001Dw-SA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:27:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so4370325ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720110442; x=1720715242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUeycCgBZbDeKm7s1M+jgUmQIYF+NoHOXQxH4p91gLI=;
 b=NhqaU1H4ZgxdbHUVS5bVhJIAthu1/xGHoeilNqXdE7NOYLzT3XkJKbkqAvHxArvzx/
 mVNuFxx8AkfyqPcOLOs6kfgRempH1bdHSHBCQJa/B9LtLfDqQM7debbjmkaXN5EIQejr
 5uAR2ghYUUh0m/amMtD7KEEmdeGjgWQCrhIQoxk0ste6/MX6ubmJGZCpzgh9oIz8XlV9
 ZItFkSQf6dtYKTBTflFn4iAGh5mWn7CRYfMaglHzCDEiDINC5Cl1EHWZi/oGcgdQraRX
 kzYCA+4DBZnWhf9itTR0GJtrPKSjjPcrbX+oYPJtFdf6L+HBcdKkvcJQfVeoaXoy5rEV
 eVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720110442; x=1720715242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUeycCgBZbDeKm7s1M+jgUmQIYF+NoHOXQxH4p91gLI=;
 b=cOy3w9xgdo88+kiFtkoRz0htTU/jZA+lY6vpVHnZYG4q631ymLx9TGnPx6PHb42DPc
 SuH6CdJDpXT9CRhjU+Eg8seRs/kqtGM0apqNOW1kXsmUFPxWQWz4wn4vTTIPw2Hafj2l
 kpJEyghhREFaJY0MRtjKXUbSMgq13GxQkLQLxvGfqgRWuQvX2ASTXX93W7f7mU8mUaR9
 uPKfSiT8bjyOTFw+79UF+vUTMYJjH9yall4opApzgl0+wzo/RcI9BX1lbNwMRkpPSmtx
 /uvWkp1Gfz9z8nkecvataTUJhkikdIkmTPdDjO7zEVBB5ZalmaxFqvhvW29oQAKlAdeg
 c/lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYtp11su1B/AlrENmNK5SP0mnPHhuPsoB0yamuzZwot8atO2O6nNfsVJRlW5J+y+Wo4DPQ6zc0SXdT3faCqeRcUixVkK4=
X-Gm-Message-State: AOJu0Yz3C/ohG+sjDK28ak2IRTgU9SPHlFF317cC7VcNdD3CRVHtMhgZ
 Kh+VO2jpMMdaJ9RsVd6DcAiTR02R7MvOz4Rzo/TpK5AG4kgD/IuuD1qutwMQHRk=
X-Google-Smtp-Source: AGHT+IELFGD3KX9I0bZiEfBQv0cokdhaEJxCBscKNLcrs++C2CpLTMSOYZOgJFsp5KqBMaNMOlD+aw==
X-Received: by 2002:a05:6a20:3947:b0:1bd:207a:da31 with SMTP id
 adf61e73a8af0-1c0cc74b5a1mr2014584637.23.1720110441878; 
 Thu, 04 Jul 2024 09:27:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a970d53sm1741085a91.17.2024.07.04.09.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 09:27:21 -0700 (PDT)
Message-ID: <f28d8de4-3e9b-4410-a250-25b40ca768bf@linaro.org>
Date: Thu, 4 Jul 2024 09:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] plugins: extend API to get latest memory value
 accessed
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702184448.551705-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/2/24 11:44, Pierrick Bouvier wrote:
> This value can be accessed only during a memory callback, using
> new qemu_plugin_mem_get_value function.
> 
> Returned value can be extended when QEMU will support accesses wider
> than 128 bits.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1719
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2152
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h   | 32 ++++++++++++++++++++++++++++++++
>   plugins/api.c                | 34 ++++++++++++++++++++++++++++++++++
>   plugins/qemu-plugins.symbols |  1 +
>   3 files changed, 67 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

