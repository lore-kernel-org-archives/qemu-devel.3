Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54728EE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE3u-0002Xs-OZ; Tue, 10 Sep 2024 23:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE3p-0002Aq-4O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:30:29 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE3m-0001Mq-OD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:30:28 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso4464888a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025425; x=1726630225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FPngTQbr0rBe+nJOvetmm3WjtErXld0upTf9RN8b724=;
 b=HDHJbScrrPpjHvwi9ZsEfPU6hdfd7eReA++WfldKtEA88ejruFLpQcwKlEdrC1RPbk
 rjgLqRVyXWfASRRIqBqzlzyjQpXhsTJ5YfYfoZjtPgdJ5pzUGkIdaSFnB1k5dLx/NAKd
 fjKdxkCEwicQXps3uW02CNNsuzoj0M7b0CIWOT90BWsr/94o8DlpPARz+AegSkF/obN6
 QgloTpy1C8q3jIIjOPFI0SL7YlpYy2nJrb6/EqQZc+MOEUteXY7c9v4GbCyU4TQYA5n7
 Iak9/4XVhsWhTDpsGq6JaPFxIovnokIXMVF9t3WV9bOXct+QrrRau4jmEzqCJKFGccUz
 /7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025425; x=1726630225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPngTQbr0rBe+nJOvetmm3WjtErXld0upTf9RN8b724=;
 b=LaDIGin2NTr9OgxcjW370vWYIUcatHkewUOsvBEV4gTtt/tt5l8wYufPywQK6QeB4w
 z5ugPo8Ntn5gc0FT8Quzq5qbV805IU4WI321wzZ8Eh8OWqhidBoP4uyoSIZbgOK7jFEO
 RIgKYkM8EIL6+LejiqutEY/3aDAILK5QCcXCu+u9eB1fb10DMCceZqQjap4/IaoRRh6B
 wTs4ThjtofHsONIdgpX2JuXTRhzJVJEFobNx08fy6xkLD6DR7jpCMEcWphl4THcShM3D
 J5V8aJ85A6I7AQI5OPbF9J8YIUt1Eme2H3Jx1+9g5l1lsGROECmS7mUmVGenyQ136M7g
 3DCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0S4yTDiZT3YAKK4N7coBv2fYGs4TJJqIm+vkxEtF+Wm8VeP0Co3ufI7pJH7wTl/Yv/gsrLDrQ0W+t@nongnu.org
X-Gm-Message-State: AOJu0YzDtHy1kb9a0J0lndgt72biWrml7SFzb/6axeg1qvAaQbg5thsW
 82wUs2jHOFAgQLAHJoGNgpXHzq/ru98oSAzR9iSDZwabw9z2i9UvBIy7XBPjr3I=
X-Google-Smtp-Source: AGHT+IEM0ZPtokiVzf1ZR9gveB23C2LrocurLBsTCwxMxxRk0OFY3PQGaDXMn25Y5YPzq/v38+1xsA==
X-Received: by 2002:a05:6a21:6e4a:b0:1cf:4102:9762 with SMTP id
 adf61e73a8af0-1cf5e1aaa80mr3450123637.42.1726025424896; 
 Tue, 10 Sep 2024 20:30:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090920adsm2058495b3a.135.2024.09.10.20.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:30:24 -0700 (PDT)
Message-ID: <aac93df0-8f6a-453f-914b-e1f45bf37948@linaro.org>
Date: Tue, 10 Sep 2024 20:30:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/39] hw/acpi: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-27-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-27-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/acpi/aml-build.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 006c506a375..34e0ddbde87 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -535,7 +535,6 @@ void aml_append(Aml *parent_ctx, Aml *child)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>       build_append_array(parent_ctx->buf, buf);
>       build_free_array(buf);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

