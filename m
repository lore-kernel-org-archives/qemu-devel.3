Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8508C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloaG-0008JN-25; Mon, 20 Jul 2026 10:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wloa8-00083p-D4; Mon, 20 Jul 2026 10:03:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wloa5-0007A6-Fj; Mon, 20 Jul 2026 10:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=deAIsGyaqzcj2x0SnSBtTCwTRpVH+o12cTxZxyGW6R8=; b=QAlDcnSvqzW2fsUfyEmW7V1BzL
 4b/4ygTcLe/Agh3ctzr4ClJBza+Yuo1Apd62xS7aRAT/vDM5sUp4Zzyxu/IaaE/YrIQCNXWCbTBIY
 6M5Psongq1IlSunPbN0v3zQ/yET3KSrnSDwURXmMwj4wXMue/C9CZwCj9f+N1Aj+v5W905HJ4GK9r
 w8hDHkFVTOFS0e3hw0gbGO5yEagQ8hwbeCU6C5cnRqCyIBC7TVE7iuffOnTEEykCgDwtWKAS77Z1R
 Q+fIQ1th70xhlAozDlr24L14gFYsvki4r4hC4Usb3wmzOOKFWkwn/n8RVP26u11Kh/RmthAkBVSnj
 +2kkfrpeFC+QFypRfXvtX2Z3a7KTe1nlxMSNd4DoIiBj6KAd0LSnr3iSIfl3SxaV/BXd7961QQkbH
 4Z4IjKyDGbpvx9gEL6A/J0xVbiRGhaTebs5JQPEYqqESX9WAIv46ISGEbVZOBUPQgasRsbzKRlxF0
 arMeA8/pxMPhKLR8fct4i/8nFNdx7u+39jYLKPawUPGCrX6iZUkamPbjU/M3+95Q6jr2FoYO3W0rj
 x2a7KI4GWEpLYOkleUHkBKnMqs2y5SX9dWIgk1hwsHriulHeRbi+wcGVE5e85vn6K5TrKFB1OH1eN
 zfWpl9H85+ZoNfe5UDenB6ZfD52Uye1TrmZlmfZyk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
Date: Mon, 20 Jul 2026 16:02:47 +0200
Message-ID: <7970030.EvYhyI6sBW@weasel>
In-Reply-To: <20260720-co-v1-7-fabb4db3c204@redhat.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-7-fabb4db3c204@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Monday, 20 July 2026 09:55:36 CEST Marc-Andr=C3=A9 Lureau wrote:
> All V9fsTransport callbacks are invoked exclusively from coroutine
> context (the v9fs_* PDU handlers). Annotate the function pointer
> types in V9fsTransport and all implementations (virtio and xen
> backends), as well as intermediate callers in 9p.c (pdu_marshal,
> pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/9pfs/9p.h               | 26 +++++++++++++++-----------
>  hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
>  hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
>  hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++-----------------
>  4 files changed, 64 insertions(+), 51 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 1a309664f6e..0e52ffbdf38 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
>  void v9fs_reset(V9fsState *s);
>=20
>=20
>  struct V9fsTransport {
> -    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const char =
*fmt,
> -                                va_list ap);
> -    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const cha=
r *fmt,
> -                                  va_list ap);
> -    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **pio=
v,
> -                                        unsigned int *pniov, size_t size=
);
> -    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **pi=
ov,
> -                                         unsigned int *pniov, size_t siz=
e);
> -    void        (*push_and_notify)(V9fsPDU *pdu);
> -    size_t      (*msize_limit)(V9fsState *s);
> -    size_t      (*response_buffer_size)(V9fsPDU *pdu);
> +    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset,
> +                                             const char *fmt, va_list ap=
);
> +    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offs=
et,
> +                                               const char *fmt, va_list =
ap);
> +    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
> +                                                     struct iovec **piov,
> +                                                     unsigned int *pniov,
> +                                                     size_t size);
> +    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu,
> +                                                      struct iovec **pio=
v,
> +                                                      unsigned int *pnio=
v,
> +                                                      size_t size);
> +    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
> +    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
> +    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu);
>  };

I wonder whether that could be made more diff/blame-friendly. Especially as
this currently only serves documentation purposes.

They way you are positioning coroutine_fn it usually resolves to an attribu=
te
attached to the function's return type, not to the function itself, even
though clang/gcc handling it flexible. For attaching an attribute to the
function itself the attribute should either be attached before the function
declaration or after the function declaration. In both cases you could then
add it to its own, separate line, avoiding a lot of noise.

/Christian




