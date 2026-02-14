Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D395EF99F3
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5YI-0004KL-4U; Fri, 13 Feb 2026 21:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5YC-0004GD-7w
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:38:28 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5YA-0003PU-GV
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:38:27 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8249aca0affso882541b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771036705; x=1771641505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kF4Vl7mhZvKZrCuPXSjzq62ftfwdPAG78kjJSPD65KE=;
 b=pdg28FRnI+4WLAwyb/j1yL//K4gmq/LhgbqlX9RL0x2VuWkBiLvt0Aiee/dMX0oZea
 FwOikVU5covu544Cwru/1ANGiSztlsx75yqQ9rYW+lNL7PGDQTJHzy+OlHQOx1ZYnZ2L
 o4FV1lH9EyrNG71CxFH55Kxhou844Vvm8ubGSGatyZ2s35gXHaTs+1+JQLKwOcNl2GPV
 F8iFMYAOQFjzzGruOQrzUYmnx7ztCjp0pnt/eZCOwaXXxnZU5svh7aD0vCvzkx/O/bcS
 aBjc900WCstSoTVDpnlGTdAcn6j9kj7JbyfsETHd6cxt5bvczJJlwM0x2NnDgprMoO2C
 CocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771036705; x=1771641505;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kF4Vl7mhZvKZrCuPXSjzq62ftfwdPAG78kjJSPD65KE=;
 b=wKWoOKD0NcxFOiz1lck1diUuI0y4nL6McE2UmmZSzJqJGBpZdzukKFM6RjIrmdLmF0
 M4rpYi2afN+cXDo8Dk7BVwYW2z7rnHeHd98rir1fInvoKZDEctZ9x/lD+8RD5UQZHYBY
 LCQ5eE5gqerXDlg9RCDze2ty/QhWfCO0l/XblJD/Bp11IqTde7RaKeYlkm/cejtd4ihs
 jBYSMdoVPbmrghAjsH0WrEe2xFqfZj1swatZmG/Ym4jISWx6AZq3+JelR+WXioHyLfse
 A/cjCogVI9oyEFKzZ8nwVzumdD3VIKbFJqZd8KoU7ZVxq6O4GFyyS5E13AGKpwgO+NjE
 fPhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDq0BNLmZTEDl4aUadmVb71keCGrdlkx8mEPB5P3MpcZAh4QA2d2F11rhHGcUADuNTn97cf8giy2hb@nongnu.org
X-Gm-Message-State: AOJu0YypaY4xeIfcVA6NwBa8alW3wXB28xAsPa+KLlpLtFAWsnke9hzv
 ADMwGxW0mKhwz26Q7uB/k32x4alvHlj/A4SwB/AKIEYu4IfLue1ytXmPulNayQx59Zwdb/om6TA
 Hm6l6
X-Gm-Gg: AZuq6aK+eRE6gTjvVzPvjuJwaxN1R4zRQlLHaNfAw4qArHitA7Kj4KZ+DHm9AlbevVF
 F/5n5xhWqCzQjuFtO2QL0dXIsOZxEjyYCtzbtVd5wSlmY80uJnz6RJYpuC5Nx7GzzYAAeqThH6L
 CG7ikyWjWg+btOhf1GFfgxHQMDl/6UetivF4e6GUTSmP2FmldTWIZGbsw+2VA+YlpKtPRRB2uGB
 xNzw55GmkWIvDiDRVRt/l3CVN3s5wdmtNbSPKyOwFcxeRc30dG8yFt9PRTTMbma+juQHjAo/XWD
 SrYTdghXJtEQaO0hK3MA77NPmES6G2cN+k7bI7n7J6DYTNOodhVfcgBUTjJJpvDSwpXCTvSx3Pq
 bIQpD1Alw9sJJ7Nt6zYHcvwyW+xZtdN5w+0LQQJaJVAby9tVy5AuqRPVNvbndZR6fpe+c5bHZxZ
 48nOxcltxh/ElAaYdIy6iFHRQwDEMetXc+phUzuzHZeRuEZkGyjeX+Ts8IpTG5zdb76xat
X-Received: by 2002:a05:6a00:3e14:b0:81f:3f8a:4c37 with SMTP id
 d2e1a72fcca58-824d95f49d1mr1033856b3a.38.1771036705009; 
 Fri, 13 Feb 2026 18:38:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a546edsm3773899b3a.25.2026.02.13.18.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 18:38:24 -0800 (PST)
Message-ID: <9e7e1247-0bf8-45fa-aafc-857e3b4b8d9a@linaro.org>
Date: Fri, 13 Feb 2026 18:38:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/sparc: Set graphic display dimensions generically
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260214021240.58657-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/13/26 6:12 PM, Philippe Mathieu-Daudé wrote:
> If a dimension is not set, have the machine init code
> set the default value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/sun4m.c        |  9 +++++++++
>   hw/sparc64/sun4u.c      | 10 ++++++++++
>   system/globals-target.c |  6 +-----
>   3 files changed, 20 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

