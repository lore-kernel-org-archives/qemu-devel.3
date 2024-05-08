Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E02C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4kSz-0007py-Nu; Wed, 08 May 2024 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kSy-0007pi-OF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:48:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kSx-0006qp-2A
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:48:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59a8f0d941so1224764366b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715186905; x=1715791705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5642/wXrSzq/S4uUz3Ek51pEPrBwSU3eeslW19Y78po=;
 b=Fg+p89PF//o7XmWOtPXAAGJxFfZxDatPHOWAK8IhNEYu5h6VoTtH44MBUQxykXUMDQ
 BozuDdoLUt1kwvUw04f+c2bsKB6zYH76khhomBbR+hwsX7H+Fn1mh7mk37Y+FPVUoVPe
 BArHGCJc11eDuuPvH6JLEt4V3jqNHuoUV6S3vvcTM+PSFihIppnw+8tBfyXuacNTvacm
 om3tdmcryEczQpT28yC8VdgS5+FfooeMsqhDWTcwr8CjxsrITCQIV/GouMCV02nN6x9B
 1+Dkn94ey8yMpN15gNb6V9uM4wGrdiNYYP7SaL1ZvF/3tIbTsTkVYqqj1T9Q5VujOEzh
 Nlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715186905; x=1715791705;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5642/wXrSzq/S4uUz3Ek51pEPrBwSU3eeslW19Y78po=;
 b=Fa0MPcjVbSskE5JKBCq1wlCvUBGOu7oysYz/MpqXDf6HymHyuZdXvbN4GMlTLQemgX
 rfBXYyGiou0t+fGZzydt+QPmu4qkuzAfQma1lsEz5N59R4C6ELB0k18hIC+axL21ik+J
 5aQRPpxAKXxlKT4fAsI0F5ZbwPK65nvzv/HyWPqFbjvDT9jzZM3CsIQhwVJMgC8kBbOM
 G5Bcy6Adjem3NrGOWQh5euo/ufkrJKmTslD9F7S0bpPV4W0hRkXxHMSVf0/U5IwXktA5
 FwWB4Opa3+HQHMlvbbcGw4M13H8cUu3Tam/aTts9fTNwdLsXhex/wLAz6IAS6VHwdLOE
 XEQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY2AvLUWhuX/q5bzZdaVH3KP9uKObyfrcLX32cBYzjBk6dNE7fqy+78sieeYIcZoG9CtichOK80ymUgAtj95OlSDlGA6Y=
X-Gm-Message-State: AOJu0YxHTvV0MiQfVQOu0sb3lPy0HPH8Q2krFhNhZNK044xXeyRNPI0o
 cVpmQrEERlNyJEF9Lgv9XcQ8ESmo4kkCG77yUGFgC13z2y5pGWNronLUpj9vbTNOHey4C8Jsq/w
 Z
X-Google-Smtp-Source: AGHT+IGi+i53t+KsUUkisBhwaRbDLZSB9YAHG/ZcvU0U4s2AvmgAB/TtUeTpz1mYz2NEHEn7W+nsOQ==
X-Received: by 2002:a17:906:b311:b0:a59:ef75:5382 with SMTP id
 a640c23a62f3a-a59fb96beb1mr205055766b.43.1715186905403; 
 Wed, 08 May 2024 09:48:25 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 fy20-20020a170906b7d400b00a59ac65a13csm5522788ejb.179.2024.05.08.09.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:48:24 -0700 (PDT)
Message-ID: <37a227ca-af03-4f03-b135-b12ea2ef521a@linaro.org>
Date: Wed, 8 May 2024 18:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/loongson3_virt: Emulate suspend function
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>
References: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
 <30ac6d1d-6bda-473b-b212-25443efcde03@linaro.org>
Content-Language: en-US
In-Reply-To: <30ac6d1d-6bda-473b-b212-25443efcde03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 8/5/24 17:35, Philippe Mathieu-Daudé wrote:
> On 8/5/24 11:31, Jiaxun Yang wrote:
>> Suspend function is emulated as what hardware actually do.
>> Doorbell register fields are updates to include suspend value,
>> suspend vector is encoded in firmware blob and fw_cfg is updated
>> to include S3 bits as what x86 did.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   hw/mips/loongson3_bootp.c |  1 +
>>   hw/mips/loongson3_virt.c  | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
> 
> Thanks, patch queued.

Fixed:

ERROR: use g_memdup2() instead of unsafe g_memdup()
#76: FILE: hw/mips/loongson3_virt.c:293:
+    fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup(suspend, 6), 6);

