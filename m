Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F237CF9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXY9-0005Oa-Fx; Wed, 22 Apr 2026 09:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFXY3-0005O2-Ts
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:23:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFXY2-0006rz-Dk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:23:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso3467637f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776864201; x=1777469001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IN4w6v8X9e+Hem17KkkQplrF/oFkdnizLQZBS8jKb4U=;
 b=Im57YciWu5Vs3MVxtA1gYfbMu0PyeyTnJH0t4Zj+PnOOyVlW8+PYGFY73MnRO1MKZW
 JyZ3Tevh+/EX53w0+Tr9mSM9HUzso+8Bh8FbYcQHmEeusMHnCuWgBETRONdQ6l/cCLvZ
 53yoLd+ysMhysyF5NCEECKuTfa/BDXar/JXgLdYUKveneMSJ1XiJqV9Eg/P2bZ2Rb/TN
 ClkYaj6pY9aB1tN/AN1vHbGpREZxYxsnoZ+vsQbgc3iUaZP4eTCzbifE9AoAoeIXki2j
 v+SZT9GtuJQNHcO+UPcr12mvMzXyWgKvNl+OrCrG1o7ngN3D59ymU0Lh7P+NjWfQ547i
 SwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776864201; x=1777469001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IN4w6v8X9e+Hem17KkkQplrF/oFkdnizLQZBS8jKb4U=;
 b=Uwttmxvite7r0nxCa7IS7wCsig9QPOlIKYuMAn3dksvyHssiTMT5Dl5AYAZdOnYs2v
 zgMN/IhIocBM85N/HY70boYZjl6Cbh9p5YBbIB23rzmNLWTNgYnF+Z6Mmo4qE2wu3Jc+
 mbnchv57Yqq/mfkpS7cJQVX3FL1R6r75FDrep9d+OvIogq6Ga8ynpfcCDeCXgxZXxsIT
 SdK7PtUepYLLPIwyAbr1BTZqc8k0H1D8UZmQRDttcbB/foB00T8ow4vP5TWaCo4CBDMr
 LN37apvo8BFMQmKfEAzp4gREx+RvHThBBWn5DNXhavefYN9RUi7xbBaKVIQpUysHEubC
 TvEQ==
X-Gm-Message-State: AOJu0YzF+KDTT7egOngMJ3ufpPYrLiE3Ad5N3ge2kfWnSuzftWue8uJt
 dpo0b8jzSk5r0lsqWtJZYED4biRdHeHPjOW/oJYzBbcOnG0relt5IvyAJFQqVKOcnO0=
X-Gm-Gg: AeBDies/C7vI3wie3xWiw9WFpsGlpYfKawhwHZ2GKwG0VshzrM89opWtcO8wG/5aIMU
 PYI79tCb+lHZt2a6MTNh5EXqiT+5kNujscN2/4f5/ZbFTkjc8mNCDKuTt6leJ0N4vqfjl6qTakO
 Rqq07cKeXFkfWjl8hFCzlLGGM7LvzLfmy9tcLrnWIUw1n22z2d3jnkfz/+cUnpzr/Ks/l7OTyie
 9OU6lF+91CpdMafrziB3c07z2dv09r1C8VwNpo6vIqLXuTzfgTjJtLviaBKbDicnJTvLSTNE6Th
 0NraiS02xLMpKhW2mnTMj3DtSEvgXD+NEXSyP9tg4jr9jnQxby+uhLZjocV20bTLh631gLQhH85
 zBYMnS4LbjTO1oJopygLdmpMeZtuV9lJIRpD0fyOMioEUyvWt7htDZopVgE3R4iluOO+BGYwikQ
 l7fhMhApoP2jaMEdbC8AjcRrPoZhwCKkc0PUmudMP6919S+lJJUWC1J2kZ8QkwPJJdM/3iqrwtG
 zb0
X-Received: by 2002:a05:6000:184b:b0:43d:6787:993b with SMTP id
 ffacd0b85a97d-43fe3db3c50mr34935481f8f.6.1776864200550; 
 Wed, 22 Apr 2026 06:23:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc07bbsm48699570f8f.11.2026.04.22.06.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:23:19 -0700 (PDT)
Message-ID: <287abe6a-b007-460e-ba59-72ae254a29c5@linaro.org>
Date: Wed, 22 Apr 2026 15:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: Report TPR accesses to HVF
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@linux.microsoft.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
References: <20250616090632.55214-1-philmd@linaro.org>
 <aGSZkJeoMVI0yCuM@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aGSZkJeoMVI0yCuM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/7/25 04:29, Zhao Liu wrote:
> On Mon, Jun 16, 2025 at 11:06:32AM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Mon, 16 Jun 2025 11:06:32 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [RFC PATCH] target/i386: Report TPR accesses to HVF
>> X-Mailer: git-send-email 2.49.0
>>
>> HVF should be able to handle task priority register accesses.
>>
>> Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: Untested as I don't have access to such setup, noticed
>> during code review.
>> ---
>>   target/i386/helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Untested too. But code looks fine for me,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 

Thanks Zhao!

