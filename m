Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C89C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuFT-0006NP-IX; Tue, 27 Aug 2024 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1siuFQ-0006Me-2P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:20:28 -0400
Received: from va-2-36.ptr.blmpb.com ([209.127.231.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1siuFK-0000Uk-K2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1724757609;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=l3H6O3wN8ygj5c0HjKSGZvvAAU3jpCr5zQmDySbw65o=;
 b=15Aczww05P4vA3g7Jf559gLQYlTccsQS+OFUFFgD15HyYf7f9nvtTwc2EqLZImKKSQZRxp
 R7l16Ffm8Gw93ZK+E+JvTwW+WOOvXvwttyDuvxflt5tuYMZQoSu1V20Rbf7ABgNMD83v+8
 w0Xh149zDybNrL0f19cvv6N12NuKpdlm/kH0Mxv1hl1NoVPvL03d1CzTWKnFZzkBJRImRj
 F+P7h/f/2cFWys7Na5rfTptGPJdGGUwuh48yyhYRy1PRKcoM4ZIqpZsNu2dJbAls3ONgTf
 jwS0V8pp0vVbiQGU5So1qbDhOn70Ox2qkF4OxVCsseLjLMXmHVVMS0Uw4tRHsw==
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.aef11064.252c.4e66.b54f.0729a2c3aa1c@feishu.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Mime-Version: 1.0
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
 <20240801101210-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
 <CAE8KmOxPS2QsWOesKg7h_euSV7r-z4NPZ9vMvTLY6tOudqJjuA@mail.gmail.com>
X-Lms-Return-Path: <lba+166cdb668+2697fc+nongnu.org+xiangwencheng@dayudpu.com>
Date: Tue, 27 Aug 2024 19:20:07 +0800
To: "Prasad Pandit" <ppandit@redhat.com>
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
In-Reply-To: <CAE8KmOxPS2QsWOesKg7h_euSV7r-z4NPZ9vMvTLY6tOudqJjuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.127.231.36;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-36.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


> From: "Prasad Pandit"<ppandit@redhat.com>
> Date:=C2=A0 Tue, Aug 27, 2024, 19:06
> Subject:=C2=A0 Re: [PATCH v3] vhost-user: Do not wait for reply for not s=
ent VHOST_USER_SET_LOG_BASE
> To: "BillXiang"<xiangwencheng@dayudpu.com>
> Cc: "Michael S. Tsirkin"<mst@redhat.com>, <qemu-devel@nongnu.org>
> On Thu, 1 Aug 2024 at 20:32, BillXiang <xiangwencheng@dayudpu.com> wrote:
> > > From: "Michael S. Tsirkin"<mst@redhat.com>
> > > How do things work now after 7c211eb078c4 then?
> >
> > It does not really work after 7c211eb078c4 and it's my mistake.
> > I forgot to submit the code to check vq_index in 7c211eb078c4.
> >
>=C2=A0
> * vhost_user_set_log_base() sends set log message only when (vq_index =3D=
=3D 0),
> =C2=A0 =C2=A0 -> https://github.com/qemu/qemu/commit/c98ac64cfb53ccb862a8=
0e818c3a19bdd386e61e
> =3D=3D=3D
> =C2=A0 =C2=A0 + =C2=A0=C2=A0 /* Send only once with first queue pair */
> =C2=A0 =C2=A0 + =C2=A0=C2=A0 if (dev->vq_index !=3D 0) {
> =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0=C2=A0 return 0;
> =C2=A0 =C2=A0 + =C2=A0=C2=A0 }
> =3D=3D=3D
>=C2=A0
> This should help to keep things working, no?
> ---
> =C2=A0 - Prasad

Yes, that works. But I think it's better to be consistent to use vhost_user=
_per_device_request for those per-device messages, right?

