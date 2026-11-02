Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC16072C46
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZUFQN8Vf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtJC-0007RT-DQ; Mon, 02 Nov 2026 09:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNtIg-0007BY-AA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:46:23 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNtIe-0000lR-Qr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:46:18 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ea138a3497so19779995ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793630775; x=1794235575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U+stu5URgljUQ7wVEZmEhAN5qX+gY/8lQntT8BLPQDA=;
 b=ZUFQN8VfZMtPcEe/uN1x1J2gJDNuGGEXkvI7TUngfE/EfaAEXmGswjwLXGJWw1bbjz
 5+Y0Hg0eGLVg7zE1hJgsNtE6O2sWnddTWGXcpbT+5svDd7kAK9UFei78DgjfLbJhhzqF
 a9ra3uzpH5WTG3Ue65q2a1DgnjVAIzmcKBmlh4kb24udiaTItkbOBCRscW9uzqeWE5pU
 R11ED5WiFfnAWV59mLisRgtA1oiQIgN6BAUZLhkwj3zwZbHWbvLVnapC1504QHwltnZB
 nD3mXoJ+brwD+5+6/SOPK+iLgq66mJbfTw8m6sqt5wSM8HTHXEg/zbnxz5+Ec5m/TnH+
 StQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630775; x=1794235575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U+stu5URgljUQ7wVEZmEhAN5qX+gY/8lQntT8BLPQDA=;
 b=sZxuqxX8K+26XjpGTicL17YYUQaWVj8HHdz83bHnQfcnlkFUieWeRJPrgSK26j6pA2
 L0y6HquQSOLHsRMkR/rO+/MD+8HpnHNeb1pCKC/pqLufxDz3+cnXKQKu/disu/6a1+vi
 c5wynBlCUE/IVl4rlyBIurkvk2O/UYMe3dXjrUmMwfOK04Psu9gGtqlTq5e+KCjMZhgG
 UhjswmFy+hjGZtohgCR9belVZZD0GYbnc+v8G4WDZMyJqNLHz33BqL862u1vyAzlYrSF
 AFn6B5Q3aViHz5woSgLw8TI+ZH5kME1w1XUqoRD55zKTYE2udQQOxmLJSjrTVOwBeCmG
 ydBQ==
X-Gm-Message-State: APuU4Z9KsF2ZVFaSxLoZB3+9I9jC9zhi1xteWqzxmGsasDDuu3j2z6XC
 YjhY30lHbFQa5lxg03vQVAWrG5C57DPbywbFkKZueh+Aea7Pnx37bQhDDP6G+HAmWGs=
X-Gm-Gg: AYBFou1Bb2dCAHanKpXUhNlaaGunMmoC6Z+XC2eDft5aADkGXeCayGDirA0eRQT64bw
 bLxaVCPaw0cVsQXBURuv4nKYxWsh7oLBkJsu9AtjfLxqgtpUPXPhnTj/P2QgO+8TkuLgZa37sj9
 +jW5r/8UyC1Mndf70i9ibxFCiMBKf7fDDs5fHGddH/rtNXip64EUF1q/JPFLWBnmYZM1Y6jDy+V
 pa2n1JAKwHQ9hcXyAba7j2ZFWk5E48fNX/gB4M96Svl0eVk6+doZVO+/5qMigWq3jfqgp1XC9iC
 eWpk6yxQNfboN+d3BEZgJ/lmcLPknpytrYeJJdQdXMuePRazzPL31HYRlpR9+5OeFaNjszMzLw+
 Yo2Djjvx6ptOgEK4bBbGwVdon8mVLeyzr3DtwzyFzFDF6nQYFy8PQZkBv0ItoZswTkUuW0Upf9S
 U6UZGPsM7xY5GsrSOS4LFu7BzKM7+UMV8VrZbAal6v87gXD3D5GMpqGOKrNVZvwll9QObWcq2wW
 3pRhYbuUUsxRiNQWAUixh7kHlbkDme+RRq1a9epAREcrT67tnE3zXtntc5ujNDZLb9MAj/L98vz
 gMmuhIENxOtebibXdZgxbVHYe2ND2ByllF5pXDMK89eeVxnF5XfYgADJYCcL5yz594yy8AcOGUL
 +L4n9b4jBtRkFJTk=
X-Received: by 2002:a17:903:1b2f:b0:2e9:5ec6:bfc9 with SMTP id
 d9443c01a7336-2eb3648b9efmr93800835ad.9.1793630774961; 
 Mon, 02 Nov 2026 06:46:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39278e13sm29152725ad.45.2026.11.02.06.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 06:46:14 -0800 (PST)
Message-ID: <23a1b59e-f2e3-43e7-abb9-b5b92911e487@linaro.org>
Date: Mon, 2 Nov 2026 06:46:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/19] tcg/x86_64: Introduce TCG_REG_NONE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Matt Turner <mattst88@gmail.com>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
 <20261030131554.41208-14-richard.henderson@linaro.org>
 <CAFEAcA-Bb0PrHh4MCiWt8QZSAm-o=9ENiP-EBBVDrfU5WQCHAw@mail.gmail.com>
 <9463f02a-1d1a-407c-87cf-4dd8f8d00a4c@linaro.org>
 <CAFEAcA-XsHfHp8konU0XAxtTzw59i8A9n8Q1c-N=qJDjZV-fsw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-XsHfHp8konU0XAxtTzw59i8A9n8Q1c-N=qJDjZV-fsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 06:40, Peter Maydell wrote:
> I've marked them as false positives for the moment.

Thanks.

> Incidentally, s390x uses 0 for TCG_REG_NONE, but that seems
> to be because the instruction set really does have "0 in
> register field means no register" in some places.
Exactly.


r~

