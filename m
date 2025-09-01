Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F04CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyJP-00007b-2N; Mon, 01 Sep 2025 02:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyJK-00006B-7l
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:46:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyJD-0002ob-Q1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:46:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3cf991e8bb8so1570885f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709189; x=1757313989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/Neb+XJIU2WR94viZ5J+wzwdj3ZhbtzvmIEqHiEGl8=;
 b=Ut9DONzfHP39JADS3lvGO73++6VsEPaIyiiuSJcEyY1h9Y35V0+/5SFnLK5wCk1pQw
 fZVrs3kaEP4amwwJSqzeMU+dlsuGcN8BgLd6uqC0lkrkgkSiQgKfokbo0gcjscz6HGmU
 1SPz+rnS8MzM2Lb0S/kTm75MYn/nq7dhAoLD9mlRJpJBFce16o2h0PFgEv83aHNoAkJ6
 WCRauwGubnrC1SZP1aT5RN42cv8toK/af7DshMPLzwI1qNv2ylfTgJfNt2L9FIXlncpP
 o/IkzkSYTXYGf0XNNz0TrYgG4SISvyI0AX49OpXxQ+ncHseu33kh1o/YsSlao+eWOhJk
 l7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709189; x=1757313989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/Neb+XJIU2WR94viZ5J+wzwdj3ZhbtzvmIEqHiEGl8=;
 b=tGOTY7vuBCrb7fwnLLKaxXDhJSLcnrUxsETmhXjDgD/qy0rgy25jFiC9N4IXsL+vxF
 3vibM6lSvatWkuJqDIaKOzVO7Zupxusk+Xp3V+UZokACWLhGbXOFDRmAQvncP7L5volF
 uwd9mDxAgGFh6FcO+mUVeMrtb9n10iyfoejwybY3TOqCIUkLTQUI+ryMqwQ40LKbXq0K
 QMpWqBdpQ4A1dUCdCkdpSNdIEOf1JIpwGYI5BQJ/0co2z5gWjabMarOOcw1I8yB6RQVV
 868pElyh31t9Ow2vWqadH+uMp/9AbJN4tRSaNz1Iuc4RLtSR86IESUtFB+7uFvo0+umv
 GNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqvzPVxlQl6NFGVPcDwAw9mAE2fn7sIbMSFUVg+O+VayUbYm8WG+HJ8VwT5xerrXMrsqifWGbMJygU@nongnu.org
X-Gm-Message-State: AOJu0YwMRej8iteOKlT//tAaTxlDtcEP8VztI4eVVadLvHlk5F1URAvu
 0p8VxaKSj5LKRSYQNm43BwQ7ZT8hC/N0Qiup7R3SXVyUAfmIXYTJ99P8Pnx/ZGcRsBg=
X-Gm-Gg: ASbGncsUDsT6NrCWYUAOPlRkl+W1gxRQ4eFaoE01ALIMTb1THFbmeDmCU6ZG+dieweu
 L/Kc6dvlaMsnrgrskXakD0+lMCfPyZuJb1Xy7CTE0wZEyW96Llc+27TG8I7yY1QZyXrjkx3+Dvm
 il7LQL3Gna4+i/3Vl5c503i98bUBb3HY4rlk+MA4KqTx6uk0gfEtVi16wvRbhumDELpRLrxe9rD
 hsJsVc+Lr02vSYHkwdxDf3W74BSIqbbtUMaPPgkNsl47p/VRJRoxWjywyoZhReQUXi38iZL8SQ+
 bNRiF5/VhxbDMb8+yTHwOC1g6YceB+5odBvZw3IpTDRmGAgYs4/WPV9PVPKV9UVjgmT7K3OxLX8
 JeeG30Fugi0zXc7XLMHNjHmsaPymQEKl4MzllXnVFAkjVoRgZeO2S1JNtMjaWn0YbUiBu631TuO
 ke
X-Google-Smtp-Source: AGHT+IHlN1qZgwX0n0CsciTMCMHfGFpN6PXBafEJyLOm1ziu9j92o5djuazY80MlvJyPXCzGXPsb0g==
X-Received: by 2002:a05:6000:2007:b0:3b8:d15e:ed35 with SMTP id
 ffacd0b85a97d-3d1dcb77d9fmr6002383f8f.23.1756709189063; 
 Sun, 31 Aug 2025 23:46:29 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c72f8sm224498985e9.3.2025.08.31.23.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:46:28 -0700 (PDT)
Message-ID: <64361111-116b-4d56-98c7-095280c0577b@linaro.org>
Date: Mon, 1 Sep 2025 08:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] target/loongarch: Use vaddr in
 get_physical_address()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-7-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730030202.3425934-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 30/7/25 05:01, Bibo Mao wrote:
> Replace target_ulong type with vaddr in function get_physical_address()
> and the same with its calling functions.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h        |  2 +-
>   target/loongarch/cpu_helper.c     |  9 ++++-----
>   target/loongarch/tcg/tlb_helper.c | 11 ++++++-----
>   3 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


