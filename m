Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACF4C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZS7L-0000UP-HX; Mon, 12 Feb 2024 03:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZS7J-0000U2-Qf
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:56:46 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZS7I-0000AC-8r
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:56:45 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d0ce22b5f3so34370991fa.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707728202; x=1708333002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DB5e2sN1xYQfkMcbVVv2khqeLsjlNIi/c6vqNyWwR7o=;
 b=JdlcefhFHJYBPV/SokEEUcPlYa7/wA+0i8eNrgbnssutdXCfCZyw1HRfMXvZUSjdmO
 5IFfYggV6+KOZGwOF+V4V4EFoao6RNYdWC0usmTI24uW8DFfICayS7qoBTIbtP4QdAMJ
 CJieMLdSjnYj4BAs/n/E8A22cC5+njTIlEhW1F4xrznpha9wzGD9h9ztGOrkE5EX2dLj
 1FB4zhbvtlxSTxmTiQb6wKphz5hnLxefkEd3ywXQd3Gf/TFWchdW5tlBBvBbadV5aCLL
 2wB7+bJ9iDNNBErXQd+xIHfyLVT1JaYHQOxAUxrNC8bEbxGaF9q0P/Mex/Da5LoovLnt
 GmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707728202; x=1708333002;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DB5e2sN1xYQfkMcbVVv2khqeLsjlNIi/c6vqNyWwR7o=;
 b=okADYC80BJU2t/sWUJpATedonZCDe24aXYW4g0aAKnkbVV3yQ7Naw7Y93/3uJExHDQ
 /ZvTqOVJW0M2RmY9z8hcI1LUjgMGYyU6K7VTAAhdzZwp5ygTFBFhCCkVR3es+jObvPSN
 /LJF930uSyjGOHNEUSrM76cY9XDyfzKlzwTpUYuVSNF4Ds24cFeLbLQPuaCk2R2fLZGc
 jlWOfYABDX+HlJtPlQVp6fbSWYGyLfw03r9XN+NtbBcQOc9hhhX8hCM/JwDk41BsdZ8d
 R2QXw87vCaSgvc9pLfgNY7wO+DWh0Pglf0CFHni/lFTja5TmfZkMYzz0KBqF8Y/11wTQ
 EoTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtES687S0uIr2isX2QU642U2Euk+wy8xI6vR3SF6/NYukJjJp2GD0c19VEB3ix6vnEs6qowm+zVmMOEy7a1vTWlnaYkrY=
X-Gm-Message-State: AOJu0YycOamj41kzQZV5S3EK6D6yt/VhDAEphbZpvgtH6TD08mIKYhRQ
 gf4J1/9Nrm0/3W1R1809/SnQs7JAY3QAijUCs7IUhBbo1gLzkPeiKJ2AlOg1Mj+YyzLa2/amZOS
 6
X-Google-Smtp-Source: AGHT+IGmuQ44AMwwjkZD4JDz9WacZ3W+aPRVFOF8N9VNOF9Lni4qdOUA4bHAYXiKZ078pUf736V5Xw==
X-Received: by 2002:a2e:8847:0:b0:2d0:d75e:54e7 with SMTP id
 z7-20020a2e8847000000b002d0d75e54e7mr3724037ljj.17.1707728202271; 
 Mon, 12 Feb 2024 00:56:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWyBr6rGO6cS20rhFQqA8sqRAVY94yHBbqd2z5SHq5csDP27Lxt3zPABrGDExzIY82EG6RHaIbyCpiA+daSujRzMH/unL8=
Received: from [192.168.69.100] (vau06-h02-176-184-43-97.dsl.sta.abo.bbox.fr.
 [176.184.43.97]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d67d0000000b0033af26545c8sm6130214wrw.50.2024.02.12.00.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:56:41 -0800 (PST)
Message-ID: <a616c83d-068e-46a0-80b7-878425005317@linaro.org>
Date: Mon, 12 Feb 2024 09:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] This patch implements several Octeon +/II instructions.
Content-Language: en-US
To: owl129@126.com, qemu-devel@nongnu.org
References: <20240119045626.9698-1-owl129@126.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240119045626.9698-1-owl129@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Hi,

On 19/1/24 05:56, owl129@126.com wrote:
> From: owl <owl129@126.com>
> 

Thank for your patch!

> 
> Octeon+
> - SAA
> - SAAD

It seems it could be split in 3 parts, SA*, LA* and the rest.

> Octeon2
> - LAI
> - LAID
> - LAD
> - LADD
> - LAS
> - LASD
> - LAC
> - LACD
> - LAA
> - LAAD
> - LAW
> - LAWD
> 
> - LWX
> - LHX
> - LDX
> - LBUX
> - LWUX
> - LHUX
> - LBX
> 
> Signed-off-by: owl <owl129@126.com>
> ---
>   target/mips/tcg/octeon.decode      |  35 ++++
>   target/mips/tcg/octeon_translate.c | 281 +++++++++++++++++++++++++++++
>   2 files changed, 316 insertions(+)

How can we test it? Is there any distribution producing kernel for
Octeon+/2? Per https://github.com/MarvellEmbeddedProcessors/marvell-dpdk
I understand there could be Linux and FreeBSD, is that correct?

Thanks,

Phil.

