Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2965C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvhJ-0002kU-D6; Thu, 08 May 2025 03:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvhF-0002k4-Tm
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:29:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvhE-0000ab-4v
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:29:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227d6b530d8so7191925ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746689370; x=1747294170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HpvHuRxKXE3hUM5G1W3E4yC2SOPYhTgmTrK0RBLLJn8=;
 b=lEWny4HyjQhJkBcJuRT5Dr/WBFUbWAmPauUMaCYql6N0tDhgrJCyxXKYkWBWoDu+lp
 6h/L9hg+E9pKxfNYP1JWl1gDgJN/YJQYI5J6uT/nKQBRS5//GcVymurSAn36HB9KScIi
 QGgZLp5A2wmg4viOEEsMtY0cZ/yJpHK+VgqwyixypkJHHNviv2djPgOE3nxf+J94NmOG
 wWLGCzoOlkF3L3hIfJy39S8Dc72OnTGY7kcg2L69UfVvAfrG//JwKx2NpO8IQ64khDPm
 SYos1W9bCdkUDXV7BjRR8EDSqQBiRJc7bYgN7EtU21j9embWIoBpu/2r2HmfY4va+SN7
 NpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689370; x=1747294170;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HpvHuRxKXE3hUM5G1W3E4yC2SOPYhTgmTrK0RBLLJn8=;
 b=r4lpUZDZfX9ZB5EV2icQ6rFCLbmQom7y4IQ/o0OT8PquDYOvWDwERuVi/KxZf2WkAH
 Ierb0S0isTHsiaT7oxz4rDZOOW7PhfqyPWV7NHBhUzMh8ipVzo/nX6eRoQQaftkCYb1H
 9LC4kC4mSjBrtgfBU5wGzgvka8IFTUVfCpH+NXdXi1m/SpwM2h1/nGSS7mB9bTViwz+P
 XI85e8+M1RJ6VLWWEzR8JXVt4fffwnmJzk6Q3UC3VpEpE1q601KV9lCtJ9Lh9+a2jRks
 mP3xZNfkwKFO0W+9n1USklOty4v3FGL2lYk8O+3XmLehRy2XEqvhTS/W3TQXgBkons7v
 oiJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWSb/U1n3P2GIIK78Eulrbjk4+sQyv9z8ZSjN1at3qbY+dOnOBxJWGfKnKWteSr1C1zKdTear4dM6c@nongnu.org
X-Gm-Message-State: AOJu0Yz37OgOTaIxeaDOvk8JGpgPuxzOgxYD+zuuOpZT17HNI2U9hoD2
 lh7hiIZ9ZWPthBxN38srdVTXFmtQn3wUUprfnf1MtRcBC6FgxFwfWZv2KauKvog=
X-Gm-Gg: ASbGncv85HZc8SmAb/hv5ZIyF3bB6542l8ZOhd6AfMoqAkz0XXj4ppco81wa1KfIpgs
 y7vDSAaVHCObLPR/2HpyRDWyt8TQQOc4l0/IOWXs/qT9INhe8HeH6+bd7o5jtONCPl4SvA7Egzb
 I2M4XmdDqjHsf9fc4DOUUtMQmCtg+WLrNwZfW4irc/nq3+L2ayU7w0C2nGF0/e2RVGDvHGw6GFV
 LnJp+vsZ3Awdc/mqrZP8eXGEG5Gd+kkqVuY4aIvE5+Toty7hgHTSCPei4mE4KxJqXlLe2QAeCU+
 owlnq1gD6uWOK8zPTRpsiJqHCbEnili4rPKxxpz4vw1GMrLE9iFtGMP/kJQ4/zyBUXK+r38i6Ka
 U9AMqh+eb
X-Google-Smtp-Source: AGHT+IHxnPpW0DNVisFvkjWUW9cLX7NfdmOHOS7Wt9u4GaaAE3xENowyBPArmLWXTwbTz4OsxdjM6g==
X-Received: by 2002:a17:903:32ce:b0:225:abd2:5e4b with SMTP id
 d9443c01a7336-22e5ea78da9mr100156525ad.16.1746689370310; 
 Thu, 08 May 2025 00:29:30 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e696a554esm25138965ad.128.2025.05.08.00.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:29:29 -0700 (PDT)
Message-ID: <06743a2e-009b-4143-bf95-47338a595a51@linaro.org>
Date: Thu, 8 May 2025 09:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] hw/core/machine: Remove hw_compat_2_6[] array
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-7-philmd@linaro.org>
 <fd5da152-cd33-48e6-96f7-7048c631661b@redhat.com>
 <cc6fbcae-fda6-4ad9-9f7c-b3afd471d151@linaro.org>
Content-Language: en-US
In-Reply-To: <cc6fbcae-fda6-4ad9-9f7c-b3afd471d151@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/5/25 11:58, Philippe Mathieu-Daudé wrote:
> On 5/5/25 11:13, Thomas Huth wrote:
>> On 01/05/2025 20.36, Philippe Mathieu-Daudé wrote:
>>> The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
>>> pc-i440fx-2.6 machines, which got removed. Remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/boards.h | 3 ---
>>>   hw/core/machine.c   | 8 --------
>>>   2 files changed, 11 deletions(-)
>>
>> It's still used in the arm virt machine which has not been removed yet?
> 
> Sorry, I forgot to mention in the cover this series consider
> ARM virt-2.6 up to virt-2.12 machines removed because the
> series doing that is already queued in target-arm.next:
> https://lore.kernel.org/qemu-devel/20250116145944.38028-1- 
> philmd@linaro.org/

The ARM patches has been merged as commits 1731ec33c38 ("hw/arm/virt:
Remove deprecated virt-2.6 machine") and 390becbf7fa ("hw/arm/virt:
Remove deprecated virt-2.7 machine").


