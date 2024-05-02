Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB32C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 06:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Pzr-0001JF-Mb; Thu, 02 May 2024 02:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2Pza-0001HV-6A
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:32:33 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2PzY-0003Zn-Gm
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:32:29 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57232e47a81so2446644a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714631544; x=1715236344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EYclx16HNFs8YntLtI93PesjTHQNuEjlTaisfuEtSc=;
 b=OAv90L0AjJS53oQkWLoHeQDatH8eEYq51dUcRjIr/ty+cKSI7EflV6y8agTf73iZM4
 643O36RsHkzz1qVVk3Iq9VB02RPrxQCbmNPrqdX0+GZSCyFG9Emqg6QUvnRXjTdinDcw
 JyVAFE1HKf3svCohz6vOPA5fAVpr3pWyZobSEI6n9OPp00XRgthTJ818wCQ0PF9T/Kls
 EKEV2YTqUuEILoIguDX13fMo3uGILI0z05P6JMuN77OHV67NpBkuyYMTimOZf2OAd6Br
 ZW4EiAGfhQyPyDhlSkZ+hyCjl0vU2buZ2sREkRDwbJaq4IiRyDum8uvEKrkBKXlA1IJD
 4Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714631544; x=1715236344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EYclx16HNFs8YntLtI93PesjTHQNuEjlTaisfuEtSc=;
 b=rxaODe5XFP8G1koLLoP8gylCcT1BUsJr9CgMlU+xOZObjuywWPEP5KFMlxqtrPeYCY
 sApPD5YfULNV4xLwFRZ2+TZzM0SMkkksQZ9qLdSBXYf29u/PFeR8EK15tfKsuhF2ITJF
 VlgH6e09/+riWHt89/p3orDc9KLN9mbY3gEiVCam+6DTvfYIRMfPugzCb0seVnMo3Cyw
 WF5UZ3Jw+sXgf87QdgocMtgbBKqsDpai4LTf5pe8BSm7Fl6kTXkiRBM6/99XUE9Qjm4O
 dy+AAKmmFn/De58eipo4H+imQw3JiCoUvxlAggshm5tVWFvKODekLtRGk9le72skKMkK
 JWew==
X-Gm-Message-State: AOJu0Yz1uu+c5VBPfHZvOnVqF8DkfP++8/ze48sIzLcp3Mb6ebin7y87
 4z85qbW5QBaYPWa/Ju3DvLRArlcTYHmc4RlvsaKM5eDMhWv44re7q+3Jan7EZ3JZMOfiMrDzQqT
 Z8C7Y3gQZuqxtJ6rYLKm8Q5bp9bc=
X-Google-Smtp-Source: AGHT+IHa+J7ytWh1ojM1i3gs+HSyTqEKairXLG5kBCLQOfyxqSWNggYlnQsg4jVmTkw5jE+i7zSPz/srdxbFnfvcN9o=
X-Received: by 2002:a50:c054:0:b0:56e:7281:55eb with SMTP id
 u20-20020a50c054000000b0056e728155ebmr1387706edd.9.1714631544216; Wed, 01 May
 2024 23:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-8-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2405011345140.497719@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2405011345140.497719@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 2 May 2024 08:32:11 +0200
Message-ID: <CAJy5ezq2PBXMXGMFORfuDVeC_t4S=9AF6b_pur9kD26fhBPhwA@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] xen: mapcache: Refactor
 xen_replace_cache_entry_unlocked
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, May 1, 2024 at 10:46=E2=80=AFPM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Tue, 30 Apr 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Add MapCache argument to xen_replace_cache_entry_unlocked in
> > preparation for supporting multiple map caches.
> >
> > No functional change.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/xen/xen-mapcache.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > index d2deff70c8..6e758eff94 100644
> > --- a/hw/xen/xen-mapcache.c
> > +++ b/hw/xen/xen-mapcache.c
> > @@ -556,7 +556,8 @@ void xen_invalidate_map_cache(void)
> >      mapcache_unlock(mapcache);
> >  }
> >
> > -static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
> > +static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
> > +                                                 hwaddr old_phys_addr,
> >                                                   hwaddr new_phys_addr,
> >                                                   hwaddr size)
> >  {
> > @@ -578,7 +579,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hw=
addr old_phys_addr,
> >          cache_size +=3D MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCK=
ET_SIZE);
> >      }
> >
> > -    entry =3D &mapcache->entry[address_index % mapcache->nr_buckets];
> > +    entry =3D &mc->entry[address_index % mc->nr_buckets];
> >      while (entry && !(entry->paddr_index =3D=3D address_index &&
> >                        entry->size =3D=3D cache_size)) {
> >          entry =3D entry->next;
>
> There is still a global mapcache pointer in use in this function:
>
>   xen_remap_bucket(mapcache, entry, entry->vaddr_base,
>


Thanks! I had accidentally put the change to use mc in future patches.
Will fix in v5.

Cheers,
Edgar


>
> > @@ -614,7 +615,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_ad=
dr,
> >      uint8_t *p;
> >
> >      mapcache_lock(mapcache);
> > -    p =3D xen_replace_cache_entry_unlocked(old_phys_addr, new_phys_add=
r, size);
> > +    p =3D xen_replace_cache_entry_unlocked(mapcache, old_phys_addr,
> > +                                         new_phys_addr, size);
> >      mapcache_unlock(mapcache);
> >      return p;
> >  }
> > --
> > 2.40.1
> >

