Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DEFC5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 01:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sil6v-00025Z-PN; Mon, 26 Aug 2024 21:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sil6u-00024S-EG
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:35:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sil6s-00082l-QY
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:35:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-714262f1bb4so3567877b3a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724722501; x=1725327301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LSXcgJ0uRrmsmj2wIzilolj7pL307rd+GiQ7AXQFD7s=;
 b=XnLgSxmwMLW5Tg2XgumScb558ZJYi2j4fyQYeFevEwNOVBViwJtTnjKKBmWwomhmfb
 uCQU7dB9bIxIutdEIO0JkyWSUESBaiN9xCkwoRY1bKzBVWyr9dheC6jSlISJXB8lMH9n
 sRmLk9de+YZr/PfbX5dSJH1TrCcRjcX6IfpchHmqzls/Qp6fFfC/aSDYSPiKD3vxrS7Z
 PsX90xERk88TNgKJ28XiWLZpiRkmB/KEzd2ZottmIIu/3HBfzmhB3MoWCQ5QPcN9kjqf
 nuX9z5mF7At7J1H8Ap434TNKPy9I03PWPMVnMbs6MnqSaOg84ELLgg4I7reyZV3HcCM/
 GJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724722501; x=1725327301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSXcgJ0uRrmsmj2wIzilolj7pL307rd+GiQ7AXQFD7s=;
 b=sHjTlJuhAR0xEDW9lfHexyoA17NNLXeqacxGuXWNDTnIm2C2nxLFsgn8sBYhCCGAc6
 m36hu8EifhbbDQ/ucbdh0+vtCgVPshj4GH50vJKppp/mZhJme0kjr44yu/wIMDzAhIl3
 cjI9HRjiASr+IXOMM45hNGLN0jeb3eK4e8St2miYJ0iL+YDoJpNx7YRqFN4LCbfzRLut
 ir/zRb2zVaCUdw3TIR/beTuccLoPVzVPcmSAOa6rLrLtBy0t2ZSDBggh/Ki2S0Ul0Jwo
 vYWq58M1U9WhMUKPuibVesonllxSuYcVP3iNCQJalbUIwBpPEnF0eSSxXl2dcwWu1t4B
 9e2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyxl27CfommrzJVY/xmbENnU3bBLWLMD3RftJ98VULI3hN0R66IRgCHymX3J+vTHAwC+nEatYKAbHQ@nongnu.org
X-Gm-Message-State: AOJu0Yy3R54Vv0bjSlXG/tnXO6bCdfF0C9YveB2BP4zuOE7m3zACQBgK
 xEHM7HOy5R6ygU8bl5nK8dpqbhlm9ivGDGSb6k9ekWYAy0k9/RaBvchnJYuKKsc=
X-Google-Smtp-Source: AGHT+IF8cC9wPcK88P36Ybwu+7cXjFvU57sEVfWWW7Z59hCC2rbEGJyFGV/UV23mqdrPApBMzuqOIA==
X-Received: by 2002:a05:6a21:3a46:b0:1c6:b0cc:c50f with SMTP id
 adf61e73a8af0-1cc8b49ba5dmr11747576637.25.1724722500680; 
 Mon, 26 Aug 2024 18:35:00 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:2082:f68a:6871:1edc:69fe?
 ([2001:8004:5110:2082:f68a:6871:1edc:69fe])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385609775sm73013115ad.198.2024.08.26.18.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 18:35:00 -0700 (PDT)
Message-ID: <056740af-1b61-426a-940d-3ca118ebd081@linaro.org>
Date: Tue, 27 Aug 2024 11:34:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/17] target/riscv: save and restore elp state on priv
 transitions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-4-debug@rivosinc.com>
 <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
 <Zs0jURx7jbgd64jV@debug.ba.rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zs0jURx7jbgd64jV@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/27/24 10:52, Deepak Gupta wrote:
> senvcfg and menvcfg belong to S and M state and don't actually mean anything
> for qemu-user.

Certainly they do, in that you obviously have arch_prctl calls that adjust them.  The fact 
that you've modeled those so far as separate variables is part of what is confusing.

> However if that's how it is for arm as well (i.e. exposing system
> state for qemu-user), then probably there is precedent.

I think having special paths for qemu-user in target/arch/ is maintenance burden, and 
should be avoided if possible.  The best way to reason with user-only is to treat it just 
like the full machine, and set the fields just like the real bios and kernel would do.

> So while shadow stack and zicbo are similar in terms of enabling. Landing pad
> enable differs.
> You still want me to generalize *envcfg flow?

Hmm.  I'll leave that to riscv maintainers; perhaps a third user is required to show 
generality...


r~

