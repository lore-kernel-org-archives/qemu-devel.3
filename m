Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5942DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF41H-000404-9v; Wed, 05 Jun 2024 23:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF41F-0003zt-Qh
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:42:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF41D-0005uN-0w
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:42:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f480624d0dso4976145ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717645344; x=1718250144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jHDWegXe5NXAKopAMrt5aDB6pxak4QB04rSLO7shvtA=;
 b=u28PZ+VflIrQMsaTvCIVkn3DrYn76xai2nR/cmKdCm8eFpqiA5FwWAs6DmaSLomPIo
 35mVfPpi/98gPZANKau//+eMSySM0n4d6CaGvQpb6PV/h4nGz4w9nwK+haqL8SDeiSLn
 b1ty+g8bKbGOLwyv8xedoDxhbQKmsL/U3p1L8FXxotP9dKwDd5d4EEvPCfe4DtOZ13gv
 JUpkvNUhGORjOp58K+Z7rDPZip27e89NTenkwGT4fbNNnZDrr0dwMB6Y3oaGMjtpQiJt
 R/QpF0apFmvcdjmlhAXW2kzarZnkWSnE3txnVmYetTH6bYufQSYs9MCfpuU0/n7fOBhH
 mY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717645344; x=1718250144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jHDWegXe5NXAKopAMrt5aDB6pxak4QB04rSLO7shvtA=;
 b=VfCokGGvFdqRc03WQrmF0OXQTaIiW/ZULk27kzWGOf2zzyg9YmUQsakNJ7zPDEkJKX
 71frmf7opX/NFXYKYQp4SECNxuZrqN5YkwMlaioJpmz9gp0NJfS6PwGD5DYp6bSpai0n
 VMRRjEibsUIIvXxw3Y9mtlq1UBES7zACiPWw2lgQkUzxLKv/azE6Ow7umwOz6p3MaMRr
 kOXJRrT3U4jf5XtlzWriR2MZs40n6CfGOU+bEfQ+5DsjaOGcdZrLpCb/Dbtrm3NNdf4+
 qc0P83mssopItQdtIM61ltEZc72tgpzRej9lvh2sLQ7AzIZ16/qONUtOylY9J7/rNDis
 z2KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhOWZFzWX6/OMo51aW6uE8u3u2xXQf1ZgkcXsEzkxLu59fey38/P/Xz1MrG7RMvAOVpXIqf1d9YWKOQbsJp8bnlhl9u8U=
X-Gm-Message-State: AOJu0YyHIAemP3vcTqxDsHQULy8NIsIrTYtNrWq20eNmI3zklRIZa2VW
 zP4SDofx03W0x6v0My9jKK1oZcxgs29JOsnS21K1XvZ6lavny719F52QiCppNNo=
X-Google-Smtp-Source: AGHT+IGkjnz5QLZGGV0xsBKW0MWSmKgcldjeVNB18u9xIzCuV0+yqbWnbceyN3w2Hnx1AydFxT0J0A==
X-Received: by 2002:a17:903:1d2:b0:1f4:5c6e:3a9b with SMTP id
 d9443c01a7336-1f6a5a6991amr55186035ad.44.1717645344051; 
 Wed, 05 Jun 2024 20:42:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7ccdecsm3138985ad.177.2024.06.05.20.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 20:42:23 -0700 (PDT)
Message-ID: <5dc13c38-353b-4f17-97f3-fefd7f188570@linaro.org>
Date: Wed, 5 Jun 2024 20:42:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] util/bufferiszero: Add simd acceleration for
 loongarch64
To: maobibo <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-3-maobibo@loongson.cn>
 <5d78d82d-a939-4103-8411-507b1a0372ac@linaro.org>
 <7b4c6909-40e8-def7-03e8-18a3303295f1@loongson.cn>
 <58ba9ea7-cc45-47d4-a278-3777b496cb44@linaro.org>
 <d504ffbb-353a-452f-bfb1-2640ee1badc9@linaro.org>
 <da613eb1-65f8-b690-4517-04640581261b@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <da613eb1-65f8-b690-4517-04640581261b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/5/24 20:36, maobibo wrote:
>>> static biz_accel_fn const accel_table[] = {
>>>      buffer_is_zero_int_ge256,
>>> #ifdef __loongarch_sx
>>>      buffer_is_zero_lsx,
>>> #endif
>>> #ifdef __loongarch_asx
>>>      buffer_is_zero_lasx,
>>> #endif
>>> };
>>>
>>> static unsigned best_accel(void)
>>> {
>>> #ifdef __loongarch_asx
>>>      /* lasx may be index 1 or 2, but always last */
>>>      return ARRAY_SIZE(accel_table) - 1;
>>> #else
>>>      /* lsx is always index 1 */
>>>      return 1;
>>> #endif
>>> }
> size of accel_table is decided at compile-time, will it be better if runtime checking is 
> added also?  something like this:
> 
>   unsigned info = cpuinfo_init();
> 
>   #ifdef __loongarch_asx
>   if (info & CPUINFO_LASX) {
>        /* lasx may be index 1 or 2, but always last */
>        return ARRAY_SIZE(accel_table) - 1;
>   }
>   #endif

No, because the ifdef checks that the *compiler* is prepared to use LASX/LSX instructions 
itself without further checks.  There's no point in qemu checking further.


r~

