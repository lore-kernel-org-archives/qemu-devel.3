Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E93E87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJAl-0004Ma-OY; Tue, 03 Feb 2026 11:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJAj-0004Lb-UC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJAi-0008J2-67
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770135753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAMrTRvKkncemIehLRAdN+PzjanyKU+JKO014ihsYJw=;
 b=MxnSolU4/ZiyW3DjTYkNUt/f14R3En/DkDO3TEVd1nehOmuJPDZWxwfBZXJGQ8GCwp9ko7
 D6KkvwU+IWSVvlAuPlvc5C7YoWzZgEyOj1jHtqyndhZcSHQcoq5n8wsFJwoX1aXBCo+NRW
 1jJrETyDdWivAbyA6Z+dFxFp9+JyzgU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-q7dqPilLP7ukh841StsMtg-1; Tue, 03 Feb 2026 11:22:31 -0500
X-MC-Unique: q7dqPilLP7ukh841StsMtg-1
X-Mimecast-MFC-AGG-ID: q7dqPilLP7ukh841StsMtg_1770135751
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cd00e02so30688485e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770135750; x=1770740550; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DAMrTRvKkncemIehLRAdN+PzjanyKU+JKO014ihsYJw=;
 b=I7xbcIu87nWkgVsEOBFcL4irsHiWflgKDqhNksGDO4u9f1vO62tQIJIif9EDi9HS9d
 kfZAwzfX1uVvm6kx/9bPkW3aHPmGD/X6IHgTh+6AlaaCrF19dxB04gTo8+W53De3zvxq
 Y06TJDgRgAjNaj7DvtuTXgfWOlW5xIqdINDmbZ66pj1P2wlvqoIDSgh0Dll1eNMVpy0P
 YsMRW6mAwUWMuPvjJZLb4X2AwN+/u9Qlq0HMNbtlPbUteZgqjudYsPft4EcLWxXhmc70
 robtnuF0tImGy6VQMZKryARZTcsnV+KpY/4xQnhpDZreC4I2NyEBkj4/b8wgD0h3Sejh
 P9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770135750; x=1770740550;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DAMrTRvKkncemIehLRAdN+PzjanyKU+JKO014ihsYJw=;
 b=ae7sLGWj/SKcMoN3Y6UKAo32GWCbIvcdE/na1aWW7e/a3ZVSgm+M9pMmCZpern1cHj
 s+zvaAcQZmMWVb3S4DcDHzBu2sL3mwzjH2NwFUzvulszy+Tp7Rb0UvGq1ZsUCsv2kWxm
 BCXw4EFEQXqRRcqoMWhDB+XLfGPggG34TNLa0AEH2xdzKdhDIHvGuXBr1Aben69s1mrX
 zpXNxo6u14S8sAHs/PT0FeDjhUhMzrIjuHFaTB4pVswEmLpnBkVp3t4cn05SVNe/pImY
 el54XPHOf+zdk9BgHF+O9Kl7SZXZEefojbTrPY4qiVIvgYvX3nJSfn37z3ClG55lmZI8
 UIhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+uGs6oeDwZcUspQeS/GG/Yh9OudtCGB+YmFVnl0m44mVezP5xQweH4EoHS4j9hLx7MD72/16nw8DZ@nongnu.org
X-Gm-Message-State: AOJu0Yzbrju6nTy1nrN6GqJTOBEWEuMAw1FB700E+pSbc9y83f0IfK7t
 NkJGEpCRN7V9oVK6WCKdcOOu1pw/Q4GV+K0XibuoZu46pOvcrEqtDNiDqh6Mu4e1gcvmF05dSsc
 Pp4aWLwr8FVDvSDihNoBtZrjT4IBnGLJtA8Xx6f/p77K2FWPokEBf0dzr
X-Gm-Gg: AZuq6aLplUH0iUOAf91CGAq0fxrwH1Wb0EwXobDexUJwN5RuSJEDJPA4gqRG4ULsaPl
 fo08fGr3JeeYCvJvvH1aNYDHc1Td+e8bwYonVkwUNK85ptJuFB5xYcZUHqg/n12qElL6tfT0GCJ
 eW4gUIsn1BiXmPzKVlC4cETuHaTo/FVHb8zE0WVoJovw4TxKoI2pKHV33pZMIkNTGl7j72wCTiu
 VshRCJKi/RuCl8l1oKjlqaBdQbdADcmy+F653bu0nI5H2b4JkEyWVR03qkgbsD4W5XLlkWVNfwh
 mS/w6phs+LWIuGG/r/hL6apbujEz1dWTawylF+cnQN1QWRB7ZQztquD4ALlVlMVH7mHXfKmuWOw
 KHeCRhHLKrJHRef0RhVqCR2rZbZDHjjoq5A==
X-Received: by 2002:a05:600c:3552:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-4830e923ff0mr2924205e9.2.1770135750373; 
 Tue, 03 Feb 2026 08:22:30 -0800 (PST)
X-Received: by 2002:a05:600c:3552:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-4830e923ff0mr2923805e9.2.1770135749853; 
 Tue, 03 Feb 2026 08:22:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830515381esm76643915e9.11.2026.02.03.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 08:22:29 -0800 (PST)
Date: Tue, 3 Feb 2026 11:22:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Wafer Xie <wafer@jaguarmicro.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] vdpa: fix cannot get vring base when stopping a
 vhost-vdpa device with multiple queues
Message-ID: <20260203112213-mutt-send-email-mst@kernel.org>
References: <20251029125001.15086-1-wafer@jaguarmicro.com>
 <CAJaqyWf+YxQAxM3e0H2Er=dYSbGHhadJQ5n=Lj_b4Ufa4z=HYg@mail.gmail.com>
 <20260203084017-mutt-send-email-mst@kernel.org>
 <CAJaqyWees4dzY1pm5KfLiJ0j5zZnW38YhCXk3f4Yj5ff2Xb8Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWees4dzY1pm5KfLiJ0j5zZnW38YhCXk3f4Yj5ff2Xb8Xg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Feb 03, 2026 at 02:56:19PM +0100, Eugenio Perez Martin wrote:
> On Tue, Feb 3, 2026 at 2:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 06, 2025 at 09:04:46AM +0100, Eugenio Perez Martin wrote:
> > > On Wed, Oct 29, 2025 at 1:50 PM Wafer Xie <wafer@jaguarmicro.com> wrote:
> > > >
> > > > When stopping a vhost-vdpa device, only the first queue pair is marked as suspended,
> > > > while the remaining queues are not updated to the suspended state.
> > > > As a result, when stopping a multi-queue vhost-vdpa device,
> > > > the following error message will be printed.
> > > >
> > > > qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not permitted (1)
> > > >
> > > > qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not permitted (1)
> > > >
> > > > Fixes: b6662cb7 ("vdpa: add vhost_vdpa->suspended parameter")
> > > >
> > > > Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> > > > ---
> > > >  hw/virtio/vhost-vdpa.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > > index 7061b6e1a3..2d5e6aca74 100644
> > > > --- a/hw/virtio/vhost-vdpa.c
> > > > +++ b/hw/virtio/vhost-vdpa.c
> > > > @@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
> > > >          return 0;
> > > >      }
> > > >
> > > > -    if (!v->suspended) {
> > > > +    if (!v->suspended && vhost_vdpa_first_dev(dev)) {
> > >
> > > I'm sorry I missed this fix!
> > >
> > > Good catch, thank you very much! But the right fix is to move
> > > v->suspended to v->shared, and then all the vhost_vdpa devices cannot
> > > have different suspended states.
> > >
> > > Apart from that, please include the tag
> > >
> > > Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")
> > >
> > > In the patch description.
> > >
> > > Thanks!
> >
> >
> > Eugenio do you want to post the fix?
> >
> 
> Wafer posted it some time ago, but I realize now it was posted with a
> different subject:
> 
> https://mail.gnu.org/archive/html/qemu-devel/2025-11/msg02947.html


Oh right that one is tagged. Thanks!


