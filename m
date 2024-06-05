Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CB7C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEt59-0000cf-DV; Wed, 05 Jun 2024 12:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEt58-0000b2-Gf
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:01:46 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEt56-0007gE-EE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:01:46 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso48465ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717603301; x=1718208101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mZkrt/ff2c6/pmUpYBPDaphRSPh2DhbTCRB1YNCx6rA=;
 b=x326wAIaecm7a3dbqA3PyTNPyNB6eG1Ls3Cl3rN5OyN3zkbdT+3HFXgoekcFnTh312
 D+ElawRVz/1YlnLmpOaFrYaRgMK+JESpDNcYRgSIX1FaVws3wlcI//kkXoYq/2EM3+pT
 hOWe1PBjJ6+B0St6/eYhqNOxIVm/WfekuMmurY4rPk1DYqFa0NPy6rmsM/PqPcEftz6o
 Qi/n0JKNseM0lo/d5HDQxKNjqQeYjIJzul5e2QH+6IsHMNYOMEmdOGPuQSBdqGP3sRNr
 mVDJAULwH42s4ZVg+VGBYLSap/r2vCk6n/esd5hJiZARdNuZRZ31UqrjZIuQWGf94pUr
 G30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717603301; x=1718208101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZkrt/ff2c6/pmUpYBPDaphRSPh2DhbTCRB1YNCx6rA=;
 b=nsYk3Ou+omWYjrn+Gue28Bv9rmrTtgdlAO+zUJmgonpsjEMcV8sWzTWEUahM0MjrUb
 iNPVS8GbHRCSruqlmMW7gfxowR0J/SVeZu6aq2S32+G5rSrTKsjXGOo1WNPCdRNYGsJC
 TWc2+zTakOBI9444i2/SyC4kLMQX5JYtGD2cdB0oBM6pBGi58Ik7oWmBHznK1Jg5HCfe
 LPXBMzn8ya++Pxcp8Xa8DyH6LNWU3ljUKmMOaWEgOAEjCB/rVgb8vBCJk0X0s9huQjHD
 NJA0fRqj670u+PE8WHENd06jGLrcZpRCxcNGqxox4Ftvl4Ns+C1vGZ5NG/DkvaVNVo0G
 u21A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbbTtAzUiXfdwW60XE7TyMsOJCdhf+f0oLnHY4LCORpSOeaEw8MMToRo7j/ijJfb5Q+YNJZZBiF9eaCJ05/LSCPAJLwVU=
X-Gm-Message-State: AOJu0YxCDR/kdzJJ7nzEOJlkx79O+9J6RFh9OlMY2W8FEGQXDuVmfzZX
 SU2xFXlmvwviY+zWAcnme6k4EDbQ46rMelNAmQrUeNPcqmYu55UPRNkRJXGSTHI=
X-Google-Smtp-Source: AGHT+IG4TTQgYz8xbGGIAZo9FaMAfTodKDPpCynQWhyOoP/8u8AdcTGXyh47EAVeYNrQeqgO10G2jw==
X-Received: by 2002:a17:902:dac1:b0:1f6:6313:66a5 with SMTP id
 d9443c01a7336-1f6a5904431mr34717515ad.11.1717603299545; 
 Wed, 05 Jun 2024 09:01:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63235f88dsm105365855ad.88.2024.06.05.09.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 09:01:39 -0700 (PDT)
Message-ID: <3a1c870c-f708-482d-802a-d3230b398c28@linaro.org>
Date: Wed, 5 Jun 2024 09:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 36/46] bios-tables-test: Add data for complex numa test
 (GI, GP etc)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
 <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
 <2eefcbdb-ad41-465a-9c14-1dc15bfff94a@linaro.org>
 <20240605162733.00007d8d@Huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240605162733.00007d8d@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/5/24 10:27, Jonathan Cameron wrote:
>> This fails testing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/7021105504
>>
>> acpi-test: Warning! SRAT binary file mismatch. Actual [aml:/tmp/aml-GHR6O2], Expected
>> [aml:tests/data/acpi/q35/SRAT.acpihmat-generic-x].
>> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected
>> files.
>> to see ASL diff between mismatched files install IASL, rebuild QEMU from scratch and
>> re-run tests with V=1 environment variable set**
>> ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: assertion failed:
>> (all_tables_match)
>> Bail out! ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: assertion failed:
>> (all_tables_match)
>> Aborted (core dumped)
>>
> 
> s390 and passes on an x86 host, so I guess an endian bug - any chance of a table dump
> from someone with access to an s390 host?

Sure.  By what incantation do I produce a dump?


r~

