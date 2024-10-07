Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D06CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpN4-0004YE-3N; Mon, 07 Oct 2024 11:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxpMz-0004Xo-UB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:09:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxpMy-0006sQ-BQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:09:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso53933625ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728313794; x=1728918594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gOBKURaWUiuzlL+nYXas2lJAM0frrqi8K0jTg2Cs8ME=;
 b=TZe/1oD47tb0E4G+H59JYGNIpFTWiNptRMcLn/jXrP9JkYUdana35L6bqLgRzM6iyz
 5yzQGNLOmWlrwPKvmyq7r1GGO0nkuxgE6DFsPniOs4S/o6sRxGmJYckOqsxJYX85MQYj
 5P5RM5uYd0Ybiq4MIItcuVhOnsKawyAKl6LBl3aLYuTI6X1p2wicrBVFQf3Ffth2h+OW
 DVsd4e0bWAaravILgFo9/YMz+p45SUuoNvtJMPzVULuLqvHayI68RrRJEeRPoOuceqfA
 z/wj07UwJA1Sy6FzSJjzxoy+3jN1VXXYYO1EKtslm/uNKlr4Y15nLU97/Ry5B24czFEH
 cWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728313794; x=1728918594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gOBKURaWUiuzlL+nYXas2lJAM0frrqi8K0jTg2Cs8ME=;
 b=w3sXyvvY026iSsvuXcCNdHyvQMpZGUuXDgnAuBcTxqVtMB5qTgE4Es0MslCfLb/gyg
 naFsSLJo9TM5EEamJOIaA99VxwxggtHqpOzbjwl/nL+zr4uX3/ooykiIVvBD8edczA3l
 BZhA3h6tHc+h/cLxc+W0h1T4QjeulztQdsbK3TgG5eetBviXVm1KTZ0cF7LAYEuXfpSw
 p00kIm/zlIh/LsaGKqxcUrFV9NucAV+rXCQn0IFiqal/5yqiRPy2GuxC6IdCXc41RqmH
 dc3bkaisqrjwBg/XCkcVfNyuyYQ+dpFvlYwKpcZOsTQt8Luzxz2bxcUNTi2lpBr6nzOI
 EpBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAGwBqliYLIt7+mv9m6DzhiXUSfhz33/Dq0bl28+WiaqqR+HX+OBXglgVzqi0CBNe4bgKrpnhKooVg@nongnu.org
X-Gm-Message-State: AOJu0YybzyqSxJ104CGnNhhvZpGzTx8Y5kfh3rm80jPJWO4rDMnDcS/E
 XSBWCk5AOyeTTT9FuT/YY03yU+gFL6fCi9MNC4TUO2wTbHmg9kS343p/4tejstfvw4lbJ+jiRW/
 a
X-Google-Smtp-Source: AGHT+IGupBfduKVrKL6Ft3Q56nOhd8cdr2w+V+JHPsBTVDWRxh5ITVyh9FMmiLci+FMqkpbz39XNuA==
X-Received: by 2002:a17:902:e848:b0:205:4e15:54ce with SMTP id
 d9443c01a7336-20bfdfc0564mr212802245ad.20.1728313794495; 
 Mon, 07 Oct 2024 08:09:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13930facsm40694175ad.129.2024.10.07.08.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 08:09:54 -0700 (PDT)
Message-ID: <9228f7d2-851f-48e6-b864-65cfbe04a069@linaro.org>
Date: Mon, 7 Oct 2024 08:09:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Support 4K page size
To: Michael Tokarev <mjt@tls.msk.ru>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, maobibo@loongson.cn
References: <20231023024059.3858349-1-gaosong@loongson.cn>
 <d8901ddc-b7b9-46c2-be35-40950a651b21@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d8901ddc-b7b9-46c2-be35-40950a651b21@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 10/7/24 07:48, Michael Tokarev wrote:
> 23.10.2023 05:40, Song Gao wrote:
>> The LoongArch kernel supports 4K page size.
>> Change TARGET_PAGE_BITS to 12.
> 
> This change appears to have 2 issues.
> 
> First, the subject is misleading, - it does not only introduces support for 4K page
> size, it actually *switches* to 4K page size.  But this is sort of minor.
> 
> More interestingly is that it has quite noticeable effect on performance.  For
> example, https://gitlab.com/qemu-project/qemu/-/issues/2491 - I confirm 7z
> decompression performance drop from ~110Mb/s before this change to ~73Mb/s
> after it.
> 
> Is such a performance drop expected?

The #2491 issue appears to be for user-mode emulation.  Because the reported host is x86, 
I would expect guest page size == host page size to improve performance, not degrade it.

If this were system mode emulation, quite possibly.  If the guest loongarch kernel is 
still using 16k pages, then all pages that are given to softmmu are "large pages", which 
perform poorly.  I hope to address this at some point.

If this is really about user-mode, then perf may be your friend in determining where the 
extra overhead is coming from.


r~

