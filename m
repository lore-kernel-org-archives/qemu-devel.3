Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5722C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WDX-0006YG-Ek; Thu, 02 May 2024 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2WDU-0006X1-6t
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:11:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2WDS-0002dl-0k
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:11:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a55b3d57277so992918466b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714655472; x=1715260272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fU3GTrJvcXQfCND8ixDDQXceVtyUI/0gb7LP0MtZTto=;
 b=VfvoO9TQGoYSfMx0FEneZpxQ2f9r9AdAI5C6Y5X07Nqlw8D8Ow0OUfb9wnA0iUPx90
 nMMTrauVtnWU+b4aaTbAhrjGEJiD1iW3jh29WkNb3V+7tdmhtUIh2kRdecmbeSBZHRCe
 IAy7OW4ea4wLqh3MjospY+0H0s8mRWnFmBIw4Vx6uOPl0O1T+qI0Z31s8WJJeQR3Duej
 vB6lR/9+KdtyprTlSiJNMJ+h80qxwIs5EZijGy9fdlcMfJnZD+HGbIVtrplPDGx10qHA
 jFQP6q6LxH7pRokUq4qQ199nVd+A4NPC6/7MpoyWjDi8+qfX4y/r8Rzz5rUwXO4LGt3N
 7RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714655472; x=1715260272;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fU3GTrJvcXQfCND8ixDDQXceVtyUI/0gb7LP0MtZTto=;
 b=cmkZnFVPmxfxGl44Jhnth8M18D+lRXsAPjl7CV/jxDh3NuWa4PK9m44TnlFqvsmWxR
 WrpOHng5n3uaGIdtNYxio2Kglvzk8dl6Sub0ouOAMLEXdkJP6KpChT1sGlGKgFa25mA4
 Drg9iFPdcWRaX/pQQttZqA+GSzC3tJfVRff7PBwvaQ0lVriEKPBY0jYIRSty4vJH6tFc
 vLqetLvsAg4L8a0/0+8rNlojhQR5AFE1hZkjLAruViSBOk9vr+VGbMJ6CehnSqvyrVhA
 uS/H1a0YJGDokZ54h3lAawtubEkzC2Y4L1Gg1CXQdHj54C55f4hVgEOfF80Qnc6Vj9G8
 ZBjg==
X-Gm-Message-State: AOJu0YwvZFg4nf6bXzc3RF1L0KpfaqKEkyw8CfRtVz0nS3Gsm1mg4fQX
 WlELNjcApDUpVoXM8G86lfPYB7FF7uG83iO2JIO1vrKU4Myn4ClYGmwA50O0PcU=
X-Google-Smtp-Source: AGHT+IF6dyDo+usyNA2y342/w4FpRF1ksz2SsiYFmrPVi8IC2szcegebgo/81HfMS7LPBcby0JBI/A==
X-Received: by 2002:a50:9516:0:b0:568:32cc:f808 with SMTP id
 u22-20020a509516000000b0056832ccf808mr3246040eda.15.1714655472243; 
 Thu, 02 May 2024 06:11:12 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 cf27-20020a0564020b9b00b0057270606829sm518212edb.85.2024.05.02.06.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:11:11 -0700 (PDT)
Message-ID: <c696603d-b8dc-4fed-96f0-da40c6ce8287@linaro.org>
Date: Thu, 2 May 2024 15:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
 <CAFfO_h6-RXettxqnCYciDrq6ivsTHtM55FcksJSUNnLdbio4mg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAFfO_h6-RXettxqnCYciDrq6ivsTHtM55FcksJSUNnLdbio4mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62b.google.com
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

W dniu 2.05.2024 o 15:04, Dorjoy Chowdhury pisze:
>> Should "return" also have "(1 << 24) |" to have MT=1 set?
>>
>> Otherwise MPIDR_EL1 = 0x000100 can mean core0 in cluster1 or core1 in
>> cluster0.
>>
>> Value 0x1000100 shows MT=1 so thread0 in core1 in cluster0.

> I don't know all the details but from what I understand the
> "arm_build_mp_afiinity" is used to set the "mp_affinity" member
> variable which I assume is about affinity, not the whole MPIDR
> register value. That is what I assumed because the Uniprocessor
> indication bit(30) is being set only in the "mpidr_read_val" function.
> In the patch, the MT bit is also being set in the "mpidr_read_val"
> function based on the SMT status (has_smt) of the CPU.

mpidr_read_val() is used only to set VMPIDR and VMPIDR_EL2 registers.

So setting MT bit for MPIDR_EL1 needs to be added somewhere.

