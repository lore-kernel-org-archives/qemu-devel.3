Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A2AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 15:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMUsy-0006Fk-NP; Wed, 26 Jun 2024 11:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMUsw-0006FH-HO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:48:38 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMUsu-0000NR-3B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:48:38 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-718354c17e4so3503013a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719416914; x=1720021714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l5HzS4P0yJOklkggIzz0NwmSHKTeApv9+YDI8pdunFo=;
 b=mq7GNI7cDYBU0CBP+x38qwKhVdcao3ap85g+djQ7xsI89jd+Vs9WtTi5G+lNEcbY+0
 6dqTwi1zUk9mPBFWRIhtsM9shmoXTnHF0ontMzFWs9XDeKVXB5CVTZSu6d3fZGhFZfba
 yIFF0cqcWWkuJMw7Qg2Z6lXn4DXpJ9jes5CEG9wUm/erRQHXZXMN0Vj29mGrmxLFTUtP
 9V3AYuZKG03FipcOF8vSt9m8tquIt3Ie3GxRLpeigmQ5/tT4XrVdJZxpjnBRGmYoGq9k
 +baTqPB89R5LIV3FKFaJvdVagWAhtbge3JY/wuFFEv2cctbtpjX4W0MNP5exjB5gFVqe
 4MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719416914; x=1720021714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l5HzS4P0yJOklkggIzz0NwmSHKTeApv9+YDI8pdunFo=;
 b=PA2DRrUSuzB68iMh3fIW4sjnep5ChBd6TY5YNXyIjLA3pJlzsc9ku9HFTIU0Adp8J0
 Jj+j1iO/ZLHR5FoQ2VgIUwMWnEKkQvr6yq0xhqb3bpvZOfZTA+MOw3BPI/qibGK7c7ZG
 dOovAOSQXexQkDNSINpv0tuu+99gcoqA2FcDryTp2g/5xWaaIsiYGo48kwqal5LvuDaG
 NdhgRNx2MyXoDtr51wS62FUN1EU5nE7VBYJQVHNtNcbg6oe2nY5MdDWR2WApwKEdHkpH
 YupYIddlmsrIBs0BHJJFiWNxvgnBbMwQ8IYN4464nQe1CM3APJD4ECoV3fJMw6TBqh8A
 4auA==
X-Gm-Message-State: AOJu0YzJz0me0a04pE9gtWROKFM/ydZgSx+3boCdXPO22a5P43ksDjh1
 DoeLDXRC+tQF5Hm2TAkwzwYCL9JHAu7MPbFX0bffEYjG5jSFpWXlGC8hKPeVriA=
X-Google-Smtp-Source: AGHT+IExoWnYHEcCzF0CEGhUDkYgQQhR1wsQ44xcf9xhgKraErmM0CIQar+E6R9qauIXyCUBl6Qvuw==
X-Received: by 2002:a17:90b:a4e:b0:2c8:eedf:65e7 with SMTP id
 98e67ed59e1d1-2c8eedf6ce5mr472043a91.2.1719416913591; 
 Wed, 26 Jun 2024 08:48:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c8d806140csm1831739a91.33.2024.06.26.08.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 08:48:33 -0700 (PDT)
Message-ID: <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
Date: Wed, 26 Jun 2024 08:48:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org> <mvm4j9gp0xd.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvm4j9gp0xd.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/26/24 01:23, Andreas Schwab wrote:
> On Jun 25 2024, Richard Henderson wrote:
> 
>> can always force the use of a non-zero base with -B or -R.
> 
> $ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64
> host mmap_min_addr=0x1000 (fallback)
> qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual address space that is in use (omit the -B option or choose a different value)
> 

Well, sure, but that obviously is where qemu-riscv64 itself is located.
Still not a valid test case.


r~

