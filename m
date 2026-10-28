Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23233606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l0eAN80u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6BX-0000uj-TU; Wed, 28 Oct 2026 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6BP-0000u3-Ny
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:07:24 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6BO-00058V-7D
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:07:23 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso11168057b3.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203641; x=1793808441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=csupwtguHGj40ZjGNsO/cWJDb7VvOw9ZCsf9ca+ttVs=;
 b=l0eAN80uhQxWJiiw9ZieJv0Z9yqXzevIOnltbtFC6HTvcIMho7XquMbjqdkGE/kZNg
 6DIyxJMxRai0E2RqCPg5hP41irfXogFRTzWIciT19QcZaZnJbogZ1WLL4GjCbi463ocJ
 Y5JXlZfIlkZKDTNOhSYxvpPMLVLrdvUiQbacOtV+RpEFhGcCXjChzVc/byew2phNvmKy
 TcxiTunenW2WeV9/g5YAGI1869BD1sYAJ0ZVkieGQzGod8cY7tDtUCOqkW1kiEENmUNN
 KIq1FJA6V3/3RsPAEMFRby4NJPIIgbLaPNOTdA8QOpPxNZtT/2ZSFT1lD7dLQh0uKQod
 M4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203641; x=1793808441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csupwtguHGj40ZjGNsO/cWJDb7VvOw9ZCsf9ca+ttVs=;
 b=O2p4WxTOUr5mL7Gq6CEJaDogV4btgwZq/zUbU/albDgFRdMCAR1jj1oiUHZx8MFRsC
 3RJcg7lSp+1CIy+fT5qrA3AnOXxjEdfB9NkLW3kv82yui3W89ux9MXi3cFxdvYK3+p66
 Cax1Y07STK2kLPKCUMPZPcEbkoqyDTrsKPXbI8kJrvIIh68cH5Tt9oasGOwmr/V2dQxt
 l8ogAyK+SV2ImgWtsvN9fbe0Ua8yWkPgeVCNckucmtRlj8vRfBdKr5iYKRe3IftuNLsL
 CRlEfvNAcQCuhTsV3DIGR+DaSPPJZ/247/8/mk5juTqdbV63W5Oy1l4pks9z5ZXeYWee
 a0dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW2LT7YFtsH3m7dFZhf05p/JFkfcD/EFn5V+KEaHj2g/6gxy5j50v65rmqcg8Sf5KtjT3Jmn/EbevI@nongnu.org
X-Gm-Message-State: AFq9FYJ0iYB+3UT8qE1VI6YH5zZNAWETq1ugB8bKzji0MAs+IGzq6guW
 9SzD6CjhnveFaMmj2rzx726LSix3MStbkE5BE/O1PLSsPsjGD+FvFqdbBpz+M8xXbF0=
X-Gm-Gg: AYBFou1Mj1JEaxTl2TuHy1jDnLFtrhOtBqX102JTLDfgYBToAMflV/VNM+VrxIlctrh
 ZK8+/9ja82ixTksavKuIEQ06rhuiJMpy3eFTZHzmjzR6QafcG0Nqkks1Aw0tw6+IKpUwrC0gFvq
 vtxFOHdythOJsjET18JdFsCnCVxG7GUF1MLeXPrGcoi+mnlEU/LPSnNwOnoJKWv0SHru3q4NR0R
 LrAbuC0ymKphKGqxr48gAyVUhvICGN2LuSOggMr9Ai8zOTFcUhH2uBmxFW+81ztvU6k56knSCrN
 OfRNCqGStrDbNYWKK9fEb2HCucpeRKOUJ4ImBL6T15QPi5DurFUSTs9YAJbd+tG0QYlgD0L38Yg
 V42lmbm5iSu04aHghtRlL9xCsB3WwAdvwxcTxdFB9DsywuqDbXqwJiGSViqhRfodEI8AFjCHrQ9
 xq4QCLtrvXSYTC9ypXAl4uWoA3tf9DX+wyTRt1zUFvLqzQoN8cjsvI4gmHYWDDPsiUb2FWY6s8q
 FE8llufAi3XSZehc4evu2guJ+AfRdFLW69SWjbm0WH/BfzpNt1zRIftb8RZbChWjuH9jN87TDYz
 fDK6rIA15fIeSdMDMkT7ZxvQywlHcnarTH1AHDriQnNsJZzYzku2GZFB6zFFk7jzXvDHTQZMIys
 zIE/24Nb0UAs=
X-Received: by 2002:a05:690c:4dc5:20b0:88e:edf8:e375 with SMTP id
 00721157ae682-8b1b599b9a9mr16829697b3.5.1793203640653; 
 Wed, 28 Oct 2026 09:07:20 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e5c7d50sm31104697b3.30.2026.10.28.09.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:07:20 -0700 (PDT)
Message-ID: <5dd0039d-dc77-4d45-bf84-2ccdf6c0762f@linaro.org>
Date: Wed, 28 Oct 2026 11:07:18 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] target/mips: Share MIPS16e/microMIPS 3-bit GPR
 xlat mapping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
 <20261026162034.32711-11-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026162034.32711-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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

On 10/26/26 11:20, Philippe Mathieu-Daudé wrote:
> The 3-bit register fields of MIPS16e and microMIPS 16-bit
> encodings map to the same 8 GPRs. The map is duplicated,
> and we want to re-use it for nanoMIPS. Rename as common
> gpr3_m16() helper, using the decodetree !function signature
> so both the legacy and the decodetree decoders can call it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.h               |  1 +
>   target/mips/tcg/translate.c               | 11 ++++
>   target/mips/tcg/micromips_translate.c.inc | 61 ++++++++++-------------
>   target/mips/tcg/mips16e_translate.c.inc   | 19 +++----
>   4 files changed, 45 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

