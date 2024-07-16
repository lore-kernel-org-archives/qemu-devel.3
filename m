Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9D6C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl7Y-0007fv-3G; Tue, 16 Jul 2024 12:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTl7R-0007Ue-OR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:33:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTl7O-0007lm-LU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:33:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fbc0a1494dso34515455ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721147612; x=1721752412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eOCvtxuPXKdYoz3fnUC4P2Hs6TFctPbMipLplPpaSLQ=;
 b=fl96L3NS6xVV9F3zXzluFFb2VQz3XUl6fdmvl9zyGpzdptn0NRs68u4RO+z+9Wsv8J
 N+Fs7Hnfh7ZZuindf4TPHj7Z7qHd8Dm3/nKUH/V2iF665Eq0vtFb7sspx6KnmFwCPqw/
 fniSx1mMbvlD7Jg3JAdsY3RJfKni97k9guOlN9i5T348Q4UiW0AY3gKixs1GXbdlFcdl
 EcD2TwmZ9INDohtmjGBzpymknmtcTMxDg6spECrS9o3Lo1SLBFQBJFZUMoRqBFPlzX8n
 ZBpKh77SvKMFTdzHNR+hHMMzdWrHkfes+CVCilvz87vHVyNqMHB4Yu5hYmTT8UZr61RR
 UvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147612; x=1721752412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eOCvtxuPXKdYoz3fnUC4P2Hs6TFctPbMipLplPpaSLQ=;
 b=IGHAWth64MU0WDuFre6S3lfMPPEBrwmQkQbKDDLUwxRS0zriKRgo60pGG/fBJpjb7F
 X8qf6SeQpz8PblIwBq4+1oRIIATx5nzKor/7AZOtNNBlignE0tmDLokZz432gLrKvKjM
 w/NyVVg3p96bAajMvIEBsEa14NxzU7yxrjbL5w2X8hCHxVZbDuX8M5OlarIPrhB+0x4K
 +xRULY5ibzHBQ5G8OX0l2Hedo8pgeRl3xJb0wP5s5sTUpkMW29/cu2182JIQsJOEqVMJ
 9LUsDChktenBSmbPrG1O8Abwy4CvLFemsQ/jDgkbLLTbRrwcUTNEKmCV/omCSLWK4WO7
 FmLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULT0yuwGXW1PpbIm4LCuocURunEJvf7e4taqs8AbvzgYSOGkWTHhcRzpz6tOltVBtEKgRo8OS81FhXbENxn8FL+a3Ai54=
X-Gm-Message-State: AOJu0YxJdI44Mo2cjqpQqZ2EPNjZ1e7l5/9OPEQlmkMp1QmyyK23D33t
 USW5RM6OUEnZXzzNug6Z5QezkhYSJB3/piRy7xdOYXeV7EGzC1viXBNCkBGwwhM=
X-Google-Smtp-Source: AGHT+IF+0qh8p2s3SUeCIwwOsDAb0LZM/jwQexX/uhOvSO+ZeQSMq8VE5gUQh5jnGQd1wkMz7ifLEw==
X-Received: by 2002:a17:903:1c5:b0:1fb:7c7f:6458 with SMTP id
 d9443c01a7336-1fc3cb5bcc4mr26876785ad.32.1721147611654; 
 Tue, 16 Jul 2024 09:33:31 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bbc68absm60085245ad.118.2024.07.16.09.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 09:33:31 -0700 (PDT)
Message-ID: <b9b178fc-04f5-49a6-992a-f6920408b41f@linaro.org>
Date: Wed, 17 Jul 2024 02:33:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20240716114229.329355-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240716114229.329355-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/16/24 21:42, Alex Bennée wrote:
>   void gdb_extend_qsupported_features(char *qsupported_features)
>   {
> -    /*
> -     * We don't support different sets of CPU gdb features on different CPUs yet
> -     * so assert the feature strings are the same on all CPUs, or is set only
> -     * once (1 CPU).
> -     */
> -    g_assert(extended_qsupported_features == NULL ||
> -             g_strcmp0(extended_qsupported_features, qsupported_features) == 0);
> -
> -    extended_qsupported_features = qsupported_features;
> +    if (!extended_qsupported_features) {
> +        extended_qsupported_features = g_strdup(qsupported_features);
> +    } else if (!g_strrstr(extended_qsupported_features, qsupported_features)) {

Did you really need the last instance of the substring?

I'll note that g_strrstr is quite simplistic, whereas strstr has a much more scalable 
algorithm.


> +        char *old = extended_qsupported_features;
> +        extended_qsupported_features = g_strdup_printf("%s%s", old, qsupported_features);

Right tool for the right job, please: g_strconcat().

That said, did you *really* want to concatenate now, and have to search through the 
middle, as opposed to storing N strings separately?  You could defer the concat until the 
actual negotiation with gdb.  That would reduce strstr above to a loop over strcmp.

> +    for (int i = 0; i < extensions->len; i++) {
> +        gpointer entry = g_ptr_array_index(extensions, i);
> +        if (!g_ptr_array_find(table, entry, NULL)) {
> +            g_ptr_array_add(table, entry);

Are you expecting the same GdbCmdParseEntry object to be registered multiple times?  Can 
we fix that at a higher level?


r~

