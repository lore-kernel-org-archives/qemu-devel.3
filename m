Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FADC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPaN-00048I-GI; Fri, 23 May 2025 06:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPaK-00046x-Np
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPaG-000386-Ng
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747995898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oawNubQda7x1Nmr+pSHpzPgh3HUWShnOFG1X3WdiyDw=;
 b=UYS0/T3bDKxMdqGbczUJAnudw6aVAOYxjpgf9blahzSnmSDQ+MFWY2/m4Oo3ozH1AHLWOK
 VdHtHpnXek4Z4I1UKe+VmiPaJDXgNz6c/6wOt4LIy/vkxyAdNvtA9NmUDeSP/zud9/NU4/
 aBhf+jXycbcdRNI2itX6FH4a8whk+yo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-oAceqp2SNJWj3Ol8etY-aw-1; Fri, 23 May 2025 06:24:57 -0400
X-MC-Unique: oAceqp2SNJWj3Ol8etY-aw-1
X-Mimecast-MFC-AGG-ID: oAceqp2SNJWj3Ol8etY-aw_1747995896
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so50223185e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747995896; x=1748600696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oawNubQda7x1Nmr+pSHpzPgh3HUWShnOFG1X3WdiyDw=;
 b=w6W4TAIXXpSH2O6lM7XNVrFog3x28sC1YJOtBh3q69IUV+QIrhR4e94EUpLXxDNnzu
 ZKz8xGGOpslcXKcimwXR00bJh3wPGMzk0Y+KGfXhP0XXzfcXs0QAozl3huHQqdkoPF9h
 TyQ0jW/bmW1vSr/f5W6ggyq4pvx/W4R/+eV8xe+u7FyxxIpnwvJqsX70je5BZ35cMU3W
 W6YGJ5mnPUCN2G6T2PfoaQP5tU5HSp3kHOAUAH6LYxQ8LmA2o4D+632tvblW1MDzoNuX
 +w6Vnj0S77D9ARhoFoG8UlGasCeVUefRIz+V+nAc5LKmU+ZtahIHSRA5E19onFnDYhcG
 m1Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF2KIdLN+vc1jRlRRqBGy1UNV3NjQos4zg4DX6lmusQdITwB/gK8dN1MCdPVr9vCcDwB4KTQzO1RT5@nongnu.org
X-Gm-Message-State: AOJu0YzkfAcw/7x5/46AJwNFb8IbwxqJ24YF1sDWktrIOLeUZdeP8t41
 gvt2yJzDqjDVv/4pJAKU/B3Icw9PHUuWz+7dC0tPPSgsAYHUwV09uGhPgVFxM0deJlnEvrzWcYx
 rzGH0Nyut7M85LIYg8QYVpwNVdhScc3d+gzH3gY0K+WKeeQx4655gzMEc
X-Gm-Gg: ASbGncsZRFOZqJ5mwP7PHhP6SMYELaOieGfCICQvhC5YaFoIIodsGaYVt6cuMO8Jp6M
 dkxitU9Cy4qy4BR9a6n9LLvE6lEDi/c4lbdXcVXXBreaM8naj/SoVzK3l1HZNPUDMr4c19st6aa
 fZvA7+/1rSAODHQzWLu6PaqLAOc8u8WJ8Ys+JW90kaoVjU+a/Bs/mqkvJvgqWHXlxCgd35kydh0
 0hdOfIxA8HdT1v1vGtwkYfnUz7YVGK15k0ItIYERRT/PMDCX8iz7ADYjfoDMwOLOspG+fw1RFoF
 eLFGdTjtZxTNrjDHuaI=
X-Received: by 2002:a05:600c:3511:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-442feffb5e7mr258959725e9.18.1747995895717; 
 Fri, 23 May 2025 03:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgkqxa2llAf5ZXF9wZ5wZREDxlpN5PP+4vv6yc/Cu3DhHSyEbs0rqg+V+2i2bwhMxxXoYwPA==
X-Received: by 2002:a05:600c:3511:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-442feffb5e7mr258959325e9.18.1747995895337; 
 Fri, 23 May 2025 03:24:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a3631c728esm24856178f8f.60.2025.05.23.03.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:24:54 -0700 (PDT)
Message-ID: <3f5b288c-af84-4bb9-996f-c77ab63bb020@redhat.com>
Date: Fri, 23 May 2025 12:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/16] net: implement tunnel probing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <b0e5839ab3e723247b12ddecf36c75c51c5a0b83.1747825544.git.pabeni@redhat.com>
 <6c48edb8-082c-4474-8815-36ab4c64a228@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6c48edb8-082c-4474-8815-36ab4c64a228@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/23/25 9:39 AM, Akihiko Odaki wrote:
>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>> index 22ec2f45d2..2df601551e 100644
>> --- a/net/tap-linux.c
>> +++ b/net/tap-linux.c
>> @@ -37,6 +37,14 @@
>>   
>>   #define PATH_NET_TUN "/dev/net/tun"
>>   
>> +#ifndef TUN_F_UDP_TUNNEL_GSO
>> +#define TUN_F_UDP_TUNNEL_GSO       0x080
>> +#endif
>> +
>> +#ifndef TUN_F_UDP_TUNNEL_GSO_CSUM
>> +#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
>> +#endif
>> +
> 
> These should be added to net/tap-linux.h, which contains other UAPI 
> definitions.
> 
> But perhaps it may be better to refactor it to add the real header file 
> using scripts/update-linux-headers.sh. Such a refactoring can be done 
> before this series gets ready to merge and will make this series a bit 
> smaller.

I may be missing something, but I don't think such refactor will make
this series relevantly smaller?!? Also, it looks something quite
orthogonal to me.

I propose to just move the above definition in net/tap-linux.h, if possible.

Thanks,

Paolo


