Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B562F8A144
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDI3T-0000rS-JZ; Thu, 16 Apr 2026 04:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDI3R-0000qj-S0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:26:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDI3Q-0003OK-1h
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:26:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso90747135e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776327986; x=1776932786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2K2+xyyVdq2JuQOengyXVpX3Ib5ES/uKxtLJ/BmWnQs=;
 b=ahJA2O2A4v70kv199L8FuP2abu+KavZaPyqZ4e1Nt68OL/b/f94CYWTDdILb6QFTnH
 k1ZpUXQiMUQ3T1UH1DZzRD9yNIhwgRwoKdrKB3JjcuMxWlTNxIZwXuzvKbi/ys7cN3Z2
 4hRt6TgiiUJTr0WnnZsba0yA3jP9JwH2v0sVG+/mhhCThC5A0ADab9MFK4pyPxs83CxT
 QSf8sTtDELIcmQ63iT2fZNa8WqCQB3AVtETzd8fy1N9TYWtQ1V2LepaWTz2ZfpsoCEZz
 rNkxhwwIURb0aYiKTnbBjFMVStQDf67XJieBB7FHsUQD9T31JZCyqNeKfc/pu7V9Je/Z
 3yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776327986; x=1776932786;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2K2+xyyVdq2JuQOengyXVpX3Ib5ES/uKxtLJ/BmWnQs=;
 b=kFnTbfWDsAC1xGNZxDObOyuN/suloc6NaIueqlv2k0AUM1+3Li8jxnhrhtk4wTbiPm
 HPfXUiBf7TZ0Ps/UQTXpYfWewOYjcWF1jketNjByzIGgWvT56f/Wnc9UmU1gjO1ryFaf
 MvvO+SCL3fTZ6ZRKZejDHlrFEfKHHAB5bQOiSNBOCuI58fo7AFGXutin/3r6xDndMu54
 8bRZUhqm3+QZgffWz+mxfQMFO6P+qnDkgJboSdUVcaPOm3T/yjIjH3Og/EOddFk5uC0O
 5Vw8mEeBpsLzBC0AEXhPvMMqVONmkhHmFmsIpUqw7ru6H9YzDIeKsRK/kaVVf0vEQ/rZ
 yo5w==
X-Gm-Message-State: AOJu0Yw5biq3tpzLMwZvomFxWyYJMPwWhoRKZelLbTH7ZPkRJClJKtW+
 SsxalY3DGNNfr+L1EK9/ajWtsSSgkqiE8uH//B4P+FeypXQ0iaOtXU/HBB+c4E7xpoY=
X-Gm-Gg: AeBDiev6wYaJr6RUO0lAZUtmwtoOeueuNY0fHXjSOleTvlf4IhRE72DmJa2kGflas+t
 TQyyF81kFRbjW4+oxhTuHFbJzycNiVkfhEzjqVVoBLVNLao9u/xBPtBdKifFGeM/T8m1iaZh1Mt
 XSNPTXtNDiZ326mGzKSgI4Eo7mnpIm1ySOaMdvRLUpYxnyFcD2j3prA5VgTp3OoyvqlYOMAPwaZ
 c64+aYMUAnF+n3Kj9aPhDNteYbV05uNh53YvSQa3h60KPs3XcibYnRHQ1+m7dOKbRPS75DL00wY
 4jZQvrpsz9hGp4trgw29XmNQc/OkkHUx+5VP7votF3DYnH509nJ6Oh8Ruo+snFxdXj9Zpr8T40E
 NW9togYDJ60u4bR1wV4Z4sh5JF6320pNlkR19cl9NXO2RmmB/8G9JlWjN36GkLak8v0AYjEAJ3T
 U0z+tDbz2I/iOq4xBJSNVR1iKbFG34ZFXrazM=
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id
 5b1f17b1804b1-488d68865f6mr267253775e9.28.1776327985513; 
 Thu, 16 Apr 2026 01:26:25 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5489217sm20945775e9.2.2026.04.16.01.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 01:26:24 -0700 (PDT)
Message-ID: <3bb1340a-b7cb-4ce3-ba72-fedbbd5839bf@linaro.org>
Date: Thu, 16 Apr 2026 10:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] hw/sd/sdcard: Add erase-blocks-as-zero option.
To: Christian Speich <c.speich@avm.de>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-5-dc1cf172ee57@avm.de>
 <8d358e4b-d6a0-417f-b357-99a0ae06164e@linaro.org>
 <atp673czap4hd3ozv2u5y7fiie6fsoqkvy4ou5vwp5ukxz5iw5@ac6356oe52jw>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <atp673czap4hd3ozv2u5y7fiie6fsoqkvy4ou5vwp5ukxz5iw5@ac6356oe52jw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/4/26 10:02, Christian Speich wrote:
> On Tue, Apr 14, 2026 at 05:02:34PM +0200, Philippe Mathieu-Daudé wrote:
>> On 4/2/26 14:22, Christian Speich wrote:
>>> Currently, erased blocks are filled with 0xFF. However SCR Bit 55
>>> (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
>>> them is wrong.
>>>
>>> This patch does two things.
>>>
>>> First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
>>> correctly reflect the content of erased blocks. We also increase the
>>> Product Revision (REV in CID) to indicate to the guest that
>>> DATA_STAT_AFTER_ERASE is now reliable.
>>>
>>> Secondly, we introduce a erase-blocks-as-zero option, which allows the
>>> user to choose if erased blocks should contain 0xFF or 0x00. The default
>>> is still 0xFF to remain compatible with current users.
>>>
>>> Signed-off-by: Christian Speich <c.speich@avm.de>
>>> ---
>>>    hw/sd/sd.c | 15 +++++++++++++--
>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index c9cfd3620b563fbe7520cfe361e14b57cd8f7472..5ddaa08d77b6b7606005fb59f42f107d254d6e5c 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -162,6 +162,7 @@ struct SDState {
>>>        /* Static properties */
>>>        uint8_t spec_version;
>>> +    bool erase_blocks_as_zero;
>>>        uint64_t boot_part_size;
>>>        uint64_t rpmb_part_size;
>>>        BlockBackend *blk;
>>> @@ -439,6 +440,9 @@ static void sd_set_scr(SDState *sd)
>>>        sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
>>>        sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
>>>                     | 0b0101;      /* 1-bit or 4-bit width bus modes */
>>> +    if (!sd->erase_blocks_as_zero) {
>>> +        sd->scr[1] |= (1 << 7); /* DATA_STAT_AFTER_ERASE: Erase produces 0xFF */
>>> +    }
>>>        sd->scr[2] = 0x00;          /* Extended Security is not supported. */
>>>        if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
>>>            sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
>>> @@ -456,7 +460,7 @@ static void sd_set_scr(SDState *sd)
>>>    #define MID     0xaa
>>>    #define OID     "XY"
>>>    #define PNM     "QEMU!"
>>> -#define PRV     0x01
>>> +#define PRV     0x02
>>>    #define MDT_YR  2006
>>>    #define MDT_MON 2
>>> @@ -1363,7 +1367,12 @@ static void sd_erase(SDState *sd)
>>>        sd->erase_end = INVALID_ADDRESS;
>>>        sd->csd[14] |= 0x40;
>>> -    memset(sd->data, 0xff, erase_len);
>>> +    if (sd->erase_blocks_as_zero) {
>>> +        memset(sd->data, 0x0, erase_len);
>>> +    } else {
>>> +        memset(sd->data, 0xFF, erase_len);
>>> +    }
>>> +
>>>        for (erase_addr = erase_start; erase_addr <= erase_end;
>>>             erase_addr += erase_len) {
>>>            if (sdsc) {
>>> @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
>>>    static const Property sdmmc_common_properties[] = {
>>>        DEFINE_PROP_DRIVE("drive", SDState, blk),
>>> +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
>>> +                     false),
>>>    };
>>
>> Keep it enabled for previous versions adding in hw/core/machine.c:
>>
>> GlobalProperty hw_compat_11_0[] = {
>>      { "sdmmc-common", "erase-blocks-as-zero", "true" },
>> };
>>
>> (Although I wonder about the PRV bit).
> 
> If I understand the hw_compat correctly, this would mean sdcards would switch from
> `erase as 0xFF` (old behaviour) to `erase as 0x00` when using the migration path?
> 
> I don't think this is a good idea as an guest might depend on the erase behaviour (e.g.
> looking if an block is erased by comparing a "well-known" byte in the block for the
> eraseure value. Changing this unexpectantly might confuse the guest to think used blocks
> are empty and vice versa).
> 
> The other way around would be to change the default to true, and use compat to keep it
> at false when migrating. This would make more sense, I think?

Oops yes this is what I meant, keep "erase as 0xff" old behavior for
up to v11.0, then from now on start using "erase as 0x00" by default 
because optimizable, except if the user request otherwise. So:

     DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState,
                      erase_blocks_as_zero, true),

and:

   GlobalProperty hw_compat_11_0[] = {
        { "sdmmc-common", "erase-blocks-as-zero", "false" },
   };

WDYT?

