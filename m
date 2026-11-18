Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zqOBhgUy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTT7G-0006zg-SQ; Tue, 17 Nov 2026 19:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTT7F-0006zI-6X
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 19:01:33 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTT7D-0002jx-By
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 19:01:32 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso169333a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794960090; x=1795564890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vobrmFjqWRK9OrWnyBl9iG2HQNcI1qES4s/zOFwF9LM=;
 b=zqOBhgUypNhxXc1FKqlDofqSmvKLfK6zGqqvJZnD+EUvU5avNEZhlReUXXDfXJ+kZP
 UWjNP7qAxG9mvhjlDDzWSrNVNVOuyzDYRU7lNuCoM5mivkjkWz5oHjxUza8Prx3J8gV/
 w+SrdAk9GbR0JlNjEGfo/wA1NuEAzmbM6JeGfXobLv1swI6JiflMqBxTIFrvI59Vf1b4
 eh7ZSmLS45c19KXIn3/PjerzBOCUGVC0execKo+0lGwDdPOn1uhn4rrUITNY6D7ho8Kg
 7W31cTUiXaxbVWcfj64lneF1/JNEoMvsZL3qkL8k5OFHIkCB86TWYMaEi4NzMQRRxzOD
 +JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794960090; x=1795564890;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vobrmFjqWRK9OrWnyBl9iG2HQNcI1qES4s/zOFwF9LM=;
 b=K1cvmRG1BSl80FTXZYWbD2vhGN7opWinREic38amsbhsuHUdG+g43TKd9lEwHcsOn0
 C1TKzg9SvH/LRJ6iFi2hRHu5fAm/yqBF06om3LV/I94YpnOeOEYJtWfkMihKNjkqEqzw
 PZrpjO7eBcYqz5jsvfhwYC7zaEDtnXs/GJiHnABQ2KOetRwY8bvrLxf0uBBx1qA1xnaZ
 o+hsCSj88mCWChZZ9dcJLLdjAuyaZTudoYZz20DxzMhwVy19tpOn3JPDSPGkeoLnrS2L
 Ql7GgnrmYnFsVvhqWs7b6q75kY/7cXoQqxmcQsX+Z4O2ATkdM5ba3bPCzmzdq22LBeSc
 cztQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF8fowZuk+M01BlWl7DXuzcpkrKrHQcNzmC4I8HtzUhBAw9ywSApcFUr4SWl9aeuK/CggDKdcsV2O/k@nongnu.org
X-Gm-Message-State: APuU4Z+wBs6YCl8K5WCrOQV16zaGnd+Nx8jU97PXR8gIn8i6uckef2vh
 ZJ+KLplsWRXiMuyBbJUEmzNnK53v7uPB7RdKC87nj0UW/AJocNmCFX8tSiApYyhxU4E=
X-Gm-Gg: AZFdTZe2wH/MbiM5WjFYV94FbSX19JXzf8/0Uz7afS6DaB1idkF93DaB+SNA4tSU7rz
 Y38RNCgCCiJcuAnpQaanu6/IvmlSJ1Fcmm7vGwKU6aadtmp3Lz0X2DcA/+22rT3aHtj3dsNZ4zL
 /veHOUYD9/wt9LFFMQKKz1y3oEG+9ODQsGZEp83wMxiR41zKieYRBfd0XUfucoysJCCb1WqFHWC
 cYAElZ050pL/3AxPA85nodJSR0IE9v/vAA+EUeWJ5XT2PiRPIwpxGvV+9BgiknVi9/hoWueVG8Y
 +OZ+V8t1n1PwTWUs+zc4WqhIhZ2dau4VSXG7cwepkq9nJ4BiFi0IswI6/RaUPH9YtXwi4whCpA7
 mqAWNRgmuXT+jjjIoA+5F92ZxulqiE3ie2lJSkf32h5s1T8btR6VUGdJcKdLCiqEm9R1E5PPAKG
 ZwZe8lSuawWnyXP1mPAzvHEx09D/BSidcjAM+xTyIS3GfLEqT6pvMr1faMz8eY5msZ5GMQUqB1H
 S6DHJ53K6433qjk79a8CzzRG/BsNP72mTrWPquYYG8Zl92VyIueeSKM1tBE+FqN+Ce11gpjYaZj
 m93iwo6SanfYK9ib0xQikCH3rzfKlKzcItuxsXqlqh0N+qpgaMA90J0H1IrVMj6XWHA7Pfs=
X-Received: by 2002:a17:90b:4a42:b0:3b0:a413:dd8e with SMTP id
 98e67ed59e1d1-3b3d0871658mr561635a91.43.1794960089530; 
 Tue, 17 Nov 2026 16:01:29 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4ddecasm6135903a91.14.2026.11.17.16.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 16:01:28 -0800 (PST)
Message-ID: <663f579e-7281-4b71-9e38-d3d5639af55e@linaro.org>
Date: Tue, 17 Nov 2026 16:01:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] target/mips: Require the MT module for MFTR/MTTR
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-4-philmd@oss.qualcomm.com>
 <ec413b6f-23ff-42f6-8e21-52c565afb426@linaro.org>
 <72caf091-61e8-40a7-bb07-abd19478f0c9@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <72caf091-61e8-40a7-bb07-abd19478f0c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 14:35, Philippe Mathieu-Daudé wrote:
> On 17/11/26 20:00, Richard Henderson wrote:
>> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>>> MFTR/MTTR must raise Reserved Instruction on processors not
>>> implementing the MT module (MD00378 pp.46/50, Config3.MT:
>>> table 6.21). Use check_cp0_mt(), as done for the other MT
>>> instructions, instead of only check_cp0_enabled().
>>>
>>> Fixes: ead9360e2fbc ("Partial support for 34K multithreading")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   target/mips/tcg/translate.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Surely check_cp0_mt must be enabled for user-only,
>> not sit behind an ifdef.
> 
> I suppose I got lucky, MIPS_HFLAG_CP0 is never set in user-mode so
> the OPC_CP0 dispatch already raises CpU before any MT check could apply.
> 
> I'll remove the #ifdef (and fix the Config5/Config3 typo in comment),
> thanks!
I meant, check_cp0_mt is undefined for user-only.
How does this compile?


r~

