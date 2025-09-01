Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFECCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszAO-0005Oh-Uy; Mon, 01 Sep 2025 03:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszAN-0005OQ-4j
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:41:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszAK-0001J3-AD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:41:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d758so1538339f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756712481; x=1757317281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LCfnc4j2cGLlJgufcxLg40dTrg71CsyssN0gxONVk8s=;
 b=apSj+3GM30SsnZ95XJaOBE5ss5ZU1XfDzTd0Wv5R69BQXgJuMShjdoxx5LwcnLBy5e
 ndnZahUyqvmtZt0ToOVHeO7lPZYpX7RlpKRSUPuxwVPmvbPNP84bgFaOgDKg42tErLSf
 S56XZdU2DMDNnCy6iP+72JwbPA7JYlpJfrBdVBZdRi0tVUxPux8S1wTxlj9GVwDUsLj4
 ylnHrBxXu25nHYjINQqLBLZ5tpe9HTWESHn0toOQwAQsOgZi95eRlIQ9msMqo0oBzcj1
 7YV/E/8sBke6pLO0ySsvqFNN0PWC+4XYDMDYFDyhxlxC/xdkoO/9gtoR4YbDuBtx6B2G
 rfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756712481; x=1757317281;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCfnc4j2cGLlJgufcxLg40dTrg71CsyssN0gxONVk8s=;
 b=Ycrtdl88vBfRcK6VgagQEdVTq7RS9GInTH1bhlYpFHxiPiW4aVcwj2y3PTN2uCOEjy
 pKRC6u0FcQAJ5KU0+NDO0/6FaEXuvkg583XGzVzltfPadioh6oqT9j93RuWbJyNH2Bed
 JUtPJnr0nQTpSbY0oTgOfseiTyJUhSeMbUSXY+IdSw2ToJfjCm8X5NXR6IBI7aXI7NSF
 UWsnNDBS6lNp7S25nn4vLfe1L2NnkN3dPLxvg457prWQmTnhfDa4x4VCDU53+hkqKaBa
 b+D2TVuMcGcZ4uYK+WkgOsvq6wAPrlySQCXUqtIFAVFW9g1uIXzdlZaDgdhCPEHvu+62
 0ddw==
X-Gm-Message-State: AOJu0YxHHIvQTwWfu2AuQPjvXpS4VBgBQJIG6p2VDH1xFf8tPaWRaN7E
 EdjuaAc/LmCYIpmrL4c2lYSlXoGNJGxIpZ02xz+JbG0bui/QmHXiJ5CWs75A170o+Qu4x7fbVxY
 pyEOd
X-Gm-Gg: ASbGncsI0yFaliTaqGgC0ccRO8NLDCthJolqb2RqU1UWjcLh5Z6zceEILPBhGR5PHCT
 1rNLwCx7pLqS/6wRMPgQhEVFfES0kVbeLe0/xrwaR3FIFYW9qcL7M3f2LMBPPQ8cqaMmD6dAepy
 35ac6p63ulW9wwyzPfHlvy0Be4j7kYDDuuErWLpamFCrR+KIxg4D8T94TWdje+3LRSKv+4d6sd/
 jA/yr0xfO3eVfAFQrf2xCvnYZyPz0svRIk/veNp6BAu0EItQtm7hKBiouMBOyXJftayxZ/cZfqu
 HhRcWfLFoWGiV2lRabjqrjzGUEwqKQ7La+JIijMgvX8Bcj4k13PaubYkKeQqY9egEloUkNZyrIl
 fR6Qmy7yEtBq3VfqLga1RgP/1E6QTfWt1sWxGax+HOgLjYtDx3ucKStbxLN/sRb2dwOkGPCoVEa
 7i
X-Google-Smtp-Source: AGHT+IEfoBrGY2+5SkTb0GnSAZjvZswnVZqynRA8A+ATgQu1Qz9Hob7UWe3gXpOuWHwE6KwJ0ghPxw==
X-Received: by 2002:a05:6000:4022:b0:3d6:781e:9fcc with SMTP id
 ffacd0b85a97d-3d6781ea586mr2610009f8f.60.1756712481266; 
 Mon, 01 Sep 2025 00:41:21 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm243541555e9.9.2025.09.01.00.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:41:20 -0700 (PDT)
Message-ID: <7c7c8c08-89d1-4864-95ca-dfebb50007fa@linaro.org>
Date: Mon, 1 Sep 2025 09:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/3] hw/sd/sdcard: Remove support for spec v1.10
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
References: <20240627071040.36190-1-philmd@linaro.org>
 <20240627071040.36190-4-philmd@linaro.org>
 <8d9521aa-b7cd-4f93-8d36-bb286f8a6bc6@linaro.org>
Content-Language: en-US
In-Reply-To: <8d9521aa-b7cd-4f93-8d36-bb286f8a6bc6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 1/9/25 09:29, Philippe Mathieu-Daudé wrote:
> Kind ping :)
> 
> On 27/6/24 09:10, Philippe Mathieu-Daudé wrote:
>> Support for spec v1.10 was deprecated in QEMU v9.1.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst       |  6 ------
>>   docs/about/removed-features.rst |  5 +++++
>>   include/hw/sd/sd.h              |  1 -
>>   hw/sd/sd.c                      | 12 ++----------
>>   4 files changed, 7 insertions(+), 17 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 02cdef14aa..ff3da68208 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -362,12 +362,6 @@ recommending to switch to their stable counterparts:
>>   - "Zve64f" should be replaced with "zve64f"
>>   - "Zve64d" should be replaced with "zve64d"
>> -``-device sd-card,spec_version=1`` (since 9.1)
>> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> -
>> -SD physical layer specification v2.00 supersedes the v1.10 one.
>> -v2.00 is the default since QEMU 3.0.0.
>> -
>>   Block device options
>>   ''''''''''''''''''''
>> diff --git a/docs/about/removed-features.rst b/docs/about/removed- 
>> features.rst
>> index fc7b28e637..dfe04b0555 100644
>> --- a/docs/about/removed-features.rst
>> +++ b/docs/about/removed-features.rst
>> @@ -1056,6 +1056,11 @@ by using ``-machine graphics=off``.
>>   The 'pvrdma' device and the whole RDMA subsystem have been removed.
>> +``-device sd-card,spec_version=1`` (since 10.0)

Updated to "10.2".

>> +'''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +SD physical layer specification v2.00 supersedes the v1.10 one.
>> +
>>   Related binaries
>>   ----------------
>> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
>> index 2c8748fb9b..362e149360 100644
>> --- a/include/hw/sd/sd.h
>> +++ b/include/hw/sd/sd.h
>> @@ -56,7 +56,6 @@
>>   #define AKE_SEQ_ERROR           (1 << 3)
>>   enum SDPhySpecificationVersion {
>> -    SD_PHY_SPECv1_10_VERS     = 1,
>>       SD_PHY_SPECv2_00_VERS     = 2,
>>       SD_PHY_SPECv3_01_VERS     = 3,
>>   };
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index d0a1d5db18..37a6a989ee 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -168,7 +168,6 @@ static bool sd_is_spi(SDState *sd)
>>   static const char *sd_version_str(enum SDPhySpecificationVersion 
>> version)
>>   {
>>       static const char *sdphy_version[] = {
>> -        [SD_PHY_SPECv1_10_VERS]     = "v1.10",
>>           [SD_PHY_SPECv2_00_VERS]     = "v2.00",
>>           [SD_PHY_SPECv3_01_VERS]     = "v3.01",
>>       };
>> @@ -371,11 +370,7 @@ static void sd_set_ocr(SDState *sd)
>>   static void sd_set_scr(SDState *sd)
>>   {
>>       sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
>> -    if (sd->spec_version == SD_PHY_SPECv1_10_VERS) {
>> -        sd->scr[0] |= 1;        /* Spec Version 1.10 */
>> -    } else {
>> -        sd->scr[0] |= 2;        /* Spec Version 2.00 or Version 3.0X */
>> -    }
>> +    sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
>>       sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
>>                    | 0b0101;      /* 1-bit or 4-bit width bus modes */
>>       sd->scr[2] = 0x00;          /* Extended Security is not 
>> supported. */
>> @@ -1241,9 +1236,6 @@ static sd_rsp_type_t sd_normal_command(SDState 
>> *sd, SDRequest req)
>>           break;
>>       case 8:  /* CMD8:   SEND_IF_COND */
>> -        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
>> -            break;
>> -        }
>>           if (sd->state != sd_idle_state) {
>>               break;
>>           }
>> @@ -2231,7 +2223,7 @@ static void sd_realize(DeviceState *dev, Error 
>> **errp)
>>       int ret;
>>       switch (sd->spec_version) {
>> -    case SD_PHY_SPECv1_10_VERS
>> +    case SD_PHY_SPECv2_00_VERS
>>        ... SD_PHY_SPECv3_01_VERS:
>>           break;
>>       default:
> 


