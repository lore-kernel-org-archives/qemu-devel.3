Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382D2C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 18:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ad2-0003Ow-Di; Mon, 13 May 2024 14:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6ad1-0003Od-5b; Mon, 13 May 2024 14:42:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6acy-00067K-82; Mon, 13 May 2024 14:42:26 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5a5c930cf6so386150466b.0; 
 Mon, 13 May 2024 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715625741; x=1716230541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqkmL3s2zR9/zsAVzNv7/89QitS+KSPlgwQuuRm0iGg=;
 b=KOZDZzV7RIB9IwHC2H0Rtsi2cuCOmdLv0dKDUeLUYSlia6oxOexXqluuKsq+Vtfua6
 U43dNXD7o9f0Qkb5CBHmNWTkdFM752bKj1oYGDg9uztlCcdja0YJddHTSu01zorbWhh2
 mm5lJ+VX5YA0LtF+FLygrQnP+p4t5rIJmU1/rhMUeQoW62kVNEEJWAy+Gke3A87R1UsV
 mjML3pi1FVdKAKMXjUXwJSDV7ayEQTFIMNRhQyqzRxElQibzGr0kmof+HWsc3pmKF7cg
 cTuYMgpQj+K6v2zgWVUlXz0t/eaFCzWV5jR9cvIvOWwrjHtR1Cc7MFEaC9tXs/TXobQ1
 o/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715625741; x=1716230541;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqkmL3s2zR9/zsAVzNv7/89QitS+KSPlgwQuuRm0iGg=;
 b=YHB02hCmOF0z/4qmcmBBLhRIDcnQE5B3WykbQJZdc/3874tgodeo8OjtKVe7G107Lv
 2hAqvvY1ZWTKXIK5BvC/HbnSML8EB+3O5BUmkAl+FqB/nX/yYNVuSqsRg7AgWfm9LVNU
 7E8GDCjTYA+63V3gaT+9NC9ZEZheUql+sBbIuTVL/ApK3gyUpCK/9l8O3I8ZW+DH5RzR
 TaOPJTYWfyFrPx13QZX6QoLEfL9ieH60GJ165fSIk4ouOJuigxPQjiAXbD7Pgz53OPcg
 dsKW/PrJ08Oi1vNwFvIl/IigKHGN9Cm2XYwVSAZk4E7sIZ8Jq+5yBe4t67pjxOYLMKiY
 Me5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi0zz6qMPCrd3QWwz0Lwv3Rodxpp/JiV/kbKJ/S0gSZOFvsXwKG7qTRIiVXX21DGKOE0c3pNFJKB8lr64nzYv1Ijm+SBRl4MEFNLorNLL4F3t7XxDUZDoY7jm6lVNDiWPfckJN8hLUuiQ5AMJ1CnDUf+Ba
X-Gm-Message-State: AOJu0YxSWtWlVeRc5N+8xqW0yJYfTHWmflYL/stgzp6Nh6Eae59jpecB
 +q5GjLDM7Ct00x2odVdZIxlPt8CVkKxNWea9BRqNXwlXhB1iirbS
X-Google-Smtp-Source: AGHT+IGg16I5Eg9IrXGoSyO7BJig2k6tyWgdyWhpJuoS/w9iLUzb+ZL3IvLxHTtW4824wM1wA7bfqw==
X-Received: by 2002:a17:907:9449:b0:a59:bdb7:73f5 with SMTP id
 a640c23a62f3a-a5a2d6668camr835168766b.52.1715625741118; 
 Mon, 13 May 2024 11:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a5ecd37a3sm247784566b.79.2024.05.13.11.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 11:42:20 -0700 (PDT)
Date: Mon, 13 May 2024 18:42:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/3] hw/timer/imx_gpt: Convert DPRINTF to trace events
In-Reply-To: <c77aba57-19cd-4724-83e2-6d5a289de4b7@linaro.org>
References: <20240513101108.5237-1-shentey@gmail.com>
 <20240513101108.5237-3-shentey@gmail.com>
 <c77aba57-19cd-4724-83e2-6d5a289de4b7@linaro.org>
Message-ID: <04618842-2F37-4F39-BA4E-72DF5234037B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 13=2E Mai 2024 11:30:04 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg>:
>On 13/5/24 12:11, Bernhard Beschow wrote:
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/timer/imx_gpt=2Ec    | 18 +++++-------------
>>   hw/timer/trace-events |  6 ++++++
>>   2 files changed, 11 insertions(+), 13 deletions(-)
>
>
>> @@ -317,7 +310,7 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr o=
ffset, unsigned size)
>>           break;
>>       }
>>   -    DPRINTF("(%s) =3D 0x%08x\n", imx_gpt_reg_name(offset >> 2), reg_=
value);
>> +    trace_imx_gpt_read(imx_gpt_reg_name(offset >> 2), reg_value);
>>         return reg_value;
>>   }
>> @@ -384,8 +377,7 @@ static void imx_gpt_write(void *opaque, hwaddr offs=
et, uint64_t value,
>>       IMXGPTState *s =3D IMX_GPT(opaque);
>>       uint32_t oldreg;
>>   -    DPRINTF("(%s, value =3D 0x%08x)\n", imx_gpt_reg_name(offset >> 2=
),
>> -            (uint32_t)value);
>> +    trace_imx_gpt_write(imx_gpt_reg_name(offset >> 2), (uint32_t)value=
);
>
>
>> @@ -49,6 +49,12 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t d=
ata, unsigned size) "CMSDK A
>>   cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned si=
ze) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " siz=
e %u"
>>   cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>>   +# imx_gpt=2Ec
>> +imx_gpt_set_freq(uint32_t clksrc, uint32_t freq) "Setting clksrc %d to=
 %d Hz"
>
>'%d' is signed, for unsigned you want '%u'=2E

I'll respin=2E

Thanks,
Bernhard

>
>> +imx_gpt_read(const char *name, uint32_t value) "%s -> 0x%08x"
>> +imx_gpt_write(const char *name, uint32_t value) "%s <- 0x%08x"
>
>I'd avoid the cast and use uint64_t/PRIx64 here to KISS, regardless:
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>
>> +imx_gpt_timeout(void) ""
>> +
>

