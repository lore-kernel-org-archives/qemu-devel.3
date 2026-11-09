Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF76606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CTqK3oQQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUuw-0000WL-6P; Mon, 09 Nov 2026 14:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQUuO-0000GF-Qt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:20:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQUuM-0008VS-U6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:20:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ed28bac8d7so5104645ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794251997; x=1794856797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kBe4vPxeCvnVXcv+Q7ORoiydLa5bbUHfqJ7BziF6P5s=;
 b=CTqK3oQQru1UkY5uPv0FxSHmYmnQnEg/IpefWkkzx4I9U5mv8ZXkDdTKMSxGSbqFvn
 kMObEoyT+4n36y2VX0Q/Ti4oYHODJOW+3JPzTHYwwbBDbMH8KYAk13nCEY/zk0/auBM/
 JnDmPThFHWM3rFTygGoi3qWa6BCDuIxaZ/ytbXmwWIigMZrohn4G1TDaU1QY6EZdNicH
 Q4wH9YWdrUEUEszAsaQXcCQBTE8M2Ph/HgQKO/1w/731k+PiCgZ3YfoOc4EdbDJ5OPoz
 27yqImfQujbd0OlDL7ztZ2qsXgCIGHAEdigVpNX7Zb2ncdtlJQXxDRialMkNuzcOfNl8
 fGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794251997; x=1794856797;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kBe4vPxeCvnVXcv+Q7ORoiydLa5bbUHfqJ7BziF6P5s=;
 b=kXT4tigPzaKCSODl33cNaFLk8pOVcChtmf/vJQo2Ho3E53AYDWAIXFsyR5NTMn9jq0
 x6N6GMa1ooDSON0c8pN0cAG+v3/0sUqiAcY8kAK3+C8nF5hpxAEuPf0/jOkhsIRLktKj
 heNIio5tfkMXWkTeOLH4AQqDJQHzMPr/BG2aErhS5hljeYEnLVYdnLMYg1oUOm0BLoYI
 y/QUOHN/LPrZtF5Me0kVJVZWAjzzKmS+UIe0W2bjMXPoHUU2Z8RYowcRW4LU3PVm2a/x
 VkyKPn79tNrvjQEy7oNHgauQwaFsjEClOtHDA1YbHCzjrZ1kB2CJVePKE2ckADZBvJDA
 c9TA==
X-Forwarded-Encrypted: i=1;
 AL+hErF4mE7asFGbYK3Nkd4I67Yyts0BA7A50a/oIclpeXUAjqsa3R6bg0b69lSv+74Wjq7mY6G5Q6yJO9pV@nongnu.org
X-Gm-Message-State: APuU4Z+hBp2HE3sD0R67W6L5/fsg9oK8q4tzGaYeMzaNyTcL61Bl0Cr8
 qTomBLYZvT5JTTHVZOJwEBz9DR93TfVvnnjbMM0a07/9UuHinJuEOBAWUtz//3LM1mY=
X-Gm-Gg: AYBFou2p4lDyRSRe9FGe6dUdJsA27ll+d9PQAU76umrj0xZi++lY4/bYMc5emKc0toC
 IHt7bHHDZtD1S8NFP2eDjmh4JnLqNdQxJvEPAqUWZWBnSQ7Bi4tIC81V78NmWkLF4SLCCpeiR82
 1BybcSq1Ag4mEfBTRrQXArQ1slNhw8kkViP1OitncZw6f3lfiEZS4Bk5y1ZP2bVmEG/vSsMwLr5
 fJI6yTaxBY2W4wrcpYJppn1H5KPXlTWiDjVZNhG/glWVGVSz24Kpg+Apu4HDUEP7C1WuR0mNirq
 AxB5TTq4t5j4acAvf9LWaA9J6+VfLdL87Ry/MAkmaCEuIMQiJNu7swypY/N17ocACqjgi1S7EZH
 nxv5VfAy0FK0yKJ4l1gUn5sZtQsLY4hJu1Ha/W6k5xT4h2vlEMG40LFBRkxLD31sH4qgE8tgStO
 788mYIwURtaJ3E8WXT3PNhfq8abZ1vJkJ58gSOpmvXRk2etD75pk9C607ezKnY9ezyoBoGdnyEc
 YoF707DlFxOvX6diCXMVBGqR3B1tKE1oBiOkvfZiqK6bESuohq4lLwoLj0eQgBAVJ+iP3GgifBc
 PZr5rLDYSvZp9XO12lXmwblvQ+7CnEEN4RCySDvu4QPYQyt2WvL/HzhvlYHkJ1rL1B0nzA==
X-Received: by 2002:a17:903:3bac:b0:2e8:5857:b5f4 with SMTP id
 d9443c01a7336-2edb909d6eemr691765ad.10.1794251997335; 
 Mon, 09 Nov 2026 11:19:57 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d4b12esm1333065ad.21.2026.11.09.11.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:19:56 -0800 (PST)
Message-ID: <3805110a-0a53-4222-b597-0941bdb558d0@linaro.org>
Date: Mon, 9 Nov 2026 11:19:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for v11.2 0/1] s390/vhost fix
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261109144344.847531-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109144344.847531-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 06:43, Eric Farman wrote:
> The following changes since commit f71afb409a87c4ecd0f9d63a5963eb645dfab780:
> 
>    Merge tag 'pull-loongarch-20261105' ofhttps://github.com/bibo-mao/qemu into staging (2026-11-05 07:24:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://efarman@gitlab.com/efarman/qemu.git tags/s390x-20261109
> 
> for you to fetch changes up to 94289e7960008ceedd16ba366ddca986df739936:
> 
>    vhost: only use config notifier when exists/initialized (2026-11-09 08:14:45 -0500)
> 
> ----------------------------------------------------------------
> Fix vhost on s390x

Applied, thanks.

r~

