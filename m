Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06064C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tae0p-000631-1m; Wed, 22 Jan 2025 11:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tae0l-000612-Am
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:55:27 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tae0i-0008PV-84
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:55:26 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MIxBc-1tv4Gw441S-00Szh6; Wed, 22 Jan 2025 17:55:21 +0100
Message-ID: <1e095753-6d29-4ac9-a74b-53a1f9b7c87c@vivier.eu>
Date: Wed, 22 Jan 2025 17:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] linux-user: netlink: Use QEMU_IFA_XXX values
 instead of IFA_XXX
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
References: <20250120213340.359195-1-deller@kernel.org>
 <20250120213340.359195-8-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250120213340.359195-8-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1ASTIyqFQRUK+YATBnUVPb8RdMw8oHJNddkJZgrJMAtdbSzD1Ie
 23pQN/Uzx6DxKLX4lfupQnRejOt6xnCLyC4X44u2X9gIJChCyBkhzjsuXLdJdEH1djgX0b7
 Ml97GmGCWKEYTrEM32h1f+llp18d3IlV4nS+cmD3ESoSpZnMJn1xNjv+9WIH1io4MKK+RUP
 G7bumnltjV9sg0MGKyXbA==
UI-OutboundReport: notjunk:1;M01:P0:earVsYS8Pj8=;+SK4GY0ffgHgURylQn64l0GR672
 00FBLBRstFR5P+9lW+VKPQcXQ33Bpsiw7S5LjEKQmFBM5CZUBI3cgt+dnXTO5hThVy5UTm72t
 INUvqauPJ32QtKvajotV2b0xG5OnPX2JpsVtS+eoFDxRv1GnFhJ3HojZ3AMuDKmXGuONc5q7b
 iGwu4N3dlJszezH6OfS89/VCT+zjE7Yh8J+BjzqB24xC8kfvzYNC9dmnvmAuAQoubl8rcz/fn
 LUjtM+UzLWyynhkXIe5nG3jWER2UhUEtwRj5gt+N0aBsWa908bFofTELWi1eT9686MCjQu4qD
 BDxqsgtfUH+oEhe6Vn9UhfluFZVFBPoRYy6kT35dDFeTIKTNwH8te3HOsJTTNlI/iuGP3euHy
 Pm9XMMxoliLyakHzaczWztzmx+DUZn0Nu62cyECHAYN8lyZZCnOlLIl3K5ugUkrjSUUGOQRHo
 MHyzjEddncvjktYp3ohFVIvuRlFkKTliZRWyc4yBtNC1FXwWG2xUuTjHsVLbpZCI0sWiS2fIX
 hp1InY7Kg3LKO+dFV8yTGYmJJUMvU0sv20hJJ8lGLVpVxfOoZAHmrP41vkBzxREUpj7ZSWCjS
 noI3vgxWumstEfEKus80sn6ECDf/djI4R4p+c33EinVfJ1U8RhryHmeO2cX1nS7wkjtehXW4u
 nk7wdU/5eTat1u81Iriuhbllh4XZS0orB6VEgVGIvgwgZg7W+Qds8WY1WgB3Eavv2yOpudA8E
 74UDpXf0bhbFn/PadVXgsQc0OufQBPeGdOyo8cUrZbm0jizkUtm9ipRDbnkAf/Ez48nVsyGvp
 Vx+nBlHnQ25zaj5KtUWPN9G3UHNj4mFUKttgIOVJs2gbpvl0ZgXtQVn/jzV4JXUOB23irVOmF
 2zazTo8e4lqITebI/1EN5vRCXh/Xy8mU+PJD1aSke5beH5JibDUyCxhMlOEdrSVkjE8rVrt+q
 OUaCcvrg/mYM9u0h9r80Q21w0VolPrfl1NdsPDm18uARCmjyN9J3ec/4aK4Lct39BJFabRLI7
 yBa9XNpSG7zDr07gCcoOSH3AvLLKI98LFoPOcnsmOeL0rVt/j+t2DIRRyg6wk4PtuAB3Mh8mv
 83gDp0l+JNdxH+e3+m7h751FuTEsbIalmY4qD+nOSoVoXslviDNZsu2RNX6W6BxQFEUHO1YYc
 =
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Le 20/01/2025 à 22:33, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Convert existing places to use QEMU_IFA_XXX values.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/fd-trans.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 105b1f0713..f83d1f79d5 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -1192,21 +1192,21 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
>   
>       switch (rtattr->rta_type) {
>       /* binary: depends on family type */
> -    case IFA_ADDRESS:
> -    case IFA_LOCAL:
> +    case QEMU_IFA_ADDRESS:
> +    case QEMU_IFA_LOCAL:
>       case QEMU_IFA_PROTO:
>           break;
>       /* string */
> -    case IFA_LABEL:
> +    case QEMU_IFA_LABEL:
>           break;
>       /* u32 */
> -    case IFA_FLAGS:
> -    case IFA_BROADCAST:
> +    case QEMU_IFA_FLAGS:
> +    case QEMU_IFA_BROADCAST:
>           u32 = RTA_DATA(rtattr);
>           *u32 = tswap32(*u32);
>           break;
>       /* struct ifa_cacheinfo */
> -    case IFA_CACHEINFO:
> +    case QEMU_IFA_CACHEINFO:
>           ci = RTA_DATA(rtattr);
>           ci->ifa_prefered = tswap32(ci->ifa_prefered);
>           ci->ifa_valid = tswap32(ci->ifa_valid);
> @@ -1501,8 +1501,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
>   {
>       switch (rtattr->rta_type) {
>       /* binary: depends on family type */
> -    case IFA_LOCAL:
> -    case IFA_ADDRESS:
> +    case QEMU_IFA_LOCAL:
> +    case QEMU_IFA_ADDRESS:
>           break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "Unknown target IFA type: %d\n",

I would put this as patch one and adding the QEMU_IFA_XXX enum in this one.

Otherwise both patches (1 and 7) look good.

Thanks,
Laurent

