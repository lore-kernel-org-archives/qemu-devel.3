Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50450CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9rt-0004au-VA; Fri, 29 Mar 2024 06:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rq9rs-0004a0-2U
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rq9rp-0002sy-EI
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711709626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBS9n1MgA3SGDDtxREsSjADRnQKe4wIE5sFaCbLfsLI=;
 b=YFlu9dwJCQXKcWt2yMpY6i9EEm3W8HDRsramly2VH7Y0H4kLi8p/KyAZeWvouuKXGKx+c9
 j1T/Wh5Y4gv7fu2+UVB1vAOASr6Sx/wgozym9EdUJNO0i6UbCDRVFt6JuDDpgsHkUJsEc5
 YDybSFKZCEg9o7ZLxGNJG52e0LmWuE4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-2uARZlx-NOWmBrlI0AhJoQ-1; Fri, 29 Mar 2024 06:53:45 -0400
X-MC-Unique: 2uARZlx-NOWmBrlI0AhJoQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56beb0ad4c0so913100a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711709624; x=1712314424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBS9n1MgA3SGDDtxREsSjADRnQKe4wIE5sFaCbLfsLI=;
 b=SqX76mURQRzWBLh8hBgJK/5MTzkw+zcpAtfu9kmG9uXxliVQnQMyyhEFnOWzdaIPQG
 fyzOEzzZeePrRSGxphbRcuvyV9HPy5bbGPd8zkIyVPKlfd7AauzDlna3u0k+1S3/4qCo
 YSAjdMty/v0bUDpumxwwaxS4r2w3rM3wuOpfwHCP4Jo1S0NS/wsDonoFQCYn7Twj9Wx4
 t/0qss17pbq4kouusINANEoy9InhoFH8vuBCwynBWPLWZ2OvJ5dAhh3yKalItoQbmsCE
 MyBQfqUhtlgaD7QVpyxjcxYjuLB+RVxzCKw1HDhe/cm7F2cv9Fw39JcgFYanKTQUIL57
 YXHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0BGC6pybJ3dHOYQW91UPP/gAGgewn8gcocQQ8pdTw99jT+8LwPajtT36Zbw2BBVOTwVBTDup33pBUiGD6sm2/zMS2HCs=
X-Gm-Message-State: AOJu0Yz20lYWSiDfPTI/NsGjD18lEJ3Y5gnVrMQrKPnKNepEiCzjQl5H
 afhh09cFF9w+osC/3PFNSM7WGPWrobOzw20wIV89YhCxJ2C4Ww4JaexSours6l1TVuyRXGGxJaL
 t7sWXBAUfMCTMLuH9RzH7iVBTXryK1nwrn3yeWS70Xat/DPWKTpw2
X-Received: by 2002:a05:6402:2806:b0:566:4a85:ceba with SMTP id
 h6-20020a056402280600b005664a85cebamr1355150ede.1.1711709624048; 
 Fri, 29 Mar 2024 03:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOpbj8Dz9qfG0J//5mbnbzGz7EWF7OMexwZxeghRlP2pM+7RRpkJDj3e4OfnNt66rir3kW8w==
X-Received: by 2002:a05:6402:2806:b0:566:4a85:ceba with SMTP id
 h6-20020a056402280600b005664a85cebamr1355117ede.1.1711709623582; 
 Fri, 29 Mar 2024 03:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a056402248e00b0056c5515c183sm1570594eda.13.2024.03.29.03.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 03:53:42 -0700 (PDT)
Message-ID: <47139c9f-b447-4378-8a8d-a0f21e24b964@redhat.com>
Date: Fri, 29 Mar 2024 11:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 07/14] migration: Add Error** argument to
 .save_setup() handler
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit
 <pjp@fedoraproject.org>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-block@nongnu.org
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-8-clg@redhat.com>
 <9bae5618-2ebc-453a-8b10-32474422c66f@yandex-team.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9bae5618-2ebc-453a-8b10-32474422c66f@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Vladimir,

On 3/29/24 10:32, Vladimir Sementsov-Ogievskiy wrote:
> On 20.03.24 09:49, Cédric Le Goater wrote:
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 2708abf3d762de774ed294d3fdb8e56690d2974c..542a8c297b329abc30d1b3a205d29340fa59a961 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -1213,12 +1213,14 @@ fail:
>>       return ret;
>>   }
>> -static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       DBMSaveState *s = &((DBMState *)opaque)->save;
>>       SaveBitmapState *dbms = NULL;
>>       if (init_dirty_bitmap_migration(s) < 0) {
>> +        error_setg(errp,
>> +                   "Failed to initialize dirty tracking bitmap for blocks");
> 
> No, that's not about initializing a bitmap. This all is about migration of block-dirty-bitmaps themselves.
> 
> So correct would be say "Failed to initialize migration of block dirty bitmaps".
> 
> with this, for block dirty bitmap migration:
> Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I had kept your previous R-b.

Should we remove it ? or is it ok if I address your comments below in a
followup patch, in which case the error message above would be removed.

> Still, a lot better is add errp to init_dirty_bitmap_migration() and to add_bitmaps_to_list() too: look,
> 
> init_dirty_bitmap_migration() fails only if add_bitmaps_to_list() fails
> 
> in turn,
> 
> add_bitmaps_to_list() have several clear failure points, where it always does error_report (or error_report_err), which would be better to pass-through to the user.

Good idea. Will do.

Thanks,

C.



