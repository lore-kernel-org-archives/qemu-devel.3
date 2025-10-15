Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08455CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92Z9-0006Cq-EJ; Wed, 15 Oct 2025 10:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v92Z6-0006CI-Rr
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:33:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v92Yv-0004r4-TB
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:33:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so5467637f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538781; x=1761143581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pw54Wa3njJwyuPn9ZSmWMmmSIJfMdbSYe3HAYI34tWk=;
 b=IyWSV0z1EkAX+QEcSqeCZybAYOUJ0mC2joLj8cMVHl3DSbyAygS6/ElrJsrmAXFEkC
 sz12TpTgkQTpFM196qHXl4UXXINhUuK5regmAqjgaqk+pIgj2SOkNZuWVHrt9KQOHZLE
 3uust/iIvW0XofGWdf1MDrLHqBWeMAp+TjH5j2bWROT0t5CfBaPSZMydIaJRnOUM2IDK
 GL4ZoBVhzPluvnVVP2TewtGwA+iClatR61knFLOvDEl7gJVZ+Yj6GD5cpNY+xlU+/N17
 mv3bvGeaFTH37P8m/hmacVY3tdsh7L1V9jfoqCcZ+XkGhtrTH9QYv859PooKkuxzPJlA
 IzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538781; x=1761143581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pw54Wa3njJwyuPn9ZSmWMmmSIJfMdbSYe3HAYI34tWk=;
 b=F1Hn1NSS2aMi7MUFC+t5gQV0HwyfwBML8ZLwOj5x5ZGFPZqsKXAneX4pPvS7ZfPllW
 YesFXTX/gI4ktaUgw8H0p8g2UNCLnOZ6ZsaeJtbUUoDcL6andkENTWwlOwmG0EIUPD9o
 30qoE4BCxs4/KAcqfq+6g0Y4Tx8S1x2fBRuRt0KelZUF9LetJ8AkkbmnI1hcixeZRM1O
 ghHINYehr7IeHxmY4gozZPq5zu15W7LnzmGtdmdWlSuCiLnHvL6F+W8cpVY5zNGRWC+T
 z9bLLxG8+qQthSbPuXOOAbs5Bx6QHsp0N3Gw+PcoE+kwky8ag5gaA0t9ReSFkei3QpHv
 0m1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiyY3W3DJMi/KpiNhYI6ivWpVvLCxB4cKCbNSmfc9ZDWoRQvs1vY2GCx/5boKPq6PL2AVeN3ItIsO8@nongnu.org
X-Gm-Message-State: AOJu0YwCd8mXXHTvVj8vtpQ9TJUfCn5yayz75QCXSqRwx9Uzlkv7sXzr
 mH0iNDQOb3m4HtYIUUYSiYYnRpQMx5LKRJBFEnD1GfZp+YUqmBNomfARjnQtcS8ecAk=
X-Gm-Gg: ASbGncuR8vLyNpE56ARRlqd2jAMsrK0dyAemoHKBWYjkP+8628rtAjuE7BzBEQtP3YP
 bZmJmwIO4fz15g8trClHmh5CC6af/Q44Vy26N/FJ/k3KdibWBOdsiLdb/4b43wkFIkSqgg6EZxo
 bscmbq/fBnccDg7dEj/Gs6Iwg6d4mYWffSfk46DZnCLewoSnZNQwl6tGKe26viW36GHrqqEGn9S
 zF8aD7HTAWKGpGJp2pWmypL0Wgb+mX60J78AsFlZe4I6Z+luKbuq36EeDmch2gyeFCxgmaxUB9b
 iCI54lvWVr++2b+dLxLa09OQmwQBUNd8WgqQKUWf9fHUkIBR8LX7RRE4ObG/zSNtNkuB3QF/8QB
 NQHOFiPL2KmXi0pmZfQiZWTqyc+Qmv/HiCN3ruDvqWIlV/gWb3bQhRUZmrJZggWxcZtQcIUDRp1
 iq83++1OCWTpcB
X-Google-Smtp-Source: AGHT+IFpIMkp4xP1YuTWeFzLIdOYtniyYj8/zL0b8qfbuU30qJo06z65eFiwKaTAXvDUgfsi/q/nnA==
X-Received: by 2002:a05:6000:24ca:b0:3f3:3c88:505e with SMTP id
 ffacd0b85a97d-4266e7dfcb8mr19353585f8f.29.1760538781426; 
 Wed, 15 Oct 2025 07:33:01 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e10e8sm29464463f8f.39.2025.10.15.07.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 07:33:00 -0700 (PDT)
Message-ID: <673e3c7b-b8ef-4908-b74d-62203b131229@linaro.org>
Date: Wed, 15 Oct 2025 16:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target-info: Introduce runtime
 TARGET_PHYS_ADDR_SPACE_BITS
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: pierrick.bouvier@linaro.org, qemu-devel@nongnu.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-4-8b416eda42cf@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-4-8b416eda42cf@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/10/25 15:27, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/qemu/target-info-impl.h | 2 ++
>   include/qemu/target-info.h      | 8 ++++++++
>   target-info.c                   | 5 +++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index 17887f64e2..80d1613128 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -18,6 +18,8 @@ typedef struct TargetInfo {
>       SysEmuTarget target_arch;
>       /* runtime equivalent of TARGET_LONG_BITS definition */
>       unsigned long_bits;
> +    /* runtime equivalent of TARGET_PHYS_ADDR_SPACE_BITS definition */
> +    unsigned phys_addr_space_bits;
>       /* runtime equivalent of CPU_RESOLVING_TYPE definition */
>       const char *cpu_type;
>       /* QOM typename machines for this binary must implement */


> diff --git a/target-info.c b/target-info.c
> index 3110ab32f7..3d696ae0b3 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -22,6 +22,11 @@ unsigned target_long_bits(void)
>       return target_info()->long_bits;
>   }
>   
> +unsigned target_phys_addr_space_bits(void)
> +{
> +    return target_info()->phys_addr_space_bits;
> +}

Missing field initialization in target_info_stub[].

BTW this definition seems unused by common code since commit
2e8fe327eb6 ("accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS").

Do we still need to expose it to common components?


