Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590E5D29DEC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 08:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZh0-0003i8-1h; Tue, 13 Jan 2026 03:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfZgp-0003hL-Cr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:23:48 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfZgk-0006Nj-Vr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:23:45 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4ffc0ddefc4so83594541cf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 00:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768292601; x=1768897401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cC0XgdfhUh7UbRoLmiavYRm1qQhzMqioeoKIJX22arY=;
 b=YSQusT+0xoI9GZ1nv+GBOm0qafCtme+QYy8VX6XSkuVVnB6b9JGJ0UDY9xAX+3vaO1
 s/gos0RaxGsaPNgZz9rT+P95/9QbMMSlxjah5lamxMNc0cLPkm20ieE63AH/4PXReBqr
 QMKrXfRojG9vVKrWiyfgxhMuvbQwpMUwpCAyWAkAe0gtR6q0/HGcjwtcRQfIPokFtO4N
 tYdAyHTg8heezwrj2YCvQU6C/s0iq4HAk6Wq8IgtjYNEBY7JVGlHajZr5NQsDzHEUtyN
 6aoRTbRNnrgY2xljqsYT1c2f3g3Fj/hTXkT/xGtdjCxndUkmFL+OafeAvSsuhGM6CjQC
 g0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768292601; x=1768897401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cC0XgdfhUh7UbRoLmiavYRm1qQhzMqioeoKIJX22arY=;
 b=XqE9Kpz3gw+EPVoM82EVa+amnc2qLo4SK70k/GcnVlNAel6hu2KxJd0nC45HQN3mUH
 rFWmXO/l1+OR+seEW+Vypv3jEbXA6pAoUBMySHch1hMiNg3XBhv5598pmlxhLZPGZwly
 K45I0lXu6r60/FmhiQkYI8vgt41pE/eBH5P/y+5bC4PENNUZSqle89wA2iEWStyH8Wa0
 d9qsQb5r5gNGbfP2RhaAVMjdJ1jmN5YNMd2lQkXsAeMjYvtAK9kY+gdsdvE2qZS7Yp6a
 jiSbOjFalG/di8N3Zg5B29xvCR4qLdinvvcBO9eNE10QDQigs49g4klxJolSrGbVsYYI
 YpHw==
X-Gm-Message-State: AOJu0YzMh33Zr1nhmH0AtGKQlajAjZfD8OO4U5QGrosQliLCJbGUUlfU
 EVJ7hI/At5qJFIlOkSgjsxNulZmKYC1MicBT8ptoHOWIa003ZFLj1xIFsXU/shQmjIwZNOSm3TU
 vVhrsbeHqshxbommBEgUWeGsToUrCU8Q=
X-Gm-Gg: AY/fxX5ydBfets6KPe24Tli55cj152Z86eYiTv82QGt/vxwwZhrq6BJ0xs48He0CCYN
 V2ptq6UigtjCTtAGbzomE8lqeJpKNqG2RMjuZkjTTcMEZmDhng5aySbz6xe/W7Jtlu11QeN/BSi
 2bINOZ/4cWP9Lp3EuBABm5HsGv/zp70ai8iPFh4qfuC6f75U+P/z4ncOrkTBu7ijqjVPGA29YBM
 a4/vOvTrw9aLW+zk7cTpuCtmjIpx01ozzYHrX8OXpr6srcEDky73iwtnmbLhPp8AYdbYTPjXVZZ
 uvu/P4WFw/IF+YsLJaNmguJeWw7uXbPxa6MgXA==
X-Google-Smtp-Source: AGHT+IFKljBkrfKxFu/m6nh5wKC7/e8DTDnUvmWgJCJi6iP0dYiIJNjeUyKVjimhdo5YJdps6ZXY5mCqV7m4y3Dgrd8=
X-Received: by 2002:ac8:6f0b:0:b0:4ed:d76f:a350 with SMTP id
 d75a77b69052e-4ffb4a1d824mr285649201cf.75.1768292600986; Tue, 13 Jan 2026
 00:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
 <20260112230127.99125-4-yodel.eldar@yodel.dev>
In-Reply-To: <20260112230127.99125-4-yodel.eldar@yodel.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jan 2026 12:23:09 +0400
X-Gm-Features: AZwV_Qhv8tS5cXjiQeFOS2O_av9alVcS2aoY2HD_L8iMbuCJ8GVX1jzjYBfqr0Y
Message-ID: <CAJ+F1C+OZfmAh2eJrH9__8yFNr-p1njg6DGseN1VWKu344+ReQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] contrib/vhost-user-bridge: Add UDP receive
 hexdump
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jan 13, 2026 at 3:03=E2=80=AFAM Yodel Eldar <yodel.eldar@yodel.dev>=
 wrote:
>
> vhost-user-bridge debug prints UDP TX hexdumps in its transmit handler,
> but does not for receives, even though they are beneficial for testing.
> Add an RX hexdump in the receive callback.
>
> To delineate between transmits and receives, also add a debug print
> indicating that the program is in the transmit handler.
>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/vhost-user-bridge/vhost-user-bridge.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhos=
t-user-bridge/vhost-user-bridge.c
> index ce4c3426d3..3f0fd0fa49 100644
> --- a/contrib/vhost-user-bridge/vhost-user-bridge.c
> +++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
> @@ -179,6 +179,9 @@ vubr_handle_tx(VuDev *dev, int qidx)
>
>      assert(qidx % 2);
>
> +    DPRINT("\n\n   ***   IN UDP TRANSMIT HANDLER    ***\n\n");
> +    DPRINT("    hdrlen =3D %d\n", hdrlen);
> +
>      for (;;) {
>          ssize_t ret;
>          unsigned int out_num;
> @@ -333,6 +336,10 @@ vubr_backend_recv_cb(int sock, void *ctx)
>          };
>          ret =3D RETRY_ON_EINTR(recvmsg(vubr->backend_udp_sock, &msg, 0))=
;
>
> +        if (ret > 0 && VHOST_USER_BRIDGE_DEBUG) {
> +            iov_hexdump(sg, num, stderr, "RX:", ret);
> +        }
> +
>          if (i =3D=3D 0) {
>              iov_restore_front(elem->in_sg, sg, hdrlen);
>          }
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

