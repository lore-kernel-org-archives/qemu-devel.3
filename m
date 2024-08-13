Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F3EC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 21:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdzL0-0005oq-Ke; Tue, 13 Aug 2024 17:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzKz-0005hV-7Q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:45:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzKv-0001N7-QA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:45:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so5520620b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723585547; x=1724190347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VLRktQdpnlkc02rbZlZj6cYSOO09Y6a2Pf6IMLPs7tg=;
 b=EB6giyWc02xXT0+hiGCp2tEWJu2TuDhWDTm45HFEV86TSUTIAlnuRnNkucM9NQPO10
 O+8VTkUV5YfjUXqqJiAhKLbByZovve6PZAzjSmvWtX85VFYJFFTVxmxeea/XjZduWm2F
 JERJ5yc+abEbd0/WARzigg/SITW+Kfm0yRPw6O9SY9zyNuf5XqGS+HbSdSNHYEA2R70W
 Lc/ZuCW/lDtgzw5sMJlDBszcnNBzOwXgu5wH+hirq2u5WvoTnzwiU5Z4Mvv88NBEv4Cs
 uLAvqZPtD1LwytLsyz2gTqoPCAeEeI2sMTtgXvBllHmj6zEIXlNhLAwBa2kZ74pHMUa2
 iSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723585547; x=1724190347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VLRktQdpnlkc02rbZlZj6cYSOO09Y6a2Pf6IMLPs7tg=;
 b=sBPR1zH2zzfpFJ4kWz3AnwBayCWTxZL4oqOk+dhp6Cvsax89+zLVs+VKpXbpGp71ro
 1tlg217k4wherpX6lOSxxlxJxvUc66dVimhtL8qp2hL3dFZpd0J2gY3iDcHqK64YpAoO
 tqw2wvINgqYWG751IOEn5FfdaokZSgF1N3EQFYw5enW+hZ/7Cjzen93+g9KTeKNkeiEI
 p5L6fyCKZCGtjluchNOk1Hpa1ekIni1avpG6FIM7PESS0AQad41ZAnffoiBYDI1Qdr1y
 BUyQ9lX+GQV6AwBZOShBQJ+SLYKzAa4abe1nDUbH6NW3sehIc9078aOIJ6k8RH2E/LOh
 lCuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl2ogwPyt/VZEx0ouO8Q3gkjC4YfzQ30jojo8q9cyFmO4djbugF1JoLNVY/msIfmcKg6/UCJgSFEF7KZIXf2YEmifh6oA=
X-Gm-Message-State: AOJu0YyOxdXZDVu1L+DTIxelKiJzlIXhEp9UJUUwopm+zlN4cTaMw9xA
 tL1y9KFJKwm/6gqsJeUT6EMfuRqLLOZ0Q2KKQhWM0zMVTmgSAA0GwJkAxXaIuTk=
X-Google-Smtp-Source: AGHT+IHMcCEmdVS2QV2N/KigBEhPUikv/S9Dz9msuzg1n14AHl+L7tt+i23cgMDv2yqhvHLwRGyhVA==
X-Received: by 2002:a05:6a00:4f89:b0:70b:2233:f43b with SMTP id
 d2e1a72fcca58-71267113c64mr1400912b3a.13.1723585547378; 
 Tue, 13 Aug 2024 14:45:47 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58a80dfsm6162051b3a.52.2024.08.13.14.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 14:45:47 -0700 (PDT)
Message-ID: <e1cc5fdc-bee1-4e7c-bda8-4fbf563a50c9@linaro.org>
Date: Wed, 14 Aug 2024 07:45:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1?] target/mips: Load PTE as DATA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240813152610.97883-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813152610.97883-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/14/24 01:26, Philippe Mathieu-Daudé wrote:
> PTE is not CODE so load it as normal DATA access.
> 
> Fixes: 074cfcb4da ("Implement hardware page table walker for MIPS32")
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20240813135313.96519-1-philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

