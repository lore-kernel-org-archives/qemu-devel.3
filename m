Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B3CC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 20:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdz51-0003gm-MS; Sat, 24 Feb 2024 15:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdz4z-0003gc-HP
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 15:57:06 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdz4x-0002Kb-NK
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 15:57:05 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29aa8c4710bso196361a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708808221; x=1709413021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4yUIxNJubhs18uylN3c7VniVPL0H3xhmQKnvW2RQ85Y=;
 b=ZhSVFxWjoMPSt5ehw7LvdnLsdVlBZX9d7UQExhcGADhrTCHmnjQQYKSPaHGvpPlSvp
 KscRq98y8azBvP0d6UUd3XC3WF/1nTCndIrPWAUSu1jnrLXxHSJplXk8MHnrCMuxTeHa
 KiIcWynWaCMeTUkQrIgs4ca6lzxkPpKVExwImWfRpdTN2Kz6tNH0cJZWJBg+ohc69vbn
 UFX6VpaAH0lDMCn2xoTlKm/SLwqG5nKaRgAej8RCF97vbAXbKpaHvZnA/ofHDes7UKBm
 eZ7Ly6d30q+JJznNmYZKeNChO6WJPVovPLjrWZ5tYsoIqr/FiPHKZroFOKvtpMRR3/gp
 qa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708808221; x=1709413021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yUIxNJubhs18uylN3c7VniVPL0H3xhmQKnvW2RQ85Y=;
 b=XICy0gQenVH/qj6UmgFl7yp8MZAxyuZDJpVI0//HlCdNc9U+8jFgcN050Q+JuxYII4
 G1FOkeCRpUjKXe0/QFzjCSz4PxGIqZmXqCWbPKe+NqsHCkqrAE4h/M6XY5vy2EokTi8k
 DMPB5u8Yp8UapzvutU2EtJx/fc9eJBqsGBUPyNQi/d1TRqet9AaXbVmY0bTaDj0tpOmr
 YM7tHr8MPsGHwFAxxkResLD4fq4ZeD1TwU2ZQLEZV2xDkknPuPF4D8+e9cnt1+XX7nOm
 TMyhXptRyxK/aU5WCcD4PEytn/RvqXpDDovV4NQMgvftgPbuwBMpZsbQoyrc8jzFS6UQ
 8MbA==
X-Gm-Message-State: AOJu0YzEHXmKwMROfVz/69bH9YBcfFZDSUB/Re6qeKjKD16XMdzDJZeC
 7s/B+nT/51EIz2YpAmSG0Q4wLijmrPEUL+bO1EnnTKsOtM3P6uhDaMFB8go3PsI=
X-Google-Smtp-Source: AGHT+IHN/p5guKTKjoJyqqOMVdvPgpYOlcVjKXSt5910Zon0FcYCAKug9nOyFM/no97zINjjr/zjEg==
X-Received: by 2002:a17:90a:c690:b0:296:2afd:ead2 with SMTP id
 n16-20020a17090ac69000b002962afdead2mr4302453pjt.21.1708808221553; 
 Sat, 24 Feb 2024 12:57:01 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y6-20020a17090a1f4600b00299a8011e67sm1771016pjy.55.2024.02.24.12.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 12:57:00 -0800 (PST)
Message-ID: <b0b20150-6336-4e01-b3c6-9d710c294334@linaro.org>
Date: Sat, 24 Feb 2024 10:56:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/39] tcg and linux-user patch queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240224010517.619640-1-richard.henderson@linaro.org>
 <CAFEAcA-5pE+=Xoq_BLRemRRr-zr2HU-FOcX-wHNQutTdc4Z4ww@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-5pE+=Xoq_BLRemRRr-zr2HU-FOcX-wHNQutTdc4Z4ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/24/24 06:15, Peter Maydell wrote:
> Hi -- looks like this introduces an new variable-length-array, which
> we are trying to get rid of:
> 
> ../linux-user/elfload.c: In function 'vma_dump_size':
> ../linux-user/elfload.c:4254:9: error: ISO C90 forbids variable length
> array 'page' [-Werror=vla]
> 4254 | char page[TARGET_PAGE_SIZE];
> | ^~~~
> ../linux-user/elfload.c: In function 'elf_core_dump':
> ../linux-user/elfload.c:4778:13: error: ISO C90 forbids variable
> length array 'page' [-Werror=vla]
> 4778 | char page[TARGET_PAGE_SIZE];
> | ^~~~
> 
> I noticed this because I happened to test merging this pullreq
> together with Thomas's testing pullreq that enforces the -Wvla
> error. I'll be merging that testing pull shortly but it's not
> upstream quite yet.

Ok, please merge Thomas' first and I'll fix this up.
It looks like we should be dynamically allocating these anyway.


r~

