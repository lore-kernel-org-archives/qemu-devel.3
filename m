Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4FDC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVvt-0003op-98; Fri, 24 May 2024 10:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVvr-0003no-Pf
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:30:07 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVvp-0002oc-3R
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:30:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2bf57909b4fso924571a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716561002; x=1717165802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DucGVR+ydMxVth2cHN+YZ3JcGCRj8Olyw5LqtZJXpxc=;
 b=mjcfna1JufVdH/uNIZ7Jt1Wz853s73xyzvbQkEqVvv3jQtDLxhSHoMtK3N6duqb//G
 hG1iAEsCgYjUW9/pA4kSNWccmVhp/FIo/ulN/7U3U+Wk0oaOTFkw1bLFqIxuDyAjURmm
 ZMHOuhVGdgyuJNOT3db+TK6xzU9KZH5rt+vqoVUQOgHYyIbrqGhCIvThDKUQGKWaxJNG
 GXyumm2Ok+bcpwIpFj7QFaq9OyaDbBm8oR2KWs9zNhPlF1gsp0hk02iYooiD0NUfm/d6
 /zrlEK9UB8FYBq4myWiTveudUAxiwSkOWYBQjiQ6zXfE5bMyusf48zarwyaX2SGzX3o3
 bcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561002; x=1717165802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DucGVR+ydMxVth2cHN+YZ3JcGCRj8Olyw5LqtZJXpxc=;
 b=DKu8jfoFg7l5/pC9OWs956iO3aQOqmpQOJ6OpuiModOsSJs6SWVNb81T20iixE8PNF
 cCta9xBESwn3ouc/1EeAazRr/rfZcfZG0+VFk2GneTrmsdS/rc/oyZhyGiZlHLeAGyYA
 XcbYPzTmZAx+2a1wJUcB54jB0m7bX0QMD0WJcGcP8ToArbJ1H/YmjqEkcmgKrZOuO0LG
 t9SToTGPcexrzOuKSWS1A8bED0kHuWMvkaCCCR2tO7ypBSzKIpU7DIBPT1uU1l45ubSv
 D+6TdFwd58NuhIpBBmObafkIOcjqwOASvrBBtMGrCrR+O2YGWkP3bcUJoyoWd2t7QFBq
 DvjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2BLF1TTBz4SRjxQv/cGTKRapbGBrmsR/WrCFXTHRhiZtlradTkhtABHaOlbw3C1fSD2OaNrxfAMLkTaM5X4unvgxRSQs=
X-Gm-Message-State: AOJu0YzuSEZnGL8r89JtOvvy7x+oH7T78iIBoS/AoVSRv+EwXv5khSqe
 oWoWk43d3As28IvrVbeWzLUGcjk87wzdBmX5JSm1WqvudYgNfzYU+l81KPEYOqn0DeEdov153fa
 H
X-Google-Smtp-Source: AGHT+IH6+6dl7PlPjPm4EIEgQt3Aoon0Doc342oFvyiNe0wLuV58ifLMcHk3fjCPdSrWUrj7Fhy5DA==
X-Received: by 2002:a17:90b:1196:b0:2b2:7e94:c5e0 with SMTP id
 98e67ed59e1d1-2bf5eb32de6mr2384263a91.20.1716561002473; 
 Fri, 24 May 2024 07:30:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f310044sm1431446a91.9.2024.05.24.07.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:30:02 -0700 (PDT)
Message-ID: <9a3f718b-9501-4718-ab4c-bb7731b5aa0f@linaro.org>
Date: Fri, 24 May 2024 07:30:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] target/i386: assert that gen_update_eip_cur and
 gen_update_eip_next are the same in tb_stop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> This is an invariant, since these cases of tb_stop() should only
> be reached through the "instruction decoding completed" path of
> i386_tr_translate_insn().
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

