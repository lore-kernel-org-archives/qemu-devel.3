Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9EBC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JzN-0007i3-M3; Tue, 07 May 2024 08:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4JzI-0007eV-6M
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:32:04 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4JzG-00080N-BU
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:32:03 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59ece5e18bso169603266b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715085121; x=1715689921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kahH+wzMeqGbGVPpwLDgSUVfZuS+6f/alnN9QucmKJc=;
 b=d4N1DfBK5WuR3inTGrcuZZaaL9NU7n+V+2Q9Wvcr0Yiggoi7WqL10Dk2ateQEfBe+k
 G4jBv7Dfp2d/ShMwIYdumtYQGVg1L7Qr0467IP4Fn0JOy80STd67w7d/boiDCe22mClF
 WJqg/kQ+8ryiRpjJTxGbWSrdNdB5t2OcTvtaiF9NjLEdeQz8KRPLYpl2bmm/92qptzrQ
 SbQqFVz6KztKIF8YoUYLHGnxC61D6rJbsIOHQigzG1Y6t7tyf6pFvE/jbk8qCV36upms
 tMuLE9NznVsYpi7pDaMZc5mh2OlqhuwSNPorxxR9KNm5Ux1gOZNOKPlj/DE5f9z39qPq
 9dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085121; x=1715689921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kahH+wzMeqGbGVPpwLDgSUVfZuS+6f/alnN9QucmKJc=;
 b=qk9o7U9z87CkGZy+Fsj87VG97OEHwECWPQ2hQiPtCJpOYMVZO8YAWQe2rucZHMiuSQ
 LYfanoC/z4q4V/RIObuA0jqOie9+K6/gF8HS8uS0Z3Ne4lOfFlhqjGgYKDFzxKui5FCc
 b/521+ZV6NSO0AE7kx9ucYeBCjpzusYFB2kDYkqFBGrSyOIsAZWc2hu6q6ie2L08iMHD
 cbX6l1P0Cuu0TUZ4EfZs8g8m2TgfnUUz0eZPKGC1H5032reDd1yh46FhDWWtv8Cay2/x
 V9M0fzt1iGzuy4UDuT8KXRq5tIHgy0NWPXkOT7tVLXiT0Z3iK69+xqPfNhe67A6Gt5j6
 KMRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhSX6/mrdgz5ooe4S0v3+T+XxwLKVxSRR4l2LHCudt3yv1AH/PwPWF4YxdnrIKyAhJGo0JI2UTbN2wXmz3wFOI5mqfx2I=
X-Gm-Message-State: AOJu0YzShVaUwE1besueKl17Y6KE9VqMdF182YHp1dwoCg9bgTWgFBEn
 nujBxSkPXFQibFE8/xZaYRDLUm4LpuP+V7NczZ/dsUb2vyJLVYrGwUjT2la0CZw=
X-Google-Smtp-Source: AGHT+IHmtgk7tZt/nl5Sv6vsATAE32qdjCgzAiogtzUM0e5y/w0qB6uSm9s+s0zO1Upv93MnGnpkGQ==
X-Received: by 2002:a17:906:c109:b0:a59:c209:3e2f with SMTP id
 do9-20020a170906c10900b00a59c2093e2fmr8463599ejc.11.1715085120611; 
 Tue, 07 May 2024 05:32:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 el1-20020a170907284100b00a59cdf6279esm2419829ejc.224.2024.05.07.05.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:32:00 -0700 (PDT)
Message-ID: <93bdf880-81a8-4b0d-aab7-df949cc4fe46@linaro.org>
Date: Tue, 7 May 2024 14:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/5] softmmu: Per-AddressSpace bounce buffering
To: Mattias Nissler <mnissler@rivosinc.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, jag.raman@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240507094210.300566-1-mnissler@rivosinc.com>
 <20240507094210.300566-2-mnissler@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507094210.300566-2-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 7/5/24 11:42, Mattias Nissler wrote:
> Instead of using a single global bounce buffer, give each AddressSpace
> its own bounce buffer. The MapClient callback mechanism moves to
> AddressSpace accordingly.
> 
> This is in preparation for generalizing bounce buffer handling further
> to allow multiple bounce buffers, with a total allocation limit
> configured per AddressSpace.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>   include/exec/cpu-common.h |   2 -
>   include/exec/memory.h     |  45 ++++++++++++++++-
>   system/dma-helpers.c      |   4 +-
>   system/memory.c           |   7 +++
>   system/physmem.c          | 101 ++++++++++++++++----------------------
>   5 files changed, 93 insertions(+), 66 deletions(-)

This patch has been split in 2 simpler -- IMHO -- parts here:
https://lore.kernel.org/qemu-devel/20240507123025.93391-1-philmd@linaro.org/


