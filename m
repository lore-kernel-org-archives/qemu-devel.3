Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B573CC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlt8-0001IL-F9; Tue, 30 Jan 2024 06:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUlt7-0001Ho-AJ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:02:45 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUlt5-0007sf-RX
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:02:45 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6dddf4fc85dso1943576b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706612561; x=1707217361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnGok8mwjmNhzt2HXuIz+Lqj2e2ygpdpzHuBcAMHThk=;
 b=XOJNTqF9HB92yPss890wsdQpN3wviaHUa3bidX5sC7FYoPuMqiX1Eu1GbcwSQznYVt
 XToWvdE8CnD9ss3B0k1mz2+tb9TsPZzxkcfsKmXxeGYgB9eifCf55ZuTzq4899072m3f
 CLa6f/Ekol3yirWOnROrfGKboIn4o5xtY5tuXsKF1J3nMK/WzA2NIc56S10YAoaeHfu+
 mhAHE44a7MouEENtBh6izg2NNRXAXxzMA+7ah6UR2eNvEhaJWBQKyCchob07Ai4B3iHT
 xw4t4eB0YZPwomxkchMcgnTwYu+2KGLBfzH9fZJnl035JqK+eyo0d8WUASv+QulOB6nr
 zOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706612561; x=1707217361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnGok8mwjmNhzt2HXuIz+Lqj2e2ygpdpzHuBcAMHThk=;
 b=wUIUn6P+dVHCzQCTaGPc9OHY+ZjP4LcSY06rokcKuxm8SONIY2ueRNUdV2QWHroH39
 MvEZv4PN6uv74G0e/X2UjWwpEdO5wZJ0l0fXC7Nk/USelgtzBYtl8aGQxbvVimAIJvRi
 I5V5ZD/bec5+MBkEd9aDC/cXqX8rFxGZlUzEQmYMPLtO6FBCb5IzqxBISCXo8T0ghC+F
 D1hto5U/hrw3hK3t6lc+YwubBFRKLS02bO97jpHB/0abS4KFvGqBtrUgLJFSy40sfBXP
 3iF9r4XOpgrYcQBibEavOdsqMAqq9FGdyVpa9qm/HL2N9DDAr5BSubPHIMzD941yGAx2
 QjOQ==
X-Gm-Message-State: AOJu0YzAAxH1d7Mjm9dMFNmgk40o4Rj3JQd1/gIKtGMYZWpOHvyjZk3E
 tdio0aunly+cYNiLS46Qu0AAAN8ATkQFyJHGuvAjyriP5+0WYPA4Bbpfkuk06kCD9ZRBj1F7Lcx
 ivCY=
X-Google-Smtp-Source: AGHT+IHUc03hnKApXKhZLY7Eg4P5aWX+0jnD6oi2yGlBIt8vGf0CwphGxy/s+fmAxUuRgs2Jj8YBog==
X-Received: by 2002:a05:6a00:179f:b0:6d9:8ccb:be1b with SMTP id
 s31-20020a056a00179f00b006d98ccbbe1bmr5736071pfg.29.1706612561270; 
 Tue, 30 Jan 2024 03:02:41 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a62e807000000b006ddcfbe736esm7678047pfi.97.2024.01.30.03.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:02:40 -0800 (PST)
Message-ID: <a720b9a1-8e2e-4e2f-a673-d5e342e3b284@linaro.org>
Date: Tue, 30 Jan 2024 21:02:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] include/hw/core: Add mmu_index to CPUClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-2-richard.henderson@linaro.org>
 <238c5053-47d2-42c2-a012-5a88f318e290@linaro.org>
 <ab8d0b2c-4ee0-43ff-98a1-afaf02320dae@linaro.org>
 <7b142c6e-07c4-4f57-bc47-b8490b2810d1@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7b142c6e-07c4-4f57-bc47-b8490b2810d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/30/24 18:20, Philippe Mathieu-Daudé wrote:
>>> Can the index ever be negative?
>>
>> No.
> 
> Then why not return an unsigned type?

The existing function didn't, and I didn't think about it.
Does it really matter?


r~

