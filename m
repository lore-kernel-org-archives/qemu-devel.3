Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66874D0E6C5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2w9J-0007OG-GF; Mon, 21 Oct 2024 13:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2w9E-0007Ns-3M
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:24:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2w9C-0003NR-O2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:24:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so43788335ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729531489; x=1730136289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t7Icxzzv87BzYtTsRoj8tqe9WQ7Sq7Ylu5Sa2wNsa7o=;
 b=NexGQ+e6eykkXkmN4nq7MVN3tjcnHKc/S+kZ5KGEpNk/S4yDSmsKkLDh+spDb39fik
 nUHJ1fIPodyJRfpdeLem79vZTVWW/1c7dw2/Ja6IC0FNTWo8CV+DS0sl1f5UoRZeaSQZ
 HHuk7OLv0e+TncBuGTI/nKebq2VMo2CyZWhc2qM34s4VLnJu7XMtlv9FHaedzci7q0cg
 n5D+7AiulCpcMZCcsdeZIj3PQN5s28+6Wi5fJaMTqR99PFql0QFFb65ONqj9b7yemerY
 ZeWLWuEyvHmxTjkQr71/GlHEgYxSOSO3CfxAhEuYEhH04Mtn6DPwuZWLJDZ8kIO8XBqw
 faZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531489; x=1730136289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7Icxzzv87BzYtTsRoj8tqe9WQ7Sq7Ylu5Sa2wNsa7o=;
 b=k2XQ6XOMcpivKL0PuAcEZIDKUPbHLanJeWxZi4gYKCg+HFT9Cam4ZmAaG94ptDpy5+
 59gYzTyx6NG3JpS7DxFj4OTHdYniupGYLQ0feB9p7isEiFBzJkaVxlFsGptQDA600rhF
 1TUPeZdk1F3UFqLMB+K8kvqwRsTNbMZ1Ld7btppXUjmGA67urDkX83bmW77k80DRKxh5
 ApcDcT7D+de8Z85CmuO5iKW4q/YgNz01Q5d/r3ADMyiDsB1TB3qfX0pqREJYI2Scjt1B
 yqIlcJY7ZHaQ5PMI+FdEKVB9NlIegvdlPeaVv6o0Pw6bo7PD23jNiOWz3d1if9cVo/Fj
 uGQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDpkNBDi/31OmG2Pas+AnqXg5Wb7aDxN9wYg8YT+tYVVRTuRUpmuhXQsJiaLx3enKLFdOkXMGyKzy@nongnu.org
X-Gm-Message-State: AOJu0YykCwQGA0QVPqc5l35W2mmn/QDnFpJsz0Cfdrpi1oxI5wGkOw3o
 0w1Shd9XkcR8+f5X6DoVFBjw3Qj4ckcJAy1UNXXW4euo2961CQ/CQ7pRSe/4YIo=
X-Google-Smtp-Source: AGHT+IH/AW4gDEoKfqFoPLCynYf+JMwGgFcBr8Pd50reEWg00AT5Md+8jKxeC6jWxo+IscDTq8BO8A==
X-Received: by 2002:a17:902:e741:b0:20c:d578:d712 with SMTP id
 d9443c01a7336-20e94b5fa6amr7881765ad.59.1729531488960; 
 Mon, 21 Oct 2024 10:24:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7eee7116sm28772295ad.36.2024.10.21.10.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 10:24:48 -0700 (PDT)
Message-ID: <6ee8e20f-a48a-4f4e-a3ea-29bf29a9d630@linaro.org>
Date: Mon, 21 Oct 2024 10:24:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Introduce ase_3d_available() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241021145832.34920-1-philmd@linaro.org>
 <7eb739af-c39e-4d5d-a439-99abceca7f00@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7eb739af-c39e-4d5d-a439-99abceca7f00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/21/24 08:02, Philippe Mathieu-Daudé wrote:
> On 21/10/24 11:58, Philippe Mathieu-Daudé wrote:
>> Determine if the MIPS-3D ASE is implemented by checking
>> the state of the 3D bit in the FIR CP1 control register.
>> Remove the then unused ASE_MIPS3D definition.
> 
> I forgot to mention:
> 
>   "Note, this allows using MIPS-3D on the 20Kc model."

Did you mean mips64dspr2?
The 20Kc model has ASE_MIPS3D.

If so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

