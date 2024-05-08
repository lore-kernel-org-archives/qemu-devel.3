Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6CC25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4iCK-00082H-D0; Wed, 08 May 2024 10:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iCJ-000828-8t
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:23:07 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iCH-0000FB-Hq
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:23:07 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52192578b95so924634e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715178183; x=1715782983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r9b/KYGCpFg4e7Z6EStgo1qjH14mzmGzKeX8zTSKYSU=;
 b=uM4/XLaRlNQwvnPg1C81KL9hDg+1IjTPyOTvX79NjUP1PTx7xV7q5GjaP03cQOYSYZ
 DzgTNC7t7tNNMZ6Wv51os/gqhof34lOHTO5FEwdWsPWqrFK1rwsfsLTd1EyvzQkpSVUP
 xFPeCYQR4mdNxOvmP65Yfd2xCzSSLf3bIBFxvm8vg7o6axudihlrQpUqWFqDV2KFoRh0
 D1311vvg/wcKnP5Rqu6rEDhWPuuJZzXhL5pL2RlopILAiP6/Pwtqt4iKpw0g3wrPX8Vj
 FoKqn3YuovBtgPK4shMx9jdorc9MVg01fWnJQy9Vk0D1fQBuS7iwI8QNDby3xsLBNa/g
 vSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715178183; x=1715782983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r9b/KYGCpFg4e7Z6EStgo1qjH14mzmGzKeX8zTSKYSU=;
 b=nNRjakseGv02trOdeFmuKzFoILKDxdHZZAOrGVXEdbjnKe+Jb2yVh8eIDNzqOBkn8n
 9F598Qbw1+eS6WbPSsmnhIBPwA6ulEIaWESpjgDJptIKq/+jGJx2c+lW+4TzDtmsSj51
 oMuJIRSnEaCZR2FceU2bvJGjLEk13GW/uQb/ye2SR12wlWs/f2lBvI/pem9M8AvPpqDi
 iGxx0D1vuYCcGnjv/8jJRwENP4vT4r3WxMpYHAaX8r2HpxOvGtfoRUR/TFgJXS6czoDg
 SHnFvP5dgn/UzbBCKTHG6tkoUpeVWGhzptansHERDYNjuwdhW6iJpR6ujB4eNqi71nV+
 KdGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyBF9YHPH5ZrLcOTblEE9PrPaayCF2NDzlFpgOkhYqNHqDhZXx+vcPXojCvZLehGVJecOF+UCNuZKDIejFpNOFVZZkVPc=
X-Gm-Message-State: AOJu0YyGhQ3K4mz6M64RMcBxK+Cp0LC3FwKMv26APKXDqWrzLz+UeI8q
 s4N99gHi4NktMBooqJc2s4T1sVJsOtUmOuc8SHBntcpGX8U5BsMlGMhLs4QFhE8=
X-Google-Smtp-Source: AGHT+IGFImL3S0UnjIM+sSsWpyKtK9DMiXvYdGuYboviealbnYJUDVBB3WHD6WEC9uP5j055KlKwKQ==
X-Received: by 2002:ac2:5230:0:b0:51a:df97:cc8e with SMTP id
 2adb3069b0e04-5217c276f4dmr1681356e87.4.1715178182818; 
 Wed, 08 May 2024 07:23:02 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87d1fa40sm24569915e9.20.2024.05.08.07.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 07:23:02 -0700 (PDT)
Message-ID: <3cf22fc2-222d-40a1-b27f-fda72d4b2be5@linaro.org>
Date: Wed, 8 May 2024 16:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <210757c3-c949-4dd1-bd7d-c33db3aa390e@linaro.org>
 <ZjuEOPPbGaZgY6gG@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZjuEOPPbGaZgY6gG@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 8/5/24 15:55, Zhao Liu wrote:
> Hi Philippe,
> 
> On Wed, May 08, 2024 at 03:09:39PM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Wed, 8 May 2024 15:09:39 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable
>>   timestamp as WARN
>>
>> On 8/5/24 06:32, Zhao Liu wrote:
>>> In some trace log, there're unstable timestamp breaking temporal
>>> ordering of trace records. For example:
>>>
>>> kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
>>> kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
>>> kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
>>>
>>> Negative delta intervals tend to get drowned in the massive trace logs,
>>> and an unstable timestamp can corrupt the calculation of intervals
>>> between two events adjacent to it.
>>>
>>> Therefore, mark the outputs with unstable timestamps as WARN like:
>>>
>>> WARN: skip unstable timestamp: kvm_run_exit cur(8497404907761146)-pre(8497404907761161) pid=3289596 cpu_index=0x0 reason=0x6
>>> WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908603653)-pre(8497404908603673) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
>>> WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908625787)-pre(8497404908625808) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
>>>
>>> This would help to identify unusual events.
>>>
>>> And skip them without updating Formatter2.last_timestamp_ns to avoid
>>> time back.
>>
>> Can't we reorder them instead?
> 
> I think so...IIUC, when the current event with "wrong" timestamp is
> detected, its previous events records have already been output and
> cannot be reordered.

Well, this certainly need rework to cleverly handle out of sync
events, reordering them to display them correctly.

Skipping events really sounds a bad idea to me. Even more out
of sync ones.

Some simple approach could be to queue up to N events, then sort them
and unqueue N/2, while processing all events.

Regards,

Phil.

