Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA641C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redVB-00069M-Gd; Mon, 26 Feb 2024 11:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1redUh-0005yk-Pd
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:06:19 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1redUc-0005s3-5C
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:06:19 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso4284140a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708963569; x=1709568369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94ItvZTU8UjZJXpr7paETTd3/ZnKh3sFlCRaL5V+peM=;
 b=dnGYXSaWHYyuVjRL+wNn8lAfPiuLFWK6vBRKhqG1R8MIwilG5BuW91L6DVYWH1Fh53
 EnswcAe2Ei5UitacpIGMYZyL/+T5lik09JH99wCTCrBdkQJqUvsIUfulQaQiObbeRcm8
 reOPCTxQk5kl3Ed9Z6AEhBTMi460oqwLupaeVOAlVcZpFfrQa2JVX2WhAhXVq1neoK9o
 aETe67AJ28AID61ukeUUDvCicmbh2mqI4IqJ6srrz66BcfyQavtMQZ4R8v9wan+s1D9H
 4L8Q+paG8NcqyD2pbozjowiQdx+RLFDxGFfm5XPmSqDFIwrQ2+JHmJRBZ1NQQetisXMl
 rB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708963569; x=1709568369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94ItvZTU8UjZJXpr7paETTd3/ZnKh3sFlCRaL5V+peM=;
 b=W7lzPaq1PUZCUpYXOYicHF/ksUSGvhExEM+ChuSrIpQFGuAikroZvV2AU6+T7+0mIi
 D2CDv/UDH2EnhtRCyD2QBzfwuJCExV+mRXCULca8pAGeWLjhi8KGkmmleSc2g1qgPtct
 h87iVEqDhXaLt+Wzr4eTyDylL3elFDwRAbgs7OFo6mJZCdJIMbgbFyxNgvqCfu2V1HbV
 bCMkeOYOhsNCqKDdPBV+3J0fDiy7gr4h+ojm5fpqqKJrosYGlaf5VE09BABMXZXNAKlz
 fPSC03Nca/S/NVgJrdGFUufkUAXgASAIy7PorwQxy3eKwktebvKi132c+JgRwW3+tphj
 K+eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjFHWsCgF4Sb0K9vd51uEU0w1VVsBE7H30HX+Jtt/VzZUkQSil+NTr4Iao07oQq3eOc8/CF9PAVEWvDRt29TyYSlxAjXQ=
X-Gm-Message-State: AOJu0YyI1tjcwxur6ZiRmQJuwE9Gpp1XcAADUKZFXs+QTRtPqyWRubUg
 vWjhAu2gL2eDgOhVLL0BwHIpRDY/E8MSkjqA173pA6SSfZdTdgebpD440EdozrA=
X-Google-Smtp-Source: AGHT+IE2XIW2htb9puM1DnKluxB11PO7mJ9eojqeMxCAC5+767YmeA7M20n8EcNL2l+5TeyjagtVjA==
X-Received: by 2002:aa7:d31a:0:b0:565:dd87:9811 with SMTP id
 p26-20020aa7d31a000000b00565dd879811mr2617596edq.5.1708963568753; 
 Mon, 26 Feb 2024 08:06:08 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 bf9-20020a0564021a4900b0056626973bc1sm104394edb.38.2024.02.26.08.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 08:06:08 -0800 (PST)
Message-ID: <df5f7f10-41ba-4c2e-8d50-9d35203d940a@linaro.org>
Date: Mon, 26 Feb 2024 17:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/41] Temporarily disable unimplemented rpi4b devices
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-12-sergey.kambalin@auriga.com>
 <2ab7b523-816b-409b-a58a-f09e3f71ff8e@linaro.org>
 <CAFEAcA-WwWQnAQTmoCixaW5aeRWrdx__YoSHp_VyGEbk-rOkpg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-WwWQnAQTmoCixaW5aeRWrdx__YoSHp_VyGEbk-rOkpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/2/24 14:39, Peter Maydell wrote:
> On Mon, 26 Feb 2024 at 13:35, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 26/2/24 01:02, Sergey Kambalin wrote:
>>> +static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
>>> +{
>>> +    uint64_t ram_size;
>>> +
>>> +    /* Temporarily disable following devices until they are implemented */
>>> +    const char *nodes_to_remove[] = {
>>> +        "brcm,bcm2711-pcie",
>>> +        "brcm,bcm2711-rng200",
>>> +        "brcm,bcm2711-thermal",
>>> +        "brcm,bcm2711-genet-v5",
>>> +    };
>>> +
>>> +    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
>>> +        const char *dev_str = nodes_to_remove[i];
>>> +
>>> +        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
>>> +        if (offset >= 0) {
>>> +            if (!fdt_nop_node(fdt, offset)) {
>>
>> Peter, I remember a discussion where you wre not keen on altering DTB
>> for non-Virt machines.
>>
>> Since these devices are all implemented at the end of the series, why
>> not add the devices then the raspi4 board at the end, so this patch is
>> not even required?
> 
> I'm not super-keen on it, but as you say it goes away once all
> the devices are implemented, so I'm not too worried.
> 
> Doing it this way around would let us take the first 11 patches
> in the series into git now (they've all been reviewed), which
> gives us (I think) a functional raspi4 with some missing devices,
> which seems useful in the interim until the rest of the series
> gets reviewed and committed.

Fine by me! Sergey, don't we also need patch #39 (Add missed BCM2835
properties) to have a happy Linux boot?

Patch #17 "Implement BCM2838 thermal sensor" could also go in but it
doesn't apply cleanly on top of 1-12); maybe Sergey can send a series
of "patches already reviewed" on top so they get in for v9, postponing
pcie/network for after release.

Regards,

Phil.

