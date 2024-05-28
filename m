Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE67C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0bR-0003eT-GG; Tue, 28 May 2024 13:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0bQ-0003e0-BL
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:27:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0bO-0002mR-Cc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:27:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f480624d0dso9337115ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716917227; x=1717522027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bBlwiUJeQIH7DSXgOBC1Z5vxVVOeQRW7eyy+qteuh8=;
 b=xEBBeb8PK6VMNFWsHWSGFNAVMjyuQAvfgdqIjt7tKDXAmcJqqTQWKgetH9WH7U6T+A
 JvTYT4cUM866fNJQSKtRNZMljeP2VGJwxcWV13ACate/9pHSzJup6zmfe8rZmCxRAnXw
 cNB6wrBSlTXUAFWo6SfiU7UbyDmDlWp4C5dGJXkjqYB1UY9YMK2dYELuQiP6bN8VE7r3
 4DfyEc9kTrzzEc37HemVuGXWaSIF/aN+jZhNzhYG8FJirXYGKjPmY0jpZOcDgmDTobUk
 gHi5aCL4xq7wFRbHZPH9FiEGae4hOFQaLbFkhtuK9iB81yVnHBjKUVzEcKJ0OByVja2P
 dqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716917227; x=1717522027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6bBlwiUJeQIH7DSXgOBC1Z5vxVVOeQRW7eyy+qteuh8=;
 b=Z9lqJGH0t09u42tPCepeaoRwfYVBvQ3SSVslphsb+dZa3n1b+2lspJRv0R3k6hFAPc
 V8f5a3m47V3aIGTBQm65fr0MAHWwSy6st9XP9wTLZ8ANS+rVf05muRc2yLNMow9xb0X2
 MMWsVhXgzYzXXZxPT/4gTNNXefbiHH+Gd2wcmszR3C3Xryp0dHodmZLm7s+nWLzFWqpg
 SWsrA2YFhCLxDeOgoZWniTACADMH2yOsflm532zXc8BAplubDJkrCuQMvkjW+hQzDbIK
 NsC78/7jqyeB1/XKTBDIryJ+NGdZecGSH+4a4ifBapJQLinBo51kU9CySjASlTvM+IwZ
 QxeA==
X-Gm-Message-State: AOJu0YxdJNFuFsWdOnsLSE1UIx4AgCecSBGLNVTDhj0aIDXoRITQavnU
 ls9FVBFyLhpRlcArjQdWMC8tTbpVvJiMENdG8BtbjUWBM63jVzsUbvwKpLgjvPG9cZ/D2K9/0Rp
 V
X-Google-Smtp-Source: AGHT+IFGexHjtCw6gHn9t841IT1EMgIoMnALxdyoYO6/1oby25NljE0ssx4rqLIIoT4V6fEVj2YGaw==
X-Received: by 2002:a17:902:d509:b0:1f4:be9b:d30f with SMTP id
 d9443c01a7336-1f4be9bdadamr52760765ad.68.1716917227337; 
 Tue, 28 May 2024 10:27:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75e663sm84820665ad.29.2024.05.28.10.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:27:06 -0700 (PDT)
Message-ID: <ee96e58f-28d9-4fbb-a0b3-1ec385fdadf2@linaro.org>
Date: Tue, 28 May 2024 10:27:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 65/67] target/arm: Convert SQDMULH, SQRDMULH to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-66-richard.henderson@linaro.org>
 <CAFEAcA9MKmvgT6Q4qn8ELSA0pXEO2w2poHELW3Ed6xCs6cKstw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9MKmvgT6Q4qn8ELSA0pXEO2w2poHELW3Ed6xCs6cKstw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/28/24 09:10, Peter Maydell wrote:
>> +void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
>> +                                void *vq, uint32_t desc)
>> +{
>> +    intptr_t i, j, opr_sz = simd_oprsz(desc);
>> +    int idx = simd_data(desc);
>> +    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
>> +
>> +    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
>> +        int32_t mm = m[i];
>> +        for (j = 0; j < 16 / 4; ++j) {
>> +            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
>> +        }
>> +    }
>> +    clear_tail(d, opr_sz, simd_maxsz(desc));
>> +}
>> +
>> +void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
>> +                                 void *vq, uint32_t desc)
>> +{
>> +    intptr_t i, j, opr_sz = simd_oprsz(desc);
>> +    int idx = simd_data(desc);
>> +    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
>> +
>> +    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
>> +        int32_t mm = m[i];
>> +        for (j = 0; j < 16 / 4; ++j) {
>> +            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
>> +        }
>> +    }
>> +    clear_tail(d, opr_sz, simd_maxsz(desc));
>> +}
> 
> Missing H macros in these helpers ?

No.  The only index that's not identical across the vector is M, and H is handled once at 
the beginning.  Otherwise n[] and d[] have the same operation applied to all indicies, and 
it doesn't matter which order in which these happen.


r~


