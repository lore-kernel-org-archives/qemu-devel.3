Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D2FC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SuP-0000CK-BF; Mon, 13 May 2024 06:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6SuC-0000A9-4Y
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:27:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Su7-0001F9-JB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:27:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420157ee56cso6425605e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715596052; x=1716200852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnnDOhkSf+928a3znwihP07RaNhWnsXN5+Ft9yFRAvs=;
 b=LX3rErhzjp2rYWn2sW9u9isFJ2lgWQmc3We5d5XkTPqOJxXRO5aQkAk1eBbOyUxJuJ
 g3mgL0L5WxtA0azX2ZP6hWZCilAfK9VfRSmTl4wxnGe6JMzoE6j/Z0SPZjlTVn+6pSBC
 DfnPfnvstBe1MKMVknMjy+rgKNPE06HgBjzkS9fgVS5/YQELrPBYyAf8doB7oRmb49To
 BHmfrzMbZu8skyxnGcsxvy8Vlyk3CLP/UvXR6i5EpjFmg4dWfH7a4beDDX++fO3VeM+1
 fTjcC55zby9Mdv869RtIV/6Ye5BT0yWKP7N+JNxY+pHFAqY1sCH6F1K1WqCOgUtaupVV
 6thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715596052; x=1716200852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnnDOhkSf+928a3znwihP07RaNhWnsXN5+Ft9yFRAvs=;
 b=KrbahzL8+uXnKpizolrQKjUaRUMc1I6WPqBhz6M3otll1jl3kz3rWPb6sLaxhpUG0a
 KnsmD1SidYMdLsxcnbsz2h1RjO78nF3ZPEDagXeCc9KQTF4yoS54jf0MbHAew+RtqLXQ
 i/fxi919QAg+NRYMqUNUCX/MAF4I6o2Q3kl6swkmH9KZVfDZfyLp8Tn++SnkpLdG/sJC
 XfH8QpuV05/baHtNTyJwKXXVJUHD/7BJxnvNxQ5CyI+G+12xKGI7MlZeh1uSb21EVX06
 fpVDV7KPbJsPyb11YqJCzfU81xIr6pVc5EkweXipYgeafpoU3FazWXjA7wmYxWRZNqmN
 KImw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXCpUR9DRUjBeGN+ILPkFmF3UZR/txJyRzW9iN8EJqPR8rAFIMJcbg3aq8xjbAJARqh4F1Mx07KfKmQPv/EtGqIOu8nTE=
X-Gm-Message-State: AOJu0YwX8RAuA/EOHHIlYzy82j8/D8rGkHswybohQQ9EVNEHidQ3Snk4
 US/DrGXPuOIODRQqwWHfk7THadvsxOnswBnByVakj/+Y+scBzKQENdnvkoZf8Eo=
X-Google-Smtp-Source: AGHT+IEO3z2kgjrPEMtfn7ZftaQ5ro+KXAud/ZX0s1fmMl6ccrEVSl04yKgB2uOUCYYB7yqJOLM+6A==
X-Received: by 2002:a05:600c:3c85:b0:41a:1b3f:b465 with SMTP id
 5b1f17b1804b1-41feac55fb9mr71643665e9.26.1715596052332; 
 Mon, 13 May 2024 03:27:32 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbc5654sm10829373f8f.115.2024.05.13.03.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 03:27:31 -0700 (PDT)
Message-ID: <09dbb04b-4ee2-406d-92b8-e0d0185da63c@linaro.org>
Date: Mon, 13 May 2024 12:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/45] target/hppa: Use TCG_COND_TST* in trans_ftest
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/5/24 09:46, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


