Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB682C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4iuP-0006NA-I8; Wed, 08 May 2024 11:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iuN-0006MN-Hu
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:08:39 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iuL-0007dI-VJ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:08:39 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59cc765c29so853575566b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715180916; x=1715785716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZMsHAJVvfu1B9SU7b9eMth8eSb5rkEdhG4+pXRBwaok=;
 b=M3BF596NwI/vXGsACPzxrLEUS4viHHnvFNlG7lXpZRbXi89bhb8o3Rcfnm6RVu5D2q
 LnM5Ao0zijrbolMCmWpSVS2NB20pjLl1JrRudHb4DJx03ls6p0qeBuIWQcxunhK3URVM
 mGskw3SxRB8nmwj52JtaShoX5lWR/puNR4pljXSiiuDqFmFf5FTaSfPoXlvX7uiRAcEY
 1+ptzm3xQoJAY5g2kjrXd5svrRoRV80yg51C9izYTYayF4Zkn7mXgBsTXagHBFr42iWw
 EDo9L3agRMYNyJswrW8tFR+5O1J7l+4k7pSWhU7yHCOoo2Ws0h2YUU4kzBJM443RR0fs
 brig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715180916; x=1715785716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMsHAJVvfu1B9SU7b9eMth8eSb5rkEdhG4+pXRBwaok=;
 b=J8zTjZTPCBPuwj4TcjxUN5f5pkOh6CMfKvAQRltXTQmUZ6Sf6fhaHdG8NKe56o/ulA
 knuTObrAa343nonmfYYY8inKEOcr6XaCzG1JWqI3tr8fNFQMw7Z+MtZf/S0oC+Rz8P+g
 X0WB3b0husB4tlbloy4bufp5rVbTL/njuC49GQb0BolO1klmCi/5EN8kxGDuJlk4WL3u
 0Jma4eTKnb7ztqMzMdvzjwXsfupBG3J1ONqxm9GQVycu3DrCTrU/S/dARJi8ZnM0pqdE
 GC2R+M+9r/1HGogLnaoUc4n5lgWuJOYGNjrFYRkH/rLv4ao4gPsGuWki++tHpnOwdfkT
 sJhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtCkdAQhe5IXTkymwhe5WL0axObWvnUxQZdhpUpni//aD82qKoh0nJ9QbkDFAmAGs55iKrsL2ozUK8TI+60disq8oaV28=
X-Gm-Message-State: AOJu0Yw3U2R1cwe92zR153QSXauXmmKSzuJIoKXWAOWBabLShwmFOvu4
 /GeLxxRfUgYr1Mj7FJ4NOeBe1SSZNFS1ucvo0emFUdUcgzzr2QaCGyuqx1Gc7VI=
X-Google-Smtp-Source: AGHT+IEFmmLvUtkU97kcgHwTVULmys0MccD3Qn5aC9QtfKUx4aUQ5q/uAj0fSil73dPKp7GsDrRhwA==
X-Received: by 2002:a50:d796:0:b0:572:6ab0:6afc with SMTP id
 4fb4d7f45d1cf-5731da81847mr2107913a12.33.1715180916375; 
 Wed, 08 May 2024 08:08:36 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 l11-20020a056402028b00b00572bba6745esm7623119edv.81.2024.05.08.08.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 08:08:35 -0700 (PDT)
Message-ID: <36f2513b-7316-4544-bd83-8cd3bd7aad9f@linaro.org>
Date: Wed, 8 May 2024 17:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] hw/loongarch: Rename LoongArchMachineState with
 LoongArchVirtMachineState
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508031110.2507477-1-maobibo@loongson.cn>
 <20240508031110.2507477-3-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508031110.2507477-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 8/5/24 05:11, Bibo Mao wrote:
> Rename LoongArchMachineState with LoongArchVirtMachineState, and change
> variable name LoongArchMachineState *lams with LoongArchVirtMachineState
> *lvms.
> 
> Rename function specific for virtmachine loongarch_xxx()
> with virt_xxx(). However some common functions keep unchanged such as
> loongarch_acpi_setup()/loongarch_load_kernel(), since there functions
> can be used for real hw boards.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c   |  89 +++++-----
>   hw/loongarch/boot.c         |  10 +-
>   hw/loongarch/fw_cfg.c       |   2 +-
>   hw/loongarch/fw_cfg.h       |   2 +-
>   hw/loongarch/virt.c         | 340 ++++++++++++++++++------------------
>   include/hw/loongarch/virt.h |   7 +-
>   6 files changed, 226 insertions(+), 224 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



