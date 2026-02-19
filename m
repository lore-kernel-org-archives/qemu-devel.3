Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FAFC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBFf-00079o-W4; Thu, 19 Feb 2026 16:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBFb-000789-1W
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:07:55 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBFY-0003p1-3f
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:07:54 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c6e77ace76aso773806a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535271; x=1772140071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hLeSjFDqWwEgb5X8ETWGegP5UjU/vFcYTc6FWMSq+kg=;
 b=JrD9WeRbNjsspddLuT6ZjO+S+WQNBJ1KlLd5SThsQJCa7eIB/dezuQaEWGVuDn+cTY
 2XZOvcaqpLtpKQH29TMaW6UVX8GrRP1V3B84Ifef36XjpZpGoaNWrHe/ST/fNgYp00tx
 xf8gC7iEgWq+KcCjLsqQOnJqK3ag87+MZv7qunPz+DnRNn9dh2IDl1pa8iiUB9MDbtLP
 o5wWbH9Iowmzwu2XFrmw1XDBVjKLlAQ7fx6Zmoc7J8nXK6rRiB2BkEvAZP2QlUcmGTog
 QsYk0A10qtAxh0cAC3CSdu+P1z6IshoI1/rhCIHjdsm3OmYBfTdY75oka+Ajo7Cgp/73
 tIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535271; x=1772140071;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLeSjFDqWwEgb5X8ETWGegP5UjU/vFcYTc6FWMSq+kg=;
 b=flyC3sq37291q6k+gSOeohtFcyGmbffk6CBs6w/fUdct99DHiMMAZ4oKXyKQtDGiuC
 Kfxu9uHr2hl8ng0EGEFyTLQci+dKp9z+n+NZQ3k+sr9w9O1jlXKl9GrvEdgplOQ/B61/
 I8lLKgU4KzNuDkvYt21g0nHauJY0sOJn9cGcE599ZOTNUqsR+p/ZelHY4pQvpAmxAFc6
 HAHEs51NHnAEGJuH/pZH7Hk72mWO2udqQCoDmZnm4EBCIe1Tg6jKDpq/X7ICXig6zHYU
 NJOIlYneaDHvwdaEDldTSizNHigRSkMPk8a1xiFe1VbsQxfF0pB026u/PylWbDzpK5K0
 j15g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUllLcQ+2pzvSUyWZesOcxlHoFj/HxBKMJikLCecJtyCkeM1GF1GzsL3TvWeYEnKyRfbnnltUmifjgU@nongnu.org
X-Gm-Message-State: AOJu0Yw3DW4jPA0sBS+gR/y/9EfzGJD0T5Gs4KtUzCLH2UA5zkS1gyCM
 WAMsV2OYNbb7ATKTbPGiE5lD0LohXqtyka/HScEjwOJFZoD5y0d2UQiACWAaRkfiI5GeOQR/WSp
 1mM/M
X-Gm-Gg: AZuq6aIRk4/5hGuuTrSttGzO4h5E3tVrqM0oG1bZPuc1aMsHDMo42TD7hFz+l3XBNQY
 V1nS7Q7A47+8izl/hrJ+bX/Ul/z5KJxmZkr/EzzVKIttYoPGN0flYYQaU60Ol2DDIEBOIvl6qoe
 oX0EaHgtjUEnBYn46jzpALXOQmnJpdM2ufgweY9fjqobYOiG44GX5/l8jnc5C6haqjGligvFOz0
 gAzMlnOStug/Vhtfi8CkpHm6rWXC3+FTjyUL/xHiL6Qit5vXATI1+4F+f/xyEP311xveSBijdwb
 5WZIScNwpWghkKR4vCA5mUH3s0XC3xHKEb6ExADio1Av/qEgYnx9/i0IhAAUxsvoxq5JcGFtMsF
 lfOxSrnvTHvADUtZY5clA3mG55LCaaApfwUEuvGXnIRaTSBm66uaAQKlm14yS/jHmuUSUBxo0v9
 I6CO8I73TO82RdjkaMRarBJKimg/giqqtd237XjC19v+YF6z6RhE6Dnm2/EeyIr/UpMvxoascsJ
 mEbhuo=
X-Received: by 2002:a17:903:234b:b0:2a3:6b54:5d42 with SMTP id
 d9443c01a7336-2ad5b1aab3cmr39378165ad.59.1771535270562; 
 Thu, 19 Feb 2026 13:07:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa4a0sm175245955ad.14.2026.02.19.13.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:07:50 -0800 (PST)
Message-ID: <2757cc5a-5ffb-40d1-b777-ccd6598597ee@linaro.org>
Date: Thu, 19 Feb 2026 13:07:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/50] gdbstub: Always infer gdb_num_core_regs when
 using XML file
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Rather correct inferred count over invalid manual one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 4 ++--
>   gdbstub/gdbstub.c     | 3 +--
>   target/alpha/cpu.c    | 1 -
>   target/ppc/cpu_init.c | 2 --
>   target/sparc/cpu.c    | 1 -
>   5 files changed, 3 insertions(+), 8 deletions(-)
> 

You can merge this with patch 7.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


