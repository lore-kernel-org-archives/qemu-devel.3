Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CE4D2502A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej1l-0002Zg-7C; Sat, 10 Jan 2026 19:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej1h-0002VP-9Q
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:09:49 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej1f-0007q5-Mw
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:09:49 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso205049b3a.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090186; x=1768694986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Jv+E1vpB1mVkrGTKvltb9UjfcEGo44tBQEyvl69+1U=;
 b=LxE2FEV3F4ElC6iNa0qbv6B5DPxYVaxXE9FxX+WBOTweZEus9rFwDdK9HtrA91wyjB
 89SiXPGoyQQ349EzgiWiX8cWqClXbAsM8TVIjQ6W9W9KKNgEm6PcyzrQt/TGMy5Skbtk
 aUmrSvfT3QNWL6eIuwNJMKSk1ckS4VRyxI1S0VctsNy+AKON4kD+dW5eREPUW5J0b3r/
 Ktr3vXh1/QWqBwQ7nsusObCOJT2Rvt/oAs/bZLMhC7gocLr6mF6ip1YgPQwBuy7hFJGU
 +jleH+m80fZHzTfz6/so1KuAyWK58SdJCzFAzxPsUKxbKFpPADGTB1tCBy3l6YucXWGP
 WH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090186; x=1768694986;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Jv+E1vpB1mVkrGTKvltb9UjfcEGo44tBQEyvl69+1U=;
 b=BNOJhlbnpxN1AHC8yLv9IY/xYieiyU8oKYyhkdyq3Zlo5Nir9zPmH4U2WlqktBjYbg
 bHoryoqwlF98A4rHOZ7zTLfN7yMBT+B3YX+cCe1tT8RnD3cF8vAE6bzgIVfmEIrtFdn7
 DhPUu4xT8TbcxXyfwKaPbB+NiAGzQXRgbyV3qUKPWk2KYKt8sG2tVUngcvyS6xt6ucAi
 HdMsxtoTnlboVaKWjwSYEo5+pXfL3PcN9RH93nlu6sIzS3TQrAp/drK62jdB4CwB8MD/
 EWaMZyOii2A5dyAKQwP3vxqVq2RsUxGW1OakYVSneGeWQP39+inTt3NGNUn1uwsFzRYU
 rmrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNoV0NymL68k01mGndqEaCVyoDBpN1Tn2ZC72zarjd5AZm5RdJKvk5drhdatgqEO+1Hoj7zZOeQ1Kz@nongnu.org
X-Gm-Message-State: AOJu0Yyydt6Nh74QxVIwVmN3RG8Gc+DL03q0FRyRxxl/NtjjEEnxVwsa
 i7253Qc3IcgykkJrGCQVYsEZx3dP93msOwlxPVwC9CB/m5SPNOI7V4zGphUvBsrpasI=
X-Gm-Gg: AY/fxX4ZVtMlyiChowPOYgvaobU63eyo/E6aeBqmv2FrEgZ0PmUgvvLltnDrp/EDyxx
 JwZV1uhwXoeYtKnSoWhMlBLw4+ccKpbd7FL2omfd57Xbjx/bbAdNaEqdyVVlA0fhH14E+jOQXYY
 HrBP9Jz//O7oRmf/fWmNp0O03Q9M6F5MCUB1MYKGo2qiI5fQCL9s9crvOPtDKSIAiJEGHkr7+cR
 3mmbXlvThlGmwaAjDnU1Zg0QNbe/rifV4o945ZS9dbN8edUXiLdNTCMfmcvcsIVr/h/PVW2RVCi
 27gIF2+JvCZynveuVhdE+JodE6j2+Y02ICCZd+Xej4CfCTpkM8pdU7dlhQqunktfW3Lui097lhM
 eX4IiUTMkr65GYfruvKS0ZK/nu0KT/NqyPynaDutSX1cLApFyR7F6uWZ42SWpMFhDXCBSNZT0jR
 XK7Mk2ALwbi/COhZZd3OnGc9z5UA==
X-Google-Smtp-Source: AGHT+IHHYDcDPfY68rbj5UcLUmC6ULuEOWTQU2KTGgrJGLvMuzweLf/+k1x3v7fgkwojPMAWEaMxyw==
X-Received: by 2002:a05:6a00:ab85:b0:81f:1a4b:bf55 with SMTP id
 d2e1a72fcca58-81f1a4bc2a9mr4108951b3a.39.1768090186233; 
 Sat, 10 Jan 2026 16:09:46 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81efe4a95c7sm3557144b3a.37.2026.01.10.16.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:09:45 -0800 (PST)
Message-ID: <63957684-8839-458c-a0c6-0054d90643c9@linaro.org>
Date: Sun, 11 Jan 2026 11:09:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/tricore: Build system units in common source
 set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/8/26 07:06, Philippe Mathieu-Daudé wrote:
> Since commit range 809b460f305..cd08bcaa36b we remove all
> uses of the target_ulong type in target/rx/. Use the meson
> target_common_system_arch[] source set to prevent further
> uses of target-specific types.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

