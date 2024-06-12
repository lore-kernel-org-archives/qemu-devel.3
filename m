Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC27C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNI5-00082p-CX; Wed, 12 Jun 2024 08:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNI3-00082B-RK
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:41:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNI1-0004Zv-UF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:41:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so34248925e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718196080; x=1718800880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWHUKg/zjYNtmU/Lg/9RbL6pFprhOQ5VObmPARBdPVA=;
 b=voSipf0/cqpOy564bqbHQ2aJ4eT6mCYRc9kg+IZO2xjIPAbXg7O4Ifk0o2FvvwuLfv
 uLp+BNyLgAmbTVhtwS9yPN8bCLFUnejayj5KN/L24VlIZVYA0a1AV1Iu0lB93X+liJiT
 JYPFLCGGrJ7IJ1FUDZyoEU0sBkeZMwOKT6lLqVM9WM53j2IHByuHVYYhra4aU1ZUdvCN
 +tRxbLrCSNKx8FHVrm7j40gBD5G1LeCPtXWAobaJ1mw+N/9giKdMiKidrUO8R/LmqKL6
 tbYHjztFVBVukG1M2/m1DWtMaEvIJbAYaJxYK4Wa2d8dHzFtkgvdlqW7DXoe1gB2uu04
 ZBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196080; x=1718800880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWHUKg/zjYNtmU/Lg/9RbL6pFprhOQ5VObmPARBdPVA=;
 b=JFPQKv/d6biSjmhaf1j3oJR8koww/7xT7eZHSPU5uQhafwQuk0bfO9Or82vMfmW8Aj
 gFta+dcHk74VDGmAbWCI/kogKK6SmkNWspeJ/72Qk/LRDnmvNQtWBQadGbT9oBtTvouX
 8oG8ATnyn+JjaVKX05x+8qDlbCi/bREWKETdDbxog9Zqu+XHtBP2gxxR+WKPaIp9vEue
 IzYbpcEyNt+68O4ONinpNHt+PQP5bBvKu3tGJ/k/pGsH9XPquCvX5+lNj/8AHT0TEW1J
 Nw6APHJ4gjteQnlROMJYjoBWFkFrHGJiPekEcuSHqBzhLgQwHklvwhAia+VvlcQ57kkP
 HEUA==
X-Gm-Message-State: AOJu0Yy8RTrbCnThfnuBMhclImy+DaaBOc8mR5jO/o7y1iGom47hrd64
 sKQWE3gecmd0p1eP3l3+Qv4rEt2vCKdf+EsqT0J1peGJqD1BCtWbIxjWUyAWr4BiSn0WTn07zjH
 T
X-Google-Smtp-Source: AGHT+IGOEUeFaddceCgNfObA82oeV7XuFprLKyqmCD4u/BAlfUkwCpVyZZEXo52HeeSzD2Q09LY+vQ==
X-Received: by 2002:a05:600c:3b87:b0:422:123f:4b15 with SMTP id
 5b1f17b1804b1-422867bec5fmr14832375e9.37.1718196080127; 
 Wed, 12 Jun 2024 05:41:20 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422871f98bfsm25005075e9.45.2024.06.12.05.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:41:19 -0700 (PDT)
Message-ID: <b0b49b1b-6877-487c-9f4d-b29ae54c5ab0@linaro.org>
Date: Wed, 12 Jun 2024 14:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: assert fails in s390x TCG
To: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <6a3e8443-2d0a-451e-a481-cc26575d8211@linaro.org>
 <14787dc3-66ae-e15e-0bdf-14ca53bff17d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <14787dc3-66ae-e15e-0bdf-14ca53bff17d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/7/23 18:43, Richard Henderson wrote:
> On 7/28/23 09:05, Richard Henderson wrote:
>> It's the page containing both code and a page table entry that 
>> concerns me.  It seems like a kernel bug, though obviously we 
>> shouldn't crash.  I'm not sure what to do about it.
> 
> Bah.  Of course it's not a kernel bug, since the store is to LowCore.
> And of course LowCore is part of a larger page, which easily has other 
> stuff.

Maybe related to
https://lore.kernel.org/qemu-devel/20240611215814.32752-1-anjo@rev.ng/


