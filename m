Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B69C9830A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgsep-0005wH-VJ; Fri, 16 Jan 2026 17:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgse4-0004aJ-1c
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:50:27 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgse1-00089G-Js
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:50:19 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso1228842b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 14:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768603816; x=1769208616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kG0icGy8/yAhRchptWfmzofN4/QVM4H/cNHwsacLbz0=;
 b=QUtf11AyGq1jgIa79UQsGookRoHH1FK1kTQzf4DVSc6CSI/ih+uNx5cFm3yYat7+wt
 MZ6ZT7eQMa1PEWG56VRLNczCURz2VEYg00oeWedKcgmZSkZsqmzx/ulpAC8VYYOxEbKD
 TP7u8ypEigRqO9rEoEr8C348Vy9xW6BLXHHqVRLbbuLdaoK6G3vyDm+iu9zP19ZHWkkS
 AVGFYxO3xHts7zIO/LeWThD0Ed5ASjYX5PGNZnCnvMnCumosv7gF/q6sAy5tsTCXHZfB
 SwjpuzekOiEAEQPAibbh58OD27pdfrMwi7XuaamrZxlQs7zq8e7BJCVYJJwGF4TaaKcY
 07RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768603816; x=1769208616;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kG0icGy8/yAhRchptWfmzofN4/QVM4H/cNHwsacLbz0=;
 b=DF/uhfW/3YMM345z0mqqEB+ZSmUPazQ0n7EllIS2UsF/aPf17lnG7vXNZlvyDYvndh
 u8heo1ngYHclyVU7Rz5fK7qQA4OTL4WpPVzMJ1szEAa7amuIoGOwV0xlF39pgIcRkpC6
 B4VpvN3XlevKhsmJfGVf8lBntRVVVpCGFL0RrCgHoDmyPDs+W3vwktntwxoTZcgj9xXE
 3XjcYW1YWqKjfY9i4iqlz807WlAxm8x3Eap/bSx6a3JbIejNXS2aCD5UZYGhPdunbHjZ
 z75prp96EoDcs4iUXhuA5XULrrrULNxGRi1McA0a3BP30lq1Z2tKupd5TXzMZH+dhSKO
 IFpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLcloxDMxOBgdfE7DjZnYieFT53DLD1nb/RNCB9BhvPPlWZmcjsmS6qaGb5burl1DZFptH0OGljCLH@nongnu.org
X-Gm-Message-State: AOJu0YyHSpkp9nI2yKu5D3GL2Q3KXAErNShc67vhsKjVZi6XPztEJYNg
 cAyXr6nP+z+6LYU2zRMNwFYbR/Lom9q9GAzT89dN+vmf38lIKX8AkE2ymmKbDbXjQxY=
X-Gm-Gg: AY/fxX4y65Ol3dV9DpIa+iuLuNnNx6dX95CDgIYAnaWVm8Yq+tk5+eZOmQWbrgzkQu0
 MJGXRH2mwhjq83apQTo6/o8YzCbaAMldjNYkDEO7/as0mzKrRSdgvchEBWy5YneVKrYppjupvq7
 /sbtcqGNzgC4otbjKWIxzfudXEzrE9n++JJ+Ein7N5AwDrgRcppRtFeDgMfoEpATVBUYRmPs6rt
 rvCUkkqXcb+KAbu6Lrfa4YwZqPjMKPMPBQ4SghOyAQoyHkBwpsd/fwRDiDTty2MVhTYrcwOHwmX
 icpWh8l0BpKQWaQORA0xjBOxwFmrZ5EzzZZGmqO9JVMXxPlvvs9hZ4dQgcU7WG04yPr18JvHl8P
 3NX0L4snoyITD76PaXYuloENE0IlunwiTtJ2wnnK1dJrEgafhenw2sJS2/IcmnpXJOTE7YVTScM
 6Ta/rhrS94htJHDbCGzPVK6/sBugBeVsLCJFLksUfU9LyHEmevvt3H9R4IctyAQzW/nHY=
X-Received: by 2002:a05:6a00:14c3:b0:81d:d666:72e1 with SMTP id
 d2e1a72fcca58-81fa17729fdmr3398624b3a.10.1768603815966; 
 Fri, 16 Jan 2026 14:50:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10bcf66sm2903424b3a.18.2026.01.16.14.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:50:15 -0800 (PST)
Message-ID: <e51aee33-81bb-4fb7-94df-b0c3fcaa32f6@linaro.org>
Date: Fri, 16 Jan 2026 14:50:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] cpus: Allocate maximum number of ASes supported by
 the arch
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
 <20260116185814.108560-5-gustavo.romero@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116185814.108560-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/16/26 10:58 AM, Gustavo Romero wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Instead of computing the number of address spaces used for a given
> architecture, machine, and CPU configuration, simplify the code by
> always allocating the maximum number of CPUAddressSpaces supported
> by the architecture.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   hw/core/cpu-common.c             |  1 -
>   hw/core/cpu-system.c             |  2 +-
>   include/exec/cpu-common.h        |  4 ----
>   include/hw/core/cpu.h            |  7 +++++--
>   system/cpus.c                    |  1 -
>   system/physmem.c                 |  8 ++++----
>   target/arm/cpu.c                 | 11 +----------
>   target/i386/cpu.c                |  1 +
>   target/i386/kvm/kvm-cpu.c        |  1 -
>   target/i386/tcg/system/tcg-cpu.c |  1 -
>   10 files changed, 12 insertions(+), 25 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

