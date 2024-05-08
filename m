Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7EEC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dgh-0005pq-O4; Wed, 08 May 2024 05:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4dgf-0005pR-J2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4dgb-0006bw-87
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715160843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSaf9p0kesoLNztcvYNJiJ92JbSB/luH/B+1o6wgYyo=;
 b=iE3uTLY5gcVwXCoVNCfhyAKBWZJHAP3zkwTi0ZLPAUpajhy+2dXrDSNskvc0UTMZin/kvm
 yTHIdeqvRn3WNSscm0/h9gr2n3wDV4YBDlstOPruFPEJzw59WBhVgFyiav7PrWY3DZ9wnA
 G33UaV/hnlbe3G/85CYblYljrZzK9Hc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-axA2Z6cwOgK-xw7Y5NtqWA-1; Wed, 08 May 2024 05:34:01 -0400
X-MC-Unique: axA2Z6cwOgK-xw7Y5NtqWA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34c85b29a7fso2993832f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715160840; x=1715765640;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSaf9p0kesoLNztcvYNJiJ92JbSB/luH/B+1o6wgYyo=;
 b=NTrI7maqXyEgRrYzvSLQncC6tBISRXyG9rEr7XL2OPd5a8gBTOfyBZPyF+sj48QMze
 7M04tmiuL2jWN6OPUWmKQE8OWsVllA10vWXBJXXPeLTheHvvysBdG1K+70TN1QX04Afh
 qzn0ZyBqGVhlx1SDbRZuVIFLAbqn4sM4K+wzWlQO9/RPFPFzoaqqHn6MDnXOiYn4iOBF
 42hx9YBJfOuQKpoqaLp4ehIEXaI2LRMZYVLtGGG2MIyjnylF6t4L07I/5B/rTzRNw9lP
 /OhCa7oTYUoxe1/YTNuSuUw2DQyp9/zRGKnYhKknHiwmrqqWocfPCQ8w9BinKqxBHf2A
 FfYQ==
X-Gm-Message-State: AOJu0YzGra75YPTDTpuIfrgzIsv0mkWCR/+wQ0iOE2rPq4p5nNod9LjE
 1YL4jjNIP05izBbxm8uabNpW+7/Iu2x4lJG3CpnsTThlFqvAP5g3iUY1s7J2ztCxghGoC7pIYWM
 jM+ZfBk2KHcjsBeFEqnRSGOZ2ivHhH+sF5xiLUBBZ705qQVdia4pb
X-Received: by 2002:a5d:6da6:0:b0:34c:9e4a:e72c with SMTP id
 ffacd0b85a97d-34fca14b308mr1840141f8f.11.1715160840712; 
 Wed, 08 May 2024 02:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/slMMFehOnAZ06D1x4IoDrCBZT1IxWHouQRVo2/3R8dWdl1uZPihFpy4VTFvn9SrLWBGjig==
X-Received: by 2002:a5d:6da6:0:b0:34c:9e4a:e72c with SMTP id
 ffacd0b85a97d-34fca14b308mr1840107f8f.11.1715160840318; 
 Wed, 08 May 2024 02:34:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 q5-20020adff945000000b0034f5925edacsm5459322wrr.30.2024.05.08.02.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:33:59 -0700 (PDT)
Date: Wed, 8 May 2024 11:33:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 stefanha@redhat.com, David Hildenbrand <david@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 01/12] libvhost-user: set msg.msg_control to NULL when
 it is empty
Message-ID: <qz46kdzqc266aluq3ib6q3bcmvnunmqv7tybkq2yvvatxgzx4i@3qo6ro3x6prv>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-2-sgarzare@redhat.com>
 <Zjs-aTeUfOy2PDQr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zjs-aTeUfOy2PDQr@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 08, 2024 at 09:57:13AM GMT, Daniel P. Berrangé wrote:
>On Wed, May 08, 2024 at 09:44:45AM +0200, Stefano Garzarella wrote:
>> On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
>> the `struct msghdr` has the field `msg_controllen` set to 0, but
>> `msg_control` is not NULL.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud?? <philmd@linaro.org>
>
>Philippe's name has got mangled here

Thank you for bringing this to my attention and helping me solve it
off-list.

It should be fixed with the next posting!

Stefano

>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  subprojects/libvhost-user/libvhost-user.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>> index a879149fef..22bea0c775 100644
>> --- a/subprojects/libvhost-user/libvhost-user.c
>> +++ b/subprojects/libvhost-user/libvhost-user.c
>> @@ -632,6 +632,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>>          memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
>>      } else {
>>          msg.msg_controllen = 0;
>> +        msg.msg_control = NULL;
>>      }
>>
>>      do {
>> --
>> 2.45.0
>>
>
>With regards,
>Daniel
>-- 
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>


