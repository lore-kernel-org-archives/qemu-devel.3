Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B65DD39008
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg6Gw-00083i-50; Wed, 14 Jan 2026 14:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6GX-00080K-DK
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6GP-0003SZ-0k
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768417838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H0RWyaklsh7/VwkNG3/F+SfJeMQuOjSuf2itmgiiaXs=;
 b=Ze/mkGykwxMw/S5J0vTujspw66HlqoNocmies5LFxAITVI+BEeAN3k857We3WwS8FLeDYf
 8u8hKduBMv4iGrdELWevJjiTrekQuBJTcvV0NTlh8flaTDkyi3NbX9/QNvhd1SEwsa2gnA
 mbgoabWwv8SaKfoNniIP9XeqcXxeypI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-DpyliTxuPm6Qd5y0SuZ_DA-1; Wed, 14 Jan 2026 14:10:36 -0500
X-MC-Unique: DpyliTxuPm6Qd5y0SuZ_DA-1
X-Mimecast-MFC-AGG-ID: DpyliTxuPm6Qd5y0SuZ_DA_1768417836
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a3a4af701so2588226d6.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768417836; x=1769022636; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H0RWyaklsh7/VwkNG3/F+SfJeMQuOjSuf2itmgiiaXs=;
 b=ol5rnalBZFHR5umyJZ3GnWcuV6yLcC7EBKNLY9bCwCd/25pZ+R4V/wzckrDOjqAMep
 JNH9sJvsjPjhMNdYpwpHsUtFuWaQjbEWuQ6UTSNtuiBNjuEYR4aRT9/wzoZC8IZDqVJE
 uAvCZpP5DM0D/N2+PDLmzS5m08zTyjr3KVYMWTwoL1Yy3mWizQSxCJfVqz1Kw3MuHYHt
 1vrXcF4ji0Ah4pNQd3N2SOHULpLZeR3hgYwMQjaV0FtutMxpfpv6KlhXiZa9BALqEub6
 OmlxWQnbMbtSJ9yJEPBr2NjWvCHlica8jjTIkf0+2NDJ/cHCeQmLlpHW/KgSN/N5XLOy
 Mg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768417836; x=1769022636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0RWyaklsh7/VwkNG3/F+SfJeMQuOjSuf2itmgiiaXs=;
 b=dd9foyyThCiqr8mDO0x8LB6DamM5Meg9ubRDjSLPTQx3mfoqeXZVTFmzb0kIsS6F6k
 NOiG7X8pxcYhV2QNdzDRh+nI29e246jeomSRH9uHceFoKD02ZNgN5krBf3GgVyKrnHJ3
 sQGSRR80q3L8t8G4mhBGhdXvk753VDK4Bq9AY+fKOvRL2V7hCOavKyeH86asl0A64pv3
 e/mfUVt2GJqBacgOT7aLJWjZiRU0NEqdP52nJvpmFFlTO/xIBbhmbMtemkgncmgkIjDb
 ZfpiDMSpqwklnnJdDXM1BezwmsVU87KEIxSke6m0YWP22HfAoVVZRjSPtRB8VjWT/n/4
 HgEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWukNv15HUILrBmLRrnXVp6YyHlCHEEfQSjnPXDTG515LyfDObx8JuNvuk2/m2Kxo8SAtxpFUx8VUPk@nongnu.org
X-Gm-Message-State: AOJu0Yw0JU7QHEnmGTFgjj2dDN4c0KDus3SXAtdJJ+5+ST53f1a0Y1mX
 0azgiLmkmxjNEgpfjhMEvCdT6oFfhyIHxbotydx0S8BBAYxoOyTr4XsV+rEBuWWNAWix1KrGQL4
 vWTl4DvuFr5kLD5oREnyp+h0jtT1+08szaZt9rPCBEdyv8+P8bZHwLEaG
X-Gm-Gg: AY/fxX7Gki4EjoW4oKIZ1woNnlzH9lT3QVX9TGgNzl1nh+4sAXsYcAfl2gNexBdrDNK
 tLVoHdkuwvjxOYBKmsOj6v0sdKLksq5g+sWx9XU4Uz6pX7CqFJaEgl2malo2H8VtUre+t6sdX8M
 KMPz67BRKOxBnB9MhmRpQmhR0UAPzEOn8pWdNHgp3XiaU8cJmtYDp9d1e3iAqL5f0/TYrECMGoM
 LYIauFdlCUUwrE/0j5o1AaMWHcPm6ezRu0SG31dXXGRa2NqeqnNXWg9bIXbl/6Gg40ttXAvnix0
 6uKjgDiqb7qwh7/jpjoM62/iMAs+UmY+E+tSaqAR8FDztLwelZPILMBRmqs5Bie68qUNNZDf4qC
 qePY=
X-Received: by 2002:ad4:5943:0:b0:890:8436:c82e with SMTP id
 6a1803df08f44-89274362aa5mr48613446d6.14.1768417836189; 
 Wed, 14 Jan 2026 11:10:36 -0800 (PST)
X-Received: by 2002:ad4:5943:0:b0:890:8436:c82e with SMTP id
 6a1803df08f44-89274362aa5mr48612926d6.14.1768417835661; 
 Wed, 14 Jan 2026 11:10:35 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770ce985sm179809136d6.11.2026.01.14.11.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:10:35 -0800 (PST)
Date: Wed, 14 Jan 2026 14:10:33 -0500
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
Message-ID: <aWfqKdamP4rnZqvH@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113181242.GB528940@fedora> <aWaVVJh13ctiW9Ku@x1.local>
 <2af404d1-5e50-4caa-bee6-f8aab6a30a7e@yandex-team.ru>
 <aWeKn5A7-tWaWv0z@x1.local>
 <832f4005-2e51-49fd-91e8-9f4cbe9f2adf@yandex-team.ru>
 <aWezg94AB5a3F0EV@x1.local>
 <d5c106d9-9e37-4f44-b0e9-4321d12f8bf1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5c106d9-9e37-4f44-b0e9-4321d12f8bf1@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 14, 2026 at 08:54:50PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 14.01.26 18:17, Peter Xu wrote:
> > On Wed, Jan 14, 2026 at 05:35:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 14.01.26 15:22, Peter Xu wrote:
> > > > On Wed, Jan 14, 2026 at 09:19:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > On 13.01.26 21:56, Peter Xu wrote:
> > > > > > On Tue, Jan 13, 2026 at 01:12:42PM -0500, Stefan Hajnoczi wrote:
> > > > > > > On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:
> > > > > > > 
> > > > > > > Peter: Please review the migration aspects (especially the vmstates).
> > > > > > > Thank you!
> > > > > > 
> > > > > > Looks good from my side as long as it's based on VMSD, I appreciate that
> > > > > > change from the old versions where it used to use qemufile APIs.
> > > > > > 
> > > > > > The major question here is if this series depends on Vladimir's other
> > > > > > series
> > > > > 
> > > > > No, it does not. And if we can proceed with merging these series first, I'll
> > > > > be happy to rebase on top of it.
> > > > 
> > > > I thought it requires migrate_local_vhost_user_blk() be present?  The
> > > > inflight feature should not be enabled only if there's a hint that it's a
> > > > local migration..
> > > 
> > > Oh right, I missed it.
> > > 
> > > We discussed that Alexandr will rebase the series on master without dependency
> > > on my RFC.
> > 
> > The problem is IIUC the new INFLIGHT feature bit will be declared as
> > supported to vhost-user-block after applying this series.  Then if we start
> > a remote migration (rather than local) it'll be automatically (and wrongly)
> > enabled?
> > 
> 
> No, not so.
> 
> We develop inflight-region migraiton (this series) exactly for remote migration,
> not for local.
> 
> My series about backend transfer (fd-migration) will migrate inflight-region the
> other way - by migrating its FD.

Ah, I see.. Yes I think you're right then there's no dependency needed.
Please go ahead with the repost.

Thanks,

-- 
Peter Xu


