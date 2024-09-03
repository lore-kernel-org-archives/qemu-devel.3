Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC29ACD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUFV-0000qy-SF; Tue, 03 Sep 2024 10:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUFU-0000pp-IK
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:11:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUFR-0000LJ-7v
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:11:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so2279578f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725372667; x=1725977467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5+6UOoqDtdqPF+il6F/TYHpc4wmTMnw5HKm4F9lxz9Q=;
 b=NAZqt3Y9v7u/lJ/QN12IqwmPOO/VZHw/UtVEPA3u2Htd7Tr956fg3PFUY0bmITdR1F
 vVr3FBfC07XwJfhKRxvtpDHotM1sdkb4IYa/86lI+4FBT0ajZwy3CD4XrHMy5PiwRpeP
 bdocHFM+868Jm9kltydNuOWlAg6/GQbF/Kz7cqGGWk+Uz74PaNwosH7TdLla5AN5mSfm
 C1pB04z8bvq8UNRpyQprXJNTZQOav2l4HuwL3caKAXcsImtKH5KUmFTNCRkFW485arR4
 TRFnOVpt5ABM2hY3Hit6pibFJbuiqyXsiyzndL62hDTQXaEjKAPl8lJgrioHfO0Ve/jp
 s8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725372667; x=1725977467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+6UOoqDtdqPF+il6F/TYHpc4wmTMnw5HKm4F9lxz9Q=;
 b=AyxsQ3XF4i5MY8gtQKOWHq47tIYve1Z1WTHPxsUGhHJW56FwgmNUesl1SuHTLoBA/t
 U5NyVDcyOexq+B3MgZHyRnAngnnYtaCPiuq8HycI/scS+BMssmUlWtsrdkWIu7lKTNj8
 Bya/Fh04CHM73FhXc2yNXsqir8DVvULwoqzHWBpKthlWKagoGz7kKyTsCAu8jKonmrTB
 9ywFwdVjDfbeHDEtRw8dia5MJiJox3wv7qXQEnVHmQ6haMiJUfmjo0j0vb0YGA+4Swv0
 Jb4lUSrcmLaJH4VK2ZKGvpUvPTiLc/I4HtrquJIaRxMndys4BDGNrzhXXj9o8WvBXbNN
 cqZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVP+Jk0kFm3JgYo4yRQXisRZ1p47u7ZHaMLzpepGNd1uezAHWbwUhsZDHK0wLl7EXXUjnrzYx6RPwJ@nongnu.org
X-Gm-Message-State: AOJu0YxqnUwKpG4De3ZpaM8YlJdcoPkZab/fm2OeNowIMiiACekJEAE3
 jOKNz3PJa2aGO4GbJWd/zGp4aIYLQpOdI/gimmx+h3Wp08fJ9vlNYD9LgzfBP01638RFrb9BTZP
 meQY=
X-Google-Smtp-Source: AGHT+IEsPEo2epoX7OTAofV0JW6s5uMW+6Xb0WedDoi51avO6Eak6hZFyRobVusP49ieaQajcWaSTQ==
X-Received: by 2002:a05:600c:5102:b0:426:690d:d5b7 with SMTP id
 5b1f17b1804b1-42bb01ee5b3mr155397355e9.25.1725370808737; 
 Tue, 03 Sep 2024 06:40:08 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0a42sm169043865e9.11.2024.09.03.06.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:40:08 -0700 (PDT)
Message-ID: <b1aaa5a7-f813-41b6-8dbe-de2279ce68e9@linaro.org>
Date: Tue, 3 Sep 2024 15:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/boot: Report error msg if loading elf/dtb failed
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Changbin Du <changbin.du@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240830105304.2547406-1-changbin.du@huawei.com>
 <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
 <6c9429e2-90c0-423a-812f-33f98fe1bdc8@linaro.org>
 <CAFEAcA_TyjZMcQ+_aCKQvHVow7hB0Q_nZKzRSxPUA2S5EEyBFA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_TyjZMcQ+_aCKQvHVow7hB0Q_nZKzRSxPUA2S5EEyBFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 3/9/24 11:20, Peter Maydell wrote:
> On Mon, 2 Sept 2024 at 21:00, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 2/9/24 21:55, Philippe Mathieu-Daudé wrote:
>>> Hi Changbin,
>>>
>>> On 30/8/24 12:53, Changbin Du via wrote:
>>>> Print errors before exit. Do not exit silently.
>>>>
>>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>>>
>>>> ---
>>>> v2: remove msg for arm_load_dtb.
>>>> ---
>>>>    hw/arm/boot.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>>>> index d480a7da02cf..e15bf097a559 100644
>>>> --- a/hw/arm/boot.c
>>>> +++ b/hw/arm/boot.c
>>>> @@ -839,6 +839,7 @@ static ssize_t arm_load_elf(struct arm_boot_info
>>
>> Note that header error is also silently ignored and could be logged:
>>
>>       load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
>>       if (err) {
>> -        error_free(err);
>> +        error_report_err(err);
>>           return ret;
>>       }
>>
>> (untested)
> 
> This one is deliberate -- if the file is not an ELF file
> we want to silently fall back to trying it as a uimage or an
> AArch64 Image file or as last resort a bare raw binary.

Oh right. I'll add a comment about it to clarify, thanks.


