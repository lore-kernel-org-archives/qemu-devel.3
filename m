Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3604AC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZ5U-0003lJ-5m; Wed, 24 Jul 2024 06:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWZ5S-0003ko-Qx
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:19:10 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWZ5R-0003xT-3M
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:19:10 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d9dbbaa731so3210621b6e.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721816348; x=1722421148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RsOKIH/E9WIxgG9wbuymhAzIfAPBi4M1BmntaRuhNDo=;
 b=qibycsO4WWAakviV9X1hXocWxtvxhLX1YCm+lCq7PvQ23oGoyyJuThNsYVmeu25W0j
 cXntAexn1+JQsRuqe737T6yl4IxHETFwgChnKw7tDoOoVIcsGFsdd421xaxmzgDLW3eh
 ojSFLoQwkdywFRIz40I9A5AxD9+JyHZxlsNvDzF12OtBBDTfOFqd0nsTPAMbRybb/Jjk
 luoOP2mvcd9+QF7pcY/FUBBdZ1O5qlhud4KAAtRyyDKzG/mh1kbkdiigHZpMSNB06En/
 1jicXZOPBI/LZ5bJM10F00o/eLEnim9bFm2dTWa2D9u7jzl+G4xK4UKnh8+/0eAwFYZK
 6ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816348; x=1722421148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RsOKIH/E9WIxgG9wbuymhAzIfAPBi4M1BmntaRuhNDo=;
 b=JraEk0EVLluq/9jJqRXUUk6Ka8dBjNa1QJPStJ0wmMovUPlZAPMG7NYjqByNb/lD10
 XYa/KVyK1mUr4bsy6vTlxVndQaNpbiJwf/o/0gtbp6LeXIQDRqoeG8TSo8pmMLj4IY3r
 eGJwDWcijxU9OHI9DHXksvTYjo9xSx2XUF/5D2u6ng33KT25zdAq56mX2vbumsIgIwpx
 WH+ViLz9CYVTgwk6QWJnYQ39YHAahrGV+Dv5hDXz8uKuub1Cd2z9Hm896YzoSNhneoq0
 YruCwJ7FwgT0phnpRwpnG6ctF3Mw+Yae3jHJagT6vddWLOpVsLSECH881CqjRX/UPN/l
 eq6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7aC5P7DykqLFH0wYOBbrkfAQvMIUc9rBRG33Kg0wE3f2t9DVOy1avL3LmifocC+YHFnEaFngjRhKVtcoeocCk/7wUAq8=
X-Gm-Message-State: AOJu0Yw9FGXOjKungXasyxDbbo7An9EGpudugi13SDdTFtaBzj9VsPln
 qVNtpkzHNJVvs1/QDKAlQUKhDRhSF1eUaU/YCTCfnIXEX7r8vRYrFThhz8KnbbY=
X-Google-Smtp-Source: AGHT+IGKLbBKNJPclEc8hXtaiwD/xHwHPgEfP51u7pDKIyOzQLhxxiEN0cZxii8BSu/TmpPKsGjfvw==
X-Received: by 2002:a05:6871:b24:b0:261:1cd4:cd9b with SMTP id
 586e51a60fabf-264876bf40emr2547711fac.17.1721816347761; 
 Wed, 24 Jul 2024 03:19:07 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a1a1b9c8f9sm4652399a12.26.2024.07.24.03.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 03:19:07 -0700 (PDT)
Message-ID: <05e5ac91-90b2-45ed-a614-267edb8e0e0b@linaro.org>
Date: Wed, 24 Jul 2024 20:19:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] gdbstub: Add support for MTE in system mode
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722160709.1677430-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 7/23/24 02:07, Gustavo Romero wrote:
> This commit makes handle_q_memtag, handle_q_isaddresstagged, and
> handle_Q_memtag stubs build for system mode, allowing all GDB
> 'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
> mode.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   target/arm/gdbstub64.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

