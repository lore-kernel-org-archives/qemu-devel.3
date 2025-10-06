Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34851CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5tlG-0002L2-4a; Mon, 06 Oct 2025 18:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tlE-0002Kf-KW
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 18:32:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tlC-0004Gg-1Z
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 18:32:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f605f22easo4675143b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759789966; x=1760394766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rsqxsMd1l8+UL9H+YYEB1wAuagtWs0JQPr64WA5Asbg=;
 b=QUiTmOMqcVoxpNcIqjLf8W8bkYh40gCJ3IJt/B4By+heAEP7h6s5oP2etReV/6XqCC
 P+stfwDOVfHCiOuolA27/LXBv+qTruEfaGkTDFTbzT7Wr9xUSJMJRbrRhOkQyyFXtJTI
 lPta7RhISXvA+MkbSvuwgmztOcOL39t5SqLVMuZJeZWco9XnrzPkyaCnXNufqscmfnGp
 6O66x6TEzeVKTJI0yUTXO6n2rnJ0C1hUFVAwiDcX2kbgBgT2jqEHmvPkqcrLnkGLshi0
 vVwbdYvPRZOESJ3ZNpoKgldp80YR2/2rWnr+1cHFP4wkj+rK2f08bqrFDWtRacaFETZD
 k/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759789966; x=1760394766;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsqxsMd1l8+UL9H+YYEB1wAuagtWs0JQPr64WA5Asbg=;
 b=SS83g8sDCvyG5wpwQ4H0/PzoqJxGFsAcEsDB76LJ3eAAp+l5DUNHiM7W+ELaBAtZcj
 iMcFZB+HFUrCtJxLR27WRK01ZFu289dJlTpq9Serk/H4pQx2w/TovqQzU1eZ6+aJvqC5
 2QczLQShc4t/4+1B1ZhsD6bsPFDnYw26zQV+SCDqqTaupTDz4HAe3kseDCfRSfb7D6Yn
 zDiWPVV/BZ3VYkH26X2QgJskEJFBKckiC54GMukmsK1Q1qCv9ChZscgh8IDWjiTmYFZU
 sUvfiKgVC2tjrwJN+QcqFfNfWD6tD/UPuBmaBAbizdcsAQwA5Q3TmoJY9zHTmcVxYG9R
 b07Q==
X-Gm-Message-State: AOJu0YwFa+Z0b8QWa2lDXTbKlyWy6GNhO3dv4nbdMKRdcNkwOULHEC4c
 yacxWRx2LTj1ghS1Sczfwr27W/m3OKHxyDCbi4xow1LEr67h4hnpuCKKInFZ7lnCmWs8ljM1M18
 5F9fp7so=
X-Gm-Gg: ASbGncvZkBdM7yLVNP//NlBRy1iLbUYUPx2i8SChmth24tV24/BwEZF5IfZRcpuiAaF
 iDkV+s6Kd3G1GZE372our6NPEMA+Uq8M+hzbepKBd+J8EiafGHMsf4U2J1Osme9ACP07rEJYY1S
 5ivKWTnh7G5sEfU6Z437S9l1jSd9xu5GJe6IU37M6GUfbcFFaJTKZnws/Vz4mubypA2ISny2amR
 lm9n8qwNYqqClQ0go3ieuwqYbSyW8DJU/jMqv1hE82UMynaWvuq9ucPgqkQZTFGjchAQaoh9b3q
 IBQBWXFRvyh4EGyrFOc9Uv4XqONDeds9En4cPkAU1V58zcRBQnwwiBkKoAYfUcIq9Qun/fkEVWE
 E8W9uN7VZghoHVW/TksvhDlF4yJIeKyVRf2HH+nRAt6kp/kF38ES44HxlG9gg4xWL
X-Google-Smtp-Source: AGHT+IFCgxvbVpGWC4CbhNNSQzEVEr8kXUzi3KJckX3cAMf0WDi5E3HKvIK9RSZZ8nKpbl77gd20Xg==
X-Received: by 2002:a05:6a20:6a26:b0:2bd:2798:7ae7 with SMTP id
 adf61e73a8af0-32b620be0e3mr16965814637.31.1759789966366; 
 Mon, 06 Oct 2025 15:32:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01faf086sm13704556b3a.23.2025.10.06.15.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 15:32:45 -0700 (PDT)
Message-ID: <438dd065-8edc-49d7-922f-29719f17d02b@linaro.org>
Date: Mon, 6 Oct 2025 15:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/25] target/arm: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1759744337.git.neither@nut.email>
 <77e01129000585067c2f89d4c1a1efe027e6b0d9.1759744337.git.neither@nut.email>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <77e01129000585067c2f89d4c1a1efe027e6b0d9.1759744337.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/6/25 02:57, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for ARM (and Aarch64) targets. We decided to
> treat the (V)IRQ, (VI/VF)NMI, (V)FIQ and VSERR exceptions as interrupts
> since they are, presumably, async in nature.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/arm/helper.c       | 24 ++++++++++++++++++++++++
>   target/arm/internals.h    |  1 +
>   target/arm/tcg/m_helper.c |  5 +++++
>   3 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

