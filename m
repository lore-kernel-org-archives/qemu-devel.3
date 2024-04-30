Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEF5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 00:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1bBv-00024w-J4; Mon, 29 Apr 2024 20:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1bBs-00024f-NL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 20:17:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1bBq-00060M-QR
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 20:17:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6eddff25e4eso4367793b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714436265; x=1715041065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AgR1/XUMVEQyP7MatblKbnL6sTfup+07/myKTvRuViU=;
 b=tqdi5ReCAGqQl+j+xhLlht3c7dmcBrSHfm0y6ZB3XJhkPgR9T7gkc2hAcsorzs94Qt
 QuQoR9WAlbk+qC0S52lA/Vd9/MOCLvSQJqdxJih7mYRpR57IuESmZ5F206+yxukdk3zI
 Sp8fiVB0VK4+Uuv7Qfh/hFR3vi43IbO8zHlBbK4Tt5ScRPuGB3U8QLdvyC5oAdCdlf2E
 ieIpsezG4R9f/PVt+7NFH41TI08rnLYptxL9OloW+0KLUKKltDMKdiUQrpCfKECfDjfP
 6n2koESCqgUj9gFqrGoJKS49IwjpmO3BDrhxRE9h+sT2ymTX+GSHQbQmbcL7tfB55nit
 L83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714436265; x=1715041065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AgR1/XUMVEQyP7MatblKbnL6sTfup+07/myKTvRuViU=;
 b=jYFmLjuK4S+ytFxYQ2TVlZ4S+ion3N2HHvKL+DRTYKkDw/8fzT6aPe6U+rB625F2cS
 dwejQu276boQsUBRfI90QMtgpwKryi5e0mXYFCdBsi7WloQmw7IK7BdHKziU6WdQFf/M
 37G0GmEJhpcA+hmgVBXUjVz+ElPYw6p5HamZU1TWjWy5Uz9ufJeO6xVNS22LswwD4h1C
 K3kh8SStq0xZLEKOLOHHd1UB89AxnvZIFU4wQQYyHTSFRCtgAFVHYLkYB/g1dj6LIwjL
 hbx9N5CUU2DdBZ2v44Iz0VVbrAKzxqkeyoykvMEkmG0KJH28oMR4TGi7Q54nCZCmDE+y
 iKZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQDeg/6Sam+adzst/00ikK5WBP7Y3Bt9dPPznx+Kme+X4RmUW0BpUUNR4irU3k8yPMHiiqXPJhqufF8eepJX8Bmwcn/w=
X-Gm-Message-State: AOJu0YybpfRw5KDO+FXn9wSqnBjK8Kvj6mHVWXI6cx/89bklMC0nQ3mz
 6Lb7TrXdfuI4fA8F44PkQtVKvEIHEA3VEV2NG4DBm41Vq3wxiDEB/vZsUbC6zWc=
X-Google-Smtp-Source: AGHT+IFEOVu3WaSf+3WqQ14vDqhby5jWXrsPog44M3q1n+uB4SRA2h78+r2zc7RQbCGHxpA76Y1b0g==
X-Received: by 2002:a05:6a00:2403:b0:6ed:4f2e:ef22 with SMTP id
 z3-20020a056a00240300b006ed4f2eef22mr1193405pfh.31.1714436264975; 
 Mon, 29 Apr 2024 17:17:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a056a0011d400b006ecec1f4b08sm19848765pfu.118.2024.04.29.17.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 17:17:44 -0700 (PDT)
Message-ID: <46836849-4a23-4b7d-9940-5d3ce1f63a12@linaro.org>
Date: Mon, 29 Apr 2024 17:17:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/1] hw/ufs: Fix buffer overflow bug
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, zheyuma97@gmail.com
References: <cover.1714360640.git.jeuk20.kim@samsung.com>
 <f2c8aeb1afefcda92054c448b21fc59cdd99db30.1714360640.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f2c8aeb1afefcda92054c448b21fc59cdd99db30.1714360640.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/28/24 20:25, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
> 
> It fixes the buffer overflow vulnerability in the ufs device.
> The bug was detected by sanitizers.
> 
> You can reproduce it by:
> 
> cat << EOF |\
> qemu-system-x86_64 \
> -display none -machine accel=qtest -m 512M -M q35 -nodefaults -drive \
> file=null-co://,if=none,id=disk0 -device ufs,id=ufs_bus -device \
> ufs-lu,drive=disk0,bus=ufs_bus -qtest stdio
> outl 0xcf8 0x80000810
> outl 0xcfc 0xe0000000
> outl 0xcf8 0x80000804
> outw 0xcfc 0x06
> write 0xe0000058 0x1 0xa7
> write 0xa 0x1 0x50
> EOF
> 
> Resolves: #2299
> Fixes: 329f16624499 ("hw/ufs: Support for Query Transfer Requests")
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   hw/ufs/ufs.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

For some reason this appears to cause failures on s390x:

   https://gitlab.com/qemu-project/qemu/-/jobs/6740883283

All of the timeouts are new with this patch alone applied,
and go away when reverted.

I wasn't aware that these tests used ufs, but I have no
other explanation...


r~

