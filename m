Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F81C369CB
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 02:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8rXa-00019g-9z; Sat, 26 Apr 2025 22:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1u8rXZ-00017R-1K
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 22:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1u8rXW-0000Yh-Du
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 22:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745720078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xW11uHN7NofLdIpNe75aZ1RurFZcalms+AcD3FQWSP0=;
 b=XpHfeYZP9kz5xMFtInFdHr4wzJRtNdNMhKv7FznikqG7hvIdr8QHX+l61orrPC3SAX8r2s
 TDRYb7scF5id61Fk8+F+syL2UFMr0sh6UF7/B7JTs0W9R32c/qrq1E5s90sqQtxviIA8w/
 8+aRFoOaGXpFbYhl8VMaO/bZblsR9Ew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-KMa7XRKMN2ejKEqn0x5m0w-1; Sat, 26 Apr 2025 22:14:30 -0400
X-MC-Unique: KMa7XRKMN2ejKEqn0x5m0w-1
X-Mimecast-MFC-AGG-ID: KMa7XRKMN2ejKEqn0x5m0w_1745720069
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac3d175fe71so227526966b.0
 for <qemu-devel@nongnu.org>; Sat, 26 Apr 2025 19:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745720069; x=1746324869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xW11uHN7NofLdIpNe75aZ1RurFZcalms+AcD3FQWSP0=;
 b=QcpUa1ZXkjpLBZ3YTc7EaM4PL4zQSHQ2bIv0OD9nxfN20zfG3APcLAwviEAF5MbxhA
 vUPmsOccLjHsU6xNmejPjclKNozHwDaD7cnRkSamx52rrD7AT0h9vtThXyeocTmKnHac
 VlN+LqRj81+pEufj74PL1sjuOwGyiBLDrvY4WPnCA9M1GujR6IMac4ERozSO/mR+Ii+Z
 mXgWzjB7wFKneyFispvXpv+64VAjMKRDRqs5NIiN/i4v3uKd5elmVQvZqDNFqghNureA
 hewSsxQBMwq0uHLCEtHzTFqMsmhwgbZ2XqX9hThL7/iCgWuaOuEjIiejDKmn5beG9xrE
 gptg==
X-Gm-Message-State: AOJu0YwjLM5Pfd5DkgjaFgrCEj9wwoV4WVA9vFv/5WTJxIPcI+7nMPrK
 tT9bieoMVlfWoLVD37A5p8CFwbNDF0L7IcExBD1pLimiCUI72jEeEDXY/ysNKaoZJtarBQg5vN/
 gpBLCgn9mElTfahqwSP+2uPbAkIk3tK9JTAELJrki1KLGkqjb/1D9V8/IOFnF406b4UoxbghKjL
 CPqhwQLJZDFaB3Eid6V7nfhvj1CTQ=
X-Gm-Gg: ASbGncsEX61KkLhRAyl9Hc4Y0Kxb4L5Ka8kYDWBVD3ftRoz2DrjNrwquESXVjRBe0k/
 xPLbtk22sD3iTDkFvUHuDquZ8F5BAF4hyYd+kUn14aMuZf/7QK5NKAmA2xOtwhFZ/bh/SGA==
X-Received: by 2002:a17:907:9405:b0:acb:39c6:3974 with SMTP id
 a640c23a62f3a-ace71047902mr712324166b.5.1745720069424; 
 Sat, 26 Apr 2025 19:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb6O7Q0rHzgQmVPZEBXVdPmSHAmqMrsPCJ1zlP162aN1Kk67Yzl1tv9HiZaqcou6ZaJ1CmaCJ0IMNiQ2SRy/k=
X-Received: by 2002:a17:907:9405:b0:acb:39c6:3974 with SMTP id
 a640c23a62f3a-ace71047902mr712322866b.5.1745720069104; Sat, 26 Apr 2025
 19:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250424-reapply-v2-1-d0ba763ac782@daynix.com>
 <6hrijekkhh53kyckihqv5sbkcfzqry43xt62imjq4j52jk6tqc@zmr4lquiq3k5>
In-Reply-To: <6hrijekkhh53kyckihqv5sbkcfzqry43xt62imjq4j52jk6tqc@zmr4lquiq3k5>
From: Lei Yang <leiyang@redhat.com>
Date: Sun, 27 Apr 2025 10:13:51 +0800
X-Gm-Features: ATxdqUFFUqOwdepbWGj-zswU9bjDuqK0560HVDeY2FWDjmhtlCoO6Pmxr9tpBYw
Message-ID: <CAPpAL=wFdQoR9p9BeiKTMrtwXbUs46c3O7d2G7N4fm6oShx4fA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Copy received packet to buffer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Antoine Damhet <adamhet@scaleway.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QE tested this patch's v2 with virtio-net regression tests, everything
works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Apr 24, 2025 at 11:49=E2=80=AFPM Antoine Damhet <adamhet@scaleway.c=
om> wrote:
>
> On Thu, Apr 24, 2025 at 06:49:57PM +0900, Akihiko Odaki wrote:
> > Commit e28fbd1c525d ("Revert "virtio-net: Copy received header to
> > buffer"") reverted commit 7987d2be5a8b, which attempted to remove the
> > need to patch the (const) input buffer.
> >
> > Achieve the original goal by copying the header or the entire packet to
> > a writable buffer as necessary. Copy the virtio-net header when patchin=
g
> > it. Copy the entire packet when filling the UDP checksum as required by
> > net_checksum_calculate().
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Supersedes: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
> > ("[PATCH] virtio-net: Copy all for dhclient workaround")
> >
> > This reapplies commit 7987d2be5a8b ("virtio-net: Copy all for dhclient
> > workaround"), which was reverted by commit e28fbd1c525d ("Revert
> > "virtio-net: Copy received header to buffer""), with a fix in the
> > superseded patch. It also renames identifiers according to the
> > discussion with Antoine Damhet.
> > ---
> > Changes in v2:
> > - Rewrote the message avoiding archeology as suggested by
> >   Michael S. Tsirkin.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250423-reapply-v1-1-=
6f4fc3027906@daynix.com
> > ---
> >  hw/net/virtio-net.c | 91 ++++++++++++++++++++++++++++-----------------=
--------
> >  1 file changed, 48 insertions(+), 43 deletions(-)
>
> Reviewed-by: Antoine Damhet <adamhet@scaleway.com>
> Tested-by: Antoine Damhet <adamhet@scaleway.com>
>
> --
> Antoine 'xdbob' Damhet
> Engineer @scaleway


