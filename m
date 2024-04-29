Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB89C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Kbk-0007vy-1Y; Mon, 29 Apr 2024 02:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s1Kba-0007ua-9n
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:35:15 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s1KbY-0004Kb-L5
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:35:14 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a58f1f36427so143609066b.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714372509; x=1714977309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fF+tHR9zZY2qsdLlB2woUhQUdUSvkMx+q6iplS5/FIE=;
 b=ff92oBz/hTgFfuDuGdMM7vqUjydJBaovEjvZr4VybvYvjeob3NLfOA5BmohuhvFC1N
 Gk+KZuazu0LnCMBTBtVwQbG4igL8ECGJ3yWpPm3SuFjDk3HmOJSiMB4RtIp0cm0KVNK6
 2Jb5kzg1fumKioZuOekK0EHXG5HKApuG91L+CLFS+v9pxIHe/1T3oI4EOr+u6MsTW+rP
 VIgq1PkwAIXTlGXpwdIcP296WexAr5EQ3MYqpzrQpo5dZJGZQxxf27hu/mr5tjPwE0zQ
 BljDLcP7lBqkq1hvr64NNaDuvzji+AErbg3DcKDkkMG+J1E9JA36/Zd/64FtIVdLTW0w
 /DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714372509; x=1714977309;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fF+tHR9zZY2qsdLlB2woUhQUdUSvkMx+q6iplS5/FIE=;
 b=IL+5r4eUztsyxXrsOzTeeObZmoXSimrzfLWRxQVZb4YQbcleFcz/4Eg8XEURINDJz+
 fY7D6BF0Ne7sA8QryeANoQETMRvtodrBDjyT5qmai3qYPzIpIUpxIiHDEZjsRkH/0FKT
 rh2wwMch9iNBfg87Wn/OVp2sDD+mwhGpzmUA6hpzvagjvAdsgR/5uy4bsZpsgpXVY9qm
 poHX2/UFcOyfU0ng6uNIABnMblUhhjM3KmDrOwowv2v4Uf5jiY2jhuU9hG8NkYCWHUZd
 67QfuTyyhhiyAdxRp+Vl3/M3Kxt8Zc/VKn0i1ZwuKyKmHZVdb+dV5JjDz5zsJjnA0MBb
 nETQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQefErSyNxB3eaRSPSGqAPZiRnS77kCVBd32tR97nn9K98+1epG7dmaEPXxrsceLPkeAMBhTd/M6LZzOSb+LOtDvJ9bM=
X-Gm-Message-State: AOJu0Yw+bBsZPJYzMWuvjn1FRMPpRqJlM81y6a4gFqwtSXEgnZMcFQ9o
 IzBdrPmOWahcNUGgS0b4g/YTvP0OHmsjJ1SLlx3DjX6ZRPiGRv8IfAXwkUPiUWzTxeLD2AxgKe9
 KWvCesQ==
X-Google-Smtp-Source: AGHT+IEDSgI+Ex2ao6/FnmB44mUrGQ7jXdlsC0ga91dSBSN/9nHg+TjZTuLXSRojAPbqG/1OsqO2cw==
X-Received: by 2002:a17:906:1643:b0:a55:b2d8:c584 with SMTP id
 n3-20020a170906164300b00a55b2d8c584mr5941126ejd.66.1714372509156; 
 Sun, 28 Apr 2024 23:35:09 -0700 (PDT)
Received: from [192.168.200.106] (83.11.4.140.ipv4.supernova.orange.pl.
 [83.11.4.140]) by smtp.gmail.com with ESMTPSA id
 k15-20020a170906128f00b00a473a1fe089sm13539985ejb.1.2024.04.28.23.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 23:35:08 -0700 (PDT)
Message-ID: <559cc23e-f581-4f0d-bf59-94a516d1ef56@linaro.org>
Date: Mon, 29 Apr 2024 08:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Richard Henderson <richard.henderson@linaro.org>,
 Xiong Yining <xiongyining1480@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
 <a25e01c0-5f6e-4568-93ec-970987eb6d07@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <a25e01c0-5f6e-4568-93ec-970987eb6d07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x633.google.com
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

W dniu 26.04.2024 o 18:06, Richard Henderson pisze:
> 
> Isn't this basically what MPIDR_EL1 is supposed to indicate?
> We do not yet implement all of that in QEMU, but should.

QEMU has socket/cluster/core/thread model which could map to
aff3/aff2/aff1/aff0 (or aff0/1/2/3) of MPIDR_EL1 register, right? But it 
does not.

Nevermind which combination of socket/cluster/core/thread I use all I 
have is this:

cpu 0x000 mpidr 00000000 00000000
cpu 0x001 mpidr 00000000 00000001
cpu 0x002 mpidr 00000000 00000010
cpu 0x003 mpidr 00000000 00000011
cpu 0x004 mpidr 00000000 00000100
cpu 0x005 mpidr 00000000 00000101
cpu 0x006 mpidr 00000000 00000110
cpu 0x007 mpidr 00000000 00000111

cpu 0x008 mpidr 00000001 00000000
cpu 0x009 mpidr 00000001 00000001
cpu 0x00a mpidr 00000001 00000010
cpu 0x00b mpidr 00000001 00000011
cpu 0x00c mpidr 00000001 00000100
cpu 0x00d mpidr 00000001 00000101
cpu 0x00e mpidr 00000001 00000110
cpu 0x00f mpidr 00000001 00000111

Eight cpu cores per unit. Probably leftover from GICv2 times where there 
was 8 cores per GIC limit.

So looks like adding mapping of topology to MPIDR_EL1 into QEMU would be 
a better option. May require checking for more than 256 of one kind then.

> Why does the same info need to be replicated in devicetree?

One of things we had on todolist: export cpu topology in PPTT table. 
With MPIDR being 2 level while topology can be 4 level.

