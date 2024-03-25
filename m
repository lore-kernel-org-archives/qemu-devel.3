Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC1EC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogwg-0004R8-V4; Mon, 25 Mar 2024 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rogwf-0004Qy-CF
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:48:45 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rogwc-000894-Mt
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711360118; x=1711964918; i=deller@gmx.de;
 bh=q7sGUQZGoS8f00PkWTNy0BsO3lO7ahlS/eruXlaBRf8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=LzaNdHFma7KjVCZIgsUD1gB3LbNZR6KBGL7y5xlVN5oVkc5mYY3ZBvkWjvfwpC/3
 P/RMS4AeyvnqguLsrVvnWYvXmOJhX0m3/98rN2TwAZPJETLv79TmL6hYfN4wWevTp
 DRTgUoSzJpjHro3GuDfuUZ8afGaH4ERYI7BfzSumjN1SaqMOvlSPzBAEyT+LJ/aws
 R5nM9Sh/SPF6PjQkqI1L+vjBB3WWTi2nc0gtRAsP3w7CRaQ71JGjqaAnv84sxM0/D
 5HKEpESk61x0JrywX496/B7+PyXORZHIl12pBGWI6cS3bZZUzVBXF1Q2It0y8Nvem
 /DwkpIAQYa+ZyPKAUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1sbpWW1ZwY-00n8Lj; Mon, 25
 Mar 2024 10:48:38 +0100
Message-ID: <e9f62291-1bec-48c9-ab52-369580e3249d@gmx.de>
Date: Mon, 25 Mar 2024 10:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] targt/hppa: Fix DCOR reconstruction of carry bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240325030448.52110-1-richard.henderson@linaro.org>
 <20240325030448.52110-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240325030448.52110-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xalu9BqvpDtErKG5z5NOkE/75ZXMSsGx8hSYrM2NFD8IYxrEoTL
 yZ+60nbJdENTzMirmqio9zX0m7MJWVq0YNCF4T2+WxSmed1AQMJQEoy6BTMBiU1gBCRT83K
 RtovkBHCAC55rgW4YUGZvYtjabOsvX0ev8FPGjcaQQhmNczdDH2lXtBfahy307MVGMlujKT
 ahbU8EyFd/ykhmfoF27AA==
UI-OutboundReport: notjunk:1;M01:P0:Q9CMvlHMZ3s=;HcDf1drTF+5utJpjgoPk+ZX6c7h
 unWnv2yUhAZXwCod8ehZazFlxMkPpKRe/K/FKHg5+64dshR8bhY9DYHkb0m14SaZxULHBzRfp
 Z6n42YUF46j6KYstdxpb/XQVXDcLVy1Eg5iWTGDQ7WLND40CCjDx2UIuuE8Jzcux9HRmGagUQ
 YiebVwizAEeo95/QokqwhdJc10UtleWh7iB/J4L0DmY7bec0945jlp8kBuQb7+x36tPKejh4G
 bhExTBQfXE/V4SNNtyX7ZC0OVUciJD47jmLPVr09aAj0v+KbAmznz4/l6Tu9uHSwdbWNMrPgk
 BkCeD44WBrKuG9kslTJIGYKO9hLtBa8DsS8OFB23uxX9ULT3nBtji41mdqLQ7AZ9tb6mKlOfu
 dV+cJl2gBY1isFUUImGR50b3aDCEC3LCIlES8meZxEAxZD/oQIb4Mo0nFrBuHIgQzz9g51Xv2
 UuK+WbM0xYOSd8mL6DqDkOoIceIMGu/5H3rsbAu+alcufHswqY6OML/XEJWLICuhGTaIHUbKe
 RQU3wt1puLXHSfoJY0N8xWPZiQIz7yu8gJrpXpR7S9v5aeYuml56ki/Qf3hg6f6X0xAXnDGxx
 QVHg+DfecoWr5g61q+TUJEwCjzZCBRb47Ed3saS6ylApZlofOH0qQCKD1JPQePSp+S9IrAAUC
 pzQP2+jQHr/AP820IlZ4we9LwIqLVVX2MndwUwqmimrVhZy81oFI4/fDXQkgwJU4Tzx67K2VX
 71qF223MPg+KWTZhMp2b8yFK90y/2OXDK84fkQLDCa3Th91O2925gAftNsa7+XoHa5EFFUvKq
 s7SE/U2eTxXNL2/EGRq40gSZm53VR7BLVT8aX9/mX0tWY=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/25/24 04:04, Richard Henderson wrote:
> The carry bits for each nibble N are located in bit (N+1)*4,
> so the shift by 3 was off by one.  Furthermore, the carry bit
> for the most significant carry bit is indeed located in bit 64,
> which is located in a different storage word.
>
> Use a double-word shift-right to reassemble into a single word
> and place them all at bit 0 of their respective nibbles.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index e041310207..a3f425d861 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2791,7 +2791,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d=
 *a, bool is_i)
>       nullify_over(ctx);
>
>       tmp =3D tcg_temp_new_i64();
> -    tcg_gen_shri_i64(tmp, cpu_psw_cb, 3);
> +    tcg_gen_extract2_i64(tmp, cpu_psw_cb, cpu_psw_cb_msb, 4);
>       if (!is_i) {
>           tcg_gen_not_i64(tmp, tmp);
>       }


