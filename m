Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66928606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=htJM32Rp;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NM6gcQqx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVr3u-0007wS-Js; Tue, 24 Nov 2026 08:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xVr3t-0007wE-Hv
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xVr3r-0003dJ-Lf
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795528792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctW+mOepOgOGaQ7vRF5b8yqUBBFq0f2fnLUJICthhu0=;
 b=htJM32RpUgJOObH+5uN7f5tNy3wtBUU9TDtk/KQlI9uGkbUBIZVXLp0qmtd1RFT8LBUinw
 TJrCNuIwHYluSDEEaqck665YCxdVMbdI8JnwJosqsWtt+Q5Nmo626Fz583SgyJe+NGCNS5
 tLTT2ApAXiJO7gh7vOftN5Lz9dloe2Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-SJNvTr0oMmeL9BRfp1Xi9Q-1; Tue, 24 Nov 2026 13:59:49 +0000
X-MC-Unique: SJNvTr0oMmeL9BRfp1Xi9Q-1
X-Mimecast-MFC-AGG-ID: SJNvTr0oMmeL9BRfp1Xi9Q_1795528788
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f074b87307so23412065ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:59:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795528788; cv=none;
 d=google.com; s=arc-20260327;
 b=q2rE5oKbnP/wOIpxRIrPyKYpZTJqsrwipj2aJxOYqMxULADd9SEG0ukKSw0dDJW0QR
 pRYDNI40xVzYXI0FiFTJG7d+zveUS5k5tngIVYgy1WfdreodxsD0WzKZJB7FNVvoW9uC
 HuJuYM6FtwfRARg2KOIhIRmqpj5KUbTKqF4gmoCb8ZKUw1Lw23ye0R25SYvipRH7GVQi
 k/P30uFWH8rNnpKBwBw3eQDhlaLxlSAiCBfv1/IwLHxbb7T/J9T3NVkPh1in5QQ1c0NO
 JJHJGPl8/xJSqQlAAUB3iMWyR1VuWFkZfZAKOWFwIsY8YHjNlfO+4vMkO4pUJW5+3vq5
 HQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ctW+mOepOgOGaQ7vRF5b8yqUBBFq0f2fnLUJICthhu0=;
 fh=NwttdebZ52fKsAJaPdcWox+XtF33TLEeh59vJQK3F60=;
 b=E7wVca3g7+9B0FQsPzavbXb9bRQdOGLTyiRJ1MOjHDXlRkdlF98xbqAHQT7hbakRRG
 5F+rVHRskiHE4B8E7MyiIpS0hB43X0vyfdNsb3c8KDlFeyPLKW47FYSp/uV63iL4hyAh
 +jY3iHmtDw2XEWvpsOoWWK+7qz+1uLcXby0LwRFQeIJNhIzvLUGJtq20KNLcL+Khf+Lg
 N69wlk/XficBdJaiG863xWjm5MqmzaP6pdkgAoT49vwFFBrc90Z8J+7cn4tHOZkTPyfk
 L/nWHtaMpKyIsAVp5Pfe2zScI4kWoIOkUigBCIcocQyjjis+mCu3PSjw8yjbiKeHqcpa
 tkZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795528788; x=1796133588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ctW+mOepOgOGaQ7vRF5b8yqUBBFq0f2fnLUJICthhu0=;
 b=NM6gcQqxB4rxz8gugV0AhVAbyodlrpDBp+maNRvmeUQ+/0b47OW0C6tIlLHC7Cy2Uk
 2qhfo7zHzlen5Bcm2m81pn1ArvzyLCjCXFjZcMrXniNh/XOn+0+K57nq7W+U8dprzaKD
 oLC/+LRULTJ2kFsMIHTNM5NlBh5qG+biHnkIvH16AezDqHEplDNJiGwmv7hwQwW/ZIgu
 OsvbjHLJ+CEz3dOCSjf9TAzAz2+yfM8ze/QFSUUeaw2h2q6haM6PEV1X+NXFtl2sprC6
 QAkq28ZZykw3QwAj+Hkcw69FmC6jcIeUjO+S39PdLO+ITQM8Es4Xz8LK2TfYOxMZhlEc
 o3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528788; x=1796133588;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ctW+mOepOgOGaQ7vRF5b8yqUBBFq0f2fnLUJICthhu0=;
 b=Lpwqn7Pt1SbUzsbwug7m3YkniSY91gijuTFZftPenElrqTlMbEin2J5NeI3twsCuxF
 hziqLPBiDBqAzQjPTLFZJyOttOEAN0f0WRhmh+z/ndfo4i9VYci4Vt5w0y9Ppyvom+ox
 xA617ALqhgK9r59jGsakIhDjhaFlA8uHB8QXi9edLRWymsquVrRDI1MXEbdXembaquhK
 V6HAC7Hk0+5h77wi/Sfx1e9ceaKcLNLodsy2o4kFEjxZekwKDZ3UC7ZG1/CtcpOWFc1/
 A0fEiwV8ZPAZ2MAwLXM16en0ZvvFZJJGDnBB7eBa0FYEO4F7XA26HaK0h/fEXfg7mQb7
 16mQ==
X-Gm-Message-State: APuU4Z/n8aQnXO2VLpnHeIR0HiDGAyga9cU9BdzKD5SmsmYVIGUN2pIl
 SE3SE30jXHmokLzZFdIU8mmvk86GQCgR3KvOjzlosXXe67lcXqxiCQattGJrbxrhygwuAZI91Fp
 7yKvjzm0G1W+vFlx+uQnb+rrDv2KMN6onFlvZVWsgln59SB7BZv/PxLb2gAEgLLLp7C/Vqtulro
 QRnFpsNH33dNhn3EBBvU1QBFWWaTCE/uH3bv/exidM0z02
X-Gm-Gg: AZFdTZcnm58/OJqfFktXv4QGtW8d0Jt8ktCmOurJ7R8zVE32dsuwXZxxPGKkR/3LpBY
 NrfwEMWDnH4KGNRYZifr886+US5GBe0HduCYekG7gr/xM9N+Tq+Doh1JjQOBaZCDpXjLaMbvEmz
 OpPT/Q+lqD+t3Q0R822gFlLwN+mzIlsHf8pTwKklcPDh+5qDCObRoE+6cctnv/S3amr099HdOWq
 03wKYTvuO3WO46FvcHg7R9P8+cG1BV7cyah+7n5spYA8NdLhC4OfJJnOaUJpc0tVgcH1VI/lSEu
 UA==
X-Received: by 2002:a17:903:b4b:b0:2e5:4604:c375 with SMTP id
 d9443c01a7336-2f03f1b6f40mr141635015ad.48.1795528787813; 
 Tue, 24 Nov 2026 05:59:47 -0800 (PST)
X-Received: by 2002:a17:903:b4b:b0:2e5:4604:c375 with SMTP id
 d9443c01a7336-2f03f1b6f40mr141634915ad.48.1795528787364; Tue, 24 Nov 2026
 05:59:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124073857.3582931-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261124073857.3582931-2-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Nov 2026 17:59:35 +0400
X-Gm-Features: Aa3M54qHAqpNuGKCIkg8HnR3RxRY04Fb_HXguTLNd1QNTQl9YJdCwGFGSPclf1Y
Message-ID: <CAMxuvaw8_svuWrMUCk+56jBEVWqii_yUFJ6p9jYfGTZXtKV4XQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/virtio-serial: return throttled descriptor on
 port close
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:39=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> When the host chardev disconnects while the output queue is throttled,
> virtio_serial_close() calls discard_throttle_data() which detaches the
> in-flight element with virtqueue_detach_element(). This silently removes
> the descriptor without placing it on the used ring, so the guest never
> sees the write complete and the descriptor leaks.
>
> Add return_throttle_data(), which pushes the element back via
> virtqueue_push() instead of detaching it, and call it from
> virtio_serial_close().
>
> Fixes: d4c19cdeeb2f ("virtio-serial: add missing virtio_detach_element() =
call")
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4672

> ---
>  hw/char/virtio-serial-bus.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 7fe90571249f..264bf60beb41 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -158,6 +158,21 @@ static void discard_throttle_data(VirtIOSerialPort *=
port)
>      }
>  }
>
> +/*
> + * Return a partial element held back by throttling to the guest via
> + * the used ring, so the guest driver can reclaim the descriptor.
> + * Unlike discard_throttle_data() this must be used when the virtqueue
> + * stays live (port close) rather than being reset.
> + */
> +static void return_throttle_data(VirtIOSerialPort *port)
> +{
> +    if (port->elem) {
> +        virtqueue_push(port->ovq, port->elem, 0);
> +        g_clear_pointer(&port->elem, g_free);
> +        virtio_notify(VIRTIO_DEVICE(port->vser), port->ovq);
> +    }
> +}
> +
>  static void do_flush_queued_data(VirtIOSerialPort *port, VirtQueue *vq,
>                                   VirtIODevice *vdev)
>  {
> @@ -345,7 +360,7 @@ int virtio_serial_close(VirtIOSerialPort *port)
>       * consume, reset the throttling flag and discard the data.
>       */
>      port->throttled =3D false;
> -    discard_throttle_data(port);
> +    return_throttle_data(port);
>      discard_vq_data(port->ovq, VIRTIO_DEVICE(port->vser));
>
>      send_control_event(port->vser, port->id, VIRTIO_CONSOLE_PORT_OPEN, 0=
);
> --
> 2.56.0.116.g6de20f6092dc
>


