Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7DECD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 19:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snNjm-0002a4-49; Sun, 08 Sep 2024 15:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snNjg-0002Yg-QR
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:38:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snNjf-0007h2-BZ
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:38:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2055136b612so42669935ad.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725824289; x=1726429089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M1n8dj+t9pgRCSVKBnaQZo+riYep/RnSC2s/jjAl1TA=;
 b=rl72ERKEWpKmjCWMSgJ7eEfv6oclFZT6TvJCQeSDZqu/8+KJHqfCQELAXe7cLXUYIN
 1bwFd4/Or3Z68ZeSdmO+xem2qWAJootQMB0Pc5EY9OH9mEfzk2Oe55kiWHXV3rKgeVlx
 bC4NyUzY6D0w6PDPS9tIIsS3BTS/NrTc1Vh6TlVobP1Rhmm1vtoPnhRXdvkmwtyZXu2a
 RuvNLrya2ZsqhDRe2rBZNfFDE+lZFPrh6Z5u4F+VIaA2+xW4Yxb/IUCG0rsJOScuOWfo
 ZFtwMGHvv7ksphRTr4uKVXmr0P8WpAVpUdHb138AEqpRlrWu9uZauwtdeAewshsqi58a
 Ah0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725824289; x=1726429089;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1n8dj+t9pgRCSVKBnaQZo+riYep/RnSC2s/jjAl1TA=;
 b=gKj1QhtvCk/3ZnuvHdn4CcUkdyXFtBQa1xNqiC71YBZX8ASbSdhamyxD4bDDt+8X59
 ltAPzFfSTwijQtmAAH/eKnZWLMjE1leP0K6IMcxvg3wbUhY6pjOpMoe3ikGLRs/bXpmC
 u6T5XBfTYL1jU9y5iNEkOWMpjYbmcctIGDqu8QhNc0oRfdXsu3ix0O/2IEi0TPEWFkDE
 CwhrZZUGLFJ2+UOnJMrq/ar3xO8+W6omACq3PeL6bznd7LSKidDTQPNyQWtrLH7gjJRN
 4AHD7TsTphyb99zlMKpIkqpZltV6SoJWjoMgtqbplNVkkdDbYIshf7bEE0TTkldpE48N
 Yz5g==
X-Gm-Message-State: AOJu0Yz73jbwp9rhiyJb7YdvnuskORm8VAnZDw14+ZPbHl/Pkd6kMoEf
 +fpVgZdYS3WAap+9DGNwnzsu9qycX0LyGMt8nqteN8nefnpU5J8LaMDgO1lsDU0PBjl/g+ZzZmL
 F
X-Google-Smtp-Source: AGHT+IFalAQE5pAEGOhpxa+nLf7yYc4RiBFI27ztzZWiK02honWM62BPQh8RGQnuGJJikPuqiAmIQw==
X-Received: by 2002:a17:902:f541:b0:206:b618:1da8 with SMTP id
 d9443c01a7336-206f04f9d2dmr116203395ad.17.1725824289227; 
 Sun, 08 Sep 2024 12:38:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e0edbasm22695435ad.41.2024.09.08.12.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 12:38:08 -0700 (PDT)
Message-ID: <1fb12edd-df4d-47a9-82f7-0ae58be292e1@linaro.org>
Date: Sun, 8 Sep 2024 12:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] target/s390x: pc-relative translation
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20240605215739.4758-1-richard.henderson@linaro.org>
 <06705a65-a478-4a55-9da5-17adde12a26c@linaro.org>
Content-Language: en-US
In-Reply-To: <06705a65-a478-4a55-9da5-17adde12a26c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Ping.

On 7/4/24 15:26, Richard Henderson wrote:
> Ping.  It rebases onto master just fine.
> 
> r~
> 
> On 6/5/24 14:57, Richard Henderson wrote:
>> v1: 20220906101747.344559-1-richard.henderson@linaro.org
>>
>> A lot has changed in the 20 months since, including generic
>> cleanups and splitting out the PER fixes.
>>
>>
>> r~
>>
>>
>> Richard Henderson (10):
>>    target/s390x: Change help_goto_direct to work on displacements
>>    target/s390x: Introduce gen_psw_addr_disp
>>    target/s390x: Remove pc argument to pc_to_link_into
>>    target/s390x: Use gen_psw_addr_disp in pc_to_link_info
>>    target/s390x: Use gen_psw_addr_disp in save_link_info
>>    target/s390x: Use deposit in save_link_info
>>    target/s390x: Use gen_psw_addr_disp in op_sam
>>    target/s390x: Use ilen instead in branches
>>    target/s390x: Assert masking of psw.addr in cpu_get_tb_cpu_state
>>    target/s390x: Enable CF_PCREL
>>
>>   target/s390x/cpu.c           |  23 +++++
>>   target/s390x/tcg/translate.c | 190 +++++++++++++++++++++--------------
>>   2 files changed, 138 insertions(+), 75 deletions(-)
>>


