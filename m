Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FF6C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfeB5-0006rp-GL; Thu, 29 Feb 2024 06:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfeB3-0006qj-Pv
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfeB1-0008M2-26
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709204530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Zu5tBFOH5ImhLkt+ew3sONbMeOauI95Rk2Cdxdwk8g=;
 b=N8YLBNedrIgi5Tl2292XqeOYCZArr4goS5ObXwY9sDNLQ+JbpLyXfabYHl+p0eFeRUg18A
 S5ZrSGZskTsN8WH7oo9tMGdsFcz+ANe3Ay6zd2rmu80ckDw+CNJQhxEZtd+SFl7b172Gpr
 67sQk+nkIE0Y5Jvixt1nEYFgac9nKsk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-dXQBmth_OPCbse61wCXfww-1; Thu, 29 Feb 2024 06:02:08 -0500
X-MC-Unique: dXQBmth_OPCbse61wCXfww-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-787c04e48a7so82016985a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709204528; x=1709809328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Zu5tBFOH5ImhLkt+ew3sONbMeOauI95Rk2Cdxdwk8g=;
 b=DuC4ggAxgmjvSiSxl3nbdR+hpRj4DxVaFYlUhzT7+tjNkJDizMZqmLvoLq69TSqqWO
 fQvpSANFq341LGuNwJ0wYg0pY32CIn8rOYiOPjRFmnNVQV3nAQ520wjhPg9oTzeJwttL
 vss3om7FvdAEMCi6h7RV2W1isIkGMeC8ev3Akb3gGRW47+nZ+krbJzTqqstDniQ3gYyd
 xAunGDE26Wo0gTBENhAi9V5VlW7hrOofss6YvJMt7TOCkuNW3+NRIgNeI8nqlgtbEwen
 VYEd+kYqmYQB5Pn5cyGL4oyP7tEMROXhfwzggy3mhtHXnnA3MZv0iC9IY9y0sFJayL+i
 llNg==
X-Gm-Message-State: AOJu0YwNhwbVAm3Gpc5pW/j6/0M8zdTtpcBpjsRjndERbhfVUMsiJrNE
 XCo78kzEkkCQB3xq6GJnBxSW6qY0OIWMfyryLbsTX9n6gqOBHg2nJnmriiGyx5hNFr5FO+3M3xR
 DqwjWFuyTi7QOA1flm0Of54ibqB3y7S3lT3RyHNUQNP4SZl2CifXH
X-Received: by 2002:a0c:f542:0:b0:68f:da03:3fe9 with SMTP id
 p2-20020a0cf542000000b0068fda033fe9mr1575142qvm.6.1709204528104; 
 Thu, 29 Feb 2024 03:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoT/LhIuYx5K+oPou+YAYe3uxU0qUMgeG3SWPYs/r/NoH/ZtdUGWYPedAODqAjOTstbReSwQ==
X-Received: by 2002:a0c:f542:0:b0:68f:da03:3fe9 with SMTP id
 p2-20020a0cf542000000b0068fda033fe9mr1575112qvm.6.1709204527796; 
 Thu, 29 Feb 2024 03:02:07 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 pd7-20020a056214490700b0068fe3170b0esm613341qvb.11.2024.02.29.03.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 03:02:07 -0800 (PST)
Date: Thu, 29 Feb 2024 12:01:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>, 
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com, gmaglione@redhat.com
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Message-ID: <ochbl3qszx3yqmicm7dxqsp2ayfwajvh3onrzvm3xco4r5cnmi@7iayhlxzys3y>
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
 <874jdswyzy.fsf@pond.sub.org>
 <hxd362pwyrtanyw6xtjxiegru7z57btnaynaqxm5lysgzsm4u4@af36bjkqvc7z>
 <878r33zhre.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <878r33zhre.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 29, 2024 at 11:28:37AM +0100, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> On Wed, Feb 28, 2024 at 01:32:17PM +0100, Markus Armbruster wrote:
>>>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>[...]
>
>>>> +# @shm: if true, shm_open(3) is used to create/open POSIX shared memory
>>>> +#       object; if false, an open(2) is used. (default: false) (since 9.0)
>>>> +#
>>>
>>>Please format like this for consistency:
>>
>> Sure.
>>
>>>
>>># @shm: if true, shm_open(3) is used to create/open POSIX shared memory
>>>#     object; if false, an open(2) is used (default: false) (since 9.0)
>>
>> I just noticed that I followed the property just above (@rom). Should we fix that one?
>
>Yes, please.

Done: 
https://patchew.org/QEMU/20240229105826.16354-1-sgarzare@redhat.com/

Thanks,
Stefano

>
>See commit a937b6aa739 (qapi: Reformat doc comments to conform to
>current conventions).
>


