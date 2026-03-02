Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E82EB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7bq-0005el-SU; Mon, 02 Mar 2026 13:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vx7bi-0005du-UM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:03:04 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vx7bh-0006C4-9a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:03:02 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8274a3db5e3so2102156b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772474579; x=1773079379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2B/yE8a4WQqMJAKfhBel/DBEmoUM7dqpttMF2ptj2M4=;
 b=zFJo1lyyo2mKCp12/LFrTdt+dxcIxUhEx1Yua8hk70mUfHaN4xLWcmGWnWr5C6vgvH
 SZnD17Rhpv25G4E2rih5H8DLJ3XCaVycs7TMISeNlLx3Tmlq8tZQlTp0ZEwSCS1vUWmG
 30TrpRmMgmO1HIT+CdXvdDDfglP4cRlRb2ViTbExnPPYg83u81bExfCEm8I/yslg3rrm
 GF+IvS4DX6sNd/ljktqe2Oos9UFcWEsq4TitzlM0rr5im0whAxBjFOhxa6n9tUcw1uDG
 BkV1/ycRkni1gtu871s5zZHBQ9cKLvKio89sZ1Wiv8MpHDBX+lafR+xCTTLU68PpMFxz
 JFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474579; x=1773079379;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2B/yE8a4WQqMJAKfhBel/DBEmoUM7dqpttMF2ptj2M4=;
 b=mBRJO4cQwkngwQQj52cCUNdHqg1zVS/yAEa2biVLLUXi950haOYT15AyZ9n4RJs2Le
 Pug3+ZVgY//MwXt6ZfzKzT/tLXqMsup5ZV6R10rZG6MzkwYhdT8JHhb6A/wTaQp90aVS
 uW9BqWWgG/rOOaIMu1oBWUJVKcoEBF3m62mEZp7Qf+s7pwukGQrNjTwWbMk9+qMVQ/jf
 dBgKQWpn98Yx/pXlXdeB1Yzd1wEMHQPNydPAhbFVbO7pxaAqML8A+iEhSwzQfygvH5he
 mY/kqqnNAJFAYbA5Vn4L6Az3/uLh42L8yDJlrRzHR/DQpzop3DB8YACAlQ6wemLn5pGE
 m7sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAbxRMQZksRzUJCWbEP0Np7obHrxkCtV1aMpxYdPuz5EVgAUTnJb8JCUeF2FE1iTVXqz43X/vdjRhB@nongnu.org
X-Gm-Message-State: AOJu0Yz5e8k0BkFra7sI6x2sq3lYmedGzZMITAjpo81HmQPyaOK9Js5Z
 mXU/tIijsk3O9J+srLzVOceTsQzfAQVYBahf7tdMUrzf6lduYW654tgGDEs4WJqDOujw8F2QP8r
 n7Cbb
X-Gm-Gg: ATEYQzzKeLA6x8JksHG6zS9ETQ5kwVQOfPdTKXrfEtvdBOTXvF3FviK2lRzfMBIl4Qb
 4c4uIbfrPfaowBtc0Tk9Ydn41mR19Isx+sq8OIo3LJlxmVMQLPl+aHS6HdgVb5jAPdCj5MhiWE5
 jfgbe09sItMytjowFDVKNL+ovSoo+UbTD/RfJs0OC2CHZt3/Zd2t5QO2LYuHuJoAo+ZY1IW9dP9
 xu3hucx6JsoM2opTJgU85GEWJT0qIjhsrPcy2qhQQiwK/BHTqS4GLvr6cTUoMorCbFi14U+0+mE
 NJJ9VysEBUqMlyxxSdCGI5Nb8VBwlcq0w/oidBnEYEYoAqN/q6xtdN17MYUS2qAqtvDvmxIsG7Q
 LVcipQ1WDGO1erbUuPSIoFME4BK6RXzqsvhjNnwiF3LT3cvr5xibDXU3KJJXOdmTHR5U1Ow0Y51
 l0Lgc5ndbHJVKl/26rkvU+ryvhLWv6ByR+Rrks4ZFYpBxUtiqFF7eUH3ELHbxPhjuQ+0q9
X-Received: by 2002:a05:6a00:2e11:b0:821:807a:e427 with SMTP id
 d2e1a72fcca58-8274d967e93mr11785164b3a.21.1772474578936; 
 Mon, 02 Mar 2026 10:02:58 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4d880sm14141404b3a.7.2026.03.02.10.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 10:02:58 -0800 (PST)
Message-ID: <a84d40f6-0466-4744-95e6-5a1f8743c2b4@linaro.org>
Date: Mon, 2 Mar 2026 10:02:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] tests/tcg: add test for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <11fbe855-37cb-4703-b143-66563b881a4e@epfl.ch>
 <b88345b8-5561-4b09-b42d-dafafd798217@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <b88345b8-5561-4b09-b42d-dafafd798217@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 3/2/26 6:58 AM, Florian Hofhammer wrote:
> On 02/03/2026 14:59, Florian Hofhammer wrote:
>> The test executes a non-existent syscall, which the syscall plugin
>> intercepts and redirects to a clean exit.
>> Due to architecture-specific quirks, the architecture-specific Makefiles
>> require setting specific compiler and linker flags in some cases.
> 
> Please disregard this patch and use the other version I just sent, I
> forgot to update the commit message for this one. My apologies for that!
>

Hi Florian, no worries.

What is the other version you sent?
Feel free to send a v6 for the series if needed, it's more clear than 
fix on individual commits.

>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   MAINTAINERS                                   |   1 +
>>   tests/tcg/arm/Makefile.target                 |   6 +
>>   tests/tcg/multiarch/Makefile.target           |  17 ++-
>>   .../{ => plugin}/check-plugin-output.sh       |   0
>>   .../{ => plugin}/test-plugin-mem-access.c     |   0
>>   .../tcg/multiarch/plugin/test-plugin-set-pc.c | 140 ++++++++++++++++++
>>   tests/tcg/plugins/meson.build                 |   1 +
>>   tests/tcg/plugins/setpc.c                     | 120 +++++++++++++++
>>   8 files changed, 282 insertions(+), 3 deletions(-)
>>   rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>>   rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>>   create mode 100644 tests/tcg/plugins/setpc.c
>>

