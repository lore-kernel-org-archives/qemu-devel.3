Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83229E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGG-0002Cs-Ix; Thu, 19 Dec 2024 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tOFaK-00077y-1X
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tOFaI-0002eG-7y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734611092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MLsExxvW2uxQy9Fkm0fQiOUG+nFA2eJZT63Xk4MA0/U=;
 b=YpS5vTv5p6S1jUuuJ4perVXX6/p9k4ooDE50e5oVb5h/j8S0dpu0lZN/oLlG5eEU3OBdk8
 dFWFMBxOpGYxp5JZTjW04rx9gLPkCfMrawm7NO5nE+q05FXkZxRXM/ZhxquNx2+0eL+1ZM
 DdeYZSOp05dnfnKH1+xHMT+t9iiNnrE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-c1jbjqK2PL-0DPkpq9k21g-1; Thu, 19 Dec 2024 07:24:50 -0500
X-MC-Unique: c1jbjqK2PL-0DPkpq9k21g-1
X-Mimecast-MFC-AGG-ID: c1jbjqK2PL-0DPkpq9k21g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e1339790so430530f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734611089; x=1735215889;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLsExxvW2uxQy9Fkm0fQiOUG+nFA2eJZT63Xk4MA0/U=;
 b=R9oma1nCyAMkjax6TR/YOFpTi0W+DyH64lXC/L/UNCxcjvYC8W/dPkstHgFfHu/Qb9
 lszB9gaiEz32CEt8jexoD9ZjG7KodcQiBBfCRxrWaHyZvNlIFD0so4Q3uEt0hCfz6vcQ
 h9xzANeLnndUgqOhGSSmwj+wiooq6GXTDCIL/yefhN7xM8qZMVbuGUqFK9dsaKrJIEqy
 7Q2+h9j1rktzUtPUI0olqHF+aeJTkfUel7iw3eWU//cmVyK0l2gyt39yhxuIFZUPXry0
 sZI44jwfpx/EGlMWJGRYyvVcCpuzy+CsqdfIDNrVHaeX4nBppsRJTUx/fFG5J1GsiKUe
 jNpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiVbrKy5opyrN6Wxic0hFnCV8P/nVEV96QV57VKhUrDNTc+TWUFtclnDussCIHxo3xuVDtkQk3NXY0@nongnu.org
X-Gm-Message-State: AOJu0YxWfQbQXHbUJJjR7d2WDDrW7uB4MCgClsb1rbNJmEjfuGzh0hQe
 P9Oe8iGYP626zcVvO3691YI6m8d1NBO1HhzPH4LObZeiaR7FHVA/V4rggWlK+OwRP8jPxQ1vrNw
 hTntU5s+Fraa759lcN1LeIda+bCi1IzkypCdZ3cI99RyPA3M86ZYgatZqNdd0
X-Gm-Gg: ASbGncttszE3iIPHpPr+6d0u5hWPQ3qagG7Eg8/EYt3Nl02EzUcwn+jO2oAKqOHjv2D
 c82ylb9gwCs0oVpJYBBwpob8ahrUo/XqoPGGcRwwE0WuEkLfYnUPXuIRlpLW3Snjm2q0D3vmYNj
 cBxulcTvlO8wEZmzpHtZjt9xHABk6EKByPsmvF2mWsTL+f0bOW/xH686xC7QmcxcFuf1mk0vOAg
 Qc5HSpAr6mpsIdrPmqGIH13Pl1WGx3fr1afS9nghlhUH1F7bzKFqQj/uYE7iHr0DT2cnKg2QNwV
 0JUy/nMDxYNl
X-Received: by 2002:a5d:588a:0:b0:385:ef8e:a652 with SMTP id
 ffacd0b85a97d-38a19b3ccd0mr2946099f8f.56.1734611089550; 
 Thu, 19 Dec 2024 04:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmU5KXnPM+uCwmg4aTTEwyfDMLWqneT0wght1DQrVwhxetApkLSutpM023WS4NN9feNIIqdQ==
X-Received: by 2002:a5d:588a:0:b0:385:ef8e:a652 with SMTP id
 ffacd0b85a97d-38a19b3ccd0mr2946066f8f.56.1734611089147; 
 Thu, 19 Dec 2024 04:24:49 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6dd3sm1442353f8f.96.2024.12.19.04.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 04:24:48 -0800 (PST)
Message-ID: <6b1e4f73-b53f-4929-8be4-4c07115af626@redhat.com>
Date: Thu, 19 Dec 2024 13:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <1d4faf8e-b2cd-42b8-a6a7-9034b9512b86@redhat.com>
 <8cef1bf9ffde6779ad322534c4469e6687b9c9d7.camel@infradead.org>
 <7e6fd4ed-ee93-48eb-ab12-fd9aa30e6898@redhat.com>
 <72B07F94-036B-4789-B5DF-103CA913278C@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <72B07F94-036B-4789-B5DF-103CA913278C@infradead.org>
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

On 19/12/2024 09.49, David Woodhouse wrote:
> On 19 December 2024 09:35:13 CET, Thomas Huth <thuth@redhat.com> wrote:
>> On 18/12/2024 23.14, David Woodhouse wrote:
>>> On Wed, 2024-12-18 at 16:54 +0100, Thomas Huth wrote:
>>>> On 18/12/2024 12.48, David Woodhouse wrote:
>>>>> On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat.com> wrote:
>>>>>> Use the serial console to execute the commands in the guest instead
>>>>>> of using ssh since we don't have ssh support in the functional
>>>>>> framework yet.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>
>>>>> Hm, but serial is lossy and experience shows that it leads to flaky tests if the guest (or host) misses bytes. While SSH would just go slower.
>>>>
>>>> I now noticed some issue with the serial console in this test, too.
>>>> Looks like the "Starting dropbear sshd: OK" is not print in an atomic way by
>>>> the guest, sometimes there are other kernel messages between the ":" and the
>>>> "OK". It works reliable when removing the "OK" from the string.
>>>
>>> Nah, that still isn't atomic; you just got lucky because the race
>>> window is smaller. It's not like serial ports are at a premium; can't
>>> you have a separate port for kernel vs. userspace messages?
>>
>> Maybe easiest solution: Simply add "quiet" to the kernel command line, then it does not write the kernel messages to the serial console anymore.
> 
> Want to resend the bug report about that test failing again? But without the kernel messages this time... :)

With "quiet", the output just looks like this when it hangs:

  Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!
  Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
  kvm_intel: VMX not supported by CPU 0
  Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!
  fail to initialize ptp_kvm

Anyway, to properly track this, I've now created a ticket with the full log:

  https://gitlab.com/qemu-project/qemu/-/issues/2731

  Thomas


