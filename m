Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6AFC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2Ej-0006Zs-IY; Fri, 14 Jun 2024 04:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sI2Ei-0006ZW-Cu
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sI2Eg-0002dT-Hy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718353477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oEdhGTrVtRaqF35u4TZs1tsp9BKWxNTmMK0HYGZcH7A=;
 b=jDIzqRoGsS0ym0P6fLwhftyI3fbCHTQ0DbAUnCA3wn5rIHT7B44r3dYWb/nnV8l0Hmbu4/
 fGeIaQYlnk1vYr1RkDE9sDJ3fAlGjcnqeXiKLAkX96pvAhGJnwwSfpGaZS5svGfusbDEGh
 yaRqMV88G1Zpv+30t+KBOnxakx8haxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-_2ZU0wmTP7GY6FKoKpXD4w-1; Fri, 14 Jun 2024 04:24:32 -0400
X-MC-Unique: _2ZU0wmTP7GY6FKoKpXD4w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36073f6db77so881583f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 01:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718353472; x=1718958272;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oEdhGTrVtRaqF35u4TZs1tsp9BKWxNTmMK0HYGZcH7A=;
 b=e4GiK9ZxTjnFE+LSvJUxUaiLZlOpOUvfe1etFjSb8crM7hrwM/mhlboYDaDeZ4bVik
 +sRIwX4khkl3CKGtS3JHObgwcZrWYeLX4eZDNm69EVkEjJh4u5DNFRFPwsba4oCb7m46
 CHueFKjKCzD5Q34M6mX8dt09vr+4/14FYpwvQhXNey3gOtHoI/BGuH7sEKm1zaiwg50C
 +/UoOTtFd8YI4WeB3P9PquGT1tMjATJNUR2sdJnHG537KCWamt58LhwKcuYkOYgt+PJC
 g5182GMrpngPlzcdX7q2cBC6XasvvBYrUssql0mlRAK/bDPF7akZFHe1Rqekq/BF/0pG
 mOkw==
X-Gm-Message-State: AOJu0Ywwlp74yQBAMKPDYbfw+Amxze7tZ4HgAy/tsQf86aMPIEpCyHUB
 tHXkfvP9Yz3IYFJFkTPWEqF5x2cLyOjtDX/DiybSUzUoMCutPML8qW5hS+ZZIthqyFacbAea/xz
 eFUOCgfppX34n9SVCnuFQ/VHnpgdWJcNkSUgsVcF418mL2APdEP0k
X-Received: by 2002:adf:e0ce:0:b0:35f:2092:39fd with SMTP id
 ffacd0b85a97d-3607a7675a7mr1235910f8f.36.1718353471851; 
 Fri, 14 Jun 2024 01:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrwYvfPZJfrelgk53hXzrHUW+mFwHNV/Q/vMbhReA3eVsdjU4I9Eq5jI0M+ynsV9P+gJiBJA==
X-Received: by 2002:adf:e0ce:0:b0:35f:2092:39fd with SMTP id
 ffacd0b85a97d-3607a7675a7mr1235896f8f.36.1718353471489; 
 Fri, 14 Jun 2024 01:24:31 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-242-210.web.vodafone.de.
 [109.43.242.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093568sm3671100f8f.2.2024.06.14.01.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 01:24:31 -0700 (PDT)
Message-ID: <c752752a-c45c-4428-948f-b27c18510007@redhat.com>
Date: Fri, 14 Jun 2024 10:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Add a CONFIG switch to disable legacy CPUs
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240613170702.523591-1-thuth@redhat.com>
 <3c138eeb-83df-4953-bdc9-3cf8343a0533@linux.ibm.com>
 <0b932efb-bd0c-435d-a75a-a6608097cb07@redhat.com>
 <dd562095-f104-48d8-abe9-9b22b53b8743@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <dd562095-f104-48d8-abe9-9b22b53b8743@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 14/06/2024 10.17, Christian Borntraeger wrote:
> 
> 
> Am 14.06.24 um 09:15 schrieb Thomas Huth:
>> On 14/06/2024 08.07, Christian Borntraeger wrote:
>>>
>>>
>>> Am 13.06.24 um 19:07 schrieb Thomas Huth:
>>>> Old CPU models are not officially supported anymore by IBM, and for
>>>> downstream builds of QEMU, we would like to be able to disable these
>>>> CPUs in the build. Thus add a CONFIG switch that can be used to
>>>> disable these CPUs (and old machine types that use them by default).
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   If you're interested, the PDF that can be downloaded from
>>>>   https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
>>>>   shows the supported CPUs in a nice diagram
>>>
>>> z13 is still supported so the patch needs to be fixed at least.
>>
>> Oh, drat, I misread the diagram, indeed. 'should have looked at the table 
>> instead :-/
>>
>>> Furthermore, z14 has the IBC/VAL cabability to behave like a z13,
>>> same for z15. (we do support VAL to N-2)
>>
>> Hmm, so if z13 is still supported, and also has the possibility to do N-2, 
>> I assume the z114/196 and z12 should still be considered as non-legacy, too?
> 
> Yes. z9 and older is no longer relevant (only for people that collect old 
> HW) but the upstream kernel has an minimum requirement for z10 so maybe we 
> still want to support that for testing purposes.

Ok, fair point, kernel support is a good hint, too.

> For upstream I prefer to keep the full list but I would be ok to hide those 
> ancient things behind a config switch.

That's what this patch is trying to do - by default, all CPUs are still 
enabled, you have actively disable the switch to get rid of the old ones.

  Thomas



