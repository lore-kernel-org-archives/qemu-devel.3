Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA488CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzXt-0000Kt-Bv; Thu, 23 Oct 2025 13:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBzXe-0000A0-EU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:56:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBzXa-0003aV-Sn
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:56:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so10649995e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761242157; x=1761846957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+obvAx1Tk32r7xzbZXaZN9kGErxtn5ECBBwFi5HAMI=;
 b=qM3LynL8lqk5CR8vvbsadkzN/s2+v0qOwQx/PK+7c42B17X3JpYp7hRdEqnF+K1mDl
 Rj6khGoQ5NxKYiR03RDJpjK5RQcZ43BevYDLoxKEm9EUXKi8PEqnFwGBNKfJ/kZMEqQO
 6EDY0ajrQmOxkYreLS+KdIv3Ltp5YIUbF+jrhQ4VzcNT+vqtrpGX9BPNbGk7MjdMMbg/
 zkCafGxpPzV66ZiKPB2FCQ8xrDwmwpgZEegl2vP6Lw0PvVdGQ/iL5u7BHVc86s4+E4DH
 gm0E70Q2mj2uw5i38P7My45FV9EItFlQAQMZU/cH5w5I+TvnP0vSh8Gp2S1nvpyyj/Sh
 9qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761242157; x=1761846957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+obvAx1Tk32r7xzbZXaZN9kGErxtn5ECBBwFi5HAMI=;
 b=u2SLwSS8dbUyO/7+H4hqlcjOSw2QKD35KFYqZ0ufeSa9Wgcfl6d6UKNJmvjdSoH70y
 lyg7ABpUmNYsx+ac207Wj6aBq8YMONWptkUDrIwYHwTPQgYAmZ75/FeqOlR7Po+Yfp9r
 BPA2cEzY0vE6/vgwqXwYsdzDS6n+zVwFSEKlXgZyUzebIL3eIqtlz0gUpiXrFR2QdHGN
 mTDDkB6E40N7kFKnW+HodCubwCgs6ypV7fy9uvsWAX3YckbxI/qboTVjwBu1tDCbxmzF
 aoTfXCmcG8MvsiQ2Nihngn7ox6p7eWHvC23yXUqb+Gnl9/Qd23hdYqsyRB0JDqaChTqO
 40gw==
X-Gm-Message-State: AOJu0YwaGTfmgUSfTQjSQDiOw/Ew78hR8xFGlzTnFVYLFOi1DcLtBz3e
 pTTH5mwP2niYMXlYxeM8iCtWwNYZHaL3aheUoKb2lqVoR4UjZ6PCvClWPt6/IKJVlyk=
X-Gm-Gg: ASbGncvczPIE9Z5ojMInwqQO9TedaF560EoMRyOFrZ4yE73J52jG/riHW1+LU3L/zsD
 NibH26Wi6x30myhzJPqSFCMOConURZefGe1jpIS/YvyRVg9fNTZkAaRmA2qVbhQCJdeJsL5NZEq
 6D1VD6+kcKMqdntjd3XHpybxqUFmn//CHBzejLmHVne+Zmria5l6cRzZ56Emz1Ru57LfJ2iUwen
 TkL9+S9RGBZCCkXoypnQMsidcw/m5+OGWleBH1R5tz7+nXIDFXDiTjqVnbdsl0T+n6vQoYLLNSs
 aGmFEgDjZPK2CW6TwYNZtiUoBfXPRE3cJa6L1GUt0qrCKflF5VPABqa/Fa0hUXWvx7mP+tCaHNK
 lIeE67S+Dt8FfHm0R5Qn7DWEKeP5CMQE2xJJt4oUs1CPwZ79pgF1GjqTBU10EZc63sje1whJobe
 O2+hQJOndaI8J8vI1CVNk9MjOpeSwim0712qmnkqSqtoGvcfLA2YEJGw==
X-Google-Smtp-Source: AGHT+IG9G8hVnRMST1Se76EHB0N/FxL6Rq199W3AGiwl4DKoNoEYrwTDa9Drjc1b9Kj26Ey76odB0w==
X-Received: by 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-4711791c8d3mr202012915e9.30.1761242156732; 
 Thu, 23 Oct 2025 10:55:56 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494aad668sm67276875e9.2.2025.10.23.10.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 10:55:56 -0700 (PDT)
Message-ID: <0f154c4e-0bc5-403f-a8fb-06090957b0e4@linaro.org>
Date: Thu, 23 Oct 2025 19:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/riscv: Use generic hwaddr for firmware addressses
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-1-8b416eda42cf@rev.ng>
 <1f8876eb-9e57-4102-8d04-3de29c4832f9@linaro.org>
 <gfywynwh3pl4emzpepos7r2usnapgwdro27qxa3njqo22rbuuj@ydxpxmfa3lu2>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <gfywynwh3pl4emzpepos7r2usnapgwdro27qxa3njqo22rbuuj@ydxpxmfa3lu2>
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

On 23/10/25 19:14, Anton Johansson wrote:
> On 15/10/25, Philippe Mathieu-Daudé wrote:
>> On 15/10/25 15:27, Anton Johansson wrote:
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    include/hw/riscv/boot.h    | 20 ++++++++++----------
>>>    hw/riscv/boot.c            | 22 +++++++++++-----------
>>>    hw/riscv/microchip_pfsoc.c |  2 +-
>>>    hw/riscv/sifive_u.c        |  2 +-
>>>    hw/riscv/spike.c           |  4 ++--
>>>    hw/riscv/virt.c            |  2 +-
>>>    6 files changed, 26 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
>>> index 7d59b2e6c6..d835594baa 100644
>>> --- a/include/hw/riscv/boot.h
>>> +++ b/include/hw/riscv/boot.h
>>> @@ -43,21 +43,21 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
>>>    char *riscv_plic_hart_config_string(int hart_count);
>>>    void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
>>> -target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>>> -                                          target_ulong firmware_end_addr);
>>> -target_ulong riscv_find_and_load_firmware(MachineState *machine,
>>> -                                          const char *default_machine_firmware,
>>> -                                          hwaddr *firmware_load_addr,
>>> -                                          symbol_fn_t sym_cb);
>>> +hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>>> +                                    hwaddr firmware_end_addr);
>>> +hwaddr riscv_find_and_load_firmware(MachineState *machine,
>>> +                                    const char *default_machine_firmware,
>>> +                                    hwaddr *firmware_load_addr,
>>> +                                    symbol_fn_t sym_cb);
>>>    const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>>>    char *riscv_find_firmware(const char *firmware_filename,
>>>                              const char *default_machine_firmware);
>>> -target_ulong riscv_load_firmware(const char *firmware_filename,
>>> -                                 hwaddr *firmware_load_addr,
>>> -                                 symbol_fn_t sym_cb);
>>> +hwaddr riscv_load_firmware(const char *firmware_filename,
>>> +                           hwaddr *firmware_load_addr,
>>> +                           symbol_fn_t sym_cb);
>>>    void riscv_load_kernel(MachineState *machine,
>>>                           RISCVBootInfo *info,
>>> -                       target_ulong kernel_start_addr,
>>> +                       hwaddr kernel_start_addr,
>>
>> vaddr?
> 
> Maybe vaddr would be more suitable, I went with hwaddr as
> kernel_start_addr is fed into load_image_targphys_as()
> which expects hwaddr, and hw/arm does the same.

load_kernel() tries to load a file at a vaddr; when it fails
(because can not be parsed, i.e. ELF) the fallback is to try
to load as firmware at a hwaddr. My understanding anyway...

