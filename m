Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B27C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 13:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivop-0008BW-NE; Tue, 27 Aug 2024 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sivob-00088H-NJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:00:58 -0400
Received: from va-2-31.ptr.blmpb.com ([209.127.231.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sivoW-0002ot-2C
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1724763637;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sCJgXjoQWhEbuDsgDnCbLPMOLYoQIv31SoExaC9HSJM=;
 b=RQpRnWslM2jXKLQEv6yn4fY4QpaFoLUj+ciUqW6Szjd7/LJWf9clJi8MfO9huVYTaRfn2D
 EwDiwKofHXMGXm9Py0ac0u1c377/GsuMmT6fNkkQ64ijJyrfbdVPIRHYsSkzikXlZIfEQP
 gCpY1+AAWSaIJu8nHZ8Ihb/j0395cB/1oKpB3fNOqeqJwyu87RbtME6FTEP1E3vpmBcixd
 m1ZLk1/9cUwpeT9Fm/qArkuB3FdfkL5KLI/dBI9Qm76ay3KAyoY8bKv9LjarQ4JiDIrP+h
 l2rHUV99iTRct331sA8w9pkI9wD/5pVWIscx4E8Ioq2jGav8iXoJzanivNXoGA==
To: "Prasad Pandit" <ppandit@redhat.com>
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
From: "BillXiang" <xiangwencheng@dayudpu.com>
X-Lms-Return-Path: <lba+166cdcdf4+fbcd8d+nongnu.org+xiangwencheng@dayudpu.com>
In-Reply-To: <CAE8KmOz1QH_gT=nOvovqTj+th=uMxEvacGxN4ndTYwz=dPxrHg@mail.gmail.com>
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
 <20240801101210-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
 <CAE8KmOxPS2QsWOesKg7h_euSV7r-z4NPZ9vMvTLY6tOudqJjuA@mail.gmail.com>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.aef11064.252c.4e66.b54f.0729a2c3aa1c@feishu.cn>
 <CAE8KmOz1QH_gT=nOvovqTj+th=uMxEvacGxN4ndTYwz=dPxrHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Aug 2024 21:00:35 +0800
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.a3d7ed0c.8388.4f30.8938.ed24afc64c52@feishu.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.231.31;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-31.ptr.blmpb.com
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
> Date:=C2=A0 Tue, Aug 27, 2024, 20:37
> Subject:=C2=A0 Re: [PATCH v3] vhost-user: Do not wait for reply for not s=
ent VHOST_USER_SET_LOG_BASE
> To: "BillXiang"<xiangwencheng@dayudpu.com>
> Cc: "Michael S. Tsirkin"<mst@redhat.com>, <qemu-devel@nongnu.org>
> On Tue, 27 Aug 2024 at 16:50, BillXiang <xiangwencheng@dayudpu.com> wrote=
:
> > it's better to be consistent to use vhost_user_per_device_request for t=
hose per-device messages, right?
>=C2=A0
> * ...consistent to use? Could you please elaborate a little?
>=C2=A0
> Thank you.
> ---
> =C2=A0 - Prasad

That was elaborated in commit b931bfbf0429 (" vhost-user: add multiple queu=
e support ").=C2=A0
We have added vhost_user_one_time_request() to send those per-device messag=
es only once=C2=A0
for multi-queue device. Which was then changed to vhost_user_per_device_req=
uest() in=C2=A0
commit 0dcb4172f2ce ("vhost-user: Change one_time to per_device request").
And VHOST_USER_SET_LOG_BASE should be one of those per-device messages that=
 only
be sent once for multi-queue device.

