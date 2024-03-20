Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF65C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyb4-0005bn-Fr; Wed, 20 Mar 2024 12:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmyb0-0005L5-VL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmyaz-0003Sa-Er
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710951314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4IhxAuWNgzsFqb6tIlcQFajJYSC/Su8joooqt+6RRU=;
 b=MhVWwfkRVTsHTL55ggC8jH3QlzeEdGBvtfP1jzvqOyuLa9kagWwNdfOo/dZiXD7+iaF8bs
 dkssLwOAQ2ubvPZ7l1VEAn1/dVrzEwPViGuD/J0hwaXltk1W3Ebcj5Wpn7ypm3fsFJ+EIP
 BJwXXog9MenSx7zuohcUf0P3i3dmzJo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-FAAjPmExMyiYA6NeZPaZNQ-1; Wed, 20 Mar 2024 12:15:12 -0400
X-MC-Unique: FAAjPmExMyiYA6NeZPaZNQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6e46420dca9so4487190a34.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951312; x=1711556112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4IhxAuWNgzsFqb6tIlcQFajJYSC/Su8joooqt+6RRU=;
 b=rOmXY8kNwQPNzfZA4omYhz2gug5hJxbMI8jFGKKzEwlk493IqxQdU2zw2noZ4suOcI
 Lt0xenpuRolrvqEtFuAOW83uobA2sRPR1JA0Q+DLne7V8ob1mJZUPP+0BFVZQvt2yFmB
 zt7AljFGp32C4ndudRB1L1DAv8fYNPzSHEvJZuIpNFnzyrr0jl+C0Y8uLU5gmrmBPMRU
 AbZ7jXGHp4xjJGMyanm12CrDQrOlXeU/XWofAliX6l4J1JAPQP3u1LQTTNfPC0tyVj/n
 IGTe1mCgs7YG/Kg3mx8tT1cSaibWl1ppD4AVEgN0UB8S+sDD+JreRShPDd4k9N9hXy5e
 oVjA==
X-Gm-Message-State: AOJu0YxbbP85/2k/uXPiHJPf2OhfCA3+wD+90bB33W7ZSh64NiMJBuSV
 a1ac3p2x1V9KRS8YHqoakMdq/Xy2wRTU1VVOUIVVN7MiKkTqdkyl+ATYsImAGR9NHvV9ghyP38a
 x8egUoKQahkeWlCPlks+/RIsGs9Ybg2RIbovQaCAt7iPeWMHGphtr
X-Received: by 2002:a05:6830:1d70:b0:6e6:8516:4866 with SMTP id
 l16-20020a0568301d7000b006e685164866mr12600270oti.16.1710951312134; 
 Wed, 20 Mar 2024 09:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5SXrLrO24aMjWMzHB6MM12ePW1/UUxpm7nPE1oUi+NjEX/CxeqywPujgO7EBLwXPakP49HA==
X-Received: by 2002:a05:6830:1d70:b0:6e6:8516:4866 with SMTP id
 l16-20020a0568301d7000b006e685164866mr12600232oti.16.1710951311827; 
 Wed, 20 Mar 2024 09:15:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x14-20020ae9e90e000000b00789ea3555acsm4666094qkf.19.2024.03.20.09.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 09:15:11 -0700 (PDT)
Message-ID: <d58d5134-dbfb-4c07-956a-5e8f3e230798@redhat.com>
Date: Wed, 20 Mar 2024 17:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 09/14] memory: Add Error** argument to
 .log_global_start() handler
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit
 <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-10-clg@redhat.com> <Zfr10JG2dTChsLVj@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Zfr10JG2dTChsLVj@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/20/24 15:42, Peter Xu wrote:
> On Wed, Mar 20, 2024 at 07:49:05AM +0100, Cédric Le Goater wrote:
>> Modify all .log_global_start() handlers to take an Error** parameter
>> and return a bool. Adapt memory_global_dirty_log_start() to interrupt
>> on the first error the loop on handlers. In such case, a rollback is
>> performed to stop dirty logging on all listeners where it was
>> previously enabled.
>>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Still one comment below:
> 
>> @@ -3014,8 +3044,11 @@ static void listener_add_address_space(MemoryListener *listener,
>>           listener->begin(listener);
>>       }
>>       if (global_dirty_tracking) {
>> +        /*
>> +         * Migration has already started. Assert on any error.
> 
> If you won't mind, I can change this to:
> 
>    /*
>     * Currently only VFIO can fail log_global_start(), and it's not allowed
>     * to hotplug a VFIO device during migration, so this should never fail
>     * when invoked.  If it can start to fail in the future, we need to be
>     * able to fail the whole listener_add_address_space() and its callers.
>     */

Sure, or I will in a v6. Markus had a comment on 8/14.

Thanks,

C.


