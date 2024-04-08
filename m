Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E83C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjcZ-0007y6-Er; Mon, 08 Apr 2024 03:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtjcX-0007xh-6D
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:40:49 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtjcU-0002fJ-Vn
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:40:48 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dcbcea9c261so4259916276.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712562045; x=1713166845;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6TdT1MqLHsL0h0baBJt8PRFGb4BdHwo6IaErCVrNEE=;
 b=dQ86yYyJB4XvbAo6w+xmEO2an/jtBAs4Hzs2WBTxm1C1AgMzfk2oVU5iwJoL/C7xbf
 58jD3rn9EjQkhAu0HxavHpmTooM4aOAWo+d31roaRkKUnJRwRlIdgJPBo3uJTKDQdZAc
 p+PQm1YGrK0h7qMtd88FrIv/UN/WMVDYSrk38wgORdd9K8BYzawoZUlW6tEhyfrWuW3M
 reg1O8gi7RpVDSRJdJH8VAp4GAGyl/qL+fdNf75KcOM4YgflCJJb1EHF+bJ3sHZ9n3Gw
 41C0T96ypYRO9XqDqqT/ybqjPsqJOJVo5DiQo6hzKsoH5Q3uJ+vnp/sC/X4tLD99nUGC
 esWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712562045; x=1713166845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6TdT1MqLHsL0h0baBJt8PRFGb4BdHwo6IaErCVrNEE=;
 b=AXZgNB0n5DSo6+reSu5CYc5L9BJ5tI2k8Ek+0rpn2j7LGfGEJYQTxW7TJhFdLVs9dy
 wMi60ddYyF+H1pZIrjs3k6a3qAuaC2quhQ+L7dNE9EinUhKxYUe2uZVgkCW81Uw4S3Mu
 NraR1ABzv+d8c7NeovjnMT8Kvrf0ZWeVdx8j1MJZT6FaB8W/VX1KzjCofguEr0/0LWL2
 Xrp7ABqqSTWB+YWqYxyASRzSfyokzoV6D6wHNnG1u3S4PyLmA/dUN0dqEF6tuYdpdawo
 YvDV5JeyoYlPfNcbUdh8AIzoA6d84OxaxDcio3yrsswl53VlkKRoW/fsNrVZegc2D8Y5
 Zf0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw5ew2atE8vOrbFUXzpCYsb3uLSvmOXG2QcPEdh1mj14YrIfzwbF0koZiy91xy3JtWenHEOFUrO2wIUfZE/YiGNqmChZ8=
X-Gm-Message-State: AOJu0YxEIbVLEf9NxwnJ7IO4YQPULAyZaNcEvIUfy18wF3DIOASw3JHk
 yQzyBXEuq0NV3JHbo8uJZJEZMU39SHnlKJqIHdCVI1sUcCzB/mcRkyWbSfiBg9jqx/8nICzAfNy
 KKcN+yZlQ6YvyYHp4z+ycOaUDvRgvhTO5Ena5gQ==
X-Google-Smtp-Source: AGHT+IGpd1ofcRiUK/l1LEXEI6nG23nmuBktJoDQPZo8yfa6+AY6N0XMxAaa3kqSOHF4NDPbenS8wsyHjE7DROkRETw=
X-Received: by 2002:a25:b327:0:b0:dcd:30f9:eb6d with SMTP id
 l39-20020a25b327000000b00dcd30f9eb6dmr5177100ybj.57.1712562045659; Mon, 08
 Apr 2024 00:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-16-c6d87e69d38b@daynix.com>
 <CAOEp5Od=KUTHnikVBA7iWfdFPJ=T7hbJrSu4zwCiB_Q1P-Sz+Q@mail.gmail.com>
 <8010b335-4b46-456e-bf6e-c191cdc34964@daynix.com>
In-Reply-To: <8010b335-4b46-456e-bf6e-c191cdc34964@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 8 Apr 2024 10:40:34 +0300
Message-ID: <CAOEp5OeHJR=EeZ=yLovSD9vUPt-zRNKLo2k_fNZPP3W-eX4Fiw@mail.gmail.com>
Subject: Re: [PATCH v9 16/20] virtio-net: Do not write hashes to peer buffer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::b35;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-yb1-xb35.google.com
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

On Mon, Apr 8, 2024 at 4:30=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2024/04/08 7:09, Yuri Benditovich wrote:
> > On Wed, Apr 3, 2024 at 2:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> The peer buffer is qualified with const and not meant to be modified.
> >
> > IMHO, this buffer is not so 'const' (although the prototype states so),
> > it is allocated in net.c
> > btw, another procedure in this file also modifies the buffer
> > (work_around_broken_dhclient)
>
> Right but it has a FIXME comment.
>
> >
> >> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
> >> virtio-net header support.
> >
> > Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
> > for peers without
> > virtio-net header support? Where?
>
> No, but I meant that this patch fixes such a problem.

No, it does not. Such a problem does not exist in the master, the
hash_report feature
is silently dropped in such case:
https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L816

>
> Regards,
> Akihiko Odaki

