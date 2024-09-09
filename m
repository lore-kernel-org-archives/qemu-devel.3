Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA670ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmge-0001ap-Nx; Mon, 09 Sep 2024 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmgZ-0001V8-3p
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:16:39 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmgX-0008Vv-0d
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:16:38 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso8468879e87.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920194; x=1726524994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DiLweO+xRzB/ZaK5l3QPVwxad0+92DdBtvB2cbENFUg=;
 b=OePyjmVdIj+Zyx9K0dowIqyeEWg6OTbyfAplIOpi9Bw1yhaVs9gV0SEt5abXmeM/wB
 0PPcla1W76nMQw8dp5XnuhwhB+WDiLxiqKZovA1452blUFOWjOgXSqHJVffV7RwvULSn
 gSvgR0SqgoCW1aA69yHMSDm/4og1QrRMmh+LiIb7csOjYahnidfKLa6R4Dc7gyCWja8X
 XB7by60ZDNd+tJxtpTglmAQtLJKTez91TiNl0tQv1j5LQsnGt+NIOsPDKCA/1EO+JOng
 JhBQE0cCogdNoBz0PXU08f5o0LDI5/bwlx4Bn+6dH0oHoP5e9rbL5xc1c0oBnn8EQJDB
 28mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920194; x=1726524994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiLweO+xRzB/ZaK5l3QPVwxad0+92DdBtvB2cbENFUg=;
 b=J/1YxTee4yB+eAja3QqWJCwz8nKDc4Qsg9rUyCqQ9Qw3zRAaPW5pkkP6eWG2XuyK8u
 tddv962FP+NwiNeBbnOxWiqjzIQAyjms+AzSgMZvAxEemN920Nx9hjaBHXd0kt/1fwKe
 hDZFif3mbqLqgiImw6HqBBf4Dns4uqI38J9OD8AxPgGHLER9lzgKcEh1YyCpy2Lt4yOd
 yHvp2NI1ZYlISb4Gl2DyVflYfGPthMmxLWxvaa/iwObcFED2cIh4xfaI6V8YBvDtoiP0
 jzulX8HXP4fdDMDXhpqP57JOWcH1REg9ioRPAeYyDR7wJdGr9CgjnL1x4f2BAU0z+uFP
 4fRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZMMhxTXrA8t6QD1HY7L75irRRNGFz4B7EnSZoSP1kH1FquzP03OMGuSbN/fnlX/kSUcYFN0HPm5cX@nongnu.org
X-Gm-Message-State: AOJu0YwHbGSWCEPRmKEZBnhnsF5sUKCWCQndAyIgWzDk5wLIMYkzyatO
 jq3O48G+2ISv/T763w5o98X9LVzFvFokRHhJNk+ml72TcuSColahJsxzxJWYPckUa6eemi8h7wI
 Z
X-Google-Smtp-Source: AGHT+IG+/iy6lGE/M2XkPf50AhuEgxwsvedFpzZNwSkxn9w2bD2SfNWWN3TfnTTJ9aqhxc9Zwn9tAA==
X-Received: by 2002:a05:6512:e97:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-536587b537cmr12211480e87.25.1725920193948; 
 Mon, 09 Sep 2024 15:16:33 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce96d9sm389880566b.157.2024.09.09.15.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:16:33 -0700 (PDT)
Message-ID: <2da77c72-de9a-4a2b-887a-16590de7c299@linaro.org>
Date: Tue, 10 Sep 2024 00:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/26] target/m68k: Merge gen_store_fp,
 gen_store_mode_fp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-23-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> This enables the exceptions raised by the actual store
> to be reflected as a failure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 107 ++++++++++++++++++++--------------------
>   1 file changed, 53 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


