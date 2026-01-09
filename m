Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B45D277C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLst-0005zG-5i; Fri, 09 Jan 2026 18:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLsq-0005xP-NS
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:27:08 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLsp-00036P-AE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:27:08 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c227206e6dcso3015180a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768001226; x=1768606026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwTF1MVU47K34mQvUCHpkzgFDbb1WUXLEPKgEvmFe9o=;
 b=en2NpJeWi3+NE86eKWOA6LKIWLKQKW7VuvKTv9z1oaboHRrACkFxOPgnQSPCv5/SFu
 pLiTeB43hpxmTgLJ4tR7FkgT6ltQWjBVqiHJ9E6S6qcJ7fUtKS4o/09t908XSxKz/1w3
 c49K5cJi8UaLxL11l5BRQ3f4QrPIWz5k8lOZ+jjMLx8zoKyxnZSeqG+51x+a/mC0+reS
 Vq6OW4AXsQtPWrqiezu06SotQk34wVJ6prAJSyIONVOxCzyjppb0b3lPviC4yFJHzLeA
 sP9Ogs+Rrsv1+Q4ZsqRApMOEZgXnSwiA9BjEjsWr1Hky0tVWsV9Y0qm2RRgkyU2Tz1Rm
 wjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768001226; x=1768606026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwTF1MVU47K34mQvUCHpkzgFDbb1WUXLEPKgEvmFe9o=;
 b=cpRlUEDV8TrBrzR4vXps7Qqon+FPZhiEWhpFKobq/kGhytxyQkcttH+Ht9BS0g7K9J
 Up7lruo0uqk266uKvi4jbIko6eqpLgRqsrErYYW8x1ChpyXi+xN7OqTpI0IgRi/XgCc2
 y6K6yWJ/qVBIuGi7JNbOED1hrH3+2ay8HFwvyalW1/hY5YwbIFc8/AYbnpOz/qEfwTJL
 PQ2pjZAo3cY2yrk+eBEz/Ge4jXiH9F66Y7TyWin7/K408012PuzOt5i6UokXRMMeKZcZ
 9w0GQLRQYtTDyzVMgYy031zRvqOAPY+7T3rmdGO9JUF2b7kjP84rbid9Ph1MhHbF4ngf
 TyGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWukG6Yc+xeqxhMZmC2fNl+0p6Y1oKPUzWueVtAYkpyeHV3LKXnB3whDWKAS7Zf7YjQEyRLw/2+mhLP@nongnu.org
X-Gm-Message-State: AOJu0YysOKp6vVu20WhVgrWjYXFCQyNFS9S8FaFA72pvML9sO7sxqiRc
 dx4/gLQhGavkkpa3XqNxVYIhlubDgJ1hcPW/06xJxHRTxTvFZ6UWQPE3WU9Sb9+2+6g=
X-Gm-Gg: AY/fxX7sp3sj/ign34ZWivzmjxeTwnbjm5bYtarC83/UWDE2JJU4QyPysTyp+G4gryA
 T1otERCB5GIKAITmDm1p9d7/Jt+ODEA1P32ijMXQU9ITDELfCbmGn/0E7m8qP0sQmCVU0dbezVH
 7fKowE/tk7SD6a6pbh6Xy986fjw0ZkA9Y3jCRqbcVGijqA+uhWGDW+gCnFIrUm6SKG6JsPSThCa
 MQIUOvZPURIfBPVAi4KJnF/Zt9s4Gl55D9hvmEC0uw0L5WUpiXoFXm5smFHn6orLLy8e3sAZNTM
 c3QvlQjexueK+UoW88R9M4RNDQFpVYC1Oph0eeQIsSGVHzYLyD2f4c/ziwmpSu7TAVImmOJhbCB
 z7y2EIX8WjI5mVTbMbeTXGtWmlJmXkW3bFbQVREWdbirBFBMmADi8iLnoXn0b/pWCKS5oDb7uIU
 UDgsF7IgxZXpeKLdCnhkRFzndjSQ==
X-Google-Smtp-Source: AGHT+IFwdeoGmvQ/1inYnANOd8kKIivIyvBrW5ueUyZTi/guz0+rDcYzMHnTyqzNnZd5xWSeuIt/Fw==
X-Received: by 2002:a17:903:2f8a:b0:24b:270e:56c7 with SMTP id
 d9443c01a7336-2a3ee4137cdmr113551775ad.7.1768001225724; 
 Fri, 09 Jan 2026 15:27:05 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3abb0sm116029035ad.11.2026.01.09.15.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:27:05 -0800 (PST)
Message-ID: <4ded8cff-6bae-4938-9678-17fc8f27e528@linaro.org>
Date: Sat, 10 Jan 2026 10:26:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/22] system/memory: Use ldm_p() and stm_p() helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109165058.59144-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 1/10/26 03:50, Philippe Mathieu-Daudé wrote:
> address_space_{ld,st}m_internal() take a MemOp argument
> so can directly use the {ld,st}m_p() helpers.
> 
> Suggested-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

