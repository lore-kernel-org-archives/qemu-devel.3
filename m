Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51848C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd60h-00069N-MT; Thu, 22 Feb 2024 05:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd60f-00068t-QB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:08:57 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd60c-0000z8-Cx
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:08:57 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5101cd91017so9998007e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708596530; x=1709201330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2O1ZP6YM8mByvFm8LuvOyrbrlbHKRJ8TBcU1nuzTwIk=;
 b=xiKzLxKCpOtV0pRe7wC8TLWKBooir+1LLKmygg0HzpmqwG6f5d7eAxc0rurHJ/+VeX
 G5cGPXgHTNrl5M3jJJOyO60hQC70lHVFRmd3Nc5uqbpTx+p2Bw37F2tqvB6v8tVuf9c/
 7gio0CYhoYkjQfkFWQTAqDk/7igVxup4TCmFSizFF0xt2JKCQhRdHlnzzRFebWdIvVmF
 vsDQt0Ib6p1u356HkYg34KBNVYrQ0XiuIS9qRvy2siCLKnGrQpDeHjOK0GdPiP8oeNxP
 gSwJpoPLHBnAEQELQCLR9V1pOXSK4bU0B3kiVug98wnh5GbkS+WvFMfrdz9Q9RJMIS2/
 RQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708596530; x=1709201330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2O1ZP6YM8mByvFm8LuvOyrbrlbHKRJ8TBcU1nuzTwIk=;
 b=p07WL+AQHliA4FPv0H76x/6mm474sosBxoPL3ay5VZyBSwcNK8ZfOkxTCXFGmPvVyy
 mbLRI2o287G9AONlNxGfUv3FP3m06pVyPtEVpuTvpDlcAAuyOevVixx0ByY2aaE4ulLS
 yjxFQMo7c6SW5BWQ/lWbFSDfvwwnU678bxnrU/LS3u68BfwqGSo/U5kQdrkqbu9/iwMW
 K0CO1kjYRSYBB9fOnj39wYIxEoP6PYnDmfELXZluNzaP+2Jqzpz+xAfRP4DNlhyEI13L
 hfR9UW8I625m7rznTbK8Y1Mu8uQAwbAjGpM5E1awtoG6AYiM6ya/gnE+ZSIDfaGPNX8h
 OmPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfH6XmxQYW/TxP54kOQy+qT20U7TKnpbkEpAON4F9FQ3g/Zp6fZNQFb/CHAlJB+sDraNIOBFyabNTRkL1USa8AC0M/Uks=
X-Gm-Message-State: AOJu0YxRDcufrSuWNMsUXbtGbb1p5ek7WlsWWKxPgSRi3E35HZ4ZHOTW
 tYJ6j7OBeAdPFWFc3sBWrGuZUfFK7Dc599FrAKSTneUxaN0wZBKGSZpb60cYZoU=
X-Google-Smtp-Source: AGHT+IG3kp3dSA8TrDZ1IrvnxgopwKes+ChIYQR8WawEWdVavh6DyaOppqBE/TrMnmFRWnRh51Fvsw==
X-Received: by 2002:a05:6512:3ba8:b0:512:a743:3ce3 with SMTP id
 g40-20020a0565123ba800b00512a7433ce3mr11865932lfv.23.1708596530622; 
 Thu, 22 Feb 2024 02:08:50 -0800 (PST)
Received: from [192.168.247.175] (41.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.41]) by smtp.gmail.com with ESMTPSA id
 f21-20020ac25335000000b00512d86c2c78sm375667lfh.88.2024.02.22.02.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 02:08:50 -0800 (PST)
Message-ID: <42681015-53e0-40df-8de3-3f93e83ba002@linaro.org>
Date: Thu, 22 Feb 2024 11:08:45 +0100
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
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Hi Klaus,

On 22/2/24 10:29, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
> hosts results in numcntl being set to 0.
> 
> Fix by dropping the endian conversion.
> 
> Fixes: 746d42b13368 ("hw/nvme: Initialize capability structures for primary/secondary controllers")

Isn't it commit 99f48ae7ae ("Add support for Secondary Controller
List") instead?

> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f026245d1e9e..76fe0397045b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -7924,7 +7924,7 @@ static void nvme_init_state(NvmeCtrl *n)
>       n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
>       QTAILQ_INIT(&n->aer_queue);
>   
> -    list->numcntl = cpu_to_le16(max_vfs);
> +    list->numcntl = max_vfs;
>       for (i = 0; i < max_vfs; i++) {
>           sctrl = &list->sec[i];
>           sctrl->pcid = cpu_to_le16(n->cntlid);
> 
> ---
> base-commit: 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0
> change-id: 20240222-fix-sriov-numcntl-5ebe46a42176
> 
> Best regards,


