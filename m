Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E62C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWBe-0003ye-1K; Mon, 26 Feb 2024 03:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWBb-0003xr-3p
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:18:07 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWBZ-0003pO-53
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:18:06 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3e550ef31cso294936466b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708935483; x=1709540283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehfKb/GXBKJJhlhNDhvn5qEI/0dzYxZOynPkWDOGcpY=;
 b=zp+Q8TeGtMdvrw1vPDCRDXZYNHCwNypfbjy4vPXqf5N5AUSK5Ui6FSi+kL34ftlh2n
 3l5jy+saVrtWOn8VilYkJwJeF1AxNcQ3jrBm9tssPabzrqWQP7n76gsmw6G1Zst/PEhb
 +z4eGxjFd7MdMT0+yEEGXDz8kbLdi+b2llZV2+hyMsA6GrDDfA/IrsTxo0svpb/KMrl9
 9YKW6c8yQFZqqKq4jNQoY+PQN6NXVZ4wFi3fMrqP+oMYpwcEAjLNhFVoabC5oLylgwV7
 bMQtCsmHhmDlIN70OI7rjZ5pWxINVGnm5ePxKeH0F22f+QMMMcxVVmabfcyAtYnHMYKt
 H5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708935483; x=1709540283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehfKb/GXBKJJhlhNDhvn5qEI/0dzYxZOynPkWDOGcpY=;
 b=s1NlhOKzrV+B9HdiCdfW+bYcCAGvRRX+U1pLqyt6ek72+AxEJXwmOnd5aOxPxX7yZ8
 tSApn99Ush3mRSeURD9p7dF1/OvGpIHP5oqvurQYV9mCYJLjVUlWcTCRAHpywZs6nID2
 Vak1TzeOQ00uicDum7WBOeOSDO7MWgRwqUUujRDrRMJQvI8JoMhy/ZImjO/vXgHcwBnZ
 BJjZSq8ZFGh5lsOXEjBGTyvZgRIVqeYzcSBDQGCrNSIs56n1otIzexyoH8ED7NPogBo9
 r03v3C9WM3QZv2eaSwdmoTJPz0j3Qo7/GGSK4lqngGNT4IV1VjmBOhEOTMdYlilMHREn
 tXbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbnDzVi9epQ8PWngDgd3zwVFrXyDMFv+XhuNzYBntMde0He/GuR8o+LK+IL9FzEP5z+qiCOHTfekxf3tU3JogGGq25hI=
X-Gm-Message-State: AOJu0YwUyJkVAc+TB3YOEz7D4PXJ3G+WgLZFxxDJ1g8Doa8n/44OSd2F
 4YklrGVX682EZG6FHWhGj4CkGSTCCFUsyAqgTMS0uZKudngcWX4LSCBLavKgvRA=
X-Google-Smtp-Source: AGHT+IFEGFzMSX6KeM4pf82eoQaZ4syFdXkKRw35Z9XVaibKuMJ4RUszn42YDMUdkyENxXxtGf+Y9w==
X-Received: by 2002:a17:906:fb0b:b0:a43:5429:499d with SMTP id
 lz11-20020a170906fb0b00b00a435429499dmr1067198ejb.27.1708935483076; 
 Mon, 26 Feb 2024 00:18:03 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 vu2-20020a170907a64200b00a42fa8c207bsm1970682ejc.94.2024.02.26.00.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:18:02 -0800 (PST)
Message-ID: <295b6a29-d0a7-40b1-ae37-34faab925d67@linaro.org>
Date: Mon, 26 Feb 2024 09:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix invalid endian conversion
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Kevin Wolf <kwolf@redhat.com>
References: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 22/2/24 10:29, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
> hosts results in numcntl being set to 0.
> 
> Fix by dropping the endian conversion.
> 
> Fixes: 746d42b13368 ("hw/nvme: Initialize capability structures for primary/secondary controllers")
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Hi Klaus, I'm not seeing other NVMe patches on the list,
so I'll queue this on my hw-misc tree, but feel free to
object and I'll unqueue :)

Thanks,

Phil.

