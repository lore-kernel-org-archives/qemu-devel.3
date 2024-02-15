Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B693C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radcA-0000Kf-Is; Thu, 15 Feb 2024 10:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radc7-0000JW-2q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:25:27 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radc3-00087C-OG
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:25:26 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so412098f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708010722; x=1708615522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jhRQsAfr4ekZEkJ8DDbzUQK1c7Hjd/Dzn/FvQXB9GF4=;
 b=kSoWwjymiOgfWfqel/j17t4H+IsRoIUjMEOqucUrJI7HdznoHt+mFUWn/3YjZIisnV
 /DkWzzQacI9kyqwItYr8GePM/KS+01SCDjRVcKQ/Ah1cLsULiq06z4t4m6gKaCfTluWO
 nPv2ThECWeinTrja8TXSpDapKXi7OGVkpMU2fucyS9BAaxKuDCBZ3EmGlpMbI55I4MM3
 mNfDzN3TV02pLXCcCHDivHr1wt0JS0uioHDY7POqmDExCNRsXdQb/Wc6hwOZn1iHxZ5z
 W9oqH/j+CmEnywJ0UBwIXpq6RSgyLnuZc4lcHAk9giPpx84JeblagQTOhPYPs97xL7xn
 /VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708010722; x=1708615522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jhRQsAfr4ekZEkJ8DDbzUQK1c7Hjd/Dzn/FvQXB9GF4=;
 b=APsWh9vCnTNGIEcuatYygzew4Oo6oKjawvAlPnUVgX0RbZ9PLqpzT75C5vytnePhrN
 bVz0rXjU+CIvujVLG7rDmG+AaSK/JGeTAL7UlkUhzehvdDq0zy5pT+bUVqp3lZir+7nF
 faD58/p2VgN7CRHqzXyLeQr31FsThAPlxTtIXRpq52SuMJ9wYbHPMr7sYvS4KdPRuWG9
 qJdp4Zr3sMeo/zmTCw1QHaRFTogz7S6az1WOZ/vcWPd96oTO8mh5TY3AJ3YngkVOSe+c
 dsoL5MhA1bCD2cVbnPNopM5FjdauxoIyhNxa62XRoIntXhWT3ogcksMaE6Ekw31qzqyR
 JfgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR9F5+6pRlytCIz9X9EaHPMjSNzn0pSlW+bJ+Iu+zGSTfDDFko7U9/Sd33Id+OD5LJRBAUbup0eM+E8b36YDPVAkm8yBk=
X-Gm-Message-State: AOJu0YywIiQzMpLQpIri2lklfLgp9kYM+jYzgnetri8qY2z/pQ+VIXTD
 l58XyKe9zr8uULVjObpfKRUXusAFZTMv7xvO2csjQ1bt145dRzR6Qvtm/7JbFRg=
X-Google-Smtp-Source: AGHT+IEapwBRj3h1NPAu3umyhhsF0wDNnYLXjJgCJrBjjkg0sa4JI5Cs7T3apUovrBNmGE2iIoqN3g==
X-Received: by 2002:adf:f892:0:b0:33b:6129:9d5a with SMTP id
 u18-20020adff892000000b0033b61299d5amr1983713wrp.52.1708010721817; 
 Thu, 15 Feb 2024 07:25:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s13-20020adfeccd000000b0033b7ce8b496sm430245wro.108.2024.02.15.07.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:25:21 -0800 (PST)
Message-ID: <5927419d-2dcb-470f-9b88-7320577d1a27@linaro.org>
Date: Thu, 15 Feb 2024 16:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] hw/ide/ahci: Inline ahci_get_num_ports()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-5-philmd@linaro.org>
 <f2dd89fd-db4c-410a-bcdc-2a117e4f633a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f2dd89fd-db4c-410a-bcdc-2a117e4f633a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 13/2/24 17:43, Richard Henderson wrote:
> On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
>> Introduce the 'ich9' variable and inline ahci_get_num_ports().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/ide/ahci.h | 1 -
>>   hw/i386/pc_q35.c      | 6 ++++--
>>   hw/ide/ahci.c         | 8 --------
>>   hw/mips/boston.c      | 6 ++++--
>>   4 files changed, 8 insertions(+), 13 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> As far as it goes.  But it certainly highlights that
> 
>> +        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
>> +        ide_drive_get(hd, ich9->ahci.ports);
> ....
>> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
>> +    ide_drive_get(hd, ich9->ahci.ports);
> 
> ports is always a constant.  Or perhaps that's only from this PCI usage?

I'm just moving code around :)

I'm not sure about this assert, but TBH I consider ide_drive_get()
as legacy API (pre -blockdev, only 7 uses in the tree, half from old
boards).

I'll let that constant cleanup for later.

Regards,

Phil.

