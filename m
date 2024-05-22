Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483DFC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uqi-00016V-1q; Wed, 22 May 2024 18:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9uqa-00015c-HL
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:54:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9uqY-0000ns-Du
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:54:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so120049665ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716418449; x=1717023249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=boHNVoYjZiVALj0BdZzuvEpmzb6F+mybkq4QTpmHcFQ=;
 b=sTi/P3grMNI8Wcp769EgfA9THaoaf7Qzqe+GgXZlxQLuHHPXW/5PymlKmLfFTdN8Rk
 ZZYdeFimWeMDeKGnbEsKGbF5juqTBCkLUCswYO0T3q4+iwtWz9ztQDphGUHplauztr4F
 NtVtxFG1LSWNKxX4+B+4F/9EkRrS+16WVe+OSkoJBZ3/mMAJDv3oUbbgHDkSS97g23lZ
 Tu470WznX7gXIhoLJCkgOTW2wqRSr1yX4W2pz5TfdfboRXX9u/X0Gqvz9UtDxIgq+YR7
 /TTOVFJULZN4Ffolc5eV/MEVit2A4Wct2jo4xGkryAyRZ6bcDmzcbH0QnBJlMyQzCeBS
 oe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716418449; x=1717023249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=boHNVoYjZiVALj0BdZzuvEpmzb6F+mybkq4QTpmHcFQ=;
 b=ls9jd1uIFOILzdcXFBCrC6KrWNoXvwTVFo3PCbFygzGB/FJTGRuST23Dv0D9I2edRr
 L2IQvT8cVeFWug5ase12WjP8qnzeom+fwWN1qpFqBLeYa0VlS4X/9gDvOnSibyiHVSlr
 ZD8j64aZRPVygJbpIRiYY9tBenBIyKL7bm/9drnew+QscTDZ0szShxsBInzYHInfne2U
 NPMZ30p+ZGvDKXZ+sM7nDKWDcXIwil5wjCFv8GSjzPk2MCsGBPJ/7pnu8rF9vNSZGOUQ
 6AtGoH5yYz4oQDawtAzWHQEP4LxP0yvA5oj7d7xuMa/tTPSlYORJvcMB5mPig+Xl0YeK
 reMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTOIAwSSaE6qugp0scKu6j9AvYREL3+RJqZ1I2BKEgomhXLChWYzgiC3XSTTgZ5mh7EH+lBxA/vXZ0nsI654Z8g+Eo7r0=
X-Gm-Message-State: AOJu0YwwwTWL5jW8dubJypwt+5WNI129haPlGFVaPZ0q0kV4LLUNBqKc
 2C3QT7nqUfrzIgi7SFQBoM4MHCnWNbwpaEpSyMyiHtkrmE3yJ2APgO9IB6UjDtU=
X-Google-Smtp-Source: AGHT+IEocV1rh6RBRIo/SyjD1CPs6V0TqcCmNhpXNfuWjJtwVoCHaMWmehCqDJUbPB7/LWItT6lmmw==
X-Received: by 2002:a17:903:40ca:b0:1f2:f50d:b4e0 with SMTP id
 d9443c01a7336-1f31c97e8a8mr40472375ad.25.1716418448862; 
 Wed, 22 May 2024 15:54:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f31eab519asm18735445ad.272.2024.05.22.15.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 15:54:08 -0700 (PDT)
Message-ID: <84a38790-0cf5-4854-b8fa-c525023d3b05@linaro.org>
Date: Wed, 22 May 2024 15:54:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/s390x: Raise exception from helper_per_branch
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, david@redhat.com, thuth@redhat.com
References: <20240502054417.234340-1-richard.henderson@linaro.org>
 <20240502054417.234340-10-richard.henderson@linaro.org>
 <b1d64ce0bce9241f62a3db44b92b74d47c833979.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b1d64ce0bce9241f62a3db44b92b74d47c833979.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 5/22/24 15:45, Ilya Leoshkevich wrote:
> On Wed, 2024-05-01 at 22:44 -0700, Richard Henderson wrote:
>> Drop from argument, since gbea has always been updated with
>> this address.  Add ilen argument for setting int_pgm_ilen.
>> Use update_cc_op before calling per_branch.
>>
>> By raising the exception here, we need not call
>> per_check_exception later, which means we can clean up the
>> normal non-exception branch path.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/s390x/helper.h          |  2 +-
>>   target/s390x/tcg/misc_helper.c | 15 +++++++----
>>   target/s390x/tcg/translate.c   | 48 ++++++++++++--------------------
>> --
>>   3 files changed, 27 insertions(+), 38 deletions(-)
> 
> [...]
> 
>>   static bool use_goto_tb(DisasContext *s, uint64_t dest)
>>   {
>> -    if (unlikely(s->base.tb->flags & FLAG_MASK_PER_BRANCH)) {
>> -        return false;
>> -    }
> 
> Why was this required in the first place and why can we remove it now?
> 

This was required because of the structure of the code: the PER exception was only raised 
from translate_one, and therefore we could not allow the TB to end beforehand with goto_tb.

We can eliminate this now because we're raising the PER branch exception before attempting 
goto_tb.


r~

