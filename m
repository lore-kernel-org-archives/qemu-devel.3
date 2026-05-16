Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1B6CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 09:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOBlb-0002To-Fa; Sat, 16 May 2026 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOBlM-0002Qr-Bf
 for qemu-devel@nongnu.org; Sat, 16 May 2026 05:56:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOBlK-0003vF-GQ
 for qemu-devel@nongnu.org; Sat, 16 May 2026 05:56:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so280498f8f.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778925408; x=1779530208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TdVA3u59WdBeSeDOLBQr8/7JWodvPyJEu6pAZXRDM7E=;
 b=eVT6DcO6f//PCvt1YsZ+EDkXICi3JPEH6DbfM81KTMebSuSYExxCBqLF2hIpnJ+6oe
 7GsgmTwOLqsu1Szji4g1N+R3nw0Huc7L+WHAP/Zv5oPsp5M40CvM2TBC1yr6qOcw+Pic
 6UX0K4Gr8Ts5L3YOUKfTJyI2d6D5x4jjOiF4beICyXIe5qN+SmKDtFDadLTuKeHo+ejy
 LzKJI0jtONhax1axRBQWAcH7uA6PzGNgA/MG8OHCPEL4ob3IZYfQk7UNdKYpI3348E6e
 OukLBYvUW1OI7us59rdHv6zpHhPFXVQdKKzN9QYW43BE/Boq0U4kwrGqcqBWJ8eloTS9
 39fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778925408; x=1779530208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdVA3u59WdBeSeDOLBQr8/7JWodvPyJEu6pAZXRDM7E=;
 b=gP56H6iamFbkWEOqpjDOKcSw9MnMfZQSLbFTHyePAPttHsacQ98hTJeOgptSsWp7EC
 C4f5BtImV19d6lYIbeEKgD9H4qXBfz6G1003OlsY9TauLvsuacXZtsm29JqO1L1mDVSB
 GEgfu1NjKq3xvaa9ksedDt5HdzjRaahX13oTg4XoCjXKeio084FKwNSEYIlR1vymdApq
 1eGkyBV59UDStY36IS8bWpD5u7I4t93enXSWQymt+UUgTFRZAEPbq8iaX+Ne2lCS1B94
 BCMEE0/vnScZhcByc4h2UKbvj4UrKUnSZOP0YeA3Ybq6fkp6rQAf9v0e9dUPaqGDsJSE
 3Obw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZIS0OtBsq1GR/B/KO0V7imGmrUViE8j57OkTODJEuL6ch3Pvxqbm5yyoO3Hc3I223aikAEN/XymBA@nongnu.org
X-Gm-Message-State: AOJu0YzQPfZPpOF6+q3smhwH+3NucAFbDjW0MrYwKgtGG5ZRH2hTEewt
 F0tICptLlAPo+UIm1MeO1VxA2V6h/H2HgVRQf+tS6aqkJktFWx5LwCHGJeesYodCnKY=
X-Gm-Gg: Acq92OGLkRAMUbYRfR6Od9at/1d5I+iKIoulOvmNeBzKSUTHq26b9qsaQYv+7wJPUiz
 Out1bsJ1dwFk2pKn/p3gIzf4kWEY5lCewJAWN4EV0kbNh4DlWxug+o4Pk5AnUchiN7wN4YdOH1N
 tXS0S2FeUFIv4cA1Bf9qT4qZ+xQgt2luLPUTxIg5XYu/uhVs5j7WOHqRf6umU8Vw1+exOwkkCU0
 CA7W1AoaPgJsWbNzzrjJ2/yphzbXgfPW75L4BAmh2pTftbdPMPcnT6gc33/HF8boO09iX9M1eNa
 uj+yd9H4QXPZJI3KyRsas9EA25TgpbkxFdEqYsdKohbteruZ1FeBJ17CghW3uzsJdAke9ucFjL0
 XY8BYJ9yAb1B91jr1NEoZiPsNjZaBPBin7iEO8EfbYKm8AijY2bffG6hqtCyX3yWxkBbkfeK0fm
 nPJ5vPMYNjsEHhKe1VOUq7fAcih5kVsLf3MW/N1tDQQfTcuO72Inu+NaKIHxsZT6xvXsIbjZL3e
 XIYl1gNuVIEKVM=
X-Received: by 2002:a5d:5d01:0:b0:43d:73d4:b34 with SMTP id
 ffacd0b85a97d-45e5c5a10b0mr10724159f8f.16.1778925408202; 
 Sat, 16 May 2026 02:56:48 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17ec2sm19224183f8f.24.2026.05.16.02.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 02:56:47 -0700 (PDT)
Message-ID: <76f7c2be-2ce3-49c8-820a-ccb09112d7a0@linaro.org>
Date: Sat, 16 May 2026 11:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] hw/i2c: Add DesignWare I2C Controller
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Chris Rauer <crauer@google.com>, Hao Wu <wuhaotsh@google.com>,
 Corey Minyard <cminyard@mvista.com>
References: <20260516004206.169035-1-npiggin@gmail.com>
 <20260516004206.169035-9-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260516004206.169035-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 16/5/26 02:42, Nicholas Piggin wrote:
> From: Chris Rauer <crauer@google.com>
> 
> Add a model for the Synopsys DesignWare Advanced I2C/SMBus Controller
> with sufficient functionality to be used by the Linux Designware I2C
> platform driver.
> 
> This IP is used in the Tenstorrent Atlantis RISC-V SoC and will be
> added to the QEMU tt-atlantis machine.
> 
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Chris Rauer <crauer@google.com>
> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> [jms: rebase and minor build fixes for class_init and reset callback]
> [npiggin: changelog, code cleanups and fixes as-per below link]
> Link: https://lore.kernel.org/qemu-devel/20260507120524.111056-1-npiggin@gmail.com
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Corey Minyard <cminyard@mvista.com>
> ---
> This is a re-submission of the model with Chris' permission, with
> changes to rebase, update to QEMU register API, several other
> code improvements, fixes, and cleanups from reviews from Alistair,
> Phil, and others.
> 
> Thanks,
> Nick
> ---


> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index 1a8ada1fb7..d9560852a3 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9
> +Subproject commit d9560852a34f156155b3777745baa0d96d553f22

Unrelated change :/

