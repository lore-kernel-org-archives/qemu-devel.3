Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87DECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9JgW-0000lG-Tl; Thu, 16 Oct 2025 04:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9JgU-0000l4-G5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:50:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9JgQ-0004o1-I0
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:50:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so3324795e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760604598; x=1761209398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JtRkQ3cv14nKx8fV7RDMm+SlMsLjJHsJrekZwNIKt+o=;
 b=KNzFrkfisgxLJaz5Pjx7Q2AHDoitKAt8Dp7jzKk5FZK8aXEYyy8Xbxbst9BbFqOAFy
 PokKV1F8YH6rTr3suDTJJnzxAvmAghtmul09FCrK0hbbAShHLVAltv1SksQUM6AzN6Y7
 ivK+x7JbjuZeBgkkf04yS//syI8gcQehbeLjCWF/RXYo4BQgO+3Jp8gsX48/DuUzrrII
 QvUduw/5uexqfWGhCyfX8b2SZQOVfDWk1mKwMYn5cqzyzCjG7qhXSjH/sT9Th9BVBlet
 N7XL2t9SaPnR8/jBD8HpOLt49iXWi0M/SzLU3pfD/3uUwCM1k4gso7mfXe0y5HDMq8rA
 0OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760604598; x=1761209398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JtRkQ3cv14nKx8fV7RDMm+SlMsLjJHsJrekZwNIKt+o=;
 b=afOAaBt8ERhjY4mN8nF3esQIxc5AW5icAos9EPernPl4ho9AfG8rqGE1T+9Ccnw+1j
 00Uq8ojdLctfN3yLXT+DDbqQeMJEoBSuYrMotkojS2II+kQmm4nQkO/LmV+tlr4seycZ
 TOOI2hWMNq7bWT6FBkHfF4l3lzQSoQ3hFAK0dPsMzydZjSc0opOS6M9uD8LVuYRiChah
 CZo0+ChyFrYQF1+ES+a/uhLjlFSrYfLDJpJ2Rm+TWOyyQnko8oE1QDFcHqQoxQrJTfIR
 hlbp6Z6Ogk8OUe8s3NOOHItlMx24Cz/lKWyXLFDNhY/4+2SXwDPEnW0elroK6ALWoZA7
 tm1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFoo8TnPnXFCA2XgwvfEXceYt1ZRcjzxA4gMx8kk3ataehiuFPbtRyPbfpGLmhn7jhMCYJoudA3xxP@nongnu.org
X-Gm-Message-State: AOJu0Yz5TAQ/tF6oLs/Jw4IBaxNW0WGI8vPiG3yGa0XRMJT2p0uJlKXQ
 /3ZChErgfTBs3WOEnjoHERQU6aaw6RzxdfQOKspvYV6PqG7/ptv2Swf3sLyztKPbOCY=
X-Gm-Gg: ASbGnctLAVaSOcmHzmv7BAVnX5/Waoef+6Jdu5ctUgzvTgtHmzbJ9zmJXHeCUTFU0Kf
 0T9C6+jtWkjPcyRV6Fu7jSNiRz1NrqfbFw4hbvO1ARAd77/NxN79gNoUBDo4c0Pp2amPBVi8b8b
 hq05hCe6qf6f+rDiQcX2KXvXb5uKwGkF6lL6W0/ZBL08BJoKaSptwJC3SfsCfIMLNlU4DsuK53i
 JjdYWvDDEBF5zVLolZx2QdwkT+fksqSP9j7kdGILCgwMuP+hQwc6Z7atSH9s7AW5UT5dQjRLXO2
 xHH2DIXwupuMw+8YlrixxE7MDib/XRsziRsGnzXSYgoutrU2y9kKaBdu/N0NkT4TsBih0Sk2oVq
 rDFuSmw7nm7wanCyO5VJ07Jt4r7b6sQAdxITcj20aPNvijm2DLOKtk1k7SqviMQLmsoh7sLjCBw
 5EZ9IM7RzhnAXBlr6Pe8aJsMApyomnFGn8YC4v7dc6ovRKWg6+Wh0blAwB2NGf9xexlg8A
X-Google-Smtp-Source: AGHT+IGYEIFQcYB+s81sG72liqP75+uUXs4Yha6nXXzZgHAKeexIyCn8MyboShoFJf25Xpr11AAquw==
X-Received: by 2002:a05:600c:8b42:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-46fa9afbd71mr221893315e9.28.1760604597647; 
 Thu, 16 Oct 2025 01:49:57 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82c9sm14790615e9.14.2025.10.16.01.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 01:49:57 -0700 (PDT)
Message-ID: <5bdf4bb4-1439-4c46-bd7e-082e72949217@linaro.org>
Date: Thu, 16 Oct 2025 10:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
Content-Language: en-US
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Andreas_H=C3=BCttel?= <andreas.huettel@ur.de>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 9/10/25 22:51, Gabriel Brookman wrote:
> For the fmpyadd instruction on the hppa architecture, there is a bit
> used to specify whether the instruction is operating on a 32 bit or 64
> bit floating point register. For most instructions, such a bit is 0 when
> operating on the smaller register and 1 when operating on the larger
> register. However, according to page 6-57 of the PA-RISC 1.1 Architecture
> and Instruction Set Reference Manual, this convention is reversed for the
> fmpyadd instruction specifically, meaning the bit is 1 for operations on
> 32 bit registers and 0 for 64 bit registers. Previously, QEMU decoded
> this operation as operating on the other size of register, leading to
> bugs when translating the fmpyadd instruction. This patch fixes that
> issue.
> 
> Reported-by: Andreas Hüttel <andreas.huettel@ur.de>
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3096
> ---
> Hi all,
> 
> This patch fixes the decoding of the fmpyadd instruction on the hppa
> target, which uses an inverted bit convention to select between
> 32-bit and 64-bit floating-point registers. The issue was reported by
> Andreas Hüttel after observing incorrect behavior when running real
> binaries under that target. He kindly submitted a minimal reproducer
> which I was able to use to debug the issue. I used this reproducer
> to verify correct operation after my fix.
> 
> Thanks,
> Gabriel
> 
> Reported-by: Andreas Hüttel
> ---
>   target/hppa/insns.decode | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Patch queued (including doc refs Andreas added).

