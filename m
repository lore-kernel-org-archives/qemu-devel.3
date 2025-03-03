Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438C0C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6iH-0000pJ-TI; Mon, 03 Mar 2025 09:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6hr-0000ep-Sa
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:23:44 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6hp-0000DY-MN
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:23:43 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30bb2fdbb09so13576041fa.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741011819; x=1741616619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pF8mhgVS9mR7+xpM7SF4Y/E3aG2pQC5gehg+3H9tV80=;
 b=v5kfkr/sUcaPZXGKq7AOTS1+L5OOAYgrIxq1DBmDZYwJpbaGR/sqCYcZ3xYtzVywE9
 N4N3//ikMAJFufDfxuSYfc/3DO44j1/auPZMFFKr0ERzsxcqpFX1H3socX95eP3NrpIB
 hQy+Lg+Itbz9sCRwvYtKw1ydIpxumx4JOqTLoFQ+KkzYRQGe/EQjDDwYFTxcLyyD3YUB
 VnOXybetYPH6QthuKnhKg2u4vBMeUQmW4f4P9Ckn1sODkIvnuQttQiydXjBN+X99QMeK
 EWUjvOOQmXd4uAzpGUruoPiJ4Z4sBo2ky/2s3NsYwOdX7tHwKUicjGo4H+9UKrekvY3m
 Pvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011819; x=1741616619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pF8mhgVS9mR7+xpM7SF4Y/E3aG2pQC5gehg+3H9tV80=;
 b=icqEqbZNCqPZkYy/ggZJC/WodxJUUR9sLDm+sE2RBVNk8x7Drw/uEIXJo2eoEiGUtz
 q5wuQBxWvXI07q0peHAGJFeMcdN+hyYU69KO5C6l0yn0t2Qg8C9ofaATFQZvtQTfbHOS
 lbBnY403soBZOh3gtBpS38wHvLFKyhOhe04T+w0aP6UPY/8cK57AF1LQyMBqvfuwfQOb
 FBizS1IV8uXZ90KUFXsS1v7Gug2QIw7Llc9ntPu7dYJ9bRFNRRHNKnln6injb/uCVlzM
 2bbQ04BrU/3K55ZIfX2TwF08d0+cvcVrerj/mV59hs/cBNdYTBeGpDJmiJPbWmnYVwMw
 zDdQ==
X-Gm-Message-State: AOJu0YwY85xNvNvA5fhfAPNBLBRLmWkpAsCc9CA+oq20phpBgEa81byJ
 IlU4WqbKaIBYdblGtDm8vs3COIjFqBb7VWtwHPn8QsGldBen0WGPb2eOk/sFmVs=
X-Gm-Gg: ASbGncuzkLXkSfE+VZrxX5eBbKuFUP2YHVP5fMolABN9dB7+UmRKsBDTRCsyoPuPXEg
 lQo1Ahz2Ki7SeBOWC4e8VOnhM7yfii/8UhhD3l+LWYT3/3OcnVlpZM69AAFvwIASRuW6mwXtfbl
 shD8U72eGhdv+yp07Afx+NTAzC1cbGbU2/DODXJ4AYbY21CKhTFCpAKuCG9MqjRPqeMSPKoENgS
 S2La1eux/MbOldLZNBlsXUs5XuVGjdiygQ8SO1vchr5IOxI6l/QyJ8wAwemOTEo41HBQ3PJXaBX
 aYm0Ygc+eCejpQJcrgIO/XyKhjbuTBGPbVJsERVi3Y2IHWAdi7R+nMjqE+k13YhpxRPT9F7xyH4
 ZXpLorYJ51V2t
X-Google-Smtp-Source: AGHT+IGautwzdxbFpKOav9W11W73VWUeR18+q7gSWI1T5LbnQC6a6mxUxouTG99MtltBGDByZeGB/A==
X-Received: by 2002:a05:651c:19a7:b0:302:2620:ec84 with SMTP id
 38308e7fff4ca-30b931f9d3dmr45740011fa.7.1741011819461; 
 Mon, 03 Mar 2025 06:23:39 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bb22c2189sm5179171fa.33.2025.03.03.06.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:23:38 -0800 (PST)
Message-ID: <846d2da9-1254-4c38-aa36-d3160bb84b0e@linaro.org>
Date: Mon, 3 Mar 2025 15:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: sifive_uart: Free fifo on unrealize
To: Alistair Francis <alistair23@gmail.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, chigot@adacore.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250303023120.157221-1-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250303023120.157221-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 3/3/25 03:31, Alistair Francis wrote:
> We previously allocate the fifo on reset and never free it, which means
> we are leaking memory.
> 
> Instead let's allocate on realize and free on unrealize.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/char/sifive_uart.c | 44 +++++++++++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 16 deletions(-)

Patch queued, thanks!

