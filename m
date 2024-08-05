Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B57C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb2Kr-00049b-2S; Mon, 05 Aug 2024 14:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2Kd-0003QN-9k
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:21:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2KZ-0000E4-0f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:21:18 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7ad02501c3so434755366b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722882072; x=1723486872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mbIBG2dST87uiWY6rJO4bVLlI7/ZYn5a+IVVDSOCoo4=;
 b=qCA0FDzFG01dnNuAw4UMmXA5uvBbQMaZ0ZMHwtrFkNxcDnvC8cWkAHz5kWq1UBhM+J
 ZHic2KMh4/3rAQwflxkdTKhiXmCbZX8ewf2sqGRhrehcjzwAlGBTH7KKhnrX3xSgF8l2
 maARIQYzzFjxO2m8+FsdvFGm80QDxhZiLXU/msbNeFQ7YhVKE4OyRde+RGZy4Tok/OzY
 BWFUQ2sI60RhMJgJ/UBEdVwYF3kNWtm/1LltRxo5N9Dha+6R5q4JlEvZGW4lPSoAJbrV
 dF6h1PMCRD9rGA+pwAieNwDEH1XGmA63Rl98ZmQn077VbZlQhsVtH26nfUljwPZ4mSBO
 dCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722882072; x=1723486872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbIBG2dST87uiWY6rJO4bVLlI7/ZYn5a+IVVDSOCoo4=;
 b=X+vF8ZvlPgT/cQypazlmNllzm8m8uHzzpDxmm+q0A+99D5IAL3QiLypMhBQQ1UnD5W
 fSaVCn0i5N73R4FG1VAI3GbNBXO67SeIkJaRzRVQ5LO4/L5gh2tvbHS4Tb4fQnP5JBw0
 2+Ake6CZ0umTr1cWxtq9rSetJljyHwEzu3s3UTGSyCmmUDScZ7BsJngAgicBWByp5P9t
 P5wB7+UWelOcEW/ppxQGW3vr4Gky5wrqs0WvuFNb32s66/UxsjH8YUB5R1t5FTjC+p4h
 k3Tcgm7LqMREk1vuI+qiWWBpyQvSUzGdbQcPomickD59z+iBG9rPgVx0BzSeo7okcw6i
 lzgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG/Gwv1EWZka13a0Pg6xSKWclNdq8suqG0SafN9IB0PCQ0/1qDk4CwgUFu4RD3aUAhi55qPsUF86Vw/uhqn0JmO72x2gw=
X-Gm-Message-State: AOJu0YzHqyU0MZm6iiood3CGkDoiK2FJkhxxh2Gg/S+JxMFZQeA2pwO8
 PRaNU5ub9XYs1ZcCFmLmB2Kur2roboPWXSxX+w1TxRyqCvDQZdiniReNstjtJgA=
X-Google-Smtp-Source: AGHT+IHGIHFo/+knp10DncZHIczmekyI8oTGMAuNAibpcGHFmCNGiKMHPCpK9MdMnN6qZlDO9mpwaA==
X-Received: by 2002:a17:907:2d24:b0:a6f:c9c6:7219 with SMTP id
 a640c23a62f3a-a7dc517a75emr957269366b.47.1722882072070; 
 Mon, 05 Aug 2024 11:21:12 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3cd0sm487353666b.11.2024.08.05.11.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 11:21:11 -0700 (PDT)
Message-ID: <9df8ffb7-31f9-4024-a52a-987bc7f26c80@linaro.org>
Date: Mon, 5 Aug 2024 20:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] block: Miscellaneous minor Coverity fixes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 31/7/24 16:36, Peter Maydell wrote:

> Peter Maydell (7):
>    hw/block/pflash_cfi01: Don't decrement pfl->counter below 0
>    hw/ide/atapi: Be explicit that assigning to s->lcyl truncates
>    hw/block/fdc-isa: Assert that isa_fdc_get_drive_max_chs() found
>      something
>    hw/ide/pci.c: Remove dead code from bmdma_prepare_buf()

Patches 3-5 queued, thanks.

