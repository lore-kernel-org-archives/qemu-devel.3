Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD97CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waTZY-0002BG-Jp; Fri, 19 Jun 2026 03:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1waTZQ-0002AD-MI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:23:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1waTZP-0005nn-41
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:23:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-46255b269c2so1329379f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1781853797; x=1782458597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bHb0K4WMa3w7V3TJW0HfB4GphaVB4zINoZuRbv4IDUo=;
 b=YELbNVb0rbef+iKGi54vwD/8U3u58mHG5hEKWvt2VNt+Wqc560PfSWddoNgV/LmGWX
 dqbdrTZFCpzwOSKPkcVwCilfzFZ8iOewJXh5Z5HlYA2ntewJARBF3hvDnZVvr42EB+wg
 GJhG6vPE6bceKSPNBkmEpm9AW6Dp5gA5MV92tAjZnQrb7uZwsia2sNDKeu5OYkB0h6+G
 DmSo52jqOY4YFHIyl2du6S1dT2T22k00n6Slk0re/TmE7u3KauJmRuYknUdqhvSes6zC
 CmTjKNsik5M8o7+uxLnAOYzr9KWVFOY5blP76HQeHaMpvQnjGvYQUjUxdtdKQyMUvQXX
 egtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781853797; x=1782458597;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHb0K4WMa3w7V3TJW0HfB4GphaVB4zINoZuRbv4IDUo=;
 b=sJjpY9D5yrsCnzCkT8ZMtb3X2m9riauKf7w6LyvSF359QwiYwiUSMfg1AmrdSZrNqZ
 O/6S6xqVzvu+B3JA0BFZNhW5esbAFGMBPB3+srbjPammC1QerTX9jt4z+uccWtTKYOe7
 7XJBqzYZS0fFfE4YSP27eTRWfw2FrcZzg/vXYOssaXCA1VCgHDGaFqXUkn8NgeXOcqT1
 /nNixp2CElpeRnY4HgJ7jdiqczlGxt/4Qj4D7gQTP362mMsJKETYYoz7q6vUz62yon36
 03EQ9vf3SOx/ukdwPJCFUYhpGCn7TB3mm/5SFsSdOEt4I3C931/VEo3sCgxKac7j3uzO
 3xrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HV8DxEIIXWwozW2nknaZfsNLS3ID7TS3yX5pei4rJZFfuSjkVL/MMu75yLJ+W87o4UmjfuBYnl2yB@nongnu.org
X-Gm-Message-State: AOJu0YwTxL4g4ExIqdUXpfoMmSUmZStQg2omD68wM9+XICPvK+ktuI2x
 z1qG2Gqhu+Jhp2fNhI9CHtdmlW2VD0FNjnFBpruhWHEzBNsKMEKapSX1L/2nxky6tGc=
X-Gm-Gg: AfdE7cnU8NKr6wXef2CGsqWAAxjEvqnfF5B5Tf3W5EDHOY3oooLA+fS4Tlzp+TWaJ1W
 RzYPSObcrnUH7frZ7brt3vJkuTmOayerlTFYE7X6hiqTeiZAxh9g+kg6XYMi5ZdT1wkQsQrZVqw
 IXtJ64Xsg7AjcuIFfliTpOx4qWwQsXfQ7gkRL7wuRZzq3BXD/la8s7r/v+YzY5lutIMeLjdBHpr
 0Vrf8KYpZsxmSuwwUqwTODidoffoPKfayPAq0IIjw781wEBqB9PWAzohcIerufIUSmwIlXUw2wh
 /67qpPUm/62uoQbWblMOjU+J280I7J0fO5MNP+pq98lH1smJCI7mhNCdzbrZsSQpzRsXem9kR3F
 fVNBCbTFIJvFeJzDRujg9fLip89jlhHUTtuYNarOEShvhg8piD8SAz5rwANtVmWOPcH9XICbhaM
 j5lZE1B/QJlFtUqCzoKBedEwQw8qMXVzMGwD9A+XlDXHmjDu3wzPFwZqbXLOURx08eIOoDavLOl
 qL2QZec9Ly6iNyoXGTeNSL+CyVCbVc8YwTdkgDZL5Sv+w==
X-Received: by 2002:a5d:588d:0:b0:461:b5be:3e7c with SMTP id
 ffacd0b85a97d-464fff65d21mr4488556f8f.6.1781853796790; 
 Fri, 19 Jun 2026 00:23:16 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc?
 (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de.
 [2003:fa:af26:200:51a:ef03:a698:a1fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a3e8sm5310036f8f.19.2026.06.19.00.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 00:23:16 -0700 (PDT)
Message-ID: <c507c17e-cb9b-4d8c-847c-c44c5f3cbcbc@grsecurity.net>
Date: Fri, 19 Jun 2026 09:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260327143413.254227-1-minipli@grsecurity.net>
 <94b4dd4d-9a11-43d2-8e12-bb5e0f46701e@tls.msk.ru>
 <b3f10a9f-513e-42c6-8141-e4d5616242df@grsecurity.net>
 <eab9f7f9-0f24-4df4-9892-96db02b231ff@tls.msk.ru>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <eab9f7f9-0f24-4df4-9892-96db02b231ff@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 19.06.26 09:15, Michael Tokarev wrote:
> On 19.06.2026 10:12, Mathias Krause wrote:
> 
>>>> - after the change:
>>>>     (gdb) info registers cr4
>>>>     cr4            0x8000f0            [ CET PGE MCE PAE PSE ]
> 
>> Would be nice if it could be included in a 11.x release, as that's the
>> first with CET virtualization support.
> 
> Hmm.  So it looks like this change is wrong for previous releases
> (10.0, 10.2), and should not be picked up there, right?

It's not wrong, it's providing symbolic names to architecturally defined
control register bits. If a guest doesn't use these (because it cannot
because of QEMU/KVM lacking virtualization support for them), they just
won't be used but they're still correct.

Looking at the git history, it looks like QEMU gained PKS support in
e7e7bdababee ("target/i86: implement PKS"), which was v6.0. So this
change should be backported to all still supported branches, imho.

Thanks,
Mathias

