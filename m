Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8235BD3A678
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 18:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5qfK-0006Vb-9i; Tue, 29 Oct 2024 14:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5qfC-0006V8-AI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:09:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5qfA-0003eV-Ks
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:09:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-210e5369b7dso20782155ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730225389; x=1730830189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=19ltOQlymDKRQZLp7U/dVUvUrG56GYCMOexe09qMXc8=;
 b=AKr2EuSrtxQiKQffy6Rxjgm1ALFhotEeekklrGi/PkRNcm0Te5fpBUonLSbIIfm22E
 SqRt+5qnTtBUlfdNmWcY/HU8Z1Ax1xRhhB4MKKJ9ehFE15P+lWRuV1/BLwN+m6QhNn/Q
 5bMTv/gE9PH/5nXh/U3qphBNTymwWNcX+DZi16+rROsqKOvMlWzU/cgUPSIR4wdvl4Jd
 qYK6U+k0drgWEKxc8OKun4A/6iu9qGXGY6jsgC8ZueBBXizUPehEC13huP3K/zpWZdfV
 vezPXtb6LCxjVPKbfW4LjM2m/OZDAiLzIZCgxP8X8fNKfTPvc+r6dPf8e1YbR4CwgR4G
 Xyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730225389; x=1730830189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19ltOQlymDKRQZLp7U/dVUvUrG56GYCMOexe09qMXc8=;
 b=XCulSq3S9oTurPtoLn5Bh6/0o5PA6SAfvADDqTfsDvGehGu41qnfTl/rAczGmV9WKF
 N7iyvRovnaTndLtLHvtOmwGejTE1x57jylh5ueDv7l8f/1yPxMi3gLBOHRDP6eLl9uyK
 e3Z4i5MaUwRDnGZRgIfQ2gDYnb+jYp1ylrrGvbqWOYi5pbXrzEM4Whw7CtpEUd0Eby3v
 TtVeVk2UWxV9cWr1ikFmoH1QCct2QF4NoRscF5uNfeH8GoYiME/bue1wj9D3wTOo9+U0
 v267UjdDrD+TpVmZk7x+mCuKye3eelvo8AM1DGCcmZygAxn3ax9+nHhjsAiLL9hLSR7/
 Zifw==
X-Gm-Message-State: AOJu0YztSIryPOi288ZC2LisCpdSxTeK1/N9LP/l2xtDriJT8Tr9bT4P
 ENr6zzr+waIgrhs6Jh+FEzWL0MFx7M00N/1CXnmC6XJgVAcVkLU0fIrgE/ASwlcApaTP6c22OiK
 9Zbk=
X-Google-Smtp-Source: AGHT+IGUk0f53wFxeNqwwuKS9bGXs4rxuRceFdagJCSKRDj4bupqvVx39ELg1BYJb3tpCkXlfE1PoA==
X-Received: by 2002:a17:902:da82:b0:208:d856:dbb7 with SMTP id
 d9443c01a7336-210c6c7868amr181072535ad.39.1730225389324; 
 Tue, 29 Oct 2024 11:09:49 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc04b201sm67980745ad.272.2024.10.29.11.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 11:09:48 -0700 (PDT)
Message-ID: <02bf77ef-9136-4976-b961-ffb889ed1181@linaro.org>
Date: Tue, 29 Oct 2024 11:09:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: remove erroneous file that breaks git clone on
 Windows
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20241023073914.895438-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241023073914.895438-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 10/23/24 00:39, Pierrick Bouvier wrote:
> This file was created by mistake in recent ed7667188 (9p: remove
> 'proxy' filesystem backend driver).
> 
> When cloning the repository using native git for windows, we see this:
> Error: error: invalid path 'scripts/meson-buildoptions.'
> Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128
> ---
>   scripts/meson-buildoptions. | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   delete mode 100644 scripts/meson-buildoptions.
> 
> diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
> deleted file mode 100644
> index e69de29bb2d..00000000000

cc qemu-stable

