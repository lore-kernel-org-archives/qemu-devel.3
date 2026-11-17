Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56547606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MQhi+mK9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOm5-0004Y4-PX; Tue, 17 Nov 2026 14:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOm2-0004Xq-Rd
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:23:23 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOm1-0001cm-69
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:23:22 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3b3af93b85cso43970a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943397; x=1795548197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b6buHuBlXNGbqmAm94qEjCdfIRHMjypO5Uy+1CCTriw=;
 b=MQhi+mK9CXItRNCvWA+jqfXaCWABn5Xkia/q66kR3TVdaDZ03e/1fEqxV88kyNn6ON
 w8zfduxgquYoM0r8aCSFHAESxFFf+J51m1lLW3Vmhh6T0/W+0wjjjZiQJEMU+GRZWH5O
 wXX9w7mjuGFQcjI2rRj5NSbMfJZ1GyBfcqv3sffTmvrgsCGknwLWqi3JMf/G4MIIouKV
 Hut7kv2oQtbGYVgfy8qFwImhGQqpfn2j+ndZi2IBuf/q/2molvjdkTpuLVSxg68W8bNL
 8RUEEpwTxakYcA86P31WW8uCd6K9yb3NwAWXHMS9vBliLjbTXq1tXROyZR0GCbX2oMnp
 hLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943397; x=1795548197;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6buHuBlXNGbqmAm94qEjCdfIRHMjypO5Uy+1CCTriw=;
 b=BOVuA35d0i1/R5Pi3EgYneTlXsNR3t3nTn28Ae8zROH+3NHcewQg2AQ3Q8VftAeR2E
 5D4jBU91ksLCJGs+oRoTsUGDFcrK994qvU0BnQqbei/Mo9LZnvAmDATH1MvJAWA6CnLi
 eXG95iAI6lLAgj3IdF+VXz9zYfsxz3fyPpfU2paMS50GxVWPns4z4DOGQ1tzimuPbFzo
 GgHp9V3sldjwxLJDXHZ+Ts3cD4w93FCLIeYCJ7lb4iLiGVwiTuZu3+ZXIzgFjlYboRWM
 lBR8Pl9kcYwK+Gk1D5Tfn6mJ2P+SnukGfC48Rj9roXBDyA0padA/0FRPIivYr7H2aNI0
 5k2w==
X-Forwarded-Encrypted: i=1;
 AL+hErFXjc8cIeaaQLgPnnutnL+zPbMLG7cZbs4ejI6bo+eE7bG3Wnzob3CevUKztH0HOzIFnX8CNbV2gOK/@nongnu.org
X-Gm-Message-State: APuU4Z+r+BLe6JRKnGDhzY12MKao7UoAOj1KrcwWFbJDNrhLVCTzJ74B
 bFSfqZcqIRVbFgru8S+xlMRFAi+nyDX4S8WpoUBGKb/UbFDoD02KlLl6XHtiItKE3hM=
X-Gm-Gg: AZFdTZdZi/TQkWe35O9nJwxfd+/NFA9oGqTd64qNhvMyom86QLr4XySmPH9Jd45sPbk
 dvUZJBjbOm1dHAIs3biwsqNInm/JTj0yK5Nb6Gh3r8PIeIsa8SOw91rdKJmrFBLF2eveNczQKmJ
 jAEKqgMjvjGeqm5gBI3KcTdMQ+WVxWS1y9lErC/P+3XhZcytib6WJPUnQsjUfXwZ11KQZ7Bf8Z7
 vTsv+vQRQpzH1PM//6U3NBWcTndxgtpU14puaEN+nODwAq2ZW+uc+BMmHhw85Wa6O/EHLJ2YP1e
 R6MjDAL7VqebFxYfN8MqwtBMs5ecbYKKeszT0x7waEv2iRhSJ1G3F3v4r88lnoB5UpoVLU3VHkt
 CWTbpBBg5DOBwbmPzA38IPmTsNRHZ9EZhORGDqFvfGCSER0wAs5oFuevY4jomislrXg/9lT2lNQ
 4tmKurEFyMydIsFgKIEtwnJvHoeue7Lp7LqzVTiQA0VnxKVdmNsxh0VVMLR4Z5Ds1Yg+AzGnHmH
 7zarc+k+S8ddO5pYRg1oRWvX5s1ei0wAGW4H8PfEsWcQ+STF1VWXHzAXgcfVh9LTLkbuymqWQ/X
 pC10j2neABBDM1zL00Sjbtn9wTpmLrvY+JwlOCjFUSwJu17hk51Gj2YcBliLX6CeoBF9a1I=
X-Received: by 2002:a17:90b:5307:b0:39e:21a7:5df5 with SMTP id
 98e67ed59e1d1-3b3d0760eebmr416197a91.24.1794943397505; 
 Tue, 17 Nov 2026 11:23:17 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187aa1esm365615a91.5.2026.11.17.11.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:23:17 -0800 (PST)
Message-ID: <6acf512c-bd2a-48b4-a62d-34ecb7965ae4@linaro.org>
Date: Tue, 17 Nov 2026 11:23:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] target/mips: Pass the nanoMIPS BREAK code to
 generate_exception_break()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-16-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-16-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The nanoMIPS BREAK[32] and BREAK[16] decoders call
> generate_exception_end() and drop the break code, leaving a
> stale env->error_code for linux-user. Pass the encoded 'code'
> 19 bits for BREAK[32], 3 bits for BREAK[16] (MD01247 rev 01.01,
> p.59).
> 
> Complete 6f3533dd1b6a ("target/mips: Extract break code into
> env->error_code").
> 
> Fixes: c02809830346 ("target/mips: Add emulation of some nanoMIPS 32-bit")
> Fixes: 8869ad02bfd9 ("target/mips: Add emulation of nanoMIPS 16-bit misc")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

