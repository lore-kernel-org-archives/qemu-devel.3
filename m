Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C18C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOdV-0007UN-TN; Tue, 06 Feb 2024 11:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOdU-0007UF-UL
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:49:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOdR-0006mR-Ub
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:49:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40fe79f1aaaso6239655e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707238163; x=1707842963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YBKSlLtaNH8fxIz6B7TtoPw5EWlHODBuxDku4oG9bEA=;
 b=Hs8pAz4zSuXfZQfUcyhbQIr3/g5rXAUy9mrABnxa3oY0BIK2JTlTMwHmYtGGegG+qw
 dvJ3SjQMPuzjEY/PnQ6UR0hAxBAKZ8WSwuxNdHO9U4z1KQh27Z5BSD0OeLVpjcQVUVWV
 DuutccK1m1cr+IyG9FDWw7hJW8enFA3dEI/8Cj25K6tM5W5YQ+xRW2Jlg2MS6uk+dnFv
 q6IV3PHEhLvExgPyU2dtPbMYDn2ZrxJlwiUZEkj2I2w5smeMBdxFLEr/i/+wq5KaqnnJ
 RqzU6n/FMZvyH1JjGs7xmzcMnQKpurDW5uemLh2Ln+tlvVlExR8YwoVu5/fkCWVZIq/3
 DmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707238163; x=1707842963;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YBKSlLtaNH8fxIz6B7TtoPw5EWlHODBuxDku4oG9bEA=;
 b=uUDxNlFjXdF7Pq3d5AmIeTsds4KSSySBn7QHBXIaX76KZtgAYOFv9RG3mbi+YqGlvB
 sAiiB3aSwbY7m4YUON5lKKuY6mtVwgVEVetzH6wUtE1+WqljzCrlxMgCsa+jxA5VsMVy
 cVIoJjVl6AUZMhsdvVVclClJkqXGuke6N4Ez49QLjlcNa5sSugFmYD4EExafs3ncTowG
 8RTQmvKMsCYTpEil6ZaZGmm1P7B0JTWRAK9JXfKyY9zIS4Syq9xE5CVrjxt2XggQaaJc
 pExPvq3KNwD3gD9VDH2hCxJ+kg5BaSBHLdjuFoVHS7Gzwi16Nju0cCePUQPGBjz/T7ZL
 S5+A==
X-Gm-Message-State: AOJu0YwQf4fR871C5tktW2dqnAJ5EprmJhWXventexZ+kyOwS3GaHJXW
 6JYXpaymzV925AADRqQ4X7zwDg78FtD5WMr84t2tGBFAVfa9eaavzsefqOM8msBZj8f9lSbBeu5
 w
X-Google-Smtp-Source: AGHT+IGg7ZZuzur37OUB0EoizaILuiHiW3JoK0YENblcY734MYKcgzNZMJO9yhoJyovmK0MZF050oQ==
X-Received: by 2002:a05:600c:4ca4:b0:40f:c655:aaf0 with SMTP id
 g36-20020a05600c4ca400b0040fc655aaf0mr1940019wmp.23.1707238162830; 
 Tue, 06 Feb 2024 08:49:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVkR6Qe196rlCSeZ4rLQ0+a6GcgQb6KUa4ITyxrJsCxEpPfjaD6T1xD3rxbCvnlzUi5MLxR+kUsRFZinPmDu7gLAnH/qcdcbAq8PvIfI5hvZE2Cn8Wfw3bYJRU=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 l31-20020a05600c1d1f00b0040e3635ca65sm2534632wms.2.2024.02.06.08.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:49:22 -0800 (PST)
Message-ID: <fcc684db-635b-4640-a0e1-51b0f12a459b@linaro.org>
Date: Tue, 6 Feb 2024 17:49:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] hw/arm/mps3r: Add remaining devices
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> Add the remaining devices (or unimplemented-device stubs) for
> this board: SPI controllers, SCC, FPGAIO, I2S, RTC, the
> QSPI write-config block, and ethernet.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/mps3r.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

