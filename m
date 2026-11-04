Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E60606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3pWX/wn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZSn-000836-3j; Wed, 04 Nov 2026 06:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOZSk-00080z-9g
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOZSh-00062w-7d
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793792845;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMkud1RGrzW3a4Vn1L+ucbNUzkjspVE4HrrF00y4wz0=;
 b=O3pWX/wnXtOHV+F3qNo+7Kq/0XsBq5Gn7t/2b9am5r0r5JCeNMSB3S2LhWNdGU+UB8mtAy
 Hd1s8jW77z0lAV2VeMCaoWA3BcyDvba2ycxA2iVyFE2QzO9NCWfW5RI2RxQliz5aQvZsr8
 TaxbokCgRCU7KVgNpMX084ff/vv9jlo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-TajFfVZKMLSxu0yTE7DNXw-1; Wed,
 04 Nov 2026 06:47:23 -0500
X-MC-Unique: TajFfVZKMLSxu0yTE7DNXw-1
X-Mimecast-MFC-AGG-ID: TajFfVZKMLSxu0yTE7DNXw_1793792842
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39AD195605B; Wed,  4 Nov 2026 11:47:22 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33AD195608C; Wed,  4 Nov 2026 11:47:20 +0000 (UTC)
Date: Wed, 4 Nov 2026 11:47:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Anatol Belski <anbelski@linux.microsoft.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] hw/audio/virtio-sound: Report bytes written in used length
Message-ID: <ausbRfNzMzIwwMrA@redhat.com>
References: <20261001224501.1952113-1-anbelski@linux.microsoft.com>
 <003b6c73-91cf-4ef3-8943-6b8068cb2a64@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003b6c73-91cf-4ef3-8943-6b8068cb2a64@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Gerd/Manos,

Any feedback on these bug fixes for virtio-snd spec compliance,
to fix the virtio-villain test failures  ?

On Fri, Oct 02, 2026 at 06:50:37AM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing maintainers otherwise your patch won't be reviewed:
> 
> $ ./scripts/get_maintainer.pl -f hw/audio/virtio-snd.c
> "Michael S. Tsirkin" <mst@redhat.com> (supporter:virtio, gitlab:@mstredhat)
> Gerd Hoffmann <kraxel@redhat.com> (supporter:virtio-snd, gitlab:@kraxel)
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> (supporter:virtio-snd,
> gitlab:@epilys)
> qemu-devel@nongnu.org (open list:All patches CC here)
> 
> On 2/10/26 00:30, Anatol Belski wrote:
> > The control, invalid PCM, TX and RX completion paths pass fixed response
> > sizes to virtqueue_push() after copying into the guest's writable iovecs.
> > iov_from_buf() truncates the copy when those iovecs are undersized, so
> > the used length can exceed the writable descriptor capacity.
> > 
> > Use the byte count returned by iov_from_buf() for every completion.  For
> > PCM_INFO, retain the actual payload byte count so the control completion
> > also remains bounded when the requested element size is smaller than the
> > native structure.
> > 
> > Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> > ---
> > Tested with the following virtio-villain reproducers:
> > 
> > SND0005:
> > https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0005_info_size_short.c
> > 
> > SND0012:
> > https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0012_pcm_info_size_zero.c
> > 
> > SND0015:
> > https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0015_pcm_info_status_short.c
> > 
> > SND0065:
> > https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0065_tx_missing_status.c
> > 
> > SND0066:
> > https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0066_tx_status_short.c
> > 
> > Before this change all five tests fail because the used length exceeds
> > the writable descriptor capacity. With this change all five pass.
> > 
> >   hw/audio/virtio-snd.c | 82 +++++++++++++++++++++----------------------
> >   1 file changed, 40 insertions(+), 42 deletions(-)
> > 
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 6df7ea0eb0..52e12603dd 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -271,13 +271,12 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> >           memset(&pcm_info[i].padding, 0, 5);
> >       }
> > -    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
> >       cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
> > -    iov_from_buf(cmd->elem->in_sg,
> > -                 cmd->elem->in_num,
> > -                 sizeof(virtio_snd_hdr),
> > -                 pcm_info,
> > -                 cmd->payload_size);
> > +    cmd->payload_size = iov_from_buf(cmd->elem->in_sg,
> > +                                     cmd->elem->in_num,
> > +                                     sizeof(virtio_snd_hdr),
> > +                                     pcm_info,
> > +                                     sizeof(virtio_snd_pcm_info) * count);
> >   }
> >   /*
> > @@ -774,6 +773,7 @@ static inline void
> >   process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
> >   {
> >       uint32_t code;
> > +    size_t written;
> >       size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
> >                                  cmd->elem->out_num,
> >                                  0,
> > @@ -828,13 +828,12 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
> >           cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >       }
> > -    iov_from_buf(cmd->elem->in_sg,
> > -                 cmd->elem->in_num,
> > -                 0,
> > -                 &cmd->resp,
> > -                 sizeof(virtio_snd_hdr));
> > -    virtqueue_push(cmd->vq, cmd->elem,
> > -                   sizeof(virtio_snd_hdr) + cmd->payload_size);
> > +    written = iov_from_buf(cmd->elem->in_sg,
> > +                           cmd->elem->in_num,
> > +                           0,
> > +                           &cmd->resp,
> > +                           sizeof(virtio_snd_hdr));
> > +    virtqueue_push(cmd->vq, cmd->elem, written + cmd->payload_size);
> >       g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
> >       s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
> >       virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > @@ -917,6 +916,7 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
> >       VirtIOSoundPCMBuffer *buffer = NULL;
> >       virtio_snd_pcm_status resp = { 0 };
> >       VirtIOSound *vsnd = VIRTIO_SND(vdev);
> > +    size_t written;
> >       g_assert(!QSIMPLEQ_EMPTY(&vsnd->invalid));
> > @@ -926,14 +926,12 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
> >           g_assert(buffer->vq == vq);
> >           resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > -        iov_from_buf(buffer->elem->in_sg,
> > -                     buffer->elem->in_num,
> > -                     0,
> > -                     &resp,
> > -                     sizeof(virtio_snd_pcm_status));
> > -        virtqueue_push(vq,
> > -                       buffer->elem,
> > -                       sizeof(virtio_snd_pcm_status));
> > +        written = iov_from_buf(buffer->elem->in_sg,
> > +                               buffer->elem->in_num,
> > +                               0,
> > +                               &resp,
> > +                               sizeof(virtio_snd_pcm_status));
> > +        virtqueue_push(vq, buffer->elem, written);
> >           QSIMPLEQ_REMOVE_HEAD(&vsnd->invalid, entry);
> >           virtio_snd_pcm_buffer_free(buffer);
> >       }
> > @@ -1216,17 +1214,17 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
> >                                       VirtIOSoundPCMBuffer *buffer)
> >   {
> >       virtio_snd_pcm_status resp = { 0 };
> > +    size_t written;
> > +
> >       resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
> >       update_latency(stream, buffer->size);
> >       resp.latency_bytes = cpu_to_le32(stream->latency_bytes);
> > -    iov_from_buf(buffer->elem->in_sg,
> > -                 buffer->elem->in_num,
> > -                 0,
> > -                 &resp,
> > -                 sizeof(virtio_snd_pcm_status));
> > -    virtqueue_push(buffer->vq,
> > -                   buffer->elem,
> > -                   sizeof(virtio_snd_pcm_status));
> > +    written = iov_from_buf(buffer->elem->in_sg,
> > +                           buffer->elem->in_num,
> > +                           0,
> > +                           &resp,
> > +                           sizeof(virtio_snd_pcm_status));
> > +    virtqueue_push(buffer->vq, buffer->elem, written);
> >       g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
> >       stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
> >       virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > @@ -1306,22 +1304,22 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
> >                                       VirtIOSoundPCMBuffer *buffer)
> >   {
> >       virtio_snd_pcm_status resp = { 0 };
> > +    size_t written;
> > +
> >       resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
> >       resp.latency_bytes = 0;
> >       /* Copy data -if any- to guest */
> > -    iov_from_buf(buffer->elem->in_sg,
> > -                 buffer->elem->in_num,
> > -                 0,
> > -                 buffer->data,
> > -                 buffer->size);
> > -    iov_from_buf(buffer->elem->in_sg,
> > -                 buffer->elem->in_num,
> > -                 buffer->size,
> > -                 &resp,
> > -                 sizeof(virtio_snd_pcm_status));
> > -    virtqueue_push(buffer->vq,
> > -                   buffer->elem,
> > -                   sizeof(virtio_snd_pcm_status) + buffer->size);
> > +    written = iov_from_buf(buffer->elem->in_sg,
> > +                           buffer->elem->in_num,
> > +                           0,
> > +                           buffer->data,
> > +                           buffer->size);
> > +    written += iov_from_buf(buffer->elem->in_sg,
> > +                            buffer->elem->in_num,
> > +                            buffer->size,
> > +                            &resp,
> > +                            sizeof(virtio_snd_pcm_status));
> > +    virtqueue_push(buffer->vq, buffer->elem, written);
> >       g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
> >       stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
> >       virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


