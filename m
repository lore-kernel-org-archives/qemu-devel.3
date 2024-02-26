Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7055C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVeb-0002Io-6A; Mon, 26 Feb 2024 02:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reVeU-0002I4-8Q
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reVeO-0005b2-Rv
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+9Uf2A4hWyBId3rEJ2quXrVSStW/DHxpZoBPKqs+Ff8=;
 b=jJayzaCDT0y6pvjjv17ndNsUlCcSwDga1AZFZlLaoTQSVIN3vsGCifhlYouvdFJrfY73mn
 f8cE6zSVdYA30/HmxUo2Dncru1hKM/LBIBtRNiGnoFqs2nOImnDVPuxnz1coWKykthlkv2
 DdPT9siD3QHP5+Xk08k+QzSJdq4ZIAg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-I2fgxk9DPzO09LudkDKKgA-1; Mon, 26 Feb 2024 02:43:44 -0500
X-MC-Unique: I2fgxk9DPzO09LudkDKKgA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d10bd57d7so983641f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708933423; x=1709538223;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9Uf2A4hWyBId3rEJ2quXrVSStW/DHxpZoBPKqs+Ff8=;
 b=CK09T1Gzg1B2yrP+PToyurfAQDLibfv8yglP4Kfo/9KzmyYvnEei2vkqakr4dARCbs
 toIj+SG3N+sSyGkKRPcPtrmbwdZ63bZeNH+/IaLwlSpY98tcGochcCQwdqPUS2m0QYdK
 zlveSbqNpJfE+uQ5blWjTSjmrHBhm0iXQtH3ONYdrD7Fqo/Zo4lPalTTeFMJflPqFgWV
 x65/oRG0zpwg5OyUsMWSva3c3b99rwi70SyhElU+RpT/Vk46EqMflsm1Z76XfUG5/bP5
 1V+RcEM0nH2K/QHkqmLR+VoaP7KJpmhl3FvsVz+KigW5qLi8cMZn9y6HV0In1Ozh8rMe
 Xw/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI9ZGdue1JL7QTt7jfnGUK60ZH7bhwboiXj4vp3CgzrZlqbQkX6KR7gownBzGCtAoxoV2jdx8Zdkc3M/5naMrICVA1jVc=
X-Gm-Message-State: AOJu0Yz06VLvgiHdGEb4rlNu2j7ICjBEt8enw0VUJO6ai/wN7CSQFisG
 t72qECDyGsyf1U7XER/5itbBIVYVx/RSVB7D4vNhM25O17fIRw1wxl6hl52E2dVI4IbiQuKCvRf
 fryJPb4wNLnRe6oQurUnw/Ala+o9FmcjRYgKuP+/NsxeszXGgtobG
X-Received: by 2002:adf:cd8c:0:b0:33d:747a:1e94 with SMTP id
 q12-20020adfcd8c000000b0033d747a1e94mr4049647wrj.41.1708933423019; 
 Sun, 25 Feb 2024 23:43:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXqfUHqmLtA/g57JSMAn2j2vSOkkGZrYAs0sAJ6OhEfHzGhlnEZnjF3lU0VTglrTUPTVF8IA==
X-Received: by 2002:adf:cd8c:0:b0:33d:747a:1e94 with SMTP id
 q12-20020adfcd8c000000b0033d747a1e94mr4049631wrj.41.1708933422703; 
 Sun, 25 Feb 2024 23:43:42 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-215.web.vodafone.de.
 [109.43.176.215]) by smtp.gmail.com with ESMTPSA id
 q17-20020adff951000000b0033dd1a3ed0dsm3737941wrr.97.2024.02.25.23.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 23:43:42 -0800 (PST)
Message-ID: <be8a82b0-cc82-4acc-997e-753c030cb286@redhat.com>
Date: Mon, 26 Feb 2024 08:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc/mmu: Silent maybe-uninitialized error in
 ppc_hash64_xlate()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240223083245.80175-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240223083245.80175-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/02/2024 09.32, Philippe Mathieu-Daudé wrote:
> Initialize apshift to avoid a maybe-uninitialized error:
> 
>    C compiler for the host machine: cc -m64 -mbig-endian (gcc 13.2.0 "cc (Debian 13.2.0-10) 13.2.0")
>    C linker for the host machine: cc -m64 -mbig-endian ld.bfd 2.41.90.20240115
>    Host machine cpu family: ppc64
>    Host machine cpu: ppc64
>    ...
>    target/ppc/mmu-hash64.c: In function 'ppc_hash64_xlate':
>    target/ppc/mmu-hash64.c:1154:15: error: 'apshift' may be used uninitialized [-Werror=maybe-uninitialized]
>     1154 |     *raddrp = deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    target/ppc/mmu-hash64.c:947:14: note: 'apshift' was declared here
>      947 |     unsigned apshift;
>          |              ^~~~~~~
> 
> The call chain is:
> 
>    ppc_hash64_xlate -> ppc_hash64_htab_lookup -> ppc_hash64_pteg_search
> 
> ppc_hash64_pteg_search() either sets *pshift or returns -1,
> 
> ppc_hash64_htab_lookup() returns if ppc_hash64_pteg_search()
> returned -1:
> 
>    1068:    ptex = ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
>    1069:    if (ptex == -1) {
>    1070:        if (!guest_visible) {
>    1071:            return false;
>    1072:        }
>                 ...
>    1087:        return false;
> 
> So IIUC this "uninitialized use" can not happens.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I had this in an old branch (2 months old) I just rebased,
> and don't get why nobody else got this error yet.

That's weird, indeed. Did you maybe compile without optimizations when you 
hit the error?

  Thomas



