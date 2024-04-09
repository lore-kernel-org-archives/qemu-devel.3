Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE68AC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 03:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru2Ls-0005fJ-Ds; Mon, 08 Apr 2024 23:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ru2Lp-0005e8-Tl
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 23:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ru2Lm-0000QO-3g
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 23:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712634044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mDWqjuJuN4A9JmlRllVa9+HXvr5sgAPHKpCm5HkrhI=;
 b=iVZ2IoF8AfmO3Dot7L5TV5+AAT+aqvbyRR9dRPIL7E9rtxL21qVnX4fMQihhp1g8s2z2fx
 EDAUNtdjt2lxpBx9ROGvpbhMX7xuCWCpPLAWj5QnjTssf1hvRuBGVoYy1cLCOcSMah5K5E
 HdNccVzo0bJX12icnagv+gm+7u3DMIo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-lOlOb4bgMzqFVeS6OcJCVg-1; Mon, 08 Apr 2024 23:40:42 -0400
X-MC-Unique: lOlOb4bgMzqFVeS6OcJCVg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c66a69ec8eso3739942a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 20:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712634041; x=1713238841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mDWqjuJuN4A9JmlRllVa9+HXvr5sgAPHKpCm5HkrhI=;
 b=NDfAZe+vK4LgutqyfHOoG0AVV4jJNCERm0X/V3W8wAo7zyWj8zvSAGXm8Zb4TX2oR7
 qGRV8XQp824QFbQ3uqxIJIr8KASJU6GWhBJFRsrfk8ZwWkPhU+JT0cx36jz/4Td/CNHt
 d42XrVm7OBYvIWsKwo5/1sFH2KZXb1+FOJzN7nHFn0wD7fwnNFLkaSR+9ZWL0dfCWhzc
 aVLKLXVLkwkf3p2PPPTFfUPYpYg/O4/Ub5iTPLCHKc/Es2HoPfUO2Vqwd0JRfAAOviwT
 ityfBNffuYynLwEvCxPkzXDBp4EuWXAYJuPv2ObuvxzExYVEJjkaM0P2DhnsmZeOirn9
 gZWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp4nYF9e7ki2NKZ4A9IMMcevl8DTE7OTMqeRAjPTdHziK0HvruW7RsLemQnttIB+tp/jrapyPIPQu4KHdaWfOQaAunh3M=
X-Gm-Message-State: AOJu0Yx7WDhSP33NbB3toQ2ipVMKv7OjxxBm2RLfmX4aicT4FzH8hequ
 gOL1Hvt2LuBwWEnuFk+b2Kz7IBCjGszizQw9/PpDsWtrDeixWeVsxF0OXTY6ufeIT1JF27aP6g4
 /IR4Eshgm8PKYVKjqgotFBG55LQUmG2e5EJUHWQCJRMnMe4VdBQomNYdyqH2GQpQFgqey6vjuUt
 G0+knz/wd3tuBKM49zOZidOsj4loU=
X-Received: by 2002:a05:6a20:c892:b0:1a7:4f8b:6439 with SMTP id
 hb18-20020a056a20c89200b001a74f8b6439mr10028624pzb.34.1712634041683; 
 Mon, 08 Apr 2024 20:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkh6Xri0yR11NRztpOZqqBp+DqppukjKdejdKyFLedjeaxwV3Xuf9aGFBeQQnZybOh65229ujOflO9kJgWt74=
X-Received: by 2002:a05:6a20:c892:b0:1a7:4f8b:6439 with SMTP id
 hb18-20020a056a20c89200b001a74f8b6439mr10028612pzb.34.1712634041391; Mon, 08
 Apr 2024 20:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
 <20240326-vhost-v1-1-09bd85b1ba2c@daynix.com>
 <20240408061306-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240408061306-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 11:40:30 +0800
Message-ID: <CACGkMEuRJgJ_d_0ki2eXMcaZ46bfwO6AMcW0zwApTV+HEkf1ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: Fix vhost virtqueue notifiers for RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

On Mon, Apr 8, 2024 at 6:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Mar 26, 2024 at 07:06:29PM +0900, Akihiko Odaki wrote:
> > virtio_net_guest_notifier_pending() and virtio_net_guest_notifier_mask(=
)
> > checked VIRTIO_NET_F_MQ to know there are multiple queues, but
> > VIRTIO_NET_F_RSS also enables multiple queues. Refer to n->multiqueue,
> > which is set to true either of VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is
> > enabled.
> >
> > Fixes: 68b0a6395f36 ("virtio-net: align ctrl_vq index for non-mq guest =
for vhost_vdpa")
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Jason, are you merging this?

It has been merged:

https://gitlab.com/qemu-project/qemu/-/commit/ba6bb2ec953f10751f174b6f7da8f=
e7e5f008c08

Thanks


