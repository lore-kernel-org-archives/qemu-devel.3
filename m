Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF06C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Sln-0002hd-PR; Mon, 13 May 2024 06:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Slm-0002hJ-Fw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:18:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Slk-00078E-Uf
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:18:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34eb52bfca3so3705725f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715595535; x=1716200335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JeBG9gisBbcaT+NuMpk0gzkKtdLjvyvb5Tw7JEfxlZw=;
 b=MrK2RAKUPSScE514BNSiqH/f63LuLtpUWh7F4ygXCPt8Oug/eOZJMI5K8Bw49ecSkt
 q6rw6jM/+FdiGJ/j00G74BmEiD9q6sLcmKOW8XnkvpgCVdmnHziQazrukDdRkdZwbNjT
 nSBEs6k/DCGjWJCjPOoMJ5wTQj4GC9jeF8h3MznTeKHcrnr0B/oL0eqbpsokt/6kzpeQ
 yn3N+ewOOzQJVVCaPx9iW1jD27GQCdqWz2IQIJwdT8WVspIUtx0J+ZjYPs3W7RTlwXfq
 tRgMXTf/WPlEMmCan/969L+Y4DDVgOTSPcH3cZQyphxb5jo0QJRcV3G55nOtLDUwHBdm
 4KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595535; x=1716200335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JeBG9gisBbcaT+NuMpk0gzkKtdLjvyvb5Tw7JEfxlZw=;
 b=HddK8KDkevqrqz2Dvhb7nRFotk9ROZMzmPhtG7xPhpWb/upKT+ChYqFPYtDMPlefwc
 Caa44XP5yK5Vg5xzKQNEd2x7hMRLU7+lAt0kh78jGw6Ehhb5LZyQOpZw2x3sOsO1zKWO
 KSEq8owRZ49tsrwzki02n2kwXrq45Tbop6P+87TZYIQ8xfB/5dWE5vWNAf8KD0+S+WYE
 UQdNvpDQkZt2rEJTCLHnplWGsq4sL/Gsj+Ztf+priYFh01P1p+2bWQDugcPQQEkJNx+0
 +zWElrInhKIPpB2m/HuelcOQqiuFUsF1mXKgtZY2MWN3Yjpl6DiJagvbgzRvyzS7MV6q
 /fAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI+f5q9CxEIx00sZzqWvUqxKkHklTtq1CaKHjfi1peafXSRV7zv1IHaVOkHzxs6JdhCjkEIfUwvX7KOm75nrFx6DXD3iY=
X-Gm-Message-State: AOJu0YwVtLt9EFesxlmvT8UkJzA+FyPleU7Pm/8q6vrsEJLblJNyTh2d
 c8o7U/O3+M2Po3awI8FpGO8XN+h3d+VQtChOV2mgmdnEcdLy4Wnq9Y1EYafVaOI=
X-Google-Smtp-Source: AGHT+IE2yuZlNIc/GubUGqoPGv5yIxqsD5WjAmcvNUoLWJwDeLBja+mosZON4kbeDYxlPMCk7zLKZQ==
X-Received: by 2002:a5d:6503:0:b0:34c:eb4a:1948 with SMTP id
 ffacd0b85a97d-3504a631080mr8271307f8f.5.1715595535233; 
 Mon, 13 May 2024 03:18:55 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420113d808bsm65396165e9.12.2024.05.13.03.18.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 03:18:54 -0700 (PDT)
Message-ID: <39d59714-c25d-42a6-8e2c-48a2ab473c78@linaro.org>
Date: Mon, 13 May 2024 12:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/45] target/hppa: Use TCG_COND_TST* in trans_bb_imm
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/5/24 09:46, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



