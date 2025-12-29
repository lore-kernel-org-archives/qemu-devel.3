Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A45D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBQT-0003Zn-DB; Mon, 29 Dec 2025 06:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBPx-0003SZ-0K
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:28:09 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBPt-0007FF-Ly
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:28:04 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso1175072166b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007680; x=1767612480; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg/UE/QZpWIq3RRBEbl4nxCVw6ufBWahVOryBwqdCrc=;
 b=xV2o30mEybKRhEbc8U7R1rLJqwoEbEbKO8GEjE5jMNrhL3a3l7qa/TYmKPnSRwL16C
 qUI39qRTdfmes5Yr/7ZRLP/r3D4C0WYdLrdHIzm9+1n+xP0T/NUAmulxiRW/jkQE0r6S
 KaJ1VievRxgGsbGGHYAsCu/Jm1dmLOEJ1qLfGDd/d9Jcz5Q6AWxuGFbLZIwjEBZj85ni
 tS329OZOdiBEj/epUYbcTE2JvkV3t8D0UXMDmQxIg5JKEHZSlBrgmL/h0sj0qWgkmFpH
 1D/1oYYgVzY+68BR98FhcNok9poSBMXJWTaegcxGI7PeS4OAFaXLrr4bL2W/t3cl434D
 4XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007680; x=1767612480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mg/UE/QZpWIq3RRBEbl4nxCVw6ufBWahVOryBwqdCrc=;
 b=ppAHAfN9XWyXvYFdX4ZM8Fv8SkVHaClfeHrRyFi35Sr4w8nLsEWRrjHO3G2LRTEXjc
 lzbBYdR7XgpaC1dbXV3LwaWlmX+S1LXVd1432YnOTHYOBCNyZ9N0figuPC8+auAuUAKT
 f79V3GCgnndWrYGjb2EfyMVs7myEINKWGwGz9h9FmsZejo1yJgP/6R1VHe7BexEURtOw
 jp6G7XUzhmE3PK4sv8dhF/aSNqETQHNhkP2L6JegKgUP56LsD+hz8nFS1WZAptC43Xw6
 gnkyknw/tYaXXaCo3wLBMtop0J9g1gWCrrAXa/7/ggBE993FN6c161fWM6ee3htdMXDw
 bAbw==
X-Gm-Message-State: AOJu0YzyGN6Wq0L65EQXO6BTVcpyqw286aYNKZbfdakP3Hw5Zwy/bhm3
 GUoYH6taEptEfA4fEmh3emTSupAM11ZOwPoH3bERVpr/f4F9zojuISqn5nSRpl8t4fpVJsxV0c+
 LNk03GrTHN+rc7WH4KNFMn4Cv3dgvILuUSsPwKblmaQ==
X-Gm-Gg: AY/fxX4leCHWs7uJ9k/Wk4o+CcwtqEWsauTO+VzSfrK/EkxehOlHxubnMml/GYswF/z
 RRvD5iHQotDA2P5qkhLTbfy9D0tQ8BWZD3FJs/at95K+VJEulPtmLU5IZ+c7dpgl17M276vfSVo
 5rf0QR2YSAGDIR6yTKdwm+kil6usrnvOxmoiRLhsDAf8yJ5I8G/HyZSt+j7Dr7JheTe2p4Pe6IJ
 SSersKtVi9fpKKy1wtSQ4811OcUwCi2WFN2jO1O0b0TVshJZ73VKOmCjzEzr5/0sapf0y0PvV0A
 cDQYGzgRyDoLOo8aNztl7jRtwoggbvSKaJnEG3Y=
X-Google-Smtp-Source: AGHT+IGeKQf15HaC6QJxdtg/BzV3E8FJ1P4Nby/cjgZgExi8Jwn1jUUNyIrMTITt9O/B1oAJbi/KpHtl2HSjGEBKcyU=
X-Received: by 2002:a17:906:6a1d:b0:b79:c879:faad with SMTP id
 a640c23a62f3a-b8036f61bf2mr3127092266b.21.1767007679949; Mon, 29 Dec 2025
 03:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-2-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:27:33 +0200
X-Gm-Features: AQt7F2rTCBfcH9rqGUZxaqddCXBjIM-CZG8x9Vf0_k3gMCCcGKbZMtE8vAvYwHw
Message-ID: <CAAjaMXYrCP71sR+0Qd=P4bjM0sTGq--mc_MVMLiO19=aE09A-A@mail.gmail.com>
Subject: Re: [PATCH 1/8] hw/s390x: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 24, 2025 at 6:20=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The S390x architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' hw/s390x/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/s390x/css.c          | 24 +++++++++++-------------
>  hw/s390x/s390-pci-bus.c |  4 ++--
>  hw/s390x/virtio-ccw.c   | 24 ++++++++++++------------
>  3 files changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 53444f68288..4bc2253c182 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1582,27 +1582,25 @@ static void css_update_chnmon(SubchDev *sch)
>          /* Format 1, per-subchannel area. */
>          uint32_t count;
>
> -        count =3D address_space_ldl(&address_space_memory,
> -                                  sch->curr_status.mba,
> -                                  MEMTXATTRS_UNSPECIFIED,
> -                                  NULL);
> +        count =3D address_space_ldl_be(&address_space_memory,
> +                                     sch->curr_status.mba,
> +                                     MEMTXATTRS_UNSPECIFIED, NULL);
>          count++;
> -        address_space_stl(&address_space_memory, sch->curr_status.mba, c=
ount,
> -                          MEMTXATTRS_UNSPECIFIED, NULL);
> +        address_space_stl_be(&address_space_memory, sch->curr_status.mba=
, count,
> +                             MEMTXATTRS_UNSPECIFIED, NULL);
>      } else {
>          /* Format 0, global area. */
>          uint32_t offset;
>          uint16_t count;
>
>          offset =3D sch->curr_status.pmcw.mbi << 5;
> -        count =3D address_space_lduw(&address_space_memory,
> -                                   channel_subsys.chnmon_area + offset,
> -                                   MEMTXATTRS_UNSPECIFIED,
> -                                   NULL);
> +        count =3D address_space_lduw_be(&address_space_memory,
> +                                      channel_subsys.chnmon_area + offse=
t,
> +                                      MEMTXATTRS_UNSPECIFIED, NULL);
>          count++;
> -        address_space_stw(&address_space_memory,
> -                          channel_subsys.chnmon_area + offset, count,
> -                          MEMTXATTRS_UNSPECIFIED, NULL);
> +        address_space_stw_be(&address_space_memory,
> +                             channel_subsys.chnmon_area + offset, count,
> +                             MEMTXATTRS_UNSPECIFIED, NULL);
>      }
>  }
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 52820894fa1..aeeed82955a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -461,8 +461,8 @@ static uint64_t table_translate(S390IOTLBEntry *entry=
, uint64_t to, int8_t ett,
>      uint16_t err =3D 0;
>
>      tx =3D get_table_index(entry->iova, ett);
> -    te =3D address_space_ldq(&address_space_memory, to + tx * sizeof(uin=
t64_t),
> -                           MEMTXATTRS_UNSPECIFIED, NULL);
> +    te =3D address_space_ldq_be(&address_space_memory, to + tx * sizeof(=
uint64_t),
> +                              MEMTXATTRS_UNSPECIFIED, NULL);
>
>      if (!te) {
>          err =3D ERR_EVENT_INVALTE;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 4a3ffb84f8f..9dd838c61e4 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -889,26 +889,26 @@ static void virtio_ccw_notify(DeviceState *d, uint1=
6_t vector)
>              }
>          } else {
>              assert(vector < NR_CLASSIC_INDICATOR_BITS);
> -            indicators =3D address_space_ldq(&address_space_memory,
> -                                           dev->indicators->addr,
> -                                           MEMTXATTRS_UNSPECIFIED,
> -                                           NULL);
> +            indicators =3D address_space_ldq_be(&address_space_memory,
> +                                              dev->indicators->addr,
> +                                              MEMTXATTRS_UNSPECIFIED,
> +                                              NULL);
>              indicators |=3D 1ULL << vector;
> -            address_space_stq(&address_space_memory, dev->indicators->ad=
dr,
> -                              indicators, MEMTXATTRS_UNSPECIFIED, NULL);
> +            address_space_stq_be(&address_space_memory, dev->indicators-=
>addr,
> +                                 indicators, MEMTXATTRS_UNSPECIFIED, NUL=
L);
>              css_conditional_io_interrupt(sch);
>          }
>      } else {
>          if (!dev->indicators2) {
>              return;
>          }
> -        indicators =3D address_space_ldq(&address_space_memory,
> -                                       dev->indicators2->addr,
> -                                       MEMTXATTRS_UNSPECIFIED,
> -                                       NULL);
> +        indicators =3D address_space_ldq_be(&address_space_memory,
> +                                          dev->indicators2->addr,
> +                                          MEMTXATTRS_UNSPECIFIED,
> +                                          NULL);
>          indicators |=3D 1ULL;
> -        address_space_stq(&address_space_memory, dev->indicators2->addr,
> -                          indicators, MEMTXATTRS_UNSPECIFIED, NULL);
> +        address_space_stq_be(&address_space_memory, dev->indicators2->ad=
dr,
> +                             indicators, MEMTXATTRS_UNSPECIFIED, NULL);
>          css_conditional_io_interrupt(sch);
>      }
>  }
> --
> 2.52.0
>

