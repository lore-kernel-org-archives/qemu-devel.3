Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC5DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2QyA-00068w-TA; Thu, 02 May 2024 03:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2QyA-00068n-0S
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:35:06 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2Qy7-0007L4-Fg
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:35:05 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57232e47a81so2534471a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714635300; x=1715240100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlUMOnUMKElu43V8N8NXHih/16FRYsa+DT2aHHqwJNE=;
 b=QikVbhPSf5xJeBmICbQU7E9caCnERHZ3vUF/vIsPADeiKc5ZOL2+Y89mrQ8RXpY8rz
 i9u2cD2ngs1AUrZdTvwwiCMkbqwySnSyd/Hgxd2zHkJ8q+KruxBOy+Ad4JQKlgBi79HB
 mNloFOhILXTE4vIe7IKnkCdVZKJLT5a+jZ6DsCLAGxeuLntLMF7j6X3BKrU3D2JhoTDf
 YwwGQyIABu9klKYQU56ioL7Hap3ZVDd2NyCJZSUxKlA/HyJ6VTecDwNFv2/690627UKy
 TNkvhX2WQXZV/C0luC74veeRiHL1IpkKkhbrlVYCkdLGhJQ8DhNQvTmcDJm7cbG76LD3
 JuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714635300; x=1715240100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlUMOnUMKElu43V8N8NXHih/16FRYsa+DT2aHHqwJNE=;
 b=TahMiH48ufBWFHKtAkdLlzYT6fzR9bSubKx990YhFlz/5O1gZ34cIhtuiyPu3wgGMK
 I035Ms0meP0q96HPMEGWuNmTd+8hUs5ASVlWKC9UJBE+s8GDREWp/o3X3IhNS/1hsrPk
 fXp96w2wxhZYOFhfcyfCvJLIRggaVCJnN5C+qLrSoN+sBqgT5HZdAcqpPxk6tmVTK5cM
 dFZWYLrD4P0+kPnHLmkK9ppp2k6D6UXtLYitv3TwD8gGfavcXGmvcX21GsW1KiaU+VWt
 RvTm3OeBJtSrO2DU67z/1lEto6Q/4TwePOLbcIsRIrDNu40QCD42snQQoVFZpDFMr+w3
 bUJA==
X-Gm-Message-State: AOJu0YxomWCG8pedQWCMgL6WmUuT/eOmvSJ8+D5tDuOXFVh/eg4QNM5a
 EKHYwKL+V95FUxcf6zcAzMGmWPh79s4CqjS0Kw0hKohzEDBIwxmu/R7RbhDBEAkhpm/WH7w+LmT
 2HXsrpnH1Fc++BtmbFdRyR05cI2hD+dTJ
X-Google-Smtp-Source: AGHT+IFeFt+Pbra3NifN8rs1UXcD8UP6ZmjUZHfOEsk+O2tSlQVe5lCGAJsT/L6+37rrO+XVhxWqsOTvvoJ6Jvn3MsI=
X-Received: by 2002:a50:cd53:0:b0:570:4aea:4e1e with SMTP id
 d19-20020a50cd53000000b005704aea4e1emr1859829edj.15.1714635299936; Thu, 02
 May 2024 00:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-13-edgar.iglesias@gmail.com>
In-Reply-To: <20240430164939.925307-13-edgar.iglesias@gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 2 May 2024 09:34:47 +0200
Message-ID: <CAJy5ezrJ2YYgAXFhcyAVosnKL3a5E96oJCfkuS4y2OGSxdU0Fw@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] xen: mapcache: Unmap first entries in buckets
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x529.google.com
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

On Tue, Apr 30, 2024 at 6:50=E2=80=AFPM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> When invalidating memory ranges, if we happen to hit the first
> entry in a bucket we were never unmapping it. This was harmless
> for foreign mappings but now that we're looking to reuse the
> mapcache for transient grant mappings, we must unmap entries
> when invalidated.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/xen/xen-mapcache.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 4f98d284dd..0365311788 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -486,18 +486,22 @@ static void xen_invalidate_map_cache_entry_unlocked=
(MapCache *mc,
>          return;
>      }
>      entry->lock--;
> -    if (entry->lock > 0 || pentry =3D=3D NULL) {
> +    if (entry->lock > 0) {
>          return;
>      }
>
> -    pentry->next =3D entry->next;
>      ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size)=
;
>      if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
>          perror("unmap fails");
>          exit(-1);
>      }
> -    g_free(entry->valid_mapping);
> -    g_free(entry);
> +    if (pentry) {
> +        pentry->next =3D entry->next;
> +        g_free(entry->valid_mapping);
> +        g_free(entry);
> +    } else {
> +        memset(entry, 0, sizeof *entry);

I noticed that we're leaking entry->valid_mapping here. I'll fix this for v=
5.

Cheers,
Edgar


> +    }
>  }
>
>  typedef struct XenMapCacheData {
> --
> 2.40.1
>

