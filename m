Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F31C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19K1-0001hB-GG; Sun, 28 Apr 2024 14:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19JS-0001dL-O8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:32:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19JP-00026s-TJ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:31:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f074520c8cso3705321b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714329102; x=1714933902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v2r0zZ2gNREk+iN+TLr3EAv8SD2AbhiikuBWmxqVh4U=;
 b=eJ+F1isTIAuThJi5nGRH8JVuWBZcU4LBZPwCzX/e178q5cdu7uUuR2GzDs0FISFg0z
 EN/1oynyuQQK6uPj+fIKmsvPaXICMhtHg04mFQyLyEJsHGrch3iKMC/H4YO2pZkhOsNn
 g8ARZ1D4X8z9EjUI0YQnS/vaDzSI/hLSEMEeiAvvL+mQH0amkAVe5hVqf6mBQMflNucS
 2DXvG3YAbwzCuLuTu1bVypPqkpaN+3FvNEfys0rjSPfj5VbtBFCuUebivJtaWOvxMymh
 K/vEOR4V0JamPANYmgrijbZfhALPllKSRm/XlAy0WoV84qevBieQ5LYg5HpbW3A4mqXh
 9Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714329102; x=1714933902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2r0zZ2gNREk+iN+TLr3EAv8SD2AbhiikuBWmxqVh4U=;
 b=O/nb6mulYjP9aIRQCX0imeWtwHXOCcT5/E0hCQ2KZNs6C4pD3QdqANvgwsfLePLSSv
 p/Afhdiv1pWtnHmAyPcTPLQBqrY3pMAsMO0Bz2HcVJYYL4lz+CVwTaaszxADv6i8AwRR
 NbvmOpJ8RF0SNhcuaiskXOH7Cv+kCN7GT/vmSHwZqCx3LSlfBtSKMMtvKHeHVii3Hz24
 8RelNbZiBG30hRmm3sE1n/9yGU+0WtqELEbys5u72zM/b/S4gKzrQAmSZ6UJEKJq3Kd9
 VX8+02yJ33Qw72nCOrb/vjkHvR62D3Qg6Lm8m13mIDewCj+duJteAhcJjNkf5auqFsZQ
 Wfdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVULrScYe7MeY0yk0VvlK4E7VvWhb1drDvFp2dlj5Kh6MM42XNCKHE9PKnHhWjERD4TkGEHEzhGg3b+sIjJCmRO/73Peao=
X-Gm-Message-State: AOJu0Ywhlnae5te5mDihV6Iwj4z0WxJDSPf5uLUWghxXyZHlyfU7IG07
 HGRWGeY3etQrqsbhmdzSuP9tk9GvTvSfbhzw4UwhLTtc/AsVmb0kdPgK7o2+Olo=
X-Google-Smtp-Source: AGHT+IFoKU93mowwnSJ1Ce5WoVem2R2D3DkwQ6KuSv4AqJUTKM131gJv9B7xHeNdl381Gfw8TwyIyQ==
X-Received: by 2002:a05:6a00:170a:b0:6ed:d3af:1070 with SMTP id
 h10-20020a056a00170a00b006edd3af1070mr11254303pfc.32.1714329102264; 
 Sun, 28 Apr 2024 11:31:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fc20-20020a056a002e1400b006f3e9bdf393sm3222822pfb.8.2024.04.28.11.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:31:41 -0700 (PDT)
Message-ID: <5185c954-a03a-4fa6-ac69-a36001006cf4@linaro.org>
Date: Sun, 28 Apr 2024 11:31:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/14] exec/cpu: Restrict user-specific page
 definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> User-specific PAGE definitions shouldn't be used on system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/page-prot-common.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Come to that, PAGE_WRITE_INV is system only.

Does this clarify or simply spread ifdefs around?
They aren't particularly common at this point...


r~

