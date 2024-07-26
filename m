Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD95FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 11:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXJBs-0001ft-79; Fri, 26 Jul 2024 07:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXJBq-0001fC-AO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 07:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXJBo-0000iJ-Bt
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 07:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721993567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uSDhnvJdeAqIQbVpxBOkkgnfidh1GlMWBeyXZHBnVck=;
 b=ADhudrEwHxtWaKzp5Qo3/gd2EN0wsj2BwSDRsnhWCS8YN/E3LOxqP4kDFmzECxs5DhDX4k
 +NI4I8ZWlrnKRzb8JyJe7Vei8o2WsVC5e8oLp7ya2nWrJhWXNwgacegb/imuUpVlAAjOzX
 CAKYrj9sVyZ+AqSlrMovLrQxW6u0EEc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-b_91ggytPM-F0f0XQyu6_g-1; Fri, 26 Jul 2024 07:32:45 -0400
X-MC-Unique: b_91ggytPM-F0f0XQyu6_g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b798c6b850so1905326d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 04:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721993565; x=1722598365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSDhnvJdeAqIQbVpxBOkkgnfidh1GlMWBeyXZHBnVck=;
 b=kHL37VzAehytiL2n50lcFRDvLzgtCquZZXOeQVHMcL774rmljG+MehF1/611Ibwtqp
 5M9IrNtRwR62ZLAw8mMjjkT4T2URbOnmBZr2u2lu6+Xr/YM4Rfr0ozdbd3xgDN1FLTsU
 t1yIqOLAMF76fP36EdH0ooYeUHBbimPsP6WrXM7nznnF+bBwAe+aiEcETbOfPksy2RNH
 wqz2hHWPMyZAGb867slHM3/cVrQtZKpClvFr1RmTzBo9jm2xtjYk+UyCaoLy4UKlRRnt
 aX5kvbPTMPiNwUv3BkFufFummVcC3nU8vY7az0Gt2PmdsQkfog4UcQKqHx+mBeVo/4HN
 Ra/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO+HsQU3rWB41HcJGsN4eoue569gMAsSOzOM3LZl7j9TmXaWYMqgyoyHa8MNLYbBO/k4wmrUQyBpcNJcc8cpm/V0MFgH4=
X-Gm-Message-State: AOJu0YyDfapJSjj10BLpmx+KxHbnqBo0ak+imXHoi36jibyPDz5HXPNV
 rp9a1fj2KkqxYAk14Rf7Fdx65D4o5o41mrgd62WO3oYIfO1j14YB0DKxNDkxYpDMkSKRIKQ48PG
 WAMOkBk+3aT342fdWs7uUZPuCwKEH5PhSpSDANUfk3bz9R9Snl+9q
X-Received: by 2002:a05:622a:1a87:b0:44f:89e4:131f with SMTP id
 d75a77b69052e-44fe5b7b5f5mr33090281cf.12.1721993565131; 
 Fri, 26 Jul 2024 04:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/8neHBCyeJ2UerVymE97cIaZ5JbOhbPvm/rq5VicoduFA0E7cRVWAfcyn+VYiIJ1M0WR6tA==
X-Received: by 2002:a05:622a:1a87:b0:44f:89e4:131f with SMTP id
 d75a77b69052e-44fe5b7b5f5mr33090181cf.12.1721993564756; 
 Fri, 26 Jul 2024 04:32:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44fe8199a6fsm12669731cf.58.2024.07.26.04.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 04:32:44 -0700 (PDT)
Date: Fri, 26 Jul 2024 07:32:41 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqOJWRDq-W3XfDyn@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <20240726032520-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726032520-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Jul 26, 2024 at 03:25:31AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> > On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > > USO features of virtio-net device depend on kernel ability
> > > > > to support them, for backward compatibility by default the
> > > > > features are disabled on 8.0 and earlier.
> > > > > 
> > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > > 
> > > > Looks like this patch broke migration when the VM starts on a host that has
> > > > USO supported, to another host that doesn't..
> > > 
> > > This was always the case with all offloads. The answer at the moment is,
> > > don't do this.
> > 
> > May I ask for my understanding:
> > "don't do this" = don't automatically enable/disable virtio features in QEMU
> > depending on host kernel features, or "don't do this" = don't try to migrate
> > between machines that have different host kernel features?
> 
> The later.

The question is how should an user know a migration is not supported?

The user can be using exactly the same QEMU binary on two hosts, while
there can be a tiny slight difference in host kernel version, then
migration can fail between them misterously.

There're too many kernel features that can be on/off when kernels are
different, even if slightly.  Then I don't see how someone can even
identify such issue, unless one uses exactly the same host kernels on both
sides..

-- 
Peter Xu


