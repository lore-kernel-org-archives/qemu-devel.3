Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C304C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4Lu-0001zn-1R; Fri, 31 May 2024 11:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD4Ls-0001zZ-It
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:39:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD4Lq-0001cy-O9
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:39:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-420180b5897so11411655e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717169968; x=1717774768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YEXZoC/oGQ12S9TJ/qvsBvrmQO463EcPubkvPD3RMEk=;
 b=KnxqMdUQ+DhC6fVJ1wGZzrsxo6vdDYXGpN4/+8ZJNupRe3Aq3MsrvYAal9vCrDHKLD
 bC1oHHa7Vy//hV2vuPg9j4oX0SSz8vGB2j+uW8E3m66Zlwm8ivLk7cgWpcNyq2amxFKC
 NuoULd0crtMSbDdE27CoczobhW4pcc1gum/M86ccUEd50eBTjBsBuRfVy5q8WBUTLeYv
 yXXmqe/3oz9tijH1SCAsd4em2Bg1boWmEKoYGhJo5xlX+oUH2AWCOpZvPVL1vuncGbuX
 NP0Tjv6bO32Moun7EqC/qLOcmU0ZY55sXChqmqq1dVVw0NsAhXf0D0XkpHzUpn0IpmXB
 uCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717169968; x=1717774768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YEXZoC/oGQ12S9TJ/qvsBvrmQO463EcPubkvPD3RMEk=;
 b=QOfdQA+eF7/1aVdWmmFA/86Z/yXnCIRNg4mTj3J6IEiNDKOB/ly/+W4luPoVUr28yP
 xI39IiVvOJXCVKQrFg9xAg9D5sbcTUeRLmvgcqszjk5CkIaHn5zZINZy/eCt9fHzSEdO
 EgOQy+JcjBYZqsRt6yzh2uR9FCQtwTBsWI4tZLv3rJUVBmlHsWceLNvg4UY7rmy/pYp1
 9Eo1DNgVcg4XaOqxXKHNoWxD2wCDf5TutddkQxl0crsaXVt2q7hxqUixKGPdG56E+OmS
 BsKgkUNt9kdDnnlTVglUYE2oWREQr8S56fazValymcXIL50nlZy4VJi6CcaRahRmyNUB
 IKJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2iukSJnIlaN9oTMatTI7cDrK+nfomxfpmy/HQZ572we8FLaISkk12zyabc1Y++5QLfzCut1ukocb+3FFao+p/diGK59o=
X-Gm-Message-State: AOJu0YwsFfjLXMvDkntHZU51yzxkviPRvKL2qbuQ2frt7i6Wdu0eOBrw
 Pc0WZUg5WyGdmG2UNnoil2pYsNO4Pw0VH7LNcDbPDg6dh7eBcT/6uaLj3G6XQpHUSFQDc6AM10F
 9GzI=
X-Google-Smtp-Source: AGHT+IF6iw55fyF6vF4ERWy262Bw2jysc4C+EQEpfIzfTnloz2aG27hH0jOBKvf9wgEP/GAnP7GOjA==
X-Received: by 2002:a05:600c:1f93:b0:421:1fb7:dff2 with SMTP id
 5b1f17b1804b1-4212e05ea21mr20681225e9.12.1717169968469; 
 Fri, 31 May 2024 08:39:28 -0700 (PDT)
Received: from [192.168.137.175] (140.red-88-28-21.dynamicip.rima-tde.net.
 [88.28.21.140]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cad5bsm2139804f8f.38.2024.05.31.08.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 08:39:28 -0700 (PDT)
Message-ID: <d9ce4eb9-e211-40a9-8d71-4ee1c309ea00@linaro.org>
Date: Fri, 31 May 2024 17:39:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] backends/hostmem: Report error when memory size is
 unaligned
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <cover.1717168113.git.mprivozn@redhat.com>
 <025d0bdd5e76b334754c09c445fe621090121da5.1717168113.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <025d0bdd5e76b334754c09c445fe621090121da5.1717168113.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 31/5/24 17:10, Michal Privoznik wrote:
> If memory-backend-{file,ram} has a size that's not aligned to
> underlying page size it is not only wasteful, but also may lead
> to hard to debug behaviour. For instance, in case
> memory-backend-file and hugepages, madvise() and mbind() fail.
> Rightfully so, page is the smallest unit they can work with. And
> even though an error is reported, the root cause it not very
> clear:
> 
>    qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-file': Invalid argument
> 
> After this commit:
> 
>    qemu-system-x86_64: backend 'memory-backend-file' memory size must be multiple of 2 MiB

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   backends/hostmem.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)


