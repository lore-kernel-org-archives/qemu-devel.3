Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76726ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniR8-0006bE-RD; Mon, 09 Sep 2024 13:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniR7-0006SC-2m
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:44:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniR5-0007XS-IL
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:44:24 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso110468566b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725903862; x=1726508662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WhADs7iqvEaAUaomqK5YQAls8lc0vQdbI/JzKzXPc4Y=;
 b=NOOgB1rEZ2HnjqtbF5Cmur8ShSLlb6CNkcNAJUhlda2qfihxFkdmsT9UWZDG7QTjAU
 DyR+sWpusYUWSAs/zAYThOy5nkf7CEsouYWjHZZuV8CaKBnGcU2N6usfgT1ZsSow9Nrm
 0rLPOLpGMIZq35k5yi8bldytYcg1QP1QO+rdSvRWDKcu7k8LP5qF2s6po6LkmeRcuOuO
 c7y7oG4wgHAdaA8p/m/sl3aKtxWPVA+Ck7wqQIpLXp6M0w3eqm1gSsgpWokAAZ5CnYC7
 oNkFLb4E9rI7Y70tOsoJmnf0IjsEzQUMroiQhKepiW3YqauXvU7P0i3ItL/BIMPOAx2c
 wwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725903862; x=1726508662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhADs7iqvEaAUaomqK5YQAls8lc0vQdbI/JzKzXPc4Y=;
 b=fNnnoCDL4I9V3H12pvgn7W8ZIjqSfjGqYjX7q7xvJNhBBduRZvMyW/tsZtQqWghAHK
 i5GDl8lTjtmRgl3MaPQZwvoCYdy7MKEmsxW4DGohLjCDTiccTP8XQHN8CKfu3E2Y4GRN
 sfY6Ux//bNgR6I5vvIIRDYGmEXyDWx6BygFt+cLOr613Ct+/MldQ1t5I+IUmURMeB/4t
 KyVTPOBhjtaYLOttlQGNIR2+EBB0UVrICnhhpwCi+Aft4/A3IccfRByI7f0HB0Uk/e+M
 rnhO2B7UriQ8WIPBhK2P43+dbIXfsy0BHF4mBglxaniurwS4LfMUBfmB9v5LGFYju5rk
 jMIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlaq6vTXjnvpPisy1k4fWKu4KK9hXQlZQ+/mMoUROVXEEZSN2DMuagRYbfGRhr2DDq7vvmXEQMIYve@nongnu.org
X-Gm-Message-State: AOJu0YxbXJnXN9KlPOR+Hymr3j9iABI26zSYiGZrOuwsLmx59PmFauXF
 8rx+T+H3hrczkBIzSAO+jWMiRGNqOO5TzaEyw9yPzFHao4dwasResh6QiVqKfkxlSI7g0GGm6m1
 T
X-Google-Smtp-Source: AGHT+IFnQ43mmnw0IOReTjbUx5/21BQqvOCFjGB9dEY8Rvx8tn+JOmG1HvOauZ4J4kxqodVWykMQtA==
X-Received: by 2002:a17:907:7f86:b0:a8d:4cec:fcec with SMTP id
 a640c23a62f3a-a8d731a734bmr53428766b.26.1725903862039; 
 Mon, 09 Sep 2024 10:44:22 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25952c01sm370880566b.64.2024.09.09.10.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:44:21 -0700 (PDT)
Message-ID: <5546695f-a746-41aa-aea0-a39a61a27936@linaro.org>
Date: Mon, 9 Sep 2024 19:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 14/53] hw/timer/pxa2xx_timer: Remove use of pxa.h
 header
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-15-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> pxa2xx_timer includes pxa.h, but it doesn't actually make
> use of any of the #defines, function prototypes or structs
> defined there. Remove the unnecessary include (we will
> shortly be removing the whole header file).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/pxa2xx_timer.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


