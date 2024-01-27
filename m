Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1355C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 03:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTZZf-00045o-Dv; Fri, 26 Jan 2024 22:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZZd-00045b-RL
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 22:41:41 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZZc-0005tU-EJ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 22:41:41 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-602d0126e80so9992677b3.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 19:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706326898; x=1706931698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPffGOcjhH1dbcwHGhjSKxdPapvEAZQPeAaELip3Bo4=;
 b=bO5YSX2JfXwJW6/+uVhQfpopGZOVF8VoMjwjiPd+zCf8nSOT5LAFPvEjhll8vhAlBz
 kpjDi/QVOs3JOc7xHNT5dEbDCINyepFy95XlHwkHG+0A51qcYm+MiR3zuXuZkJ6+4W+n
 AMFjWx/BqL5v44NSoib0svEvGFSoKKyPSQcZMHea+le/8FINdW8e/OO3ChJjOqcmyy/z
 4+q1tSt6faeh16BGBk+vedQa/zEzqQqcVOfzni+p/Gj9q5q7+44MeziadubBCdKweUfA
 sy40z5HWk7gITHlVUPX5i4abe4bKncA8yCY1VCsW51xE0m0X4cq7OGghB4xzXZQCj/ZY
 mn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706326898; x=1706931698;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPffGOcjhH1dbcwHGhjSKxdPapvEAZQPeAaELip3Bo4=;
 b=FRS9pvQyggbtygaOYBJPArNMByizfCjd6dxPnZorEIwjPtmeWUxUoxs7lNoZdfBpLk
 EyzKJCDI0QkoPVx1GOM94KQrqf5Z4cyxwgdNthLG/dMx87ZAhcCWj/056EfqXic8yNdW
 pPCqrtGdGkQefHpjGs1PmkBN4ZFTRI65BUByjDU28l28eF4aTdYH5hHEzD2yFLRFOXkQ
 0PKfHMb2QDpnbBta3Hbpdk3a66nYj5ObZPJuyOvoD5LUtgNWbDkN9n68p+Q2Ur/AYCiz
 YmIcbAK4CDQ8TzxeanWttIDAWn7LdYWBZCUZzGBr1ix5Fqff3EdiYNP+R1AQtswNfwhr
 vb2w==
X-Gm-Message-State: AOJu0YyzNt6isu2x43UgKOe8Gqrhd/Didfp483K28gXG4zj3frNAPGjP
 283SG1mrmYzkZ5JL7Qz/tLGoktCSfNb2rXU9AsMKFzq4/1yFdhhRZypn7nYEOsOQyZUw/LkgtrU
 bz4s=
X-Google-Smtp-Source: AGHT+IGEyFXS0g3gdGj9mUHBaYdI2lzhAW0cwXDgbXOuyDUvA0GbPM6OhJKpyuROoYS5x29dIW7zgA==
X-Received: by 2002:a81:b61d:0:b0:5ff:7e95:107e with SMTP id
 u29-20020a81b61d000000b005ff7e95107emr845882ywh.18.1706326898528; 
 Fri, 26 Jan 2024 19:41:38 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 li12-20020a170903294c00b001d741873e4bsm1625757plb.95.2024.01.26.19.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 19:41:38 -0800 (PST)
Message-ID: <d4e8908e-6e8b-4509-b94a-06fd59e1765e@linaro.org>
Date: Sat, 27 Jan 2024 13:41:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Enable -Wvla, forbidding use of variable length arrays
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125173211.1786196-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1136.google.com
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

On 1/26/24 03:32, Peter Maydell wrote:
> 
> Peter Maydell (2):
>    tests/qtest/xlnx-versal-trng-test.c: Drop use of variable length array
>    meson: Enable -Wvla

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

