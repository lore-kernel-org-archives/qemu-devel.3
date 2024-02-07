Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1EAC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoMf-0004HN-KK; Wed, 07 Feb 2024 15:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoMf-0004HE-0L
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:17:49 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoMd-0006in-BX
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:17:48 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3864258438so40724866b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337066; x=1707941866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VkOsMDnpNb2ePiAVwIkq0hcRPnZsG8A3XHmMhQ8vCFY=;
 b=wxUaPHmIdJBWHu6O5cXhuZnfJfBhpMuJ6kOuxHi1AG93B5syC0Df2y5MsDTrVydbCm
 gFrHIXSYRYH9GS6q5VxwfaarEVoGaL/nBXThUQjVj/pJ36rPimeHMHrVj5VxORtrhOf7
 Iqd3ycVkndNN464KKp40bfLO4PeVOQJj8Hl2Ted5gNBI9RPqT6OgSfoMz8G/zVzjRZuU
 4fQqg+qfVnRdIurv8EXJqHas8d40z3D/+FdL1xoPXwrgVA2QHajKluauX1MSzABUGYLb
 FcoetCxCQYfZmiZuiL3HPkw4Z7e8GobPuhGHgt5Ev63INjnyYz8Xwt/P003t3ru2b3oH
 eXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337066; x=1707941866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VkOsMDnpNb2ePiAVwIkq0hcRPnZsG8A3XHmMhQ8vCFY=;
 b=f1KTFrtCoPvWyzhOoMJ5R48tkC1f9+aAaBj/t5E+oMuH0MUXZhRZccPix2N/+PqtwF
 SWbgQFvUjEzNqF6CT3E18YxdQFdE+NPaT8CSGXPLO1NX6D0ukuDBEDvCaltAQcC6NQdB
 Qof+ZOHGTCSdnS1Ewfih9obDynwb8ypyiIvKZQMMhrZMx092Vn74miSum9swJO9UUwIy
 neab45q2bOb4AlFSS7q6qgQ47lPQSh7s3zIKoZih/fyETruoy1WaH5yeFRlVp2wgGVF/
 W18iDzpwsByVCz+O62A/dg75rgS1LoHCn9XYPDBCXog1nn8TW4fJT8kl35+Zfo22zoQA
 0SgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVESDeZQEk3I25yHgyRpCpI9Id9lXH7lhzemlpbDt/GBzU68+33ycoJay/mP56qhixuvNKSNxkZbtAI/lSMaWOYprtXKrg=
X-Gm-Message-State: AOJu0YxPCbo0OCEq77CjpuLJn66X+346RAyEPXvRkMoLKp5qHmukWiSi
 J6hwY7p75njzRvZ6J4PmFLerTUscOb4NixwAxS/W9mK4vl97E1ePYBPxh/AwqRw=
X-Google-Smtp-Source: AGHT+IFSi4KDAEpLbWu48Q10EfLEbB/nFGYf945x6jDb6eHA8BQ8b1isRbyb9N5g/2dCmdzc3oTZMw==
X-Received: by 2002:a17:906:c30f:b0:a38:9911:cd2e with SMTP id
 s15-20020a170906c30f00b00a389911cd2emr580928ejz.3.1707337066065; 
 Wed, 07 Feb 2024 12:17:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXOfifR1GR4686IWyghMyLMaotN3+41/k8b8/yULgoO5CbNHvrM/0Szrim6vzf1LimapVlz5WW/3pJLpTnaWxGiTgiKtH+LM6ILVFHuN9qC1CpPr+16PI0IHtRFX6FHddaq+NAz50rwoQ5l1wyuD1MG7og=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 hw16-20020a170907a0d000b00a36f28baa8dsm1108764ejc.111.2024.02.07.12.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:17:45 -0800 (PST)
Message-ID: <d53ce64e-73bc-4e88-bb9e-171f02028efc@linaro.org>
Date: Wed, 7 Feb 2024 21:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-7-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-7-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> This allows to update the Error argument of the VFIO log_global_start()
> handler. Errors detected when device level logging is started will be
> propagated up to qemu_savevm_state_setup() when the ram save_setup()
> handler is executed.
> 
> The vfio_set_migration_error() call becomes redudant. Remove it.

Typo "redundant".

> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


