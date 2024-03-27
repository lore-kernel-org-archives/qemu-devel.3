Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEE1C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTBl-00067R-4u; Wed, 27 Mar 2024 09:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpTBk-000678-0l
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpTBh-0003oO-Gt
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711545567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bs2V6mluzgyIKODbH3iRM5jaxEkr5fEgX0samReN4B0=;
 b=hLyaF7IVOPOh8kHHtmCfnbKuaA8Siqem/gTAu5WyYlRV6fsPaGFqO4EkKpXKXgFYfySORE
 HRAWYahdR/dl8DhLO7EH2FmN00oExranDXtaBJcYAIkl4FnLrWESeT8gJQojBpoY1Ma+cU
 EllUEz2SY9ra+gIEcFHZUzVrsFlLUs8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641--weIZWIpOJ6mzWBs8nbl2g-1; Wed, 27 Mar 2024 09:19:25 -0400
X-MC-Unique: -weIZWIpOJ6mzWBs8nbl2g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ecc0f0c95so3716738f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711545563; x=1712150363;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bs2V6mluzgyIKODbH3iRM5jaxEkr5fEgX0samReN4B0=;
 b=IUw0xAiNdDoLxOx/nPjgfdJLfBsFKds2eFPR60nragx4Rg8D8s0Rdikk6cz3D/I40Y
 6HGcDPxJkplzwpzpkx/aNRDGSfc2yfFBeLfhOKosMhAW7tPS53GU8q1L3KZdRydkiTyo
 9t1KkabdhQZjcD79RvxacdqAKSIaX2CswT9E6GYYQKsoce9TfRAAHMjPyim4VCWPsuLr
 WzaTbwkhlD+ywSjlNJMY0/lrLCk2DWovl1jMdEIV80LcPAthCrCcPLbVVFzHKgH10h3T
 zgfIhmetD4i7asTPaiFqByLzA4NtKOn/SfZYYxOSNkrJ0enqg6xJgd2oQlienP9fAaUp
 1lUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUov+jmCwOUjgPmk4WwzJL/5Br3AtGz0p+xAAOL2x3oH+Z0nI6C8GI5/4+J1hS9GlNzF9N+X7FWsHyLoqJBhZSQHVdKS00=
X-Gm-Message-State: AOJu0Ywffc6RjOB2OJqWrDJ21ir6ZRojZnk09isCGv8gmdPcz3afBT5v
 B94aik/LE2v9J5lZYc4IYAqwQJZsEOMugSjWjDw+SjbdLGdyTCXtTpt+QDGaG5A9B1IE+ih1LXY
 2GSE30vqRU85NlcHkIGKubW8wzou8YCBV5HSOZjDUTNFJIHmysJGg
X-Received: by 2002:a5d:47c8:0:b0:341:bf39:9f8 with SMTP id
 o8-20020a5d47c8000000b00341bf3909f8mr2324812wrc.6.1711545563706; 
 Wed, 27 Mar 2024 06:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxD2o893Qkfuly+1uA8IEv+YXme9hc9NnDgxTV6gcYu/Hh3OELDDNdGCEPSJJydTZ8AFoZdg==
X-Received: by 2002:a5d:47c8:0:b0:341:bf39:9f8 with SMTP id
 o8-20020a5d47c8000000b00341bf3909f8mr2324795wrc.6.1711545563353; 
 Wed, 27 Mar 2024 06:19:23 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 bt17-20020a056000081100b00341b5cf0527sm4745104wrb.11.2024.03.27.06.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 06:19:22 -0700 (PDT)
Message-ID: <fb28d3b0-1ab9-4423-80ef-03a285cf02d7@redhat.com>
Date: Wed, 27 Mar 2024 14:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/nios2: Remove machines and system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240327123554.3633-1-philmd@linaro.org>
 <7aad7197-21f3-4c0e-931c-2eb4febdf94a@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7aad7197-21f3-4c0e-931c-2eb4febdf94a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/03/2024 13.45, Philippe Mathieu-Daudé wrote:
> On 27/3/24 13:35, Philippe Mathieu-Daudé wrote:
>> Remove the Nios II machines and the system emulation code
>> (deprecated since v8.2 in commit 9997771bc1 "target/nios2:
>> Deprecate the Nios II architecture").

Please remind me, why didn't we deprecate the linux-user emulation, too?

>> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
>> deleted file mode 100644
>> index 4748ae27b6..0000000000
>> --- a/hw/nios2/Kconfig
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -config NIOS2_10M50
>> -    bool
>> -    select NIOS2
>> -    select SERIAL
>> -    select ALTERA_TIMER
> 
> I forgot to mention I deliberately chose to keep the Altera
> timer model in the tree, since it looks like a re-usable
> IP component.

But if it is not used anymore by any machine, this will happily bitrot, 
won't it? I think I'd rather remove it, too ... maybe in a separate patch, 
so that in case somebody later needs it again, it can be restored by simply 
reverting the patch again.

  Thomas


