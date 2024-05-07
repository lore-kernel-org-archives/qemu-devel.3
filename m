Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E94EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4F2q-0003eQ-28; Tue, 07 May 2024 03:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4F2j-0003Xl-U7
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4F2h-0003BF-B3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6avkvtHt/qOgI2pQAbXBg8UxCMSZ2xrpYYaNnSE9h0Q=;
 b=LIPzze65bU7SqDz8/cICeuSwhTzjJb5Cqd8h+3EI335QU01UATkkYeeOGi2WThgCxTi86v
 ftsRiQE1ITU6ua58V1wXXE8TbDy4uYkC0PkHGRuOoU12DP5zeLCkyVU++iuahxBPPwciLk
 /t3CacMznebMFWuPFTTs6AOd8qz6ruY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-rGeEOjncOZWH63W6b8CdNQ-1; Tue, 07 May 2024 03:15:11 -0400
X-MC-Unique: rGeEOjncOZWH63W6b8CdNQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61bb09d8fecso52144937b3.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066110; x=1715670910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6avkvtHt/qOgI2pQAbXBg8UxCMSZ2xrpYYaNnSE9h0Q=;
 b=Dt/b4DC8oNu9fi8GbONtIMb7DiM7OxPWsFsK3FW6qfyvcAteiR/1LEiVPWKUmOnOKA
 0ciSLWD7dnHKun78pMKUpTt9i9Z/3RgIoFqjnhgpOKbvAwaIODstE+gDsDo50FcEzXJH
 7nsgKsEyubTz/IlqyDu+6hiRjTK4OdsAFP2Q9ez5pMrdHe5RRW+Xf4zUoph/WtBqaZdw
 5WF5szR8aZzngqpwT2qVLktGc58+LQOtHhSaiMGWd6iiKQx84jjDvy5Arpkz8GAS/rAA
 mxKUhoY3l35hdfDn63cj6zr4F52oZ0gUebyufMZ27uLszIllf60kWrLRloPyVsTssJVo
 CT4g==
X-Gm-Message-State: AOJu0YyH0ilc6pyWGpRwNEtmm50dPPEMHZwaOA8+CfObPbO5MolyGp8p
 hp/fNNUSMkour2XmeCkW9zn1J+0S88Bw52I1n8010A0T9g4FpBmlgI4Se1ZWINPufF5kABvH2hp
 ytMokSRZYgOm/mfdRFBaWvBGcEOen8oQrrPXW2yRmm0gO6DMDeLss1ZaKxopyh00Lxsx2nAoO6X
 tE3eMaqmBto1djnu0p8ZSD2+NGWsE=
X-Received: by 2002:a5b:c0a:0:b0:de4:7bae:d57f with SMTP id
 f10-20020a5b0c0a000000b00de47baed57fmr11677937ybq.38.1715066110573; 
 Tue, 07 May 2024 00:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNAqL2nEQQyAStr+SJPOWhoozDkwgWwIwE6GiF2mAxyzeb1TP8a5DgTVAYYzi9aCLC7oy0lrMsF4yFkxNgaWM=
X-Received: by 2002:a5b:c0a:0:b0:de4:7bae:d57f with SMTP id
 f10-20020a5b0c0a000000b00de47baed57fmr11677917ybq.38.1715066110227; Tue, 07
 May 2024 00:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWdD7futYvUFt7=zV1xsoBdyAET6mvneOOjR2oob2U1-qg@mail.gmail.com>
 <4912056.31r3eYUQgx@valdaarhun> <13514535.uLZWGnKmhe@valdaarhun>
In-Reply-To: <13514535.uLZWGnKmhe@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 7 May 2024 09:14:33 +0200
Message-ID: <CAJaqyWeYtyfGav9Ppx=FgRg_Gzucaoz4T3kVi9EbzrDwwEBsyQ@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 6, 2024 at 9:00=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote:
>
> Hi,
>
> It's been a while since I last gave an update. Sorry about that. I am rea=
dy
> to get my hands dirty and start with the implementation.
>

No worries!

> I have gone through the source of linux's drivers/virtio/virtio_ring.c [1=
], and
> QEMU's hw/virtio/virtio.c [2] and hw/virtio/vhost-shadow-virtqueue.c [3].
>
> Before actually starting I would like to make sure I am on the right trac=
k. In
> vhost-shadow-virtqueue.c, there's a function "vhost_svq_add" which in tur=
n
> calls "vhost_svq_add_split".
>
> Shall I start by implementing a mechanism to check if the feature bit
> "VIRTIO_F_RING_PACKED" is set (using "virtio_vdev_has_feature")? And
> if it's supported, "vhost_svq_add" should call "vhost_svq_add_packed".
> Following this, I can then start implementing "vhost_svq_add_packed"
> and progress from there.
>
> What are your thoughts on this?
>

Yes, that's totally right.

I recommend you to also disable _F_EVENT_IDX to start, so the first
version is easier.

Also, you can send as many incomplete RFCs as you want. For example,
you can send a first version that only implements reading of the guest
avail ring, so we know we're aligned on that. Then, we can send
subsequents RFCs adding features on top.

Does that make sense to you?

Thanks!

> Thanks,
> Sahil
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/virtio/virtio.c
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/virtio.c
> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c
>
>


