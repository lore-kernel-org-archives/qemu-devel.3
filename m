Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7ME-0001LP-LY; Tue, 26 Mar 2024 10:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp7MC-0001Jk-Rj
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:00:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp7MB-00031L-0E
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:00:52 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512b3b04995so3034291e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711461649; x=1712066449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=518rxPStDSiC644PHfV+WPYhM8g47DKTiBbf7OfJSi0=;
 b=kWBcBdpf792gvdtXC/72MjFfTzItqOcs9LCs6U4mWLk6RS3zOQJ1Bj++2iNdiFfQFX
 36znMpFNcAy15WY8wepqaU3WCRId0B4uuP8QMS4q5B8WwHVlaRPkheQpchh/J63PrKzi
 qXvK4VF4K/QgC1Lwjw24RfshGBfNp153HpNeQaD4n1ytBd/Oez8p1E3N+uVuOeX48Pl4
 3WV4HDQvfWH8pKyfIAvk2joKk8QWmHf5MPCG9a0e4gQRki2gzrRzjcbhZnx9oA9/QMOq
 sH9wTGDHbnihNVYjluw1LPuofMbtKUnWTSAvlDgKh00KqDi8mtx86LTt9jXcw3c4Mozy
 udDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711461649; x=1712066449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=518rxPStDSiC644PHfV+WPYhM8g47DKTiBbf7OfJSi0=;
 b=NjhE1I3XXONIROSh+xAp1wN40WoFKaBdtNTXLG9P3llegDjSuuo5+atAYGNH87fm3R
 ovhiaUZ8cCMSFED50aIOFNAEAkpDdfx0FKxIn7Bb5nTEIc2hofH1nQZqk9Ot7EkWCinB
 dJI6EZRTYtkfk+rFWV/N8eZx3v7fx3nxrapMmVS/I9R+Cp91StV9Wts6CD6rh3prL+MG
 A/vHeciWvT/n/R1o327KWtbjTuePVI1lp3HQW7SWTOKYJIw32EHdJUBLgyV3mUfOtk1g
 OrE40C0za4xiqD6csHwEWqNjUP1wKpGG2YTjfk97tjeDiJ7zGEbRQGrJM5dgUCUiYQzL
 lKBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE4ddOUruz4qwaIJILoB3nTJDqMILsEuJcL645NmoQnM63yOqUqm0rSLRS0NPBnzJyBUtbuEbZ4LC4HbOJtYkB3TRRZCc=
X-Gm-Message-State: AOJu0YzxCCsapZKzy8OrS+d1ig2CXhhQYf9xPqrJa2QNzLX0gLNSHgUT
 vUR8jgEFziU5EP3G+2EbWn/IbvWg4/NlZWpG4O3f0PR0+QgkFGJkxSjnaqZYc8E=
X-Google-Smtp-Source: AGHT+IHTZfn9haAVcRCw/8INyWm7Ly7DU7TOZaflyvkjX11+WuWsm4pXECrJDW8M1nc7kDWpNyvcLQ==
X-Received: by 2002:a19:6914:0:b0:513:e249:65fc with SMTP id
 e20-20020a196914000000b00513e24965fcmr5932355lfc.61.1711461648472; 
 Tue, 26 Mar 2024 07:00:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c00cf00b00414041032casm908926wmm.1.2024.03.26.07.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 07:00:47 -0700 (PDT)
Message-ID: <c8a96403-a07f-40ae-8865-bec3fa1a7258@linaro.org>
Date: Tue, 26 Mar 2024 15:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Cc: pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, qemu-trivial@nongnu.org
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <306fd62e-50d4-4871-ae62-ea554a0fb388@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <306fd62e-50d4-4871-ae62-ea554a0fb388@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 26/3/24 14:37, Thomas Huth wrote:
> On 26/03/2024 14.29, Philippe Mathieu-Daudé wrote:
>> Hi Igor,
>>
>> On 26/3/24 14:08, Thomas Huth wrote:
>>>
>>> s/iaspc/isapc/ in the subject
>>>
>>> On 26/03/2024 13.51, Igor Mammedov wrote:
>>>> ISAPC machine was introduced 25 years ago and it's a lot of time since
>>>> such machine was around with real ISA only PC hardware practically 
>>>> defunct.
>>>> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on 
>>>> RHEL9 host
>>>> in only TCG mode, while in KVM mode it hung in the middle of boot)
>>
>> I'm quite opposed to this patch. QEMU models various very-old /
>> defunct hardware. I'm pretty sure Bernhard and myself are OK to
>> keep maintaining it, besides we are working in separating it from
>> the i440fx+piix machine. Also, this machine is particularly
>> interesting for my single-binary experiments.
>>
>> Where I agree is we should stop reporting "KVM on ISA/PC machine"
>> as supported.
> 
> +1

Rough plan is to extract 'isapc' machine from PCMachineClass,
having the latter becoming smth like PcPciMachineClass, on
top of:
https://lore.kernel.org/qemu-devel/20240305134221.30924-1-philmd@linaro.org/

> See also:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01367.html

lol I didn't remember I posted a similar patch =)


