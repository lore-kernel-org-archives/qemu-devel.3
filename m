Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FF9C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebGa-0000mk-0q; Mon, 26 Feb 2024 08:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebGY-0000kh-4r
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:43:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebGV-0005WC-Fa
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:43:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a7b68809so3990665e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708955010; x=1709559810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p5V6T/S23ro90/XXslrjXWQ3eNACND7aZH/oW8xf9V8=;
 b=SPgkj17byEVLFWVdrcAexxRnGPd0NloCPN4VXMAHkwRBSvaBP+a1z7iTD+VFtNz1OR
 dkOBrGN+knH3prV/2pyY5JxEv1M005YwaVC0f+P0FK1AnZU12Mv6cMrBvWouwXvdL/MG
 nueYL3k7GkMmdHvmid5uXnQFTHrsTuaTwBXA7ANqF8HydEkd+8SiRYOeHh9OD+WC/Tdd
 PAlpmsNdtLD8Sf3fyIVY0JhDhltA3uC/MPCOWKzMEZ/SlxYYsq2UPLUiyBhc+zI9N1pY
 +L8S84P6VbaR7jSzjH5u8/SUy5vdSIsKzzKRzPScNSXRoIGZ07SUZrscTH5uCHGX2ZSb
 36Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708955010; x=1709559810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5V6T/S23ro90/XXslrjXWQ3eNACND7aZH/oW8xf9V8=;
 b=SUVMcY2ef3Tzgn5wY7jQYs3HnI1S6sJ4wFkEZ6SHEFKkZ0O8jeE1HtEFFpMgBjHwWv
 aZBPKB2DBYkFWQJe24Vnr+OPVbWfahSZf0ZtjxowyQJx2+RJ0EkCaN8CSFsclojteI8K
 o3Ap9py1ZGb+9AugCv5oIIUhfuiIo/6RqI5DgPUlAuzs84sktEP9N6mwdOPAJzvt1Yo+
 sYsAad4OzYWTuxVijq0OkeZWyWKn0pbNv1FnW+8oaE63w7/5MbXXgO9LmFnM6PuxPtzb
 0/jNxkV1nlKdV4ta6xYud03NlqLgoW4roQ2HGKDxKsSpXCAd4GS1NDRoSFJgDtBgnj/Q
 p4JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm2HiI1AgMP6eXG0xx8X2YAyow+0BfUgyNf2sbSxl9+vR8uGU0zkURqVEgEaufQIBqay6iKoj5MdO7lJox+8ZcaKupq0c=
X-Gm-Message-State: AOJu0Ywl5DPd7DbRBPWVBLCtR1xomP7gEujCvv3TczQ3WZpCOBEC/Zp7
 AstoQiHp9wJRJkwXGNQ6bfV+lxynTvBiF11RjICKcCB6jZdH/XkoBLzkZ6CTIP0=
X-Google-Smtp-Source: AGHT+IGIZ9hBmiQMOxOtbvM37It0r5GwzKWfjr3s9MfGnEWZF/Iqq2k1mM1bmr/Bhd69ktMmf2uwxQ==
X-Received: by 2002:a05:6000:110:b0:33d:ca9:1fab with SMTP id
 o16-20020a056000011000b0033d0ca91fabmr4687694wrx.5.1708955009696; 
 Mon, 26 Feb 2024 05:43:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 d3-20020adffbc3000000b0033dd2c3131fsm4573228wrs.65.2024.02.26.05.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:43:29 -0800 (PST)
Message-ID: <5dfafae8-c429-4d2d-9ec4-240b8d4290ca@linaro.org>
Date: Mon, 26 Feb 2024 14:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/ide: Include 'ide_internal.h' from current path
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240225171637.4709-1-philmd@linaro.org>
 <20240225171637.4709-4-philmd@linaro.org>
 <feffd329-59e0-0291-0dd6-76a625da190b@eik.bme.hu>
 <878r37lll6.fsf@pond.sub.org>
 <fd0fba89-cd93-4113-9f3d-2ee20f2217d9@linaro.org>
 <90219760-aad5-82b2-41aa-be563f52fdf9@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <90219760-aad5-82b2-41aa-be563f52fdf9@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/2/24 11:50, BALATON Zoltan wrote:
> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>> On 26/2/24 08:40, Markus Armbruster wrote:
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>
>>>> On Sun, 25 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>> Rename "internal.h" as "ide_internal.h", and include
>>>>
>>>> Is there a convention about using underscore or dash in file names? 
>>>> The headers Thomas added are using - as well as ahci-allwinner.c, 
>>>> only ahci_internal.h has _ (but there are others elsewhere such as 
>>>> pci_device.h). Maybe we should be consistent at least within IDE and 
>>>> this series is now a good opportunity for renaming these headers to 
>>>> match. But it's just a small nit, thanks for picking this up.
>>>
>>> This is one of the many unnecessary inconsistencies we're inflicting on
>>> ourselves.
>>>
>>> We have more than 3600 file names containing '-', and more almost 2700
>>> containing '_'.  Bizarrely, 68 of them contain both.
>>>
>>> I strongly prefer '_' myself.
>>>
>>> Zoltan is making a local consistency argument for '-'.
>>>
>>> Let's use '-' here.
>>
>> Fine, patch updated.
> 
> And then please also rename ahci_internal.h to use '-' to be really 
> consistent.

I'm sorry but I don't have time. Maybe fill a ByteSized task?


