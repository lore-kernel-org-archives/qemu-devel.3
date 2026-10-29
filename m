Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A741606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y27tqmtf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMP4L-00087Y-2U; Thu, 29 Oct 2026 08:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP4D-00084c-Aq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:17:17 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP4B-0000Li-KJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:17:12 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4b190cdc9feso1156913b6e.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793276230; x=1793881030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TgiqfMt4enZALtodJHzxMyM1+EJFhIjqABitftPbU9k=;
 b=y27tqmtf9gJT1CsJAoYW7C2mi4eXBST29ktwSR5wqG5SlLH3A/QdREB5JjLzW7YZAa
 a3K/KViXHgRzS1D9hPRLuEva3Mo9j20h+pUXNaCXcKQFUxH9VhqAkoinJ2P1T5klczsV
 NSh01iat5PbB334saewdhWTJOkOTwjLdhL/HehDi0xI1F1oFdiq+u5zjlHuDhSpvAWL9
 vzAoji+co/3AQFH7AFCdwJzh/VaDi3vHw4xK1iKHDGQK0u1KWRuVIMK3LUmrMk7KRirE
 FYRkX6Ot/GFq+F/YYd0jcDnjnk/e3mvBdhstTms/VWN64h9oweyA7S2Zq2GHXYoFys+r
 b5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793276230; x=1793881030;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TgiqfMt4enZALtodJHzxMyM1+EJFhIjqABitftPbU9k=;
 b=1kbyLmt5blqscCUyOkz0fGU8DT+I2OUURsNrSf5b/epMHAb5l0E1UvgwkdnDL/vOhS
 A61VkwlnrLeNTqmA5SdVPQjfei8fudGXNXuqIUx1pPRX4JDsPEkG8qiFrUcM/Jvlk1hS
 Pfz3Kn8d5v6AqvIsdL49uGMTaAuVfPiKwrMMbwMF9YNKjHhnsvD1zmIQFJ4hjq+NeQpx
 f7kcD42vulktjVFXZMpdLhauLlRD7//hxNirArEp/A2t7bN19nf453APsrc84jfEshKs
 wLcVvedmljpAocMWcdx4EoPEMMngajvdjZoChvVqnpH3K2aPQ2Uu3OAwZ7XWInevdUcD
 2fIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzALR+l4f1fhA5bpwsyz9kS4hsU4wNhCg3e+bMRYSlb/diXqWUHQiLFZRYSji8TtgFNgACdwRFY4lDR@nongnu.org
X-Gm-Message-State: AFq9FYLq2dTV92WLK0bvPWl7TTt6nRy+wGze7HG80x72vhvyk+d1yZQ+
 QrNsENlLVy/edHYn+4a6JcDkO/SPIfZ30ZqHGnLEiJzR5O3Ens58wHT/oU3uZkzi3LY=
X-Gm-Gg: AYBFou1oxaER26HN7a+wJpKbvO+AHpryVtFtgyBTYnn/hsb4qXqtPDsRoPnEhgU9g6i
 ibOG6xqemA3fJyRNT924b46n8iKMA2fShvkbHcz8Tg/gUzEr4HEkBmIrctKNE156MlsnySHMKH0
 i+QqgkfT4bpe/wqkHc+Ws5AN13w7oxmYcp3Hj9E7EQ0dvMB//9MzYm019ax4zIeHN9NsmoiRpTp
 gpTgsaAn3h11vGqrcS9xCg5pOpVnLyxonlZkAAIiQDebKPGql9Xhs0ZLwL3eva/oNqUgt3KhXM+
 PNWMDRwOU57dmRHnnESAG9zQZ4CJgA2zLhrTe96JoQqPL3cNMHuTeAzjhcRJTG3hSJ7u5erjRO5
 qXxVC3AmaHhseSua8lgWbgRKsKJZXhQoToe5h2JYR8k/EG3zUPHbI6mmwZtpajjBUcnmv7IS5d7
 3dFmPxyHePKCwHgCNY4gfic4y7MGlXbmIfGbQQpPba3uZ+KFl3sknEhav+4lx/DH4aWrUL4Z83y
 OHTSwz5vmyOax/jWMBxiB9PXiU8qi97+wPlYMQLM9fGorFXfgHU5pszdNh3QDSpFh6T+qrf15Ic
 q6LSzkbN2BbWDjQYEchHkf2Izh0cD+sd3peRREWusIRg
X-Received: by 2002:a05:6808:1529:b0:4ea:b0ab:b753 with SMTP id
 5614622812f47-56383e91b1bmr3359378b6e.50.1793276230154; 
 Thu, 29 Oct 2026 05:17:10 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c654ad38sm3716945b6e.15.2026.10.29.05.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 05:17:09 -0700 (PDT)
Message-ID: <cd19db27-b5c1-463c-9475-67808a4e88b4@linaro.org>
Date: Thu, 29 Oct 2026 07:17:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] tcg/riscv64: Extract elements for vector
 arithmetic immediates
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028143330.6518-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 10/28/26 09:33, Philippe Mathieu-Daudé wrote:
> The .vi emitters for add, reverse sub and saturating ops pass the
> whole replicated constant (e.g. 0x0505050505050505) to encode_vi()
> instead of a single element. This aborts debug builds on common
> vectorized guest code and is undefined behaviour in release builds.
> 
> Add vec_imm() to extract the VECE element, and use it.
> 
> Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   tcg/riscv64/tcg-target.c.inc | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

