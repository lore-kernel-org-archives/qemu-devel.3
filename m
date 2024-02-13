Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F54DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxjw-0006jr-UA; Tue, 13 Feb 2024 13:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxjv-0006jg-9L
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:42:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxjt-0004LD-PN
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:42:42 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so34644515ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707849760; x=1708454560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MkeRKkSoAHSY/hUpon186ZbX0tFP32NPVO08IW35BHE=;
 b=FULir02BGDRBt8g9ynb7WjnoxaT0X7PuF11B/+5TQuTJZCY9gpAj5v+Qv7Z/ErM6yP
 ULKyQ8kusaic/+t7qOrueJuPEN9klGYfDxIYdigBCvtPqXilEMXCFteSmfYosS7ExGjF
 Z6z0927U+G2H6jX/VotaYqzBRly2mOE+nHXVmAwOTx0ZdlFSbyvsJDvcivU2tt86882Z
 +SrV0SCfSpKyIH9TPpKFDUm4hroPbMA9gXE8H9AYvXdCwWwcmzoZAYR9p2RieUimqdBL
 snWgrv9R83CgbVzM/a61TILKvdea2eDbFTddsMnUaWPbK3OFCNjZM/eDi95yyCKqSih5
 kopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707849760; x=1708454560;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MkeRKkSoAHSY/hUpon186ZbX0tFP32NPVO08IW35BHE=;
 b=aCKTidzVa1QBWJG2nkbh19kiQN7Uk8+p22t/cUrmJloCrnwQDrwilR/q/dEfO+4mID
 QohK2U5RIDmwUjtEdz5PfAfYX3lWvlvBjZjTU8LTYcfzfO8dlJDPdy7rostpiZi0+mOO
 Q2NdZ0YiIEAIQRkqaORMZq0X6GGMC13LaVLLYU3osydfBRFb/ArXAQaeFPkuOv9zA2L1
 tI6ZdOnq6KeokHnOiQ6OvVLppLw4Muvh8fU0iUSDDLwDOwO7eDJeZZsYulO5EHinm+QU
 dIzJgId1rmK8YiFuZ3pzR1C14ucBezIk5H6e1B/i1rHvNStI0rXFRcHN86VnO8lqyxFO
 dK9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoMtw3XLUjutX8gJenoqvtBZJ9cMOF6LScT+Rln8JSZDBY4gXImPdnT19tIKf6DGBi1506yw230tZ/BVPcsT2mnV5lAqE=
X-Gm-Message-State: AOJu0Yy70R4/RXCNFm8mRSpzIyIGbPz6JhZBVouozki7LakN7KDD3l/d
 Bp0vckZFfSMGkvWZ4gvKdvzdVFayBzO9E5+cWguW64CmifxAIougcd5Am8CyCoY=
X-Google-Smtp-Source: AGHT+IEKFYdh80/95krlghCr/RPuQOsbmIDJpGKXTWVIydWgG7F9NgNv/PWXNhC+oc0TrubB3OwM5A==
X-Received: by 2002:a17:902:ec87:b0:1db:3a0d:1cf9 with SMTP id
 x7-20020a170902ec8700b001db3a0d1cf9mr421811plg.48.1707849759797; 
 Tue, 13 Feb 2024 10:42:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX3IDqIBja1e4UJZwUCtnXUXcTc8bU9vkQBdW3vdVtr3jB5Ih+eflunuT3SVceaqFy5ldJ1fec7V52DXFHhggDTmxtgdWo=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jj19-20020a170903049300b001db5079b705sm233013plb.36.2024.02.13.10.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:42:39 -0800 (PST)
Message-ID: <e8f4bca6-d775-43a6-8882-c7dc22a3e79f@linaro.org>
Date: Tue, 13 Feb 2024 08:42:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/18] plugins: add inline operation per vcpu
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-10-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/12/24 23:39, Pierrick Bouvier wrote:
> Extends API with three new functions:
> qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().
> 
> Those functions takes a qemu_plugin_u64_t as input.
> 
> This allows to have a thread-safe and type-safe version of inline
> operations.
> 
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/plugin.h        |  1 +
>   include/qemu/qemu-plugin.h   | 51 +++++++++++++++++++++++++++++++++++-
>   plugins/plugin.h             |  6 +++++
>   accel/tcg/plugin-gen.c       |  7 +++++
>   plugins/api.c                | 37 +++++++++++++++++++++++++-
>   plugins/core.c               | 23 ++++++++++++++++
>   plugins/qemu-plugins.symbols |  3 +++
>   7 files changed, 126 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

