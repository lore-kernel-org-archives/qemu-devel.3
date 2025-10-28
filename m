Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B3CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlpg-0006Gd-OI; Tue, 28 Oct 2025 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDlpd-0006GT-6V
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:41:58 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDlpT-0004Im-FT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:41:56 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b6d83bf1077so256591766b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761666101; x=1762270901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WhEgdXYWOCMpTXbdV4K3qyicdeKHvfSYotTmYvSaLr0=;
 b=s0ID2jg9VTX8s0FnzMN4V4iwrfV8xJ2Dab4CryP3FCBf27vszUgEn7WT2cHv3qQ+Cx
 pSwmFQGcpeT9zkZaMKG35B7/nbhOpLHjJ5OJKb5k/0FOVjKWlvLFCpKlqso6avyLbdWx
 UO/NcyX1otTjbmP/HbhHblNwLFhUbLzBDNLcP5QChIOVfGSFhZt1QbTSdK/jkURFWFul
 He/xvp01EJ+QcGjMP8yjKsVPDh6fQLvBw/Q7/bJL7TKmctoLZouZgbNeKFIi5tmlw2kp
 uZY5i267G2GoCCRgQVYzS53InXHrgBNZT6rZmbf0BY6WnP3CJ6Oagz3EVB+C9GU1wD2p
 +AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761666101; x=1762270901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhEgdXYWOCMpTXbdV4K3qyicdeKHvfSYotTmYvSaLr0=;
 b=ZLxyaqy0X0zsUWaGlDIlcApgVBupPlTC6a9YrAw6w27nawZ1pAbO/x0kzqNZIjmlFj
 3Fs+vklrgTeKrR2JfIZ1unGsdrZBu7yR1qgSaoMhUm/+2WzDXP8Rax3z43s9dtNGECRS
 dJqwga/FA6fhsithsuNE3UkgMg/3SdsBpwYL283Z5cRyJoGq7TL1cAVU0jmloG8Sbu5l
 dkc4OdXyiCnATlvg4tF66DtXHSa3GAdUCWejfl7ZnRSenNjbi5L0oGsu6rk5wOPUCFtd
 9zub9tUZc9SvNRblCThWGN2APvlxHdndH40EZfxiR9HmXil9gMoVKyBZgxoFS1T7fafx
 IYTA==
X-Gm-Message-State: AOJu0YxdndAhgaSamQUAMK9Xhk9aV/qjPba7/3Lh51unFd/f+KxPNUjg
 GQZ6XToI5UzdcKF+6hnQwDWXi4Qa+hMd5IU2pkohzMPWR0/0fJdh2G7iag19NF+UIwI=
X-Gm-Gg: ASbGncvjrTLRG0BthlloOiyY9NpS8CU4btUn/2Q3K2B/si74cX9d0Ybx91/K7FHvOjp
 vDYO6HZsKDsiB2+n4vmMOp3bCtYRkaSQDR+P51nCHITyHYSQT3YnpHRd8yC0ZcuEmr9ii/EGeeZ
 NkbjEdLQzIqZS3rAuksDT/gePF12eIzmYEAFz3o/1WJvv9niVxBmF1HqZkkBIew+ShuWAV2Jqzk
 wIfIdZ4BhvSLkzTaaDRbyJiMPMz+oFW44TKeGcKoQ2X+FckvHZWgDp+HeStWeywIVJuNGNVrJqh
 YKl6a3I2sT2HcEFTamOblRMr9L7iDKsBv7Eau0BQ9XnLIoJdXysnLD0wyYhUrHa6a6N6H3a6MrP
 wrpBxe8K9wyfWtTnqMPh+CAGTcbzfSTH/64VwK4MJLNL790ZVh5GM5kNENoXBV3ZUpcYoQ5XUA3
 ALVSuo9GlPmQb2NLZP51iqxE4dPEg9XYbOhJUY26IdKRA=
X-Google-Smtp-Source: AGHT+IE/puHvSMWEyCjrzg4pbCHIK1YQGEGPCiK0Sh6xj/E+FqUaE2OiocE8gFuoCvht5swqRzyejw==
X-Received: by 2002:a17:907:2d86:b0:b6d:3ad4:ecb5 with SMTP id
 a640c23a62f3a-b70328da2bdmr707566b.40.1761666101171; 
 Tue, 28 Oct 2025 08:41:41 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f9a0fsm1117874166b.50.2025.10.28.08.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 08:41:40 -0700 (PDT)
Message-ID: <0d2fcc9b-ad42-4668-a8bd-9ecb70c9822e@linaro.org>
Date: Tue, 28 Oct 2025 16:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/59] target/arm/hvf: Consolidate
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
 <CAFEAcA-3SzHPmLc-huMnyNbZBnEwi5+fbPNuvCYJcvY7gYboEA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-3SzHPmLc-huMnyNbZBnEwi5+fbPNuvCYJcvY7gYboEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 28/10/25 14:10, Peter Maydell wrote:
> On Tue, 28 Oct 2025 at 05:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Missing review: 15, 18, 26, 32, 33, 38 (up to #41 could be merged)
>>                  42, 43 (up to #49 could be merged)
>>                  50+
>>
>> Since v2:
>> - Improve host page size/mask uses (rth)
>> - Remove cpu_test_interrupt in hvf_wfi (rth)
> 
> Richard found an issue with patch 32, so I'm going to

IIUC this is not an issue, just a worry about performance,
whether getpagesize() implementation calls a syscall.
Anyway I'll cache the value locally -- or better, maybe
have qemu_real_host_page_size() doing that --.

> take patches 1-30 into target-arm.next (patch 31 is
> reviewed, but conceptually part of the next few patches
> in the set which use the new functions it defines).

Thanks, this is really helpful!

Phil.

