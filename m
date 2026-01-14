Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA56D29FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzuG-0001WX-4Q; Wed, 14 Jan 2026 07:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfztv-0001T4-Bo
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:23:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfztt-0007zZ-Pi
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768393380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hdiooh6NrQsiBujMo60ueod3VrVFVCWn9eH7aYK3Iw=;
 b=RiI8Eogi1Cwuy2oP9n3MflsRwHt6GIP7H0l9TAGM9APVMarAvb7ZHHJSzPux/1/AOZzSOT
 FZDvwTqyZr5p90oV4Pwec8Yj5qZnMCnF1vqkiSdvQi6EImQLlaea1DBTd1I0B71nOEW+7u
 RW+dRVw6bxZOCAEwImscY2uTQsauFWY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-00DYJANJNUKhhpArof5tnA-1; Wed, 14 Jan 2026 07:22:58 -0500
X-MC-Unique: 00DYJANJNUKhhpArof5tnA-1
X-Mimecast-MFC-AGG-ID: 00DYJANJNUKhhpArof5tnA_1768393378
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8824d5b11easo188779996d6.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768393378; x=1768998178; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6hdiooh6NrQsiBujMo60ueod3VrVFVCWn9eH7aYK3Iw=;
 b=JTyc0Qwc3Lq1UUKb2vNdq6q0DqV/2I5tRVBVJSyb1cCKylHNfzhEDa7koMbBxqk6+T
 Xx119C8qdiafDmeNNHjHus7agZpGlekn0247FjP18zhEeNzFIRUyODMTHa+3qVKq36ye
 TW0XZshxutEPDvdipPti+v9arUIc4jkIRaYF/tvewCb1bE4SFAWOJkofObp01Ev7b/BF
 m5Im9aQ1pTmvP7j+/tTYqDyabuby1PgM2hEI2A0T7RY3CZ8BuYNeTlvUSDAYG4xLpd1b
 TzGUooWg9yLFR9Mo3i997ToDBAuTGI3hLUUhRVEuY0En/eRNh2XEAiE859NMnB9Yw34z
 PUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768393378; x=1768998178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hdiooh6NrQsiBujMo60ueod3VrVFVCWn9eH7aYK3Iw=;
 b=H1xVnllhhJobhkvbUC1CIWPIVG8xuCWLEzTQw2i0oB7BadVaNAiTyQFM/4HuLsFNL9
 F/FULT3SPi9bEOGE/gPOCtnlTgaMQKgmz+x9zA3Gl8CACUGExGtxksMKv3BWA6i33IMs
 Cr58CDXxABBCCHJ1rJCApxvSiNci7Z4IdB/nx3zaAXS9vOhf1NmzDx2DKVd+yaf+Isud
 aw6gU7DwxJAjveqfj0pNMHJheqVcfTICJSbS3BIyYAt3cC/f2TDa7H7ZaHWZfdeWUQ42
 dAitfz7A1uEL+KSKLAAt3IA1qHyUcTkpX8Gse5czSwH5FVmgIo+plj8WjfdDRwh5vY5A
 htbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbrlH4rsCpSM7W3bnD1hXRT6OrL5Tlreomushjhjs8Rkrzzhel1HxXg2Q54vlzfAfc7o25Mrif2YVk@nongnu.org
X-Gm-Message-State: AOJu0YwVkMckq7jWevQKFHYGBR4y/h4z1im5VAiqN2f8FYWDgfHzNkQl
 r/VVHGKUDnM1p/NoDnGkInI/0rFkqZuNpuWKgM4vUun7lnVkvaQ+2AumHQHrJuBsGHGSr54fT/g
 XwyCQkk+to2SwLXY5JdAwEx7/G0DW3y6gwQt4otEz2P9tr3imJ0chxI7j
X-Gm-Gg: AY/fxX6zi+7ayh0qZzq0sni6Hq6zc34cF7zn0xihP05bYpnMkNEdjbHDghenk0n3fzE
 RVNfwZWRurc+1EnOfHHxwhxC/LWYAi6AAYzt7sxmPkE/ZaA9p38c/SUFLHXdZfiPN13GiJNYnz1
 nsqypRpvEB/whsbtFIOi6L9oOpX0qH88Pse/So2lu9thqHMyIvHjhPvWAyMZXBsger9YiBjp8yb
 1O/zf5GHzR5ZIsO4co87043DBZc4PJMcxxH4YKwLnWt3I6RFq2cwaJzmMudyZbdMc/8/N9Yrp6S
 a3Z0smDW51yajJVfea2wE6fSvAklQe4153c4m8b/CnVeXm16u8HVJY9D6Vs/lg2RMp4eTdyKsJg
 Hd7I=
X-Received: by 2002:a05:6214:21ed:b0:880:5193:1102 with SMTP id
 6a1803df08f44-892743cf6a6mr28041936d6.56.1768393378073; 
 Wed, 14 Jan 2026 04:22:58 -0800 (PST)
X-Received: by 2002:a05:6214:21ed:b0:880:5193:1102 with SMTP id
 6a1803df08f44-892743cf6a6mr28041436d6.56.1768393377556; 
 Wed, 14 Jan 2026 04:22:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770e2a8fsm176650066d6.16.2026.01.14.04.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 04:22:57 -0800 (PST)
Date: Wed, 14 Jan 2026 07:22:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 0/5] support inflight migration
Message-ID: <aWeKn5A7-tWaWv0z@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113181242.GB528940@fedora> <aWaVVJh13ctiW9Ku@x1.local>
 <2af404d1-5e50-4caa-bee6-f8aab6a30a7e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2af404d1-5e50-4caa-bee6-f8aab6a30a7e@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jan 14, 2026 at 09:19:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 13.01.26 21:56, Peter Xu wrote:
> > On Tue, Jan 13, 2026 at 01:12:42PM -0500, Stefan Hajnoczi wrote:
> > > On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:
> > > 
> > > Peter: Please review the migration aspects (especially the vmstates).
> > > Thank you!
> > 
> > Looks good from my side as long as it's based on VMSD, I appreciate that
> > change from the old versions where it used to use qemufile APIs.
> > 
> > The major question here is if this series depends on Vladimir's other
> > series
> 
> No, it does not. And if we can proceed with merging these series first, I'll
> be happy to rebase on top of it.

I thought it requires migrate_local_vhost_user_blk() be present?  The
inflight feature should not be enabled only if there's a hint that it's a
local migration..

I'll comment inline on the patch later.

> 
> > while there's still one patch that is not-for-merge:
> > 
> > https://lore.kernel.org/all/20251016114104.1384675-24-vsementsov@yandex-team.ru/#t
> > 
> > Does it automatically mark this series RFC as well?
> > 
> > Personally speaking, a new migration cap would work all fine, we should
> > have discussed it somewhere previously.  Said that, "local-vhost-user-blk"
> > capability is likely not the right one.  IMHO it should be either "local"
> > or "fd-passing" / "fd-passthrough" (or something generic) as the name.  If
> > we are not sure if we will leverage more than "passing the FDs around", we
> > can make it as simple as "local" as a new migration capability.
> > 
> > Then migration's misc.h should export a function migrate_is_local() then
> > device code can probe that in its own vmstate handling paths on save/load.
> > 
> > A note to Vladimir: please remember to add a check to enforce UNIX socket
> > when a formal patch 23 will be proposed some day, no matter what is the
> > name of the capability.  It should fail qmp "migrate" or qmp
> > "migrate_incoming" command if the main URI is not a unix socket.
> > 
> 
> Thanks! I'll keep that in mind when prepare next version.
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu


