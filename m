Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E086C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI15a-0003lf-TH; Thu, 22 May 2025 04:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI15Y-0003lJ-EP
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI15U-0003nb-KJ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747901734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hfR3zd/P9CydyQLnwxYwzqbq6WBawPinzLFgasUukj0=;
 b=b3WMyl8PXfhrmsODIB7WJHn9Y/TpH7BSQ2wLuMlUjkgd3N6wvXFLlam3IrKW/JM+bPnwQJ
 R5pT0OkMPENJkNP2Y92cSFkc+9b/mzIyliZwet3u9RJT3SOcEl6wU0z1JWw3X9d7Bj4gLa
 dPITjwY5M7Sza85doTMZxol4zQFzljk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-r8RbOMVuP3mj_YKPT3-0pw-1; Thu, 22 May 2025 04:15:32 -0400
X-MC-Unique: r8RbOMVuP3mj_YKPT3-0pw-1
X-Mimecast-MFC-AGG-ID: r8RbOMVuP3mj_YKPT3-0pw_1747901731
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a36416aef2so2460279f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747901731; x=1748506531;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hfR3zd/P9CydyQLnwxYwzqbq6WBawPinzLFgasUukj0=;
 b=ToDebu9zA/fnQfHmQHoPDWb8TYtD+vxI8n/0UPRpur9UsXj1z4CjzHV1iIKa7cePqj
 DrSJtuLk4UBTkpe7aavyEYjYsrZkeAX4vQvJmzz0LEkHW0zc6kjfQvKmAzFdURK4sA2Y
 sXUuqMkypqPDTwbxIyw6v6/kFdacE423Lpn8bBTKC7rWUdyN/31pJ1INZ/gex5a35c3z
 sTMDV6Yg9nxPge21zVmE+Sukrq9LnGa41OS0L0e0AXuw5C6SSPuQVhKEfHM/bT7UfBCn
 G3oGGVzllJA+AWo+RBgJWm+R3UU9M/qNQVyEMGm5EyemDK+OTY6BUN6JLjEX4kZBnmfQ
 Jf3Q==
X-Gm-Message-State: AOJu0YwZcILlwRJB5Wt1ohu01/SDgk+HFwLOkK/N6DEknMf4FNFUlnl9
 wU2hoAmXeLSfsB1L7dzCJHR8bYTtJ756aCnoxq5lLSGpLnBSjsNN/0GFRR5Gq/hjvDp6GYuxK1U
 ee2RraukEqE0e3e2aF9Eu4uMN8uCjblD1vPOK2NaDSHFnqek+oK+fdnQa
X-Gm-Gg: ASbGncuiXmNETAIQHY7RXBv5UwhslvkcwreH6IEb3hfszxDJsDmUY584ABf3HmgBvLN
 NmE4hv4BMa2dIYb1ukgnorWNUFjU+7qUOBZ30Od0GAIOTOa5GvEwko5IhC7jyigXC1koGOqKLV9
 +3PNtVWoWvkBW//fp3oaCzwZfKdZ9pIP7+Se+b8Z7EYpx3/xsLd3obwDmENNpBydCUwoihu4+nq
 1ymMTqyaKGZ8j9E6ylJa2Ds9VXcKs7NZqC1SOTOBIDA0IUjhIqXKJB7Hwt5psAx9jW8R3AmmTQD
 lbgg/m8ay4mnyX9z/mx0008wjk1MXEWDKmb8kHMNUHM=
X-Received: by 2002:a05:6000:2902:b0:3a3:6c37:eb3a with SMTP id
 ffacd0b85a97d-3a36c37ed75mr13925227f8f.26.1747901731137; 
 Thu, 22 May 2025 01:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhWvnsaa/56b7QVhIpLjSB6G5zHsxIYZZSCgQynLBiA7Gm6khuonGCEyyeSZ07zhyFPn7MGg==
X-Received: by 2002:a05:6000:2902:b0:3a3:6c37:eb3a with SMTP id
 ffacd0b85a97d-3a36c37ed75mr13925199f8f.26.1747901730756; 
 Thu, 22 May 2025 01:15:30 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef01besm94769495e9.10.2025.05.22.01.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 01:15:30 -0700 (PDT)
Message-ID: <ca409e44-ea4e-4208-b558-06b42c757567@redhat.com>
Date: Thu, 22 May 2025 10:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Set 'pc' machine type instead of
 relying on the default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521151323.155232-1-thuth@redhat.com>
 <aC3woEjL0UxXYavt@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aC3woEjL0UxXYavt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 21/05/2025 17.26, Daniel P. Berrangé wrote:
> On Wed, May 21, 2025 at 05:13:23PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> In case the default machine has not been compiled into the QEMU
>> binary, the vnc and the cpu_hotplug_props test are currently
>> failing. Add a set_machine('pc') here to make sure that the tests
>> are correctly skipped in case the machine is not available.
> 
> Hmmm, this is making this test be tied exclusively to x86.
> If we can't ever omit the machine, then effectively all
> our tests have to be tied to a specific target arch ?

Since you never can rely on the availability of a default machine (there are 
also some targets like arm that don't have a default machine), you either 
have to set a certain machine explicitly with set_machine(), or use the 
"none" machine (if possible). Speaking of the latter - that's maybe a better 
option for this test, so I'll give that a try.

> What scenario did you find that 'pc' wasn't compiled
> into QEMU  x86 targets ?

Run "configure" with "--without-default-devices".

> Shouldn't a new default
> machine have been picked, or should our test harness
> be picking a default for each targets if no 'set_machine'
> call is present, to preserve target portability ?

We're using something like that in select_machine() in 
tests/functional/test_migration.py already ... we could maybe give it a try 
to turn that into a generic function of the qemu_test module, but I guess 
it's hard to find a default for each and every target that satisfies all the 
needs...

  Thomas


