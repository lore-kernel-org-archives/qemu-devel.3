Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AC9C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErTX-0005um-FD; Wed, 05 Jun 2024 10:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sErTV-0005tn-Dk
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sErTQ-0006Un-SS
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717597119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bRZKTgkGzUvIG0oeuidyiEoMLSHlfuLt1pgrXPVvAQE=;
 b=GM6oGtSq/rH5Fe0N+UfwGtOvFE0LQ8iI98IobUr3rJ9ctyVQt6TTIzm6IgYN4JNczxKF+C
 9tmTEW8d785GX0MHMMCUnF3yYWXhGvvCs+ttglDI3JDLJGmR4TLsUkyoM0JTWYHylbsdm1
 w36ATrLNSV5sxOVbEcNjtE30jCUz9O8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-A63tmcLZPYmABBwpTuaEKA-1; Wed, 05 Jun 2024 10:18:38 -0400
X-MC-Unique: A63tmcLZPYmABBwpTuaEKA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-440267a8b1dso731931cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717597117; x=1718201917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRZKTgkGzUvIG0oeuidyiEoMLSHlfuLt1pgrXPVvAQE=;
 b=NIPIEXzhGaRTg2N4I4FLRPwohOKvCHVGODTnGAjiIpZKVdO1zckCs6ffQsAK6Ncxf2
 YkIOEd3CfmSB8AQdCnV/Znzq3Ot5o4cuaCO5WILoj92ZLrJbuUOxpf9LemhfAVDyk1nG
 j6IPVJT+DCazuo4Fll0RQ4EZBgO7+Zs3WVdOf1h9xA9LYLcpExYreUjffLLk9zf1N/dv
 w87xBN49XoHiqg6SN6z6fQl7aX0TMa23zHZJDHUCApqPFFinFV3kSTKb/O265zmykkJ8
 76EG45j0nF92+LX5zKD92LI4mdvWfWzFd/wQxZPaYoR5wv4L+w7TpcYlTWuxj0P7Hmkh
 436Q==
X-Gm-Message-State: AOJu0YxAkfC2YwoClJCnVTyDy7cZ1OCgUHg7HTuSTAfVz6AK3Zz2EYB0
 z9Oln4U2x4d45TjsihVnCC/sh0DFCkhMuvRG/TWHZ+ivk+pSk8X9OAIGhz9CHGoicAYXZ4dk//4
 7qda9USaprc4YmK0va613yCQbQgPsuUwP/uw+ldzPHO1nl7ZVTrKX
X-Received: by 2002:a05:620a:178a:b0:794:ef5d:9e92 with SMTP id
 af79cd13be357-79523fccf54mr240840485a.6.1717597117219; 
 Wed, 05 Jun 2024 07:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwqDmomDT2V2Zii7ReE37WLdt8xRgcYRFAWnJZE2fPfsZNEoL8MpkhLg/X4EA3WX+BbT/fA==
X-Received: by 2002:a05:620a:178a:b0:794:ef5d:9e92 with SMTP id
 af79cd13be357-79523fccf54mr240834485a.6.1717597116483; 
 Wed, 05 Jun 2024 07:18:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ffa80b70esm52876681cf.69.2024.06.05.07.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:18:35 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:18:34 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZmBzusHyxLYqMeQg@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zl9rw3Q9Z9A0iMYV@x1n>
 <de950e0e2cda4f8dacd15892a6328861@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de950e0e2cda4f8dacd15892a6328861@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 05, 2024 at 10:09:43AM +0000, Gonglei (Arei) wrote:
> Hi Peter,
> 
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, June 5, 2024 3:32 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; yu.zhang@ionos.com; mgalaxy@akamai.com;
> > elmar.gerdes@ionos.com; zhengchuan <zhengchuan@huawei.com>;
> > berrange@redhat.com; armbru@redhat.com; lizhijian@fujitsu.com;
> > pbonzini@redhat.com; mst@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>; Fabiano Rosas <farosas@suse.de>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > Hi, Lei, Jialin,
> > 
> > Thanks a lot for working on this!
> > 
> > I think we'll need to wait a bit on feedbacks from Jinpu and his team on RDMA
> > side, also Daniel for iochannels.  Also, please remember to copy Fabiano
> > Rosas in any relevant future posts.  We'd also like to know whether he has any
> > comments too.  I have him copied in this reply.
> > 
> > On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linar
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performance
> > > degradation, hoping that friends with RDMA network cards can help verify,
> > thank you!
> > 
> > It'll be good to elaborate if you tested it in-house. What people should expect
> > on the numbers exactly?  Is that okay from Huawei's POV?
> > 
> > Besides that, the code looks pretty good at a first glance to me.  Before
> > others chim in, here're some high level comments..
> > 
> > Firstly, can we avoid using coroutine when listen()?  Might be relevant when I
> > see that rdma_accept_incoming_migration() runs in a loop to do raccept(), but
> > would that also hang the qemu main loop even with the coroutine, before all
> > channels are ready?  I'm not a coroutine person, but I think the hope is that
> > we can make dest QEMU run in a thread in the future just like the src QEMU, so
> > the less coroutine the better in this path.
> > 
> 
> Because rsocket is set to non-blocking, raccept will return EAGAIN when no connection 
> is received, coroutine will yield, and will not hang the qemu main loop.

Ah that's ok.  And also I just noticed it may not be a big deal either as
long as we're before migration_incoming_process().

I'm wondering whether it can do it similarly like what we do with sockets
in qio_net_listener_set_client_func_full().  After all, rsocket wants to
mimic the socket API.  It'll make sense if rsocket code tries to match with
socket, or even reuse.

> 
> > I think I also left a comment elsewhere on whether it would be possible to allow
> > iochannels implement their own poll() functions to avoid the per-channel poll
> > thread that is proposed in this series.
> > 
> > https://lore.kernel.org/r/ZldY21xVExtiMddB@x1n
> > 
> 
> We noticed that, and it's a big operation. I'm not sure that's a better way.
> 
> > Personally I think even with the thread proposal it's better than the old rdma
> > code, but I just still want to double check with you guys.  E.g., maybe that just
> > won't work at all?  Again, that'll also be based on the fact that we move
> > migration incoming into a thread first to keep the dest QEMU main loop intact,
> > I think, but I hope we will reach that irrelevant of rdma, IOW it'll be nice to
> > happen even earlier if possible.
> > 
> Yep. This is a fairly big change, I wonder what other people's suggestions are?

Yes we can wait for others' opinions.  And btw I'm not asking for it and I
don't think it'll be a blocker for this approach to land, as I said this is
better than the current code so it's definitely an improvement to me.

I'm purely curious, because if you're not going to do it for rdma, maybe
someday I'll try to do that, and I want to know what "big change" could be
as I didn't dig further.  It may help me by sharing what issues you've found.

Thanks,

-- 
Peter Xu


