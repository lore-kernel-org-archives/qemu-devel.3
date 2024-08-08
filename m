Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81860C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvMy-0005x5-35; Thu, 08 Aug 2024 01:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvMu-0005wT-A4
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:07:20 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvMr-0001Wk-He
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:07:19 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so492463a91.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723093635; x=1723698435; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enT2cpHQjyzy5nslTvcUmDkNDASMls0lzplufQTs2sI=;
 b=yMdHhg4dtnNxwiI1hO0UjhCplTkfABBsT/R+PvhSMWX7N1j8V4zHbVUsjdktt0kzZg
 NEprCB69SszMid0U4Bn0cUuOz2DsLx5XTAkIb+k1zllw1IpyO2WlEsu2+7pMqoAK2XNY
 B8NAdqPmautlDgbl+8D0P8sIgCLQlig4wReDsDRRv3v6KNYilymxXpoBl7+qcH/iPPUT
 UZLMJuKSJi8qOwY6sLD3wA4OPvU/HrJFZ347n26P849nRYQfx6hqPbt8H6BgslM0se/c
 L3tVI/uQW/qRxd4RrHLmyk0sz79aZUae2Fq911gwznvD3R2kXBPtXuk07kRhLjduae6v
 tioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723093635; x=1723698435;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=enT2cpHQjyzy5nslTvcUmDkNDASMls0lzplufQTs2sI=;
 b=cm7b1h8CjEvqTmPDa2WxDaOUnF9iJEbneFLSoKWkmkcPTOpxLHvYHb6lIqEuDkYk49
 mrXwllJUAknLWWUvmV2OscOP6SHNFU1sH4oNUM76QfHy/TgHGtm4lQa0oJ+1fRJGAgUj
 qPYWuSHbmvV7tcpYgzyrwmDjxFw+POMHKDZ3TvSRefcQyALSiYnAnjv0Jg+TWz5qpfI7
 5QAwwseC/qBQm4KUjp+2rIIRy9O3Hjexu1iNv0BGLsrHyO/ytUQJPRp8yB3kY8XvBqlN
 /sAMFIJ1ANy4oL07xM44vEnji8UmOPKie769rg0MDezCSF3E+xqjViNpwx0pzAmuMbqY
 Nn9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2viwr3th4vdrj4JFOHa4sRJJGuJY25ug1aqAvhjEJoPPkgWnfbjJ9drql52HeBa1dnzoAd753ODIHyqu3kJd3Sgn8YQM=
X-Gm-Message-State: AOJu0YxBv5FVP/tCTaUA0p84X/1W17DoLZZMi6iyXAQ1l0ENmxnE9PtE
 c2toq29jp9Vkrk5Tyse1B3JnWMxgkH04fbU4ZvdPHg7RDIbddq16FopD3I7sFk+LvdpGqAFNLDb
 G
X-Google-Smtp-Source: AGHT+IFbkdJY3g7pjTmfSj4FFBGLpNjm1lxOHbbmTpwCwEgokFzQ10pks2VhzYUmkAprKcm8PGFR1g==
X-Received: by 2002:a17:90b:38ca:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2d1c33b5ce2mr817538a91.11.1723093635452; 
 Wed, 07 Aug 2024 22:07:15 -0700 (PDT)
Received: from [192.168.0.103] ([187.75.36.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3ab894asm2529485a91.21.2024.08.07.22.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 22:07:14 -0700 (PDT)
Subject: Re: [PATCH 1/4] gdbstub: Use specific MMU index when probing MTE
 addresses
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-2-gustavo.romero@linaro.org>
 <707d1076-4f29-4089-b7ae-0bdd3e1305ee@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <b2c8c005-44d3-08d7-0a54-97647aa0ad0a@linaro.org>
Date: Thu, 8 Aug 2024 02:07:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <707d1076-4f29-4089-b7ae-0bdd3e1305ee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.732,
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

Hi Richard,

On 7/24/24 7:14 AM, Richard Henderson wrote:
> On 7/23/24 02:07, Gustavo Romero wrote:
>> +    /* Find out the current translation regime for probe. */
>> +    mmu_index = arm_mmu_idx(env) & ARM_MMU_IDX_COREIDX_MASK;
> 
> The official interface is cpu_mmu_index().
> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

s/arm_mmu_idx/cpu_mmu_index/ done in v2. Thanks.


Cheers,
Gustavo

