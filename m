Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243FCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcdT-0006Ts-VU; Mon, 29 Jul 2024 22:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcdB-0006Se-Gc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:30:30 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcd9-0008Lz-I2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:30:29 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-65f880c56b1so25947327b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306626; x=1722911426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Ar9Sgn0IxzEYCHEZAi5SyFy45mh5993+jCFx1sf8HE=;
 b=smCqM09q4JLo0++5rWq2/TZHnFhkXl39tzgSYafug6j8BJAEg7ssS5S65GuiVrbA0c
 kswP7u+eiTV2lgkbOr1DxRDwZQFlxmVeUpuzRd0WsastD7ZaMMKmZybIVAlf7Rv15h+u
 nAVAR4Caz+WjVqDTF4ObufCbJa+uFwoZHHrKIJpNaiySxdFvtZPdq9IKdJKV7aIhO2Oa
 OROTGvJXVxLdY4UPehBgogpUo0iP1cunvVn945QgI2Y9qb1eJP/Xeeoxjjsw9lNqnIRe
 soNCIA1SuH/3sZDEyi6EwmoEurd9iGziHxUuZwpeAwNEdw8vxNtIteaEq9XV8VlabEDd
 49pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306626; x=1722911426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Ar9Sgn0IxzEYCHEZAi5SyFy45mh5993+jCFx1sf8HE=;
 b=HIgrcOK1bcQ+F41whsBs4EML9kFE6yFOTNnnD035svMor7pojcEIeBg447ki1estKN
 F+xRmjaCyXp5bpNLmPI4hAEB/uI9Xlq59W7RJA9y7LzQpzz1vcRHJcYI7vHAD07urBwk
 uP+dILpwVjmbyYzdBTfBvTyPtpHiQR3IW/PIfR+hgrhWlftXivWjkhyaGYPau1cKEYm5
 hiWI0V7ohJC/DouDpZkX8CpXHUOil85Is4vaWtjSJo3o9fqDbczq1P9WP+sQwkldFQib
 3MbF9vC1EYDR/hM74yKd+IN2Bjr7nC5FLJsNnKXmUSn2q0lcYSTbecYRwkLejMlSJGHh
 roPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE/4DnSLciVqv0mUKyK2ALfjvr860EDHNydpsg0IVNKMjbdRDJUspB1YONrkTbdqex3LMRSC3KcgaCDhJ3AN9+S+AmA6k=
X-Gm-Message-State: AOJu0YxZ1GdFyTFl4g9Vt6Hf3E2AG6arEK8KsGAhR6cg7oRMwoViO8kK
 M1OkcNNez5rNjRc4dzWVZh25vWN+w/waKrkug3M/5yhrHEq696k1AXZg9NnVg2caJO3jygMz1xo
 Nc1k=
X-Google-Smtp-Source: AGHT+IGXd/O5IP4IYhH0NNAwcjl1Xv0fEACN4QaROjI9SFC7/cBQ/cZvaajj3xQ3YP2pq82AYjHnXQ==
X-Received: by 2002:a05:6a20:9e4b:b0:1be:c2f7:275 with SMTP id
 adf61e73a8af0-1c4a153355fmr7731387637.50.1722292011255; 
 Mon, 29 Jul 2024 15:26:51 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cd8865sm88694695ad.81.2024.07.29.15.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:26:50 -0700 (PDT)
Message-ID: <f88f47b7-a1ce-43c4-9285-ee13c2e5350c@linaro.org>
Date: Tue, 30 Jul 2024 08:26:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] tests/avocado: remove tcg_plugins virt_mem_icount
 test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> Since 4f8d886085 (tests/plugin/mem: migrate to new per_vcpu API) this
> test was skipping due to not being able to run callback and inline
> memory instrumentation at the same time.
> 
> However b480f7a621 (tests/plugin: add test plugin for inline
> operations) tests for all this matching up so we don't need the
> additional complexity in avocado.
> 
> Remove the test.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Fixes: 4f8d886085
> ---
>   tests/avocado/tcg_plugins.py | 33 ---------------------------------
>   1 file changed, 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

