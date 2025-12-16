Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D1CD64061
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVewF-0000Xm-FH; Tue, 16 Dec 2025 18:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVewD-0000XJ-Bp
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:58:41 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVewB-0000qt-OG
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:58:41 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so4294336b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765929517; x=1766534317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EF0id/+k3FGCmd4ldUZgaea2Q+pPpVUsEhxcIAFitHc=;
 b=RKQ7QkFR/bdLHEZaO+vq4ROHROwX5+varX8olxxoPrQAr/lZerWNsz3c8XPr8ZrI5f
 0jczCdyDFTS05kZQvCguGFgl5coJ9997hrpJD1ifiwMT5JoFnvK9w0rXT3xUpFOeUfW5
 Skq8AWPG+WLV9GrSANEMrC5WlZkd6gnmY3UC4x+KP+zxU3dH80BDlg5hn1FQ6UqmeCPz
 jbSWzWQQncz20eLuxGM96IX7kc7iy80Z/6GuPCjX9SojnQ6FQuIBTNDpbk4aUhbMkCrz
 EcDajohIEwdwVFJtSjQJ7Milyx0rzBSXAetZDHKKDVuA2dQD3x+KhmbphmcWCQXd8GMj
 e73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765929517; x=1766534317;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EF0id/+k3FGCmd4ldUZgaea2Q+pPpVUsEhxcIAFitHc=;
 b=Y9s2E7TRRz0+DlZHBoraUmRc13323S6+3+TmiDAnleO0ChPLLM6+B6deWar6TTcGKJ
 CZ1ypYqC+0+N8IcIA2XfVvaD61YwGwOAkEwCQzpG/Bhayf7IYUm78VkPut2s2GwZzsk1
 fx8T6WJkbSnmKQfFOH4WYOJ/8OFro+JZjM9ucmT8akwscYfMcDKXRX6ufMsTYOKQIs5s
 dLyjOyUVTypJGozkDe9syt8OBkcgXC6VpZLgjQYN5/+ZS2caYRytkdH024uAqy/2J5is
 REISN6o74bVN8FSNDO475cFHkmmjZxyqTd5fnz5U4ZWoc+9BSVxLm1Pv0cYdwRm39Vjr
 3Srw==
X-Gm-Message-State: AOJu0YxjC/sGslaPkfkfmw0KRRpX8BCd60zD+g/KgDLllAjw4l9EZY/l
 QOAfLmUl+atqLOhKcMQ4ahn/luF4tLdBNqv+uN/nM4gTK5dgzh+zUV1bwhIwtGhdDApvEaWW5tJ
 S5NV2fdhN6A==
X-Gm-Gg: AY/fxX6Pqxt5IQ/0QHcK8ljc0pHbsSaQCJQptXT3cnOAjrbXgmj7Te6EJ3hhlJKKoGp
 OzrMsNtqSRjCC9v9sHnLT94kHxyJo3auPM8w3gnN38dGSS/orVFQsgLGSijeenG7TGCJDdvIh/p
 gSyIqD2O5Dkeo9qdBNzq17AVxtkTwyfhaC3fyNYlY54VZ2cRNMo3RGzL7I/SSihSvxwaGkMTgPo
 FyRk2lftgHZg2nDayOVi28szrbGDTx3zRB6xAdeR3qYw2ztmFO/IwKGT37CfA2e4ahsxACoP0Xm
 hsOeD8hot5o4lny4FXFYNcn8B5MlkfZbSdAA/1UHEZhocrbcu8tFdHGDSZ2i8XkJDrgblQR1qE5
 n+bYkXA3YeVhTUgXd+OKB3whAclGZAYoXw9HefYi09Og/3MIU+hC5umWmYLIxuzqJgK36oJZ7ok
 OwRKq0NZTOkrdxrR1/kmdTVRSugwq73OAtSQGruS2x0LwNuD26xAsZxds=
X-Google-Smtp-Source: AGHT+IFeH0wfAGHUWbLWlp3YPJmCRBAYKyediMR2UsDkCqqlfPvjjOAK/9ILsfxv/KnZjQuPxeKGUg==
X-Received: by 2002:a05:6a00:3391:b0:7e8:4587:e8d2 with SMTP id
 d2e1a72fcca58-7f66a079ee9mr15827110b3a.69.1765929517033; 
 Tue, 16 Dec 2025 15:58:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbc5a2bd2sm676485b3a.67.2025.12.16.15.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 15:58:36 -0800 (PST)
Message-ID: <5e55a368-a268-4799-ad7b-6e113d11c40f@linaro.org>
Date: Tue, 16 Dec 2025 15:58:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/smmu: add memory regions as property for an
 SMMU instance
To: qemu-devel@nongnu.org
Cc: tangtao1634@phytium.com.cn, Peter Maydell <peter.maydell@linaro.org>,
 richard.henderson@linaro.org, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20251216224845.1673051-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20251216224845.1673051-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/16/25 2:48 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 54 insertions(+), 9 deletions(-)
Sent v4:
https://lore.kernel.org/qemu-devel/20251216235731.1793908-1-pierrick.bouvier@linaro.org/T/#u


