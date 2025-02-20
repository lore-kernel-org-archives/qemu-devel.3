Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7F8C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 20:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlDQp-0008TD-V8; Thu, 20 Feb 2025 15:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlDQo-0008SZ-74
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 15:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlDQm-0005xV-6q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 15:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740084358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzzZ5ww6n8noddmUx/YahapgVYOjnRL84qT3+4Wfjhs=;
 b=MZRCT8lHesncmepa6MdhOd4LOr7Arik4JVonDJcYzMrcUq0/chKbBLETHGTp56Rm7dLWAM
 FIlyzF30nsJZDFhRoMHOKeD16aGAQefntwYr1Rf+XEJ4stwgtdzCUVGrHeKI3VPHPKhI+Z
 i58j6OyF0I+uTCGhmE7WMS653X+RDvA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-CdcibevYM7S9J20M9x_iew-1; Thu, 20 Feb 2025 15:45:56 -0500
X-MC-Unique: CdcibevYM7S9J20M9x_iew-1
X-Mimecast-MFC-AGG-ID: CdcibevYM7S9J20M9x_iew_1740084356
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb8f65af3dso131493566b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 12:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740084355; x=1740689155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzzZ5ww6n8noddmUx/YahapgVYOjnRL84qT3+4Wfjhs=;
 b=P4kdw1myQXIhlHxw3LgGNiDn8RGJSRvMwWnpPUr+ZAj/C5ZDwqo726pKZqqc+ql5mP
 rKKv6POeibn7opnExAsC0pDs7pCspR6ms+LN00bgu6eX9z9gq1fvOK+WGzP0QIBhUb27
 z6UFngHuhqlT7ZK3F+48+w96R11sC3nT2P4DS9XVnIHmoQStTtouDPi2zkX8ESSD2yAa
 uCP2kRBOdlS7xP9/OrUSvuWhcaqA3r3JjqKncW0dRUX3bskX9tOt5v/uir26El1rf0ps
 znsdC1kYZGBWMTP46wW91X1sT/vp7FzKB06v0vpJSCHaApJp7lfs9HZ/ctIEmCtdFDrw
 Be5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU55ok7UDU41XrLusAXhkxrJbrgeyic7HcqVQZly1Zb3TymqhbgECAip2cPrjeFDg/Gfbrw64MgQ/WM@nongnu.org
X-Gm-Message-State: AOJu0Yy6EQs/hP2U/ZPU0u/cJbdLB8e86YIV7se6XENYZ4ebItEvTFDK
 My+1xVjQasw9smrSFxBt3KxWF227ZYMsjEOwLwQTw+ZxNfUaw/1gd2jsUDxOOkA9PIjUecy/kD/
 BTAvWV021p+9vQXNa2ptFTe2yytGiMj96E7tz6SL9hPyDormd/vXI
X-Gm-Gg: ASbGncsWcr6gQ/qaJYjkerOuR730H8P58w8zGOr1BuCDcCJ5gfoLdp4g5xHkb4lApY0
 0Lb64NAMw+spgVUsbpsq5qhy4kQ6jNRo+amCwyuIu/zgs7Q9IqWLjq4rF4LqwFo9UFFiPBWdv47
 0ng31fU6H0XmS+x6nCUfiiT0506CMELGsACiyvrDxhfZNB4e6bfLIAMab9bXK1GmU5+y151wLEM
 vBl0Zg+TwRMqiXjuGqwC25ayHI37WdHxri7RXEM0xbhPbrN1+wrclrZ5y9VnLSP6oDslA==
X-Received: by 2002:a17:906:6a14:b0:abb:b36e:5350 with SMTP id
 a640c23a62f3a-abc09c2654emr79135966b.44.1740084355449; 
 Thu, 20 Feb 2025 12:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEks6qLmt4WO+P6CqcBzV5MsioVe0OemrL7GT3UeruCAb4JtJkW7w7ghNkO/PimCCUNw16SoA==
X-Received: by 2002:a17:906:6a14:b0:abb:b36e:5350 with SMTP id
 a640c23a62f3a-abc09c2654emr79133166b.44.1740084354641; 
 Thu, 20 Feb 2025 12:45:54 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb6e4df5basm1150590566b.152.2025.02.20.12.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 12:45:53 -0800 (PST)
Date: Thu, 20 Feb 2025 15:45:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Thibaut Collet <thibaut.collet@6wind.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250220154353-mutt-send-email-mst@kernel.org>
References: <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <20250124170327.448805ad@elisabeth>
 <20250220102724-mutt-send-email-mst@kernel.org>
 <20250220175910.25688823@elisabeth>
 <20250220131932-mutt-send-email-mst@kernel.org>
 <20250220210004.1501dd86@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220210004.1501dd86@elisabeth>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 20, 2025 at 09:00:04PM +0100, Stefano Brivio wrote:
> On Thu, 20 Feb 2025 13:21:33 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 20, 2025 at 05:59:10PM +0100, Stefano Brivio wrote:
> > > On Thu, 20 Feb 2025 10:28:20 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Fri, Jan 24, 2025 at 05:03:27PM +0100, Stefano Brivio wrote:  
> > > > > But I don't understand why we're leaving this as it is.    
> > > > 
> > > > So that people notice if there's some backend problem and
> > > > announcements are not going out. should help debug migration
> > > > issues. which we had, so we added this :)  
> > > 
> > > The message mentions that the back-end fails to do something it didn't
> > > and can't even do, that's (one reason) why it's wrong (and confusing)
> > > and this patch is obviously correct.
> > > 
> > > Perhaps the commit title isn't entirely accurate (it should say "when
> > > unsupported", I guess) but it's somewhat expected to sacrifice detail
> > > in the name of brevity, there. A glimpse at the message is enough.
> > > 
> > > Laurent now added a workaround in passt to pretend that we support
> > > VHOST_USER_PROTOCOL_F_RARP by doing nothing in the callback, report
> > > success, and silence the warning:
> > > 
> > >   https://passt.top/passt/commit/?id=dd6a6854c73a09c4091c1776ee7f349d1e1f966c
> > > 
> > > but having to do this kind of stuff is a bit unexpected while
> > > interacting with another opensource project.
> > > 
> > > -- 
> > > Stefano  
> > 
> > 
> > let me explain. historically backends did not support migration.
> > then migration was added. as it was assumed RARP is required,
> > we did not add a feature flag for "supports migration" and
> > instead just assumed that VHOST_USER_PROTOCOL_F_RARP is that.
> > 
> > If you silence the warning you silence it for old backends
> > with no migration support.
> 
> Thanks for the explanation. I'm struggling to grasp this. So if a
> back-end doesn't support migration, because VHOST_USER_PROTOCOL_F_RARP
> is not present in the features flag, migration is done anyway, but then
> this is printed:
> 
>   Vhost user backend fails to broadcast fake RARP
> 
> with the meaning of:
> 
>   We did migration even if the back-end doesn't support it, whoops
> 
> ?
> 
> Note that the message is printed *after* the migration and the flag is
> *not* checked before.
> 
> > If you want a new flag "migration with no RARP", be my
> > guest and add it.
> 
> That would actually make more sense than the existing situation I
> think. VHOST_USER_PROTOCOL_F_NO_RARP?
> 
> I didn't understand, yet, what the exact meaning would be, though.
> 
> > Or if you want to add documentation explaining the meaning
> > better and clarifying the message.
> 
> I'm still in the phase where I'm trying to understand the role of the
> message :) ...I have to say this is fairly different now from what was
> mentioned on the thread so far.

I'm going by memory. We made it a warning on the assumption that hey,
maybe someone has a way to migrate without a RARP, let them work.
Exactly what happened, we just did not think it through completely :)


-- 
MST


