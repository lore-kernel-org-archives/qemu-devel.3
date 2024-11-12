Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8525CD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvT2-0002nx-T8; Tue, 12 Nov 2024 13:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvSz-0002PJ-Ax
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:18:17 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvSx-0002gG-D3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:18:17 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so4387080a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435493; x=1732040293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G8yHe7sgb3xTGCU+Xandjyk48Xf2bteWD1TWngN3Hi8=;
 b=VJcHfiw7Dc0SgUCmdi+Fmc1O4KXSLKiJCXGFYi0NYIJmyuOnaT2md3MsN6wUiV4U1j
 xduIYzfFQmFUmX8RCpJteKVt8cdrg+RCWIamD9am6UGKW2/Hi1Uz0IXqlotxCojl2dgg
 8PwobazTusdZUGU13xACbhUznxpDG/2jQ14Ncc9zUSc0Lpyc+4uc7gKr3iK8WszVcB9W
 XNxd7ruDegf/+Rh0SS1/nMWAU4Jua59VqTdjn1JKoBMCszYGxz7jkZL5zOPYor3MQD+9
 Wfrw2UCQs1AALB3N3hP2w1jbVWeiUgxocm4d2psioXGy174/5qERRPmXCYvs8VJKh8ba
 oGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435493; x=1732040293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G8yHe7sgb3xTGCU+Xandjyk48Xf2bteWD1TWngN3Hi8=;
 b=efXGdUQnOZ8JVZn/nGUFC+q56Z4sgpf7VABAqhF4QkBQFfKZwzcRJunuewHyNtniDW
 m43B3BaOTKeeGVCj3LfpOYxFUzuuQ0Eq9CWX8feltpqwFfCarWt/GpIiS9lcPmuCzG8g
 ZNKfkOIr5p6R5SRzGj1iQ3zE3ldnwfhL0VuGtdB59sR6IzAiL+x3uaNjkGR8fU368wEW
 715FS4sNtvVatfLp0zdDV7Kee0koyxLIWCk6EKYlc+DQnIx8bIytYnI/I3Qq9K61h9wG
 E7E7IaqtFYuLUa13FswOC0uNHQQUmm/3s38suaNkhikRfHDREvdQxwOUSE4+vEj1jVDF
 nkvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOqzdp2Q44gwWcNhwNm2DaAnMDLsyr7Xu8kcp79PHr82IjKpgzNGbFMZ/vsZQhP1DJGf9fHZqTxaOL@nongnu.org
X-Gm-Message-State: AOJu0YzsUKF5aXpbCU9Ah3FIL9VNXOIwSLD2Q4XkG+USPiYnfrN1G0ZD
 owXkx5dLtmUAlyA+sPHm9R7cg8ZpJYZpMeBrvrqS+uKheXZXwS8z8D9QYakMfDE=
X-Google-Smtp-Source: AGHT+IGAJ4/q1UBcVlgXeWXxB+YbjRxOMRgKT4hfbP7uYfev+6+RhrUB+a2evTldDA05VyLWO1Nsqg==
X-Received: by 2002:a17:90b:3890:b0:2e2:ca4d:9164 with SMTP id
 98e67ed59e1d1-2e9b168241fmr21375466a91.12.1731435493306; 
 Tue, 12 Nov 2024 10:18:13 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541cf0sm12837491a91.12.2024.11.12.10.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 10:18:12 -0800 (PST)
Message-ID: <1e36011d-6ffb-4f93-a5d5-4f5055e8924c@linaro.org>
Date: Tue, 12 Nov 2024 10:18:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] target/mips: Convert nanoMIPS LSA opcode to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241112172022.88348-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 11/12/24 09:20, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<f4bug@amsat.org>
> 
> Simply call the generic gen_lsa() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/nanomips32.decode        | 6 ++++++
>   target/mips/tcg/nanomips_translate.c     | 7 +++++++
>   target/mips/tcg/nanomips_translate.c.inc | 4 ----
>   3 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

