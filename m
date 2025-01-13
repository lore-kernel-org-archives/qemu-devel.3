Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D171BE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 06:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXEK8-000574-UJ; Mon, 13 Jan 2025 01:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXEK7-00056u-9L
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXEK4-0005Mc-LE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736751194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pdm90ZFXqXfhlySAGDmKOf+f33qwcvJzeVusKwT5HGE=;
 b=JWyb3dntydJo/bMzEsQt1yxEOEBVl9qoEMHviMTx1QWJjTTwkue0cGspAClUpvkmY7M047
 qr8fG804Va31RJdyOfawHb9n/zxlPKrmxTzZtQ8p1U9XR6S+oCmZ7gtKoEV+w0MFc9U9wJ
 DywBhkPgWUxR825rD6bAc+Ws1e4oWko=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649--CXvEozMMXa-bMId0-osCA-1; Mon, 13 Jan 2025 01:53:11 -0500
X-MC-Unique: -CXvEozMMXa-bMId0-osCA-1
X-Mimecast-MFC-AGG-ID: -CXvEozMMXa-bMId0-osCA
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d3eea3b9aaso3073434a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 22:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736751190; x=1737355990;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdm90ZFXqXfhlySAGDmKOf+f33qwcvJzeVusKwT5HGE=;
 b=ZJ6HFIzR2RrE6AZKXXsCHFuO1uGNGRwWpJFnKB0VzMJIuEOSRsdBDALYx2IdFnkQUv
 WQWtDlk4n8XOLXdfEzj/DZoifoMJMm9lUkizXPIbaN7b5x9Emidbenax2hzoNyxnFp69
 sROOT3JqlPvrOFEj3ctY8tsOZKkGEziO5yQw1YILPli6Fr6Uh3dTzIIL1WozQs2mkSVu
 vgten+10R8560/JUWtqsCMnkNcCXzpHwZPAXI0U2QfgR9oXpXQh/WIvqfSe/HEG3TULQ
 UP5TA7+TWce5+v/NlAfmm1bkt2IPhdTOAZMFyHUf50+F73+oVVfsl7+6dr74Do7I31oP
 cRfg==
X-Gm-Message-State: AOJu0YyggPGWC7YX3sCkxlDRHjBapyfNlOMdAhmojLkR/dkYGKk8Ij6N
 UmAW0zn3Tvrjhq/feXM0lbWRIuNfH4jXZ3ByoUKax6OynmLwFfz5c12Wor9l0VzO4K1tFfBOx/J
 vEsHR1XeHggWfvoE+YgCDxw0TjIXzHxP/KPWxF1JceeTNzB817BOA
X-Gm-Gg: ASbGncsTZ0ueEBb0RliW65XZczv/677v8/XBy1VV3ZYdRNT/F51f+ONahksXpNnOPVu
 Wx9/QyZ3wLobQsYaNmzoMdef25oR42emCg4kGG3SaLloT9irG9/eoeGTU6/vdC2FKMleG9AOpJC
 Lc5V1tm5uKx366oDhFryeKIUGAmGxNN9GhosY1hxRYRdbSa3oIYq3+I7EHZmiNNSnI2EkjPJ65Q
 P7+hLz5DT5pjvZOIpbKtgeXp+Pooh0PON0+g2lkYnC0DfnKgVtVTPM6+4B7L9gbbdWh0UM187eq
 z+ZhfCB5dQ==
X-Received: by 2002:a05:6402:5251:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5d972e63ddfmr42175084a12.23.1736751189845; 
 Sun, 12 Jan 2025 22:53:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+EXZ6gm76Grq75RHmeoDp9uSVBKBdg0FK0KKqfom6s8liDoEO27bSb1mzKpKDREwNlOB3Vw==
X-Received: by 2002:a05:6402:5251:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5d972e63ddfmr42175025a12.23.1736751189411; 
 Sun, 12 Jan 2025 22:53:09 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-16.web.vodafone.de. [109.42.48.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9562e83sm460671766b.103.2025.01.12.22.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 22:53:08 -0800 (PST)
Message-ID: <ac2a2d0a-49b1-46ec-8c45-0d9e4487fb11@redhat.com>
Date: Mon, 13 Jan 2025 07:53:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
 <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
 <70b28370-228d-41e6-88cd-eda686d55b21@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <70b28370-228d-41e6-88cd-eda686d55b21@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/01/2025 21.54, Pierrick Bouvier wrote:
> On 1/10/25 08:30, Peter Maydell wrote:
>> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   docs/system/arm/virt.rst | 14 +++++++++++---
>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>>> index d25275c27ce..9f1457cf9a2 100644
>>> --- a/docs/system/arm/virt.rst
>>> +++ b/docs/system/arm/virt.rst
>>> @@ -17,9 +17,17 @@ to have the same behaviour as that of previous QEMU 
>>> releases, so
>>>   that VM migration will work between QEMU versions. For instance the
>>>   ``virt-5.0`` machine type will behave like the ``virt`` machine from
>>>   the QEMU 5.0 release, and migration should work between ``virt-5.0``
>>> -of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
>>> -is not guaranteed to work between different QEMU releases for
>>> -the non-versioned ``virt`` machine type.
>>> +of the 5.0 release and ``virt-5.0`` of the 5.1 release.
>>> +
>>> +When saving a VM using the ``virt`` model, the snapshot is automatically 
>>> set to
>>> +target the latest ``virt`` versioned model. When loading the VM with a more
>>> +recent QEMU version, you'll need to set machine model to match the 
>>> version of
>>> +your snapshot. When loading it, QEMU will return an error with the expected
>>> +``virt`` version you should set, so you don't need to record it.
>>
>> I don't think we should be encouraging this -- our standard approach
>> is "use the versioned machine types if you want migration", not
>> "you can start with an unversioned type on the source end". So I've
>> dropped this paragraph.
>>
> 
> That's fine for me, I don't have a strong opinion on this.
> I just had a (good) surprise when I saved a vm with virt machine, and 
> realised it's versioned by default. It's good to know that when you export a 
> virt machine, you are guaranteed it's bound to a specific version, so you 
> can always load it with new QEMU versions. This is what I tried to express 
> with this paragraph.

Technically, the "virt" machine is not a real machine, but an alias of the 
latest machine:

$ ./qemu-system-aarch64 -M help | grep alias
virt                 QEMU 10.0 ARM Virtual Machine (alias of virt-10.0)

So maybe that could be mentioned here instead?

  Thomas


