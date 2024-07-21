Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6C9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 03:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVNKa-0005ba-Sc; Sat, 20 Jul 2024 23:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sVNKY-0005aR-8I
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 23:33:50 -0400
Received: from va-2-34.ptr.blmpb.com ([209.127.231.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sVNKT-0000IV-Ty
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 23:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1721532817;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=z3b0CvkrXM2ETWMOqwe5RRm5DikdKxQJ/Bwj7OUK4Ls=;
 b=G1jno/VihdGdqTorUjz9QPR3GD8if6id+RNMNtDNWjkwSwwZNLfMEwXQXw2LpZsmi7wBJC
 y89wEbE/gTqZNwJe1IJOf/1y1RBD7lRzR9bD8SMRvwqDUdPn8dNBVZfLa7uS/RY2qGaXhc
 6nKINVOjCQR4FFk27Y+TiNKte0clw9aYNzX0Yjxqx6sZ1lUIUQ7ySVEM4/8czZbYCX4CXP
 tJod2/ieIIjp0k9BsBSjuszhKEm/hdtOwf+3SNN076esovinnv0jVLZJsKjwcWcEeuT05O
 R8p6HcKEVD1ppiL7sYVC2gYQSNkn1jDiRSgg7WIXmRsCT1ispL/cyfptFw43pQ==
References: <20240710074041.85984-1-xiangwencheng@dayudpu.com>
 <20240720151228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240720151228-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.40ef8521.83d4.4c10.b808.28a1b1443e13@feishu.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhsot-user: Remove redundant judgment
From: "BillXiang" <xiangwencheng@dayudpu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jul 2024 11:33:35 +0800
Cc: <qemu-devel@nongnu.org>, <alex.bennee@linaro.org>
X-Lms-Return-Path: <lba+1669c8190+6d9a98+nongnu.org+xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=209.127.231.34;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-34.ptr.blmpb.com
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
> Date:=C2=A0 Sun, Jul 21, 2024, 03:14
> Subject:=C2=A0 Re: [PATCH] vhsot-user: Remove redundant judgment
> To: "BillXiang"<xiangwencheng@dayudpu.com>
> Cc: <qemu-devel@nongnu.org>, <alex.bennee@linaro.org>
> On Wed, Jul 10, 2024 at 03:40:41PM +0800, BillXiang wrote:
> > From: BillXiang <xiangwencheng@dayudpu.com>
> >=C2=A0
> > Send only once has been supported in vhost_user_write by vhost_user_per=
_device_request
> >=C2=A0
> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
>=C2=A0
> I am confused by all the patches. Is it on top of your
> other patch or instead of? Because that one added
> the vq index check.
> If we are going to check vq index it's likely cleaner to
> always check it.
>=C2=A0

Yes, it's on top of commit 7c211eb078c4=C2=A0
("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests"=
) ,
and the check has been done in vhost_user_write=C2=A0
after VHOST_USER_SET_LOG_BASE be added=C2=A0
to vhost_user_per_device_request.

> And again, typos do not inspire confidence. How was this tested?
>=C2=A0
> > ---
> >=C2=A0 hw/virtio/vhost-user.c | 5 -----
> >=C2=A0 1 file changed, 5 deletions(-)
> >=C2=A0
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 00561daa06..04e3568b7e 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -446,11 +446,6 @@ static int vhost_user_set_log_base(struct vhost_de=
v *dev, uint64_t base,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 .hdr.size =3D sizeof(msg.payload.log)=
,
> > =C2=A0 =C2=A0=C2=A0 };
> > =C2=A0
> > - =C2=A0=C2=A0 /* Send only once with first queue pair */
> > - =C2=A0=C2=A0 if (dev->vq_index !=3D 0) {
> > - =C2=A0 =C2=A0 =C2=A0=C2=A0 return 0;
> > - =C2=A0=C2=A0 }
> > -
> > =C2=A0 =C2=A0=C2=A0 if (shmfd && log->fd !=3D -1) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fds[fd_num++] =3D log->fd;
> > =C2=A0 =C2=A0=C2=A0 }
> > --=C2=A0
> > 2.30.0

