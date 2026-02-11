Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D77ECD6D6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqFar-00040J-KH; Wed, 11 Feb 2026 14:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqFaj-0003zn-GH
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:09:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqFab-0001M5-Gn
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:09:32 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso3477540b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770836960; x=1771441760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P9S6+WV27uCAsjrNNf8qblhv4XH9pQFBefckT2pIOes=;
 b=dvyBJXvCoCaanaYyhPVTKfkjTuXMS3jHkWYErXBQ+JVziZBmPMU7CFmtxnz3wary4y
 yLsmwxOUy2XPi/D9GMiAXz60tPoFG43TbF8FWzkcmvK4nUd5bDfuO0g9iDZ90sa9GuzW
 IKzn5xqpZiwtF8Unyp0mtfTK79kLx9iOcQig7KDVFPjUrmodWa5bwf+V/Nd/PNW60+6k
 BuOjOG4uG8ps3LnZpo2mWNtwWqbgvRks69pcL519me9PlKKbbV4vyLKw0rS4oqy/+HaZ
 W3Vps/pIk/EXmaawkNcA5VBYMSarRk13Avo/sbmia9vt5ChwL1D/a5qm0q1b0VRgwa7r
 UP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770836960; x=1771441760;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9S6+WV27uCAsjrNNf8qblhv4XH9pQFBefckT2pIOes=;
 b=NPazu+KssMBVN9SAiuIvs+C/ydWdLrJ/28ZnJ8md0ENOuT/OjD7n2abM8qmfvS/ncY
 ltKCNrDdHQeyGQloTIDKKZxZwbMBmjRT8zLId5xgCbEMmRRNLJRJDCQz0PRts6jLQJHz
 ZLNDabQb0ggkNEmKyzn2apoXQZlE/kOEpj/cshUP4JNU0cOLT4pnYoHU3r/E5+JhW7gR
 oO2+aTgQESWoavpXeJ4pNyEI5DjZaVxuL5VLVamvBHYf0cY8beKSI1lBGbE+HJGrbgTA
 Ds/Ve3JNlBKBm6JyYZJ63Kp5wCT7pM5LKjjBpTESbFjxyj0YZJwzLBoCmRyeQheAaYVA
 2x7g==
X-Gm-Message-State: AOJu0Yzyba1IXaCvXIx54Xco3rYuQMNp4XdJHNIvP/itIwMiC0GJzXn/
 Bh1uoLeVqD0gWJCgPXh0shBEkp89Iu8wdgDVC6c1Mz+gjTz0342TOvb4tjGXsmyr4h4=
X-Gm-Gg: AZuq6aKBn2jzWiaWpVmC7Rb8J48OaJhG+1BNY34rGnMPBifM8RsEgZ+krfj2Khv0z8X
 vpcWKEhkUnpGDYgNSTytK56webCEz6ej4IsmB0UEfona/bGU89qeuMrVUOnq0995FV7AC8L4aFO
 7PobTjEPgWhFidjoTb+td91B2dXsIuUtR3IX0ZnLIO59EePYaMcyFBquGmxmXg/q8Zg97DGWDwl
 qAS1cpbsy2Phyx03P6S6byV4HYo07txh7Ji+1X+WdFV3gonOLaN5uvpKVvM+TrEmiIF+63mj7lU
 B6ANOBTuZyq8cWOFUwFx1NGmg2mUKhRoWS6ndSl3ok0f8wXSEmHIKTv6d29qLj2dR5pHDZbWRUn
 W8ORzdBOcw6GPHTeabdvu4YL2zFH+EtaOfD3tNJw3MiH+qbGSjHXW6HG1IPgQFTP7uwd8zaY3bk
 V4qsh9Q0+W2bulYxpH5ae7xJJaNePiKBrTMVk/LlU6WVWmj3nGgIJMnLSXck3sIwfbSA/2
X-Received: by 2002:a05:6a21:600a:b0:392:e5eb:f0e with SMTP id
 adf61e73a8af0-394488394eemr239891637.65.1770836959639; 
 Wed, 11 Feb 2026 11:09:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e197f5e17sm2879420a12.25.2026.02.11.11.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 11:09:19 -0800 (PST)
Message-ID: <e42fa904-5512-4e9b-b6a6-218688519863@linaro.org>
Date: Wed, 11 Feb 2026 11:09:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: simplify DiamondRapids CPU docs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260211180021.1057478-1-berrange@redhat.com>
 <d2ec5397-bfec-442c-9265-6619c6573fbb@linaro.org>
 <aYzOEOhGPppCY7Aj@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <aYzOEOhGPppCY7Aj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/11/26 10:44 AM, Daniel P. Berrangé wrote:
> On Wed, Feb 11, 2026 at 10:36:25AM -0800, Pierrick Bouvier wrote:
>> On 2/11/26 10:00 AM, Daniel P. Berrangé wrote:
>>> This aligns the first line of the docs with the style used for previous
>>> CPU models, and simplifies the text in the remaining docs.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    docs/system/cpu-models-x86.rst.inc | 16 ++++++----------
>>>    1 file changed, 6 insertions(+), 10 deletions(-)
>>>
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> I'll let any maintainer for this file pull it, but if needed, I can pull it
>> as well.
> 
> I've got a queue of misc patches I'll add it to.
> 
> With regards,
> Daniel

All good for me Daniel :)!

Regards,
Pierrick

