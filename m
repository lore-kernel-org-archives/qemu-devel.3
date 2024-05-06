Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6DBC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uWQ-000511-Bm; Mon, 06 May 2024 05:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s3uWL-00050S-Ax
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s3uWI-0005OT-3X
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714987224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBL3bbaiYGc99nROMq6nxogEkbn/ygA24XV1IkiZfgE=;
 b=Gu/JdmlmaEMhsnPP3XlL+Lp5Adr5D5r4lDOvWGrdSuxn0b/DedMyZi2bFPQEqpK4egLG5U
 R9tqgHZIuRLn6uYiodw8uHAlsELtWJzFjE7tim0an/Qqc4aWTtKomCrGTEPkP/tETERNFL
 9/BIclRc6Uu2HB0wslfGaMN3cLFO60E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-k6So4IAkMaSdcpllyAFOnQ-1; Mon, 06 May 2024 05:20:23 -0400
X-MC-Unique: k6So4IAkMaSdcpllyAFOnQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b364c4c4b0so2247126a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714987222; x=1715592022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBL3bbaiYGc99nROMq6nxogEkbn/ygA24XV1IkiZfgE=;
 b=URuhjhdPKn8/QTM6fhm2wowH7kMl+LEgkzsnC+XsatJpZn9eCMVK2mdoUhT+9XYZNY
 98aan8R8e+ZUahPc1kkGWiFStp6ptQA3CnozYJ9iGkvo5KQgcS3CjDakDdh26WxJM0kK
 KjVCp1iRo1m1ivXsuz0oLyABRyckUUYpdjuw8OjZABkcu4JmZ5Qkcb3c5MgHI1RMHDCm
 7Hms6gNiYlEluV0HKllPcxsKT5Bcp5RxVhZq6K02VzmZWO5yK1L/Sp8KVF9TyP71LpLf
 IvjnRh+2M4jPpb/bRg0e27Ssua/WUmChibBXAujI/w0ZSLoYNPmVoaAP7mktRDdDj9OX
 AWEw==
X-Gm-Message-State: AOJu0YwrHc0gdBha/8fbQC/FW75e8FcMyikIKBCDyVkTW9E9oZz+njKk
 MOlT8gVOL/EDfSG2OmaXBqUDFmdEyxsB3q6D6eKulTpBzCekDp0OEQV+zgzxcLQurYScilW2Lpn
 Yp6TsFxiwp32FhRUbeIXu1Y00mIBA3zn8SVXTBAAC3m5OLfkLVTfm32omnyuKn2VL51U4/I6E1B
 uU2TAPdCXY18oDQL4fdujLvOXkTPY=
X-Received: by 2002:a17:90a:8986:b0:2b4:36e7:4f72 with SMTP id
 v6-20020a17090a898600b002b436e74f72mr7392828pjn.25.1714987222038; 
 Mon, 06 May 2024 02:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWbGvZqD9O1UX3NCkf6bUZnqWYgBN3MRWEG9qA4eB8+ajmBE4GUsrAOLV0ilHuPNNHSJfgQm5qCbOZ/ydMxi0=
X-Received: by 2002:a17:90a:8986:b0:2b4:36e7:4f72 with SMTP id
 v6-20020a17090a898600b002b436e74f72mr7392815pjn.25.1714987221701; Mon, 06 May
 2024 02:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240430105333.23377-1-adobriyan@yandex-team.ru>
In-Reply-To: <20240430105333.23377-1-adobriyan@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 May 2024 17:20:10 +0800
Message-ID: <CACGkMEvH9MNSyk3QdbY0ie4_Wbd9tp-pmq41QVyLA-06QYk2nQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem); "
To: Alexey Dobriyan <adobriyan@yandex-team.ru>
Cc: qemu-devel@nongnu.org, adobriyan@gmail.com, mst@redhat.com, 
 vsementsov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Apr 30, 2024 at 6:54=E2=80=AFPM Alexey Dobriyan
<adobriyan@yandex-team.ru> wrote:
>
> Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> creates small packet (1 segment, len =3D 10 =3D=3D n->guest_hdr_len),
> then destroys queue.
>
> "if (n->host_hdr_len !=3D n->guest_hdr_len)" is triggered, if body create=
s
> zero length/zero segment packet as there is nothing after guest header.
>
> qemu_sendv_packet_async() tries to send it.
>
> slirp discards it because it is smaller than Ethernet header,
> but returns 0 because tx hooks are supposed to return total length of dat=
a.
>
> 0 is propagated upwards and is interpreted as "packet has been sent"
> which is terrible because queue is being destroyed, nobody is waiting for=
 TX
> to complete and assert it triggered.
>
> Fix is discard such empty packets instead of sending them.
>
> Length 1 packets will go via different codepath:
>
>         virtqueue_push(q->tx_vq, elem, 0);
>         virtio_notify(vdev, q->tx_vq);
>         g_free(elem);
>
> and aren't problematic.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
> ---
>
>         hopefully better changelog.
>         use "if (out_num < 1)" so that discard doesn't calculate iov leng=
th
>
>  hw/net/virtio-net.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>

I tweak the title to "drop too short packets early".

And queued.

Thanks


