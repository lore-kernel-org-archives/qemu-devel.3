Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E28606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JJZBV9Qw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMS9w-0004L0-HT; Thu, 29 Oct 2026 11:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMS9u-0004Ki-Dr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:35:18 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMS9s-0005Il-Tf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:35:18 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ad98c3fb15so21149987b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793288115; x=1793892915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=btu1MYlRvjfrPiXKgNGqpohuyBIRrdYjsKE04wh+fkM=;
 b=JJZBV9Qw9tXHXnRiKrmb4Ds6eh4otu/dg1iC+OsKvuZzq9ZfVqNe2Gfo233sRE6LD2
 aFJx5l8+ZTMC9K2l3JR8VZUKi9V4tu//nEgCQT6cO0tS0P6aCih51TvQt+PRblyz6RDr
 KWfTi2WREpYmjrk5MeUaK1t/TN7P5iSlgxquNvZxfTB0Isgn4sgBJgMMzRf6WRMf+LEu
 GaQpFdIlsOjiRSgOosC3nmz8GhGdexWFfrYW07m1cs5q6ru1IkX7YxesGR4GPDfBI6GG
 340tl7MLOyxBQdjqsUo7hyaS8NsfVj1FPf8S3m2kriSWX/MRqRmIspOme5tSrZq4fxS3
 Lz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288115; x=1793892915;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=btu1MYlRvjfrPiXKgNGqpohuyBIRrdYjsKE04wh+fkM=;
 b=NvuLrdcfDgsxORy+j7nGaaqy4Gdzmp+G2EB4ALg7CgPrEcCjWKar9ha4VfMZrHYGdL
 wwoaq5aMGM/zu72Yw4DSTcWaBbl/BlIRW7wZV8hmvEF21oRB0UMU4wNxFYTAupfjKSBq
 RdvCqPYbj7xvL/yrS5wIYBcSF6wamDUtFRSLytASwJ84qhDC7UUp2o4WyjWgLZ5RYhho
 0w6hdAEJTWaPBRSqEwK/3H90Ip4tQkTqHkLbB1phWcpSimx/n+1AP7NLQ6HpsJU38Abk
 h5ySUUkApN1XpvhWII+Gi/cE/wIZ4NMzp6sVJcsYj51P1GEvEMLhffPkZ8/xqJAORjcO
 HJjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcQksat2nFNDBCI5JJbFw3qZDpR6d9qcED/CPiLzZyTlWNoq61mRjWep9UGkiWS/8rgUDTOiiGSEYS@nongnu.org
X-Gm-Message-State: AFq9FYIWDOvWQEvV7EqXJ29izIyeT5qcbzb8m2pAuNDRwop85mRTiNHn
 PBdDItDmJzn/Io5hFpvAkByysNFLoPFdQ6mUiZAMLkx2hCvu6cGvbcsmSSTQ+4af3Uo=
X-Gm-Gg: AYBFou0JHYoDEHp/853EDPGw+euNmVS7+Ue8/XQUL84tscwjL/tPKnJpwKe3mB2wt0c
 kvOFb4sNTCY0ecMNgD7TJ1jN/VZ0KvLW/49IkFMpRhPqmDlJghIj+qZlx8REGxRgfX785RB9HUl
 mAWQ2SLygMrzudRbgKXGZJG12fiVK9CqbhtvJuLd2OWLizitXsC4yuATAvcYHUoaaAcUWCRFK7U
 Zs5HhQLJm0p0jPbm70u2AgaYZy6nckKa9Y5Mt7K2PDzSFTszhx6WAMTVpQAEwSs2SrxXvNam4jc
 I+6ptWi6dsctmw4mffOAciPRdskUuPBVvKiSTcsllcOzxaN/pupgyA4OYMAHhXa0LBXd/Jc5Mqc
 x2HaZdNOjL3hcZDgGB6DjQhJEoZktk8NNiCHR/W+AW8YJKiighMsVFw0+edmXDr9ijZFRQn242x
 6ZVkpG8Tcl6bBiBa2jm0xM/PN3TJ+vY1b8SFbniJyLC5/vZwZPPIbc6msmaN1YO8c0E9KmBQqqQ
 vQNYS7NM8PwAMVSJ+jXQtsE02N3tDvaynBaMJf79R6XJVE541LhyL4k7Ex96Cn3ZP1Zs3LK5NX2
 c1u5PQsvNtkJJaXBM8JXCy4erVju1b5EYkaDKYz/dSfn
X-Received: by 2002:a53:ea8b:0:b0:677:ac49:ebc4 with SMTP id
 956f58d0204a3-67a7bd7b772mr3643212d50.67.1793288114833; 
 Thu, 29 Oct 2026 08:35:14 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67ba1abf427sm56401d50.0.2026.10.29.08.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:35:14 -0700 (PDT)
Message-ID: <f866a360-a77c-40e1-8503-e5e94bc08705@linaro.org>
Date: Thu, 29 Oct 2026 10:35:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/mips64: Test the Octeon POP instruction
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
 <20261029152009.19812-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029152009.19812-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1131.google.com
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

On 10/29/26 10:20, Philippe Mathieu-Daudé wrote:
> Check that POP counts the bits of the low 32 bits only, unlike DPOP.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   tests/tcg/mips64/octeon-insns.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

