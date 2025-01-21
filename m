Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFCCC02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 06:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta88c-0003sy-Ky; Tue, 21 Jan 2025 01:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta88W-0003np-T9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 01:53:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta88V-0000Ab-6W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 01:53:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso37199695e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 22:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737442397; x=1738047197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hno+0VhubQFaDVYC27yqSuTNN88NEoSvCzFF2xKdfG8=;
 b=EpJrCBhcB5eUnYOpObmILMjTZZgTujvZeuCydpkyAtN++KvqhqKtWegRmdXwVyOfbD
 Zvh2SJKD0csv4Te7Tu5BEQ6yHgbxtBdj+bd7bOuGjjJSoKm51hX33UlKaEkglyDhRzXJ
 d7qqWy9WcOxmFc+b+Yosyem/Aug12cOlJ+X7d/I5Lk6zdelehwMoyQm9cnit8XZr3cWV
 wCamGqIMYkduxH+kUjXJx+kI0N3G7TflaoJgkPmZJa2FAnv+S2nF6TDAeYiymkeCmihB
 5I6g5SzHDrkXT/7Y7b/saC5lo2VA03J1pc/d+wRnqk32oBReHdnJ2aAYeUyuHxc+TnYk
 o4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737442397; x=1738047197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hno+0VhubQFaDVYC27yqSuTNN88NEoSvCzFF2xKdfG8=;
 b=gMw5nE9RLrKnPyE+8dHQivj5wQEI+LY/XFApujEeYFpW/IRHzt98ooW82U7MmVKCcy
 U9C0R7D+PQN8lT4ca59ufAhlnTis9840PXfHrJJY9QCgoWAirbhdpyyx5Y0nHpHIC4az
 edH8v1fXNHFVKHVM1/xPOKSS0LfuIyW+Pf0UD5cPuqYRIxd+6dTv2Fva0r4GZIr/qUpd
 5hBPElURu+F6ntfFMm2YPsuvAnTfZOjCQIyg8PXNwlEi9TrqL012L9KQOJPxo21H6E0e
 oCbEmqA4XGnxKqqQ/ZX+gFDseuh3S5SZWKKJe6j3mgXHz6RoHUR1ZVDNc8OkRxpDPkWB
 OPig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV+jGsV7s9G6xgRumOSBTHzuk8pjAYCAHFho4jNq73vn9ljWHC8GaYjy+YzVbslzHgtphOcik4oNzZ@nongnu.org
X-Gm-Message-State: AOJu0Yx8fYOba7Gm6TkrqYgyYZYAk1BT2ODiulZCPCSY6Feqc2Lgb6pG
 tljuIZphd6HXrO8PK67LWgJ8IwlA+lGgTudxus4CYZ8LnsNddYdkPHiSiBULUG4=
X-Gm-Gg: ASbGncudTo0JsXw9BnnIPPznIOf2PcZt95LZkULDBEH5WP4+C2HOQeeYv0QEQwTUnJO
 3HmNzrTNhpHbFMqZI/jU4abxS/Tmpo/18X+8LFUN/2Z1SHlbke/RJzXV1rWbDa5HR0nYuiC0U+3
 aWtLhOVSW1bWZPRJbD/WOqk72Sl7XvderTPKQHKDmpJ4GGtGGHAJRkWtl8PLDHvUbDlVEtjgVR4
 UyT5uAwr20A53jTcfqttfbF0w2Xv1zh2swDYA/Fp/8t+lZ0wL9ofLhs7Z8V5YqWoMIlRZPwmg65
 bXe++xtecAp5vBaT4OYbxYfbIJxupHDxM8C7Zg==
X-Google-Smtp-Source: AGHT+IH/Uu46C+OsiybJTbtn3V6JDbAVxUXNtPc7jIH25r2rW1YoCO032PplkP54k44pg44EAcpMMQ==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-4389144eea8mr169769595e9.30.1737442397061; 
 Mon, 20 Jan 2025 22:53:17 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad74sm12612926f8f.56.2025.01.20.22.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 22:53:15 -0800 (PST)
Message-ID: <28ded100-4dff-416f-a11a-cb1e94cdbd94@linaro.org>
Date: Tue, 21 Jan 2025 07:53:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] qtest/libqos/pci: Enforce balanced iomap/unmap
To: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>
Cc: John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20250117172244.406206-1-npiggin@gmail.com>
 <20250117172244.406206-3-npiggin@gmail.com>
 <0584eb66-ab11-40ab-bf97-64299eaab52d@linaro.org>
 <D77H30AHH52R.NMFINJAZGOD0@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D77H30AHH52R.NMFINJAZGOD0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 21/1/25 05:39, Nicholas Piggin wrote:
> On Mon Jan 20, 2025 at 3:29 PM AEST, Philippe Mathieu-Daudé wrote:
>> Hi Nick,
>>
>> Only nitpicking comments...
> 
> Hey, no they're good comments actually.
> 
>>
>> On 17/1/25 18:22, Nicholas Piggin wrote:
>>> Add assertions to ensure a BAR is not mapped twice, and only
>>> previously mapped BARs are unmapped. This can help catch some
>>> bugs.
>>>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    tests/qtest/libqos/ahci.h       |  1 +
>>>    tests/qtest/libqos/pci.h        |  2 ++
>>>    tests/qtest/libqos/virtio-pci.h |  1 +
>>>    tests/qtest/ahci-test.c         |  2 ++
>>>    tests/qtest/libqos/ahci.c       |  6 ++++++
>>>    tests/qtest/libqos/pci.c        | 32 +++++++++++++++++++++++++++++++-
>>>    tests/qtest/libqos/virtio-pci.c |  6 +++++-
>>>    7 files changed, 48 insertions(+), 2 deletions(-)
>>
>> Maybe put the AHCI fix in a preliminary patch?
> 
> Yeah, this was just laziness. I will fix.
> 
>>
>>> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
>>> index 83896145235..9dc82ea723a 100644
>>> --- a/tests/qtest/libqos/pci.h
>>> +++ b/tests/qtest/libqos/pci.h
>>
>> Consider using a definition rather than a magic value:
>>
>>     #define PCI_BAR_COUNT 6
> 
> Now I look again at PCI code and it has PCI_NUM_REGIONS 7
> where ROM slot is the last entry. qtests doesn't use it
> AFAIKS but maybe it could(?) so should I just use that
> existing define?

Even if qtests don't use it, using it makes the code clearer IMHO.

Thanks!

Phil.

