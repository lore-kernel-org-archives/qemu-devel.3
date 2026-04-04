Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115A8E63FFF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9AbC-0007vd-E7; Sat, 04 Apr 2026 19:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w9Aax-0007sq-HW
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:40:04 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w9Aav-0006rV-Ds
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:40:03 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 bebc2439ec4f843644186b9355f35484e7904f3d978673e03be1b5b227237dd4 with SMTP id
 69d1a150bf9bc69edef14cff; Sat, 04 Apr 2026 23:40:00 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775346000;
 bh=zKmyzkDumFXb1FqaGxbqMN+gUzc97lAfvmhJPxhVVEo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=dhGmCPw6fS7AchXfaeIia0q7Bu7MC4JBZsGvp88aPaU2AfIqdEcuoPY8l+R3JQFgR
 /62b6mez95VbKbXt10PAI57goEbSbdGs7HgRvZIy4Sy6AbucBuRfOIRJJX/4ev3y6W
 vbF6oOZl/BsECY7B+5PQKzcvJEKI5XpD111kPZ83nRIsbUWTPQERBlxaST4EidMrtJ
 sQU4IgMXV4W3zTE/6lZiRIvlHKKrL7grHPiIgOg6mQjbIheFR43l1lHQ2NxDAyBtrt
 rZ1zgmnQz4bNnMBW+zwOKRgPFgVln2c4n46orjrEaNwWf/gIt/5h09G6gC+6MQtehL
 tiBhl+fXQSwXw==
Message-ID: <35f17ce2-b272-4494-8c22-2449d4f4915a@yodel.dev>
Date: Sat, 4 Apr 2026 18:39:59 -0500
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/4] alpha: Define Typhoon instance_init
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-2-yodel.eldar@yodel.dev>
 <5a6f0a78-85aa-4d80-9dc2-4a58100bf6ba@linaro.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <5a6f0a78-85aa-4d80-9dc2-4a58100bf6ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/04/2026 19:49, Richard Henderson wrote:
> On 4/2/26 03:04, Yodel Eldar wrote:
>> From: Yodel Eldar <yodel.eldar@yodel.dev>
>>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>>   hw/alpha/alpha_sys.h |  4 +++-
>>   hw/alpha/dp264.c     |  8 +++++++-
>>   hw/alpha/typhoon.c   | 24 ++++++++++++------------
>>   3 files changed, 22 insertions(+), 14 deletions(-)
> 
> This is doing more than one thing.
> 
> The subject says adding typhoon_pcihost_instance_init, but that would 
> just be moving two lines out of typhoon_init.
> 
> Creating the typhoon object in clipper_init is a different change, and I 
> don't see how that's even helpful at this stage, since typhoon_obj is 
> not used in clipper_init.
> 

Like Patch 3, I'll split this one, too. Thanks for being specific.

Yodel

> 
> r~
> 


