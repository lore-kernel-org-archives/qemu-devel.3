Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A969606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VeCTsN8u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVR1-0004qz-88; Sat, 24 Oct 2026 02:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKVQx-0004ql-MS
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:40:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKVQv-0006gR-M2
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:40:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so1348895e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792824047; x=1793428847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKKk5lVa+Sps3t5rws74SVErFUIjMd7rm338gTk+hNc=;
 b=VeCTsN8uqRX9Z6x6AO5nb4f8xJBH4JhwKcVZz6iv8XqxnR6txfW7Ic1MgiDrk2tjrC
 ohmxQyMkL6xU73lefawuSAgkd9LQ+QhANlaYFnN7iEVOVjQ5JQTY2Ah9ntLmWIJW+o7m
 WmZDvuDXwU0ekHfKhQoq3plZRz+HSvPyZ6sbTMl5qEZqFcPioa+NOdIwXkc8w/z1TLGq
 h5j1pBBmALlWw8B5Z1gziRd0lMGlcuJo+06bhzMKK9A3F+pg60/sFoHMbYoTfDnfxeZD
 ONe02cE6826Pa1nbOw6bIXgGIK2ZZuVBDyfRQe1Pk3WIkri+jQ9KH9mOyDCV6rH9vkp1
 I5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792824047; x=1793428847;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QKKk5lVa+Sps3t5rws74SVErFUIjMd7rm338gTk+hNc=;
 b=M9beUUao0XomJeI1KEJE6+OOA+ArKRNdcyby09wE2Aw25GuRr8MN7RP/VE9VWrlh0j
 LkEEbnb0Ht1QvmJEj3KVBRfUhg2I0HWuCrBgLeykUUN7mcLikzkWiJpEnKUvWzfriHEJ
 e9wT034HPjAQ+ROGC1qw3oHHkbTH/wB7Mr0HFsZSBQVKcMwjqNZX39B0tjp5KAbxVX4q
 oOsPjqoYerizBlTXhM0JvvgqNjsbz0tcQao2wP97mmwj3Ce/cqbvoxrUtbnkFmJ8ou+J
 hcxQEpVlSAGSNqwkcebIOi+wWypLcpfZJ1LkgdvJlQR777g7PS/4ihdjgF9Gwl/zPD7m
 +3Dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqtlb/Na4TssodS1WAHPUCFzKomgy8YADAhyN9BauSbXDQHcN79hGxHM4jpjnK4eyVovPc4jMVjz26@nongnu.org
X-Gm-Message-State: AFq9FYKyjfcg6MvXQaBA5pToiPwVHpTKMMM1768LPo1UbmTTLXGwlpN3
 nQpD/c9nrPvDucUln13IPVupyaEw+/luyZer/mp10qSuFR9rKOFjUwzeiD50zXt3XheocQGS5qY
 /jkQT1ww=
X-Gm-Gg: AYBFou12uo0QOW6FplizLQD3DmRcKfDVUUk41mMqj5XTQ38w8jWyF71iVUBXYNzkYG8
 grRxD1vOS/qjHh7w8XW/g3fWLtZk5Z75KRJl2paNLrNbyTDUcOL52CBAx9L0I9bQqiIFTuWz6Ge
 VTEOkpgvCK5ZBAZ3DXt6goGVZrHjLlkMBvLsu6eGFQAcW2dMWlsBQClkvjMgH0i8SGXJby7M1Zh
 bOLq2dAHxnK483jesnCtIMnwR774T4EWNLN4euXusoRElnMLkqF2eoGSzOR7G7A2kquq1oRN+Z9
 dnRDhN8BMolkWhFlc/XUA2wvyCy9qmgmh049JyaU+VvMSLRPz7Y9+9iWJITZNgyPHQhGW1Qepi5
 BjZ6CVFxArEIKVxw6IEz6/OJV6l1NU1bTJYu+9mS388Ndj/rMHZJqiWr1AkoiTsyV/8sTWmy8dL
 0lm596xGY7waWXjURY/4MR2HDh6SjgfY/VjbxFoLrt2Q9TDTNOCUYOqYnTWP9I+eDQM+bk/56mu
 djMb1SYEbV2gdUeZSiLzpQusqfa+yxf6zH4u908K+mYczakE2qXOlgBg40AxMfW4PYA8nTO5SuZ
 Sondn2S7JQrKjg==
X-Received: by 2002:a05:600c:4e87:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4a35acafe0dmr18868115e9.6.1792824047269; 
 Fri, 23 Oct 2026 23:40:47 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm2600144f8f.24.2026.10.23.23.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 23:40:46 -0700 (PDT)
Message-ID: <1720ce05-f58e-4795-a2f5-3212b017784d@linaro.org>
Date: Sat, 24 Oct 2026 08:40:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/43] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/23/26 03:49, Brian Cain wrote:
> The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:
> 
>    Merge tag 'pull-request-2026-10-22' ofhttps://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261022
> 
> for you to fetch changes up to c8798f02fd9800b9a439b3175b0c94be09cf52cf:
> 
>    target/hexagon: fix semihosting ACCESS filename handling (2026-10-22 18:49:07 -0700)
> 
> ----------------------------------------------------------------
> hexagon: v85, DSP machines, singlestep, bugfixes
> 
> - v85 scalar: atomics, CFI/_rb, vector stack
> - new DSP machines: SM8975 NSP, SA8797P NSP0, SC8480XP NSP0, SA8775P CDSP0,
> QCS6490 CDSP.
> - bugfixes:
>      - coverity, ubsan findings in semihosting, decoder
>      - handling framekey w/dealloc_return
> - handle singlestep exception
> - performance improvements: TLB flush, l2vic
> - test coverage
> - MTTCG fixes: enabling MTTCG exposed races in lock/interrupts and ciad.

This fails one of the hexagon tests:

https://gitlab.com/qemu-project/qemu/-/jobs/17413671779#L1159
https://gitlab.com/qemu-project/qemu/-/jobs/17412765117#L1159


r~

