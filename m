Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B532C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOmXr-0000Na-4P; Tue, 02 Jul 2024 19:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOmXm-0000K1-J4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:04:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOmXk-0007RK-Sl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:04:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so36647695ad.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719961451; x=1720566251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zr971XPG8EUVSGL4jrwNJ0XNcz64ejWGU7FEWaNDXz8=;
 b=za+b3WzWecleVItuRZptZc60tzC53YXnRC8rgR+vJkqs57e36wujNweioWZ0Tm1n2Y
 yKa8RluIy7BBtzAzIf9LDX/koZz6OP35fc4rmvwEz1Ems50fyhbu1G8Zq5gQQqBOfJ4a
 6en5dkS2hjfqqrlm1sUmc0Uivi+kGUXefVIY7C03/ebqTWvTCHdoqCF/wrpL+zOIK2rW
 a4z6VL5ym6MxV+acy41nZERYkvAOrzXiv7ZOFq6MnUJ6faevPECgCkIabpJKdKzffQET
 jjGnaZzTxA7njx4E0ERAycWYDor0A9zFyKWXl/pw2+9/FruCXdcb/5bekV5Ch1P3QEe9
 tJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719961451; x=1720566251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zr971XPG8EUVSGL4jrwNJ0XNcz64ejWGU7FEWaNDXz8=;
 b=Ju+q8XHlucVFnRgz8QxrGF15waNRzNiQQ4T4w2YNJF5BXBsGPvwX7+ItMoXG/SQgXL
 i9zc3E1RoZcCFjTbmXUgk4JaKVOBOz8X1dGgHSPwe7G7t3JJbsTAcJ5SVuXN8egCrjpW
 12uMqpkEljvJdysEI/F3oMBSckIRqvpwEQEunAka76NXVejebxS+IGyhSiCxdJyxhY6R
 utRZRBXjnb2rWDyDDfVW4HWsq1qbnrmY6oTpS7xTdm/X44HETJy+JlUfjcqiWpWP8/Sb
 KnCDcIrY1d+OSvazXs8ZUuf8j5x2cXQN0bX6C/EL5+2KP+fN00AAqhvq8N1/pvnnX8pY
 nW/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW00mBXzH5ob704rQeHSZ0Mj+/v+GakMjbDfj8eMGCyAcZ0UzUTmpjk7DoED9S6CyAw6bXC8LE/2fMcCRKlUNk3rZ2LodE=
X-Gm-Message-State: AOJu0YzM/nGRkD2wbuUITMOyRbpMe9g+GoHrwGkzaFfzMV9Upd4v5Q8x
 pAKWaiB69GltCEhtEhZmVbE+XX2UyOOHpyJxu0Bss0ZCUBvRLq7p/GUL5UZdXi0=
X-Google-Smtp-Source: AGHT+IEMySXIwhRI+V69MNAwe+whXi/ptMLQ2N8NEuiYaNic9YrW9rIrPDGHQ9PvJlE/32xJtyhM4Q==
X-Received: by 2002:a17:902:ce11:b0:1f9:d0da:5b2f with SMTP id
 d9443c01a7336-1fadbcaa785mr99531895ad.39.1719961450998; 
 Tue, 02 Jul 2024 16:04:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fad2eb7cdesm81091415ad.146.2024.07.02.16.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 16:04:10 -0700 (PDT)
Message-ID: <57829ece-acde-4719-a82c-e3eef0daca84@linaro.org>
Date: Tue, 2 Jul 2024 16:04:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-2-richard.henderson@linaro.org>
 <360734c3-df2a-49cb-892a-0eb7953fa1c1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <360734c3-df2a-49cb-892a-0eb7953fa1c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/2/24 12:55, Philippe Mathieu-Daudé wrote:
> On 27/6/24 20:03, Richard Henderson wrote:
...
>> +            info |= !got_sigill * CPUINFO_ZBA;
> 
> A bit too optimized to my taste, 'if (sigill) info|=ZBA' would be simpler to follow. 

I switched to "info |= got_sigill ? 0 : CPUINFO_ZBA".

> Otherwise,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks.


r~

