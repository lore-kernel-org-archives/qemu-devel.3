Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884CDC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRZD-0004Pq-4c; Sat, 17 Feb 2024 15:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRYy-0004KA-CM
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:45:37 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRYw-0000VL-Om
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:45:32 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59a8b9b327aso1089290eaf.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202729; x=1708807529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQkxEuZ1KKupyrZd7n2S/dtoK9dG9RrsFuLLvaqdWc8=;
 b=qQS25mVjQZ3fVajSNREhxYm7DhgBpy6QZw/ap+FW8QjxUyO4PsH2JduW9Y8A2m2ZpX
 OcEUbHU06a8xVwciv7sEc+ByrVviMASBqB9G6CoIL+dbRNl3sX2qskmW7IuapApBSCpQ
 VRGVveXE+cbOCcM+HsuUfCy7vZ8Afll7zEqTt9ohWVY9rGfzqRwDM1TX8ITdO9PPDG1J
 svD1331YLTmlF3uWDmqiqQgMb70ONg8vpfc8nGnBdfJhqT8xTZ92l+7Sf68BPQFmm0xw
 TIuMBoezoiY113v5bdjSocqnn8RJlWP7jr/CeQubWN//dkZBTlPmcgzgilj8/2HEtV+v
 OSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202729; x=1708807529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQkxEuZ1KKupyrZd7n2S/dtoK9dG9RrsFuLLvaqdWc8=;
 b=m5lRar2t9HBNDTLYALTBXn1TCt0gzGEJWGHBUl1n/ZWLbRB+rcnsvUkDUWm2JKJOnL
 da/WjOPproAImVim75p6J3mJJcYmL/ctZHjnQvV78bB8GOzc+rrSvu6/IWc3DE9GyxOm
 YV/t1D6g2OndEe+ZdJ5Tta3qOy/Jd5oTkYCuOKcG6PTJ/mCAYjtUjZkBVHe+KiEGaWIM
 GPTC2bLkLjp34p6CT0SKlxErTtmc88zt6YHwGYaQmgCsPoG7BjSJq85WriDUXeozch6+
 cZ1xv05kv803lj74/tMrSITwybZ4fOfRawzp5HU++fHProniuAm3Xn6xGIBK3+lkbQbX
 zUmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX0bUfvpx7WHgKVcSXPYnshmU/I9PysRQtx0sf+xd12gyXs9+HFXtHFss/uvhdJkOViVbu1iiOuCcs5DtnlQP3OoKI+Vc=
X-Gm-Message-State: AOJu0YzaI9Xw8VSvcJXLDTRWtqhTaEpbNXzBrhAtrYg7fEA+l9uxruUf
 qcX7RjxGOTn6eiZS27PwkQGZwH98ZUV2dE6V1p3WUfJstchmm04lOrYJd9SV7PM=
X-Google-Smtp-Source: AGHT+IGFQWvIKwYozypTA3uyCZtbBkvzPp8/M73Rhaccz5bR72FAAO89LTRammDImYPkPdi1VOBlfg==
X-Received: by 2002:a05:6358:94a4:b0:176:6141:48e5 with SMTP id
 i36-20020a05635894a400b00176614148e5mr10359766rwb.10.1708202729365; 
 Sat, 17 Feb 2024 12:45:29 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y4-20020a17090aca8400b00296f2c1d2c9sm2227236pjt.18.2024.02.17.12.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:45:28 -0800 (PST)
Message-ID: <67ffa947-5538-4d10-80ca-024c9a62e229@linaro.org>
Date: Sat, 17 Feb 2024 10:45:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/sysbus: Remove now unused sysbus_address_space()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216153517.49422-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/16/24 05:35, Philippe Mathieu-Daudé wrote:
> sysbus_address_space() is not more used, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/sysbus.h | 1 -
>   hw/core/sysbus.c    | 5 -----
>   2 files changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

