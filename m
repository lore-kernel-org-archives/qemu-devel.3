Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB656C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 00:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSRMM-000053-Q8; Tue, 23 Jan 2024 19:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRMH-0008Ur-4I
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:43:15 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRMF-0005Js-KG
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:43:12 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so2660057a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 16:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706056990; x=1706661790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3tVzWMbBVIztW+IHBl4ipTT7q5aADt4OAh9GLtfBA0=;
 b=Nx2sfrYrTD+PwVcV5O0X3xCSSE+C6wwCgnB0d2igfDP/vtSzazQjBDbyYt6F8fl4ve
 vt7dfj4a+cUKUhby4uq/6zp66FciZGtV4TWsOYXjCYv4LHhpexyqqJCV6RI6FR28XELO
 +VUs/iswpTPeMjtGZu3daTeGu/cJIlw8ieNG0RY4H+T05WQaXiJoOlcdt01G/spqd9j/
 DlOOuqkiXU/V61xGh71MY34oxwo3tEDdHXTSWJdQ1tvYngmiUbhFNav5HDpO+Ef3+N33
 gFCsiDHup8HqaaK8HhOrRxRo8U78jcIM7SIzlHCuY++viOvSUJlzcjp6xMFs2+DEsvjM
 QGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706056990; x=1706661790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3tVzWMbBVIztW+IHBl4ipTT7q5aADt4OAh9GLtfBA0=;
 b=WUEgpdHU9i7YS9Gbo8ecJC00eeMoLrvnk3+B8VPJ7ZzAYLeS7t6UIOB9lbQG0dB3xQ
 iG1eENJr2vkPZQP4m7dcIPNGAxMwHF66mKpc8Uy8j54NoYL5HCKXDHpZZQmSyRBScZEF
 0Rel3YJDFfMIfnVkRq1feN2p0R9jy5TZ5/3y/ntue5hWpodSPuKT2ZjlJZaJQju8bLlQ
 S06qTEhEvkjb8Ny8AovWr5zpZZWm/kaIsu3o62GEJuwafmyNxtd66wde+6Lb165oFnGj
 NdO3bGKQ4yjdkwZQwU7uEeLOriueGy3HP+QhHdYGUCxE7LuFdNNlG6mD7Xe6s5DAzmX0
 tpXw==
X-Gm-Message-State: AOJu0Yzf9hxhM84mMvK32FChxFlrJ6KcsBrjj9uXuSa38ooP1QGNrO8z
 oL41xemtGQ0yfd5WJcdU26dJyKQksVzm5ljz7uDmO6ladY3Orb+UA+jvxXLyWgg=
X-Google-Smtp-Source: AGHT+IGB9UaBSel4/qw/1ITK+0xS/l2duDpVPvIyVe2w9+ZxcBl4vLYh6jtomKVJVC+SHkzBGxrctg==
X-Received: by 2002:a05:6a20:144d:b0:19c:333b:aa9e with SMTP id
 a13-20020a056a20144d00b0019c333baa9emr51412pzi.77.1706056989752; 
 Tue, 23 Jan 2024 16:43:09 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a170902d11200b001d766749e9bsm2323661plw.156.2024.01.23.16.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 16:43:09 -0800 (PST)
Message-ID: <c79c2c68-8f0d-40ae-95db-b7ccb7bf438e@linaro.org>
Date: Wed, 24 Jan 2024 10:43:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/34] hw/core: [CPUTLB] Move target specifics to end
 of TCGCPUOps
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-18-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-18-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
> TCGCPUOps contains an extra function pointer when included with
> NEED_CPU_H, these are moved from the middle to the end of the struct. As
> such offsets to target independent function pointers don't vary in
> target specific and independent code.
> 
> [Move target specfic fields to separate struct?]
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Or make these unconditional.  Move fake_user_interrupt into the CONFIG_USER_ONLY block and 
do_interrupt into the system block.


r~

