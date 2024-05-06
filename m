Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C075C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40ws-0003Kf-Qx; Mon, 06 May 2024 12:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s40wr-0003KK-3i
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:12:17 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s40wp-0000gw-JC
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:12:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b33d011e5dso1347971a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715011934; x=1715616734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3+A0kguw22tuTfmDByFeajzwuJ7hiojOOboaRip+0Mw=;
 b=GW7qFLGbsdHxqFuBzW0WZZ8yIjtLWhar3XW1xS6k6dK6qfKc7ufGtZxLgilmPxU7fu
 3v/6RWei0GbE1oXlf1tR6/pLHy7OKMO2551+7PYk0k6KHsuPQnQO6s7eFu5w2BeVrXY5
 dxRVTFPzWSJ/KvDQBxU8mElz6BmBImTDLNA0emCz5tObQXwhnkfovt1xvamHKYf+9PSL
 fgvbY4MS28hD00K/3puoZLY3GXQGnA6HWOTH3IQyO9x9LzBz4uDn6KpSjda5iFue6gFu
 fiiMFSdda6lubfoRGbyp18pZKtirxp/3cFLZe8JQXtFySvj70XON6FtWhR1FRjuSafdL
 7tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715011934; x=1715616734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+A0kguw22tuTfmDByFeajzwuJ7hiojOOboaRip+0Mw=;
 b=u+7dpNhM4IHeW8plsm4ict/lut3wZGPn1W8dtpcV082wBesOrErcGfU5Wl+2oXYuf8
 1W1WSVllWcQ7whcW/Unpvr89uIYbMQrP8r0V/ed0YsuNhdvI2XUP/fbjKwe71UUj4dtJ
 uumHpCrJlFWweN2fSZhZ1M/PJuZ+f5nSlhs/3CyEn93IQD9Sipj4hGBIxbZc0lzMaAlo
 NtPIOKfTOyYr0YmadYEi69kMEQd966myNg9ve8KPOoMq0bDPI8SpsGI79JokRWiysJvN
 8FNRwDfaNd4+MhlzhyK6I8rQioS/NPOpAUcncceWEMK+aC+bByR5mUE8VAdWvagYE9kK
 aruw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMHgMdMBEyQUt4q21wiMf/r8SjpJzKldkHXxR64mLJojsDqFEsZ3RFQWiJOZCmlkDfXBr/gnglAcP/kTlY0l8fa2XvzrQ=
X-Gm-Message-State: AOJu0Yxnd4d6rJYm6zExlIRxFIicDio4MH5bFUXlCNLkQqgqYE3IPaAT
 czDUn0CVy8C1/ZHlhvX0bGpUVn/nlqkgyie6Pm4PPo+MAOymuww5LTsZ4ITnKOs=
X-Google-Smtp-Source: AGHT+IGtcE4OmgSBqisPpcsDsGs/D9mT3VIl0+nwQ+zA3vHKnR/grYpbvAomcEbQFfEyNKNOi9/HJg==
X-Received: by 2002:a17:90b:304:b0:2ad:f3c3:540d with SMTP id
 ay4-20020a17090b030400b002adf3c3540dmr161787pjb.21.1715011933906; 
 Mon, 06 May 2024 09:12:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 lw5-20020a17090b180500b002a6e67e197dsm8271901pjb.45.2024.05.06.09.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:12:13 -0700 (PDT)
Message-ID: <9f32a939-f356-483f-80c1-7f7f1aa6b436@linaro.org>
Date: Mon, 6 May 2024 09:12:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] target/i386: pull cc_op update to callers of
 gen_jmp_rel{,_csize}
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> gen_update_cc_op must be called before control flow splits.  Doing it
> in gen_jmp_rel{,_csize} may hide bugs, instead assert that cc_op is
> clean---even if that means a few more calls to gen_update_cc_op().
> 
> With this new invariant, setting cc_op to CC_OP_DYNAMIC is unnecessary
> since the caller should have done it.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

