Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzheR-000822-2F; Wed, 24 Apr 2024 14:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzheP-00081s-UV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:47:25 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzheO-0007CQ-Ac
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:47:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f28bb6d747so222562b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713984442; x=1714589242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cWT7s+sPqbjIjCEfIrkoOtsdeckjr6P4bDwJqFXUz5E=;
 b=EjTN9HlrCa4QJ/LmcwfCx7EFQMv5oqo7UlN9YIf+JexiZox2xiNfuCXzhT4V3FvSjH
 eo48aYvRk8NEi+QKAfKzQJa9ajhe09NhPkVaNbmMiAtmvd5OCewndSzwAPK2IqVtWgby
 HCyN+y7PMkUdAxHJWXR94avV5iN1qdvM18iDAmK49mnfxRvnOCVNSWAdI+hj85ymvZjQ
 SyItt1ETIQ9K6BMZOFSFwJyF5AnE766kjkHOgvjo50RDa5W5kwDAdcvgmsd4yigQf2Nh
 FapsS2hQdb6vhWNA5/Z3DcLt3VY5TxwuCibMMvSvnyyiJNzh1/+Q7/2/HgqRJ0Ay7UVM
 6ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713984442; x=1714589242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cWT7s+sPqbjIjCEfIrkoOtsdeckjr6P4bDwJqFXUz5E=;
 b=k2eCz8H7mDzWgoOAfjGnb/XnC1Pu8UsjIN9PYt5pLrRPJJZmsmQjA0+1zy/IS8FLxQ
 8nNa3sjY2h4y2fnl6hboLZYy6U4Xjt0V75eE3ievMYlT6w6KNUS8oN1jxAB0L4zuaiZY
 p/G0iWOIr+B6G7kDxrBhrCslP+vAiWbB9ypwGds/8aUzjCogp8YrHSSfInksi9o4pRk6
 W17pt/PVukqxRazAM7s+EKiUiAjkf4htwh3vgYd1HDN05hikEQLsFIEOjo6uu4KGao6q
 +1s3ggpOPHhiV/V4FGoFqyERNz0i5mCrMZuhVrfpf2ISBpE5NtceKwRaq1Vuoq0fUWOI
 /ZDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyH369uUdyrMUdfOMxEHDKTdV3bBZJ9lqX7Z5UBr0USHhcqFcuMplLfgV+thtI+mqn+NShO+FpyeKv83Uk9Jz6sRFMi0A=
X-Gm-Message-State: AOJu0YybtuPuhmwptHaA2VVp4QURdoIUs8MudS1+y2fhmDpzG7wvGj06
 QiUNWnGJjEPsT0FE8gqVoaKlfGB4PCHwnoqz0+IXOEdN/+rVmpMBlx7fz9x78UI=
X-Google-Smtp-Source: AGHT+IHlmCV3sfv5gVBrN4VhLinaJ95YaulCuwDS7Nt/+PK5ibyuP8DF2YJG0khBIPxVhlqh3jaH9w==
X-Received: by 2002:a05:6a00:1399:b0:6ea:914e:a108 with SMTP id
 t25-20020a056a00139900b006ea914ea108mr4016180pfg.12.1713984442216; 
 Wed, 24 Apr 2024 11:47:22 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a6568c5000000b005f7ba54e499sm8907344pgt.87.2024.04.24.11.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 11:47:21 -0700 (PDT)
Message-ID: <5bc130b5-2adc-4158-8a99-4672a96cac32@linaro.org>
Date: Wed, 24 Apr 2024 11:47:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Error reporting patches for 2024-04-24
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240424080337.2782594-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/24/24 01:03, Markus Armbruster wrote:
> The following changes since commit c25df57ae8f9fe1c72eee2dab37d76d904ac382e:
> 
>    Update version for 9.0.0 release (2024-04-23 14:19:21 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-error-2024-04-24
> 
> for you to fetch changes up to be842efbe3102c6aa1980039f6d4a8f997f1ff8c:
> 
>    qapi: Inline and remove QERR_PROPERTY_VALUE_BAD definition (2024-04-24 09:50:58 +0200)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2024-04-24
> 
> ----------------------------------------------------------------
> Markus Armbruster (1):
>        error: Drop superfluous #include "qapi/qmp/qerror.h"
> 
> Philippe Mathieu-Daudé (9):
>        qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
>        qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM definition
>        qapi: Inline and remove QERR_DEVICE_NO_HOTPLUG definition
>        qapi: Inline and remove QERR_INVALID_PARAMETER definition
>        qapi: Inline QERR_INVALID_PARAMETER_TYPE definition (constant value)
>        qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE definition
>        qapi: Correct error message for 'vcpu_dirty_limit' parameter
>        qapi: Inline and remove QERR_MIGRATION_ACTIVE definition
>        qapi: Inline and remove QERR_PROPERTY_VALUE_BAD definition

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


