Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E78606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CrzGvwDU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMP3y-0007wi-4t; Thu, 29 Oct 2026 08:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP3v-0007w5-LJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:16:55 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP3t-0000KS-R6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:16:55 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-84e513874f8so1407615a34.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793276212; x=1793881012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZPVoRRQW31QcGBoaDxD2pNzqDiP18AbjFYKGQ230ABo=;
 b=CrzGvwDUELsLfclrrcQHe+hrirs1B7XlB/7/DDLwWbJz2rq2lG6DeojmlPieAbpks3
 c4EA9ZpVp7iLspp1hDxe462kMpXMPCrx/oPj3/XjCebA45TCD9qDzayC6MM7sPlmPwGq
 w7rwVoTVq6bo2FpXRXfKomWJH6x5Ri7P37ZJ7BZMD03Yl+XGZjqPLHPYQwh443cEHcnq
 U15kq0xptpC04z3vs6A4jgyj3b/ZCN5U5cMefVVSZu2rcl70dpInTqGn3zpAckiMUjhv
 vSUHE4RrDaPdZOxlS9kmsQUxthxptCten62AyiOBmjWRAeu3h3RRZFaVeOW09yUvY5Nz
 u2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793276212; x=1793881012;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPVoRRQW31QcGBoaDxD2pNzqDiP18AbjFYKGQ230ABo=;
 b=zed0ZyzuSK/tVKYwuYXSG3ZKfEmzndQlyRFU4sqNemKkX5L2kvm16bNAdVuVOl4w2A
 tLLiuNHQ++vGV3QWAl1CtYUlCNcXsQqCU7lo82xRS+CSGpwLy7E81FmPzttbpvQhFU6z
 kRZX6996SUbRIpeck2lGjRJi89TfbvZc8qXQdwHhHUr45oWqTyAlCBVFuieVRlKkgok9
 /OvAGonWq5i445m3k1mwntDyoRDnVAnfcBfp6sRJHMIY+rkRig80zDI9oQjc5Dr7wccr
 7o5TzhmwKdgqMfuclzxV8p8HHKiDu6llk9TUiz6BUV9ztUbXXWEOzFTIJthnlc4QBBMj
 GhOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5W1BpsG2JJHSMg0iKiFiJ2+Lf9NAg/PNLcedOz9XfyQZxYIBnSGUtqpYwGbb/bGGcTbi+GOEX7NOW@nongnu.org
X-Gm-Message-State: AFq9FYI8/1rlhNPk+nFeJC7FDaCdq/6eYaKpUah5iyES51bp4+x3E5WV
 wBOcxKPfEXzCX9gDNSWbJWRC5zQ4dVak32VvZ9vzb5lxBpGse9yN+lA1/YeFz9JjrlU=
X-Gm-Gg: AYBFou2RbbFQ/eI51B6Lh04LXny5FYNc84hMKWppJcUm7VblYRmzRJChQ1cHuTdeYZF
 3pv6Vl+cLYSEmTVKYI0CVBXY/iu7ddv19ZiQxWt3ekUZBc6Z+8zpY8W+CG76QjDRvg5fHY4fSSC
 S7cu6iyRfcfcF4pW8es1tHZQfrmNVT6H4EHBMbElzeqn75TM50+b0Ff0QQYC4SmDomAN+XVLndB
 1/9+lm20ay3nLtmrBshZ0WMIATQQeXJh1t47yN/iBdkI3cW8hzccYdW4AsXyJVuz6IY2UZNIB/F
 KeULL/uqeXEtqEBHGCQLPeD8Ml0eqF1sfuxXcclWypuRrTqW+VhdGN6Jw0TLD5QkJLS1xsk9N9q
 EHQXEu6lihBZsOJ6HdnIzh3vU01QMesACrMiAeIz2HWsoydFE3XWaCHUV/MAZEu2jG6KKCmhhLW
 l3wwq8vJwG0sWqo6Ssyu5DeuePbnY7MXIwGLnvvXLIJdXsMxp7kf9woNO+cT53SWmsQhnabjLwL
 hyn4WOTxU05OCuGuNPvOlC7JEmQCi2rqAiBSsfyDp2exXViNDkjVJT3BxCuM+7Tfh0aTElT4W1x
 IWzCXKdlRXzgEZkb9DgnmHKsw97Ti7zeEm1/d5gOm57a
X-Received: by 2002:a05:6830:449e:b0:80c:d30f:97b with SMTP id
 46e09a7af769-85abeab270cmr4328710a34.28.1793276212436; 
 Thu, 29 Oct 2026 05:16:52 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm5117821a34.7.2026.10.29.05.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 05:16:52 -0700 (PDT)
Message-ID: <afb512a3-a151-4a67-965a-cdae1f919b3c@linaro.org>
Date: Thu, 29 Oct 2026 07:16:50 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] tcg/riscv64: Factor encode_vi_raw() out of
 encode_vi()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028143330.6518-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 09:33, Philippe Mathieu-Daudé wrote:
> Move the OPIVI field layout into encode_vi_raw(), keeping the
> simm5 check in encode_vi(). The next commit adds a uimm5 variant
> for the vector shift instructions. No functional change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   tcg/riscv64/tcg-target.c.inc | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

