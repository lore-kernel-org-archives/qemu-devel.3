Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5361AE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7rX-0006YF-Gy; Thu, 19 Feb 2026 12:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7rR-0006VA-UZ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:30:46 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7rO-0003cQ-SZ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:30:44 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6e1e748dc1so653305a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522241; x=1772127041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xk7zUfoK19sYLW94fhnmxvvU4SMVnnPJ+ld8X4SRIVw=;
 b=mB0yOKO2cKs0golr96IzlMSlZG8bai0UZeaaV7MJRBkjKEMVvgyrQcrdJftvUKJo2U
 o4QMuUxNbAgSjRtyRKMxyKFtcP8yyJ0v9yvtRI6jWTPTzUXadjqA11gf893k91AdV74u
 4Bci8A5v30fxPvjbToexl/8Hx33ZKol3rwkyN32m4fXx5ErbAHxpRm2KTq2JQ1KkTOyd
 co38ePH6mTFphjFvh2bR6kFdiKKQ+SDfJE4Qyq0jz7z7CiIo5j7ncCcAUOMLGfS5s5T/
 6P9kgdsbvvGRHCh2ALfyKG3V83AeI00KewItj+QGwz4IaGMCbJJ/V7ubqyKOIgEFLDxJ
 gNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522241; x=1772127041;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xk7zUfoK19sYLW94fhnmxvvU4SMVnnPJ+ld8X4SRIVw=;
 b=ka3fXO6A8LFlfev0IldpNs8+AzDm2Wj43TMIbrslfslJc+0E1Ho34vP8nEPMUghNrS
 c92tkj8vZfnL1FGzpKSC1MLCQ/+pM0qokKbu0M3xJZjoDo0tiCBZb5lZDH45phIjQuZX
 KnGWM5aIdwfMTFCuqfsLHeMtf5x89sXfrAuCL+nRcvOY2X6YuSGysnyGFQxyuT0IaR96
 uoy9AgNHSGJdemN3Y+sMigbJupg9AItYoxemGh+3A13sHNLBNaXvWtlaqfu0bt7FDrDp
 de4+vOuNNWgGROQ9yNAAdrWDjkNFEWUVPcxQGAHLP9moEmjJ+6dtWtZNK0ALNZNEFUyz
 25DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7+/WrMRncvA+wU6jk7ip+tYLRtHEZW5TG6dNCPEt2IHkaLNz3Dk6su4vTCkO4RpmewWRMNRID6ufX@nongnu.org
X-Gm-Message-State: AOJu0Ywr/6RBU2prqe8PcQpBawwnKImcMtQzQV5O/KoRXdyiPlaixP1U
 0oBeVAME0oqKALUwWzHpxzk796o07lYxYUODbMEWjqAGmQCX5R+ZxOYIAXfcAxsoouQ=
X-Gm-Gg: AZuq6aI4s3zu+R/4eddAUaqC2IIct4QZcFq0DQNjw1459nsKuieFemcQbJXFXI27fU4
 3VDJ1OgsSag0hXoEWttDnuVZl9YM2B9tIpcpwGxcfG0IOx2Qdgw7vVC9f+s2ZD+wOTGG8r4Y6UU
 8I9pZcYgvXObcgibZspBFa0ZZSTv92ie4dvMlBjQI7rLDF6eXkqePBahhaOCoO6dJurb9lqPazo
 SsK6sqy71m4r4mmovfqxKj/CKUY8LfEoBtGXY1zcsCus0NSYMrCLbnFpGd0LgghP0lmUzENIi+V
 8KvGqsYtvU1tYlS2LqNAXDshKtflaRCaQcGbWq6onj8SEojjABB/gwON67jqCN6wBvL3djArEzl
 SciEwcMNeim8InYYwzMUZb2EpD2hD7EJl34BFz3p/dW+YhnUM3C4a81/Cel+Zv3D8VxXUWpo0eT
 ApqkX8kBBNqgPBXQJ05L4JYCxFh08aVfiN4XECDp0H5rdl3ohFqDoZhqAHKwgt4pHDcoEC
X-Received: by 2002:a17:902:f7cb:b0:2ad:2390:64e2 with SMTP id
 d9443c01a7336-2ad5f970500mr14894075ad.24.1771522241273; 
 Thu, 19 Feb 2026 09:30:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aaddc46sm169923345ad.73.2026.02.19.09.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:30:40 -0800 (PST)
Message-ID: <2d8c8b3d-0b3a-4966-9073-8f9d44d604bd@linaro.org>
Date: Thu, 19 Feb 2026 09:30:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/14] hw/m68k: update mcf5208evb to 3-phase reset
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219171810.602667-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 2/19/26 9:18 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - rewritten
>    - favour cpu_reset over resettable_reset(cs)
> ---
>   hw/m68k/mcf5208.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

