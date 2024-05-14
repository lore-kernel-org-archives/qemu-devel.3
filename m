Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE2EC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rrJ-0007X5-0t; Tue, 14 May 2024 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s6rrG-0007Wv-3e
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s6rrB-00086C-1g
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2gFxq6jfUi0Z1xgq+VIIno/a5p3dHs3M3FFoWVRp6o=;
 b=FN5uISemcJIMsNP35A75JWJ2eaaHv/Hg31aVEBWIxGzZ8rTkFMSWRw4/NOsiKj5W3hqd+o
 Nw6X+wHmyTLF6aOuYJkFUQFRxVREeJpcjshbAEoDm2jmPUcme5c5JPZ/9ufkQF8Vpxk9+J
 e3QNNqieccdgUMgFGI6RvoC8FEdl1Z8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-LwJW1CFkM--y1AKI3Dhskw-1; Tue, 14 May 2024 09:06:10 -0400
X-MC-Unique: LwJW1CFkM--y1AKI3Dhskw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a103d524fdso10764916d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691969; x=1716296769;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2gFxq6jfUi0Z1xgq+VIIno/a5p3dHs3M3FFoWVRp6o=;
 b=pmkaIpZdo9X7CGEdqwfLL/daHupb2lluZCX6Oxi+KbmI3BHT1DOIitapd0r5fNws+h
 pRXLrKdDQyqmMBYoJXq769TXpE71kOl6pfdJL5i916WOhaHmFabE/GjclYulEQx/OrNV
 yPdWlh6c90rUDDrHlvrRejrrIdaTpSRLa+E4iACLI1dt78wSog9w/8hBE83z3qtrIhqG
 ZVT15gEi6z1OuPgWtu1MEKUKEwW1laIt/vQW9iGrn7jJ1MUmeaj0QtlXYhDkauvZaUFq
 pxuI64Yg7QjKF1QMB5xykFWi7SiHqqB9roEw/KxGhnRHL29RSajg6UQ6Q23Lx5m4rPcx
 2puw==
X-Gm-Message-State: AOJu0YyR2oOFmOV0eSe7l/bilnJMlgcXRo9+CpkNYKMAc20nf6wkaYcj
 FHhh0k0IAQkMua/ENWRL30CaKQDJR7XLGVBEB5jrAZnPXGuxHOx+Tr2InKcKucreY38EROfHD1T
 DjV3sKWSmCCnEkHlmEW6OjZfEH2o2euwhOBif8cG0hd04CuvtPsiE
X-Received: by 2002:ad4:56e5:0:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6a1683816camr122964186d6.4.1715691968620; 
 Tue, 14 May 2024 06:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkUk4RIfo3g4evWbA7DjbM7myfdK7BQkkSK15I++GolGB5/vDFaMZGcXjndElRdITVn09NuQ==
X-Received: by 2002:ad4:56e5:0:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6a1683816camr122963766d6.4.1715691968004; 
 Tue, 14 May 2024 06:06:08 -0700 (PDT)
Received: from x1n ([67.214.252.166]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ccd42sm53033696d6.91.2024.05.14.06.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:06:07 -0700 (PDT)
Date: Tue, 14 May 2024 07:06:02 -0600
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 3/4] virtio-gpu: add x-vmstate-version
Message-ID: <ZkNhuvPcxTLalF69@x1n>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <20240513071905.499143-4-marcandre.lureau@redhat.com>
 <ZkLojVI4ZAKANIBr@x1n>
 <CAMxuvayd5X04dOSRMHYQr-NbHrwNeZLTD6wvNb2bq6c+-qU-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayd5X04dOSRMHYQr-NbHrwNeZLTD6wvNb2bq6c+-qU-9w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

On Tue, May 14, 2024 at 11:25:26AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, May 14, 2024 at 8:35 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hey, Marc-Andre,
> >
> > On Mon, May 13, 2024 at 11:19:04AM +0400, marcandre.lureau@redhat.com wrote:
> > > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > > index ae831b6b3e..7f9fb5eacc 100644
> > > --- a/hw/display/virtio-gpu.c
> > > +++ b/hw/display/virtio-gpu.c
> > > @@ -1234,7 +1234,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
> > >      }
> > >      qemu_put_be32(f, 0); /* end of list */
> > >
> > > -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
> > > +    return vmstate_save_state_v(f, &vmstate_virtio_gpu_scanouts, g,
> > > +                                NULL, g->vmstate_version, NULL);
> > >  }
> > >
> > >  static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> > > @@ -1339,7 +1340,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> > >      }
> > >
> > >      /* load & apply scanout state */
> > > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, g->vmstate_version);
> >
> > [sorry for a late response; attending a conf, and will reply to the v1
> >  thread later for the other discussions..]
> >
> > These two changes shouldn't be needed if we go with the .field_exists()
> > approach, am I right?  IIUC in that case we can keep the version 1 here and
> > don't boost anything, because we relied on the machine versions.
> >
> > IIUC this might be the reason why we found 9.0 mahines are broken on
> > migration.  E.g, IIUC my original patch should work for 9.0<->9.0 too.
> >
> 
> Indeed, but for consistency, shouldn't it use the x-vmstate-version
> value for the top-level VMSD save/load ?
> 
> Otherwise, it feels a bit odd that this x-vmstate-version is only used
> for the nested "virtio-gpu-one-scanout" version.
> 
> Or perhaps we should rename it to x-scanout-vmstate-version ? wdyt

Makes sense to me.  In another place I used to have a field called
preempt_pre_7_2.. which is pretty wierd but it would be more accurate I
suppose if the field name reflects how that was defined, especially
differenciate that v.s. VMSD versioning as they're confusing indeed when
used together.

So if a rename I suppose we can even "vmstate-version".  I just wished VMSD
versioning could work with bi-directional migration already then we save
all the fuss... we used to have the chance before introducing
field_exists() (I suppose this one came later), but we didn't care or
notice at that time, sign.  We'll just need a handshake between src/dst so
that when src sees dst uses VMSD v1 it sends v1-only fields even if it
knows as far as v2.

For the long run we may be able to have some small helper so we fetch the
machine type globally, then maybe we can in the future pass in the test
function as:

bool test_function (void *opaque)
{
  return MACHINE_TYPE_BEFORE(8, 2);
}

Then it'll also avoid even introducing a variable.  Maybe we can provide
this test_function() directly too, one for each release.

Thanks,

> 
> 
> > Thanks,
> >
> > >
> > >      return 0;
> > >  }
> > > @@ -1659,6 +1660,7 @@ static Property virtio_gpu_properties[] = {
> > >      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
> > >                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
> > >      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> > > +    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 1),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >
> > > --
> > > 2.41.0.28.gd7d8841f67
> > >
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu


