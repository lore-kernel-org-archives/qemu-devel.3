Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2022606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XmEVvG6y;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=txHMvNzq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLz51-0001vF-Kz; Wed, 28 Oct 2026 04:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xLz50-0001um-2g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xLz4x-0000Fe-Rw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793176334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yf9+AnT8FKwbHjsqqunNGyOr/C6gfTd0c1INxP9wFeo=;
 b=XmEVvG6yzHM89oCWA4k7hPBhT1QczG7xIRumW2lgbj4PKdtSIlliTed8BJY1yW5rmi07Kb
 hrKLtWafuvHZOcCaLglD69MTTSRHRtVVW9q1z4HUzBbEjHy4Mwnc7+cp5stvwO8oWHvWns
 L/f3+WjFmqfZw0NH6FJ3EGWyp0NPSvA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-p9Yh9e2NMsuc-Yl9rIZyHg-1; Wed, 28 Oct 2026 04:32:12 -0400
X-MC-Unique: p9Yh9e2NMsuc-Yl9rIZyHg-1
X-Mimecast-MFC-AGG-ID: p9Yh9e2NMsuc-Yl9rIZyHg_1793176331
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c415561aaso403794f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793176331; x=1793781131; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yf9+AnT8FKwbHjsqqunNGyOr/C6gfTd0c1INxP9wFeo=;
 b=txHMvNzqxe4w6ddaD9Fj8NW/Blz5aN515G+QfYGl01f8x0zx03mheUWG/Wq/ux4fKg
 XbACYj0BjGTssFbIz2leyYv/SMT8xHTfzZLYdJFUbDDpEfLb1xjSRwGYNHsx72wovS+7
 niXAaWJcsKwlZwP7KhIMncEZICvzO7fECzDeCpbQnfxNwXIN8ciKMy+dY4PfAsUzrahx
 XvxwbH2SkXOE+Lnpi4OFltwBQaxlaz4qUnlofBLDxzD6T6UVklt9gXxBpSM1JGq6h2Ob
 1VZpPYr0eZ0aP3YkFARUpKDigCKBfU5ZgliRgUV/vlgbWCZO2gcct3GitbXI8zk5Ww4f
 6A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793176331; x=1793781131;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yf9+AnT8FKwbHjsqqunNGyOr/C6gfTd0c1INxP9wFeo=;
 b=Vifp7NJoZadOkpJWuwUNfzFM/95h01FWVnNwFFeOCr4e/ZJDDaHdaYA+e+ktC7ovKA
 RsKX2cJNl1m419tpklrqTdASXBPBwK2PbVbNy3MXLmClKN5pvYyYz83UaKmAXzcNbrdl
 7JpB9CII3DjoWXqL62nQFWSTTfUE81NwiICz7vCdBok55pavhhDfynIApdLbrODWP+RJ
 V4D7HbON1GIi/DtbHlYPvbFB0tv1rck+25/7OoPnz3ia6FJeDPs3mUumTaBN+njM4RI3
 /Cxm7E9D4iimke8ECN1PFI28DhT4c6Wn2ooqdigi1+x6YZwbMhKzP4Q0rEqkGdmLSKW0
 Md2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvMf9vQyycZCZCzfN+20rtZvlgW5AGlg/MMCnZ7w1tX+TfY5TueCNwkDzHAbUjwY3ufU612lyo9+Sv@nongnu.org
X-Gm-Message-State: AFq9FYJHx9OovAeVEuWTYHXFYqI6KAtk+Z9N2nlJUdzX5cHHdQTTXYGk
 h/Sro3UAoWgzpDOxKCLoZ3fGV5uZYdL+GukxBUvg8FI51yJOaVX25LnMfwiqcuUPm+MkyvaMSk1
 rzYWcPWCBBn05BzfU0gDeHbaTL85ARpoxManOkjXrp/ZtrFq9HaFyJMj2
X-Gm-Gg: AYBFou3apVxRUl0bKk7WDPfTVeR1eUEjEQoT4wHGX7TrNFix+GDHAGupexlxOBEkmTM
 1PCxgAKRK/x3oIgd1pznvYZN4PidSgpoSAyYsbZiNWnT4KpufWEu2ej3OACGf9CgHszujlbUshH
 z5meUP38JuK8Bwb94adpCfYJMPu8Bx+FwqUeTKiEfbkLDQ6Xd6XXtLZa7TQ5EPafiRoDSux6e6J
 JOW+H0yu20Af7klOjzMNx6fTb7umrqoW5GAQNUvLwEXdjRnBY7IG4o9GL0sB8/6lmhSPym1/lQY
 B3di5mhoP6WLpEMqCHDKG3M/UWPPES0ZHGrJwuDYTVGu220ZSvUA4nvmQuTfnNgwdCTDULydYC9
 mGqm7O7ZHMa7r8JZMNI6gk/pc2HaekVYWswJOUHidnBQqKy453weszA==
X-Received: by 2002:a5d:4b0b:0:b0:48b:f08:8162 with SMTP id
 ffacd0b85a97d-48e5d304730mr3162069f8f.39.1793176331373; 
 Wed, 28 Oct 2026 01:32:11 -0700 (PDT)
X-Received: by 2002:a5d:4b0b:0:b0:48b:f08:8162 with SMTP id
 ffacd0b85a97d-48e5d304730mr3162031f8f.39.1793176330919; 
 Wed, 28 Oct 2026 01:32:10 -0700 (PDT)
Received: from sgarzare-redhat ([81.127.154.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f25fsm26354004f8f.2.2026.10.28.01.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 01:32:10 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:32:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Tim Pambor <timpambor@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Brad Smith <brad@comstyle.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 5/8] vhost-user: enable frontends on any POSIX system
Message-ID: <auGyOJGAo8Qivhu8@sgarzare-redhat>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-5-0bd4d450d23c@gmail.com>
 <20261027192445.GC933537@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261027192445.GC933537@shajnocz.csb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:24:45PM -0400, Stefan Hajnoczi wrote:
>On Thu, Oct 22, 2026 at 03:47:26PM +0200, Tim Pambor wrote:
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index 6e05c995f1..788913953d 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -33,7 +33,13 @@
>>  #include "standard-headers/linux/virtio_ring.h"
>>  #include "hw/virtio/vhost.h"
>>  #include "hw/virtio/virtio-bus.h"
>> +#if defined(__linux__)
>>  #include "linux-headers/linux/vhost.h"
>> +#endif
>> +
>> +#ifndef VHOST_FILE_UNBIND
>> +#define VHOST_FILE_UNBIND -1
>> +#endif
>
>This constant is for hw/virtio/vhost.c's vhost_net_set_backend() API. It
>should be defined along with that API. Define it alongside
>vhost_net_set_backend() in hw/virtio/vhost.h and call it
>VHOST_NET_FILE_UNBIND?
>

That constant is defined by a Linux header (see 
linux-headers/linux/vhost.h). Are you suggesting to add another constant 
that is defined with VHOST_FILE_UNBIND on Linux and -1 on other 
platforms?

Thanks,
Stefano


