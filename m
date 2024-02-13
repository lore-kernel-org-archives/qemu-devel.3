Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB544C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxBk-0005Xf-6s; Tue, 13 Feb 2024 13:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxBh-0005XT-Ok
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:07:21 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxBf-0006Aa-Db
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:07:20 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e10303de41so580068b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707847638; x=1708452438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tMINNeaRKVcULc7gNovgbfB+EP2MT7YGxuZunC/CTLQ=;
 b=lLrWBA6nPs4SawWyTH4PMYo5G1Qar+22ztyHcNQHa8CqRX8pU2534ouB3h11dcxORz
 XKzlP7bGZc1njnNW5bpvrxVoKVTG9MMknWcJcLsjlxzE7A4ViDpF042Ov1UBZm5uvcxd
 tGUZ8X5jWg4OWCx/rD58KWR6/n/BzCd1tfdiIL1nX/5hg6rDUlN4wDctqRlm+uqxKPc+
 8tATFvs9OvICmRcLmXu/KHtpL3xnwwLgjcsYasRTnhSjVPqOYDtNGSyfohiTbtl3Xof4
 4xJhQOBAmACBJrgLON3IJZkduYHiu9MsYgyvQZfhilrPHvIiKickBIm0NSd6xTUpMLAM
 PYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707847638; x=1708452438;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tMINNeaRKVcULc7gNovgbfB+EP2MT7YGxuZunC/CTLQ=;
 b=c/EQjD/8Nc8OKoW8ka56ElZQiOs1rtQO3OTMpShoyfvNMQd2Zqa9r7cs3UbvoeSrG1
 EJYEnIS2qJIcGYa6EL6QiHTWNMe7KcjhXmq1tiI5V3P5uwnseU9plzGfKQVeobWrEwfR
 b9M/EC3Bn/l1ZH20yDxVeRpWFvjK3KQshJPf6s46Rg8CkYgxm+xuaDJRhMAmwgLaiHpK
 daINQFHjkL4pilFKRRpsNhGsdTb+GZbI0s/0vrxPGSjnuz0d2zLdR3SoVLkljYX0oNL4
 A+dENdjVECh/aqj27DrevzL5ZckCWGV1zlYM0d0sXFbUgZTHn4uRbFErp1u6M0wR5I0D
 zjww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV7NEK85bC9rEf9wC1EwNdtNncFSSPnYpRNQEbqjuqDMvhz84m4cYHTh7rJeBVMVm0c/w1/XsGUF7AmCkd5XAoJA49Z8o=
X-Gm-Message-State: AOJu0YxaxdFtkJs2qVm5ILj6FkAb/CReNUjDZb/4OvTpYYPdwld9gYes
 ARluof2099pPo45qfUM+AuHT9vavuv31dpiYzhu+VIQb32hA4u4ayNwLq2okNhg=
X-Google-Smtp-Source: AGHT+IEmUVv9QUEfUKzapY/BvLhH6vz4pqThMntTsYvVKGHLLeGStok+INHFqbQMA2Gzeso42MQLQA==
X-Received: by 2002:a05:6a00:1394:b0:6e0:a9bc:ef6a with SMTP id
 t20-20020a056a00139400b006e0a9bcef6amr31477pfg.9.1707847637675; 
 Tue, 13 Feb 2024 10:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWnN9QIpRvgoYvSIIC1n0g98af/DQjRN3oz1wSnuen2L6fBS8D8KwkKudXAwoMzlUfuUccxaNQcqiEMymRU4snwXnOvaEA=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ko19-20020a056a00461300b006ddc75edd55sm7634246pfb.152.2024.02.13.10.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:07:17 -0800 (PST)
Message-ID: <0c74fa06-1dae-4491-8641-63c352544b57@linaro.org>
Date: Tue, 13 Feb 2024 08:07:14 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/18] plugins: remove previous n_vcpus functions from
 API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/12/24 23:39, Pierrick Bouvier wrote:
> This information is already accessible using qemu_info_t during plugin
> install.
> 
> We will introduce another function (qemu_plugin_num_vcpus) which
> represent how many cpus were enabled, by tracking new cpu indexes.
> 
> It's a breaking change, so we bump API version.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h   | 10 +++-------
>   plugins/plugin.h             |  2 +-
>   contrib/plugins/cache.c      |  2 +-
>   plugins/api.c                | 30 ------------------------------
>   plugins/qemu-plugins.symbols |  2 --
>   5 files changed, 5 insertions(+), 41 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

