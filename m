Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8BFC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 03:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOU60-0000xT-Go; Mon, 01 Jul 2024 23:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sOU5w-0000x4-4F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 23:22:16 -0400
Received: from va-2-31.ptr.blmpb.com ([209.127.231.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sOU5q-0000zy-E7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 23:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1719890521;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+SknTLPJVuQi9xZV/4d+xkEdL76Z4dRMYlyZs7Xw1SA=;
 b=2Jdv7Gg6oPDLFw4S1cm0JI3nftx5AqRStQcUgdJI+5Yrxq0Mm/PfQcTQ3SKXgW1G7y27GU
 lvEe0pYtDbO2nMmlnenlNIa+VKj1yR+KYiAU4D3cQI5i5eROU9ZEwt3yhnJpMEElRjKTuZ
 NbMTPkWVDqqZxC8EzfHLY4e/g8rv3OAjjHqBjJX5ZgV4NS2gN5nkhdpewOfMnBDGDA+QXp
 hJMxNJt8uWnd98Ve4PCkeh83FumE9fQUZHUNICrgWgHEa4i/zKNeGCFyCO54aQn0ZZ1n6O
 7So+fx5G7UM1Dz5kAoC3rpUeDVnXAL8ISzwtGLjHlWQ+EPDWs4+9whEgkGv0IA==
References: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
 <87zfr1qyyi.fsf@draig.linaro.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.8eed26c3.aba1.4d51.9976.281bbad0a8e6@feishu.cn>
 <87msn1qh44.fsf@draig.linaro.org>
 <20240701111531-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240701111531-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jul 2024 11:22:00 +0800
Cc: "qemu-devel" <qemu-devel@nongnu.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Mime-Version: 1.0
From: "BillXiang" <xiangwencheng@dayudpu.com>
X-Lms-Return-Path: <lba+166837259+94e97d+nongnu.org+xiangwencheng@dayudpu.com>
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.99dff509.6d6b.4f87.8578.07e0e577b0c1@feishu.cn>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
Received-SPF: pass client-ip=209.127.231.31;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-31.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> From: "Michael S. Tsirkin"<mst@redhat.com>
> Date:=C2=A0 Mon, Jul 1, 2024, 23:17
> Subject:=C2=A0 Re: [PATCH] vhost-user: Skip unnecessary duplicated VHOST_=
USER_SET_LOG_BASE requests
> To: "Alex Benn=C3=A9e"<alex.bennee@linaro.org>
> Cc: "BillXiang"<xiangwencheng@dayudpu.com>, <qemu-devel@nongnu.org>
> On Mon, Jul 01, 2024 at 04:14:35PM +0100, Alex Benn=C3=A9e wrote:
> > "BillXiang" <xiangwencheng@dayudpu.com> writes:
> >=C2=A0
> > >> From: "Alex Benn=C3=A9e"<alex.bennee@linaro.org>
> > >> Date:=C2=A0 Mon, Jul 1, 2024, 16:49
> > >> Subject:=C2=A0 Re: [PATCH] vhost-user: Skip unnecessary duplicated V=
HOST_USER_SET_LOG_BASE requests
> > >> To: "=E9=A1=B9=E6=96=87=E6=88=90"<xiangwencheng@dayudpu.com>
> > >> Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>
> > >> =E9=A1=B9=E6=96=87=E6=88=90 <xiangwencheng@dayudpu.com> writes:
> > >>=C2=A0
> > >> > From: BillXiang <xiangwencheng@dayudpu.com>
> > >> >
> > >> > The VHOST_USER_SET_LOG_BASE requests should be categorized into
> > >> > non-vring specific messages, and should be sent only once.
> > >> > If send more than once, dpdk will munmap old log_addr which may ha=
s
> > >> > been used and cause segmentation fault.
> > >>=C2=A0
> > >> This looks fine to me but looking at the vhost-user.rst we don't see=
m to
> > >> make any explicit statements about how many times given messages sho=
uld
> > >> be sent.
> > >>=C2=A0
> > > There is indeed no explicit statements about how many times given mes=
sages
> > > =C2=A0should be sent in vhost-user.rst but already have some discussi=
ons such as=C2=A0
> > > https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst=
@kernel.org/.
> >=C2=A0
> > Right, but I think we should then update the specification if this is
> > the way we want things to work. Otherwise we are putting a backend
> > specific hack that another backend might be able to tolerate.

I agree with you that we should then update the specification and maybe for=
 vhost_user_per_device_request.

>=C2=A0
> I think it's a dpdk bug, we *allow* resending same message many times.
> However, less messages is better, I don't see a reason to
> repeat the same message many times.
>=C2=A0

Of course these repeated VHOST_USER_SET_LOG_BASE can be handled by dpdk=C2=
=A0
and it's what I did now. When live migration started, I have some extra-cod=
e to wait=C2=A0
for the final log_base but I think it's ugly.=C2=A0
AFAIK it's better to resolve this by vhost_user_per_device_request and it's=
 what "per_device"
really mean.

> > >> >
> > >> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > >> > ---
> > >> >=C2=A0 hw/virtio/vhost-user.c | 1 +
> > >> >=C2=A0 1 file changed, 1 insertion(+)
> > >> >
> > >> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > >> > index cdf9af4a4b..41e34edd49 100644
> > >> > --- a/hw/virtio/vhost-user.c
> > >> > +++ b/hw/virtio/vhost-user.c
> > >> > @@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(Vhos=
tUserRequest request)
> > >> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_RESET_DEVICE:
> > >> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_ADD_MEM_REG:
> > >> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_REM_MEM_REG:
> > >> > + =C2=A0=C2=A0 case VHOST_USER_SET_LOG_BASE:
> > >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return true;
> > >> > =C2=A0 =C2=A0=C2=A0 default:
> > >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return false;
> > >>=C2=A0
> > >> --=C2=A0
> > >> Alex Benn=C3=A9e
> > >> Virtualisation Tech Lead @ Linaro
> >=C2=A0
> > --=C2=A0
> > Alex Benn=C3=A9e
> > Virtualisation Tech Lead @ Linaro

