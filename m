Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CA1D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve79K-0007i6-B4; Fri, 09 Jan 2026 02:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve79E-0007fB-MM
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:43:06 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve79C-0001e7-So
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:43:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso42404745e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767944581; x=1768549381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heQmLHCndd9aieu3z7/8JKl1190F2b8PzczfRuM8bw8=;
 b=hslNNL7R5bCTBrw+TDAAqAV3JkgmItn9aGY3SILQ2w5N/0pIMTHH+hwlfnmYGBr1RU
 YsQo7bmJmRYwFkvgrt6wTURKKUN1yHQC88IY1USBsqqOqL/Nf5fIgBs8OgS9BJKNCf/D
 ALYa5ODrWQkLAI6OVe4ZMFmxOiECU5f9T1L7VARMfaoen4mqUtKmFT5o8jngTKcS+tct
 AWY7yT2VfAPCq56Tk4vGrC0YQDeXMCBvNqpUSerzesbNabN2NYJr6HcSoLjzf7D5mU/j
 VzqCRCLNPv71W3VgmI7gVEXnaJfglkSWfcOnmXlnPkW3pZO+s/z1Sw3oLWKwRRHSOaKP
 VGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767944581; x=1768549381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heQmLHCndd9aieu3z7/8JKl1190F2b8PzczfRuM8bw8=;
 b=sZINrDloiklg7R0Xl0uyvrk3vmBwDIs6t8gLGLMzN9cfdsKXv8k2Afy5Q1s0IBubgW
 lwdTgDwJiOVYFQ5vlLF7cQYvO62Ml24PlO2whc1BE1YL4xXcspiRk9embbLaMdGWSxxC
 UiBhqql6BCMvpXGjHQlZ9JlV9ifB6xPCT1PSuC7mT28jURgqH4Km98EZOGXCZV4uqWVb
 +ZtZtfGqnW4NQwl6xuIWNS/J4mYKe3WsjBK75Ii/LezPDH/u2VguGKPyREAFJdikzzrW
 Ve5k6PerESc1ihiJcz3ilIHpobx7i7izr7wFycJ3psCiwpqK2Ty3yt1/VH9+0S+pclQw
 MP8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdZn6K9CugU/o8AmcxRcnXIgf4t2kPIvFGCJJOvnDyZJZf5+58LGz5TViIMwzugP77hptvEH69cCQg@nongnu.org
X-Gm-Message-State: AOJu0YxY9b8MWqqPLdLm5XqKw67Vs7utAfr1h3gtvNz9PuT3meHb4MxF
 fSSBCGBmgZwUPeWzEt8PnV8C+CD3UIy/0lyVDaAg3x6FBeNKubAARfDFlQZFaRCVEN0=
X-Gm-Gg: AY/fxX5bX5RFi8tb14OuTe5Cy+F3RbKbvpCVwcz4zM7+lOuloPza/vZUV6SwWaYJTMb
 87Ex6i3HATLae56wL3l88+mHp28PThcIp7ASl6S+uDrCzxSiuvm9BDu54bIyLOuiJ6AaOfxsBRr
 ppLMuj93PtSMsVtSxIcXXLIitypOxwm5m1cgY/tC4LqkDDYc6YEpl+0PzKt4EQQHQzwb+n2doou
 hk846Vb0Fhk7rgDGGA+/QkWqx5VDcQO73ZsPmGSaR7c6y3OgpDtisK/KrW1anaH1h1H4wxd1esS
 qvXyA6yhFRLJxA42zR7v8OAdRi6/yW5cGMvphI/M2mnHyut0eObAusLzegT9LmvtZ67TI9NPu10
 6wVIrRzdz5bA6oKW9UukVmZWc1Yq5v3lGyJskE5QhhBb5S/j9D+J5RzgkDg4j4BydSFfSDLvaCO
 SuF2kD+765TzzcfQ0GI6VbKfz07cPbdKtAUwvsOVAD+eMlMIvpSA+hEw==
X-Google-Smtp-Source: AGHT+IHqwIb3kiigy3z61jbdJhvgxrpCBbPs7lHGCXcnkNHQtbUHeNycgtmI2DH0rMaORXmkKmk+OQ==
X-Received: by 2002:a05:600c:470c:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47d84b39d1cmr92758335e9.25.1767944576972; 
 Thu, 08 Jan 2026 23:42:56 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c86sm196508855e9.3.2026.01.08.23.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:42:56 -0800 (PST)
Message-ID: <f86879f9-0733-4e1f-8b97-9e1e35f6e46a@linaro.org>
Date: Fri, 9 Jan 2026 08:42:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/29] target/arm/gdbstub: extract
 aarch64_cpu_register_gdb_regs_for_features
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/internals.h |  1 +
>   target/arm/gdbstub.c   | 53 +--------------------------------------
>   target/arm/gdbstub64.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


