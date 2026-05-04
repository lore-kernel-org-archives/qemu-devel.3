Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74DEFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnsX-0005PV-7j; Mon, 04 May 2026 03:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJnsV-0005MW-If
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:38:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJnsT-0007U0-SY
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:38:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso26108825e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777880284; x=1778485084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xa+CGLnrL+V4mfXhcp5ZkTFXOdRkvFFxI9x4qHtyRqU=;
 b=XO3PIn4WKHhLQ1nDVgHIhGDkAcTxxVJl5U5YIHzj/P/9MrjiHDa1f0ef5fd9x5Ggkg
 jA/xgqg2Ot0v1u+OoO5s7+5U9Hsz5+iBiU/ugfXL4ahBnezq3e1mi/LWxuYRGovZ/F4j
 pnkfC7+gxBD04lTIVGcj7eu9/u6mZdPqyoIe+MsoPIAsFl7gZLxRvdXT/0bqiCLpc0tz
 uEkqIQwMAq7dMSFQHGTHpmxTiV+l+qcx5iA6RjXAXUT3Nh+aFOQNkYo8J9DiGoJ1cC7f
 mPKOFSBG4hFAS9SVyccndLL5knaS5GlhMH4s49U/57wQZjzWlXYWsIQkq5pe1B/ZjY3T
 2PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777880284; x=1778485084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xa+CGLnrL+V4mfXhcp5ZkTFXOdRkvFFxI9x4qHtyRqU=;
 b=Py+nVoDopcFgVguKuxA+UmgfpGerNQLIqDVeGlVs99qewJ6tO1PoqA5U24f7sybkTd
 UyEDWAb3xW/ztUe+PaTsZGWqbyri43SWaWf7h0b3fXY+ggDGR1R0cUG5lD0cnY/Q/Nhf
 R8p+NFLfQ6rLmyQBgdARAmx88RGl+DesqKey38SNrV0OoMlFNfqRBg0lmZnTGl+YpyTR
 /irkgM3uEv/PERQga6jM3E+ukh45/By3LWxOlaYRCOfTr/2vw2IIkUVmDjmRO3Dg2mtl
 vE+ANcqyQZE7XCJ0W7J1NfPg1KU60OqxsJdITJx9J8ICDaSKJNlCKNkj1VXJwoXgqD9B
 Dy9w==
X-Gm-Message-State: AOJu0YzQma/GfK0T00z1F21sCyaSQt/vKBdLwkEz7LS7K5qNbPNFfXi3
 G26JgxXNLIoHsVQDBinRoU9oIk34x93j/D3157Tm1NQnXVfz0rTPByFjYWETyf/nDjQ=
X-Gm-Gg: AeBDieuOIPE993oynBZd6lD5lVTJ7WSj1JijBQV2mky2PVE0WYYqKC0VqMwgkX26ntC
 4FL22ZCUXSJt53vtoFtj/uwjNoaPfwJo+DalUKKW23+GLEkBvLxLKRFVOtREvNs17iBQT660qDX
 lGYNf+PmQlsGbOo3ZU1yotUfUdH+c93kav4c1TEFBG1zUw170F25fvHhL54rAL3HQ/6ovxlZULZ
 HEB3E+8H/AJI+6pnNOBBhObvfgU+8oez4blSDZO/o3wpkHNCQtaQKfZbd92a6d20g1W3LEbkwQ9
 HhOFgebW3x7nx5Iq8thH4AH+pCTntV5q0W/zdqBybmevUayd4H9Gz1IV9UrTj3uWAdyurgS/t0P
 7Mi0UHgwRvFV2ZWpYwPWN1mTjf92865HyJafnclgwmRpthaiIIvzH76+RMVwcQ55QbTzVlCoij1
 J9lBQfMlcnFYTjNI2QZkwCGmhr91UxlBj3f8ERIFBSJgLkFz7g6Hnb3R/gI1z9++VNAf87f+UNX
 pTx/V8if4IvCY4=
X-Received: by 2002:a05:600c:540e:b0:48a:5574:3a5d with SMTP id
 5b1f17b1804b1-48a98874ab4mr125264155e9.7.1777880283870; 
 Mon, 04 May 2026 00:38:03 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8feec1easm74216055e9.24.2026.05.04.00.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 00:38:03 -0700 (PDT)
Message-ID: <77227abc-9ea3-41a3-9407-5a00555a4718@linaro.org>
Date: Mon, 4 May 2026 09:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: override HV_SYS_REG_MDCR_EL2
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260501231353.63184-1-mohamed@unpredictable.fr>
 <e36f1d1b-89db-443b-aa48-6247831a8247@linaro.org>
 <D84A47B8-1555-4ED6-9BC5-C4C433D5D7AD@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D84A47B8-1555-4ED6-9BC5-C4C433D5D7AD@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 4/5/26 08:59, Mohamed Mediouni wrote:
> 
> 
>> On 4. May 2026, at 08:49, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 2/5/26 01:13, Mohamed Mediouni wrote:
>>> In older SDKs, MDCR_EL2 was defined incorrectly.
>>> As such, override it with a #define if compiling with an older macOS
>>> SDK.
>>> This is a workaround because the macOS CI setup we currently rely on
>>> has not been kept up to date, to be able to land nested virtualization
>>> support.
>>> Once CI is updated, the SME stubs can be removed and this
>>> commit can be reverted.
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   target/arm/hvf/hvf.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>>> index 4f0f7ffba1..79209bc8e9 100644
>>> --- a/target/arm/hvf/hvf.c
>>> +++ b/target/arm/hvf/hvf.c
>>> @@ -468,6 +468,15 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
>>>   #define HVF_TO_KVMID(HVF)  \
>>>       (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
>>>   +/*
>>> + * In older SDKs, MDCR_EL2 was defined incorrectly.
>>> + * As such, override it with a #define if compiling with an older macOS SDK.
>>> + * https://lore.kernel.org/qemu-devel/BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com/
>>> + */
>>> +#if !defined(MAC_OS_VERSION_26_0)
>>
>> Not sure about this check, i.e. wouldn't it clash with 26.1 release?
>> I'd expect a check such:
>>
>>    #if MAC_OS_X_VERSION_MAX_ALLOWED < 260000
> 
> Hi,
> 
> MAC_OS_VERSION_26_0 will be defined in all future SDKs.
> 
> See AvailabilityVersions.h in the macOS SDK, has all of them since 10.0

Right.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>>
>>> +#define HV_SYS_REG_MDCR_EL2 0xe089
>>> +#endif
>>> +
>>>   /*
>>>    * Verify this at compile-time.
>>>    *
>>
>>
> 


