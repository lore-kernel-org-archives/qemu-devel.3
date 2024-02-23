Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3E1C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOy1-0002Xe-6p; Fri, 23 Feb 2024 01:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOxz-0002XR-N0
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:23:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOxu-0000Vm-If
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:23:27 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so311637f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708669400; x=1709274200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kLeKvlMb3wGlcLhnVSk9eXKaCxlb27jnugpkFeDiUME=;
 b=rkoAuw4YSmeXl9wh9NjNFV1lsG43VoBE59bOTExO4PGxpBK0EMNE9zG5/d1S1p0hDj
 kn32GQeWjnorc65iWYa8JIArKefK65q4UNTvDx5hWJQk7brrGBFXk3UIv1MAm9d1BEUE
 6z0gaaD1rddno5QN0N6O4KKrrgGUqooq5y4Rt+dwclPVUrEJ6VD6f/N7P6f5qHg6xtnF
 5eIgS2Jjh9t96017tpJg+Crh6qNTRaOFx8AH3X66Qmzszf5GQhXGZvpgoOz9ZS6tQEhN
 9uGNdn1Or5GYnLjtuwduTGeS8sXY93/3jm+bIQLMeXvRFoyW018YXQlzeD4neMTTNtYd
 FaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708669400; x=1709274200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kLeKvlMb3wGlcLhnVSk9eXKaCxlb27jnugpkFeDiUME=;
 b=Xi5Xd8Hd4LqYl6z17537VmkqL8DtPCyTfyaXWLTezd9sv0m4rPf5gRWHa3I0qBefQE
 1EG+yslUAE+FNVlEHH8BHOYh6v0uXCaBwZy07XKgz1gOAFtHhvg/lHt27/KhjQiiWcv4
 7zX9OmOz1HyH5Bu4x9RHT1O9YWDCKRgRgAnc314woQ/EYmDYFi36PuYB85SXBq5Hr4Vr
 pZEYGpAyOoNsl/Ke00Ks1JKaodGVo+xeu/NXGeZ+ETZgk6RBKtL8MlvG6kaHPKz56+3a
 iSMCSwyOSaoDftcA8qFamhaiyT65xqKamrgjay6bINUJbu0EExjUI/ZFknwF6Nu4q5bj
 Iu7A==
X-Gm-Message-State: AOJu0Ywuujn4trMBcWRPT+g2CvU0c0DJZ12kp12ppriwNURbLhZSyMA4
 LL9S8j6+5r3pT86G5OErHLQ5sfi70ebychLyDGW/vDzB0s0gt0NrU4pvOQ0vRSo=
X-Google-Smtp-Source: AGHT+IHZonBSHBqKECocMcHd719VvfQXcT0pMnutDOrKkhMWvn5AUZGCSkAfrhc/sWOTrXipvztEGQ==
X-Received: by 2002:a5d:6288:0:b0:33d:9ee9:3c15 with SMTP id
 k8-20020a5d6288000000b0033d9ee93c15mr716595wru.1.1708669400276; 
 Thu, 22 Feb 2024 22:23:20 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 r1-20020a5d6941000000b0033d8aeb229csm1507775wrw.27.2024.02.22.22.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 22:23:19 -0800 (PST)
Message-ID: <fe96d71d-6abc-43f7-9b83-8bec93ab5512@linaro.org>
Date: Fri, 23 Feb 2024 07:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add support for I2C in BCM2835 boards
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
 <CAFEAcA8GFFQ-L6zGcft9q8arJxuggraHYRhcAf4q+Oi+VMSP3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8GFFQ-L6zGcft9q8arJxuggraHYRhcAf4q+Oi+VMSP3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Peter,

On 22/2/24 18:54, Peter Maydell wrote:
> On Tue, 20 Feb 2024 at 13:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>>
>> This patch series implements support for the Broadcom Serial Controller used
>> by BCM2835 based boards for I2C.


>> Rayhan Faizel (3):
>>    hw/i2c: Implement Broadcom Serial Controller (BSC)
>>    hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
>>    tests/qtest: Add testcase for BCM2835 BSC
> 
> 
> 
> Applied to target-arm.next, thanks.

Sorry I didn't notice earlier, the I2C[3] IRQ lines have
to be OR-ed using a TYPE_OR_IRQ object before reaching the
INTC. I'd rather a v4, but if you already posted your PR
this can get fixed on top.

Regards,

Phil.

