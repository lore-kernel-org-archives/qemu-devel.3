Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07713C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxL8-00012z-Nv; Tue, 12 Mar 2024 04:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxKL-0000fp-Qv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:17:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxKI-0008HM-05
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:17:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-413428499a6so1566435e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231452; x=1710836252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZBunxkiIx3J7GdymtcjxLq5TiZgj9wVB5HxuBHiujLY=;
 b=hdHXzVbk6rD/7f+7iauZ1GgrLrfDqBrMlccRW15ytBRCKl7Ti3DxjmBYF5Bswy5HO2
 +MMgS/P3w3vWPxawWngRYwJlyP0K5KHq0gS4qBUqgVXxMBjRKM2dHsZsj5pvSRtEkTz2
 lVvWL4EXw737HTjqcG1/oH+baEE68nwpdtG4Ow9gbixcr0KLrzBUp3vSKikVAUPeN34A
 TAaoAOlPpKBJ/ulehtFff/J02Hgwolu6qunOpxW8nwvbsVZC8BC/ba5mWbRrC0o+hTLT
 9nsDu2FCMV0qZPTqR6eizaTYrdf2uSaaJiobB5WgjxbYhLn8Ex+H0KUjU/WIDpmkHeYb
 II/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231452; x=1710836252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBunxkiIx3J7GdymtcjxLq5TiZgj9wVB5HxuBHiujLY=;
 b=kDMd2mbzFf5j5SWh9AYM/C7Ektzvqf9rgRu2bI5YjFCmCbY1p1wxLU6vHn2Jn9CsqI
 DsueG92J4yug+FYrVtfBnfeGKqW322kBW94T2qh1yjCDnfdWtJ5sngnS3tex9wRwZvQE
 BL8mECdWlQnhm6TZGv9dQzdYbApDzWdU2360u/xFNh2Fz7PTjZ60LZy4ynlhLNdw//+p
 yFlKbjMWgGshRgxjWT2+7Mr0w6Zv4f8ESxRHpNq+XYP6QmLxgNYj4zRPBavhtafCCDi1
 AFZQl6rEKZUwdzZLUX2lkkm+jvbDtWBUT9nhMqIVT/7F3Rl011nbob2Oomk4jnoTXorM
 f6yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Plyqxo2CvDb8skUQ0Y4I0ozbckAddMqUtWUIj8FgTUbI1VZg1stNaMFcSqvQhhKhuYughffzGBit72GHGlTCc+nhNJc=
X-Gm-Message-State: AOJu0YwrwoKO02666hte8VsGus3TaYm5S9EPkvZB2g1I9KEDrYJ1AReh
 dEJ8dATjVr6mBtuXykeV3h0mlAiCzjyderdu8FoL3GZMucHlkgtaBSmuYThbSIk=
X-Google-Smtp-Source: AGHT+IHs79feZo7DeMAg++sYfshY4q9VvUcMjMoPJdk1KzgoMVmb8gcifUP2ZHjyyn111lRqQilUFA==
X-Received: by 2002:a05:600c:538d:b0:413:2ab0:c317 with SMTP id
 hg13-20020a05600c538d00b004132ab0c317mr3037391wmb.11.1710231451899; 
 Tue, 12 Mar 2024 01:17:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm11617377wmo.7.2024.03.12.01.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:17:31 -0700 (PDT)
Message-ID: <d48e5d05-0e1e-4bb0-b10a-f0c943b055f6@linaro.org>
Date: Tue, 12 Mar 2024 09:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/3/24 04:37, Zhao Liu wrote:

> ---
> Zhao Liu (29):

>    hw/core/loader-fit: Fix missing ERRP_GUARD() for error_prepend()
>    hw/core/qdev-properties-system: Fix missing ERRP_GUARD() for
>      error_prepend()
>    hw/misc/ivshmem: Fix missing ERRP_GUARD() for error_prepend()

I'm queuing these 3 patches, thanks!

