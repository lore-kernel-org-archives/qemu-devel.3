Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4C4EDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfrB-0004Gt-Os; Wed, 04 Mar 2026 01:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxfr6-0004GU-HG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:37:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxfr4-0000SL-7c
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:37:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48375f10628so43190785e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 22:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772606229; x=1773211029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HxzWagOJqO7R5U3L51QnnW6yyqaJbFLHyWbHyAwE3qE=;
 b=BEJuoSPDTg3OZxEHIKbCh60UY+OA17tBHDFdrI2g03lQCvCO4LUaX0pq0CCoU4EsWi
 JRHOuK13XEgvrTFxXIjv6ZeqwSkdyDMBOJV6eAIEQfLgUZf3LSc4DkfFwtWZaZDyHflE
 L/kQF0G9vz5t3/RPtKL/W9uF66PRzWfryUFHSPE1oYgxcUSaqeamLJtOMmArGx/2DoqV
 EOL80bdp1BGCoOOpVT7vEWsf1Xl6mzuN5ZnGXXYUihwcO2UpIzjFhmR8YlVsWKAQhttF
 Z8tCn09VwupP1xzZsaxvsN6EmYpbSOD6Hjlv6OEwDSLsYtQYE7uixaFFx1FT8VAz7fVc
 PqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772606229; x=1773211029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HxzWagOJqO7R5U3L51QnnW6yyqaJbFLHyWbHyAwE3qE=;
 b=U/JEXo2Uz7rpGFy2HSrdkDlCZUMkSSOpeQ3IHCNyFZZSnwR5Kh7ugz+IryKCdYtf38
 3Lsozm6skTsH/Q2hkCx5xThfKiG3WPqp+5BBCcjkFoipGEGPS8/4m4Bs7IINfhi26J8B
 wJAg2RzDhY79zghUXmSHvwhDspoKSSiXf3MDVfcqQNgxxcGzvr3vwtnbsdTJVd2XLW7V
 MTVSyEstHYC+Qua6jx/CvDdJ68lqMUs9YOl7Dk/R7GdC5hv2f6jec0FZ+TGHbHjkF2ag
 dtNjPCI8EgX5tUcdlf/plDvb532xKk7Xw/P+vk0dEuV4Db7mzHnds5YvrFBb74cWvVLf
 znxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr6EKajHDEEaNULbu2dYqwCzj1HhqX8JqPr31qA5l+pOkxYWQrlbWIZUh1z29hn37x5EpWosMZliA5@nongnu.org
X-Gm-Message-State: AOJu0Ywt3Hi7yYbsXj6LUyJT33wMlmRjV1zJQHgC2nmIhj4kGigJYONC
 NQJr2gQijLQjBUBkL/plleh6ROfxMhfK15EbLioHxS0gCoh0hoD4tVvt1zd0cxu7Ehc=
X-Gm-Gg: ATEYQzy60164QHZ3Rg3+VRCePYj+97Odvwa8VB+Mzg3KYZjeNP0kxbQdt2bhUEIdR2S
 BKU+7alkrjWr+v1IJDN3eTSJ2RwkVqfD6cHtttnvK/lgzDK7P121/Qu/pdypzCxf/gRPKP8N6xE
 CN6KbXSScb87d/d4+mgFneRJCD3vFFaUgpeQwAqKgVAL5TLIopiwtdTEVi+ZvDJKP/CELFJtwuv
 KzMZoq7+FLJ8lB/5S7TrN6ZZhBXCIeEbD0W8OyP+PgW6DwJRw2ldWb8iDiLhgOClWWBaVuuojTY
 iduPrWDSwlm5aBGR5rfrxbKax7+38a7Qjg1vsVznNOqdQUJkixf+34EuqfWqfZTCpTIRMNUEvv3
 eIr+iDni9xuR4z2lpj4zSkIex7HKkmz58ZW9o4QYMtYim2qLjXjEbP9VMgxoLQsFPlbkgz0/UV/
 +0Asg47uzsMTbWbRJs1sG31lrA+oxQqlRbM7TZZPuVMQn9Zo7HLFPJFWswNMYeGxSyHw==
X-Received: by 2002:a05:600c:4e8a:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-4851988ade2mr11214895e9.26.1772606228584; 
 Tue, 03 Mar 2026 22:37:08 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851887fc54sm32506415e9.10.2026.03.03.22.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 22:37:07 -0800 (PST)
Message-ID: <e64fa21c-a2a8-42af-b725-f7ac8c1747bf@linaro.org>
Date: Wed, 4 Mar 2026 07:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/37] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-5-brian.cain@oss.qualcomm.com>
 <d949b2f4-d31a-4890-8e27-6f05e9977323@linaro.org>
 <aacknZiSQhhIaS-8@hive.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aacknZiSQhhIaS-8@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/3/26 19:15, Anton Johansson wrote:
> On 27/02/26, Philippe Mathieu-Daudé wrote:
>> On 27/2/26 21:35, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    target/hexagon/hex_common.py | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>>> index c0e9f26aebe..63f83a8de2a 100755
>>> --- a/target/hexagon/hex_common.py
>>> +++ b/target/hexagon/hex_common.py
>>> @@ -247,7 +247,11 @@ def need_next_PC(tag):
>>>    def need_pkt_has_multi_cof(tag):
>>> -    return "A_COF" in attribdict[tag]
>>> +    if "A_JUMP" in attribdict[tag] or "A_CALL" in attribdict[tag]:
>>> +        if tag == "J4_hintjumpr":
>>> +            return False
>>> +        return True
>>
>> Alternatively:
>>
>>         if attribdict[tag] in ['A_JUMP', 'A_CALL']:
>>             return tag != "J4_hintjumpr"
> 
> I don't think this is valid,

Doh I was too quick and mis-understood that code :/

> but set intersection would work
> 
>         if attribdict[tag] & {'A_JUMP', 'A_CALL'}:
>             return tag != "J4_hintjumpr"
>         return False

Nice!


