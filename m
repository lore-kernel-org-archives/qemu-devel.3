Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B47FE63FE6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9AZ9-0006mB-8r; Sat, 04 Apr 2026 19:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w9AZ6-0006lB-Ej
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:38:08 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w9AZ4-0006rV-DB
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:38:08 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 ff02f649880f4c1d5d70100ea9aa6e7e10e475320cb5153f37db282a819a7e15 with SMTP id
 69d1a0dc37a549e1de8f950b; Sat, 04 Apr 2026 23:38:04 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775345884;
 bh=6KPKFo095iCc5JwnSCsD/tOrumx6Is7ZrBOcz2O6tbg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=rlEkOk7M6NfeAlOU8uJav4+bZUiJhUE/bM+p4hIbhat8iH6fxTpit/YisOtIRJM2C
 2bmojFhZCXbrc7SGkXBdNGttrNcaIwDlAvRSshxSo1UZUjLz4opJIrQK+CyaCLVV2R
 YllKyx9dpmdAvGUYZp/vQyYFOdYqzy4ipy+ATHTW/3JxNCqef33kGkEQZM42WveWgN
 5MRS8vGrYlezp+yq9EupGVaU3nqn4hIa+Ntp71zv2ThFVhwGYyu/eHt6/elUaGNfOB
 sYsquQ9HJfnjG/8RAEIGuQzI5tBY4KFAcgdah2SUV45FhezPNJh8bXFVDwP/wRBvSA
 +w82ehLS51VDA==
Message-ID: <d22fc938-770c-4c2b-9491-3cf6936ad494@yodel.dev>
Date: Sat, 4 Apr 2026 18:38:03 -0500
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/4] alpha: Propagate CPU index via MemTxAttrs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-3-yodel.eldar@yodel.dev>
 <47236dc2-cb06-4070-815c-b4f12128b99c@linaro.org>
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
In-Reply-To: <47236dc2-cb06-4070-815c-b4f12128b99c@linaro.org>
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

On 03/04/2026 19:52, Richard Henderson wrote:
> On 4/2/26 03:04, Yodel Eldar wrote:
>> From: Yodel Eldar <yodel.eldar@yodel.dev>
>>
>> Currently, a read of the Typhoon Cchip's MISC register
>> dereferences current_cpu for the CPU index. To decouple
>> Typhoon from the CPU, let's instead pass the CPU index
>> through the requester_id attribute of the memory transaction.
>>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>>   hw/alpha/typhoon.c    |  7 ++++---
>>   target/alpha/helper.c | 15 ++++++++++++---
>>   2 files changed, 16 insertions(+), 6 deletions(-)
> 
>> +static inline QEMU_ALWAYS_INLINE
>> +MemTxAttrs alpha_cpu_get_mem_attrs(const CPUState *cs)
>> +{
>> +    return (MemTxAttrs){ .requester_id = cs->cpu_index };
>> +}
> 
> No need for QEMU_ALWAYS_INLINE.
> 

Consider it gone.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 

Thanks for the R-b.

Yodel

> 
> r~
> 


