Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CAFD2F7F3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KMu-0006rv-3n; Thu, 17 Oct 2024 02:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1KMr-0006rU-Qm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1KMq-0008Eo-Du
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729147934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28nMrGKKPKasMXUwpwg8yG1AeQBCG7VUDHWxq7nq2RQ=;
 b=KEs5THIOc/bmEG4qUMWdD/nQ7huDqk4N/wE0krgFUKOtk4TZpcQEbaSBfWRTJHgptLjOUo
 oWHsgFVObP8vrLQnvv3qx7icNg+6X6ZQgScH1hYuYdEPXy+T7vYSKd2xi9vSLi+N0ZtJDt
 LL9TvvuyuRztQVE4mhOOy6oZSub42QM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-1Ox9pZU5PpCeZWmPuZRWFw-1; Thu, 17 Oct 2024 02:52:13 -0400
X-MC-Unique: 1Ox9pZU5PpCeZWmPuZRWFw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e2ffb47515so726500a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147932; x=1729752732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28nMrGKKPKasMXUwpwg8yG1AeQBCG7VUDHWxq7nq2RQ=;
 b=gyXjems6G8bkZJZoP0nWv0XkjA5cgo2CjPMursDuIRmIu7mWORD5fEDyi0LP68M6AK
 95gBwCg0bkfznV48PnXai4yLnB1EbtnWU1xBIYCBIDcOD+cB4vqOXdz84jXH+bAw20/D
 Yff+igsW33U2OSDQdfR0s8iniHe2G7DNNhrOXzBmxXqAKlT0sIHne2hcfINeuENKFyj6
 /r64d+9rmQ1GECYd7nhKnZvqa80BsKwtbAWxK/i31sMIDP4yuIi4qRAfvtKopCzTtImM
 TDYeLJYNZQz+Ip06U62cytxeCkLia7pwK6iyXy7VQuyP+2d9ChNXwuNMHg62AnRxwtRu
 ZP6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWfHcmvGPOJt7KHLv0tqN6TY09VwyaqSECv9zcM/aa/cFcP2Tqba4jcYDpgO0erYCSfESHMO1hAOJ@nongnu.org
X-Gm-Message-State: AOJu0YyzDaL2F9huHCtbULRmZlWzsLIBl2pliVfGAybdHweA4csYNJVg
 4FvOTzG4zl/rrvAhHInI4kkG2CrcVZ5SE0V3yghmN92loxxF9hmmBhCxgCs7foYVX14dRD3WBbg
 Dkm6+bxe7T6LEFgbhls9dyekPOk9DHmthRE0nYEGvGxPWx5HD3V6noqiN3Hgx2Zb38SKiIeLjXt
 HAmKgzxcoNyauOts8923NCxE1T8R0=
X-Received: by 2002:a17:90a:1fc7:b0:2da:8e9b:f37b with SMTP id
 98e67ed59e1d1-2e2f0b0ab63mr23860290a91.24.1729147932479; 
 Wed, 16 Oct 2024 23:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Vr3BObcEtFFHMyYrBYZ00ub27Ig4webRiOX4fH8goAn2XSwBwlu1TWStvbUNvahuU1EeRH0aZe8q7deo2rA=
X-Received: by 2002:a17:90a:1fc7:b0:2da:8e9b:f37b with SMTP id
 98e67ed59e1d1-2e2f0b0ab63mr23860273a91.24.1729147931928; Wed, 16 Oct 2024
 23:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
 <939526a0-0412-4984-a952-9415ce8b13c8@tls.msk.ru>
In-Reply-To: <939526a0-0412-4984-a952-9415ce8b13c8@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:52:00 +0800
Message-ID: <CACGkMEtH7PTYp6sAYosYZ=zueqo02_i7t5-50q36RtM4=kNgAQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] virtio-net fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Michael:

On Wed, Oct 16, 2024 at 1:58=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 15.09.2024 04:06, Akihiko Odaki wrote:
> > Most of this series are fixes for software RSS and hash reporting, whic=
h
> > should have no production user.
> >
> > However there is one exception; patch "virtio-net: Fix size check in
> > dhclient workaround" fixes an out-of-bound access that can be triggered
> > for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
> > can be applied independently.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Akihiko Odaki (7):
> >        net: checksum: Convert data to void *
> >        virtio-net: Fix size check in dhclient workaround
> >        virtio-net: Do not check for the queue before RSS
> >        virtio-net: Fix hash reporting when the queue changes
> >        virtio-net: Initialize hash reporting values
> >        virtio-net: Copy received header to buffer
> >        virtio-net: Fix num_buffers for version 1
> >
> >   include/net/checksum.h |   2 +-
> >   hw/net/virtio-net.c    | 109 ++++++++++++++++++++++++++++------------=
---------
> >   net/checksum.c         |   4 +-
> >   3 files changed, 65 insertions(+), 50 deletions(-)
>
> Hi!
>
> Has this patchset been forgotten, or does it wait for some
> R-b's ?

Thanks for the reminder.

I would go through this series.

Thanks

>
> Thanks,
>
> /mjt
>


