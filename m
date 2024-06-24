Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8EEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlLH-0008Hb-2Q; Mon, 24 Jun 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sLlLE-0008Ei-QC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sLlLA-0005Bp-1M
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719241841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8ols6Yx/7t5slsOmJ7Q7/Ie/h/5X+HR9eAh6/GL1fk=;
 b=LM80n50G72NEpDAmveB+ilx8xqvpxQQQqRDAZ35p96KRRBJ+hcjdNf5vVjzSvMfXmyiwrk
 85mWh19CBwsb6pQP6WQdluEpJs+FDE9v4uPQMOt7FJFUxQFW7raTcQuUoMkCOnFlNfjWTS
 TTKWKHHUhDmYRoqWLIipTRJ8hujeato=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-3o4Mr_P7OhWpaeuLXLiPQQ-1; Mon, 24 Jun 2024 11:10:40 -0400
X-MC-Unique: 3o4Mr_P7OhWpaeuLXLiPQQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-643f57e2f0fso39313837b3.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719241840; x=1719846640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8ols6Yx/7t5slsOmJ7Q7/Ie/h/5X+HR9eAh6/GL1fk=;
 b=e9RI6Q1sO3aPamquUrTfKe1tKV/zMBDAfxEZyZIzQ+Vn+d71RD6UMfFfxHh6ggVZEf
 JYfLHqqkvGTl+vwGhrulBqE00EsSZl++/5yYEMqnUpz1xML8iFtNHgLbXYZnPvEWK604
 fpAYMqZkyHSpoRWqsR22ANUZvoSEz3+LCvP1l6LaOWDYca8WFBxSxfz2T5jDK38TvfXo
 IEoOesoOrhHgLPYCVTI3S0cq9L7uAXCEUqKTs1ECBsfcbSV2Np4+5mn2FktD2auCbWfA
 YouBxHmvQJLJ9XYbJMOzXRFHqWq7RZeB3Hij9tKN9SQinGJCV2Y0uU7iOhCOs9KVSAsn
 GXlQ==
X-Gm-Message-State: AOJu0YyPBI5vldrK6t7CB7qVUbwHpLTTvcmdDxsfBO01FE0uDfk3CePP
 t3xlGXMf0v2qcQm246j49JfSn/0P1V5vBhtgtRsI0MnnBKWTMHqyPgzou/S2tvxbKePVGvrSaqz
 vjj0tsodC7pecBNFkbUNph8zBhHOwvSBhBIp/GaMv/9ez68cxT+2K0a+naSGsC9zdpGIRAyZP/Y
 gpJJPB+UrVm9ywzhG275tVYO7rKmU=
X-Received: by 2002:a25:80cf:0:b0:dfa:5a37:41d0 with SMTP id
 3f1490d57ef6-e0303f28997mr4420043276.7.1719241840001; 
 Mon, 24 Jun 2024 08:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu7DuI/nAYTVuwdla/sUIwqLcWDt+rtTNtYLZreyefK15Kj/kJvFTAg6PDn+J+TJcxUCHnOaR36/wQdq7mEyo=
X-Received: by 2002:a25:80cf:0:b0:dfa:5a37:41d0 with SMTP id
 3f1490d57ef6-e0303f28997mr4420017276.7.1719241839632; Mon, 24 Jun 2024
 08:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
In-Reply-To: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 24 Jun 2024 17:10:27 +0200
Message-ID: <CAGxU2F4Q5ewt442zGvUhfMuXYcRENEingFQVuu5VK_wQBizE3Q@mail.gmail.com>
Subject: Re: [Bug Report] Possible Missing Endianness Conversion
To: Xoykie <xoykie@gmail.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 thuth@redhat.com, cohuck@redhat.com, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

CCing Jason.

On Mon, Jun 24, 2024 at 4:30=E2=80=AFPM Xoykie <xoykie@gmail.com> wrote:
>
> The virtio packed virtqueue support patch[1] suggests converting
> endianness by lines:
>
> virtio_tswap16s(vdev, &e->off_wrap);
> virtio_tswap16s(vdev, &e->flags);
>
> Though both of these conversion statements aren't present in the
> latest qemu code here[2]
>
> Is this intentional?

Good catch!

It looks like it was removed (maybe by mistake) by commit
d152cdd6f6 ("virtio: use virtio accessor to access packed event")

Jason can you confirm that?

Thanks,
Stefano

>
> [1]: https://mail.gnu.org/archive/html/qemu-block/2019-10/msg01492.html
> [2]: https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L31=
4
>


