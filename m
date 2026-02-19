Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24465C531E1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBoR-00062C-S4; Thu, 19 Feb 2026 16:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBoQ-0005zv-Fa
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBoN-0006c4-AP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771537429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1l5gm3lXAUvinq79FRKewcKXV+JwPg66Jf7SVPM+8o=;
 b=b5h9XKqy2O8deoifDXKjGmYy6m/J8TwYoADkuXxFDgD0ASi+1syC1blOt4JHLkbee6afSq
 dg/EG5kInRIVxRP2hDcA17CT0Ip5IyIzP36e+mAkOMSQTMj0v6GW8Lses0MjEikmE3Tlp0
 sQch84sI5FR5tRQWM3m7sKKOmZNv2XM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-PghmFx8mOgac2VEMwXiNEg-1; Thu, 19 Feb 2026 16:43:47 -0500
X-MC-Unique: PghmFx8mOgac2VEMwXiNEg-1
X-Mimecast-MFC-AGG-ID: PghmFx8mOgac2VEMwXiNEg_1771537427
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88fcbe2e351so216658016d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771537427; x=1772142227; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u1l5gm3lXAUvinq79FRKewcKXV+JwPg66Jf7SVPM+8o=;
 b=anpmdZgT13bICQfN2EDVJt6a9zG0H0NckdIN/s046Pjc+SMz2eFBXr+6VFi3LQr9pb
 MBFKv/hU3dfNCQjeM1LEMdl0+n/NGtL9MotcxHe+oYtg5qGrZxJLVBEQ4iFapV40RE5x
 9w8yvRDDqEctQgza1zR3uwD3L0uN+BKSs2E3r5aJbfIWg/w97EBcJulL+EPT/WQH7fgJ
 ijRVta9ZO4jN0Z05LVslz58cmpJ9dh4HTvSoR7AI3HZl5WrTOdJTHPgtwtxHd+v62vP8
 QYEMz3OSEP3IoH5JfHJYHsaV3oz4y6jVG3Tq+rQZTjPZfKVTxLJ4L1AxfLst8yXWi1Gu
 8QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771537427; x=1772142227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1l5gm3lXAUvinq79FRKewcKXV+JwPg66Jf7SVPM+8o=;
 b=oNyo2cyXnEfZ2Jk3yBx/Nj+/uDukYf3wJ0QrXq5rEIKB+4gccgWWtqWe6APR00hAqK
 rLIDFcECEum1SjxN4Cvy3+UHdMik+qwtmeX6YJ0aIuEeWn0OO2tEYOPhqthwFpkS9bC1
 kr6xhxonqoWh8lf/dcbDJoDQOf3BqmHH8cGofVQkv8bsfKRHf6WjiHMzVe+5Ym/A16Wl
 eGzRsJPX2hOG9NUV3MUTqnTLwKxJp7T7+Cw1AaAPv1fNttnnD6LN/c0GIDV9psySMe4H
 r0nm55cE7vurjhgnbyI4g5jMIlgax7SA3EjVgPjt/96XtK3NjEKvpGZ1XnNAJ/arnXes
 HYwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdPUfNEdKwgkKUr7UTefzZU3RwjroWiFE6NGEqEYqIc4nZIEJdEA8H1znesEhb4oVXWa+y/jMaCGWs@nongnu.org
X-Gm-Message-State: AOJu0YzPmlchH+jZ5I3M3JiUIUm5mE8DReQqdKAZqa7ulJIvbnLAcZLe
 3ZAwYhZlXJkqo/2BGCRVpUBLp+jjjAgmN7KnfIvvG3II4q58j/z9McBbmb/eB6mr//IIuRRE4Dw
 A+ZCy7kETI9A3jaIpL1iOb+4citbvRmFg0i2/dPd1YEXXHy1YsL4aCG1Z
X-Gm-Gg: AZuq6aKjn0OAtanoj0NZRqVpALn9HMHr+916VkwI8O6f1wYsl5NUnGKBGil7hxGjHjA
 RspOiZJu0WshsFqjlonFBZ+CNCpj4EurCCjrps4IlEi7mA7T/nznRgRTDhJm5ii/SlILPLaiiV4
 g4XIY2P9sBo+4C73OIbie56dEl5e02ikIhGCi65/wSlmucMhtVa41BlUcSotkWjj4yu3e8jtzOO
 lz1ZyTx4i2aGdr2LeQbc9eQ7TuWf9eKIEzeIEs6vA2h3Q0edUpMTvi5Z5M2dT6zzHod1/ZxySAo
 cQ5jrZlwq6a6+5yelrHkTWCB9Y88VMynwfLXoX/SyqNswXbcWs6IyX3N5f0bf5eGhNYGU1caiGC
 Et/MfqnDoLy0oRg==
X-Received: by 2002:a05:6214:c46:b0:894:3bac:49d1 with SMTP id
 6a1803df08f44-89965af787dmr46625366d6.11.1771537427083; 
 Thu, 19 Feb 2026 13:43:47 -0800 (PST)
X-Received: by 2002:a05:6214:c46:b0:894:3bac:49d1 with SMTP id
 6a1803df08f44-89965af787dmr46625086d6.11.1771537426633; 
 Thu, 19 Feb 2026 13:43:46 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb48c27330sm1801312385a.19.2026.02.19.13.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 13:43:46 -0800 (PST)
Date: Thu, 19 Feb 2026 16:43:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, thuth@redhat.com,
 armbru@redhat.com, eblake@redhat.com, farosas@suse.de,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: Re: [PATCH v11 3/8] qapi: add local migration parameter
Message-ID: <aZeEBqiocvOeutDn@x1.local>
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
 <20260219115530.2019498-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219115530.2019498-4-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 19, 2026 at 02:55:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
> 
> In this commit we introduce a migration parameter, which enables
> the feature for supporting devices (no one at the moment).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

PS: one nitpick is maybe we don't need to spell out the per-device option
in the doc of "local", it also doesn't need to be called "local-migration"
on every device if it will be presnet.. no strong feelings.

Thanks,

-- 
Peter Xu


