Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A730C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seq7n-0002s9-J0; Fri, 16 Aug 2024 02:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seq7h-0002nX-95
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:07:41 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seq7e-0002P3-Ln
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:07:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5bec87ececeso794806a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723788457; x=1724393257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ia6EoS/pQWC1dw280eGmttTlgXgRCOdoLo4NpzA3JYc=;
 b=k/5ZGQkZcImrpk1+4Y52A/38qNCiijRPYW5+ejfNb8zmoRQDTpFZmCDige2RrZ6qRE
 LonYsQOVCB8e3igOt+d/PReEEQy7htWjpjgHuTWsFs+E99Qm7Ttw7RswR1B6hOTiAYfX
 7NsPbc6uzPY+VnNcRmoqTLOHpTGP3RSHA2Mr4l1+0KxBzY/pJKgWyEUzu8NSPsSLdzex
 wznHn4HsRUtR33RKIRLalRb7gOn93cBF+veUgSj8YUzQwGorsFLVf2CuQP0Wkpca3Cn9
 21fg6EP+f4KAbXZFMIm07+LQ8Wg1FmJVdeeYXrBbqmBpsA5zlRjLxJ60dDwQJ8l6klw1
 Yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723788457; x=1724393257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ia6EoS/pQWC1dw280eGmttTlgXgRCOdoLo4NpzA3JYc=;
 b=JnTph1KSiQhFh0OSjOEQ4t8s3ZmNEAXRJgUWUnmSf8V1eQWIDdYL9f7epR3YzUL/sU
 G9HxoXh1cHkzaeLF3b6woz5rOorzjvsfjSoYVDyH5jb6i/poVBTmDRAFW3F/XscVmGw/
 7Dg2Df8KUH9dURNpkgOB6lMy678Fx4SJVefuttODTuqw1fNiFcf4YuVhEQCOOi59uoPB
 zoR13pBjqGai93yB2NbZKH8VPzaLSIwziy2YqVX2V73iTzcPiMlFWw/pOj6h5BAyY7Ku
 D/fdqtLkliKc2s8UVAiSWE15yfggdEiJS9vnqJ1MdEP6vuLicO7JiiRXqevP0zghBHZU
 Gu2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrJtaUrIvAN/01+v5jHWT9gj8Q4rhkVKOiMfpnqoSSAqSQmsAuRqZRqBQvbKn5JXhhlld/XKYafNRX6B/gzuhbQmJPf1A=
X-Gm-Message-State: AOJu0Yw5qD1634i57HKpFkklvCBbb/b/IyBGcMlehmHzyHcgIXijH2iT
 s6dqPWKIyyjYjFUPrRRpip3lZ1i5f4Hg+llX5SISqnWL6ME3EfRqVAzUKjU4baE=
X-Google-Smtp-Source: AGHT+IEqe2GCJDxHfY7CimAibElgcKjANogxf7tJsHiZQgN4+Ki9XqEDMIQQuK+H4X75bxaABcQytQ==
X-Received: by 2002:a17:907:944d:b0:a80:7c30:a836 with SMTP id
 a640c23a62f3a-a8392a4103amr121655966b.56.1723788456504; 
 Thu, 15 Aug 2024 23:07:36 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-185.dsl.sta.abo.bbox.fr.
 [176.184.30.185]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396d5b3sm203495966b.215.2024.08.15.23.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:07:36 -0700 (PDT)
Message-ID: <db09223b-fba4-485e-953c-73f050273c5b@linaro.org>
Date: Fri, 16 Aug 2024 08:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] hw/i386/pc: Warn about unsatisfied vmport deps
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <e7c17260-41d7-4749-aca9-da344517c772@linaro.org>
 <ghPjnPAU8FvuVvcKbO9wNpQPgm4ZwkjL1j5Vh-voSnVI8EE4tCUKDqmBj7LGXv2cc7Yt7IWlMvnbvA-I6QxR7iS6xDyfIwvpuKtEMVbxHIo=@szczek.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ghPjnPAU8FvuVvcKbO9wNpQPgm4ZwkjL1j5Vh-voSnVI8EE4tCUKDqmBj7LGXv2cc7Yt7IWlMvnbvA-I6QxR7iS6xDyfIwvpuKtEMVbxHIo=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 15/8/24 20:22, Kamil Szczęk wrote:
> Hi Philippe and sorry for the delay!
> 
> On Wednesday, August 14th, 2024 at 16:02, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>>
>>
>> Hi Kamil,
>>
>> On 14/8/24 13:10, Kamil Szczęk wrote:
>>
>>> Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
>>> to disable PS/2 mouse/keyboard'), the vmport will not be created unless
>>> the i8042 PS/2 controller is enabled. To not confuse users, let's add a
>>> warning if vmport was explicitly requested, but the i8042 controller is
>>> disabled. This also changes the behavior of vmport=auto to take i8042
>>> controller availability into account.
>>>
>>> Signed-off-by: Kamil Szczęk kamil@szczek.dev
>>> ---
>>> hw/i386/pc.c | 4 ++++
>>> hw/i386/pc_piix.c | 3 ++-
>>> hw/i386/pc_q35.c | 2 +-
>>> qemu-options.hx | 4 ++--
>>> 4 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index c74931d577..5bd8dd0350 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>>> }
>>>
>>> if (!create_i8042) {
>>> + if (!no_vmport) {
>>> + warn_report("vmport requires the i8042 controller to be enabled");
>>
>>
>> Should we fail instead?
> 
> I think failing would be preferrable over a warning, but I opted for the latter to maintain backward compatibility in this specific configuration.
> 
> But now that I think about it, this explicit configuration (vmport=on,i8042=off) is probably very rare in the real world, if it is exercised at all. So failing may not be as big of a breaking change as I first thought.
> 
> If you're fine with introducing this "breaking" change, then I'm down for it too. Let me know if I should post v2.

Better fail early on incoherent config options rather than keep
going with a broken machine IMHO, so I'd rather a v2.


