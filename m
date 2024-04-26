Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175DEC19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0KzD-00039e-3L; Fri, 26 Apr 2024 08:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0KzB-000343-2I
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0Kz9-0002tL-Dq
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714135646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ipQHGe6O82HejOJ3xQpPxVbNeMyUku/VOWS3k+68MHw=;
 b=UW2iyIbAlzTYxGc3IPGolWGMQrJrfR0DOQAjnWxU9bueVU088WVlzQCIrKonEDbw7tlc2s
 1LqnHXhsqz/QAfOs32+C0UEaY1eIVA61rdFMp9NOTbFfepbcbIU0bTd3Hvl9aANjhz/0tR
 qi30P7Nxtw3KM032A4LbSjgqzV9AsG8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-0XMl5UXwM5a0UpqOjB0PVA-1; Fri, 26 Apr 2024 08:47:24 -0400
X-MC-Unique: 0XMl5UXwM5a0UpqOjB0PVA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43a1389bc01so40781311cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714135644; x=1714740444;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipQHGe6O82HejOJ3xQpPxVbNeMyUku/VOWS3k+68MHw=;
 b=Tn1sbbdjy1tsGrdGvlOkeqoTbqKHwFBoRxz/JXJX7T5t8VUPolImmG37qOSsW3uYoj
 rDQ3wfz/RqZlN95oo4vTfSrs40zo/kJPohaNSP62tNY8b3N6JTM1IVRqXlGaEbGY+l/m
 ytB3i0GYTn9h04QmqUsquLY1MTXJqZKmr/uyF4rXJBW2cdi1x6d/Gg9j0mmoL+aS7H5N
 szZKoAddt1sKHHj2vidz7raGR+WkyFTDnFGbHgpDZfrDAnAQ7QtyCaxqd+Dgt8pMLi5g
 pDRySr7z8VRdEhdyiIxxvAah0bYUiTYXRCPNssYvhXxrOPUI218O+UNJQ+DRulmYXDUn
 gMQg==
X-Gm-Message-State: AOJu0Yx4P7J7C+1AVZL5sg3GRTaNlh1FfkfnP890VedjNSwpLgWVjLAk
 pQUUST1pG8lk4WYJmq9mXBWkXtucbeSjRbFVaI1qASRvt4omhHMKOJQntEsOW8M3zr7iyP/wKKH
 vjvSMfIvoyuUAybuGqPskR0ky1huZeTy6Q0gUhVvdvUlcdAAdVN5q
X-Received: by 2002:a05:622a:1814:b0:43a:4c10:fa62 with SMTP id
 t20-20020a05622a181400b0043a4c10fa62mr3945715qtc.13.1714135643897; 
 Fri, 26 Apr 2024 05:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPR0NuLMfxMldQmjs9Xx/tr2vN9eAbUyJiF5PPbfS2TJRYXewW4JXbB7P0j3vlPeCdeMfxyQ==
X-Received: by 2002:a05:622a:1814:b0:43a:4c10:fa62 with SMTP id
 t20-20020a05622a181400b0043a4c10fa62mr3945692qtc.13.1714135643591; 
 Fri, 26 Apr 2024 05:47:23 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-20.web.vodafone.de.
 [109.43.179.20]) by smtp.gmail.com with ESMTPSA id
 ki16-20020a05622a771000b00439c3072d24sm4214881qtb.15.2024.04.26.05.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 05:47:23 -0700 (PDT)
Message-ID: <5b79efda-2774-4e76-8bb2-a1d70e8bce2f@redhat.com>
Date: Fri, 26 Apr 2024 14:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eldon Stegall <egqac@eldondev.com>
References: <20240426113742.654748-1-thuth@redhat.com>
 <CAFEAcA_gEyBXecGXP3x=uLJQTaE9=5Ubf0bGeSALskTfFoNQ6g@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_gEyBXecGXP3x=uLJQTaE9=5Ubf0bGeSALskTfFoNQ6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/04/2024 14.30, Peter Maydell wrote:
> On Fri, 26 Apr 2024 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
>>
>> During the past months, the netbsd and openbsd jobs in the Cirrus-CI
>> were broken most of the time - the setup to run a BSD in KVM on Cirrus-CI
>> from gitlab via the cirrus-run script was very fragile, and since the
>> jobs were not run by default, it used to bitrot very fast.
>>
>> Now Cirrus-CI also introduce a limit on the amount of free CI minutes
>> that you get there, so it is not appealing at all anymore to run
>> these BSDs in this setup - it's better to run the checks locally via
>> "make vm-build-openbsd" and "make vm-build-netbsd" instead. Thus let's
>> remove these CI jobs now.
> 
> So what's the plan to keep BSD CI coverage? This seems
> like a step backwards towards "the person handling the
> pullreq merges has to do some local private ad-hoc testing
> too" :-(

With regards to NetBSD and OpenBSD, this is not a step backward since these 
gitlab jobs were never run anyway (they could only be triggered manually, 
but hardly anybody did that AFAIK).

If we want to have proper support for those OSes, I think somebody would 
need to set up a custom runner on a beefy KVM-capable server somewhere where 
we could run the "make vm-build-*bsd" commands. By the way, are Eldon's CI 
runners still around? IIRC they were capable of running KVM ?

  Thomas



