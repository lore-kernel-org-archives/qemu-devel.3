Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF13C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 21:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMc3-0004fw-FJ; Tue, 23 Jul 2024 16:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMbu-0004RM-Sp
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:59:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMbs-0007et-Kz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:59:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so40189135e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721768387; x=1722373187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aFgVYa1v2h146HihTeurtxVbFu/ulYYaQPwRUdyz9X4=;
 b=u7dlU5icfbUm97/2mPCNLYcSgEG7hCVJ3JwOISYChJGmNidcT9EV5PR5V9uBOBSZ3X
 8iaj6rxf8H60zsOKYy/8/8nvlzvYNttNTrxsCa6ZnRIJcq1l4WYeU+bcQ20dp5+WUMT0
 lu4/zqF+XIiQQSbbKCZY6UwDg6uM1N68MJ4IlC5o3JLlm1xhIA3kUgYbfZ91mn1YnLd/
 pyj6BVJvX1zCZGUCmPzo3cPBvaZqhlh6h9XnmyNTAKKBQxaO+AfYmKy2NXidwdWXknQ5
 0jBB1z9OVBhONcH9bu9+ulpw3J5GjwgxKEd8+HC8Qpc6kYbH46zwNTPiVm9SL5aGXJCZ
 L+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768387; x=1722373187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aFgVYa1v2h146HihTeurtxVbFu/ulYYaQPwRUdyz9X4=;
 b=rg52P3TjeJaxI0Yoshnpxpt3TBjoOoyU87diq9wLpLDdBRHpxOUQuhKcT7d7w/um01
 JL5QKrQ+eTnlrlUyvplnygJD59w+g8KxiAKOX108+gtrybIUeHdhVh849hNhTXnT2Rdj
 gOM86tmMV/WG1Lcs3JjBfy4Qvw63WAM8wFYAjFd4xnUca7xM26OaZST+SBJnlVzgrhn5
 iYOn8F0aAtUg/pDGpPD41ksHg/LSfclThC8EKk158yQx/u+SXpLQdLFtt5tJ7uYOaxli
 Nhm86OEWb+OjEe0aOTkDrMY49lEKE+u+5pXZQ0k7PNsQ2Dceh0opqr+rl10INqACxSb1
 uR1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8iGCBplw7oRslpMd3xYLwYIv2EHQc4Bq6nQcxFOh+6lx/IEUMqnuFAq3b0z7xx6zvHuP9ytA0Cjs3AJqzfjegXyYte7I=
X-Gm-Message-State: AOJu0YzRPVuzcvdsfPr7eIPS+/kYulrwMdZ+cpAWQDOhjJktydLLJg1w
 P7E4cJMCYTrvh3awBD2v1xIY+NbQ/oPEP+BCjHasQdpS2LAeuVVnoLWeWEIuJkA=
X-Google-Smtp-Source: AGHT+IEiaVkB/7r8twb+Op6bL6DnZrxSV1RSJnyxoo/dCCwpIi+lYoay/WArP1MJf4r1E3j0BoO3cA==
X-Received: by 2002:adf:9dc6:0:b0:368:785f:b78e with SMTP id
 ffacd0b85a97d-369f5b0f1eamr61001f8f.13.1721768386782; 
 Tue, 23 Jul 2024 13:59:46 -0700 (PDT)
Received: from [192.168.69.100] (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr.
 [176.184.50.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f939aafdsm1000025e9.28.2024.07.23.13.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 13:59:46 -0700 (PDT)
Message-ID: <06420e5f-a493-44b0-8d32-1a4dc2a9db59@linaro.org>
Date: Tue, 23 Jul 2024 22:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: update tcg-plugins page
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240723205451.504193-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723205451.504193-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/7/24 22:54, Pierrick Bouvier wrote:
> Reflect recent changes on API (inline ops) and new plugins.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/tcg-plugins.rst | 101 +++++++++++++++++++++++--------------
>   1 file changed, 63 insertions(+), 38 deletions(-)


>     $QEMU $OTHER_QEMU_ARGS \
> -      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
> -      -plugin contrib/plugin/libhotblocks.so
> +      -plugin contrib/plugins/libhowvec.so,inline=on,count=hint \
> +      -plugin contrib/plugins/libhotblocks.so


> -- tests/plugins/empty.c
> +- tests/plugin/empty.c


Could we use the same directory name for contrib/ and tests/
to avoid that kind of confusion?

