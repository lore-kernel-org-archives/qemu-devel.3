Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AA3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwdKj-0004ot-T2; Tue, 16 Apr 2024 03:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwdKi-0004oQ-1U
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:34:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwdKg-0006QX-BL
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:34:23 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-570423c4f80so479010a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713252860; x=1713857660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7LYAs7izQsVLWruu/9Fs3Ifo3+Ewv93g3NBlVCtDbEk=;
 b=mNyFbTO9Kmhqj7miHWxXuM6YQavk7EJxdWug61jSwhFRZp1dynv4sWfd3PeyJV27fy
 JsMpXtNL12d8GlT9Th8kw1RYnrpVub2fBRVfA6mHZ5z8ENLXQ8RZn3jECDyuuWaTyc6Z
 Q+17tEentqWu9eSoXsyhNHM4zpXt+LojIhyS6u7YTFnxwjEtLimi4gZ2l7zzs+bg+ddA
 x7Lanc/8pZSOBfwqI7AJta0314r/m+sa2oROMFk27+uECyekbhy/73tcKK42C7vy/luJ
 L9lrlXqlisqkg+CESq1lwgHsvZzhPQ0SDxGP8c0UlPum0TBkk5b9lpl95vBAaNYhKQCR
 yOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713252860; x=1713857660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LYAs7izQsVLWruu/9Fs3Ifo3+Ewv93g3NBlVCtDbEk=;
 b=NbZSU8DTj5b9+1BS+dvVWSBgtdd++bOUAWSpsfCtdpCE+kSfOPDgp+2m3PMRMN7xfz
 RF2Xjy4AC/YSezs/7MtTgGOSNFE+FxgI1zzzfUbd2xqIfmdnn8JwVd8I8kUpjGigsa7p
 x6U5fMtmUDjFtVp4sNlvs6NISEg/2zxm7WZRsDSkZneTjwNJZB4YhTu/2N6jmSbIVzQt
 hV3VTJSR7YkIm7Hu2QMhZAnjwbjFcrTuxtS1G7CFpW26vk5HoFNurJ7NWk2de72Mqc1l
 f6yJWmsPAimX2auwpIU7E3pIbR6e+nYwy/G5htoYiERdu+aAH6v+x2yWXc8R6zpFEDfS
 NlxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHAZ3Ugoecu+0BnWBuU8PtEeoP/QzgbsDXIc98/gPd52jBo9+HYj262vS+yn+aQhLQDDY6D0dcl0LEX9W0Phskmf57mmU=
X-Gm-Message-State: AOJu0YzOTNaFTrVde0VygnjiHLkhTEklOsYNf8aLzyNS4Go5HqW98u0e
 qRHj/qqZ2PDLxAiA2s3/kiU3ISSDrHadfgooi6+hcM5NOFjZZPZ0fxf/AOe+w4c=
X-Google-Smtp-Source: AGHT+IG9GJ72eqZ1qxi7lrT2Ecp9MNbBfxh/tgIQV98k8ra1Lfko1AUHDQ4Go1r2ZusUlmoILlKBNQ==
X-Received: by 2002:a50:9b1a:0:b0:56e:2464:7c41 with SMTP id
 o26-20020a509b1a000000b0056e24647c41mr9143342edi.19.1713252860520; 
 Tue, 16 Apr 2024 00:34:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a056402000300b005702c757af2sm2059791edu.30.2024.04.16.00.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 00:34:20 -0700 (PDT)
Message-ID: <17e59f9a-444e-43d3-af02-d036f90a036a@linaro.org>
Date: Tue, 16 Apr 2024 09:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Improvements for switches in hw/cpu/Kconfig
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240415065655.130099-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240415065655.130099-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 15/4/24 08:56, Thomas Huth wrote:
> First patch fixes the problem that the file hw/cpu/Kconfig is
> currently ignored and the switches there are duplicated in hw/arm/.
> 
> The second patch introduces a proper config switch for the cpu-cluster
> device.
> 
> v2:
> - Don't make core.c depend on the CPU_CLUSTER switch
> - Added Philippe's Reviewed-bys
> 
> Thomas Huth (2):
>    hw: Fix problem with the A*MPCORE switches in the Kconfig files
>    hw: Add a Kconfig switch for the TYPE_CPU_CLUSTER device

Thanks, series queued.

