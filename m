Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E630AC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTjt-0006xU-CF; Tue, 23 Jan 2024 22:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTji-0006wx-11
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:15:43 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTjg-0002GQ-HH
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:15:33 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5989d8decbfso3180178eaf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706066131; x=1706670931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqcTvlpmG7dWwkKw7k3CO3XJckv4A5WAvyWvtj1mXLA=;
 b=oJiFNaXeq8EutdAPz1uZjrBbTVx/iQMWmel8s6F+EIDndYcTFw+sXv1Lg7ILgzVeGI
 ZEPjWsqCKc/C03eScKnY+Drie3eD9hlBcbvfE2hhmyooe2WSJQqPuEtopNDqbBF5Na8v
 0WAZ66TrZ5F6DYKmGMYhO3O5PtGguoJfixSVTchD4hW1qYROmh07cRIfH+lxj1hvxK+e
 eGLNPFwZh/7f1mIeMXzh6It7X/R1CCEAeZo22TBOcIpZOui1WtLAkSN5LBCTq7OZUGDM
 sGw88OzqrapfD6bjg5OB1mqN5Q9Laq0i/vQrapsTa5YOVut+wMuP5T9XUBtBm7V6WCzO
 o04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706066131; x=1706670931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqcTvlpmG7dWwkKw7k3CO3XJckv4A5WAvyWvtj1mXLA=;
 b=UC3ecnQtMOR1oA8Hy8KrQDiM7OXrcWyIcI+7c0HS9dry/O/XHkJYD6giNn3t2ylRV9
 A0Bdgg+JuP3sHgSe445z19kplAM/G5XrP8tTTNaayWwgrkxCfpJMPz+1u4RJHsUhxWs3
 EjvAIjF4vPw8pKPmWkuMKYV+up6zTtUB/w7TsBF9HQAbAOk7vZfhBGhUmlLth3bzuhqq
 FeEvmD18DFX2QaU12hgLihPlrcv8lpt/Y6yscE4Ai3xSTX33WAc/zqiD/tqj0NJwhkUZ
 Zj+FvQdf/ClOt7jhae+YUog0e62ckvyHeyhYnbE3CPbr2Cig8TsbF4s34PKEILM1ufCp
 gqKQ==
X-Gm-Message-State: AOJu0YyQEvSglV2Er3MgADsEIZUci3vxgApEwmpWZqlfBcSd0SOTHYM4
 nrBomVhF8F88RD0l84JQNLvIB0JybIZdkXAqJnwuBqCV2R+3g9GG+A0skjZc+zE=
X-Google-Smtp-Source: AGHT+IGof/G21Y4YsLakWnsYPtyUB5JZNn0Rzx4fKDIcMkFY/5ZfoC48o/ERGkzZPPYMdWjebKBNtA==
X-Received: by 2002:a05:6358:3413:b0:175:c187:c1f with SMTP id
 h19-20020a056358341300b00175c1870c1fmr5798954rwd.45.1706066131142; 
 Tue, 23 Jan 2024 19:15:31 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 lc14-20020a056a004f4e00b006db00cb78a8sm12927500pfb.179.2024.01.23.19.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:15:30 -0800 (PST)
Message-ID: <78e1271b-7218-4564-81cf-d079e73414f9@linaro.org>
Date: Wed, 24 Jan 2024 13:15:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 31/34] accel/tcg: Make tcg-runtime-gvec.c target
 independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-32-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-32-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Only depends on cpu.h.

s/Only/Doesn't/ ?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

