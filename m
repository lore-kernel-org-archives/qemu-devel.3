Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87372C531E1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgl-0007jt-JP; Thu, 19 Feb 2026 16:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgL-0006yw-2g
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:33 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgE-0002bZ-4H
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:32 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c6de0527ce1so733263a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536925; x=1772141725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYArc6sDryUbkcdP91Hk6DvdYbcPxHd3idIwSTa27Rk=;
 b=E0Rsz2zpTICB0SiXJ/BLq20Xzj/c79UgYvO3WxYt+fkYHQu36BsWLQ42lcVgaeCbu9
 GuQuqKJ1u2TEIxg77l1EqSCMBMVUqyftJehC42s44yUh5XeKbZ4MUaIPMXQK01fv55bA
 pvoxznZMICvFkCjsfsfJg4COFkydeqsDOpTBTW9L3WImzb0xvQLEq6reGzOqhE/T0vCR
 TplVnf3DaDZNQt7SsqK/I7/LbAZ60hQyTjRxq6lx2an1JP6kvqIo7jgeJRO26N+l1Vyi
 /90p+hxl8s3/bGo753v7wc2fZQu6Y5Z59IbnsQf84SEcgjaSGMTD56WVfMQBqLTUfsZ9
 bTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536925; x=1772141725;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYArc6sDryUbkcdP91Hk6DvdYbcPxHd3idIwSTa27Rk=;
 b=BXHqEY9I/emaY41aImwNmXFBZZ79j6dgmyeuWrUXtWVe6togj3Ilm9DQpfXmrYmZs4
 BlD1szSl2G021YMrcd8FWjhI2VB/Aodza8vDrjhFjg87FwYdcemxkI13lK58BCJ8ZsQK
 j8fe90rof6FMxf7hYMdKUjprmXhEpI2mUMRftbDwHGYazCQUTJ0rXRA+ZSmVGispOmjV
 AuVojsu9QRge7TN8ND2BN1RXZrXVUf5gsp8HKwF5CwbAP2xqVkxLLmKO9rMMIuTk4VfE
 DWVk/GmEK0lwQNS2B/YnnWsS1ZxPBm/x6Vskpu6st4PO8G3rsuDye0onqgJ55NBPF67q
 YnIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEzxw0ZJpmEciXfHuvcKzmRIaCyf8GQrlJwf/xZreIPQAK2bDLBNBSC89eKz2yf8mFSmz4GkwT/ZnY@nongnu.org
X-Gm-Message-State: AOJu0YwIdoYJzILy7OY137JIJ4ciW3OQrui9qj5S5wDMB2Q+DRjJMx2N
 fhh8gh20VZigcP6R998YBwiZyq+3EFyFJ3WBxO5g0qvL9vJQCqm7qFsefB6ALkYQrSV6QzAfeb7
 pEpPJ
X-Gm-Gg: AZuq6aKqekVDbYAPTnBxcqi/NV9JlneBL42tobGinWedpVp8rzkDuF/6NWZ83e1S+QX
 XGCnkWdLS//e+kE+bhM118vRyRX84JuBCqFccV5j/RFjixkMUQXzrFMOAfiPEnm0t0K2pEhUXYM
 uWIIILYm1VsBr//XouLlI2v7kbFRPUQJ3vMRa6J51CqtF6P0Tvt9yENveOf3nhiDAfR8R8d++Vo
 YziRNi02Fl+YnpqYexjscjIZItdhzmLURtG+EzkpuMWOnOk7zG++wRmcB+mKL1N5yK+drorPvNY
 +fcz2ktNqCqEAuy/SmJGSg2QI15w0ssWcfILVS3gUoP9/OeofAVogpDBXHzZL6ZB1E6ZEfz2bKL
 ExAOMLrj6tOzfEFl4/iDViXkeKP1yywnoiIel72sxcVxqQXN7eJAyfci0ACnuF0gdTZmfPvsyvM
 UPkL+pD7gEl3vJrZlC5eSGN3M6Z/zD3r9/BiWKxZvs1BoAr+518jiI5PcC+OCvw3IH8raB
X-Received: by 2002:a05:6a21:a46:b0:394:58eb:48fa with SMTP id
 adf61e73a8af0-394fc217211mr7168803637.6.1771536924641; 
 Thu, 19 Feb 2026 13:35:24 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e52fcff01sm16619125a12.2.2026.02.19.13.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:24 -0800 (PST)
Message-ID: <0f7cd09b-7589-4845-a1e5-f165f3267934@linaro.org>
Date: Thu, 19 Feb 2026 13:34:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/50] target/loongarch: Build 'gdbstub.c' once for
 system single binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, Song Gao <gaosong@loongson.cn>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-46-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-46-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> There is a single qemu-system-loongarch64 binary, but by
> moving 'gdbstub.c' in the target_common_system_arch[] source
> set the resulting object can be linked into a single qemu-sytem
> binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
>            "single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS"
> ---
>   target/loongarch/meson.build | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

