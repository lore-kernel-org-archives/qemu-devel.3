Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91628C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 10:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmWz2-00043L-8v; Tue, 19 Mar 2024 06:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmWyz-000437-Kv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmWyw-0003lk-Th
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710845168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcZNvsQ6BOd65671RAezXh5bYbxBnlvasH/ixda8zAQ=;
 b=fXYTpp2DQ4ulMY4Oi/UF17Y69h18SNOnN4dNOAxVxO5cjDRJtYRpfC6f/f5mMVZ9owtZE4
 mvYWLdOsMOGusTcF8at//xbN93vE0HaTedH6ZDIRTR+V/K5d3gZJIyKOXl5Ol5VaSwtwHK
 lKAbXOVJp6KhkGlfc1jRDL6QR4OwPGw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-BLCPeBGcNbOB4aZMGAbXGQ-1; Tue, 19 Mar 2024 06:46:07 -0400
X-MC-Unique: BLCPeBGcNbOB4aZMGAbXGQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513340d10ccso4681314e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 03:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710845166; x=1711449966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GcZNvsQ6BOd65671RAezXh5bYbxBnlvasH/ixda8zAQ=;
 b=QjSR9g81ATq8QGVJnZ1jvESfXKbhDZikb6YUWv6K89NQPeajxLxvVEiYlbL5Q4xrOK
 JCT+a5HA2uyutTxMb6VOCo/P52zAfzLIJagJigJkAWe+tQ0SVL2KUIE2YX/3iTRaPUbJ
 ProeEG7Ue4mssDC/QsIcIuaHBMgpy8OvrUDuhl+SsC6pOqoeYMEjHmOfb1zZ9jhB5YcO
 a3gu6VcLpSLhnhEDiI/pJvKTDHXYGbl2xN4dmKb8pZT0u0POy0kC9xFysmdfrN7RoGiY
 oA5yTyF20Jhrt/Wro/UdDO1hiWG4Tl2le9OlRLWKt8eSCFnF9RlNVhhm24e0p3CCklRY
 4LnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZbXAPiydgti/JuoIX4z3rpjN6t62TTnlMb+1tThwxNQl7b0NlqusMr7SeCK9krdQ5j1zMReUjoGOQPwLDzDJ1hBnp5Vs=
X-Gm-Message-State: AOJu0Yzuqd6bconvJulqMJ7SANvKuAhyvG0rt0aExFgBjnSIFuKGnOK5
 A1tIe/B5pNpWv0qiEjtBdPq9lZ3P1g2e9ioPLi87wsFVKVKSuHG3+e7cqXb9MrZ7AonS2AbjQf6
 lfwJZs4UmbS4leWJA//2vYOw/RPoSKdu0p1U8DrL7FZ5B9f+2BOXz
X-Received: by 2002:a19:e04a:0:b0:513:3d26:7cc6 with SMTP id
 g10-20020a19e04a000000b005133d267cc6mr8988385lfj.15.1710845166063; 
 Tue, 19 Mar 2024 03:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiKXasGFFEvpL7mHnt+ejHvaBeiDllciHDIiqSineSZPk6FYKE8pRXDmsDFAC2iEkpEiU1FQ==
X-Received: by 2002:a19:e04a:0:b0:513:3d26:7cc6 with SMTP id
 g10-20020a19e04a000000b005133d267cc6mr8988371lfj.15.1710845165710; 
 Tue, 19 Mar 2024 03:46:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05600c45c900b00412e3717ae6sm21376936wmo.36.2024.03.19.03.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 03:46:05 -0700 (PDT)
Message-ID: <84b2d729-fd25-4179-aabd-ee306a8767ad@redhat.com>
Date: Tue, 19 Mar 2024 11:46:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n> <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com> <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
 <afcb2934-7e4f-4c49-80a6-8e67026d3bc5@redhat.com> <ZfRgwKtRwMo-KQqe@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfRgwKtRwMo-KQqe@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/15/24 15:52, Peter Xu wrote:
> On Fri, Mar 15, 2024 at 03:21:27PM +0100, Cédric Le Goater wrote:
>> On 3/15/24 13:20, Cédric Le Goater wrote:
>>> On 3/15/24 12:01, Peter Xu wrote:
>>>> On Fri, Mar 15, 2024 at 11:17:45AM +0100, Cédric Le Goater wrote:
>>>>>> migrate_set_state is also unintuitive because it ignores invalid state
>>>>>> transitions and we've been using that property to deal with special
>>>>>> states such as POSTCOPY_PAUSED and FAILED:
>>>>>>
>>>>>> - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
>>>>>>      migrate_init() will try to set the state NONE->SETUP, which is not
>>>>>>      valid.
>>>>>>
>>>>>> - After save_setup fails, the migration goes into FAILED, but wait_unplug
>>>>>>      will try to transition SETUP->ACTIVE, which is also not valid.
>>>>>>
>>>>>
>>>>> I am not sure I understand what the plan is. Both solutions are problematic
>>>>> regarding the state transitions.
>>>>>
>>>>> Should we consider that waiting for failover devices to unplug is an internal
>>>>> step of the SETUP phase not transitioning to ACTIVE ?
>>>>
>>>> If to unblock this series, IIUC the simplest solution is to do what Fabiano
>>>> suggested, that we move qemu_savevm_wait_unplug() to be before the check of
>>>> setup() ret.
>>>
>>> The simplest is IMHO moving qemu_savevm_wait_unplug() before
>>> qemu_savevm_state_setup() and leave patch 10 is unchanged. See
>>> below the extra patch. It looks much cleaner than what we have
>>> today.
>>>
>>>> In that case, the state change in qemu_savevm_wait_unplug()
>>>> should be benign and we should see a super small window it became ACTIVE
>>>> but then it should be FAILED (and IIUC the patch itself will need to use
>>>> ACTIVE as "old_state", not SETUP anymore).
>>>
>>> OK. I will give it a try to compare.
>>
>> Here's the alternative solution. SETUP state failures are handled after
>> transitioning to ACTIVE state, which is unfortunate but probably harmless.
>> I guess it's OK.
> 
> This also looks good to me, thanks.
> 
> One trivial early comment is in this case we can introduce a helper to
> cover both setup() calls and UNPLUG waits and dedup the two paths.

There is one little difference: qemu_savevm_state_header() is called
earlier in the migration thread, before return-path, postcopy and colo
are advertised on the target. I don't think it can it be moved.

Thanks,

C.


