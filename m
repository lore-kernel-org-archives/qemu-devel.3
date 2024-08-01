Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXtj-0004xR-DV; Thu, 01 Aug 2024 11:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXti-0004tP-DE
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXtg-0004DA-Q3
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722526760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fuDvRQgvx1zZ4BI5eTCe9MN+xRp0vdvxz1MaSTH4mZM=;
 b=dTuyQP5Z29CCIvru23FYK5Go2fJhWikIHKgaY/vanf3SyHMEi1NGKOzcr5OJkmPMxwKis6
 CBkzNCJGvVda3zJ+wbK1EtgKYAp/pWmZC7GMbpfz9JdgLsq/mA3tSLe6B7Y9C8CcNKjot9
 p6IU2jbN3wKp9ga1t6GjHajgfdxsUlE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-hHFZ2hiWNoWuiZHoXWYCzw-1; Thu, 01 Aug 2024 11:39:17 -0400
X-MC-Unique: hHFZ2hiWNoWuiZHoXWYCzw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a2d4fb1e73so7113761a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722526756; x=1723131556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuDvRQgvx1zZ4BI5eTCe9MN+xRp0vdvxz1MaSTH4mZM=;
 b=QkrUTNf6wOf3OsiNgSsIHqWA+Wid9kulXFPoZ7Y2DDytuVcB4ykE/zQrcmP/PB5vCG
 uSaVuWGdcZe5hzCinLaKgJRwyK6nyef4GJRYIelzA29jKbyMz/PTpPnQ3V545FL2VuQM
 MAC73vCMVyRQRdK2ntGAPHtxnWGTVwA/YNXCOQOzvi5nVXIaM6SG7SUEkohS+ZB//ukt
 7vS9Z1vFLzEypKgpXJj2hjnrkP4mFzs8tK+w24oAuHxutlq8VEDrLYAwiyWn87Lrrpz0
 VeMTy9pw+Ku/Icl9DATfY4BpSRRyelB4qP7L5+5lJFOyAEEsAhFo3ZC89J5C2Ub5A9PV
 3YCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk591l0sa/KXZM4flJxzQYNvbjhfyRyA1EooEyDzwnjS3ofQk9DdJs1TaP4rZuTT4WvTMih3nItZrnMI0Ov9E8SpoDqsI=
X-Gm-Message-State: AOJu0Yxs2ozPzf/2iqMtD2+Uo3UPbuP4V6qDm200/XIURWFeiRogxS/T
 vYCHrjTUCL5k+XW39RT0PzYf/BtZywDG8ZtsVJPf4eT8fktOTTehm52S9ZruzYWfJbOZ2SwplJC
 14/CZK6gKv9pcadPncguH0WPOFqRowKTZVCEScWlPlHg89p8LrML8
X-Received: by 2002:aa7:c651:0:b0:5a2:c1b1:4b9 with SMTP id
 4fb4d7f45d1cf-5b7f59e0987mr444475a12.35.1722526756266; 
 Thu, 01 Aug 2024 08:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7gGXTxb+2ne79qGc/a6GO5ojNuoWH/gQ3IONIsgQznHiWFBQgSqk/owhCIJyusjxbDkyqGQ==
X-Received: by 2002:aa7:c651:0:b0:5a2:c1b1:4b9 with SMTP id
 4fb4d7f45d1cf-5b7f59e0987mr444441a12.35.1722526755563; 
 Thu, 01 Aug 2024 08:39:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3146sm10336495a12.66.2024.08.01.08.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:39:15 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:39:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801113826-mutt-send-email-mst@kernel.org>
References: <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
 <Zqo00Na1MZpksY9A@x1n>
 <20240801014222-mutt-send-email-mst@kernel.org>
 <Zqurc5m52YivhlYU@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqurc5m52YivhlYU@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 11:36:19AM -0400, Peter Xu wrote:
> On Thu, Aug 01, 2024 at 01:51:00AM -0400, Michael S. Tsirkin wrote:
> > So I suggest a single command that dumps some description of host
> > features, to be passed to qemu on destination. qemu then fails to
> > start on destination if some of these do not work.
> > The advantage is that this also helps things like -cpu host,
> > and a bunch of other things like vdpa where we like to pass through
> > config from kernel.
> 
> Something like that could work indeed.  I'm thinking whether it shouldn't
> require a new QMP command; that sounds more work, and we also needs Libvirt
> cooperations so QEMU migration will still fail.  I wonder whether we can
> integrate it into migration handshake that I referred previously in our
> TODO item here:
> 
> https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake

This is different. You can start migration on destination
without touching source at all. This allows e.g. finding
a destination that can support your source.


