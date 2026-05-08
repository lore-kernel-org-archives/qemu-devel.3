Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53725CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNAw-0005Hu-0I; Fri, 08 May 2026 11:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLNAk-0005Gm-7g
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:31:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLNAi-0007tb-R5
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:31:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso13540365e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778254283; x=1778859083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/t+Z/B8+Bnfb12A6cLEbGQfEl8myQ52GE3znNXmjEK0=;
 b=obSElV0Spp1lEr738rN4x4f2lZoRweMgihQYL6hTu+plSuBesNmXWcN19WwJRP0TQ/
 PLOvi1dyfzJ+geCLofj9ORhSxizOlrK8LaUllsgcbXwZBmQ1d45HD7a2SGDilRoTkMP6
 F0dcPQClnfAZMCP5m+H06HcO9ObsCSUgBt8YJaEWNy8YCbCB8n4A/qNYbR7j2zPcL0cX
 eIp7cPopI2CjnyhwZ6bv4Sn/RcOzwbwDgObtpXGs1xfzZGKzj+bDjoxpBqpKtqwNF0HS
 XmX6BEm3MyVC1MlI1pKEMHP4RTt+jA4rxyVNQeLDDgbWifmwoI0TWoP1MWpjiBnKVaA4
 MfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254283; x=1778859083;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/t+Z/B8+Bnfb12A6cLEbGQfEl8myQ52GE3znNXmjEK0=;
 b=Rlcm2QzRJYOpnDNF0RNDoMybY0PkCNqhk9ivZK1GfZXBxMO2znp1N2gLYpuwlFOJvr
 EQS4vVrDswShWVIMHAowHfCR6vQEzTG0hROkxU4NnqS++M7hDxp25mi5Zm1lF7QWR0kO
 hhQpZdM7vph8huWGeh7/3kRlrMVdbmuNwqFHXaD3aV4L6dts0d2QC11V+ez4xKFsF/M3
 AoSLvuGRr3OMT+8z8IiTtZnoMlWAZvDC7mLAYTG1NNDli/uhKpuSdndL+Je0udoLocug
 heFbSomMEhuSMVXeBTCr0t7gPua2R+FHMjK1pqPPpvOhj7U5AUsYjdZifjuv8zs5eFJn
 G7UQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TCc9I5M97typbyQYtxwQHhrQzfHXwYktkc4vNfIVUY5w/e2PZRt1ulOUC6zzH5YKS/4gdsm33aDu7@nongnu.org
X-Gm-Message-State: AOJu0YyK3YyHQUKaPAS3XufeoyI+fX9ba9EgvJAyST6zxh3WMAx0ZcHJ
 UbYFQ0If0H5M+QW0hYm6970UhIbrQ8rEyt6Q3tHxjenHo3bxnD1Bc+Q2mDCg8Ec4UP8=
X-Gm-Gg: AeBDiev6ZZCWBqz+E6/Jd3p0mQJEszV11xYl1IwPRajIbisbfVD8RBG9RijqdNduwwV
 c5O+TZAH4orbOvecdPfY4XfgP7off0F0o01On1t6TTGTFgpu4qYcQqLDEQyoDQ/gcvP2UXN6dek
 oLOkoM5If0/e9JHmALMRltlJ6v5z+LMLCno6g/FfSc5r7pbrnAsa1xDT9Woyi6dvrTeLrY/+aki
 leG9PoYQSvOpmD4cz7kY2AcjGHJc73ST2SIPKsuyTOLGH8umnECUqN1V6j+KAte4om7ioum4oki
 a3e2ACtQmdczBlPSfdmrUD7i32DlylKYZz8SEDjaiY0Lwxf93C4+4cblD2GmXhOujnQld+0X9Kc
 LpLN4A7Qzlkw0yX0Fq1MzwKWZBhJkU1FMyGK2YamSNeS1ldmvg8n0pdcNqIs9plREJ1IZPEpeaN
 3NQidXscasGrMiFUkOQSd83oVUSmfkt6272WPwWlrixFYPrDIJ/t8gfit87d0/Eh2wQ8y9EDPF6
 xqy
X-Received: by 2002:a05:600c:1393:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-48e635a1ae9mr77799395e9.15.1778254282648; 
 Fri, 08 May 2026 08:31:22 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6b17sm2161345e9.7.2026.05.08.08.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 08:31:21 -0700 (PDT)
Message-ID: <b945b362-06a9-44a0-ab7f-d5a47da4e0ab@linaro.org>
Date: Fri, 8 May 2026 17:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] fpu: Use {get,set}_flush_inputs_to_zero everywhere
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 14 +++++++-------
>   target/alpha/fpu_helper.c |  2 +-
>   target/alpha/helper.c     |  3 ++-
>   tests/fp/fp-bench.c       |  2 +-
>   fpu/softfloat-parts.c.inc |  2 +-
>   5 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

