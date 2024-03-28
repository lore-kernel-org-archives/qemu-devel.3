Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C039C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 12:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpop9-0003W4-07; Thu, 28 Mar 2024 08:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rpop3-0003VE-PG
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:25:35 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rpop1-0005pe-OS
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:25:33 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a47385a4379so356549866b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711628730; x=1712233530;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTSh/916+J4S+1euIvTGAPOX7N8Hp0DCZcMhKNVdJBY=;
 b=1q5gQivlc9OGqTRYOUHDZJNGORywe/UkclmoN6tCL479ZQ0YZq3k2bzpAeuefrsxpq
 kcDbhFVwXHnDPfPwjwDDOT7tuWpb1wAccBNCI5tKNh8+zyjkAqZdoDvm3+RCkAt4jNR5
 Mo9jJdep45bJgEwP8BSdIxHKddq21NFOkYjBZypmKG5UH3I/zxrauonaB8t3nJfzlO8x
 /Hon40N6270U6UNrBi4YnThLE5GQF408zFnC5hhNXsimzdjDZ8qkGguDUHGPlf2U+5Ne
 oUhkurd77h8txOhpY83//PiSou5LuGlDR/rq9dDKfHWAULCluYfu+gDGZbQMrq+T9fau
 LoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711628730; x=1712233530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTSh/916+J4S+1euIvTGAPOX7N8Hp0DCZcMhKNVdJBY=;
 b=wKlUvUCXrQ+aTeZeoZg9h8r1Kc26uA90uvcqTIFtDr9e6HrImKkhx97nCpjCZ1urYj
 z8rqKR7MQLWiHkfVc7ZI1pTo9JO4Sbw56LM8ig5Q8FNCjlOIxce1tZXVwjlD35cbjaFP
 orfWbMKVi+VO9LPPvMsOvbbzGbzDidQbAaZujSUtNZY/rKFoJgbOai7Tg38t1Q2E+55+
 VkEfFzKhpxnQCKbBeHN5sdXRARr1/o/hs/ruFQD2+OcJpc9o9eaSz9nS7sLo/LQgDyNN
 Gyh82l322wUmtAFuS1iCpkVOZ6qJmVAj4qp0DAXXIvI21BAyFiXUQWm+AHQ2NQJWr3T9
 W9ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuJlKDlly5BsQtQzZM/iEE93AuMsGsq7SIdXFPxYZdLGePBMv3TPND+kreMpCGQ0tr/UBNkZqY2NHgDFcFuytHmMWyINM=
X-Gm-Message-State: AOJu0Yx7TMEJNpjfWBrmHvJcm1fGbpjDDr3tzXqR+0Xbi1CJgfdzegYO
 QVkyJQQglXMPKvWw+syeq8cmiKUX3bq87JfWuES9RSff748KZZpSypSM5/EPntr84DFH3OK6rz+
 xM4kDr6UDY4ljOqz1KuqXQNEfEzeb0e+EVFndbA==
X-Google-Smtp-Source: AGHT+IE3JgCYZjGgTx9ThxQmxjJnRhJnl7nuPFpLoryZCfcN9b5q9QREwOOdUyMiUhc5JiBEwMzRz3/CuSbcKGRiX0k=
X-Received: by 2002:a17:906:1145:b0:a4d:f673:7f30 with SMTP id
 i5-20020a170906114500b00a4df6737f30mr1837314eja.11.1711628729659; Thu, 28 Mar
 2024 05:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
 <20240327-vhost-v2-2-0a89aa21b54b@daynix.com>
 <CAOEp5Od6-E4PGJMz9U51q=ho0xS56VdeZB9fr6vzeNOgcF0fnQ@mail.gmail.com>
In-Reply-To: <CAOEp5Od6-E4PGJMz9U51q=ho0xS56VdeZB9fr6vzeNOgcF0fnQ@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 28 Mar 2024 13:59:41 +0200
Message-ID: <CABcq3pEwxDzYA2LmJOgA9rWGALhp+7URPQfsnvVb4_QWjRCa2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ebpf: Fix indirections table setting
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, 
 Yan Vugenfirer <yan@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::629;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi all,
I've reviewed and checked - this patch is necessary!

Acked-by: andrew@daynix.com

On Thu, Mar 28, 2024 at 11:39=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> Hi Andrew,
> Can you please check the indirection table copy and ack on the patch
> if the fix is correct
>
> Thanks,
> Yuri
>
> On Wed, Mar 27, 2024 at 4:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > The kernel documentation says:
> > > The value stored can be of any size, however, all array elements are
> > > aligned to 8 bytes.
> > https://www.kernel.org/doc/html/v6.8/bpf/map_array.html
> >
> > Fixes: 333b3e5fab75 ("ebpf: Added eBPF map update through mmap.")
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  ebpf/ebpf_rss.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > index 2e506f974357..d102f3dd0929 100644
> > --- a/ebpf/ebpf_rss.c
> > +++ b/ebpf/ebpf_rss.c
> > @@ -185,13 +185,18 @@ static bool ebpf_rss_set_indirections_table(struc=
t EBPFRSSContext *ctx,
> >                                              uint16_t *indirections_tab=
le,
> >                                              size_t len)
> >  {
> > +    char *cursor =3D ctx->mmap_indirections_table;
> > +
> >      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL ||
> >         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> >          return false;
> >      }
> >
> > -    memcpy(ctx->mmap_indirections_table, indirections_table,
> > -            sizeof(*indirections_table) * len);
> > +    for (size_t i =3D 0; i < len; i++) {
> > +        *(uint16_t *)cursor =3D indirections_table[i];
> > +        cursor +=3D 8;
> > +    }
> > +
> >      return true;
> >  }
> >
> >
> > --
> > 2.44.0
> >

