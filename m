Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F41C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pTu-0004Go-Fk; Tue, 30 Apr 2024 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pTi-0004ED-TL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:33:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pTf-0005gr-7i
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:33:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso24947865e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714491184; x=1715095984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qGlKScnsmvNJKyqXlCXhjNfS5MUjrZg5xIiJG5BRqho=;
 b=l/kGjoHYo9734+G/TEZiZRlV238ArMuYAbMGuTlSbn+kmCzjF6WSMwez83FhF/tMRH
 k+bNAArKfN/n65gUJTBuA1teq+F69NSMcBxs16HqVuf8P1lrhhL2UCymy6PiHfiX1BoF
 bTJDNQpBAdrcSc23s3o0IbuFyr1tmfmhvva5vypSDK+QM3A//UPysQ3TiTWTv8EJBU2v
 tIwPiJzIIw++NMFBDYKdzgN7Rq9DP7I+h8XdqQuOZAKyf9AkYTwfKtYPoSnNL2jlxmUq
 p1OirLvZngP2hIm247P6F7E5y9ITKzoKZYnfKrShAYFMPh4yu2fsas3FT4C8yc2mPHuF
 ZpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714491184; x=1715095984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qGlKScnsmvNJKyqXlCXhjNfS5MUjrZg5xIiJG5BRqho=;
 b=cV+2tEOMiP9cHmvJoXM39R0FCIR1Fnlwy0HK8lYiGXCPmjSX4UfjCvpPdL6nL91ANp
 h75bInvMHI6+kV8fzbpJbU7A0b7f6qXZgtBe7DAmcEO7jsvrdWA7ll092rzqEApk08lv
 e3ta3gHUzUhSang2/D3gc62rY5PMf4EWbXe8cLFp+jsJiwUV49x/vRckjIOxJVh5drl9
 SaDlS7hcud6RnZ1d88Bn9FgQ+iPozx6Vy3EdWkHJ7iUY1ixXs4YYwKWRcOJcHsfCTIhh
 t8FCi1Kh598W84FlPEteuNs0wdlqbIdipx9gfnb476rhdzTB09wpjRL6OuTYrnl2m9+J
 w4hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVHdq/r2lcp6gIj0TVN5F09pMrxn49zeYuRf0bj2/d5Cw18Nmz0YP7vze2/NY8k2+PosHWRgD40menfP8jb03wzA7/a/s=
X-Gm-Message-State: AOJu0YzNBWu+DqhYDVvP/ynzW5EHzm45xBJUJlhee7CYuS75jJ9Sa+TT
 Bh4CtTtTMFw73xGG98wioKtLWedeGVhWfGgpHvF6eyAm4+d0yyGfR8JwpX5WS3o=
X-Google-Smtp-Source: AGHT+IGNFoXpnrmISpbbqv+WsxGRNjCJcc7Y+nc1P5zepEXH62qUetlWYco83GXksmBmNLh40zYa2w==
X-Received: by 2002:a05:600c:4e8e:b0:41c:2334:fffd with SMTP id
 f14-20020a05600c4e8e00b0041c2334fffdmr159739wmq.9.1714491184420; 
 Tue, 30 Apr 2024 08:33:04 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 bi7-20020a05600c3d8700b0041be609b1c7sm12458778wmb.47.2024.04.30.08.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:33:03 -0700 (PDT)
Message-ID: <663475e3-b4a8-4821-a4c1-03f9817cbf17@linaro.org>
Date: Tue, 30 Apr 2024 17:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/i386/x86: Extract x86_isa_bios_init() from
 x86_bios_rom_init()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-6-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430150643.111976-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/4/24 17:06, Bernhard Beschow wrote:
> The function is inspired by pc_isa_bios_init() and should eventually replace it.
> Using x86_isa_bios_init() rather than pc_isa_bios_init() fixes pflash commands
> to work in the isa-bios region.
> 
> While at it convert the magic number 0x100000 (== 1MiB) to increase readability.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/x86.h |  2 ++
>   hw/i386/x86.c         | 25 ++++++++++++++++---------
>   2 files changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


