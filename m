Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B8EC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvwr-0000QR-I5; Mon, 05 Feb 2024 05:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rWvwo-0000QB-S0
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rWvwn-0002El-3O
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707127887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NnBaEPki36rsBfa8J5maNHnYZa4IjWc2iBxHK+M8WoQ=;
 b=gdjPzEN8YOqxxP9ghs9TP6BMmOesiexGoSrIfE2oL+R0IgbcIzBKNy4yD/yFhQz6qICcRE
 RKm5fR9hx9Rft0k1Tk+mSC3u1n+oEAHT183HVy8yAhekIG8KUtNWOylTfgsmEWbnwD/sTT
 v3ZafeANh8WJkTD3g9v9og+2zUfJQcI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306--wCwBp7KPwiMLmb_pvP10Q-1; Mon, 05 Feb 2024 05:11:26 -0500
X-MC-Unique: -wCwBp7KPwiMLmb_pvP10Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7853c364e60so557738285a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707127885; x=1707732685;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnBaEPki36rsBfa8J5maNHnYZa4IjWc2iBxHK+M8WoQ=;
 b=H/8Z+2cL6cv69o/e+AnXB+xZdB4lx3lEcKEW1mjlbtcYg8NEn+/i7HTcQ1xD5XmH5t
 eIkZAjcEiU2bn28UtjyXPMKe0dXtbq39weiqVdN+uGfnJGvF+v3c/8TqhmoA9sy55Ird
 tw+2SGQPD9CwYfbqqESIVizhQU3kDw1row56vOFWliKViVPqShJH3p63m5atcKehq29G
 40xBb9Fry8+wL2EIwTnm/7K+zOFqWgOoiFmtF6u4L7lSfuvny7zVmz8XKKgYoZl4lbrA
 JIZc+6acakzXLiW5FzR63cqXhEHF5ZftnBXY/YQnBpPasInYaJkShJn7RIUhPtama2Yd
 Ee0A==
X-Gm-Message-State: AOJu0Ywl0qlHTiWKt1ZUFbpx2QBrotfsKQ3MkR7/KW3kMeecoyVtmIk6
 mpc37E0QvaL0KZOwxiV4edEpH3f1YxgUqL87NIJVgTIsAWsU2sX1v4eVWKageA/b2dk8So4bVJs
 CzrjwR5InbIcuPrwpVLztJCcn7XZSet/L0yvBPt2JGnz5PRZgcpKG
X-Received: by 2002:a05:620a:12f1:b0:783:63bc:3eb9 with SMTP id
 f17-20020a05620a12f100b0078363bc3eb9mr9631908qkl.20.1707127885553; 
 Mon, 05 Feb 2024 02:11:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoDpTcNSgZmpiwzUIG54LzAwiQKxq6wmZpOE0REdVQccf8SJZGmY8kPAPgnszmhv36c4JjSA==
X-Received: by 2002:a05:620a:12f1:b0:783:63bc:3eb9 with SMTP id
 f17-20020a05620a12f100b0078363bc3eb9mr9631894qkl.20.1707127885298; 
 Mon, 05 Feb 2024 02:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUJK8olpeoVE/pcRV/S9t/xwxzKB3kCT6PSs2QsYHPGR+Chc0Mvseh/c8PORhfWeO1q9vN6Y+zw/ScposO1A0Vk3+Ou8npqBrOk77dApGg6fh3gecgcHGc+k4Mc
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 ay14-20020a05620a178e00b00783df78821dsm2831110qkb.25.2024.02.05.02.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 02:11:24 -0800 (PST)
Message-ID: <5b188560-d0f4-43c1-8dfc-39ca8420b4c6@redhat.com>
Date: Mon, 5 Feb 2024 11:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/47] nic-config.for-upstream queue
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240201164412.785520-1-dwmw2@infradead.org>
 <CAFEAcA9-e=hzN62vkq-P575yMvjqmm1sNwNMswUDnqj1gCRmOA@mail.gmail.com>
 <4e86dd4daebb3c15d1585ff8d7316f61f122d827.camel@infradead.org>
 <CAFEAcA-Xbjpg8NUWnxq7Mkz5b+aUFUTsmZspBqWQ3N9Q76xhYQ@mail.gmail.com>
 <b69aabcd-bbfa-4ed1-9037-00933a756cda@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b69aabcd-bbfa-4ed1-9037-00933a756cda@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 05/02/2024 07.56, Thomas Huth wrote:
> On 02/02/2024 16.40, Peter Maydell wrote:
>> On Fri, 2 Feb 2024 at 15:36, David Woodhouse <dwmw2@infradead.org> wrote:
>>>
>>> On Fri, 2024-02-02 at 15:32 +0000, Peter Maydell wrote:
>>>>
>>>> This fails "make check' because some of the qom-test and
>>>> test-hmp checks fail when the QEMU binary segfaults.
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/6084552256
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/6084044180
>>>
>>> Thanks.  Any idea why that didn't show up in my own pipeline?
>>> https://gitlab.com/dwmw2/qemu/-/pipelines/1160949234
>>
>> I think because the failing runners are the aarch64 and
>> s390 host ones, which we don't let run for anything
>> except real merge-pullreq test runs because they're
>> limited resource. I guess that perhaps we have at some point
>> said "we don't need to run all the guest architectures
>> on all jobs"
> 
> It's rather "we cannot run all the guest architectures on all jobs due to 
> time constraints"

Ah, wait, but we should still run at least "make check" for each target 
architecture... so there's indeed something that went wrong recently:

commit 78ebc00b06813 ("gitlab: shuffle some targets and reduce avocado 
noise") removed the hppa-softmmu target from the ubuntu job, without making 
sure that it gets tested somewhere else.

Alex, why did you remove it? It's now missing from all check-system-* jobs...

  Thomas


