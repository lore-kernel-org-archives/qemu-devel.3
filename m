Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2130FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvjY-0001Qh-CC; Mon, 22 Apr 2024 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1ryvjX-0001QS-22
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:37:31 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1ryvjV-0004ez-8D
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:37:30 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-572146dd1c8so736080a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713800246; x=1714405046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UhoLDngw5CiwXftE0s78MinMLVHsaWibEwQOSgqzh2w=;
 b=dXuJGRIsBvOqhvrcjIkFdNFbQGmwSfM2VQrTlp8AeoTiWfguXSZH2RBZqadzol7Hno
 TB9WVxiywp+1nFNbMwqYgbcaVnNgea3H8Y7Kk3kXU/MnNfAIkejV05hLsVN/o70sbdvG
 T87MbP+eZXlbtEvO6aiESNNApmBzqKyK3Hxi+wj+zJV8tuO6LWdP5j7rqjbUGIQCA6la
 0UPcZki/wgZNIgjixEjOuPprZ8iun+LQ+Vck+u9Np9Wv8sl4wc3WbbhzQC8pKIi4mLN/
 xxw7UsQfwuF/axIpO/4EcfbksuxoivdTePgyf0FNjjRyoxJZfwV1SYxWYQdBOFI92C+b
 pdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713800246; x=1714405046;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhoLDngw5CiwXftE0s78MinMLVHsaWibEwQOSgqzh2w=;
 b=lKCmpRnoy55nb8SE7VK5MLXvGwmbVD0kPrMozguFfG6KY7C2v26+ceznX3JxitEb5p
 lGjwsHllM4my44EcK/pQjAvrKOMS4v71+ryVhy1Wja/zucj0VMEwaP813scDoP7x2VvI
 fLhrDw3ft1Nr8lUR6Yh6GLwHKDKtD1hcuuv0AFTAKCVzmpTvIlVb17fU33gT2d8kseMX
 a+a23cAIVDCaKoFSL5lxK/aUG6Q6oM+5sQmtdvPeVtenD5iwcdvUsvLoe7JHbMhJwqlt
 SKIXu3DmWoJ4WAq3pnw7hdDlqT8uDfMkuXRQQoNIWL2eO6w6v58uIzOdtarWQtUTMKyT
 jmwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzogBoI9Ww53XiolfolFsnlBGEGrca0hVG3lvO/7zsIINeV4mDk6ybBhCOaiLssEemRMtFyvP/8hmhR4nuwgvz5Z6+qOE=
X-Gm-Message-State: AOJu0YxWlhf25JpdEUThCU6Im+L1Y+lejKVN8CU9CxOSfguc4Y6jItXy
 nZYeyAMjmPd+jWQL+O9ktGN7IlmNiYNemWujKHeYwA3ybeuJJ7TQP4doBrt0hzc=
X-Google-Smtp-Source: AGHT+IFtn696B+mr0uCUHntIMkRGHogWmiTkHOZ8NT+k2jgONKi8Fff02IOSOQZ+5P+K3WlpJ46dgQ==
X-Received: by 2002:a17:907:9710:b0:a55:b36e:3e15 with SMTP id
 jg16-20020a170907971000b00a55b36e3e15mr3790168ejc.6.1713800243449; 
 Mon, 22 Apr 2024 08:37:23 -0700 (PDT)
Received: from [192.168.200.106] (83.11.0.31.ipv4.supernova.orange.pl.
 [83.11.0.31]) by smtp.gmail.com with ESMTPSA id
 gc24-20020a170906c8d800b00a55ac217235sm2108402ejb.90.2024.04.22.08.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 08:37:22 -0700 (PDT)
Message-ID: <fa0465a4-6604-4ec3-af45-2d329ca513fa@linaro.org>
Date: Mon, 22 Apr 2024 17:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
 <c84bfac7-5fb5-4fca-90a3-93adb40bcf3c@linaro.org>
 <CAFEAcA_PWyu=ca-S=qwePDdGqjX95k3oQ+BJUZc541YEyV7i2w@mail.gmail.com>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA_PWyu=ca-S=qwePDdGqjX95k3oQ+BJUZc541YEyV7i2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52f.google.com
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

W dniu 22.04.2024 o 16:18, Peter Maydell pisze:
> On Mon, 22 Apr 2024 at 14:38, Marcin Juszkiewicz

>>   From what I see in EDK2 code we read CNTFREQ_EL0:
>>
>> GetPlatformTimerFreq() checks for PcdArmArchTimerFreqInHz variable which
>> sbsa-ref has set to 0. So it calls ArmGenericTimerGetTimerFreq() ->
>> ArmReadCntFrq() -> "mrs x0, cntfrq_el0"
> 
> Yeah, it looks like it's TF-A that hardcodes the frequency:
> https://github.com/ARM-software/arm-trusted-firmware/blob/c8be7c08c3b3a2330d54b58651faa9438ff34f6e/plat/qemu/qemu_sbsa/include/platform_def.h#L269
> 
> I imagine that value gets written into CNTFRQ by TF-A somewhere
> along the line (and then read by EDK2 later), though I haven't
> quite found where. Plus I notice that the TF-A sbsa-watchdog-timer
> assumes that the generic-timer frequency and the watchdog
> timer frequency are the same, which is a bit dubious IMHO.
> 
> It also seems to be hardcoded in TF-A's support for the virt
> board too, annoyingly.

I looked at it and it seems that TF-A can just read what is in 
CNTFRQ_EL0 instead of hardcoding the value.

Submitted patch:

https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/28313
refactor(qemu): do not hardcode counter frequency [NEW]

