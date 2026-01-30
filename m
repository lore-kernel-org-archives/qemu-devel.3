Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B37BE6BF11
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlpfW-0000p7-Vd; Fri, 30 Jan 2026 09:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vlpfW-0000ov-1N
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vlpfT-0001LC-B9
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769784008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1F//S4qvJUG4Gxyac0ZGTJyhAexVf6dShjt9kzeG/X0=;
 b=YjNxucu+6FGm74b3tOQIT1U2vvdOf4irmvn0+HSiiab8OlOVctdBFswzACULMe5Nkud2Hn
 UnRZh83d481Wptc2RqJ8GJLdAg5j1yjJW+o0DPy51TUGjTX9CbQpFxvY16HxjUcw4KYhyz
 2/Qq/uoE9MQBHqP4rXKkveX3XFtNTWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-DeOfdZ1rOeqni90T6-qYgg-1; Fri, 30 Jan 2026 09:40:07 -0500
X-MC-Unique: DeOfdZ1rOeqni90T6-qYgg-1
X-Mimecast-MFC-AGG-ID: DeOfdZ1rOeqni90T6-qYgg_1769784006
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806fce5ab1so13230565e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 06:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769784005; x=1770388805; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1F//S4qvJUG4Gxyac0ZGTJyhAexVf6dShjt9kzeG/X0=;
 b=PRyHoQbdbIv17KvTdxML7h6tyq2xtQ0UqvBPSbC1eqFI8024+oyYZgDshvqi9hzLe8
 Dhb+EYRrP+07mLjxSJJJdZsao8RUI6jYRWGP8AAfRIx7YDXqii+uiNs2qUJAxMojsrS3
 D1AKeGbiVpYqmgksYYIZbYnyTHHg0wfG8P92qxHzONPJE/VereSqzOKJv7AYdWb9u6ZB
 HqKmTAYmc0TjCitG5+B151agdMZOiPkQmmodUsOIXXMSriaq5TBtogYf3NRXlOePRiNE
 Q6VoWX1LMBXE5jkxcEigPo7xJU2RQJ6A3SUU+ECbBWpMZNnB8295iAF+ZdltfJhI5hBB
 G7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769784005; x=1770388805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1F//S4qvJUG4Gxyac0ZGTJyhAexVf6dShjt9kzeG/X0=;
 b=O7BX6Y5zAJW8qeC6vVeZPyMcTxK/OWgoGxFYR9GK1l6L6cqe2fOKumVuevSY4IJSHi
 cveBFHSgVCkN7sXgh/7G9cBYJsVveSIoDIGGOV925aiAW19BIR+x5YWfGRBZevTIYeti
 RplLiwzhVP3WONSvUi+TgJQ+YpatWaFKRpGIkHuAblSn6q+bjiOO1v5aL3iFeUZeowRV
 feLWaPdozjoFcqEX/URzxuq9cd4D/DMVvBJFRaWgaJk81rdF4wwTgQ51LAuk7oqDCmmM
 Rwmaa0pvgUTcCw9Vckg6VpCPw5aVW7+kShTCfA1RAW8BHk2ARs+lDtXv7mmVPgioqjkR
 gcjA==
X-Gm-Message-State: AOJu0YxyC+cgLb2fSmFumuM5BeumJUfoza0eRr6Lzsavo1pHdVYEyCFh
 Fe5Xo+lDM1xkuCqHmUMspJHR4TRbNslUmoYvUFNa3709TyexFT5ErdyERUI1kLXBKpUloYEVNxk
 cCBQ7tu4seazLthDkiEuRdb/fY6+0W2oOfVZjaXPoW+6vhYleHsCqbk26
X-Gm-Gg: AZuq6aIzQ4s892f4n/FuD3BHH5JhE0vk9PsDvgVjOp5PDQJa4l2NM9XrSx0SzXBqcwr
 ft67gNOIQV6CjrhpAVuDx5dW0OYHXZfRbJyP2ljV4FAPE/wprhbRPJkfv8NdlYOH7gIq7qI4yLB
 gOT1PwQnX25bOh9T7Sb+CBKx9kHHGJbl4yUQHxIYo7ysLI7sp3bAhwOq5KmboJTbVVqYsjvakKD
 138sbeNYdW5aFSptEjmk62/9FnkXV/ME17MX6YhXOZNzPxuE65DFK9tr6p+Jv5vTWpA7EkMx9wn
 3iDvE7HeMQnYqJWmYg6k+ZgmLVnu6Gi7ynnoeVhk0PQCUU9VkcNpQYHm7q9vC65HRA==
X-Received: by 2002:a05:600c:1d03:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-482db4521e1mr40305475e9.2.1769784004961; 
 Fri, 30 Jan 2026 06:40:04 -0800 (PST)
X-Received: by 2002:a05:600c:1d03:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-482db4521e1mr40305025e9.2.1769784004453; 
 Fri, 30 Jan 2026 06:40:04 -0800 (PST)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e047d863sm18463935e9.1.2026.01.30.06.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 06:40:03 -0800 (PST)
Date: Fri, 30 Jan 2026 15:40:01 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Laurent Vivier <laurent@vivier.eu>, 
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <66tveywu7fta7q3zswe3zksuadmmqjnn365ulv5tsb2k3m6i5b@mb6sjuzuukdb>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
 <4uwcjd7ov7ib6q5pelqle3bdouoctyoqteec5f222cjatwkqxf@3p2n5hgjuwzk>
 <20260128182739.64f60eba@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128182739.64f60eba@elisabeth>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Stefano,

thanks for the answer!

On 2026-01-28 18:27, Stefano Brivio wrote:
> On Wed, 28 Jan 2026 14:06:11 +0100
> Juraj Marcin <jmarcin@redhat.com> wrote:
> 
> > Hi Stefano,
> > 
> > On 2026-01-27 19:21, Stefano Brivio wrote:
> > > [Cc'ing Laurent and David]
> > > 
> > > On Tue, 27 Jan 2026 15:03:06 +0100
> > > Juraj Marcin <jmarcin@redhat.com> wrote:
> > >   
> > > > During switchover there is a period during which both source and
> > > > destination side VMs are paused. During this period, all network packets
> > > > are still routed to the source side, but it will never process them.
> > > > Once the destination resumes, it is not aware of these packets and they
> > > > are lost. This can cause packet loss in unreliable protocols and
> > > > extended delays due to retransmission in reliable protocols.
> > > > 
> > > > This series resolves this problem by caching packets received once the
> > > > source VM pauses and then passing and injecting them on the destination
> > > > side. This feature is implemented in the last patch. The caching and
> > > > injecting is implemented using network filter interface and should work
> > > > with any backend with vhost=off, but only TAP network backend was
> > > > explicitly tested.  
> > > 
> > > I haven't had a chance to try this change with passt(1) yet (the
> > > backend can be enabled using "-net passt" or by starting it
> > > separately).
> > > 
> > > Given that passt implements migration on its own (in deeper detail in
> > > some sense, as TCP connections are preserved if IP addresses match), I
> > > wonder if it this might affect or break it somehow.
> > > 
> > > Did you perhaps have some thoughts about that already?  
> > 
> > I'm aware of passt migrating its state and passt-repair, but I also
> > haven't tested it as I couldn't get passt-repair to work.
> 
> Oops. Let me know if you're hitting any specific error I could look
> into.

I tried it using this documentation [1] I found earlier, however, it
wouldn't work when migrating on the same host as I expected from it. The
destination passt process fails to get the port the outside TCP server
is communicating with and I see the connection still as established with
the source passt process. This is the specific error message from the
destination passt process:

    Flow 0 (TCP connection): Failed to connect migrated socket: Cannot assign requested address

[1]: https://www.qemu.org/docs/master/system/devices/net.html#example-of-migration-of-a-guest-on-the-same-host

> 
> I plan anyway to try out your changes but I might need a couple of days
> before I find the time.
> 
> > Does it also handle other protocols, or just preserves TCP connections?
> 
> Layer-4-wise, we have an internal representation of UDP "flows"
> (observed flows of packets for which we preserve the same source port
> mapping, with timeouts) and we had a vague idea of migrating those as
> well, but it's debatable where there's any benefit from it.
> 
> At Layer 2 and 3, we migrate IP and MAC addresses we observed from the
> guest:
> 
>   https://passt.top/passt/tree/migrate.c?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n31
> 
> so that we have ARP and NDP resolution, as well as any NAT
> mapping working right away as needed.
> 
> For completeness, this is the TCP context we migrate instead:
> 
>   https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n108
>   https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n154
> 
> > The main focus of this feature are protocols that cannot handle packet
> > loss on their own in environments where IP address is preserved (and
> > thus also TCP connections).
> 
> Well, strictly speaking, TCP handles packet loss, that's actually the
> main reason behind it. I guess this is to improve throughput and avoid
> latency spikes or retransmissions that could be avoided?

Sorry, I actually meant that all connections are preserved. The main
goal is to prevent losses with protocols other than TCP when possible,
which was requested by our Solution Architects. Possible improved TCP
throughput due to avoided retransmissions is just a side effect of that.

> 
> > So, mainly tap/bridge, with the idea that
> > other network backends could also benefit from it. However, if it causes
> > problems with other backends, I could limit it just to tap.
> 
> I couldn't quite figure out yet if it's beneficial, useless, or
> harmless for passt. With passt, what happens without your
> implementation is:
> 
> 1. guest pauses
> 
> 2. the source instance of passt starts migrating, meaning that sockets
>    are frozen one by one, their receiving and sending queues dumped
> 
> 3. pending queues are sent to the target instance of passt, which opens
>    sockets as refills queues as needed
> 
> 4. target guest resumes and will get any traffic that was received by
>    the source instance of passt between 1. and 2.
> 
> Right now there's still a Linux kernel issue we observed (see also
> https://pad.passt.top/p/TcpRepairTodo, that's line 4 there) which might
> cause segments to be received (and acknowledged!) on sockets of the
> source instance of passt for a small time period *after* we freeze them
> with TCP_REPAIR (that is, TCP_REPAIR doesn't really freeze the queue).
> 
> I'm currently working on a proper fix for that. Until then, point 2.
> above isn't entirely accurate (but it only happens if you hammer it
> with traffic generators, it's not really visible otherwise).
> 
> With your implementation, I guess:
> 
> 1. guest pauses
> 
> 2. the source instance of passt starts migrating, meaning that sockets
>    are frozen one by one, their receiving and sending queues dumped
> 
> 2a. any data received by QEMU after 1. will be stored and forwarded to
>     the target later. But passt at this point prevents the guest from
>     getting any data, so there should be no data involved
> 
> 3. pending queues are sent to the target instance of passt, which opens
>    sockets as refills queues as needed
> 
> 3a. the target guest gets the data from 2a. As long as there's no data
>     (as I'm assuming), there should be no change. If there's data coming
>     in at this point, we risk that sequences don't match anymore? I'm not
>     sure
> 
> 4. target guest resumes and will *also* get any traffic that was received
>    by the source instance of passt between 1. and 2.
> 
> So if my assumption from 2a. above holds, it should be useless, but
> harmless.
> 
> Would your implementation help with the kernel glitch we're currently
> observing? I don't think so, because your implementation would only play
> a role between passt and QEMU, and we don't have issues there.
> 
> Well, it would be good to try things out. Other than that, unless I'm
> missing something, your implementation should probably be skipped for
> passt for simplicity, and also to avoid negatively affecting downtime.

I agree with skipping passt in such case, although, I haven't perceived
any effect on downtime. Cached network packets are sent after the
destination resumes, so that the network knows about new location of the
VM and the source shouldn't receive any more packets intended for it.

> 
> Note that you can also use passt without "-net passt" (that's actually
> quite recent) but with a tap back-end. Migration is only supported with
> vhost-user enabled though, and as far as I understand your implementation
> is disabled in that case?

As of now it is disabled in that case as network filters don't support
vhost.

> 
> -- 
> Stefano

-- 
Juraj Marcin


