Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28BC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 20:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1AsP-0003tt-8Z; Sun, 28 Apr 2024 16:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1AsK-0003tT-Ln
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 16:11:54 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1AsJ-0002Yt-5x
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 16:11:52 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso634124366b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714335109; x=1714939909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dDUr1CIBrHxI9tD6i7tgZ5DleLMhyEllp5AxSqUPCRA=;
 b=SbRg9quSzrRjc3QNtwybEU5RDd0NQ0GeFwpRroJJOKZga7/mZlA1DLLV3Xt1tCrbmW
 XI+1w7Clb5qPMkwRzNcFyAPJ4OEIuq5DyG1R6CHi+SCmXF0fJMJjww36bzyFyT17w80O
 E5OI+WQy2oUF3/K9BQsQVMicUD8glYmB/tuOG9Vf5ZKNT5lZGBr38rT/EOylSdRoiOdZ
 iGxJnnI6XvtEACBNLPVs8gVgmZEgAkFYB6qQ3sZk1yPuuLsSEjUy40oxu2MHxhX3HRmI
 LJHl7aa/+wvJI5vwYb7XKMi2Okcbf8+z6KXQNpt47GEFAy5g4EgRpCqkLLZ/Ra/5jiZZ
 TQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714335109; x=1714939909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDUr1CIBrHxI9tD6i7tgZ5DleLMhyEllp5AxSqUPCRA=;
 b=AX4LNi3XqtnU8SJDw/PROAUSQ0kTonrii7q2WqEQ1DLCfasNZvI8RDDJRorChstpBc
 Wvnr5g/HNwk2tw2aMn7uMqiGjgdjy3e/Q/ebzh6uWI7Nfd5hodfEbuPVVS9UgRsG03QD
 KY/jq9hNcT5Cips9Z490jnJoKJJMkm3hJoF6uqLMFjBDunPFy5WGWB1X4koXRKZmvg65
 Ll5EvVLTmwH+4+k04GKbMHXEg5xx0pUV0UZkA3gj6Z18OQ99l3Y6aHJvqWx+wIhpwDWK
 5AX7hNAZUZovu6a8SibrvNugbk2qQUpPWwdplCaeYndRZhjsKhuXh8SGJsbvUuPlyXIn
 CljA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmFgjEiDtzPSbnqLJxlkxlpo7Av/goMESDfFUNLmSvfGL6lc7V8CuOwICcwwzU+T3Do1UmCsIlpfcir1LgHBqteCdxjnQ=
X-Gm-Message-State: AOJu0YxQmN7351N6gf3uq5iG0Ab8RCLpdDn7FKLuiRWFel+FYMfuA0qq
 0gbsm9CtQ8nYRX0aIM8s9f6vkQ2uoAgSkIr6MPW/eII2/5J+pomxFO6+0RBLjhQ=
X-Google-Smtp-Source: AGHT+IHtJjib/yQFMgIMtchMzW0zIp9PfIt5nwTQY33nvYdHyfy5ql6nVoF7TYHKxYPud68yQFOufA==
X-Received: by 2002:a17:906:4815:b0:a51:abd8:8621 with SMTP id
 w21-20020a170906481500b00a51abd88621mr4723525ejq.19.1714335109097; 
 Sun, 28 Apr 2024 13:11:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a1709060b1800b00a58767c1120sm7290453ejg.10.2024.04.28.13.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 13:11:47 -0700 (PDT)
Message-ID: <36fb38e7-4269-49fb-bcdb-a96d577bd56e@linaro.org>
Date: Sun, 28 Apr 2024 22:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/14] exec/cpu: Restrict user-specific page
 definitions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-10-philmd@linaro.org>
 <5185c954-a03a-4fa6-ac69-a36001006cf4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5185c954-a03a-4fa6-ac69-a36001006cf4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 28/4/24 20:31, Richard Henderson wrote:
> On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
>> User-specific PAGE definitions shouldn't be used on system emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/page-prot-common.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> Come to that, PAGE_WRITE_INV is system only.
> 
> Does this clarify or simply spread ifdefs around?
> They aren't particularly common at this point...

OK, I removed this patch, renamed as "exec/page-protection.h"
in previous patch and added an entry in the "Overall TCG CPUs"
section in MAINTAINERS.

