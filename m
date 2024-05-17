Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F77FC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 00:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7llN-0006j9-32; Thu, 16 May 2024 20:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s7llL-0006ix-EI
 for qemu-devel@nongnu.org; Thu, 16 May 2024 20:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s7llJ-0006Cg-Pm
 for qemu-devel@nongnu.org; Thu, 16 May 2024 20:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715906871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPOy1AzejaYpxJiajq+aNxAkF9kuYdTztv7JALrpWaE=;
 b=KImxtOQVdGaBpU95W//2Xy39ZamL77UICg7YSYviC0KbnRqwOvOMhFg7AEpIBpUKdsoWhl
 LqxMFm3qdqL//7UoAlD3EyB4SG8ckTQ31RgiVZoKoLNwkPmSgPBfhDZbjEHXy9gd24hooL
 jiy5ZL5/15kPwaCycbvYIRShTG1R9Bw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-nZkGM-YwMjeUgKb6lb2m3Q-1; Thu, 16 May 2024 20:47:49 -0400
X-MC-Unique: nZkGM-YwMjeUgKb6lb2m3Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b38e234a96so7717892a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 17:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715906868; x=1716511668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPOy1AzejaYpxJiajq+aNxAkF9kuYdTztv7JALrpWaE=;
 b=JAjeOdoEkd12CrGNxbPn4pt3JCD7omWaYKNWGy5KIzPG2Dl0WOfqmmB/tNixLRSCoY
 Mv8G+oIFO4qqfVDNecDXRNaSKWEGV3KmyATcm9QPrJP1IBYAOU3ZccxE34pwk7UjxIxh
 m6+xLZf0r5OQzvhtF4Zjvg0NBZmdBl6NAzFf/vz0ZjEbnBORp4QTH12EIqg6QJS793o+
 xecLYieoWRLaGDY9ebfCEX9rDXpyX+XA6WLhu+bxx6+8kOR8WiUOCY68rHDmh8bt7Oc9
 vkXWHtcvKc7jYvFTKqzQmBRjY+sIFpD+j5dVlEgXJh1PXZeAs61D9txxg9L81YcrsN15
 Ij/g==
X-Gm-Message-State: AOJu0YyPdeFkNR8xcB7FUnfYig8cFLgRhmK5tWeOn/mk/ozcSMGlB2zs
 +UO4JodUIy9usrT6nUzagHScSvw5Kqn7gsQLLTM2KobwkoXypYt2p52WSn6HmNiynx2AVACuGya
 jPb/niPJFlyR+0a+G0wM+1HH8aydkyYmz5E5RAph11AFpdo8o87N91NuNPeR3zybMZOrgibqyCa
 UmeC3eEt0+ahfX5pF87hfvSh28Z6I=
X-Received: by 2002:a17:90b:100d:b0:2b6:2ef4:e2aa with SMTP id
 98e67ed59e1d1-2b6cc780466mr16240725a91.25.1715906868417; 
 Thu, 16 May 2024 17:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6ACsTzMwvaOAtJ6KSc8nJDBJ/Jlj9S4locvHWa8Cigl51Zr/xzxQuwA5j8n0eFOyILTuo9MhQVnFoOiWP0cg=
X-Received: by 2002:a17:90b:100d:b0:2b6:2ef4:e2aa with SMTP id
 98e67ed59e1d1-2b6cc780466mr16240710a91.25.1715906868015; Thu, 16 May 2024
 17:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230908064507.14596-1-jasowang@redhat.com>
 <20230908064507.14596-5-jasowang@redhat.com>
 <f8d256a0-8719-4132-9304-afd214ed0ffa@proxmox.com>
In-Reply-To: <f8d256a0-8719-4132-9304-afd214ed0ffa@proxmox.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 May 2024 08:47:36 +0800
Message-ID: <CACGkMEtZrJuhof+hUGVRvLLQE+8nQE5XmSHpT0NAQ1EpnqfmsA@mail.gmail.com>
Subject: Re: [PULL 04/17] virtio-net: Add support for USO features
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychecnko <andrew@daynix.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

On Thu, May 16, 2024 at 9:51=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Hi,
>
> Am 08.09.23 um 08:44 schrieb Jason Wang:
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index da699cf..230aab8 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,6 +38,7 @@
> >  #include "exec/confidential-guest-support.h"
> >  #include "hw/virtio/virtio.h"
> >  #include "hw/virtio/virtio-pci.h"
> > +#include "hw/virtio/virtio-net.h"
> >
> >  GlobalProperty hw_compat_8_1[] =3D {};
> >  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > @@ -45,6 +46,9 @@ const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_co=
mpat_8_1);
> >  GlobalProperty hw_compat_8_0[] =3D {
> >      { "migration", "multifd-flush-after-each-section", "on"},
> >      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> > +    { TYPE_VIRTIO_NET, "host_uso", "off"},
> > +    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > +    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> >  };
> >  const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
> >
>
> unfortunately, this broke backwards migration with machine version 8.1
> from 8.2 and 9.0 binaries to a 8.1 binary:
>
> > kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179b=
fffe7
> > kvm: Failed to load virtio-net:virtio
> > kvm: error while loading state for instance 0x0 of device '0000:00:12.0=
/virtio-net'
> > kvm: load of migration failed: Operation not permitted
>
> Since the series here only landed in 8.2, shouldn't these flags have
> been added to hw_compat_8_1[] instead?

You are right. We need to put them into hw_compat_8_1[].

>
> Attempting to fix it by moving the flags will break migration with
> machine version 8.1 between patched 9.0 and unpatched 9.0 however :(

I'm sorry but I can't think of a way better.

>
> Is there anything that can be done or will it need to stay broken now?

Would you mind posting a patch to fix this and cc stable?

>
> CC-ing the migration maintainers.
>
> Best Regards,
> Fiona
>

Thanks


