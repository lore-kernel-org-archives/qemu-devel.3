Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70377C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2zE-0005Dk-00; Mon, 19 Feb 2024 07:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rc2zC-0005DM-Gs
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:43:06 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rc2zA-0006FP-MA
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:43:06 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-564a53b8133so482306a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708346582; x=1708951382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Igj/YcOLZv7lNlFprRy6RN9htSHx/GFYE+0Gf3QIx5I=;
 b=DGmM4CC1do5x7uF56OD/+jSFLcnC4Cz/FyY1iQsc+tPWx4zJd50vz2twiock2ovjMB
 XJ4D4InGwqyLakREJYGMlxJWlhViRSdEq+gR6AT64ra77+NQLLvtXYl0QIEOiafu3/RA
 bBR9xw0uQc0UzLOuhHEIaWi92mXE0qjogImdFmMRuSNkN9MN/CgT6iVwzJbxZacfBdgn
 zalSg+I16CROaA9wCvKenBv5pCQq+rxmokaWNoeoDFIGbSfkkyzskBmqw97c9bplufzW
 ZZe1zPhmdvTSUMqjNqhNtUJFHnXnyV2A1oq7qi+dcO1gkGcHAqe0IKGd2IBr3NcxUMfK
 v5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708346582; x=1708951382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Igj/YcOLZv7lNlFprRy6RN9htSHx/GFYE+0Gf3QIx5I=;
 b=nbGO6SsY7TtYlZ7nugEFn1xmv9JLqdTX8xmPcqKOzycHpjWuX4i9XfoqmOElNJt1t5
 0QmEUWM+R6k6K/6jTsO4YmcY6bPNBj/wylE14O4qIEuQcA8bpM/w/hn0RO3TOg97sqt6
 s9vcTBPtdLTfTsCtGOCWyKkf9qBcd0rnl1+k2vo5njYLr9Poe7OR74O9l9gez0ezrbTC
 G/mrMQuUr+uHzXPLjoIGuSmcEcZetRvRlmnPV8Dxg2uw+XaGEtTs4sTTQlHIg4BZvAdY
 PJ2ciouyNKKcjuS1dfkJ01riFVCRbhMnSAP2/R2Hz78EOAa5xqcPbkRVXMthndnGHoc+
 gfKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMFdurT9vfp73pqtByg42ICqHLeLNchhmNOBv5hOlJkEw6dOpGCq2+ZAesMxkCWgSRTBZAq5eEe70d+z5aDU9YEdYuRWA=
X-Gm-Message-State: AOJu0Yz2KPzDk1MWHtEHNZo1vp8rH1lyZ105fqiQUszBhtJ+RhO17RVY
 kpmXonSpWF0g0ZqhZ0Mr/pB5zARETlAHNPm/o6voBVgRL9eZLFqcCabUeOO0Wu7rDmfK0q33sXk
 vI83wYaJmzNZsDu3XiKt32CneIgwnOwAOR59GXg==
X-Google-Smtp-Source: AGHT+IHsAbsUh/NLPlO5/CMyFOiIINmJDeAm88BDO+yskQ4raUdHdERcWN73VcpMeC+WPk5Uwo0LgQrZo04ECMizTo0=
X-Received: by 2002:a05:6402:31e1:b0:564:a91c:11c5 with SMTP id
 dy1-20020a05640231e100b00564a91c11c5mr281819edb.8.1708346582603; Mon, 19 Feb
 2024 04:43:02 -0800 (PST)
MIME-Version: 1.0
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
 <20240218083351.8524-2-vr_qemu@t-online.de>
In-Reply-To: <20240218083351.8524-2-vr_qemu@t-online.de>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 19 Feb 2024 14:42:46 +0200
Message-ID: <CAAjaMXb=GoT+n5Mr8K5qax5ix7NMURFWzhgQe7Rf2vwRWE-Wgg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] hw/audio/virtio-sound: fix segmentation fault in
 tx/rx xfer handler
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Volker, thanks for working on this,

On Sun, 18 Feb 2024 at 10:33, Volker R=C3=BCmelin <vr_qemu@t-online.de> wro=
te:
>
> A malicious guest may trigger a segmentation fault in the tx/rx xfer
> handlers. On handler entry the stream variable is initialized with
> NULL. If the first element of the virtio queue has an invalid size
> or an invalid stream id, the error handling code dereferences the
> stream variable NULL pointer.

Why not just add a bounds check and a null check instead?

>
> Don't try to handle the invalid virtio queue element with a stream
> queue. Instead, push the invalid queue element back to the guest
> immediately.

IIRC this will result in an infinite loop, because the code is
emptying the vq until virtqueue_pop returns NULL.

So if you add the invalid message back, the vq will never be empty.
Eventually you will loop over all invalid messages forever.

(Please correct me if I'm wrong of course!)

>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c         | 100 ++++++++++------------------------
>  include/hw/audio/virtio-snd.h |   1 -
>  2 files changed, 29 insertions(+), 72 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index e604d8f30c..b87653daf4 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -456,7 +456,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s=
, uint32_t stream_id)
>          stream->s =3D s;
>          qemu_mutex_init(&stream->queue_mutex);
>          QSIMPLEQ_INIT(&stream->queue);
> -        QSIMPLEQ_INIT(&stream->invalid);
>
>          /*
>           * stream_id >=3D s->snd_conf.streams was checked before so this=
 is
> @@ -611,9 +610,6 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIO=
SoundPCMStream *stream)
>          QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
>              count +=3D 1;
>          }
> -        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
> -            count +=3D 1;
> -        }
>      }
>      return count;
>  }
> @@ -831,47 +827,19 @@ static void virtio_snd_handle_event(VirtIODevice *v=
dev, VirtQueue *vq)
>      trace_virtio_snd_handle_event();
>  }
>
> -static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq=
)
> +static void push_bad_msg_resp(VirtQueue *vq, VirtQueueElement *elem)
>  {
> -    VirtIOSoundPCMBuffer *buffer =3D NULL;
> -    VirtIOSoundPCMStream *stream =3D NULL;
>      virtio_snd_pcm_status resp =3D { 0 };
> -    VirtIOSound *vsnd =3D VIRTIO_SND(vdev);
> -    bool any =3D false;
> -
> -    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> -        stream =3D vsnd->pcm->streams[i];
> -        if (stream) {
> -            any =3D false;
> -            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
> -                    buffer =3D QSIMPLEQ_FIRST(&stream->invalid);
> -                    if (buffer->vq !=3D vq) {
> -                        break;
> -                    }
> -                    any =3D true;
> -                    resp.status =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> -                    iov_from_buf(buffer->elem->in_sg,
> -                                 buffer->elem->in_num,
> -                                 0,
> -                                 &resp,
> -                                 sizeof(virtio_snd_pcm_status));
> -                    virtqueue_push(vq,
> -                                   buffer->elem,
> -                                   sizeof(virtio_snd_pcm_status));
> -                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
> -                    virtio_snd_pcm_buffer_free(buffer);
> -                }
> -                if (any) {
> -                    /*
> -                     * Notify vq about virtio_snd_pcm_status responses.
> -                     * Buffer responses must be notified separately late=
r.
> -                     */
> -                    virtio_notify(vdev, vq);
> -                }
> -            }
> -        }
> -    }
> +    size_t msg_sz;
> +
> +    resp.status =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    msg_sz =3D iov_from_buf(elem->in_sg,
> +                          elem->in_num,
> +                          0,
> +                          &resp,
> +                          sizeof(virtio_snd_pcm_status));
> +    virtqueue_push(vq, elem, msg_sz);
> +    g_free(elem);
>  }
>
>  /*
> @@ -890,11 +858,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *=
vdev, VirtQueue *vq)
>      size_t msg_sz, size;
>      virtio_snd_pcm_xfer hdr;
>      uint32_t stream_id;
> -    /*
> -     * If any of the I/O messages are invalid, put them in stream->inval=
id and
> -     * return them after the for loop.
> -     */
> -    bool must_empty_invalid_queue =3D false;
> +    bool notify =3D false;
>
>      if (!virtio_queue_ready(vq)) {
>          return;
> @@ -942,17 +906,16 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
>          continue;
>
>  tx_err:
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            must_empty_invalid_queue =3D true;
> -            buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer));
> -            buffer->elem =3D elem;
> -            buffer->vq =3D vq;
> -            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
> -        }
> +        push_bad_msg_resp(vq, elem);
> +        notify =3D true;
>      }
>
> -    if (must_empty_invalid_queue) {
> -        empty_invalid_queue(vdev, vq);
> +    if (notify) {
> +        /*
> +         * Notify vq about virtio_snd_pcm_status responses.
> +         * Buffer responses must be notified separately later.
> +         */
> +         virtio_notify(vdev, vq);
>      }
>  }
>
> @@ -972,11 +935,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *=
vdev, VirtQueue *vq)
>      size_t msg_sz, size;
>      virtio_snd_pcm_xfer hdr;
>      uint32_t stream_id;
> -    /*
> -     * if any of the I/O messages are invalid, put them in stream->inval=
id and
> -     * return them after the for loop.
> -     */
> -    bool must_empty_invalid_queue =3D false;
> +    bool notify =3D false;
>
>      if (!virtio_queue_ready(vq)) {
>          return;
> @@ -1021,17 +980,16 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
>          continue;
>
>  rx_err:
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            must_empty_invalid_queue =3D true;
> -            buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer));
> -            buffer->elem =3D elem;
> -            buffer->vq =3D vq;
> -            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
> -        }
> +        push_bad_msg_resp(vq, elem);
> +        notify =3D true;
>      }
>
> -    if (must_empty_invalid_queue) {
> -        empty_invalid_queue(vdev, vq);
> +    if (notify) {
> +        /*
> +         * Notify vq about virtio_snd_pcm_status responses.
> +         * Buffer responses must be notified separately later.
> +         */
> +         virtio_notify(vdev, vq);
>      }
>  }
>
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index 3d79181364..1209b122b9 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -151,7 +151,6 @@ struct VirtIOSoundPCMStream {
>      QemuMutex queue_mutex;
>      bool active;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> -    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
>  };
>
>  /*
> --
> 2.35.3
>

