Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64869C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 05:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbCwO-0004n7-HO; Sat, 17 Feb 2024 00:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbCwM-0004mv-1n
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 00:08:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbCwI-0002SO-Jp
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 00:08:40 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so26014085ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 21:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708146517; x=1708751317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaOIR5OYyt3a0p19SvBMAf7obcyhL6FclWrV3uYSjYk=;
 b=JnUl2mGNaVJV9NOxnG1YCQKLFQ7ya2ggPHEoY8bFEeRx0Dp/jp6XYQN1HjvAuMuppg
 MgqsMdlhosCEMIkG+czbmNi5WNR0T29r8/mVWvSV49t9qzaeNR4BH+6kjHl+ab3x/FL/
 +dJcbLzRKPX4V0fsVzeULb7LSQAtFgryejen+fKjdg05u03Lyh8LCJGd1++HpF6sn4z8
 vM8Nq0+Z2KQg5wpnPMtMiamYis+ZEmAdjFCpgprBVWglKt+uHfiMSyML43erI0sKZtv4
 NOt/6zg3V5IZYinJ5EdhJjU/kIdY4kTWQ3v0g3Cd9SB9D6ar3eM4igR9aY3UjUHXMaN7
 FJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708146517; x=1708751317;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FaOIR5OYyt3a0p19SvBMAf7obcyhL6FclWrV3uYSjYk=;
 b=GbayXX8dFn/lt3wT2e4VI/WTgugynPfzoaMyukDXxGzMEt0rOm8YpGJ6Y+K/YdKXA9
 t0Z38WjjZ5KpQd8P6v4eLcIrNeefNDgZreBWbvr5xbmkFGKIReBR2UwEGIVIG/3mTYGr
 mjr6ddyroestVpNaQjXsfidryHLxwc3ZClDtxT2W/X9nltHrODmRzyx/NwMY4IsD9QnE
 LTm7cl2RF70EjkBEcAtVyWupFk8fqOhc87sHqNzdYTz1nkv0A5HVlRGM0xahNfnE/tkp
 FQkHDQ9upGWHB/jNxSEGN5yqWqkdAx+d1iJI4KGR33elHTsc8qw+XZiI61j2LqbcjFZE
 Z+OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpGGMzdjQfaeNma1dyFB2WEsBmF/7oHRTGvbXU3YttT28Z2tce5ujcluDiqSU0XsNMs2Fj7wj+MdEh/YHO9+nLvBfItMo=
X-Gm-Message-State: AOJu0YwuXKYxuAlJu21uBF3SMcjjl7iFTPzjjkVtyToBNhg/VuQCtV+w
 WN2SHLej1if0g6bxlUtvihdl6hQkr/SbTZ4zW3bEuLPFq5x+0cZhITftAv7u8vg=
X-Google-Smtp-Source: AGHT+IEVCvs1aAlw0x//rZjkB1pBkpe6M9vZlTumEJfNYx3hK+egCg81mPEwoGz9pO5ZqK080lCoIg==
X-Received: by 2002:a17:902:c1cc:b0:1db:ad21:d834 with SMTP id
 c12-20020a170902c1cc00b001dbad21d834mr3410060plc.10.1708146516817; 
 Fri, 16 Feb 2024 21:08:36 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001db579a146csm650269plc.241.2024.02.16.21.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 21:08:36 -0800 (PST)
Message-ID: <5265633a-9d28-44b9-96d7-a310c2a2a304@linaro.org>
Date: Fri, 16 Feb 2024 13:49:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] migration/multifd: Zero page transmission on the
 multifd thread.
Content-Language: en-US
To: Hao Xiang <hao.xiang@bytedance.com>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216224002.1476890-4-hao.xiang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/16/24 12:39, Hao Xiang wrote:
> +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> +{
> +    for (int i = 0; i < p->zero_num; i++) {
> +        void *page = p->host + p->zero[i];
> +        if (!buffer_is_zero(page, p->page_size)) {
> +            memset(page, 0, p->page_size);
> +        }
> +    }
> +}

You should not check the buffer is zero here, you should just zero it.


r~

