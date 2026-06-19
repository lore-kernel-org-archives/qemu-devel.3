Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1500CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waTOv-0006KX-OO; Fri, 19 Jun 2026 03:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1waTOu-0006K6-A6
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:12:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1waTOs-0002kV-KK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:12:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so12922015e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1781853142; x=1782457942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uQ4iysQo80xSDu6IQlyIXy3tw1M3GKBZ45WuuT1atUw=;
 b=mm2Sr3UYdmC52LGz3YMEMPeWcIp/ApDnn/RhTCAWL5QuV6HW8vtURIglBVZ/v05Cin
 741RF2/NF6CzYnaZFfs47WC3DsVI1cbbo5U29QFX2p0D4uxv/iJfm38sMKD4XrLkZI4D
 BAHvZwvk3tpbiaUHQc0IcbGs/Hz6cF3ZV6YKmaPRuZppRkYSDePKPdmLixKr1+Iw+XbO
 0+mhf9vbspCRMmyAMJNE3qJDjdASwchQJC2GzZOJz1YdTMzWXYasdmtX2f3RBDYhGHRK
 0/eRZSqZkKbtv+0NhgW0N+htZc0A3ndb77wtyRuScrHwIYPh49Y36i7koSoEkUEgQkM8
 nUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781853142; x=1782457942;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQ4iysQo80xSDu6IQlyIXy3tw1M3GKBZ45WuuT1atUw=;
 b=DdFktZe8TdFbmOVISC0mg2VO/H8Bh8Y0JYHaYBpX5eFcYjUmqtV4bzwUUJVGoT76O3
 JEQt/YrnG+/Fmvzh5cvTYvdRFgIJiSd1YWuGacWyJI04Rv+4vSopfhGc1LtGJDSLvJBl
 67Lo1yaI+4OkA8b6CvaKgGH62m0bACWOf4UPx6VMnsH3lpmNmSi/QMDSa4iw/o8EDF+/
 mE2bx7aPkiuZCmPYOm11AOkHB7Qy7XxU0NSW91fCY/DQZ11+Abrh1uguXaeaRQQn0itj
 nf/wc3CsIiCgYBwk+ynfkBfo7eoeKFGHYPAN5r4CPgCKd2k4GlU4dE90qEtvgqGYY8lh
 DlbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vptHeO4NKqE1WsjcwgwH1+IXIQQYSq9WcGJlPeAge0uV8e/tVzJ7mtImuYiiuUR1kh3ICL5RbDdfD@nongnu.org
X-Gm-Message-State: AOJu0Yz+FylDY4EegBbd4EjLsbAD533f5PAzGVA1PNGl8FS1407I6opf
 07l4MsWf7V/BrJQEr9OPVwT4ceXCPbmUaABNf0ih3R7U1axOp8sqsuCyE4RgDiDedBY=
X-Gm-Gg: AfdE7ckLMgVv68e7G0PfnbCM8zKRbzTEgEYW+VlI15QfnXLfi/gQX0iAeCdAB/nGg0F
 LMAZuQOJXKS8OJOfXJ8mUf5FcubAEk/0CPsSIM2DM3Wdyocl5E5CvVh61qAzVPu+t9ZNPBqZ+SQ
 a5T/Ov4YXmBQYcHkgXf2oQIna+gQVxsXXqeDjlj8mafMegPm4SoTZRQ8nzY9R0TlOKErEoodpyc
 Shv/tY6boQnXD2e+kNVfUFO/qmwftSVzrRhn5XoUnLAayUws3YNEp24UEqbsqWPFaV8qVXOEnLn
 JHn2bgeaw7/lOYyuja5j2R+VPE+8e2VuLC0UHmoZ86PNlyJgoFcYVWCtRopJbo4ES8KLxPp2cQm
 jG+wjcl21mx4NGc5HXhRjeyYywsdOQDzTinc5YUHiZ+GpLfCJIIU+Sijxyl26Pf4BOYFD6QxjtO
 7nBPS29IrKC607mnrI/vnrgH0TJsNAXMGnzR1ICGB954zn7jY4aIgsloTqxv9aI671F2LaqJEV8
 vofthlUg3iw6rKdCtT460e+9Qjsmx2hQvvlfg74f+nIoTka69d/vHSM
X-Received: by 2002:a05:600c:8489:b0:490:d354:bd0a with SMTP id
 5b1f17b1804b1-4923f582d5bmr41847325e9.31.1781853141503; 
 Fri, 19 Jun 2026 00:12:21 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc?
 (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de.
 [2003:fa:af26:200:51a:ef03:a698:a1fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a3e8sm5231639f8f.19.2026.06.19.00.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 00:12:21 -0700 (PDT)
Message-ID: <b3f10a9f-513e-42c6-8141-e4d5616242df@grsecurity.net>
Date: Fri, 19 Jun 2026 09:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260327143413.254227-1-minipli@grsecurity.net>
 <94b4dd4d-9a11-43d2-8e12-bb5e0f46701e@tls.msk.ru>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <94b4dd4d-9a11-43d2-8e12-bb5e0f46701e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x335.google.com
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

On 19.06.26 07:44, Michael Tokarev wrote:
> On 27.03.2026 17:34, Mathias Krause wrote:
>> The control register bits haven't been updated in a few years, making
>> them lack behind features QEMU ganied in these years.
>>
>> Update them to the current version of the SDM and sort the 32bit version
>> to be in line with all the other definitions (descending order).
>>
>> This should remove confusion when debugging, for example, CET-enabled
>> guests:
>>
>> - before the change:
>>    (gdb) info registers cr4
>>    cr4            0x8000f0            [ PGE MCE PAE PSE ]
>>
>> - after the change:
>>    (gdb) info registers cr4
>>    cr4            0x8000f0            [ CET PGE MCE PAE PSE ]
>>
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> 
> This feels like a qemu-stable material, is it not?

Yes, I think so too (see [1]). That's why I tried to get it into 11.0
before its release but that didn't happen, unfortunately. :/

Would be nice if it could be included in a 11.x release, as that's the
first with CET virtualization support.

Thanks,
Mathias

[1]
https://lore.kernel.org/qemu-devel/fd49804a-c223-435f-a88b-c2183b391459@grsecurity.net/

