Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24DCC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbSF-0007q0-1T; Wed, 24 Apr 2024 08:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzbS9-0007pi-7Q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:10:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzbS7-0000I9-Da
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:10:20 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3476dcd9c46so5170536f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713960616; x=1714565416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1kSZQBEloRkjRml6t7fTNKUP8VQRKeYm7ZLP5JKIXI=;
 b=nuQ1QgovQ/QU/g6RZXgp+Pnrx+Ivyzi350RGb2GwhOn5FK0SDsrcpoXCs7piItLw8q
 feTtDbZSgZy5ZnEObAcRqV/VvduH92NBK3bBu5bxERjNHku4XIE/3fbzJHRWKqFpX/kU
 Ru/3LC3jThmP+IQzlXPNidGp5XiOrNJIK4LwOiIhIM+2ObMtPGeNzH7k6R9aWl/hAuPn
 7P25e6h9j8evIHdHB/xfUpxt8vrY2VN5YKG0ajaAi4Shpf+TEBKbmmjGOi/QUzfGMVr1
 IGuWbbZ5oRooxGS3MtN8blKO4BSvL52y3+EHoRE/q96yW/MmDe738RvqReASuzMH3qkC
 1J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713960616; x=1714565416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1kSZQBEloRkjRml6t7fTNKUP8VQRKeYm7ZLP5JKIXI=;
 b=MtgkP8je7dbjLNEDxazgrsXZ00gNdAwZaoqmVbW/YhlLxo4Jqm1smAqxI/oQDu6aP/
 ZAXGTkpwHwu/83/i/dQ6r2qkv5dmLAeNx+JkSEUK20JQ6bdf81PdfYFKMFr14br4o45O
 6RuY0UsDMhNiRbokWWIe3qKfmjdSjOWAU6V9x6yAJKYx7xayd+BqIk9I0PLiQgpr+CeA
 ICtcGscSF4MD2zStkQ8YH50B2NIav1WxD3FaKYTWQuxy/UQ4DgFMx8D96p3pskgoti61
 p5xX1sfhlsx6EBHKT16H0yUO83yc8eDOYYe1B0DbEf2rkJrel65Xv3/AgBPvzF2TuidD
 mqyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaImk2jWK0x7riXkt467L1iP9Ux+EFKgbwJfzorS6+JTph3acPDtA4se3SSvI2i2DeaKsynxWh4eICMR2MeTolkembgPg=
X-Gm-Message-State: AOJu0YxazcYhsu/iXJWUpaWc6+7RCs15pasrIAOf+XBROqEiBYW/tQr7
 IzOfsVttsuRsMPihAo9DjcQHXdy7obDu9ocfi7+XuWqwRfYQ4Djx8qCC+dpJv18=
X-Google-Smtp-Source: AGHT+IFZcP/aTJ5eCCfa6cT7tTyGhc+Xk50zddVlbScYDLQ6R3nfR0mOHs9FivTLVxwnjRzs7atDvA==
X-Received: by 2002:a5d:674c:0:b0:34b:eb7:f389 with SMTP id
 l12-20020a5d674c000000b0034b0eb7f389mr1200088wrw.71.1713960616461; 
 Wed, 24 Apr 2024 05:10:16 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 v11-20020a05600c444b00b00418d5b16f85sm23532918wmn.21.2024.04.24.05.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 05:10:16 -0700 (PDT)
Message-ID: <7bab1c8c-46f9-4704-851a-f7f816437ad1@linaro.org>
Date: Wed, 24 Apr 2024 14:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Introduce pnv_chip_foreach_cpu()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240424093048.180966-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424093048.180966-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/4/24 11:30, Cédric Le Goater wrote:
> This helper routine uses the machine definition, sockets, cores and
> threads, to loop on all CPUs of the machine. Replace CPU_FOREACH()
> with it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ppc/pnv.c | 48 ++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 36 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

