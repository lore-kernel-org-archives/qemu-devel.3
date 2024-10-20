Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D234FD3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cVX-00031x-6f; Sun, 20 Oct 2024 16:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cVV-00031j-4r
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:26:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cVT-000668-Et
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:26:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cbca51687so38718525ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729455990; x=1730060790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ss2Z/bPQjYGr8B0JhGUQYWJB1oU8KVIquji3pDGJPzg=;
 b=zIpxvRe72hA7Z719A/0ByjynJDbT/ap+Zcd6PzaPacxPuskRk28f7rbOr19TEvKzRj
 /HyRfriDQCZc2kb0QekCwXJDFNPr/segDS2rsEZvwXwVe2p2wWyNvVg9JgNNZoPYLXmQ
 D9LikJ3mb2PWiRk10z1XiuZkfrJTdlH1IlW15XVb67S4W4Y5ZpQITSUryZXfEZ7pPpvn
 kNot0jxibzVFn2Kh+xw1uFvm4Z75eUUvP7C/fnL8gqMgIuN4wVPLlvT9PK4h2RWcj6IF
 TWkx/VYoH5nGWCL4dwz/7tUjCSL8X8JlRmnsFb+yGfSf+rg15U8prd8ZfK9/fro+dzo1
 4S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729455990; x=1730060790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ss2Z/bPQjYGr8B0JhGUQYWJB1oU8KVIquji3pDGJPzg=;
 b=dWk5vcQuth7jgP2gwCvJ6uStPAdvvEfhTLZAMejZ295MROFyhi5U4gmFEY4//pjamA
 kHWmsJJ1CEy+7BfYYevGCdsvcco6wbr2VzJgJHH5p5IZxN70g5YNYWbPHAelpCaMRzBh
 QX1zTrNPCLGcOOzIw6yoeMxM/zozULB5/eF3STKnbJanOmBLh3mRhJ5LbmpF7EuOxZGV
 knSN5xkjFKfugj/IeXAhaJnf1pSCfdDxFlNk+LO2PGSKzI0pVShBEZUpA20M6za2Ty56
 PCoDhx8BQKmyAXheTqwcgxGRjXTSuF9jaYJ/7Isqx6C1iK3a0JePm3pRUOM7tm6YmcDX
 Ho4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCowQIWWUrEWW0hYMupUAcSSKLg3+PQ0tnROYuLfKQkxF+REFLukd2WDfc956MeSOSteTFZPk8OqCz@nongnu.org
X-Gm-Message-State: AOJu0Yy+rLBAsuwOwiY/RGhKSLJsINx0cCch8au+vcIPG6yCyZavvfNx
 BBDaM27m7pPVFNucojdVo/8ipyTHNz30z5OZrbs5TZHljVzPKwLJ+2n7UVjXTFU=
X-Google-Smtp-Source: AGHT+IHjzlE+pfezjzXNaIYIKu8KmmDasgprFyU4onddzWuCKuv4a9WCH3rAzXv0SQqwteTWfufPgA==
X-Received: by 2002:a17:902:e5d2:b0:20c:7a0b:74a3 with SMTP id
 d9443c01a7336-20e5a7954abmr148311275ad.24.1729455989733; 
 Sun, 20 Oct 2024 13:26:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef08d1dsm13662425ad.89.2024.10.20.13.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 13:26:29 -0700 (PDT)
Message-ID: <e6df3152-6b57-4d15-840d-66e052293bf7@linaro.org>
Date: Sun, 20 Oct 2024 13:26:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/i386: make flag variables unsigned
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/20/24 08:53, Paolo Bonzini wrote:
> This makes it easier for the compiler to understand the bits that are set,
> and removes "cltq" instructions to canonicalize the output value as 32-bit
> signed.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/cc_helper_template.h.inc | 46 ++++++++++++------------
>   1 file changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

