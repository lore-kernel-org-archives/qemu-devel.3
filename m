Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B9C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKW2y-0006gt-0a; Fri, 21 Jun 2024 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKW2s-0006RW-D8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:38:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKW2q-0003I9-D5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:38:42 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70435f4c330so1437537b3a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718944719; x=1719549519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JbnYdkZoHVaSywSDipI1ub1xsTTQDuay/Y0l+sWqzKg=;
 b=wQnq+HomryBaXokgAd9atiFgHYUZ3JXknZfhVGniqaXJmBASAy+imi9Xjs7HEZHDaD
 4LOBzKlaNZ875rPYDqtX3ZjFjyrP/CBOiB64b9Cuy+ZTCBdf4eZxjGWpOxvZ1MHkIFRN
 euofHSr1SwzBR3aiMh+8c+ELtYMwGvCk3qtnKR2MLhq3kF5kqB6S/b9mYlpOPg9S+rL2
 sPZkqibAnbJjlnX+X4eDD30xYmUN4OXYCQsqkpGim70janpMb9HLArOGEZvqz+RWaS4M
 N4gTbcdP//Syje0tuqFQY/r/xDvyvsXh3TpV0v73f+v8Q7uRZ9IWadMqgUBdDDuOEhZ2
 cWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718944719; x=1719549519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JbnYdkZoHVaSywSDipI1ub1xsTTQDuay/Y0l+sWqzKg=;
 b=KHvBn8i9Ai4eBmCAsLK2m9jsRUwQ0fkh3PctnK8DJIzfAMEWvWvC8XdcuJZsqUUIar
 DG4f4yMB8QWPJ1SxLB2V7zvYZcjTswyEYFaG7e84By7u+SAbkejisQZEVEwXLmSYwk2B
 +baSaWD4cddq1JptKM7WX0LJ6GgFrzCt0c258eXWth0xYYZSfjYc7W3owzzGwfwMn0NX
 HIWwuEc2mXGEvUlYsfOHG2RbuvI5DBO2DtDdsEKeO+2UybWgeAjyKKAf6gta1htc/hl9
 VI/OcB3YxGCZGUkCRRUxy1USWKcTIjkdLEUJ86PoCygY8Zrazfxw5zZ3z1xGBZS83qav
 LgJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUBnhoElPiQMny8fRPgDpKJkdJrqgX9SzltMnuHV8UIgDmeKLbxqY6E0T3QCw/AqxxGaX6GBSr6cVVmhYAdinygW1FBmc=
X-Gm-Message-State: AOJu0YxtjLRSUfCE7ev/GpaWOUMEJJnDsQ7Kgaqo3NyommWGDBiz6HYm
 p78SzA1y1zXMx1v5FrH0JMsTazEwsV3Z1diYZ+sqLRlwNaH6UoyfFMAUpfhGh40=
X-Google-Smtp-Source: AGHT+IGujfqRQTQQAJC+jxZmqU4UjYphm6kKrmUU3r868VRvqQwvsC8SkCIzg3prs1bIvA97xSdYXg==
X-Received: by 2002:a05:6a00:2717:b0:705:d730:1b8 with SMTP id
 d2e1a72fcca58-70629c54678mr7337637b3a.19.1718944718864; 
 Thu, 20 Jun 2024 21:38:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70651304126sm464463b3a.206.2024.06.20.21.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:38:38 -0700 (PDT)
Message-ID: <9f6e6321-647c-4ba4-8997-b6243253e761@linaro.org>
Date: Thu, 20 Jun 2024 21:38:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-8-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617062849.3531745-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/16/24 23:28, Gustavo Romero wrote:
> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
> are not confined to use only in gdbstub.c.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   gdbstub/internals.h        | 2 --
>   include/exec/gdbstub.h     | 5 +++++
>   include/gdbstub/commands.h | 6 ++++++
>   3 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

