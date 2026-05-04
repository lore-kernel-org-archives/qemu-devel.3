Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525CEFF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsTn-0006Jm-JY; Mon, 04 May 2026 08:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsTU-00064S-T7
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:32:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsTP-0007GY-8L
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:32:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso42684555e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777897949; x=1778502749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V4jYpYkE/9RSm0f79qfdUvw/YpXb7ygJmHHvmnXUo80=;
 b=BR3wsAzcRjng8Lm+kqN/etK7EtuqCeFc3IjsfCmYv05/mNn1acHwiu4lkRj4WT39xu
 MGU2q1V0mLTWvCjTTfMXUnIZgGkufLXRkuZ79NlkvwVgRXFPSLfEtxlTInSUjFCjl3Gz
 2+NEwdMj1QQCu43M9xKd7km5lW/2JOThhsFsJgGTDv/4JmlGRhebKyw9G/jBemD2IkkM
 L5YIM2T8HU4WKIV6sOw6pMBXrEPd9ckdrubC6nfrQYqu4gPANWf/O92gQKcM76fJK9M8
 DSAOj1L4D9Dt+0tnqX4tRQuoarGf+IN+t2lnNoc7o3Qk8hz00HJRlLuWBggtUfvDNCn9
 XigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897949; x=1778502749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V4jYpYkE/9RSm0f79qfdUvw/YpXb7ygJmHHvmnXUo80=;
 b=s7zOcVVcUVjtszdnJuZd1/gX+ZmE+3JIZZqQdcAc/hlXH0+vNObbcEn89Iqq1pxcNl
 qi/DVHOzrnxn3vLpHiocUM57F+fdVlNMGPNU51nXUhndgYlYXNSpRUbvK0FblVhKsPFl
 ucgPtAIXStC7WWI165KwZCoBF8NCwoXsZ5n8f1pC+M8HmMWp7SClVLKm21+Xp4hSV4Kq
 Ill0i5TLCJ5jXhQVE1R4rk7RyZajaCfmnbDfoUGyBbWwTHZV37+iHizB9EdKtXGu50+9
 GoysCKFjallI2OEuEmi6yGafyS3GwTrBVL3IwzQ3VIVE1kOkkP/rAZhvUTXAjMzf2+hu
 E2Cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZCh53WpWL0EgrvEj0hmgbgKys4FnqrvlL+lDDfH+z/rBuBbjGGf4RfYHmhALM1VU5HHmwlO0mrX6z@nongnu.org
X-Gm-Message-State: AOJu0YxcZE5MdBQ2g8kBXHB6u3XTQZ4MZvFzOmOwRWVkmRL4u6N9NlaK
 Y7ecOle7HW6i43op2TgyS+EoCS+FLYl5Pzce1P8wNrWw5C5ut6WxjujuShVnZk2/P20=
X-Gm-Gg: AeBDietR1zUFFeEU3EiLprvfgF3uimme62SOV3tvH8maS7wxwj0ohor15+wDWKiDekT
 VbGusE8J7EyfaZeSDoNUNz+Q2UCecmeWzyzRvP4oHwFO7DGS/lZTgZNsW8Z88N6ZXQEUNx4SnZ5
 b98eHH+79yQXn/ic0e41QP5wHL5E9+pmLVmpzdQsh4DgPuVcRXX8c4exAt955q6JGXiUTkKp0Ro
 PNwwlEDDNasVrUBqKfDhayGGJHbHWVicsHIyd/sDONRUHiQh3jQbOH/r163dveW/e9XKVaVpaWh
 W1WHgRUGemqWRKmDAqiAtaxOoTnPB5YTjeH1r82KJ5RprtNOmSvBJts/GP/hd/vtdGgGd40589t
 kX6AqcIKSr6WN3bBan6K1d4iWHjLrMgQ3PVk5YDaylC4FqvX05CLFpJsQQcE+oNvzt5YTZV2WkO
 cTngrXMehgVOxJe04AI+Hxu+buyhA9xdCSuE5QsVcx68AZ+Hql44r8a99rVt2W+H0FvxAtBLPnj
 Ek3
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id
 5b1f17b1804b1-48a9852f471mr152782855e9.2.1777897949350; 
 Mon, 04 May 2026 05:32:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b99127sm317362735e9.0.2026.05.04.05.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 05:32:28 -0700 (PDT)
Message-ID: <06c5cd6f-46a3-453e-a0b5-30e2bd03a4d0@linaro.org>
Date: Mon, 4 May 2026 14:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, milesg@linux.ibm.com, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
 <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
 <4def4bcbfe241bcd8437a195757dd753ce09a32e.camel@linux.ibm.com>
 <1bf864b8-0dcf-45d6-a2fc-fc34b1bafe97@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1bf864b8-0dcf-45d6-a2fc-fc34b1bafe97@redhat.com>
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

Cc'ing Daniel and Thomas, our deprecation experts.

On 4/5/26 11:48, Cédric Le Goater wrote:
> Hello Glenn,
> 
> 
> On 4/30/26 17:43, Miles Glenn wrote:
>> On Thu, 2026-04-30 at 17:15 +0200, Philippe Mathieu-Daudé wrote:
>>> Hi Harsh,
>>>
>>> On 30/4/26 08:54, Harsh Prateek Bora wrote:
>>>> Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
>>>>
>>>> Glenn,
>>>> Please take a look and let us know your thoughts.
>>>
>>> Glenn can have a look, but I think we are good to remove them now,
>>> they have been deprecated for more than 1 year, enough time for
>>> any reaction ;) Otherwise that'd defeat the point of deprecating
>>> and the pain for us to schedule and wait for months.
>>
>> Philippe,
>>
>> Sorry, I thought it had been made clear back in August of last year
>> that we would need the PPC405 CPU to hang around.  The topic was
>> brought up by Cedric when I added support for the PPE42 processor.  Is
>> there some formal process I need to go through to have it removed from
>> the deprecated list?
> 
> I don't know of any un-deprecation process. I suggest sending a patch
> to revert commit 52f0b59ec6b7 ("hw/ppc: Deprecate 405 CPUs"). The commit
> log should mention the PPE42 processor which is a stripped down version
> of the IBM PowerPC 405 processor.

That, and updating MAINTAINERS for these CPUs (likely adding a new entry
including at least Glenn).

> 
> Thanks,
> 
> C.
> 
> https://lore.kernel.org/all/20250925201758.652077-1-milesg@linux.ibm.com/
> 


