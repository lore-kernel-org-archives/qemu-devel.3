Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B2BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUhn-0006qQ-2I; Mon, 10 Feb 2025 09:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1thUhf-0006nv-90
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1thUhc-0006tq-MJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739197438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxaybRZ7BGxq769aC0jV88M9OMPV1mZEdl1fPPpRDF8=;
 b=I3raDOpX97mwnL3RUdTuSg2pnzPIbl0Wi/jFnpE/bvkhxfsxKTpQB8QxChmb8UQ109BgiK
 KQe6wSWha/DkeRKk6ihiUNiRAeeU+H/K2PnTPd0+phov/t5AjaKGjHzeBu4MXEjB8ypeVq
 fbL1Fy+UwqMWzo1ts5vgLf6yrNr44Fw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-b02ouySXOfOFMek96gVHwQ-1; Mon, 10 Feb 2025 09:23:57 -0500
X-MC-Unique: b02ouySXOfOFMek96gVHwQ-1
X-Mimecast-MFC-AGG-ID: b02ouySXOfOFMek96gVHwQ
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e549de22484so5830222276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197436; x=1739802236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxaybRZ7BGxq769aC0jV88M9OMPV1mZEdl1fPPpRDF8=;
 b=r5wELiOkIScfZDjEcpwLYL1FVJHO8iTUa2ZlBzbQ9v0e0W+L8MS1wll03kknRvwyhu
 7wISOqpnN90ZhC3gaJe2bHdv5c7hndqQSevTp7dzeGHx+Y1xPybqYvly1WfjIhrSk251
 Nk70s/o3lzM0DFQBdTjBk/7dxghnhnLQYNliHUH7BJjZHRzwu8ByQaZoaHpPh8Tt9Cm1
 AySk1hV8q6y6+K4SrqmwUI5+b/qr6NBl6EY2wIzpZASmw5GMfCS/vAap+Mtfo2tzaVbq
 K1nT+o+wXcwd6yVmcg5zVekrwBdwl61z88JoFAm7i6mCiyghzHNQVIz8JnZTLAi8+gTU
 HpQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPXt52QunkycE6lCjoRS31vrYbdzpFTA7X5QDop9fWyyInrUuc7YKEKY0BerwVEdLPqsQfGI/qNkND@nongnu.org
X-Gm-Message-State: AOJu0YycHzBZA2Xz8VJGWV96ycPmqYDyiJh1WaF20YwoZnedlqQ7t8bW
 71h4GqhXIJ7KkYp34dLII8Ax32ybYDmgpunz60CvJpjyptkPoyxb4d25jhrNV5pCxsfRft9LbV9
 jKR0prfCsOoZjsnlhXSivz3+A71ve24LOPQktqP0kwTTV+NihRfQBnK/3e1uyVZvgcajYiPzc6i
 Em4m7mV1TcE/gXQB4vVMk6klZ79GM=
X-Gm-Gg: ASbGncuX7D0ljpl34SUpwDoLJC+hs5/dEd+sHDVaOSilRkZAbphL2bB/wNZASSdrnvD
 h4KU515RzhWX+N9QtbWpTFves5G7gJtOrUAVXOaLRqi0ZNnllDJxlcmpgH775
X-Received: by 2002:a05:6902:2407:b0:e5b:1088:e39e with SMTP id
 3f1490d57ef6-e5b4618d6cdmr9260322276.19.1739197436503; 
 Mon, 10 Feb 2025 06:23:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYAPlemQy3tpYQhkFi4wkOXHUmozaiHkfnq/7VZICNoVD7kDij8CfvX2tyO5W/MAI1nishkg3OlJsKInJJuvI=
X-Received: by 2002:a05:6902:2407:b0:e5b:1088:e39e with SMTP id
 3f1490d57ef6-e5b4618d6cdmr9260299276.19.1739197436203; Mon, 10 Feb 2025
 06:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <9b20ffc4-b55b-42c8-9847-a677c30c0051@gmail.com>
 <CAJaqyWf_9btBAtZ1TrUDpCh-eTD47ELHO5jxWJW3gOAZO0tMCw@mail.gmail.com>
 <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
 <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
 <4ee57bd3-5ea0-49a7-969e-c3fe902d8246@gmail.com>
 <CAJaqyWf9g_yAb6oYf_bJ5st9owKOzJDKbcWh6k+ZYZ3-mRSaVg@mail.gmail.com>
 <b5e90abd-9fa0-4ab8-9ad2-2b673f1c0784@gmail.com>
 <CAJaqyWcgEefe8EKeuY_hxPuPfdOk6yPiFw1gaY5fvKYc7vPo5g@mail.gmail.com>
 <91d6b4b3-be87-462c-9a0a-4f3fc8ebe4c1@gmail.com>
 <CAJaqyWfL9sWRgk-zMyW_+K0dAp18iDNw1AxJLoLHoSN=GA5_sg@mail.gmail.com>
 <dd634f4f-1539-44dd-8f97-6d1173dcd626@gmail.com>
 <CAJaqyWe3qTJhQrkP2gkmCeand_63O_R6ZNvWSgGJQpE-3Qz3aw@mail.gmail.com>
 <5ada25cb-405e-4587-b230-b6a3ce7dbdc2@gmail.com>
 <CAJaqyWfkOwC_-3N66Gq2EM+eXz7hNv3n+W_2W6XtJZ0iS8PQPw@mail.gmail.com>
 <360803dd-f1e0-48a3-8917-2477d8a821a9@gmail.com>
 <69a7da95-c050-4a22-b295-ff3c2eb34fb4@gmail.com>
In-Reply-To: <69a7da95-c050-4a22-b295-ff3c2eb34fb4@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 10 Feb 2025 15:23:19 +0100
X-Gm-Features: AWEUYZmdo2gotdJQ2LqR0T-bwe1ZUsELrCXJnELR1zCs62XP64tbJRFX_ZbvxDU
Message-ID: <CAJaqyWf4OLVmZn+g7B6X97QFUjRV9K=u-Bkr_OhRKUSsJgd6tg@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Mon, Feb 10, 2025 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
>
> Hi,
>
> On 2/6/25 8:47 PM, Sahil Siddiq wrote:
> > On 2/6/25 12:42 PM, Eugenio Perez Martin wrote:
> >> On Thu, Feb 6, 2025 at 6:26=E2=80=AFAM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >>> On 2/4/25 11:45 PM, Eugenio Perez Martin wrote:
> >>>> PS: Please note that you can check packed_vq SVQ implementation
> >>>> already without CVQ, as these features are totally orthogonal :).
> >>>>
> >>>
> >>> Right. Now that I can ping with the ctrl features turned off, I think
> >>> this should take precedence. There's another issue specific to the
> >>> packed virtqueue case. It causes the kernel to crash. I have been
> >>> investigating this and the situation here looks very similar to what'=
s
> >>> explained in Jason Wang's mail [2]. My plan of action is to apply his
> >>> changes in L2's kernel and check if that resolves the problem.
> >>>
> >>> The details of the crash can be found in this mail [3].
> >>>
> >>
> >> If you're testing this series without changes, I think that is caused
> >> by not implementing the packed version of vhost_svq_get_buf.
> >>
> >> https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg01902.html
> >>
> >
> > Oh, apologies, I think I had misunderstood your response in the linked =
mail.
> > Until now, I thought they were unrelated. In that case, I'll implement =
the
> > packed version of vhost_svq_get_buf. Hopefully that fixes it :).
> >
>
> I noticed one thing while testing some of the changes that I have made.
> I haven't finished making the relevant changes to all the functions which
> will have to handle split and packed vq differently. L2's kernel crashes
> when I launch L0-QEMU with ctrl_vq=3Don,ctrl_rx=3Don.

Interesting, is a similar crash than this? (NULL ptr deference on
virtnet_set_features)?

https://issues.redhat.com/browse/RHEL-391

> However, when I start
> L0-QEMU with ctrl_vq=3Doff,ctrl_rx=3Doff,ctrl_vlan=3Doff,ctrl_mac_addr=3D=
off, L2's
> kernel boots successfully. Tracing L2-QEMU also confirms that the packed
> feature is enabled. With all the ctrl features disabled, I think pinging
> will also be possible once I finish implementing the packed versions of
> the other functions.
>

Good!

> There's another thing that I am confused about regarding the current
> implementation (in the master branch).
>
> In hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_vring_write_descs() [1],
> svq->free_head saves the descriptor in the specified format using
> "le16_to_cpu" (line 171).

Good catch, this should be le16_to_cpu actually. But code wise is the
same, so we have no visible error. Do you want to send a patch to fix
it?

> On the other hand, the value of i is stored
> in the native endianness using "cpu_to_le16" (line 168). If "i" is to be
> stored in the native endianness (little endian in this case), then
> should svq->free_head first be converted to little endian before being
> assigned to "i" at the start of the function (line 142)?
>

This part is correct in the code, as it is used by the host, not
written to the guest or read from the guest. So no conversion is
needed.

Thanks!


