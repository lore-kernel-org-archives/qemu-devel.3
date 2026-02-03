Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8D8E87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIhO-0000fc-9i; Tue, 03 Feb 2026 10:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnIhM-0000ey-Bh
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnIhK-0002vF-Sl
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770133933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMh2DVjaLF1XUes7Ouut6z9VFTty5/vtSDQ8YlcVaic=;
 b=NccePUm4euDnCz1vv2uwJl3t8REVxZapDDJWovOgQHk5HF5BKG4Iut/L2KeKWXuZOEPgRT
 5ObSx4swPD8aWuFA44RCvJFjtT/VMlVFtyWwVIjzbUUnLEiJpDsQO48OReeVEXF9qEi1FX
 T+f9x5y3ACv26sioVCe0HG5FxkWZy7w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-Q1rv7bjpPOqFoKckPsnLAw-1; Tue, 03 Feb 2026 10:52:11 -0500
X-MC-Unique: Q1rv7bjpPOqFoKckPsnLAw-1
X-Mimecast-MFC-AGG-ID: Q1rv7bjpPOqFoKckPsnLAw_1770133930
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801d21c280so46722705e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770133930; x=1770738730; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WMh2DVjaLF1XUes7Ouut6z9VFTty5/vtSDQ8YlcVaic=;
 b=na40peDHU/86O4zbmpGVx2cf3+/iikFyGOFGuHIscg0rnSt7c90i3jWsv7I3FP37tl
 HzZERfkrup7vEm1l0gsfoQnf4kWWzoFSuISbnRZGySMxYDWJdWWWsPLHBiYQ5pUbb9TI
 m0k2KTNW9mkLyTmulFBEV9XV0iYj2nedhMJSlt1nDty/OIOrhFz038lsY5QRUNB5KHfS
 LEdtY+I0zv4/0UrhKpfiZZRUJTC48LukoAIRSgHfVo8DbI2IUAZ/M32MvjIpJ07JdZLd
 zQaSIjyCcCH50EqsdcfWEZuKfQSwdRNhdNxw7SgQZTyymH04egMxWJGd1VevRspo08tf
 mXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770133930; x=1770738730;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WMh2DVjaLF1XUes7Ouut6z9VFTty5/vtSDQ8YlcVaic=;
 b=k09V0QTQt5JAhtbhp7RLgdLWrDEd6qnE9eGtdV2FqoBYg8p62wQFj8Ynricn5EWDmv
 2ak6dJz6fFUZlsV/MBV4KvE2xeg0BHVSUoH0qyOBLgtxh3ZmphEzY2r9xg9WE2qZpBJB
 q8R27nO1BScqnR4t9t1QpZ8glFwTOx1u9KcuLtJ67wuN0DoJgqoXJi0QrobE0hoeiQkp
 KWc2QUu7UkFwIqqvS9TB/lthQVsBGJZQ4A+Bi08magN7cfHDg7+QwG7xn16+GaCTX/ts
 XRDrOiaHYaBZIit+2M+3DITceP+0ExUF3P0/49i7E7kJqpGuuTOxUmblsOFSYYQOl2sQ
 APtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk8uqn29znmTLV//COUPiZhJJ+1FuZEsI9OP7htxKPSnLVnMPAfSwf8RnR2Gez0cT8e4MPmT1CiK1c@nongnu.org
X-Gm-Message-State: AOJu0Yz9qtj/0VhppMmv2RfOp0LkAey51gH0bASq0SB3AN6mxq3JMdHi
 8ca/JlvcjiwFPMFB6v0oGKMxNA7YGMneyIdxPdCP+t6E3phoCOcjMywzTNA0KaZfVx7qqlqxsLZ
 Y2m+c1wBWOVwA3VvOeCETilPLfrtWgaa6gJ42k8Hy9OJgzFYwPcQylMac
X-Gm-Gg: AZuq6aIJy9Z6kzhr9bKaYd6KJOSiE7N59K5PFYLS7A66C3GxFtmolq0qnR7elRHp2h+
 58GE/E5xgAIUmmdcJz+qvIYVttVHN4JriflfGRj3mTv5pAUgcl/WMPw258MGAlu+iSy0KqAbwzq
 AblYYrWaY1lULNyuT8BpXEtYo7KU/Vc+do/gR/Osk0uUeACV0BJTcAyml91go6cGm+92IFTVS4O
 9MXpJWI15pknEk/DI6s7tIceO0qneZ0S2EqY/TzAJaphychWB1REC3YK2o063I5geuGpwD/5Emp
 Z7OmAlgjuNDAaA+0Fv8FsXnJoliS9g+zzlf1SviOE/ElmFyjp1FQN3sUeIefT6XA6PhMtYMzPHq
 XYR8OwzNRD1jqAYwUlQrhfm9cUnHJgKrJaA==
X-Received: by 2002:a05:600c:a088:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-4830e98388dmr851715e9.34.1770133929984; 
 Tue, 03 Feb 2026 07:52:09 -0800 (PST)
X-Received: by 2002:a05:600c:a088:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-4830e98388dmr851505e9.34.1770133929486; 
 Tue, 03 Feb 2026 07:52:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43614cc4868sm4809896f8f.11.2026.02.03.07.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 07:52:08 -0800 (PST)
Date: Tue, 3 Feb 2026 10:52:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Yanfeng Liu <yfliu2008@qq.com>, kraxel@redhat.com,
 qemu-devel@nongnu.org, Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
Subject: Re: [PATCH v1] audio/virtio-snd: fix latency calc
Message-ID: <20260203105150-mutt-send-email-mst@kernel.org>
References: <tencent_66E8C146EA79CD00E966DEDAEF8CACD97D05@qq.com>
 <CAAjaMXYV5M-Zkg=1ycopGJBRpcuR5HHx6Cp0FVkws4+QR0VEug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXYV5M-Zkg=1ycopGJBRpcuR5HHx6Cp0FVkws4+QR0VEug@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 15, 2025 at 12:08:07PM +0200, Manos Pitsidianakis wrote:
> On Fri, Nov 14, 2025 at 11:35 AM Yanfeng Liu <yfliu2008@qq.com> wrote:
> >
> > Media players needs meaningful latency_bytes update but it is
> > zero now most of the time. This adds stream-wise latency_bytes
> > calculation so that to improve the situation.
> >
> > Signed-off-by: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
> > ---

Manos what do you want to do with this patch?

> 
> Thanks for this patch. The virtio spec doesn't adequately explain what
> latency_bytes means, could you explain what it does and why it's
> needed? And also what behavior in media players this patch fixes?
> 
> Thanks again!
> 
> >  hw/audio/virtio-snd.c         | 12 +++++++++++-
> >  include/hw/audio/virtio-snd.h |  1 +
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 9101560f38..ed0422b45a 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -431,6 +431,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
> >          stream->id = stream_id;
> >          stream->pcm = s->pcm;
> >          stream->s = s;
> > +        stream->latency_bytes = 0;
> >          qemu_mutex_init(&stream->queue_mutex);
> >          QSIMPLEQ_INIT(&stream->queue);
> >
> > @@ -899,6 +900,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
> >              buffer->vq = vq;
> >              buffer->size = size;
> >              buffer->offset = 0;
> > +            stream->latency_bytes += size;
> >
> >              QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
> >          }
> > @@ -1112,12 +1114,19 @@ error_cleanup:
> >      virtio_snd_unrealize(dev);
> >  }
> >
> > +static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
> > +{
> > +    s->latency_bytes = s->latency_bytes > used ?
> > +                       s->latency_bytes - used : 0;
> > +}
> > +
> >  static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
> >                                      VirtIOSoundPCMBuffer *buffer)
> >  {
> >      virtio_snd_pcm_status resp = { 0 };
> >      resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
> > -    resp.latency_bytes = cpu_to_le32((uint32_t)buffer->size);
> > +    update_latency(stream, buffer->size);
> > +    resp.latency_bytes = cpu_to_le32(stream->latency_bytes);
> >      iov_from_buf(buffer->elem->in_sg,
> >                   buffer->elem->in_num,
> >                   0,
> > @@ -1178,6 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
> >                  buffer->size -= size;
> >                  buffer->offset += size;
> >                  available -= size;
> > +                update_latency(stream, size);
> >                  if (buffer->size < 1) {
> >                      return_tx_buffer(stream, buffer);
> >                      break;
> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
> > index c176066584..9560bac8b1 100644
> > --- a/include/hw/audio/virtio-snd.h
> > +++ b/include/hw/audio/virtio-snd.h
> > @@ -150,6 +150,7 @@ struct VirtIOSoundPCMStream {
> >      } voice;
> >      QemuMutex queue_mutex;
> >      bool active;
> > +    uint32_t latency_bytes;
> >      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> >  };
> >
> > --
> > 2.34.1
> >


