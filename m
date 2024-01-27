Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6564C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTa64-0006oH-Oq; Fri, 26 Jan 2024 23:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTa62-0006my-Mb
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:15:10 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTa60-0003QI-0H
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:15:10 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-595ac2b6c59so676697eaf.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706328905; x=1706933705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZC3aWTJ7Sqf/1Snv1mQ9Qj8KKtrDirAfwaj+zi70og=;
 b=ZEoXuP0LF0N54TMUaVhHvNJY3CmegtdedRbA1uKcdsgHYoW2Cy661DDJTHzG7TS+NU
 ujwbCskW+a4UdLTIo+dg/pawPV+bSYARlmx19y4nmAg0SJKjDinumVzutR1m3iNTtMow
 fkiXXObDkvhqKn2slKesttcLMINPTLhEacQN8g/ojCTmxEd/yOnq8IDBFh6FF/vEr1Q4
 JeILgeVTW30AXS2AERPwdwZO2CDdv/TdHQDbS14V+elBVLQpj7NHoQ+EQ2ZCLpoezMNP
 piXoSuWQWYXrnckVmZqjih8likm4REwKdt91pWfF9wVwo6ABFXxkkiZM9/xSXV5MXiUH
 fepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706328905; x=1706933705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZC3aWTJ7Sqf/1Snv1mQ9Qj8KKtrDirAfwaj+zi70og=;
 b=cYH5pqdMnTVIwCEOVN3tRbtWg+4s+I8XJvL1bwJkDywAMGws6pp9j6Dy63JWJ82OxZ
 RDoyD/lpxu/tyFGTwUBzwyflcHNGtfsWqgS971A/nOHocRcISmvNqJAhqbHdSgjF9B/o
 XOdyRerQAn1fxQCOqYuhl1ehrGSH56XrXkhgOVMVQJGpnLYPUu/1uQSEchdgPiHNOXhw
 nGAUgINMN0m3eQFgLo1Zr3I4hWdD/jx77A/WJguXLPGbJNIFbXSbwYm3DwGqnwpKk57P
 YUYtxHUEXq2UTaEcNs38kfTfS/Ipyuq3RFRT7S+jVnE8IP279Qdol56+VzNrzHuUhSGe
 o+Og==
X-Gm-Message-State: AOJu0Yxpwj32CENiR4SKGMBfKTQ0n4NpRjSW0TLSPJYgjUtAHxs8yUI3
 j+3hgI63/9dDPjJqswGKLhOWMyLLZ3s/UXsG5ZKMbNAOcE/wTfYLbx3f1o5Fp94=
X-Google-Smtp-Source: AGHT+IE+SBHqmjew3GArKrvch/AcslNTimykBQi757aR+QOA+h4Eu8as8bnudvilocgLSagZowPTew==
X-Received: by 2002:a05:6358:ee90:b0:176:7f65:85b1 with SMTP id
 il16-20020a056358ee9000b001767f6585b1mr983966rwb.45.1706328905140; 
 Fri, 26 Jan 2024 20:15:05 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a170902eac600b001d73ac05559sm1649447pld.184.2024.01.26.20.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:15:04 -0800 (PST)
Message-ID: <d321e939-a0f5-4bb4-940d-ae6678fa2d8f@linaro.org>
Date: Sat, 27 Jan 2024 14:14:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] hw/acpi/cpu: Use CPUState typedef
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> QEMU coding style recommend using structure typedefs:
> https://www.qemu.org/docs/master/devel/style.html#typedefs
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/acpi/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

