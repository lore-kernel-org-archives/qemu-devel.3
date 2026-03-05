Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E97EEF33A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4jb-0007dV-NB; Thu, 05 Mar 2026 04:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy4jZ-0007dD-SX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy4jY-0000DT-6N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772701862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wJU1KBKmSwSgLpteqvzIOHm9qAkCS7MEXI8/2c9RhwY=;
 b=ZNQT4mDOlWn4h1s07WXSPAmhAABbkodbs0cdkQD0RUimSZ4ISmmOSeN+5wgnuwbRjeUPrd
 B/dJMNZqG3/vP+Ls2C9916fdPquMYOsDUWhxGv1EIoQ+BoCkgEQDOBZ99+73ZE0YynPd5c
 HdjaZlrJuoe4p9wVhfTDFv4GgC4t36Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-jPxYJkCJPKG8spDvJzW3kw-1; Thu,
 05 Mar 2026 04:10:59 -0500
X-MC-Unique: jPxYJkCJPKG8spDvJzW3kw-1
X-Mimecast-MFC-AGG-ID: jPxYJkCJPKG8spDvJzW3kw_1772701858
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05FBC1956088; Thu,  5 Mar 2026 09:10:58 +0000 (UTC)
Received: from [10.45.224.75] (unknown [10.45.224.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DBB21800671; Thu,  5 Mar 2026 09:10:53 +0000 (UTC)
Message-ID: <02fae69b-0022-4c0d-99ee-2c23c328d413@redhat.com>
Date: Thu, 5 Mar 2026 10:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw/audio/hda-codec: Remove HDAAudioState::use_timer
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250501230129.2596-1-philmd@linaro.org>
 <20250501230129.2596-10-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250501230129.2596-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 02/05/2025 01.01, Philippe Mathieu-Daudé wrote:
> The HDAAudioState::use_timer boolean was only set in the
> hw_compat_2_12[] array, via the 'use-timer=false' property.
> We removed all machines using that array, lets remove that
> property and all the code around it, like the compatibility
> callbacks.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/hda-codec.c | 91 +++++++-------------------------------------
>   1 file changed, 13 insertions(+), 78 deletions(-)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 66edad280f2..92e1fe65827 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -187,7 +187,6 @@ struct HDAAudioState {
>       /* properties */
>       uint32_t debug;
>       bool     mixer;
> -    bool     use_timer;
>   };
>   
>   static inline uint32_t hda_bytes_per_second(HDAAudioStream *st)
> @@ -366,58 +365,6 @@ static void hda_audio_output_cb(void *opaque, int avail)
>       hda_timer_sync_adjust(st, (wpos - rpos) - (B_SIZE >> 1));
>   }
>   
> -static void hda_audio_compat_input_cb(void *opaque, int avail)
> -{
> -    HDAAudioStream *st = opaque;
> -    int recv = 0;
> -    int len;
> -    bool rc;
> -
> -    while (avail - recv >= sizeof(st->compat_buf)) {
> -        if (st->compat_bpos != sizeof(st->compat_buf)) {
> -            len = AUD_read(st->voice.in, st->compat_buf + st->compat_bpos,
> -                           sizeof(st->compat_buf) - st->compat_bpos);
> -            st->compat_bpos += len;
> -            recv += len;
> -            if (st->compat_bpos != sizeof(st->compat_buf)) {
> -                break;
> -            }
> -        }
> -        rc = hda_codec_xfer(&st->state->hda, st->stream, false,
> -                            st->compat_buf, sizeof(st->compat_buf));
> -        if (!rc) {
> -            break;
> -        }
> -        st->compat_bpos = 0;
> -    }
> -}
> -
> -static void hda_audio_compat_output_cb(void *opaque, int avail)
> -{
> -    HDAAudioStream *st = opaque;
> -    int sent = 0;
> -    int len;
> -    bool rc;
> -
> -    while (avail - sent >= sizeof(st->compat_buf)) {
> -        if (st->compat_bpos == sizeof(st->compat_buf)) {
> -            rc = hda_codec_xfer(&st->state->hda, st->stream, true,
> -                                st->compat_buf, sizeof(st->compat_buf));
> -            if (!rc) {
> -                break;
> -            }
> -            st->compat_bpos = 0;
> -        }
> -        len = AUD_write(st->voice.out, st->compat_buf + st->compat_bpos,
> -                        sizeof(st->compat_buf) - st->compat_bpos);
> -        st->compat_bpos += len;
> -        sent += len;
> -        if (st->compat_bpos != sizeof(st->compat_buf)) {
> -            break;
> -        }
> -    }
> -}
> -
>   static void hda_audio_set_running(HDAAudioStream *st, bool running)
>   {
>       if (st->node == NULL) {
> @@ -428,16 +375,14 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
>       }
>       st->running = running;
>       trace_hda_audio_running(st->node->name, st->stream, st->running);
> -    if (st->state->use_timer) {
> -        if (running) {
> -            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -            st->rpos = 0;
> -            st->wpos = 0;
> -            st->buft_start = now;
> -            timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
> -        } else {
> -            timer_del(st->buft);
> -        }
> +    if (running) {
> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        st->rpos = 0;
> +        st->wpos = 0;
> +        st->buft_start = now;
> +        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
> +    } else {
> +        timer_del(st->buft);
>       }
>       if (st->output) {
>           AUD_set_active_out(st->voice.out, st->running);
> @@ -474,7 +419,6 @@ static void hda_audio_set_amp(HDAAudioStream *st)
>   
>   static void hda_audio_setup(HDAAudioStream *st)
>   {
> -    bool use_timer = st->state->use_timer;
>       audio_callback_fn cb;
>   
>       if (st->node == NULL) {
> @@ -485,21 +429,13 @@ static void hda_audio_setup(HDAAudioStream *st)
>                              fmt2name[st->as.fmt], st->as.freq);
>   
>       if (st->output) {
> -        if (use_timer) {
> -            cb = hda_audio_output_cb;
> -            timer_del(st->buft);
> -        } else {
> -            cb = hda_audio_compat_output_cb;
> -        }
> +        cb = hda_audio_output_cb;
> +        timer_del(st->buft);
>           st->voice.out = AUD_open_out(&st->state->card, st->voice.out,
>                                        st->node->name, st, cb, &st->as);
>       } else {
> -        if (use_timer) {
> -            cb = hda_audio_input_cb;
> -            timer_del(st->buft);
> -        } else {
> -            cb = hda_audio_compat_input_cb;
> -        }
> +        cb = hda_audio_input_cb;
> +        timer_del(st->buft);
>           st->voice.in = AUD_open_in(&st->state->card, st->voice.in,
>                                      st->node->name, st, cb, &st->as);
>       }
> @@ -805,7 +741,7 @@ static void hda_audio_reset(DeviceState *dev)
>   static bool vmstate_hda_audio_stream_buf_needed(void *opaque)
>   {
>       HDAAudioStream *st = opaque;
> -    return st->state && st->state->use_timer;
> +    return st->state;
>   }
>   
>   static const VMStateDescription vmstate_hda_audio_stream_buf = {
> @@ -861,7 +797,6 @@ static const Property hda_audio_properties[] = {
>       DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
>       DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
>       DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
> -    DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
>   };
>   
>   static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)

Reviewed-by: Thomas Huth <thuth@redhat.com>


