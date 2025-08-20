Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D298CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 07:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uod2o-0003iN-BI; Wed, 20 Aug 2025 03:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uod2m-0003iC-7v
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 03:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uod2j-0000n3-CX
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755674130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbU6thMpQGWxh7wRUEqQHqJ2WLq54MSGebbHU77F+0Y=;
 b=a0ghoZ8Y0JTRVWkGYt1rTI69o7qGZ83RRbAafK09Zb13FQI+RdDIZoXvCmNda4jR5oRHEU
 mxPgrOkpcbgRJEvEwtBirRhGLCTjoKP8GL1+YcEvoDIMhAHnia1g47dY77DG2cntX1GLUi
 0BYKGcPKUCWa2UWbjstD5Qj+jrfVQ/I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-Yf6_JO3qN9Ck0_31Xll5ig-1; Wed, 20 Aug 2025 03:15:28 -0400
X-MC-Unique: Yf6_JO3qN9Ck0_31Xll5ig-1
X-Mimecast-MFC-AGG-ID: Yf6_JO3qN9Ck0_31Xll5ig_1755674127
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3232669f95eso6078567a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 00:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755674127; x=1756278927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbU6thMpQGWxh7wRUEqQHqJ2WLq54MSGebbHU77F+0Y=;
 b=rkt+ay7bsP4nfxvbqLWqO1UkflY2vJ4bOh7vnKzOu6qdUq8TRePMyM3ofgV2dkkMpe
 YSugs2UfSMQN+iiBsN+PIsm42JiVtti9hexvFXQ1jnVQnzZOllRW82QMYS7Gi004ctR8
 4A6umKiWAKga9jQoahOrlLLgMyxccOmQGSQEnbiawh0jbSg9Un+jQvryx9vwLHt6fNo5
 j8Q4yW7inBjqUWQeewImzeVhNtAm4xhr3fqMcsVDzH3oacB7Q9TXL1DOeWTPJxrkWyuY
 ryfgYnoFsNk2vq8TxCOOvoP2ad3rJ2/Tygm1pl/XPfZ1Kb9QGY+aZd0njYSiH2FgUzsu
 +SzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXF3MLUEPm9IsH4+XeNBr3YTO/nMwAYICoU8C0MDcNFGD5rXrUSk689i3gV3P/DgLYLXDEyUB54o8@nongnu.org
X-Gm-Message-State: AOJu0YzcZ40sbbVOMBzCO9T2UnlSUmyicbMXQxictco68xjY8CSH3zxp
 6qgVN+5sbgBHKiLXEMm/oLxUjZYTdNILY3fxyvgwXc60YJ5PdeTew2zL3IfWyylo6+v8sXy02d5
 RlgOLQmTR6iHycKWpeDREDxYJpvCbjqPPmx5/GlVktjR+rTbzzhCrfd14KLY3z5oPTdC7QAUBDC
 UDbCvfh6r9xr/DE6qKmQrXQF/lCJsJEFk=
X-Gm-Gg: ASbGncvlYX3Fhdpo7Eb9b6rXIvO1ru4EpyNTW47pkOrDifJ7jUW89zwpnWWEMhl2ufD
 iF0ySiasPGhnkiwEmmmabtDe6ZavGmAk9l6LAuHkRERSLEopI1xIUvwxJrseSyTTsHM/60soCO3
 sDAhDsVLlLrN3gWLTNIXk=
X-Received: by 2002:a17:90b:5445:b0:323:28cb:264a with SMTP id
 98e67ed59e1d1-324e133a28emr2294958a91.13.1755674127208; 
 Wed, 20 Aug 2025 00:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgS7YjSGoftFyf29j9I+tXqRDiYFkaSrfgJ2+vtsJTvw7TZ3no3Qcc0qhvNsVSyXI0My1hT09MKKrRPmA+EUE=
X-Received: by 2002:a17:90b:5445:b0:323:28cb:264a with SMTP id
 98e67ed59e1d1-324e133a28emr2294939a91.13.1755674126715; Wed, 20 Aug 2025
 00:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250310122240.2908-1-jasowang@redhat.com>
 <20250310122240.2908-3-jasowang@redhat.com>
 <29e31b2d06036441ede4ccb2d2bd22a6c1ba33ae.camel@infradead.org>
 <CACGkMEsuE8HC=s2HTWj+p=T8haOxHPhSj6w4==k-pvzKjwrKqw@mail.gmail.com>
 <c9524ced9c39e688372c332f909d84c6853e1983.camel@infradead.org>
In-Reply-To: <c9524ced9c39e688372c332f909d84c6853e1983.camel@infradead.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Aug 2025 09:14:50 +0200
X-Gm-Features: Ac12FXyK-1Iopp1LpK1oT_18CpqWo7bbuTqTrCUPYhFpw-_ZRsO-zPLUzRzN3H4
Message-ID: <CAJaqyWe0dawXryB+B8HYuQJ9mcDhCT_3H8vkJMwZyjKnLHQouw@mail.gmail.com>
Subject: Re: [PULL 2/5] net: move backend cleanup to NIC cleanup
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 qemu-devel@nongnu.org, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 20, 2025 at 8:47=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Wed, 2025-08-20 at 10:34 +0800, Jason Wang wrote:
> > On Wed, Aug 20, 2025 at 12:13=E2=80=AFAM David Woodhouse <dwmw2@infrade=
ad.org> wrote:
> > >
> > > On Mon, 2025-03-10 at 20:22 +0800, Jason Wang wrote:
> > > > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >
> > > > Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> > > > structures if peer nic is present") effectively delayed the backend
> > > > cleanup, allowing the frontend or the guest to access it resources =
as
> > > > long as the frontend is still visible to the guest.
> > > >
> > > > However it does not clean up the resources until the qemu process i=
s
> > > > over.  This causes an effective leak if the device is deleted with
> > > > device_del, as there is no way to close the vdpa device.  This make=
s
> > > > impossible to re-add that device to this or other QEMU instances un=
til
> > > > the first instance of QEMU is finished.
> > > >
> > > > Move the cleanup from qemu_cleanup to the NIC deletion and to
> > > > net_cleanup.
> > > >
> > > > Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net s=
tructures if peer nic is present")
> > > > Reported-by: Lei Yang <leiyang@redhat.com>
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > This crashes QEMU when I launch an emulated Xen guest with a Xen PV
> > > NIC, and quit (using Ctrl-A x on the monitor).
> >
> > Eugenio and Jonah, any thoughts on this? It looks like the code
> > doesn't deal with hub correctly.
>
> The interesting part about Xen netback is that it does its own teardown
> from xen_device_unrealize() because in the case of running under true
> Xen, it needs to clean up XenStore nodes which are externally visible.
> It doesn't all just go away when QEMU exits.
>
> We fixed a potentially similar issue in commit 84f85eb95f14a ("net: do
> not delete nics in net_cleanup()")?
>

I was not aware of that code to be honest :(.

Jonah, could you take a look at this? It should be a matter of
replicating what the series does in the list on NICs, in this linked
list.

Thanks!


