Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4633C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmEU-0004n3-Oj; Thu, 28 Mar 2024 05:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rpmES-0004mn-3A
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:39:36 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rpmEK-0007nQ-4R
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:39:30 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d6fd3cfaa6so9769251fa.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711618765; x=1712223565;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcEa10AcorBLWXgS8qws0d6IQB8gtuFHcDftfqWNRB8=;
 b=VWGIZyeJPLBW6o626SIt/+34XIsHA+9oQB+cxtO7e81s6KN5NsVrYtUgERaGHO41ir
 10oCGksA2ZrDdkvy+Nia2qQ3XFWROzyEgzuuiu4QHrEYjAjD3lRvHWiPypQh1GIR78rc
 O3KiiXddjkLcz8GAmDP5oaMmKXeW/hK2O/DMqy07o++saU+y9+j82H50qgr2h2yvfuoD
 lNjX9PguXbUFj9vdL5PX7jo/2pCz9cRRypQyR4bWP9KI0qxlsq1RLSosy3qyJ5NwhhLU
 7IFepE8re1OzA2A/cK1M5Ptz9b1pMCVaVlqO4v+0gZ4ZTPobTxxqDDXokKW2tBCBzLkc
 CMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711618765; x=1712223565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcEa10AcorBLWXgS8qws0d6IQB8gtuFHcDftfqWNRB8=;
 b=NV43gNnMD45sAylI4+jWoLc4y4E9WGHlCzPq0Ir6sLiGwHbKhY9Ur9T+hO2yvypeg9
 uRByMZYFNX+5ASP17v66EhGEHfFLPNtShhI+qL9S9PIDSZCwgfecNE+fZ/ktE5/ahiJK
 5vxqiGCq5t6ZY4CJDhL4siSHcTX5f8O4P8ygrtTMA9/ROBKvN40NxJBQ/7mJXI9We2jz
 z07mTqJndwEUoLnqYi9rSq795WtIP171et4W7mZ/KQZRZEwDBw1ymM8bjUAxqBfU3BNe
 GfXg50s+x1EZImTNafZNdw3lWZNf95uZFZWu53NHX9jIUvg8I8oshuLA+hsJ2SBH5x56
 3AoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/2M19U+dtdKL6BhE7ovLAcpOHFBIVEWvrOd441nbx4qwPq/RGPa3Q0V13SzJi+R8WCyuBxoD6yU/hKU3aXOuyoW5O8/4=
X-Gm-Message-State: AOJu0YxvoRtxeWsh/H2679jvwTA7BSKYUROw7OGtCiuZoXIN1s6YvjXr
 A9imfWNaYi4xSp39NuLqcuwt6WARGcXH5PtdxObhi6OTZPfJOyyyMBRo7XXtdv9hOI5nfHiVRX0
 rBj3sXOhrMs+LW0dRzvS0mEBY9Or9DOEfEa1ojQ==
X-Google-Smtp-Source: AGHT+IFMmKj97A10pWJu1upej9JK4IaUKr5t8j3zbQOpN5gj+XuSJFh7SBqwuFDeD6Z79JrgkAMB4mcSeYO9WyPpYVQ=
X-Received: by 2002:a05:651c:3cb:b0:2d2:e44e:a5cc with SMTP id
 f11-20020a05651c03cb00b002d2e44ea5ccmr1084828ljp.46.1711618764831; Thu, 28
 Mar 2024 02:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
 <20240327-vhost-v2-2-0a89aa21b54b@daynix.com>
In-Reply-To: <20240327-vhost-v2-2-0a89aa21b54b@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 28 Mar 2024 11:39:13 +0200
Message-ID: <CAOEp5Od6-E4PGJMz9U51q=ho0xS56VdeZB9fr6vzeNOgcF0fnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ebpf: Fix indirections table setting
To: Andrew Melnychenko <andrew@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, 
 Yan Vugenfirer <yan@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::22c;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22c.google.com
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

Hi Andrew,
Can you please check the indirection table copy and ack on the patch
if the fix is correct

Thanks,
Yuri

On Wed, Mar 27, 2024 at 4:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> The kernel documentation says:
> > The value stored can be of any size, however, all array elements are
> > aligned to 8 bytes.
> https://www.kernel.org/doc/html/v6.8/bpf/map_array.html
>
> Fixes: 333b3e5fab75 ("ebpf: Added eBPF map update through mmap.")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ebpf/ebpf_rss.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index 2e506f974357..d102f3dd0929 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -185,13 +185,18 @@ static bool ebpf_rss_set_indirections_table(struct =
EBPFRSSContext *ctx,
>                                              uint16_t *indirections_table=
,
>                                              size_t len)
>  {
> +    char *cursor =3D ctx->mmap_indirections_table;
> +
>      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL ||
>         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
>          return false;
>      }
>
> -    memcpy(ctx->mmap_indirections_table, indirections_table,
> -            sizeof(*indirections_table) * len);
> +    for (size_t i =3D 0; i < len; i++) {
> +        *(uint16_t *)cursor =3D indirections_table[i];
> +        cursor +=3D 8;
> +    }
> +
>      return true;
>  }
>
>
> --
> 2.44.0
>

