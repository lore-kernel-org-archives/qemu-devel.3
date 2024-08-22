Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D53C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shD07-0003Aj-Ko; Thu, 22 Aug 2024 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1shD05-00033U-QD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:57:37 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1shD02-0004ZH-8N
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:57:37 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52efdf02d13so1656445e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724353052; x=1724957852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EwqKo5OF7mFrEAuAgBAi12JIIbjG/XKy+C2LYbS52nc=;
 b=aLvVEUDlChCFCAlnC5TESgXxdZMAdsBxEgejLs5L3CNZ1KSeq9msOVPVYr00aH+OXT
 v6SmC1I6r90rFvws76FihYvvY/e72CUTXby5lLjmGNe+7Z4/+l2+7d9RLGKD6iAhbXEv
 lUBnXPynITimHc24Ns9QD/qBELWk4Qre25MNmqwuo+31F374/zDtIfZZQwDglj6lcxiE
 KhFnTScXX3mMFWU/nPzXpWwdjbGYlgRtWb1VntyjXQVb/gosFZOR5Abj6+BWTMmksbRS
 b2l97OdD+/gJ2A/YuMQ9IVrHOTCrUKDbcv45x1F/OkwOYqYhNo6eGtv0ofMuqF246hIf
 pEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724353052; x=1724957852;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EwqKo5OF7mFrEAuAgBAi12JIIbjG/XKy+C2LYbS52nc=;
 b=L+dLPegfgBVTAFu+CIWBG7X9vMGBPwZ514nWssucmM7VhZYE534DoLUHJgmpHMY4Ao
 63DKu/A1pojBmr7s08LcBe06Ff7lNdpmWoQqGzfKHbEk0gz3B8s944xIhQgGRl8JvL+t
 rfpRtflzJ7KCzpzvcOlp2qPFV7gGtR1SZgOPRohddR3JSXXnDJa2A9giwhLGjpYaQPb4
 DsO7YkYP9qfUoicFQiBN0XJxRlC+LaSWRjo7S18QyxV6QbMV66af7IK9xaI6sacrbBot
 fM7aBl+jSjXxnbuXHldUJkhYp6TuLtwqri44zKbqh0yWMC8A1Ov2uJZODecZxfiZ20lp
 f5GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm2AAhQxYLHEaVKw70HWL7KXF+uGHZjVFL8vvjpMc/mQCiqV1s0v+y3p3nvRK2H9aS1EpgMglz59Ap@nongnu.org
X-Gm-Message-State: AOJu0Yx+dVDGGGoxkWcCKq7GPxFy48QdbWTDXLsF9a0FqPFecYNHCIxt
 tg+LQngb84rkESl0bd8MtTTEici+F+Z9L6ZDUJQI6d5FbQqrg1tMUw8mlp9WYOU=
X-Google-Smtp-Source: AGHT+IEkjNA5bVOF6ZQownTyztsxwEfmWsFYTucF71xT/+1oQ7HYd3layJhMmiLw1DBpOg4oU4BQUA==
X-Received: by 2002:a05:6512:281c:b0:52c:c9e4:3291 with SMTP id
 2adb3069b0e04-5334fd64f4dmr2031935e87.60.1724353051625; 
 Thu, 22 Aug 2024 11:57:31 -0700 (PDT)
Received: from [192.168.200.25] (83.25.211.12.ipv4.supernova.orange.pl.
 [83.25.211.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2a1df5sm151883766b.68.2024.08.22.11.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 11:57:31 -0700 (PDT)
Message-ID: <02034817-3f31-42ca-ba5f-0333e7bd344f@linaro.org>
Date: Thu, 22 Aug 2024 20:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240822114146.86838-1-philmd@linaro.org>
 <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
 <b3d054b9-4ede-489c-bca5-b61b046dea50@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <b3d054b9-4ede-489c-bca5-b61b046dea50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22.08.2024 16:39, Philippe Mathieu-Daudé wrote:
> On 22/8/24 16:06, Marcin Juszkiewicz wrote:

>> Maybe for QEMU project this is a progress. For me it is moving tests 
>> from working ones to "sorry, timeout, find out why" ones.

OK, problem was found (check my previous mail). Tests took 222s on
Macbook with M1 Pro. Not looked yet how to enable skipped ones.


▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_cortex_a57       OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max              SKIP
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_off    OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1      OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_edk2_firmware                 OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57          OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max                 SKIP
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_impdef    SKIP
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_off       OK
▶ 1/4 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1         OK
1/4 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref        OK                 222.88s   8 subtests passed

> Sorry for the annoyance of switching from one framework to another
> one :/ 

Project wants to change framework so I am not against it. Just asking
questions.

> Are you using Linux on your Macbook with M1 Pro? I'm using
> macOS and these tests currently don't work, so for me this is a
> huge win.

I am using Fedora Asahi Remix on this Macbook for over a year. Total use
of MacOS was probably a few hours total (including waiting for MacOS
updates to fetch).

