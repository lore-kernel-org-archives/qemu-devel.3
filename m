Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C5C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp4vD-00072h-45; Wed, 29 Jul 2026 10:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp4v5-00072K-Oz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp4v3-0008Jy-Vu
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785333960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hP3NOgV+J2DWlJFf46mwfnRJPCik9VmhQJjjMJqJgZU=;
 b=C44rzbrCk4vwTVcRF8i9CIMWOMqTK8bQQXyOBZuyEzJ1Z54FN9c6vGg4cUF5Gl851Ohilh
 DDWLwH7nwhG/V5Zf62ewnpQ96JAUYB0+B7rQG+wnw7edL2/mXr9xFlf8SIxqIl5YD8jIMM
 p/L3yuGHAmean5rSR19/7uVlKX6ZVfw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-HFWhRx90NHypzaMDUC4fQw-1; Wed, 29 Jul 2026 10:05:58 -0400
X-MC-Unique: HFWhRx90NHypzaMDUC4fQw-1
X-Mimecast-MFC-AGG-ID: HFWhRx90NHypzaMDUC4fQw_1785333957
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeb9e6a8feso708165e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785333957; x=1785938757; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hP3NOgV+J2DWlJFf46mwfnRJPCik9VmhQJjjMJqJgZU=;
 b=tmZYkaWu4n6KJKGZxYidDhFw7F8hQaknjTvEAbp7UaFruaMd/D82T94NoZFd69Cnj0
 cMJIzPX0dtTYkB1b+GUyjYhXIqTPgnX1cElLw8RH2sSJjSsZEtUSzCcFcn/qUougqmzv
 sfY51QwugfZnQpelZDAzwvi88wTTqK8CpUAzjy87SWJ5No8xFhpY9eXPvcnQpC+wwfjq
 5bUIymaKjyRWhzL666HJJDs5Oz5ZRa79ChDbdt9mGXm34Ty23SMNCZC5OxVfrqzwuwa0
 mb+dSGqJNE8SMDMCV+tkz8txeidld6XuILkLBx8+KqJ1pChlONR0Lni2KLuJuIK3fu2i
 hYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333957; x=1785938757;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hP3NOgV+J2DWlJFf46mwfnRJPCik9VmhQJjjMJqJgZU=;
 b=l4C4Rs6ee4EdYo3MyBGvA21N/8Z8sgwcIzzwkE5TdWDkBUqA9gamMwDec+d0RM4KNu
 GAEb0ipkfKJERLFO36xEqxLwyI5dnYkCYSlK++pI8Ut9D6OU/rNuozzYCD/T34At0qTU
 hUH0JEiToba9sqYFcMdhON8R+1yBMKS25MjLY0N4d/9vSS2JUc9VMAjkYDQIZ6Z8L0RS
 Ls0yD6RSMMTRh9EC/8t5ka4qsIyb6dzXa3GzjnfrQVA9Pk6+HK16bHJ1hwjWLU19NmND
 UYIVCQiJ9Ff/zZIa58VtA8D9gdmuqIwH/qa0+yxpU8MuvtqD5PNh9NkipiQkvOrKXH8q
 J15Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5rbXWPuC3zxRx+wmHVSt8LcU0SH+ZofYplu4x9/pTbUJ3oZN7Me82yzWBcS14ZQJ7Pc01WwRiqLpl@nongnu.org
X-Gm-Message-State: AOJu0Yw2Z26CuGFRUPNAv1ItQ+EdCdgLOQCAmhFiZn3K+/PVUUZvbAd1
 bc4x7LwivwgBvia3+P8xEC76NibXw0dDfgrhP59TsiSIcOrB3KJEDo0p3a7hkHwd9ZiBDzSC80+
 YD1OMynVlIqsq0zVfwRkRRRZbWJ5CTdEm/YQwWP4/TKJ8F+NpSOjBtqxW
X-Gm-Gg: AR+sD137q4uhALIR2MhfrvVLXsrXxwg7ZKCwCAY3/+MWIHolAISrDr3wX2Y95Qlhqkq
 oCzkvX5NAkaz81JozDQGNfbS3kCosRxlv3W32iWsoeFoSHUl9hx7Q4151StAPewZZ5VsbTW4+Vm
 1f/Z714hopMx5+HA+qRMVsynGLE5qhPTISdR+tXeYY8z/14XIgtVU2Ne513LyaQKRNHnKGlQ2cs
 h6Dz52lRqGwYTNyaKTwtzhwtvW91NgulnaFTs+9Vjk5zLzOxviMueTj5Jq+2XtaRAbKLCWc9Frk
 xHVkdgW3uTP69J2sn+5W1gQUd9bfiRusN4i0eYqZyIlngw90B3KKw19T05h/1SJLY+4MKBn74Un
 7mKwm+sNEet+57XqVPq/utsKIjnk=
X-Received: by 2002:a05:6512:3a8e:b0:5b2:9357:b8ce with SMTP id
 2adb3069b0e04-5b2d02519d8mr1310646e87.40.1785333956782; 
 Wed, 29 Jul 2026 07:05:56 -0700 (PDT)
X-Received: by 2002:a05:6512:3a8e:b0:5b2:9357:b8ce with SMTP id
 2adb3069b0e04-5b2d02519d8mr1310626e87.40.1785333956222; 
 Wed, 29 Jul 2026 07:05:56 -0700 (PDT)
Received: from x1.local (67-208-31-164.ip.tor.radiant.net. [67.208.31.164])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f5d5f97d3sm4314001fa.1.2026.07.29.07.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:05:55 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:05:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v20 09/15] qapi: add local migration parameter
Message-ID: <amoIvROeZMqrUY-l@x1.local>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-10-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729091334.1863155-10-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 29, 2026 at 12:12:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
> 
> In this commit we introduce a migration parameter, which enables
> the feature for devices that support it (none at the moment).
> 
> We can't simply auto-detect local migration by checking whether the
> migration channel is a UNIX domain socket: the UNIX socket may be only
> the first part of the transfer channel to a remote target.  Hence an
> explicit parameter is needed. More over, "local" migration parameter
> may be useful in cpr-exec mode, when FDs are passed through exec
> instead of UNIX socket.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


