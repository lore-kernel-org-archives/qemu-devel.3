Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64364D3517C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7veZ-0003xt-5e; Wed, 01 Apr 2026 09:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7veW-0003tD-Vz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7veV-0006Q9-F2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so63411445e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050234; x=1775655034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ck11svj1yc/XGN6lG7sZkk6/lqlP+JtTxbz/p9nVBjw=;
 b=O/lZorBmIGEKHHhnwRiaxO+uXvKgqWyiRXd/k/S8cGBdkRYqsaS1veuRiKGo8YTj0i
 wJw7zAsUkoDANv6JWd2cqkyfaBPgttZqOWsY6ZOhcmdPN8fM1sxzvoxQsNV3yG/FK0MH
 y5jvYg8OEKuI/arVODDDsg4u2qu3TMYOhbl/3ZI21r97Jr9ZIoOpJS5vMbX8qoM6peHJ
 vQhhbDtW+w4BJEXun+WKcglMjwPx0oBcQ97/9YIfT4rNWbjIUhvdeyfbZH/HRp55qHfa
 aO/xnb8Nkf+Bz/U7JbkhaPbv+LR2QiskEnMtX7OA+WQsjSBgTc7E65eRjBKobSAP67X9
 N3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050234; x=1775655034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ck11svj1yc/XGN6lG7sZkk6/lqlP+JtTxbz/p9nVBjw=;
 b=cpgP/h/YxJXChEbFM1rDzydkdxmF/VZfsyRQRjsVG0zdkj3Cg9/F+/N4h54a+c1ZfZ
 pcqMUoa1zZs5K1USaMNEhNTaWdyhimVINCdOX1Bmu4k9brF6YFPqSfmC+coFW39ZH9VT
 SjYNw63H3aWwWZbdi5nyxhDnfMzURxqYeVJm/8FTtd1O5dg8cI4Y+Dp2/M8sZMFRDe5o
 CjzXpeOwnkcgaumirGcgA++tD8z9ziXFjn4a+vjVKDUGzdz8O3W51O4xn5e5lzmfyRGW
 7R0qEwucIBqBLwy+/y3GPVuZxn+ELzf9xJ2EQkkCLBmvhp+R25bGd2viVxOQaytpFvdU
 iYJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPW2h/RDNvvAmcD0argOauUnwsIshb8hd0J7Zb1g0+jV5Ow2OFws0l6gQFBFQS1BsmMDT9XYEfe0ts@nongnu.org
X-Gm-Message-State: AOJu0Yx2ZCncM8DfM1OunjS+dindpR29wlGSzuylFP/Uyp/JDjQCTGwH
 UdPkKpem+KiiLS3xZDG6/6OP9e5/PF7167KnbSeE+W46wGf61V9YEGw4C3kSNgh/5Bg=
X-Gm-Gg: ATEYQzxxNf5UzKbMQFbeT6mS6MUGah4+9uS4Jn58tE/nmYc8qm3HchiJNX3pW3HNh/d
 wBRr5OEBFf5VL3r5WOQ59L+LRxWLpuTQSmPSMhpLUG7sY50ynjNSO3bCDeU2r9fhf/UYISC097A
 wYm+tKh8oiqyPJ/HTe+SrUZwjx1ivpYebiCGCoW4n0DiXOSt/f5coScxWQ5SDBbgmc2SStyW0Nx
 p30jIQUQrRhYi3doJtxw356qbMC5MPSSsTBVVSRDO1Pf52Gu2w8Kxyc1EkfuoyQpE8gQgXEeXtz
 uR3k+OYH3b/GUTmO2eVo80/aXOY9bF1biwNAsEvWxIWj+3GKVqOsgnVDQoVLm32OjbWELkCJjEf
 TxQ8m0lM0pID8kiNoCjociKBhpj6WHWBN01vXkxd9ESET4ju1MOu+hXjI5hf0CImezpaAiMiCqR
 LxFPozwgllYNgFuPX4BEC5qM2GzIcAbeAuT2nXmlumCKxnRiz2XNwHMwANhSInxxXPfw==
X-Received: by 2002:a05:600c:a51:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-4888358cd01mr60817885e9.15.1775050233389; 
 Wed, 01 Apr 2026 06:30:33 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c883b96sm41490315e9.17.2026.04.01.06.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:30:32 -0700 (PDT)
Message-ID: <c6f1221d-c49c-42c4-b8b2-28f11e004cca@linaro.org>
Date: Wed, 1 Apr 2026 15:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 03/11] vmstate: Do not set size for
 VMS_ARRAY_OF_POINTER
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-4-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260326210532.379027-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 26/3/26 22:05, Peter Xu wrote:
> When VMS_ARRAY_OF_POINTER is specified, it means the vmstate field is an
> array of pointers.
> 
> The size of the element is not relevant to whatever it is stored inside: it
> is always the host pointer size.
> 
> Let's reserve the "size" field in this case for future use, update
> vmstate_size() so as to make it still work for array of pointers properly.
> 
> When at this, provide rich documentation on how size / size_offset works in
> vmstate.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>   include/migration/vmstate.h | 20 ++++++++++++++++----
>   migration/savevm.c          |  3 +++
>   migration/vmstate.c         | 10 +++++++++-
>   3 files changed, 28 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

