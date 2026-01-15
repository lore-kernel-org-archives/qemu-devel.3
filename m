Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CAED4661E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 19:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTQG-0004D0-Jh; Thu, 15 Jan 2026 14:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTPu-0003xr-I6
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:54:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTPt-00016Y-5I
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:54:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso10581115e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768506839; x=1769111639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbdTg4dIcqWLj12DXpgDtbHJbnMpx+2B8gJGT4AskMk=;
 b=Q0FaKKjiYHC8vyZ4hadMvxdA7D8g1e+h9NY1LRBQ7B7mIT54n9CvlqwfbKJuGrlwfJ
 rSqopCOR1Irafhyov47TJ6OAVa5VRjmMI4xleYK1fUSciE0fmsZMQQXUP0kwKMc5WYEM
 NKfcfbbDrtlotj4g9jBEteTFvoghIr0n6RSzz5IDfmgMxm6mDKhgZlAeq1m9n81OrYZw
 g4XfRcTTDffpBkD75h42L8aH1S8JjiHTEsHAVLeDTBaOcLLV/1EdUxgvAoSTPnPvVjPs
 +PArjBptdvK06SyQPwBdvJ3xYkzCwMuJAK2AQ3nY976g/ZyK2neaB9UyXohvNuhNBd+X
 jPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768506839; x=1769111639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbdTg4dIcqWLj12DXpgDtbHJbnMpx+2B8gJGT4AskMk=;
 b=kA1dWsX/eFfmN2NoEZxxDNPSyagD2eGj1FUf9GciY4aa1IZ86QZVuYvr71QkVxMZiF
 xjxUoA+qleRLDrzVtRO9szdM4Yfh8QPllRlEVbOlQUt9kebUe3wUqA2GRJUItJfDNkM9
 fwvTWDB9H89WjBcIDa2LlE3Dh65fiCZnPArqrsj/TKOPyd0VtzabEaATfdmz2vRplSQf
 Zc+65OcBcrUE/Laps8l5SDN6vKJnbW0NEw+5Sc15GOWkO+dtq84GTHLsDX7xPU289Vgn
 4aNdwBYTnwIMRuv1ljvzFXvX9ph0AJBvvvgaSonfkF1nJEVj2Y12nwVINQZZYpQVK9aO
 8PIQ==
X-Gm-Message-State: AOJu0YxSAV14e92H02rf1etgdXyXZc8e2mzQ/UHdp1fQC40VlPVckYcv
 43ZsxJHm8fsqs3JtdjNtlieW0tTWKblXVMDHl7210DIhdqx6wF2T7djRAbjaENfg3wcJaWJdy+t
 pjreoWqU=
X-Gm-Gg: AY/fxX40nUctB8e46su3wnMDbCBEiQWdSbQ5mmhox4kwNnK4tIndldDKY1PmE96pTxu
 Py9z/G2OZcDzHyp5mkzAs0FVY6aNPGlCibL7B8Nvn1artV+u5wAlIa0t8al65U1IxU3ErByFp5p
 FIq8yWEa0oqJXag3fidz+5zaQni1lOwcae1aLXWXbA0j2cHtCtIEKmnYslkJU5ewMWjW8M7YsB8
 EsUmI5uxrcQQKAPCqksl64H4oZHR08Hdg4bar9F7La06XGnkuttdPYfHPWuJvLyXWpkHDRJXgyy
 uXI0dP8a4T7OSptAhBFj7b+K+Itre+iSteTaOHQe+1uSZZX+MNW0q34UYY/ff00LVU33VKmgTS9
 YyEPMWWL7W9vTRj/tBWVhW0DLaSN8/H4Lrh1gvwf1/cSirJ/kNrIXDGOOAAPd32LfRtt+rwL51I
 YqlvnBPOjjmTAQBzgOVNewl7Pl+sSt5LG/BWsuQtBBPq3d76YO/f6+Qw==
X-Received: by 2002:a05:600c:3f07:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-4801eac2fe6mr3851055e9.10.1768506839282; 
 Thu, 15 Jan 2026 11:53:59 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm62176295e9.9.2026.01.15.11.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 11:53:58 -0800 (PST)
Message-ID: <9469a67c-cb31-47a0-b609-4a30f1e822a8@linaro.org>
Date: Thu, 15 Jan 2026 20:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Require TCG to run reverse debugging
 tests
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
References: <20260115161029.24116-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115161029.24116-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 15/1/26 17:10, Philippe Mathieu-Daudé wrote:
> Record/replay is specific to TCG. Require it to avoid failure
> when using a HVF-only build on Darwin:
> 
>    qemu-system-aarch64: -icount shift=7,rr=record,rrfile=/scratch/replay.bin,rrsnapshot=init: cannot configure icount, TCG support not available
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/reverse_debugging.py | 2 ++
>   1 file changed, 2 insertions(+)

Queued via accel-next tree, thanks.

