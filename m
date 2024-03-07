Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E3DC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riB2M-0004D0-QK; Thu, 07 Mar 2024 05:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riB2K-0004CT-8C
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riB2D-0001C7-CC
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709807491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2868AVUuvn8SFbeEncyOdEf5lYbSN2HOdnz7YuymbAs=;
 b=AnpZ/N6HjGnEi48qHhP2aVzmkA25KSA9APJaY+h/ps0AKAFXZri0WbWlYgToXT8doNW686
 WRTE3OUwX7Pe3MJyu9uKKEZPd99ORdNgG79sLs743kZzj9LWnQMCXAXHsjP8PXiyJ8etdV
 HLYfKPPKR1tmo8CrjMRHyPKIEed6+p4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-EFe3-4uJN2SzcNEc8MpatA-1; Thu, 07 Mar 2024 05:31:28 -0500
X-MC-Unique: EFe3-4uJN2SzcNEc8MpatA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d308b0c76so943456f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709807488; x=1710412288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2868AVUuvn8SFbeEncyOdEf5lYbSN2HOdnz7YuymbAs=;
 b=JGk8q0qjUkLBqBClt5jt9NgZu8TSuqJbmI8ecLVH6+hbOBfzsXr5fRdyMne2m93wDk
 z1ur6cOFmKJUrdE4uqkuFHzEjofptwphin1idkKcplU6G3STV81X8/rMgDAddilzeyas
 Kp8YrBEMtyvDNO38UVgKkUXPlfYgRWhVCP3ssnrU4G9Z2vFdyRK6kD+2OwaSBW1e0Kg7
 ML1UEKDf9fZ+8ZmmhG0toGR4xu7tpZx4QCO9XwwfQT6mtw8+MtkSMEcECYBI1cK/uErS
 HyPfqBxBPJK5KplKb0NzOsO/zpFBEKfaXtLyaDr3+lTtjWR6rCWdHe/KIReUO4ovpUZ9
 LldA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY8F4xnacKhL5Vj/T5ZymC6DMQTf8Nd7aFuDmZOaJmGx4uCzOUFdvznjPnckN9wZegOkkyuFiijrFaFA1WZhddHcqR5TU=
X-Gm-Message-State: AOJu0YyQWEqEZgYkzPeYxDLNtNK2/Fi839vygrm+RFZCROkOZTqczEq1
 JtYE3can8xtdXpyoW2BoO61Di0mF66Wy8Jr2SgAHu7QCHqT0zSposdDj4tigyHbaJ1/G2ZwqS9X
 nxBTXvsHdRStJEE6FGfbnoLdXaAfGrbBNPZNW6Dl/bR9rMDHGktnS
X-Received: by 2002:adf:e942:0:b0:33e:6ef3:b68e with SMTP id
 m2-20020adfe942000000b0033e6ef3b68emr235662wrn.34.1709807487761; 
 Thu, 07 Mar 2024 02:31:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHELf+7Av8HT0w3UQaxoHPzbwQXDssXy9PNB2j0qyG/h2Q7W0qEyy+Q7+HQTRLbOkm75heZ4Q==
X-Received: by 2002:adf:e942:0:b0:33e:6ef3:b68e with SMTP id
 m2-20020adfe942000000b0033e6ef3b68emr235638wrn.34.1709807487410; 
 Thu, 07 Mar 2024 02:31:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ba24-20020a0560001c1800b0033e65ed1afbsm1047618wrb.89.2024.03.07.02.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:31:26 -0800 (PST)
Message-ID: <38414ab8-7b29-478c-9fc6-09804cc17842@redhat.com>
Date: Thu, 7 Mar 2024 11:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/25] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US, fr
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-12-clg@redhat.com>
 <669aaa46-0ed8-46c8-9684-fc4ccc485d4d@yandex-team.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <669aaa46-0ed8-46c8-9684-fc4ccc485d4d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/7/24 10:53, Vladimir Sementsov-Ogievskiy wrote:
> On 06.03.24 16:34, Cédric Le Goater wrote:
>> The purpose is to record a potential error in the migration stream if
>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>> handlers can be modified to use the Error argument instead of managing
>> their own and calling locally error_report().
>>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Still, if you resend, please add error_prepend in the case below:
> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 63fdbb5ad7d4dbfaef1d2094350bf302cc677602..52d35b2a72c6238bfe5dcb4d81c1af8d2bf73013 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1342,11 +1342,9 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>>           }
>>           save_section_header(f, se, QEMU_VM_SECTION_START);
>> -        ret = se->ops->save_setup(f, se->opaque);
>> +        ret = se->ops->save_setup(f, se->opaque, errp);
>>           save_section_footer(f, se);
>>           if (ret < 0) {
>> -            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
>> -                       "%d(%s): %d", se->section_id, se->idstr, ret);
> 
> You drop a good bit of information, let's use error_prepend to save it.

I kind of agree but the call stack is quite deep and the callees also use
error_prepend. The error becomes quite long. Here's an example of what we
get today :

   (qemu) migrate -d tcp:10.8.3.15:1234
   (qemu)
   (qemu) qemu-system-x86_64: vfio: Could not start dirty page tracking - 0000:b1:00.2: Failed to start DMA logging: Invalid argument

If the subsystems implementing a .save_setup() handler use a component
identifier, the failure should be fairly easy to identify.

What's the best practice for such cases ?

Can we use multiline errors maybe ? Less practical for grep though.

May be a verbose error mode would help getting more information ?

Anyhow, I can add a new trace event for "failed to setup SaveStateEntry ... "
or use error_prepend() as you suggested.

Let's see what the others have to say.


> 
>>               qemu_file_set_error(f, ret);
>>               break;
> 
> Not about this patch:
> 
> Better do explicit "return ret" instead of this "break" (and one more break above in that loop):
>
> 1. making a jump to do just do "return ret" seems overkill. It would make sense if we had some more "cleanup" code than just a "return ret", and if so, more classic and readable thing is "goto fail;".
> 2. "break" make me think, that there may be more logic after it, which will probably fail, and I should be careful, as errp is already set (and second attempt to set it will crash). Again, "goto fail;" is better, as I don't expect more failures when see it.

Sure. If I respin, I can drop the break and simply return. Although,
I would be glad to have most of this series merged in QEMU 9.0. So,
unless there is something major, I will keep that for followups.


Thanks for the review,

C.







