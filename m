Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3BD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3u8-0002Bd-Up; Mon, 01 Dec 2025 08:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQ3u1-0002As-GQ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:25:18 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQ3tf-0000Hx-NN
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:24:58 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2d44c727so742365f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764595491; x=1765200291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bU6sPUNZ1gP5fwPhTGNnvmfVu2BjMH60bs36Sy9uNhM=;
 b=DxzWaKK8xEN7Nj9fkThw3xS+hvyLjfKCjXwXmkqiudGI8xnTFKZ1faiYfHSmIMIOOh
 YA5UFB/EM8S/RIbA9tnqxob5EHH/8gQpEcMRwhip0yWlRcDn49nvzWOep9sq1hCrvZZ6
 q83/6WMfhTRvRhATuHD5iVEKlJvzwa1GGY8to4IzP8UE1xPXOoZori4YNgyRSTNrSPWr
 wldzf/9v6kS3JzFY3csyv1pDZT8yNpF8B42hdJxG0jnvFpnNpTufBn6AvVLX28iw3e+9
 qURN4pmlZgi9RlkHgug7lm+gISSsnntt1f8pWy0jLja2OWTBy/bEFqrER3dTJJc0pe4l
 NCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764595491; x=1765200291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bU6sPUNZ1gP5fwPhTGNnvmfVu2BjMH60bs36Sy9uNhM=;
 b=lMSgqgA8m4VbR1cr1Ki8DpX4ZTSXif7rwvkPlQKAokp4OvSmVE5LHDMPFm08WuCwx1
 pej9H6zS2oq03iAlXcdJIRK1sBNkmjZle9NTDskwdgqEHyWpSK4ySJYrc6Ko5T8WucFS
 bo9Ix/Wovd1Yn37rR4CdBL8NqiW9mDAr8oC48ymTcNZM0LjW1uT5SYrIrEHs/7qxyAf0
 S5rOKXzOKiyYkMltnOo39r4J2m8UTBHW+Uzixowuyr68TFuak6FzX2gIQS1jIFNUwhbQ
 PAwbNLpj50OTUcEtnFnf6bsv/vY231BbTtxp4INPzVOUGCKFkGuXVbCXTmrQLNYBgDfG
 R8DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/YgEK6ubZ4aRQY53ath+cVkNuxcV0N+otNnRbTFprtyS0K0P1kDyHPZvqPcztqIp9Jh7rUg9ACl7j@nongnu.org
X-Gm-Message-State: AOJu0Yzobjf9e6yKoQZuIQJ2YpysiuPEDC+VdqD6NDk8/X7eHhLRPQqU
 TlbVOpsKXZ9jLQPmklAgevRi4xC8RheKSxSr6Qk1diDokdZ9RmRH1OR9cIwggNzGBTc=
X-Gm-Gg: ASbGncumS4Mp1mo1LFZcrA9C8wvPK8ngH2UZjDStjCMF/Z3oyGrEua/m0dpULQfB5tB
 QknWLV3ibsanvuQfR+dvS4uqwLwtWHc4hWikfciPZKkDSMWxfouRo01riTGFykvq1XNdCs4IfWr
 +fi3RH0Z3IqabzaH+6MmXiQokQ8v28rdoIvDReFRwlZ6K+ON5k9E7tnKroKDwwwi2UAaJXuWYzx
 U20yGXc/4W28ZJHnM3Gw461urrikbg3hw9UPbil9s1U7quKcNTEQGOjTc8RyjTe7p06k0Mmw9sH
 S3c1/d2gTDRw6I6vexxFpbS02/t20u3U7FG+crZ41F21V0Zq85oHyWulXrzCUjMiPExB9gjUDPU
 lRbWm3Zuq1J4SA91Mjx4jH6WqckWWqhsCloF7ahUfYX4G+Q06t6sBhr018B3mJPm0nC9ma+uGrY
 ef0aicnjgQMRxIZ5XkluaqXuL9gEpC6RgBIEIpR4P0lwW/bzxo4UvjCQ==
X-Google-Smtp-Source: AGHT+IGGixduaVjdL4a+fE0vrYghqmhyCof0rBkkKU9PRdvP/9NKFhBFzYnC0MP8hJ4Pxy1U8TLLNw==
X-Received: by 2002:a05:6000:2584:b0:42b:2a09:2e59 with SMTP id
 ffacd0b85a97d-42cc19f0942mr40563915f8f.0.1764595490566; 
 Mon, 01 Dec 2025 05:24:50 -0800 (PST)
Received: from [10.224.3.213] (162.148.216.82.rev.sfr.net. [82.216.148.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a38bsm26767826f8f.24.2025.12.01.05.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 05:24:49 -0800 (PST)
Message-ID: <3143889b-9f46-4edc-aa2d-8902cca5d722@linaro.org>
Date: Mon, 1 Dec 2025 14:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitdm: Update IBM map
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Cc: aik@ozlabs.ru, andrew@aj.id.au, benh@kernel.crashing.org, clg@kaod.org,
 danielhb413@gmail.com, groug@kaod.org, sjitindarsingh@gmail.com,
 qemu-devel@nongnu.org
References: <20251128012151.711182-1-joel@jms.id.au>
 <87cy525zzs.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cy525zzs.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 28/11/25 09:21, Alex Bennée wrote:
> Joel Stanley <joel@jms.id.au> writes:
> 
>> A number of us have moved on from IBM.
>>
>>   * Alexey moved to AMD in 2022.
>>   * Andrew moved to Code Construct in 2023.
>>   * Ben moved to Amazon in 2019.
>>   * Cedric moved to Redhat.
>>   * Daniel moved to Ventana in 2024.
>>   * Greg moved to Redhat.
>>   * Joel moved to Tenstorrent in 2025.
>>   * Suraj moved to Amazon in 2019
>>
>> Most have either stopped working on QEMU or swtiched to corp

Typo "switched".

>> addresses.
> 
> Queued to gitdm/next, thanks.
> 


