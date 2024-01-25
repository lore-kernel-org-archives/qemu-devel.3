Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD86C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 18:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT44o-00028N-5U; Thu, 25 Jan 2024 13:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rT44l-00024S-Oj
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rT44j-0004Lv-Ks
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706205820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLn5NthawxaoNB5OXbCpHo9f4tYeIMJQ14cYuVpybxg=;
 b=bst5Wx3vY3BDUG4ElBmaAMcgeHkcmtBLcb/BLHpHRnpgj+GbFnZwzgDB7juYW1Z0ykfLUp
 6mvckqu5v76/WJ/NusR5yhrtmSrGvnWu5QJl6Io0YDDYbHU8bQ2s1/ys61dBuZaUwYw0BV
 0Wm/Rf3yfWXk66M0uenQLStBfJj8AL4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-3MTE1ohrMg2tpTq_Xn9DRA-1; Thu,
 25 Jan 2024 13:03:34 -0500
X-MC-Unique: 3MTE1ohrMg2tpTq_Xn9DRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A665E383CCEC;
 Thu, 25 Jan 2024 18:03:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9D8E1121306;
 Thu, 25 Jan 2024 18:03:32 +0000 (UTC)
Date: Thu, 25 Jan 2024 13:03:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 2/2] virtio: Keep notifications disabled during drain
Message-ID: <20240125180326.GA36016@fedora>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jGUfvYasmf9PHV2E"
Content-Disposition: inline
In-Reply-To: <20240124173834.66320-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--jGUfvYasmf9PHV2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 06:38:30PM +0100, Hanna Czenczek wrote:
> During drain, we do not care about virtqueue notifications, which is why
> we remove the handlers on it.  When removing those handlers, whether vq
> notifications are enabled or not depends on whether we were in polling
> mode or not; if not, they are enabled (by default); if so, they have
> been disabled by the io_poll_start callback.
>=20
> Because we do not care about those notifications after removing the
> handlers, this is fine.  However, we have to explicitly ensure they are
> enabled when re-attaching the handlers, so we will resume receiving
> notifications.  We do this in virtio_queue_aio_attach_host_notifier*().
> If such a function is called while we are in a polling section,
> attaching the notifiers will then invoke the io_poll_start callback,
> re-disabling notifications.
>=20
> Because we will always miss virtqueue updates in the drained section, we
> also need to poll the virtqueue once after attaching the notifiers.
>=20
> Buglink: https://issues.redhat.com/browse/RHEL-3934
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/block/aio.h |  7 ++++++-
>  hw/virtio/virtio.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 5d0a114988..8378553eb9 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -480,9 +480,14 @@ void aio_set_event_notifier(AioContext *ctx,
>                              AioPollFn *io_poll,
>                              EventNotifierHandler *io_poll_ready);
> =20
> -/* Set polling begin/end callbacks for an event notifier that has alread=
y been
> +/*
> + * Set polling begin/end callbacks for an event notifier that has alread=
y been
>   * registered with aio_set_event_notifier.  Do nothing if the event noti=
fier is
>   * not registered.
> + *
> + * Note that if the io_poll_end() callback (or the entire notifier) is r=
emoved
> + * during polling, it will not be called, so an io_poll_begin() is not
> + * necessarily always followed by an io_poll_end().
>   */
>  void aio_set_event_notifier_poll(AioContext *ctx,
>                                   EventNotifier *notifier,
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7549094154..4166da9e97 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3556,6 +3556,17 @@ static void virtio_queue_host_notifier_aio_poll_en=
d(EventNotifier *n)
> =20
>  void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ct=
x)
>  {
> +    /*
> +     * virtio_queue_aio_detach_host_notifier() can leave notifications d=
isabled.
> +     * Re-enable them.  (And if detach has not been used before, notific=
ations
> +     * being enabled is still the default state while a notifier is atta=
ched;
> +     * see virtio_queue_host_notifier_aio_poll_end(), which will always =
leave
> +     * notifications enabled once the polling section is left.)
> +     */
> +    if (!virtio_queue_get_notification(vq)) {
> +        virtio_queue_set_notification(vq, 1);
> +    }
> +
>      aio_set_event_notifier(ctx, &vq->host_notifier,
>                             virtio_queue_host_notifier_read,
>                             virtio_queue_host_notifier_aio_poll,
> @@ -3563,6 +3574,13 @@ void virtio_queue_aio_attach_host_notifier(VirtQue=
ue *vq, AioContext *ctx)
>      aio_set_event_notifier_poll(ctx, &vq->host_notifier,
>                                  virtio_queue_host_notifier_aio_poll_begi=
n,
>                                  virtio_queue_host_notifier_aio_poll_end);
> +
> +    /*
> +     * We will have ignored notifications about new requests from the gu=
est
> +     * during the drain, so "kick" the virt queue to process those reque=
sts
> +     * now.
> +     */
> +    virtio_queue_notify(vq->vdev, vq->queue_index);

event_notifier_set(&vq->host_notifier) is easier to understand because
it doesn't contain a non-host_notifier code path that we must not take.

Is there a reason why you used virtio_queue_notify() instead?

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>  }
> =20
>  /*
> @@ -3573,14 +3591,38 @@ void virtio_queue_aio_attach_host_notifier(VirtQu=
eue *vq, AioContext *ctx)
>   */
>  void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioCon=
text *ctx)
>  {
> +    /* See virtio_queue_aio_attach_host_notifier() */
> +    if (!virtio_queue_get_notification(vq)) {
> +        virtio_queue_set_notification(vq, 1);
> +    }
> +
>      aio_set_event_notifier(ctx, &vq->host_notifier,
>                             virtio_queue_host_notifier_read,
>                             NULL, NULL);
> +
> +    /*
> +     * See virtio_queue_aio_attach_host_notifier().
> +     * Note that this may be unnecessary for the type of virtqueues this
> +     * function is used for.  Still, it will not hurt to have a quick lo=
ok into
> +     * whether we can/should process any of the virtqueue elements.
> +     */
> +    virtio_queue_notify(vq->vdev, vq->queue_index);
>  }
> =20
>  void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ct=
x)
>  {
>      aio_set_event_notifier(ctx, &vq->host_notifier, NULL, NULL, NULL);
> +
> +    /*
> +     * aio_set_event_notifier_poll() does not guarantee whether io_poll_=
end()
> +     * will run after io_poll_begin(), so by removing the notifier, we d=
o not
> +     * know whether virtio_queue_host_notifier_aio_poll_end() has run af=
ter a
> +     * previous virtio_queue_host_notifier_aio_poll_begin(), i.e. whether
> +     * notifications are enabled or disabled.  It does not really matter=
 anyway;
> +     * we just removed the notifier, so we do not care about notificatio=
ns until
> +     * we potentially re-attach it.  The attach_host_notifier functions =
will
> +     * ensure that notifications are enabled again when they are needed.
> +     */
>  }
> =20
>  void virtio_queue_host_notifier_read(EventNotifier *n)
> --=20
> 2.43.0
>=20

--jGUfvYasmf9PHV2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWyom4ACgkQnKSrs4Gr
c8jikQf/Sz45NWzHt/cjpIDqMX1Boam7tDOAkVdOUj4GYi3+jrk+3a11x1FYXyLB
0toKrIlcl0zMgoM4/36w6+6jslA17rtfFgXnN8i8m8SftgFdRpbFZvP1oebJfeej
DXR0yXoFXDnrwxn6srCcOIs2lg1SxtNcmDDLdkWXNmZTdEjUbhsV7mXE4TB+R0Jd
+TiZz/bAFMTOdD8Km1HnlVtlrHKOUQptZ23NYQ2DQXrm8OXU5RMMPDcF6YsQZ6eL
c7Z2rnaTY7QiVeIblQZQn6Vynk9pyjb4Rqls6ilB68KwywEtIHGSF/nS+8iZ57FM
c0JfzX9IGn3CsqM806TU8rCBOJ43cA==
=1nWS
-----END PGP SIGNATURE-----

--jGUfvYasmf9PHV2E--


