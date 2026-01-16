Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4747DD4A604
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeGp-0007P3-Rv; Fri, 16 Jan 2026 02:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeGg-0007M2-Sx
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeGe-0004sz-Tq
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768548550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XK3dLO83R+YVc18tZJ9BXa5qJQxcmyXg4xEUxsNHudo=;
 b=NYmjBEkududg+WxMgWIzOHrrbnrQRyZsFS5D0ark0BGcL7rnGqRHttNbITGZgwaM5fpZta
 Jbrm+dUtS6Hs67tGKZKtoXHl/YHtK6wFZVoGmE+sD2PKHx6rcAXgMvG2bmVNKwF+MZmMJh
 pqV81p3K8WQu7+l7G5ODkt7FqYxb0tU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-VHx4y6pUP5qeS2n3Uo8g6w-1; Fri, 16 Jan 2026 02:29:07 -0500
X-MC-Unique: VHx4y6pUP5qeS2n3Uo8g6w-1
X-Mimecast-MFC-AGG-ID: VHx4y6pUP5qeS2n3Uo8g6w_1768548546
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b873b0bfe9dso160891066b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768548546; x=1769153346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XK3dLO83R+YVc18tZJ9BXa5qJQxcmyXg4xEUxsNHudo=;
 b=spiqUs0sYKqA04f9ERSQa86FKTL6JLRg3Og1SCfmKpTorL743f/FbI9ZqR0lQ5ifU/
 KHNfo1irfD8xTS+aFQIM3e4Hmjr5xZRD0P5V1ypUuSjWlsHWvEnvb2yNLNDOwlgzLxJL
 rlmDmRIYjxe/x3AlEGLojf6h54cGVhtXqtTMOXCL2oYmJAUh8rRP2wXI8XIBCKndFyuo
 1q1QCpwAK0tsEDIOD4PVr0kh602KoLyx7k4DnoCLpTKhImBi2MxbAuV7fm2ra37bpYAS
 NNwYf/6yYQ+QUHNordeH2vF7SLM3gEHRr7vxtPtHr0oCcwT6luP3GLtYoQUhOtXdmdoQ
 vLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768548546; x=1769153346;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XK3dLO83R+YVc18tZJ9BXa5qJQxcmyXg4xEUxsNHudo=;
 b=mJeLXmTIM/PDrSXa18SGS5kqoWlNxSmACdfqdIpf5Q4o1iVt3oaGl+hrkPjS1C5Jvg
 BlABP8SwYNuj/SfWAhq1aBhfsAGR1T5RhRobfRzewoSkFtaFsRNKcKObXpAdPoM8U6d9
 AnsbG9krliU3PinZ9XZ4IIt/zLy8pjhcjkfKqFA4BGy1EgDO6OPygphW3T2qOxBdNmMf
 CFLOT9u9WdCFctgbuMoftIVVhrfqH0zIIg2KGMJMp54QJ3S+ubDyztJn3wUZW+b1bavp
 J5ilzycSI3A1gPxFTQuCID/oOxWLBUh0JtArxEnyjaW9w5fEDjZ/y/nA5gF6FeUDeDbW
 Tc2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5/NCGgNm+dcyU5g/X8z7ViaJ3wVbnhJmCT6zuj3CBRw9eARLKnDMoQ9Erj3LUZEmIbaGbbrua2BRI@nongnu.org
X-Gm-Message-State: AOJu0Yx05pRrip5MBt50U4x+iCqTRrpO+JOA4QV9fucL66X9SwmZlFU7
 uZHN0h3vw3lLycg1MA+GP1/rFktjA4l12Vez8Gd0AaU3Z+sG0O8QtItpyA0BuJgexSg3qX0II/0
 zwd559qGqP3I3D3fZrF0WHZoz53u6Oi9RC2NPPgUAOI83GRDn4obAlWuGxbTjHdG2
X-Gm-Gg: AY/fxX7OizlAswfwOPNH1qk8kSbeBwIpj4uVleV3R804Xs1inNsIQLgFFzQlgXL/J9A
 0E1h6JWXAFgXu6QgpVhFJdquQiBru5fCxwC0tDH+6A3vBBkF7NKNHf33S5j3UvP/ASTGVqmVoTf
 YzMCt7TTqgOka5UU5EstBZZRxbbnPi9oCDFDS38CwoMRPFLVMGw2BD+d7xUuu6qJHBO4kWeYUCB
 5CWgivdvHSGoCBKw6zJNOpjDfV1k/cTCsH/mlWelqPbSROF0SwWfj3h7snwmwkYM1ME6D7UteOI
 ytM/KZohWSmry5kDMkrUEkAukDOJj6yH7u9bxw1zT+Co0L9JGjQy7K4HbcsoOE9nnKx2QlRlhdI
 Prdhnuk0=
X-Received: by 2002:a17:907:7256:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8792e196f4mr206883566b.27.1768548546399; 
 Thu, 15 Jan 2026 23:29:06 -0800 (PST)
X-Received: by 2002:a17:907:7256:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8792e196f4mr206881866b.27.1768548546044; 
 Thu, 15 Jan 2026 23:29:06 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e63dsm157082066b.14.2026.01.15.23.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:29:05 -0800 (PST)
Message-ID: <e31d7369-071c-4f49-8eb1-686f43db76f2@redhat.com>
Date: Fri, 16 Jan 2026 08:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/50] tcg/i386: Remove TCG_TARGET_REG_BITS tests
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-11-richard.henderson@linaro.org>
 <3f392a80-0db8-46b0-9761-ce0d7492a624@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3f392a80-0db8-46b0-9761-ce0d7492a624@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/01/2026 08.26, Thomas Huth wrote:
> On 08/01/2026 06.29, Richard Henderson wrote:
>> We now only support 64-bit code generation.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/i386/tcg-target-has.h      |   8 +-
>>   tcg/i386/tcg-target-reg-bits.h |   2 +-
>>   tcg/i386/tcg-target.h          |  13 +-
>>   tcg/i386/tcg-target.c.inc      | 552 ++++++---------------------------
>>   4 files changed, 97 insertions(+), 478 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

-ENOTENOUGHCOFFEE

Sorry, I meant to reply to v2 of this patch, not to v1...

  Thomas


