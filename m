Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C24CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOC0I-0002sv-Oi; Thu, 19 Dec 2024 03:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tOC09-0002Ro-3l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tOC07-0005bV-Fn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p1WB+QCi8QxvAnIXxLlq4yzNvrA/qS+1fasfpQsEHcc=;
 b=WEENaWGNbGfW/Qs9rHKdc4sSWdNZ3IVI+0klCHHbo3HqqEc/qDyD9MQv2h/aBxD1JzlHEO
 OrdoG4C8gAlEk5/PZa+CTmrFfCPxXEdWQHdjuPqtHBXPPklzaCRc4JGHwMFFcY+KlHQ4bA
 ssVK5PFEke73gcMMXV3c3UFX+MSRDrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-a91hB2DcMtanN13mmarEfw-1; Thu, 19 Dec 2024 03:35:17 -0500
X-MC-Unique: a91hB2DcMtanN13mmarEfw-1
X-Mimecast-MFC-AGG-ID: a91hB2DcMtanN13mmarEfw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436219070b4so2737985e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597316; x=1735202116;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1WB+QCi8QxvAnIXxLlq4yzNvrA/qS+1fasfpQsEHcc=;
 b=Osera6KnAqxLFOPRVPUZJ4NuqOIT3YxAMWJBgYidnNQABtiS4uNAX4wvATWURt+S5R
 BE79f53HoaMxIKr98vJep2aPJ5kW0ssx0skJ/TS2qKcitXpgvt454blVzkBTSOZJlmVT
 fMfaYN9rYldkZlA4hsNTIJTeT/DCGD2ocskV7O6ZjynBar4Q+TqDrOtpVwK7Nbh1Sl0F
 MuxHr5iaizQLXYvdqTjBIW63YqzjhXgMlRS8tqMLMHR6nN3CB4FoEdcL4NnnaB3V65zm
 9xnKyFesiAcrUzKkRcWSEE3HoPxjPTr/PaKQtxaSP+q7eFwD+fcjqMt6htfeKhVFNWTy
 Ty3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuIc8fsUPngQqbEfeI4LBBNIln8xI7stb7MWNjRzT3amtPt6Ree8cj9sjS6csmJPsZwIxyNsAsKaZy@nongnu.org
X-Gm-Message-State: AOJu0Ywu2Po4XbrCRxtok6Tg6tGVdlCQr/B63CU/EYr5/PcppRB1SzuH
 fxLX9VhcoSPeBC6BRG0zcESGH7Ij+9zTVahyaDtx/9ZwHIi0dG6vd2QL80P5IFpcpJuL6pMeuDW
 LssH9yt1kRuV1bdAeS5+yYg3mfiGFACFF+zMeNGtfqCepLt1WMhw2E2kMp8W/
X-Gm-Gg: ASbGncsHtJqJNxhxHYd1epf/w3a/X5bDTEAd1JGT3xdGJlhQDpPtxMHgxXaFVzilvRB
 9XdJFKuY9oh19O6W/76pxU9hZV9dfC1mkU34bFTJrkPdjWYp0PMxAvPT7NRW5lFEjdMKxoiU6hW
 v8fyLtxz2pnj0t9+BuayolJeR19t+s9JXwnkmxeoppri20Jc9OorU6elvtohurgerAIi0/uXq9p
 JSXuX8TerlFh80MbQEnVZ0dhV/WmxavG/hI0qsDkeiOAUhHhxWNoHuTYobXJCQiNmo3a2mSxNl0
 wdpJGAlQMBhA
X-Received: by 2002:a05:600c:198d:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-43655360633mr55622925e9.12.1734597316304; 
 Thu, 19 Dec 2024 00:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkd5VAIhmxLX4Qs1QWoZVsvBrvVNs052BQgRpeSkivXk+KFru5irjKMjuJZMosWnO814yCvg==
X-Received: by 2002:a05:600c:198d:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-43655360633mr55622715e9.12.1734597315970; 
 Thu, 19 Dec 2024 00:35:15 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4b0sm11144115e9.35.2024.12.19.00.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 00:35:14 -0800 (PST)
Message-ID: <7e6fd4ed-ee93-48eb-ab12-fd9aa30e6898@redhat.com>
Date: Thu, 19 Dec 2024 09:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <1d4faf8e-b2cd-42b8-a6a7-9034b9512b86@redhat.com>
 <8cef1bf9ffde6779ad322534c4469e6687b9c9d7.camel@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8cef1bf9ffde6779ad322534c4469e6687b9c9d7.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 18/12/2024 23.14, David Woodhouse wrote:
> On Wed, 2024-12-18 at 16:54 +0100, Thomas Huth wrote:
>> On 18/12/2024 12.48, David Woodhouse wrote:
>>> On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat.com> wrote:
>>>> Use the serial console to execute the commands in the guest instead
>>>> of using ssh since we don't have ssh support in the functional
>>>> framework yet.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Hm, but serial is lossy and experience shows that it leads to flaky tests if the guest (or host) misses bytes. While SSH would just go slower.
>>
>> I now noticed some issue with the serial console in this test, too.
>> Looks like the "Starting dropbear sshd: OK" is not print in an atomic way by
>> the guest, sometimes there are other kernel messages between the ":" and the
>> "OK". It works reliable when removing the "OK" from the string.
> 
> Nah, that still isn't atomic; you just got lucky because the race
> window is smaller. It's not like serial ports are at a premium; can't
> you have a separate port for kernel vs. userspace messages?

Maybe easiest solution: Simply add "quiet" to the kernel command line, then 
it does not write the kernel messages to the serial console anymore.

  Thomas


