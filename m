Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3BCD25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 13:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl5vW-0005Iv-4C; Wed, 28 Jan 2026 08:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vl5vR-0005HU-EP
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 08:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vl5vP-00027W-98
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 08:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769608176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVcqnXiVv5ZuNoCGDH9ohds5DTgLVTm/6BRniTnonFc=;
 b=L+MzpMxuZXiVWfN7zz+J5pLdofbzcYs/jtL/7Effmy1HQnQKQVb7mmGklsse01Y6RVuZla
 EwkFMhefxECWMCDAIty9bXI9IFEvtISMTyOpJU4IEotmaWe4k7yxQIury8FHnPx4++TKS0
 GoPTCNmUWXvhLalGxqQhqk5wsGzh0us=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-YWGNz8P1PYOnhG76hrKXgA-1; Wed, 28 Jan 2026 08:49:35 -0500
X-MC-Unique: YWGNz8P1PYOnhG76hrKXgA-1
X-Mimecast-MFC-AGG-ID: YWGNz8P1PYOnhG76hrKXgA_1769608174
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8db7f340b3so185584066b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769608174; x=1770212974; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bVcqnXiVv5ZuNoCGDH9ohds5DTgLVTm/6BRniTnonFc=;
 b=hXG8Hk8ISden9842fAy3nuPR2s4NgrPODyty/B+uNIBNTegtpljWb0Ton89+V+XY0Y
 HxIa7Muj4Q8NLMwkZ9F/wWoxTFOajkVMGeO9Xrq4aUVma0Yo20SsD1mYv74QtiT0ndEH
 vml3PdJUCQmBklwSMCcA0oqmYQ2B+5/DTFPRNqCTvtyzQNovVpSijB2nNR9NLVL7wq8+
 IXS+KhJhoKOoDuXkwsduiTNgnR5sszmWiSfmsega4IlF/4jmNiNsBvtGbha6/Duz+BEF
 b2ST/yGuoeD4MfuMXTbzFSAwAXVrks23QI8dOe0/A/Tiq4wi8noqLVPPtsWQv4qunGZ5
 wgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608174; x=1770212974;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVcqnXiVv5ZuNoCGDH9ohds5DTgLVTm/6BRniTnonFc=;
 b=kwVKX5KDyHY0l8mmaVJaKWxF5YoCo7yIQEYan2RtWtWpRqRTf1sB8l6R4Q7+eUgMn8
 21zij9hpFJiqtc+RElYqvRiQti/0SImHZDtrYUSqVcS8GeFoDpGVvrK5VHIykm94YilS
 xphjsu8uaiTLjEnVJh6ehgHMjssqPP9YRLW5eodbvjl4dl/sHfmAY5F444EaPtHzUSvb
 gVew6KSg2bKP2Dwh9jxcTaDdsYgfoo7zJTK3my0lrKxf8aNE/jLaZlIyml4wmbUZZ5Zq
 JNbEBTkUyoA32vNHWuBKW/8VsoP200T6c0vr7da8cJPGZTJpVeK0uNYaYw/YiC659/YV
 VhmA==
X-Gm-Message-State: AOJu0YzP7Z09wdy9aM1px+DDQMoIVqaTeKAWCb1xW5Y/frG8NWpht5mD
 p4Mcp+U8QhDRZiaYKGvcdvNs9/oiecJv8OH+3yw3UPUtxxJ5Cbiuqr1DlJjcodThwkxZXvgx543
 qG0Ez4QbERXcmxEAbcURyM6AbasYzQMr5bTihkPD/gknnBM38M5Rm9aqi
X-Gm-Gg: AZuq6aJIPRgWiKsYrv3Um3TM54Fshcy4XAoDQgtM99XO49uDHaZexNYO+jy1slF1Wx5
 P8vB/leaQoETNqXNWMKfzCpmGzixvNmi+5jg3iAiojfaieXUts+OXWIDaTr84nI8E5+mFp+OYTN
 EH92en/shJSYCc1m3SM+I53M+wUtyZ3Gv8XKchljx6WlU524AZpi+eRsqnuJPaXHkNG70S49guk
 UN/ZGv5oLjUI3+iSaQ2ZRujpneEhM0Xql9l7DEqzQVEU8OTAmbxKFiryDMdn7qVbJ/u3zNZz0nU
 2PnBzGqtwez5qFXS1CnJuKwLLPjRK1yVjuoj0jiigUtQ/EoMOWOAWyCnBy7MQjBiFw==
X-Received: by 2002:a17:906:dc93:b0:b87:bb45:bd5a with SMTP id
 a640c23a62f3a-b8dab361923mr402808866b.27.1769608173915; 
 Wed, 28 Jan 2026 05:49:33 -0800 (PST)
X-Received: by 2002:a17:906:dc93:b0:b87:bb45:bd5a with SMTP id
 a640c23a62f3a-b8dab361923mr402806466b.27.1769608173392; 
 Wed, 28 Jan 2026 05:49:33 -0800 (PST)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbef86deesm129324166b.3.2026.01.28.05.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 05:49:32 -0800 (PST)
Date: Wed, 28 Jan 2026 14:49:30 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cindy Lu <lulu@redhat.com>, Zhang Chen <zhangckid@gmail.com>, 
 eperezma <eperezma@redhat.com>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <fpo57gscqhtcpdomfrwadexd3ierhmax4dqflqzfsuazo2secu@2em7v5gw7vmr>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Jason,

On 2026-01-28 10:55, Jason Wang wrote:
> On Tue, Jan 27, 2026 at 10:04 PM Juraj Marcin <jmarcin@redhat.com> wrote:
> >
> > From: Juraj Marcin <jmarcin@redhat.com>
> >
> > During migration switchover both the source and the destination machines
> > are paused (compute downtime). During this period network still routes
> > network packets to the source machine, as this is the last place where
> > the recipient MAC address has been seen. Once the destination side
> > starts and sends network announcement, all subsequent frames are routed
> > correctly. However, frames delivered to the source machine are never
> > processed and lost. This causes also a network downtime with roughly the
> > same duration as compute downtime.
> >
> > This can cause problems not only for protocols that cannot handle packet
> > loss, but can also introduce delays in protocols that can handle them.
> >
> > To resolve this, this feature instantiates a network filter for each
> > network backend present during migration setup on both migration sides.
> > On the source side, this filter caches all packets received from the
> > backend during switchover. Once the destination machine starts, all
> > cached packets are sent through the migration channel and the respective
> > filter object on the destination side injects them to the NIC attached
> > to the backend.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  include/migration/vmstate.h |   6 +
> >  include/net/net.h           |   5 +
> >  migration/meson.build       |   1 +
> >  migration/migration.c       |  49 ++++++-
> >  migration/migration.h       |   2 +
> >  migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++++++
> >  migration/netpass.h         |  14 ++
> >  migration/options.c         |  21 +++
> >  migration/options.h         |   1 +
> >  migration/savevm.c          |  37 ++++++
> >  migration/savevm.h          |   2 +
> >  migration/trace-events      |   9 ++
> >  net/net.c                   |  11 ++
> >  net/tap.c                   |  11 +-
> >  qapi/migration.json         |   7 +-
> >  15 files changed, 418 insertions(+), 4 deletions(-)
> >  create mode 100644 migration/netpass.c
> >  create mode 100644 migration/netpass.h
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 62d7e9fe38..7987e6c85a 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -200,6 +200,12 @@ typedef enum {
> >       * save_setup() in VMSD structures.
> >       */
> >      VMS_PHASE_EARLY_SETUP,
> > +    /*
> > +     * Specifies a netpass VMSD, these devices are copied right after the
> > +     * destination is started regardless of precopy/postcopy. Failure in this
> > +     * phase does not fail the migration in case of precopy.
> > +     */
> > +    VMS_PHASE_NETPASS,
> >  } VMStateSavePhase;
> >
> >  struct VMStateDescription {
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 45bc86fc86..510908845b 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -82,6 +82,7 @@ typedef void (NetAnnounce)(NetClientState *);
> >  typedef bool (SetSteeringEBPF)(NetClientState *, int);
> >  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
> >  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
> > +typedef void (NetpassEnabledNotify)(NetClientState *nc, void *opaque);
> >
> >  typedef struct NetClientInfo {
> >      NetClientDriver type;
> > @@ -130,6 +131,9 @@ struct NetClientState {
> >      bool is_netdev;
> >      bool do_not_pad; /* do not pad to the minimum ethernet frame length */
> >      bool is_datapath;
> > +    bool netpass_enabled;
> > +    NetpassEnabledNotify *netpass_enabled_notify;
> > +    void *netpass_enabled_notify_opaque;
> >      QTAILQ_HEAD(, NetFilterState) filters;
> >  };
> >
> 
> Adding Cindy, Eugenio can Chen.
> 
> I think we can simple reuse the existing filters:
> 
> redirector: which can redirect traffic from the source to the
> destination via chardev
> buffer: which can hold the packets until the destination is released
> 
> And let the libvirt install/uninstall those filters at the correct time.
> 
> Which means:
> 
> On the source: there would be a redirector that can be enabled when vm
> is paused, and it redirect the traffic to a socket/chardev
> On the destination: there would be a redirector as well as the buffer,
> redirector receives packets from the socket and send it to buffer,
> buffer will hold those packets until VM in the destination is resumed.
> 
> The current filters need some tweaks (e.g letting filters (redirector)
> work when VM is paused). The advantages of this are:

I tested the idea of filters for the forwarding using the existing
filters first and it does work with mentioned tweaks, however this
requires additional channel between chardevs attached to filters.

In my opinion it was better to reuse already existing migration channel,
so there are no necessary changes in higher layers. Furthermore, by
implementing this directly in QEMU, this feature can be used anywhere,
even if libvirt is not used.

> 
> 1) reuse the existing filters
> 2) don't need to care about the vhost support on the source as vhost
> is disabled, for vDPA we can reuse shadow virtqueue

Can you elaborate more on vhost being disabled? IUUC QEMU net filters
don't support vhost=on, including the redirector filter.

> 3) for the destination we can install a redirector to packet socket to
> let vhost works like socket -> redirector -> buffer -> redirector ->
> packet socket.
> 
> Thanks
> 


