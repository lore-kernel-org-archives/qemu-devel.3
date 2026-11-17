Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DF606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ha0HqWw+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNtY-0008Bb-Pj; Tue, 17 Nov 2026 13:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTNtW-0008BR-WF
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:27:03 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTNtV-00042O-9v
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:27:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ee1b65fdbcso323275ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794940020; x=1795544820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MrZsLKiR0FanCj01Sbjq0DAATict0d6bL3bKKpfaac4=;
 b=Ha0HqWw+OJcXq5OiO58MgQQTxDELfA70wqQqFiEfDT2/8UCKJT3IMtYBaPn9X/UzYD
 yHcvwpC3c1isw0pWh6lxSDea86m6l93l4GUjzmyvpqDWL/DIHE6HQsFG8BZBW2jI4dZ7
 9JTRzC24nv1hxCFzq7fQFObVCRHuOwcKeE10nMrwjGr83Qot4TjM4btaJA7UFRHv14EP
 Zdsz/HzC3aeRxtg+YzSpuTCnRsSDGmpTHckv3YY+ZYHu/qE+3e7dnyp5mHh3+ZVhiCdw
 WQLLvnpDJYuUuuTrSikVe13j3vTh6VISSx5M1PfXPEfiEA6ZSwoQVFa3yDLvPR4pO8Ia
 gF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940020; x=1795544820;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MrZsLKiR0FanCj01Sbjq0DAATict0d6bL3bKKpfaac4=;
 b=gf/KtaiALg4XX0pHDso7w5vGRAJptsgHDrS2SCRBF6zaMVxs1hBM1NltYGvx5U3FNV
 3kW4attSTMJg3dZwSnnmhjVgnfUNjR4kxeL18vvwRoZaw753x8cfgnG1jiQBRUv8t/oT
 xeh7Ze2ErwLz4fQMdnZiEvZIcnsc42DvPZK+5DXL6I+6bUGW1XeO0K5GdPXXf1RM/fBl
 NKvQCrJG4dQwWhJwsELbGxFfEgRHLPZJSJ4cDZAHHiGZFIvMVoi9/2bHcUJguJbSd8on
 mWmDrnvHNl4KWFO5iOtNvfXXMI+K1M1FQV6jg5qgqRmQeTE+4ssLJw+kawYBAdFAqp5P
 bUmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHhO4e+XieB5/P6DIM6/YqbSqO1lbzVNDhGmY63wJGjs3cm7jRk7fElLbE4fQj4wQb3I/xIHyVjuUFQ@nongnu.org
X-Gm-Message-State: APuU4Z9abrPzs75MbWdkNgTDYUx2E4Js3MPXMnziU5q+AmVCNn827YGw
 kupObfMYLIQDKneWqD/dRcmcAgcelj1rqxEQ2iQ/2mMzoJQ7E4OOG/JoHm8nNNke66c=
X-Gm-Gg: AZFdTZcgcaUfgJ+iIyX+UToZtqJqqWALLNeendCsXo1p9zKaJ/dhgXg24c1NhNEo+Xd
 o7kABFutdQkoUyUHvwmLTDVzPM7RaIBaxk6NX7gAXbj6JHSrOc90uqE2F7JYFQqiRxtuLXglaB1
 TRzFN4bGJdUPZeEwNI4A3lZuuSEb7ZLC8KwxQF3uKxOluP2tVwdcqyd5w2piOy+6qmP+JRNmiDu
 i8z/MuiUkiEwkkj5GIgMoPLEjaegxHTOizhx75J9GowYrWOICDsDAMt3Lxv0nxW18tJ3q2wiBs3
 atugqihS84p35obK5oDbE9E7vHLpuprHMBFoL3oE7dPlyC4DUb0R2XxdhmNYZTZErj1/1dEqHho
 HJjVqeP9lugPzQgPzDwVY7ujD9finel+L6dLLo63Jrkmtj82jDNlVhXGPo8f7BQgFfTtVh6A6vE
 T1XajbmThb4t3cqwBv/vuySoqfYES+HPedqod3ICfQnaX30qFQpSgVq01puUZE3mwWUGx5k/F8A
 QgYS3ohtd0NXNsCvaPAeYtJ6G4VOelaVHJxRki9ILC9XaVU086RBvOFXlu3CnV83nxErKkJekd6
 8ScKMm8IEnkCHNUbjP2IZBcgPiDGuNW9VG/3Kj/weBGc4EvRpfed6zn5S2X+WxieMl1+shY=
X-Received: by 2002:a17:90b:288c:b0:3b3:b0f4:1bf7 with SMTP id
 98e67ed59e1d1-3b3d07598c3mr244842a91.23.1794940019674; 
 Tue, 17 Nov 2026 10:26:59 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm175147a91.6.2026.11.17.10.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:26:59 -0800 (PST)
Message-ID: <a438e133-5e12-4969-9743-366bf18e888f@linaro.org>
Date: Tue, 17 Nov 2026 10:26:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Python patches
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20261116183045.118241-1-jsnow@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261116183045.118241-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 10:30, John Snow wrote:
> The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:
> 
>    Merge tag 'pull-nbd-2026-11-10-v2' ofhttps://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)
> 
> are available in the Git repository at:
> 
>    git@gitlab.com:jsnow/qemu.git tags/python-pull-request
> 
> for you to fetch changes up to 8ff6cd65b6e4a9944e54dd27aa3a72ebef8f93d4:
> 
>    python/utils: fix accelerator detection with annotated -accel help (2026-11-16 11:53:21 -0500)
> 
> ----------------------------------------------------------------
> python: pull request for-11.2

Applied, thanks.

r~

