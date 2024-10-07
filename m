Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0901FCF887C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxus1-0007Rh-SK; Mon, 07 Oct 2024 17:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sxurp-0007Mc-1K; Mon, 07 Oct 2024 17:02:10 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sxurn-00079J-CE; Mon, 07 Oct 2024 17:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728334925; x=1728939725; i=deller@gmx.de;
 bh=Xh5m0gVCYGwVn938X3xjGyOvV0Ab5N3D1UUZ3mAE+CA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FTxtQt6TiRigCUb9eIQ+2GtGX7fZYg4dOUIZdh69vdmQVb5n2irqKSp+qJEtRRFd
 3/nbKahz5zpDZPlFDnC34VEnwrBcUqY0yYbl0s7OKhTwGx3Hq0RkYvUYYCzmExic0
 tiNSYO893zO12c/UJrIX5FeRoQUH/3A3pjWhznpH37IzjFtOFJwaJ0jyNUio4mqit
 c3uE6dC41q7WGpGqiHj1J1FfJO/PN5lKb6vNNX7h/NDjpwVV0/SUgJY7pz51Pvye9
 bV26gqr+CamGgE/owUCN5otdtzwALHYcv4eFa+n738zu5zfln+iNf+J42k3OEq6UY
 QqtGyxA/BbXb9dXv8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1tTWcZ3Agt-00Qd0J; Mon, 07
 Oct 2024 23:02:04 +0200
Message-ID: <0e45843c-01a7-4e89-a809-c8f03d0ca304@gmx.de>
Date: Mon, 7 Oct 2024 23:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] include/exec/memop: Move get_alignment_bits from
 tcg.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241005200600.493604-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KPfvXCahsFFrqCAao6fdpdWwRAT2fhIG/UicyG3avH9T7NOHCZB
 rnp5xqcrte33AH3C6bOKBhydIHvQPC0lMhd4AEitwln5Npje0hsGzIbOAOIlCgtmFyetcxE
 0u4Pi4GNLPrCJWKpNLH2feCpO7i3hE53ZT42/jM3Jy+VZW7nIszXu3uk1U8zG06RA/w1eF+
 JmgOyyJASLKHrWdvTWZ2g==
UI-OutboundReport: notjunk:1;M01:P0:Ql2WnfdEydM=;HGk6ueqeBTR/8IenwnS4ZvirnFQ
 +uxsLLXpTJXbt4WtFFmcxDdJ+VkhubiIeHpzO7cAGZjHTl+9LhfriQ+njvoU+ecLEeoICS6Hz
 59ncO/dyA3hFlUgEULvMrJoOZ0pm5z4O9YujV3hlFZpEJv5ru4/7So5tpBiZwbjtVJgbyUZ49
 y2W8ALmiHtdtzT11IqyCBx9l2j3BlsHFyUxYupgrSIfFE8QuJM2vRneLDrR3NsT5NCfx7kkCF
 0mDXfD6FYAIDMA13KkogaCWdPoLytLZLUFtawS6oWIXWaGSpzhQ2nlcUx28WixqflrnhuU1XE
 MqmUVbhRsfRRHxqXm3/TDaQunakk/A8QWAx+Ir7oar43/xprPIlxxWWkUsiK9OB9sTgJRvDaE
 epBhHUK2eotPHXQT2hezBa6jU6JwKpUtu4SpI8xQBAUCuyJ6QEr4ReKzGRGELHmDW83dHSzn1
 ow5evmxsuaCK7dnzvNDHUes5rsy/Qmd6iV6yB2jbTRTZAfnDMvH8yLbOaW8+t/G/nLBKjgEIi
 OTt6Q+CTwnycGnCjpNNAGire80FQ8dlbv8ysmqHQHr3Y0o830iA3BlMp7L9U/t5Er+9hg8BYx
 YpDHqx0FP7hwIg3Wv3oVKkomiOQNk1sEh6dw5u6bKVsHlvGKYPANF9KvCXGVgJ84R5i673i/I
 gPRKCm7rsS9lZ9EdkDzaXVtE3cxlDR818n7iNIvIX0Y8PMmcGpkyjKQrOWsrglG6tSK7b0TIl
 PhNkUOJs5t1VIetJwiaS4kywUTBxrioKOvVo+zbDD4mTGapAbbmuoaAhXPaytRaAsKtBhOjCM
 5/Kw++di6KhLqBM0M/bFVF1g==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/5/24 22:05, Richard Henderson wrote:
> This function is specific to MemOp, not TCG in general.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


> ---
>   include/exec/memop.h | 23 +++++++++++++++++++++++
>   include/tcg/tcg.h    | 23 -----------------------
>   2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index f881fe7af4..97720a8ee7 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -170,4 +170,27 @@ static inline bool memop_big_endian(MemOp op)
>       return (op & MO_BSWAP) =3D=3D MO_BE;
>   }
>
> +/**
> + * get_alignment_bits
> + * @memop: MemOp value
> + *
> + * Extract the alignment size from the memop.
> + */
> +static inline unsigned get_alignment_bits(MemOp memop)
> +{
> +    unsigned a =3D memop & MO_AMASK;
> +
> +    if (a =3D=3D MO_UNALN) {
> +        /* No alignment required.  */
> +        a =3D 0;
> +    } else if (a =3D=3D MO_ALIGN) {
> +        /* A natural alignment requirement.  */
> +        a =3D memop & MO_SIZE;
> +    } else {
> +        /* A specific alignment requirement.  */
> +        a =3D a >> MO_ASHIFT;
> +    }
> +    return a;
> +}
> +
>   #endif
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 21d5884741..824fb3560d 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -281,29 +281,6 @@ static inline int tcg_type_size(TCGType t)
>       return 4 << i;
>   }
>
> -/**
> - * get_alignment_bits
> - * @memop: MemOp value
> - *
> - * Extract the alignment size from the memop.
> - */
> -static inline unsigned get_alignment_bits(MemOp memop)
> -{
> -    unsigned a =3D memop & MO_AMASK;
> -
> -    if (a =3D=3D MO_UNALN) {
> -        /* No alignment required.  */
> -        a =3D 0;
> -    } else if (a =3D=3D MO_ALIGN) {
> -        /* A natural alignment requirement.  */
> -        a =3D memop & MO_SIZE;
> -    } else {
> -        /* A specific alignment requirement.  */
> -        a =3D a >> MO_ASHIFT;
> -    }
> -    return a;
> -}
> -
>   typedef tcg_target_ulong TCGArg;
>
>   /* Define type and accessor macros for TCG variables.


