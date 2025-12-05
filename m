Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B1BD2F7C9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 09:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRS7d-0001l7-K7; Fri, 05 Dec 2025 04:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRS7b-0001kP-PR
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 04:29:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRS7Z-00030w-JC
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 04:29:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so12762425e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764926940; x=1765531740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hxszPxzWI6GhMQ2yDnvupq9aExmicIE3wvtwVlr4P0=;
 b=Ea7w3b8rczt8k92vO6KzirNHX2mv8w+Rensb7QK0aayqI3LpofEunJO8u8+qeM39nG
 k2YqMXMcDXmZhqPNNTgwHdy75hhRZSHYobhl0xeC7ilmwFqLpYgc1haeGml/voZ0gODY
 R7vaDzQJM4zWnMx1oN6BJmghcl/9sc+Fj9oMWu+Tnl7B19/PunorbCawW6h+g553WmVd
 677IvvQBUtg9dDwJlc1dKn/X2pp7TfgthAOn+pCdZbW2p7x6HfyUQqwTDHp2jo71zsis
 h8WOI+yfhmw1wj8bnVAH3M9RlbYzNyE/snHHM/eKiB6oiSj9lrMLZ66vEqCw1KTxPaTD
 8zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764926940; x=1765531740;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hxszPxzWI6GhMQ2yDnvupq9aExmicIE3wvtwVlr4P0=;
 b=q80eUsrFD50QfzX7H3UgAqFywB/nKInHbxQ91pTWjZaez3rIH3K30a4mirm6f0h/Xg
 /zasFdyOlgWF53UYHIgJHp4Vd7jspL7JlZ38NS8S5p4akoJBsl91aiXRIU3ryYO2j89s
 39R/BTVpWZN5myPHrngxA33aT4hZTtU+eRu97xof1idNER4f7W2HQ/hz2HBA59YBE4B5
 dCAH0DO7/rVcB5WZMTF0W6SUxQNvTK82MiukH73uHIKDtqNkgG58gnprd4OBKsb4VSDI
 M/MeqO8LX4oW9ii5u3zvXkvmhm5Gagf7yE4ByNzcm/7tSNTQXf/Fl35ECjoCYYVrSIoD
 WKnw==
X-Gm-Message-State: AOJu0YxTTMJNbSbTItL7hwYDUmFUm1M8H0Kw0ICzfZfVGBwwWV17GnuD
 Ftog4Ltue9CmvKMQTKaQIAKF7litVqQxIVhFQKx9szz1ZF+XzuQLnVxL8h4fQBPbJgE=
X-Gm-Gg: ASbGncuElXPDU6NRCKg9rkSYAZhXbM93mczQISwOZVIB/bdoWKfnieoqyDCvJVx1wsb
 g8j32ZeQJ2pwWSC/ImSnbWjcH0s9T4MHjzHyQsHvTQp+boo021y9J3iXFoMlK6KIAV01vtyYtCJ
 2nU48z3dI9WuPZ4Gg1SyAK/S0leu1UZ8BqAz3Sv13COgkdb/ONGI+GG+DzbpTl7XqkTHBnETheg
 Ctmkhdfskh68DTmdZwLixXQ5UEZLLuwYrfpzSNihmMCd6l9f6jW08mm2rzqXJvT46HZ/V7inkzG
 6MTF2qF9z34zcEXq6gEk+7kJSwOjLLzm9S7HKXCPJoYlHmWSwHK0stHjFZnqoZEeIIQUeErMBYw
 8fMMsRMzb6MRjhXRDT/tfZWWNtBkK5dSgtcM+VE0dMYHpkkrAo9/A3JpfH1uL2fyDUrXaWlKkgM
 An/EjAN/ISWps=
X-Google-Smtp-Source: AGHT+IHb2nDaZpuuLDYCMB8OgQpIPOzH5qjYQF7e2GQA2BixkyYhPNPbNmnuv3AfMNLL8WRXKKlc6g==
X-Received: by 2002:a05:600c:1c9e:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-4792af4047cmr95729225e9.23.1764926939817; 
 Fri, 05 Dec 2025 01:28:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8fe8sm7670787f8f.2.2025.12.05.01.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 01:28:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4305F5F7F6;
 Fri, 05 Dec 2025 09:28:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  "open
 list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v3] target/arm: handle unaligned PC during tlb probe
In-Reply-To: <aTI1VZHxicpycoLj@Jessicas-MacBook-Pro> (Jessica Clarke's message
 of "Fri, 5 Dec 2025 01:28:53 +0000")
References: <20251204203540.1381896-1-alex.bennee@linaro.org>
 <aTI1VZHxicpycoLj@Jessicas-MacBook-Pro>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 05 Dec 2025 09:28:58 +0000
Message-ID: <87fr9ps2ed.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Jessica Clarke <jrtc27@jrtc27.com> writes:

> On Thu, Dec 04, 2025 at 08:35:40PM +0000, Alex Benn=C3=A9e wrote:
>> PC alignment faults have priority over instruction aborts and we have
>> code to deal with this in the translation front-ends. However during
>> tb_lookup we can see a potentially faulting probe which doesn't get a
>> MemOp set. If the page isn't available this results in
>> EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).
>>=20
>> As there is no easy way to set the appropriate MemOp in the
>> instruction fetch probe path lets just detect it in
>> arm_cpu_tlb_fill_align() ahead of the main alignment check. We also
>> teach arm_deliver_fault to deliver the right syndrome for
>> MMU_INST_FETCH alignment issues.
>>=20
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3233
>> Tested-by: Jessica Clarke <jrtc27@jrtc27.com>
>
> v3 is different enough from the tested RFC that maybe this shouldn't
> have been carried forwards, but I've now tested this v3 and it does
> indeed still fix the issue in my testing.

I did re-test myself and figured it was only adding to the robustness
but thanks for re-confirming its working for you.

>
> Thanks,
> Jessica

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

