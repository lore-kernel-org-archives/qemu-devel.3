Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A163C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2Sw-0001IM-Q5; Mon, 03 Jun 2024 03:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sE2Su-0001Hl-UF
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sE2Ss-00014z-NM
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717401043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJdojyxkk9WmdYBBnBDwCN7m2Ehmdp9HPJ+LGsdeO1s=;
 b=WXpUxBvl9mmt7y+QouCEbZmSkWaeNMhXw47v+P7DxL7UXj0zmvqR8utVnT9C26FgpbNZAv
 2xATxFgCVAioJozubN+x4ubJmyf6GhYcimqQ9WkMDZZNw754sZiGbaIVKjOcZOrwKBKyHJ
 rhHzqFts42oZV0H/7NwIvgXGw8rIrpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-xNUOhxJOMISwnbXMKXw4sA-1; Mon, 03 Jun 2024 03:50:39 -0400
X-MC-Unique: xNUOhxJOMISwnbXMKXw4sA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212941e244so6304215e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717401038; x=1718005838;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJdojyxkk9WmdYBBnBDwCN7m2Ehmdp9HPJ+LGsdeO1s=;
 b=m7muxr76ebzkzekivYCp54LSDxbS8nnY/J0C3Sa9EgO+vCpYs2piUcg9dCKKVyj8Xu
 dh+7EcxNiWBWXrD7T2INnWKC4yQ0JFqJeZFU0ZX9+py9Vw5IyAIee4FbUxQmLT952+HL
 aFkLU/8p1Uu9+YVGaBL7o7CA8jMeOfZCDVVOmTTHgKFvA/hvD25+DrQGDwGtbLD/NP8r
 tuYYq2tB8sJZ1zjRFaPHs0u6q5yAFIz+UKF2RmjO4tQQcBq989duqoRkxpBsu0b71f8B
 GChTPAlUOxAboJ9kGYNDQwt+qDExn3V+pFVWR4r5QKFKFnZzL0Ds8EDSfqN3zUGtk2is
 QpjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDUvZk1kivi6DDsboUdarjEPzHvO85CsnE70MDYJVkm+CZrVmjhiEscveXDWN6zFvTKxz3wNeU78tKXLlpeC1eOdsn2L8=
X-Gm-Message-State: AOJu0YytRF/GVMYMOrJ1AKTwVestd/Re9oqOrbtnMaV1HqZDF+EmclR+
 wm6MJRACjWbmNYWvDsbhZZGc4ehNG5kfxoi7muqg1DKEFAfAfrbHBGAIRjzkQd8Dmu1CnJ9oOYa
 EuxuVW8XWJ1OyoNqm9YuFlJoiUPFiEgpC9PFbC9qcpz5K+gxOGNhW
X-Received: by 2002:a05:600c:4454:b0:421:2cb3:143 with SMTP id
 5b1f17b1804b1-4212e044873mr69368145e9.3.1717401038387; 
 Mon, 03 Jun 2024 00:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHEEwzr1an7EhCvjUQgPbNuQBfOw9XIP8X+6/FPdODbG2d2zM9urXoJJ1HYPFyItz7BcOVRw==
X-Received: by 2002:a05:600c:4454:b0:421:2cb3:143 with SMTP id
 5b1f17b1804b1-4212e044873mr69367955e9.3.1717401037961; 
 Mon, 03 Jun 2024 00:50:37 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138260c5asm62270375e9.41.2024.06.03.00.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 00:50:37 -0700 (PDT)
Message-ID: <be43d0d8-f987-4892-8cda-de0f4ac202f6@redhat.com>
Date: Mon, 3 Jun 2024 09:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1717168113.git.mprivozn@redhat.com>
 <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
 <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/31/24 17:46, Philippe Mathieu-Daudé wrote:
> On 31/5/24 17:10, Michal Privoznik wrote:
>> The unspoken premise of qemu_madvise() is that errno is set on
>> error. And it is mostly the case except for posix_madvise() which
>> is documented to return either zero (on success) or a positive
>> error number. This means, we must set errno ourselves. And while
>> at it, make the function return a negative value on error, just
>> like other error paths do.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   util/osdep.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/osdep.c b/util/osdep.c
>> index e996c4744a..1345238a5c 100644
>> --- a/util/osdep.c
>> +++ b/util/osdep.c
>> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int advice)
>>   #if defined(CONFIG_MADVISE)
>>       return madvise(addr, len, advice);
>>   #elif defined(CONFIG_POSIX_MADVISE)
>> -    return posix_madvise(addr, len, advice);
>> +    /*
>> +     * On Darwin posix_madvise() has the same return semantics as
>> +     * plain madvise, i.e. errno is set and -1 is returned. Otherwise,
>> +     * a positive error number is returned.
>> +     */
> 
> Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
> which might be clearer.

That's how I had it written (locally) initially, but then thought: well,
what if there's another OS that behaves the same? This way, we don't
have to care and just do the right thing.

> 
> Although this approach seems reasonable, so:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

Michal


