Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97BFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 21:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWMZB-0006wL-6c; Fri, 10 Jan 2025 16:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWMZ9-0006vY-75
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:29:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWMZ7-0004LN-H1
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:29:14 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1912250f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 13:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736544551; x=1737149351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fbvXoBhBxiCwa6nIvqU4MPfEkFBKSPV+I1cN8+JUX5o=;
 b=vUwrONKlTPCjG8s7D7Ehr0xgnjkbkvGbgvQxNJVQPAZZ/91w0a8z/55TGXUHYrhM0O
 9UI/vlRFX47YcgU6ugZR6zL+zdsnfbyc5hDx68kS2a92OCal+3HSgaAqyFX5v/aV8npB
 SkWFuAmOZUPKNPQNhrEtBz63cxkvuoHHt6ADyHJ2SVH2fgLi3Vcvh2DTL0QlPtxcHNue
 y7GbzFzeJeENW0H59u/kAA2WIJwc91DXPkqPZA2WcIxg/CU8yfZfj+EiLs15VCCBIM1s
 uLly8q/ttjUi2CyVQyK2ZAIjb0rDb+mvmlw/g5rvmuxDyVeHXvR/cUq+u/bPjYh0w0zo
 o8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736544551; x=1737149351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fbvXoBhBxiCwa6nIvqU4MPfEkFBKSPV+I1cN8+JUX5o=;
 b=vqB6KmINev8IgYucVlhyT+LWYp3gMvxQXPJqS/FxCvmL1gLDA/uQJYZoYgLWht79D1
 tExW5HF+KPBWZdlby7azMoTw1lvSUUwBWIz+tZbTouCUxUjY+g2PPG+isqPqfzM1xZCR
 5YbZHAVXLa/naJ1lTImx34UCYgRhpat616GzTjNgAM7awOD6Aapy5EN5RCRWIXxywGp/
 SrJNe9/Py+sNKjGP3D3YlZB4awe9M9kwEhfKf1+vVMDh2s6u925w2+7b826gfdH6iWEf
 eLlwl+e+gdmIGyyTGhY/Fx3DPL8PYvPWrYivCUkd09vb4vjK/tsdjU+q2523o6q6FjYq
 7FRA==
X-Gm-Message-State: AOJu0Yxn9ABhd7al/5LTeV3WuZXAaws7besTVq9qi+bM9jcuAqR5kchT
 CgcMZY8ZmDl8MsugHX0NOrx3FPffQ6m4NXz4ZZeJVSbbx1oF84HvOA6IATqx8k4=
X-Gm-Gg: ASbGncvk1r2zIln2joQqT9nzjtAleGvdkymu4G9w5XEAFRfFLAe+fS+H40YXVfln3Bx
 gexVcUek+Tsxs8m4eLY977SkSRbd7bP70MwCoduNiL9yr3xBn+f1RMnZlsz5oY2oU2mb/x44Mn9
 +HfQwCfAahZY/ZA/FjzYs+KNeLHYxF2NJPAUgBhj0LOcR8fN/2f2r7fXQkw9Gdb4F6bOwNbj42Q
 xUmqkZN8oMf0/AcMGA2O11UEO8/+WNwx/7Py41eKcQaWXxlOzJoOe4KKSspRAyCsoSFMWUAYo3C
 jiWEvIGGU7GK9cwtehQZhvlI8CCcnA==
X-Google-Smtp-Source: AGHT+IFCngRRzBH2bbSEVPKw3buqQwex23MUTpgfO8hjFAYZzHLnjWNULFkxG/PI0JHR6pkrTO/PwQ==
X-Received: by 2002:a5d:64cc:0:b0:385:e8ce:7483 with SMTP id
 ffacd0b85a97d-38a872faf34mr9403358f8f.4.1736544551032; 
 Fri, 10 Jan 2025 13:29:11 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2c27008sm98910035e9.0.2025.01.10.13.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 13:29:10 -0800 (PST)
Message-ID: <331d0b7b-40db-4a6b-80ba-178892f60506@linaro.org>
Date: Fri, 10 Jan 2025 22:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
To: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
 <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 10/1/25 17:30, Peter Maydell wrote:
> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   docs/system/arm/virt.rst | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>> index d25275c27ce..9f1457cf9a2 100644
>> --- a/docs/system/arm/virt.rst
>> +++ b/docs/system/arm/virt.rst


>> +VM migration is not guaranteed when using ``-cpu max``, as features supported
>> +may change between QEMU versions. To ensure your VM can be migrated, it is
>> +recommended to use another cpu model instead.
> 
> This paragraph is good, though -- that 'max' doesn't work for migration
> is important, and we should definitely document that.

Ah yes, I've been there. 2 close-by comments:

- 'max' is not restricted to the 'virt' ARM machine, but this document
   is about it, what about other ARM machines?

- More generally, "max" CPU won't migrate easily (in different versions)
   on all target archs.

Not sure where to document that; maybe a generic chapter that can be
included in a board.rst template?

