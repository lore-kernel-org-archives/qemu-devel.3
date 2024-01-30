Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65323C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjWZ-0003kA-Cl; Tue, 30 Jan 2024 03:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjWS-0003jX-ON
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:31:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjWM-0003sj-AU
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:31:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so43974595e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706603463; x=1707208263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cxVszLHp8FDNbJNY/mf3ia485nZl1e2+jY4i4I+6OVU=;
 b=KotUov3hy/joLtNXFqo8RNmBOdAbnnkiye/V4eNmJQqhS6U2g1vJcGU9dwNOQZpXCm
 IpwTZiNRkiwOFKVwzRn4j/zXq7n0jRYzCHFc+34EjuT83My2oDZgVYHKoKPH3+nLwNmZ
 5Yy/pTjaO+aTkMgYR9Vn+WyRvN+l9JtQa16Z8Gu2AgVVgLQm0QAizPVvZpBPbhfIBT9c
 B7QSXW6uQV2wKUdRzXo3I5fnOcvG13sUVI8orFFftk74IpCmHk3W9FMqGSQKmGM65eaF
 Hh6fUpa4h5e8YFiHkFC/65LnMMpbJg5WieINvO5fHRXTgsTLupvdW5hGUw+vTqJUHyDw
 4VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603463; x=1707208263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxVszLHp8FDNbJNY/mf3ia485nZl1e2+jY4i4I+6OVU=;
 b=W9DU7dWHZANhwWrLHxrqVeRvA/Dem9RM0rsv1fciYAk5ukN5CRwC2yfdtIVCY0uxls
 ZIEWuelentQb53l8nNS63zo4V8iBg1FsbNJ97gA1cXm9+i0ZUJ89uO6VXHHZiw86rxIw
 kbhr2G7mBqLnMfuGr3dZntp5k4iCnif+dga5GCyPG+dFCUlaD+LJsfAiP6ZcblHTYj7b
 4m22UgbNSRBgZVg1QJ5lp0mDrB+9YcHAq7XQyYxK093tlHoRtnCzL8tNtGq2Ef4EcXZa
 bvO/p7nsGVg+u8TADr42hRc7QETN1OAX+LD6PZyVjgDmMywHDV2lOwyiBCBXL2nbbAKK
 nCkg==
X-Gm-Message-State: AOJu0YxpN9frSn9hOQE4/8fM/GYnEVJ0UwiP7isZ2y4TM83KeDLWqmru
 FKFS/c6Pyq56OMcTID10z358NCFhAc56eh0wIZTVPLpp7ZIPxj1DT5fmi0MKzZo=
X-Google-Smtp-Source: AGHT+IFgDQSZYS5xJZG8e5E7Fkd5LoE5NrieGmNZZyqED57aOktYazg6vuC6KmRkM/qj3PAioUiCPQ==
X-Received: by 2002:adf:e58f:0:b0:33a:f4ba:d5ee with SMTP id
 l15-20020adfe58f000000b0033af4bad5eemr2368411wrm.23.1706603463027; 
 Tue, 30 Jan 2024 00:31:03 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a056000038f00b0033afd6551b2sm219513wrf.96.2024.01.30.00.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:31:02 -0800 (PST)
Message-ID: <f9d910e7-6b65-481e-abd9-f289eacacc88@linaro.org>
Date: Tue, 30 Jan 2024 09:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pflash: fix sectors vs bytes confusion in
 blk_pread_nonzeroes()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Xiang Zheng <zhengxiang9@huawei.com>
References: <20240130002712.257815-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240130002712.257815-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/1/24 01:27, Stefan Hajnoczi wrote:
> The following expression is incorrect because blk_pread_nonzeroes()
> deals in units of bytes, not sectors:
> 
>    bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS)
>                                                ^^^^^^^
> 
> BDRV_REQUEST_MAX_BYTES is the appropriate constant.
> 
> Fixes: a4b15a8b9ef2 ("pflash: Only read non-zero parts of backend image")
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/block/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/block.c b/hw/block/block.c
> index 9f52ee6e72..ff503002aa 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -30,7 +30,7 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
>       BlockDriverState *bs = blk_bs(blk);
>   
>       for (;;) {
> -        bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS);
> +        bytes = MIN(size - offset, BDRV_REQUEST_MAX_BYTES);
>           if (bytes <= 0) {
>               return 0;
>           }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


