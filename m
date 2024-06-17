Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EE9C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJBxL-00082F-0t; Mon, 17 Jun 2024 08:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJBxI-000811-GC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJBxG-0003Yg-VO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718629165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSz/TeUgSGRTf3LqOqpLd7wvDa/mmxOG3fnuIoPgX6w=;
 b=Q4gMgqJPEobbVjx2Ur1Bj85ukObSNF8hc02zlmpulS/ii5v+VyU7Yl7cf4+DHvvXcYxJfs
 1I3U3UukGyogJQrtasGuh7lUUyiSWppdLOWsjr2mv9jVjx2wF7V0bOV2iWhHagghT/JyNx
 UqNGHEAkH0SCbzGTEQLJxPtwD8b0upE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-BsHIECZxM1C6dM5dLZb9Ig-1; Mon, 17 Jun 2024 08:59:23 -0400
X-MC-Unique: BsHIECZxM1C6dM5dLZb9Ig-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42120e123beso38036235e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 05:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718629162; x=1719233962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSz/TeUgSGRTf3LqOqpLd7wvDa/mmxOG3fnuIoPgX6w=;
 b=Rf45iYUcCSgCRIp+oFX/25yTW5feK+wyN3ipiP8l2C5NTA7OeftIvUvlceVO0PHIm9
 xj+4XPDfhMykEUMyIYLJ7xl2PFbA65fd+V8MnLXIajTzAK+MnJeg0X8BA2L72gMkeD8+
 hsuGS/tpKXk6MdCD+VjFE8O8IpbvCg2/OLOQrJEa1lQyMxKf0EMBcJ7Os4eSwjKt9i5s
 sh8dSrTqDjxsorueEDL2oOYZOMNH85kHkhIzKA3YMsIaBwPW0gSwJImZEcZxOnUUM+aI
 cadaDNKMqsNuM5rN50e3zrAMkxMTwjV9Xw8lBnmbXjzI1UJzOdjxiGhHuQPYI2wBsWSu
 bKpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK+fV5i+fZKHPVFJqPU9Apdx5sCBeYCTgmVw/t1K72CM91M6AKKaMTP7HQSi6dq/q030UdeCgk9VfAFykwcC4jGDq3WxM=
X-Gm-Message-State: AOJu0YwF4GN7/PX+WRFoSMxsuDOG1B8OZuEm+6SrP66DVLHy9Sn0oZen
 0BvZAiNPGzvcDdZZ4d2wxj9+l38kegWlybzIls8oBQDaNWyN6hJsyOqqS6xXVrWNufErjUAfirK
 WZ/XqL7AmWWjrXFUJyqP+GGWNyybHYy7s1VU0En9ZWrlsTHXmj0Yt
X-Received: by 2002:a05:600c:a44:b0:421:7f07:92cf with SMTP id
 5b1f17b1804b1-4230484c563mr96644825e9.36.1718629162680; 
 Mon, 17 Jun 2024 05:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhtjGtNWWymL7LYJ2SALBi9/sXNXWeZu011WgwQGbTRUVr2sDicu9hvxLFJ3G9Jl72bB4EGg==
X-Received: by 2002:a05:600c:a44:b0:421:7f07:92cf with SMTP id
 5b1f17b1804b1-4230484c563mr96644635e9.36.1718629162289; 
 Mon, 17 Jun 2024 05:59:22 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33c2dsm159343555e9.10.2024.06.17.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 05:59:21 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:59:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 slp@redhat.com, 
 Igor Mammedov <imammedo@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 00/12] vhost-user: support any POSIX system
 (tested on macOS, FreeBSD, OpenBSD)
Message-ID: <ngknr5yzaqso2aaw3baxq5sa4syo36igyk63lcvymjbtu3eqos@aolclgpjy2cy>
References: <20240612130140.63004-1-sgarzare@redhat.com>
 <rx5hvcffqzmixgmlroko7t6qvjciifr77nvpwrakpl5oovw3ec@mihi4k5nhse6>
 <87iky7eq09.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87iky7eq09.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 02:02:30PM GMT, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> Hi Michael,
>>
>> On Wed, Jun 12, 2024 at 03:01:28PM GMT, Stefano Garzarella wrote:
>>>This series should be in a good shape, in which tree should we queue it?
>>>@Micheal would your tree be okay?
>>
>> Markus suggested a small change to patch 10, so do you want me to resend the whole series, or is it okay to resend just the last 3 patches (which are also the ones that depend on the other patch queued by Markus)?
>
>I guess you mean
>
>    [PATCH v2] qapi: clarify that the default is backend dependent
>    Message-ID: <20240611130231.83152-1-sgarzare@redhat.com>

Yep!

>
>> In the last case I would ask you to queue up the first 9 patches of this series if that is okay with you.
>
>Michael, feel free to merge the patch I queued.
>

I can also include it in v8 if it helps.

Thanks,
Stefano


