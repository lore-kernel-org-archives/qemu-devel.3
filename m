Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24459CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsinT-0003h9-JX; Fri, 05 Apr 2024 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsinP-0003dh-BN
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:35:51 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsinN-0001Ps-5W
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:35:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e2ac1c16aso1326228a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712320546; x=1712925346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HCV/CKFYzt6PbDpGq3NtAJIieHqlVFOe09y/dUma1ig=;
 b=Fl4IxzH/X5hai6qP870BtKfxIeuRp/c/m1Q8Vd8OcWG2qYUObCZLwauKS7SgQWFywF
 381EogfygG/tAOYNgHcz6hXLpm5YoW6piygIGhLlkh8v8DWeQK2gyXY0nuW1vLrBZd05
 Ynzgm+TRRN3r77Ei/5xtU5owlfJVlpt84sPpg4CMnxVBgP8ZHlp1WXjgwp5l8EzqviGU
 yo71U4vjAxmKN256kRmGsV2OjlUmhDEbga/6l7p+xv2kioUesfGn6Gg2pVb5+GtBL+Io
 X8LgBskNlIPxhkw0h3FCrwzCHp6I0O+wk/sVL7kCncZILV1ErW7DfnxylRZg3+3OP5tM
 7eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712320546; x=1712925346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HCV/CKFYzt6PbDpGq3NtAJIieHqlVFOe09y/dUma1ig=;
 b=nL4qBQzx+nOhIf/+odTZ6YPeW72x97Sv1lz4ZNoEKs4D2q0hDYiTBgEDTTZudEnFPz
 KGuQb+Jv0/0/yE12KBIlJT2wmbCwJltnJX5RVfXuW3Djud5P1W1tYgFT6zaxE7pRrWaR
 WR24tJavA3GnTQp3cgaP6U/pnLXPtxwO31YxBsGYTAElD1jwFIq8RWbH40w9GUTDxxBL
 CVWVybN+V00JJfcxppPJx4vfWKMaNQhcKcwmZEAE/mQcbmxD/Av29XgCk3F1+5TCT+EV
 4RGhOk3GLVQVu168XsAEG4vU1UteTuN3OZR4APfIJGGzZFFIg+O9rcFvYHrO+WB2XrgJ
 t1uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA37v4S07qgavbVfsRZ1nFbySrdxSVF4dYFM5P1aUIqDc+jLHhqqktRgZK0gXiJUQmyUeYGKxc06WD5rnf1OikWWkhJ6I=
X-Gm-Message-State: AOJu0YzrfcKiiK8xk/ubA9enEQno/MHGm54gluTtp9aX7YRc54LReeAP
 Ospip3gcqQVFcE3WbEcJU4E2MUs/ZmDW+wEl59Y6/7o0Hk+8WMWdyiLB3gMxdUl22KbrqLZiKrb
 x
X-Google-Smtp-Source: AGHT+IEMvnHyhnq2pZHSdDk4OtdQ/tvS6f9GywRQSS4HCgI350GFfJEMBdeMBZc73/cVL0AcLclb0A==
X-Received: by 2002:a17:906:1d5b:b0:a51:9fbb:6fdd with SMTP id
 o27-20020a1709061d5b00b00a519fbb6fddmr749346ejh.25.1712320546367; 
 Fri, 05 Apr 2024 05:35:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 jy23-20020a170907763700b00a4ea0479235sm787635ejc.107.2024.04.05.05.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:35:45 -0700 (PDT)
Message-ID: <e57e3a66-b259-4cd1-a819-1ce048ef14ad@linaro.org>
Date: Fri, 5 Apr 2024 14:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] accel/tcg: Pass DisasContextBase to
 translator_fake_ldb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h    | 5 +++--
>   accel/tcg/translator.c       | 2 +-
>   target/s390x/tcg/translate.c | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


