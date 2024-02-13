Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A211AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvum-0002G4-Aj; Tue, 13 Feb 2024 11:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvuU-0002Fe-1A
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:45:30 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvuS-0007xS-FY
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:45:29 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so3739188a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707842726; x=1708447526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQaVpM5FQtoOL28pduYAu14hUalCH0DhN6OR4enHrIU=;
 b=pL/fiVtVQp2hYGEZXUNiqKxm9tiZR+4PRQ1neQyh9VYEDtRB35y1FwWJZML8/iLz7d
 izkRNE/jlBz1E+SOqc6nEyY5ok/5gsMBMkbtSn2AnK/b4TYITIaaCAGY9nTgoE8PsQ45
 VQgEaNB1LKSIAcbDDGNaFYZZblNsDzTOPSEoLE0ZJoKDqG3SuVBZZ4HULu3b9EOGgnuq
 csSuCXVeOvv1IjuhGr/rrFO/txBJFC+ZcXOwBPtSzAADvej2RDYGY5dgAarBKlBarYel
 4NkrbloOgYf58spqcAL1E4cTI33UVIQ0khPR37RYFB92/Zbc/ETXJhmL2JUefAvewbXe
 NZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707842726; x=1708447526;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQaVpM5FQtoOL28pduYAu14hUalCH0DhN6OR4enHrIU=;
 b=cxqMc5K8ZOBTLnV2xFNqz+ie42wjFzcACN31lvhsEPzENtAAxzNFo83I2RdCFSl1L2
 RujNVWRRdFZtH7iRwlbMq6sDxqnkZpZAk71oo177NrR++Jz1HX7p3BuMa+FN//BbBfEC
 /buijrAjl00/I9CqDUbPmllmtVGqq1760+lYPrClssquLv5vmLxWtSAk5+XlwsvZ6jFe
 csi3Fc/Bwci/VdrXnQwuYtpTIMwyr2dNlBim8F8uP2cSoqzyh1WQ9/PbvBl77tvKiKeU
 o5ZDKQaG4Q6i/J7dXM7TUh3933hDUKjZYEnahWgoCyW7sOOsZSH+8QAlH8wgHsIpU9yP
 Ho5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV0jREB4KwZbqeZ5I118V4e4Y1XC2B75OBF6uDpY2EhHJDwPQ8v+F7n0tCvbz3UTrq1XCk9X5N2zl3Ih4AR8heeFxUsvg=
X-Gm-Message-State: AOJu0Ywg1/nwzZUbPwLBitn9GKC7wvshDtarLw99/PUWnq5FV72koW2l
 VEYT7I8wK3dpEk7KVTTtYy0Ty84BDr1GULqQgLLRcPbjv/RRsUqEagiIQx6EL+0=
X-Google-Smtp-Source: AGHT+IGExxc0d/7HtaFizunIrH+Xz0AqMeQvj/BoJweZkLqAycy+aA+XAscYl6M7jecbwcwEMtNV9A==
X-Received: by 2002:a17:90b:1190:b0:296:a76a:9711 with SMTP id
 gk16-20020a17090b119000b00296a76a9711mr15661pjb.12.1707842726352; 
 Tue, 13 Feb 2024 08:45:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2lUJtDjOdecCwNG6V9XdcR7Szg40JFnhYe9AMShnv+7i6OIWfP7p4ca60ebAavWfZlFooee0VXXtITJLdCjEiBASxT8U=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ep23-20020a17090ae65700b00298a1d613c4sm1832683pjb.27.2024.02.13.08.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:45:26 -0800 (PST)
Message-ID: <c9c43380-04fa-4c56-8422-2e5890917c97@linaro.org>
Date: Tue, 13 Feb 2024 06:45:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/ide/ahci: Convert AHCIState::ports to unsigned
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
> AHCIState::ports should be unsigned. Besides, we never
> check it for negative value. It is unlikely it was ever
> used with more than INT32_MAX ports, so it is safe to
> convert it to unsigned.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/ide/ahci.h | 2 +-
>   hw/ide/ahci.c         | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

