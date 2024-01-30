Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBAEC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjhF-0007V8-Ed; Tue, 30 Jan 2024 03:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUjhC-0007Uf-Nh
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUjhA-0005qf-A1
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706604135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N37BdmlH9SW7HCxOhxuJd23p87ypGgIXGP+bc9rngNg=;
 b=Zn5qz4igMrOApvpto4AOXHBO1pLfwxDeQpIlgTwTpPqi3uV6eoqtaTJEWE9lscBXmw+7sb
 aR6qgOP9jXsuRQIHBlpUYB+sf478wSME+bB1JjStoPL3yCl9wAnK8BYJM4cpTNy7L1CPNN
 84fIAKpdaZVUsXMYPbMJFerXLk1fiC0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-1iAiGfVGP-a0Se_Tuof0qw-1; Tue, 30 Jan 2024 03:42:13 -0500
X-MC-Unique: 1iAiGfVGP-a0Se_Tuof0qw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so1104714b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706604133; x=1707208933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N37BdmlH9SW7HCxOhxuJd23p87ypGgIXGP+bc9rngNg=;
 b=PhR56posMdUjvdkQVKWOalvjSOKTVn2VJatqOHNLs33IpZb48HphBm7EMNdQstSCCY
 kCkwrodRaUnlw7ZkjKYZ6Vg+e+mfePcSkIjsyRCs6SJyrO4A1VpGRq1zSZIhoGWm7kl/
 1kfi5Fy4L5yu5g35t6gcp/aLsGSKHQ338UWStSQeNdftvMUuU0PlzV27/USvEZgulfJn
 /I4zCGtppy1MggkeH3ZYjXFZ0+jo/JE44p2RtgrF+ksY8CES8Oz3aYKITV7QtlW72+W+
 XYu67iAO5Bfw7J+qQm8Yx1TT9bZDWrDYhITg+p5wuWlukj9qNYDX3DWxSbVv+BLREvPh
 uJRQ==
X-Gm-Message-State: AOJu0YxA1N7o3IGWBtn+Bpo/CE1IpFjY/jKAkkkGo57+Rh23V6pheur1
 en/RVn62lKBc7ggarACHB0K19WGt1fuTWiM88EWM2fepbwYZTCNyTaRWiZVwl9Kw+ta5pxE3Ruj
 SjxdBWppRoIRjgZi6OTVrNJKxsDA4GpvXqYI7FdKV8j5EnGTvso3y
X-Received: by 2002:aa7:98c1:0:b0:6dd:c870:2f7c with SMTP id
 e1-20020aa798c1000000b006ddc8702f7cmr9489923pfm.2.1706604132757; 
 Tue, 30 Jan 2024 00:42:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkDVQyCFCs1HzEE2yUqtIv/7b9/bWdoWTArD8u4PbEYh/WyCX4H/IfUCX79D+2KA89Dva3Ug==
X-Received: by 2002:aa7:98c1:0:b0:6dd:c870:2f7c with SMTP id
 e1-20020aa798c1000000b006ddc8702f7cmr9489909pfm.2.1706604132350; 
 Tue, 30 Jan 2024 00:42:12 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ld10-20020a056a004f8a00b006ddce8e110bsm7192952pfb.128.2024.01.30.00.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 00:42:12 -0800 (PST)
Date: Tue, 30 Jan 2024 16:42:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 1/5] migration/multifd: Separate compression ops from
 non-compression
Message-ID: <Zbi2XDfeJHcUpUp9@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <20240126221943.26628-2-farosas@suse.de> <ZbdFzFxysMg274Rw@x1n>
 <87mssoe2fj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mssoe2fj.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 29, 2024 at 09:42:24AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jan 26, 2024 at 07:19:39PM -0300, Fabiano Rosas wrote:
> >> +static MultiFDMethods multifd_socket_ops = {
> >> +    .send_setup = multifd_socket_send_setup,
> >> +    .send_cleanup = multifd_socket_send_cleanup,
> >> +    .send_prepare = multifd_socket_send_prepare,
> >
> > Here it's named with "socket", however not all socket-based multifd
> > migrations will go into this route, e.g., when zstd compression enabled it
> > will not go via this route, even if zstd also uses sockets as transport.
> > From that pov, this may be slightly confusing.  Maybe it suites more to be
> > called "socket_plain" / "socket_no_comp"?
> >
> > One step back, I had a feeling that the current proposal tried to provide a
> > single ->ops to cover a model where we may need more than one layer of
> > abstraction.
> >
> > Since it might be helpful to allow multifd send arbitrary data (e.g. for
> > VFIO?  Avihai might have an answer there..), I'll try to even consider that
> > into the picture.
> >
> > Let's consider the ultimate goal of multifd, where the simplest model could
> > look like this in my mind (I'm only discussing sender side, but it'll be
> > similar on recv side):
> >
> >                prepare()           send()
> >   Input   ----------------> IOVs ------------> iochannels
> >
> > [I used prepare/send, but please think them as generic terms, not 100%
> >  aligned with what we have with existing multifd_ops, or what you proposed
> >  later]
> >
> > Here what are sure, IMHO, is:
> >
> >   - We always can have some input data to dump; I didn't use "guest pages"
> >     just to say we may allow arbitrary data.  For any multifd user that
> >     would like to dump arbitrary data, they can already provide IOVs, so
> >     here input can be either "MultiFDPages_t" or "IOVs".
> 
> Or anything else, since the client code also has control over send(),
> no? So it could give multifd a pointer to some memory and then use
> send() to do whatever it wants with it. Multifd is just providing worker
> threads and "scheduling".

IOVs contain the case of one single buffer, where n_iovs==1.  Here I
mentioned IOVs explicitly because I want to make it part of the protocol so
that the interface might be clearer, on what is not changing, and what can
change for a multifd client.

> 
> Also note that multifd clients currently _do not_ provide IOVs. They
> merely provide data to multifd (p->pages) and then convert that data
> into IOVs at prepare(). This is different, because multifd currently
> holds that p->pages (and turns that into p->normal), which means the
> client code does not need to store the data across iterations (in the
> case of RAM which is iterative).

They provide?  AFAIU that's exactly MultiFDSendParams.iov as of now, while
iov_nums is the length.

> 
> >
> >   - We may always want to have IOVs to represent the buffers at some point,
> >     no matter what the input it
> >
> >   - We always flush the IOVs to iochannels; basically I want to say we can
> >     always assume the last layer is connecting to QIOChannel APIs, while I
> >     don't think there's outliers here so far, even if the send() may differ.
> >
> > Then _maybe_ it's clearer that we can have two layers of OPs?
> >
> >   - prepare(): it tells how the "input" will be converted into a scatter
> >     gatter list of buffers.  All compression methods fall into this afaiu.
> >     This has _nothing_ to do on how the buffers will be sent.  For
> >     arbitrary-typed input, this can already be a no-op since the IOVs
> >     provided can already be passed over to send().
> >
> >   - send(): how to dump the IOVs to the iochannels.  AFAIU this is motly
> >     only useful for fixed-ram migrations.
> >
> > Would this be clearer, rather than keep using a single multifd_ops?
> 
> Sorry, I don't see how what you describe is any different than what we
> have. And I don't see how any of this would mean more than one
> multifd_ops. We already have multifd_ops->prepare() and
> multifd_ops->send(). What am I missing?

I meant instead of having a single MultiFDMethods, we can have
MultifdPrepareOps and MultifdSendOps separately.

Now with single MultiFDMethods, it must always provide e.g. both prepare()
and send() in one set of OPs for one use case.  What I wanted to say is
maybe it is cleaner we split it into two OPs, then all the socket-based
scenarios can already stick with the same send() method, even though they
can prepare() differently.

IOW, for this base patchset to pave way for compression accelerators, IIUC
we don't need a send() yet so far?  Should they still work pretty well with
qio_channel_writev_full_all() with proper touchups on p->write_flags just
for zero copy purposes?

I'll have a read again to your previous multifd-packet-cleanups branch I
guess.  but this series definitely doesn't apply there already.

-- 
Peter Xu


