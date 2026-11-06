Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E7606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jp5yJ4lK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qGeV+1c6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPF9n-0006ta-KD; Fri, 06 Nov 2026 03:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPF9h-0006sx-TP
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPF9c-0006or-To
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793953111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pf3xgOcBFwDf+gEak1F1hXlhbNO8QgfTcdJLKSNSx3o=;
 b=Jp5yJ4lKrTUgtI/U5r0B3jlwjqidKOR3Nb6OeCsz2qQpMnlErb+0OtZWDROgdwofX7AEX6
 WfpRKi6jGadGGd+LO1TkmBe/Vjdkow38wtuYo6C36V4uqswChWewNtcDjdz8WLXGxax3t2
 ofwqor+CDbYdaX9XnbQ+V8LXNA6SCWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-CowUzdY5OlSmnbXLDkg1dA-1; Fri, 06 Nov 2026 03:18:30 -0500
X-MC-Unique: CowUzdY5OlSmnbXLDkg1dA-1
X-Mimecast-MFC-AGG-ID: CowUzdY5OlSmnbXLDkg1dA_1793953109
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so2969325e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 00:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793953109; x=1794557909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pf3xgOcBFwDf+gEak1F1hXlhbNO8QgfTcdJLKSNSx3o=;
 b=qGeV+1c6fwroLna0xpHX3wR9NjcxLHj4x73od4EOsNLaGT2jhDvkbo1xpF46Fg5mm7
 bCfO4TNF/5581bACfnysqbyyjLf3dDJyrXDnm4b7daYr2H06Q7pTPNBoiTSiS9cP8WMo
 msBKoMfs8Q5mQe94n+bYGgaZf1OmLciuyZycxqDv1GtNeH/9bXPVBQ2I3gd8rrj9Lt0L
 rKFNPxAjdG6JJZpTY7BbvM6wJ4JGVtQ9CtTmdwe2Bw9rzFxXOIt9NUID8V/32uPfyzwo
 TBb2jx0eXx4TgNN9qorTiCiqHRD3YECB7wXTlifGgGrd1VTbLMage1rRW4L+bFWjDKUd
 jCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793953109; x=1794557909;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pf3xgOcBFwDf+gEak1F1hXlhbNO8QgfTcdJLKSNSx3o=;
 b=R7T1YohdYZf8X/jT/BbmFsgp4wTpgV8PempNu4vYFM2vl5n7aniCrPeuukZZdvv5Zp
 HtA0asnw8G21JYd4OCKAmR26z6ylb414EbVT0qQlXXu22pDwx++VCBio2ioeHjq0xjbS
 UdrkPhSLRyAHNfNai2Ol63PMAjysXG1+mPzNfH8FEFhscnkNo1SZvOI21PJFhWFaKg5w
 vmKPZpNEgs41M3YrfyrDvYzkkKYSJDC3EvgBIuXczfPObblRb8qcDXjilYyOCeaC9CeD
 ASTpMM4No2yJOWk9fqhla2KKmjArMU5XKsFHqKAjTPFhK/aKTRk1U6fd5hmkQm9s0A2N
 Iu0Q==
X-Gm-Message-State: APuU4Z9Ah8VlE8wQT938k4PhDhBMnTZqdZya7h3exWMoah/dLiiM5A8p
 t6quKaJbs6yRGWvzny+WdXjB39li+AHLU3C/TvwMP/vvieXaK1LtKV/RU/xuCwmXeO52W+xOhz5
 L9ChADt2jvNLqBZqlbLowUmE39+4pwPpocBD0v/RmjArmHq7UZJk84Sbz
X-Gm-Gg: AYBFou3/pdGbiA4xO4yE1pMQ4bYkxy0tILc3FigFwbeFCkEtcYHJbvEiRZWPZxdBlqj
 6xqmuUOndXDJQhpA6uzZ0Wu/86ixkjTrGROyeX9pv233aCinoyD5QnLyO9fHVIx3gHFrkYKhLTj
 cp2P87pruptmvtC1l36gSsp0EWd0qa+ApA//w+xzz3ODzrEs13OgGCOYwMYkKgphdSmAVkh4Jit
 l+1DEkPfoF+vTF6ewijHy0ciH3++bt1o6CT9PJQX0e/iV0TmRT0jNvRNL5Lz+pNr+ZBIsUwCEWb
 zXFUOh09HXsP0S6uCvMz6B9WCDQiQGeWnZj7dbowVsyPSG2uxolwDuU0GOw/BQqrZi9MBFvHJCZ
 kcLv+bf5nfL5brfHeNaLAMrGQcaTiSedMez1gtLMPlOrw8klFYsKE7PT2GZXfCy0AI1gGH4+BYE
 3NS9YXqgp/RQ==
X-Received: by 2002:a05:600c:46c8:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4b6dea69526mr26444745e9.7.1793953108855; 
 Fri, 06 Nov 2026 00:18:28 -0800 (PST)
X-Received: by 2002:a05:600c:46c8:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4b6dea69526mr26444325e9.7.1793953108468; 
 Fri, 06 Nov 2026 00:18:28 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492fc80e017sm1806849f8f.34.2026.11.06.00.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 00:18:27 -0800 (PST)
Message-ID: <ce9c3579-2026-446d-8719-184e2c707d8d@redhat.com>
Date: Fri, 6 Nov 2026 09:18:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/lcitool: Switch to a newer version of netmap and
 check it out faster
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20261106063103.21061-1-thuth@redhat.com>
 <2bb23d49-3d2c-498f-a191-5a64fa8b3c25@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2bb23d49-3d2c-498f-a191-5a64fa8b3c25@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 09.07, Pierrick Bouvier wrote:
> On 11/5/26 11:31 PM, Thomas Huth wrote:
>> Netmap v11.3 is from 2017, so this is way older than the oldest version
>> of other features that we support in QEMU. The newest tagged version is
>> v13.0 which is from 2019 - still old, but at least it's the newest one
>> with a version number, so let's use that instead.
>>
>> While we're at it, also make sure to check out only the revision that we
>> need, so we don't waste bandwidth by downloading the whole repository here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/lcitool/refresh                  | 4 ++--
>>   tests/docker/dockerfiles/debian.docker | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> I'll send it when trunk reopens, except if you consider it as a fix for 
> current release.
No, it's fine, this can wait for QEMU v12.0.

  Thanks,
   Thomas


