Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE4C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeGj-0001Mb-Vq; Tue, 02 Jul 2024 10:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOeGh-0001G4-58
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:14:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOeGe-0006D6-Td
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:14:02 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so30665425ad.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929639; x=1720534439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YcBvk2dbGB7VtbEXR/wh8uTaeMJm+lOTQpKSurAb/I=;
 b=r8ZGO6I0Tbqk9TYUJfBWzzRFI51ria/gKEHpW9dw7YMA0XTnjv87n2DWt0rNXOzoPN
 AhW7QTLkSuvqyfrF4jOEfJuf0/abj0cpjIKKm/8+3tT4FLIOHZOLJ3gYxWDAc9Lt69tW
 BPprlSBcB7amUR5kS7AOAuGdNaAMOHNfA97qDrUHlpT5jZc6MF9W6GnlRh/Ncf9EvaTT
 zWG0BMfI+fjZxFL6L3yyn7Rpum+eFyFFUT1krcUcicaoFcEUVOg+mad8VcO76Ui4z4/L
 3XV3N9YIiTUC2shSMM/y+WUt4D2OkQGippzhbXPYxRE9Yp+q5LtsN4En/Lg1Cnll4EZp
 R3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929639; x=1720534439;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YcBvk2dbGB7VtbEXR/wh8uTaeMJm+lOTQpKSurAb/I=;
 b=QZwOKs7/oieFKDrXs5dlbecQRSZfivX3GIo8VSyjCZ95NBoel1PuFYTQtWz0QgVveT
 HG1deOnqGq17+Rxxh/RKIyBiMP+dG9lruKhilHwFfS7XUHDeytUaz6s+Sgl/PsOJ+5H/
 yjlK7+9UJOBcjqJj7ecRQYH3oAUtykQZ3ZQ8VevsiI/s5u0wool5BdXuzQaB18JwLAbr
 NW3OPu1oSciPO3NVBfeANbkdNKEHuHEWeuBvNhhBFqO8w+9mH8kMmRmRCdTe76hQfHkL
 zQNzgVtvJmPO63YwddQpgRJVkeSxeqqdmK4RehgH57dXObOZsTSjrDGDrICNY2TUclP5
 UiEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNpKU+Fw6saKWeLicxQoL82D+GW//ZRMoNM5/McPfKXEksrT6atlysoX10s+ocEX1L4dkJV8LkyjfwVcUbVqTNbe+Yew=
X-Gm-Message-State: AOJu0YzkZ43okWx+Lmkd2EdyNj9Glkl36mfTXf6U0yaCPOprn6yNpHUu
 Dgn5ECBarNu8uHANg7xgBzYvLIYqH5qwBB24+0doAmQtWK92R/IfrrrdWHezn+4=
X-Google-Smtp-Source: AGHT+IGAM8lLY7eTW3eGi2WaQoBenEfxlKNobhIsNpKovbN831lD3t2GRQR3X5eHtpjCDgsmiDdIPg==
X-Received: by 2002:a17:902:f70b:b0:1fa:92ee:38e0 with SMTP id
 d9443c01a7336-1fadb433a9dmr124911535ad.12.1719929638789; 
 Tue, 02 Jul 2024 07:13:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb0bfe6564sm3758795ad.206.2024.07.02.07.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:13:58 -0700 (PDT)
Message-ID: <6cc708b5-5d6f-42c2-9bc6-820abb3eea94@linaro.org>
Date: Tue, 2 Jul 2024 07:13:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org> <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
 <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
 <mvmr0cdjjlh.fsf@suse.de> <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org>
 <mvm7ce4jjvf.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvm7ce4jjvf.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/2/24 01:09, Andreas Schwab wrote:
> On Jul 01 2024, Richard Henderson wrote:
> 
>> With -d page, I get
>>
>> Locating guest address space @ 0x3f4000
> 
> Why do you get a different address?
> 

Come on, man.  Please answer my question:

> Now I need to know about your qemu version and build configuration. 


r~

