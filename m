Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBE7CF34BD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 17:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swPXN-0002qO-AX; Thu, 03 Oct 2024 13:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swPXL-0002pk-Re
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 13:22:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swPXJ-0002hw-Ji
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 13:22:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so7727555e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727976163; x=1728580963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JS6sHnndKy+LBPL6KyiBEsGD3s9LGCaYUXqNsrAdXY=;
 b=qof3tT8wQ9QyX17766BA0RwAsfTQ47KZaLFS9XC205hUHSd3AqUMei2lBshscePiQq
 +jpe8dV6kRmnc+uzXaiOLErTm7peRvcvaeqnpQBbyuNCl32o79OGuQpNzQ514W1Grto2
 WCsegShiCU1Yivzp6nj8DzXzChVLA0aSCULj6Dd5HBGj9Oc9lFfQcjOWWF8EwN21hj62
 QXGjluF9h+S++fUhjLr5LPtvrakqZNXQkhZ5uS4/OEa856HcNUAmjMryI0P/PbAJzq9I
 NhUCiAtlQJlIwxr+3fj2WxLIwYcUKA9+eoMHBAVaICylWNjGqKDQE3qiuTvG+yRYPKIa
 cKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727976163; x=1728580963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JS6sHnndKy+LBPL6KyiBEsGD3s9LGCaYUXqNsrAdXY=;
 b=phvAZ87fAPeIGOP8LqO9TsAiWpMmaa+Q0MgWOBI0MoHpQq4y9d8dDMcjfQTBfKWbJ6
 5LLtgE2mEHOFv03zqTp90Igsx1iBgmmc8HAwF/dZ3LrAPaj8SK5dtRiEZJ1DfrZxk5tg
 n9h57Oza62sYjyQ3a+hmkXhYcCqrXFumUMUGRiMI8LWWLTYI2Yp5v0V3mfzLsz5NMrK5
 GOONyFd2jT0Oxb9q8634nlgppq7fY9wYnx5XoPFdwFfVp0gLSvvLeAVBu9RyqnFzj9wW
 NhbkcW0oc0BKZnvAhB/yShZkPi3W+x7FDGd0WgQotpzNcW39kLE0tw61QG+uMYY266W7
 rNkA==
X-Gm-Message-State: AOJu0YzEDK7B2Peh63J88uQKYRtaLy462aXXlDzocprtjlZYM5auEuZr
 rDRUnUBIAztp2QwW3++bvzlQGjiQeLY2WHFgpkMFkGUVMas2LW6VbzHUWmJO8K4=
X-Google-Smtp-Source: AGHT+IHgF1didwQPt3tl3njaqLcCNJCwxC7NyF/liojUc53d+Ba9K71TihSgMJBi3aaqzvb+AxSOvA==
X-Received: by 2002:a05:600c:3c85:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-42f7df434acmr26360305e9.8.1727976163300; 
 Thu, 03 Oct 2024 10:22:43 -0700 (PDT)
Received: from [192.168.13.175] (139.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.139]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082a68cbsm1707534f8f.76.2024.10.03.10.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 10:22:42 -0700 (PDT)
Message-ID: <21757f12-fd57-490a-8c70-b63189134fff@linaro.org>
Date: Thu, 3 Oct 2024 19:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotests/testenv: Use the "r2d" machine for
 sh4/sh4eb
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
References: <20240917194350.429971-1-thuth@redhat.com>
 <87bk0ikauh.wl-ysato@users.sourceforge.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87bk0ikauh.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 20/9/24 10:06, Yoshinori Sato wrote:
> On Wed, 18 Sep 2024 04:43:50 +0900,
> Thomas Huth wrote:
>>
>> Commit 0ea0538fae516f9b4 removed the default machine of the sh4
>> binaries, so a lot of iotests are failing now without such a default
>> machine. Teach the iotest harness to use the "r2d" machine instead
>> to fix this problem.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/qemu-iotests/testenv.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
>> index 0b32eec119..6326e46b7b 100644
>> --- a/tests/qemu-iotests/testenv.py
>> +++ b/tests/qemu-iotests/testenv.py
>> @@ -244,6 +244,8 @@ def __init__(self, source_dir: str, build_dir: str,
>>               ('riscv32', 'virt'),
>>               ('riscv64', 'virt'),
>>               ('rx', 'gdbsim-r5f562n8'),
>> +            ('sh4', 'r2d'),
>> +            ('sh4eb', 'r2d'),
>>               ('tricore', 'tricore_testboard')
>>           )
>>           for suffix, machine in machine_map:
>> -- 
>> 2.46.0
>>
> 
> r2d is works only sh4 little endian mode.
> There was probably no other hardware that ran in big endian.
> I think sh4 alone is sufficient for this test.
> 

We can enforce that with:

-- >8 --
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index 1660d292d53..01517e5c29f 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -12,6 +12,7 @@ config R2D
      select SM501
      select SH7750
      select SH_PCI
+    depends on !TARGET_BIG_ENDIAN

  config SH7750
      bool
---

