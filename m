Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BECC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkpp-0004S7-SL; Wed, 05 Jun 2024 03:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1sEkpn-0004Rm-Us
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1sEkpm-000105-8I
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717571601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJayKCGtx/FVicl0F0SG4EUQVy2KXkM/sK1DmCBFGXM=;
 b=i5Oe008Q1FA1yLXbsjmyfMLDadVoZ4zsTURMEGg9hx/7isWr/sfn3g2zpWeHx9YCKUYhlJ
 rWBVzPgNGZKRxPdODTA7HVu7wM8dhD0T3/G47WXWO8KBLdBIO95pR79gUGSG3s4VUKVQkh
 u6zPs3k9lwErYPReWJGM40E4Nm4cd8A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-kytbG_DFPFCD4WwBPpY_-A-1; Wed, 05 Jun 2024 03:12:13 -0400
X-MC-Unique: kytbG_DFPFCD4WwBPpY_-A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ea8f9159f4so39822231fa.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717571532; x=1718176332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJayKCGtx/FVicl0F0SG4EUQVy2KXkM/sK1DmCBFGXM=;
 b=kyFbo2XPxlMoYrZDqS+1hGht1ka2Y3HvtmxU4k5W9FOr5LknZ5bhBqxt2P+dQ3eHuj
 L4dgHfMNDNwsBMLLWRReaQVf4jNt7CNniWSeegn6R2Go593DCxZzUcUb9YhNqIJhwjqH
 osUXe4TqrKIGn1PsEHGIwX6YKrTyTGNx/IueDeHX6TwBpX4tapiyh3WEurB/kFNBvPUi
 MuetHKRNKix+3aVRujwe/Y4V6m8TIvrIpeY6cvQ/jA8q3mafiwL0jK/ZUF6hf80iGBOp
 QpcAFT5vU0Bn9ypTPiVJcenUVEYzdQ1bm/QqtAEvXq7KXUT9ojP0KruPHENkbnX5PUla
 MadQ==
X-Gm-Message-State: AOJu0YxkEACoUtGOPlAGaKIOvhQx4rpyiXYffpUuer8M8S/gIEJ9uk8M
 80XKhVizCWRJ4gYxtXJHRs+AC6koYEAWOqVp6vwY7C8tVZ2LfYmTTakDWouDpxaZjN3D0tIUVne
 BwOW3f5yWqe0tvlmokg6v2v4vULjwwrsLf4dE8msXdPRhpLGeC5Yo2543GT75nAvGVw6Q5wYrAb
 KJW3hdSo3gQ3/yANa2fMKegLUjzHU=
X-Received: by 2002:a2e:b703:0:b0:2e9:7417:bb0a with SMTP id
 38308e7fff4ca-2eac798d18amr8460681fa.3.1717571532012; 
 Wed, 05 Jun 2024 00:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDR4KepibulB/OHJi2+GdWMm0E4lwlFJxjpYHpOOPdECcqppSFvNC4ZWmOgODVPFlFIS2ZdKzp2mCWhIr8oAM=
X-Received: by 2002:a2e:b703:0:b0:2e9:7417:bb0a with SMTP id
 38308e7fff4ca-2eac798d18amr8460631fa.3.1717571531640; Wed, 05 Jun 2024
 00:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717140354.git.mprivozn@redhat.com>
 <58295d1f6c995c0c444e375348436e799689126c.1717140354.git.mprivozn@redhat.com>
In-Reply-To: <58295d1f6c995c0c444e375348436e799689126c.1717140354.git.mprivozn@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Wed, 5 Jun 2024 09:12:00 +0200
Message-ID: <CAMXpfWv7T0wHXgzD8urL+jNMeGJrmObbSCOVqz-ysNUn5Kovzw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] backends/hostmem: Report error when memory size is
 unaligned
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch has been successfully tested by QE. After allocating some
hugepages in the host, try to boot up a VM with the memory backed by a
file and the size unaligned, check now the message displayed by QEMU:
qemu-system-x86_64: backend memory size must be multiple of 0x200000

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Fri, May 31, 2024 at 9:29=E2=80=AFAM Michal Privoznik <mprivozn@redhat.c=
om> wrote:
>
> If memory-backend-{file,ram} has a size that's not aligned to
> underlying page size it is not only wasteful, but also may lead
> to hard to debug behaviour. For instance, in case
> memory-backend-file and hugepages, madvise() and mbind() fail.
> Rightfully so, page is the smallest unit they can work with. And
> even though an error is reported, the root cause it not very
> clear:
>
>   qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-fil=
e': Invalid argument
>
> After this commit:
>
>   qemu-system-x86_64: backend memory size must be multiple of 0x200000
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  backends/hostmem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 012a8c190f..5f9c9ea8f5 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -337,6 +337,7 @@ host_memory_backend_memory_complete(UserCreatable *uc=
, Error **errp)
>      HostMemoryBackendClass *bc =3D MEMORY_BACKEND_GET_CLASS(uc);
>      void *ptr;
>      uint64_t sz;
> +    size_t pagesize;
>      bool async =3D !phase_check(PHASE_LATE_BACKENDS_CREATED);
>
>      if (!bc->alloc) {
> @@ -348,6 +349,13 @@ host_memory_backend_memory_complete(UserCreatable *u=
c, Error **errp)
>
>      ptr =3D memory_region_get_ram_ptr(&backend->mr);
>      sz =3D memory_region_size(&backend->mr);
> +    pagesize =3D qemu_ram_pagesize(backend->mr.ram_block);
> +
> +    if (!QEMU_IS_ALIGNED(sz, pagesize)) {
> +        error_setg(errp, "backend memory size must be multiple of 0x%"
> +                   PRIx64, pagesize);
> +        return;
> +    }
>
>      if (backend->merge &&
>          qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
> --
> 2.44.1
>
>


