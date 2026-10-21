Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF7606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GpY0HZwA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGQ-0005q4-FH; Wed, 21 Oct 2026 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xJXF2-0003R4-8o
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:24:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xJXF0-0002Hx-Dp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:24:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so6765885e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792592669; x=1793197469; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3CvJsNhrdvCfq6pbETT8FYKRQh9hWkfdmLF81nGsjmw=;
 b=GpY0HZwA/U2nXBp0G3gW3UkpfMxs43xjlprZyOUsURvb7kGoEucFun7tsSuuqdY1UZ
 EWrCb/5JI1BPRZTCR/+p6twm/aFxHMAkmQgGz+yihQjbGbaAy/NEqJEXNLZeNbORRTHo
 O1Aq3l1iVfGbWhOQLjQo5V1ZW/T6QxELaJv2ZW7BA6K/tq9+eZQXr3Rr3JqLGQjBv6mr
 OoRG4xUBsI0UCtqeOyF0H18cYMMkPlb2kDZaDFx2sAVzhlDyLfC0Sv3YTebOXo+sBNjH
 1HqIA+eJwtr1VFdg5Vb9nDJUZ0PZOOvMt4c9IBL5WYPrFxq/lCUJ+q6cLvEIHfv1i2UP
 hTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592669; x=1793197469;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3CvJsNhrdvCfq6pbETT8FYKRQh9hWkfdmLF81nGsjmw=;
 b=Br2GhpAanfnMYy7LbawdT6/kJeoXKAOr2+Yb4e7C929PET99LU0/q8hYsCa/aJ2m1N
 UrSbAB9eHarrsbFs0xMxSg7K3i6qYgFwWLdpVYpE/e4FduzN+pGOqXQzdUwf4yJU2V7H
 d3+WNqcTCj74Onct3u4kvBWUJONpjmfh5lkR+OnBKvWj1BcBt4WjOIwHIzW5X8FpZPrm
 xkNyUfss2rqdSk16zNxYGFpCm/lKZPBvNfoWyqi5I8gFQSmoG27Monol1LTEwz5hwIHI
 R5ax/WvAUBwOyaYA8u41NNEhcQYgyaM8nI4sQ8RbZwulQAgwOO2QNEi2eWZgaZ3jCw3j
 StEg==
X-Gm-Message-State: AFq9FYK3E6VpE9MMBuEYJ7PXSKW506dGHZPBUQrHw20v6wayE2NyglRQ
 HgAZUaEDf790feWS1bFCZnxDg9JqpilwSCVc2HcpGSaCGOdFBsxVXGJE
X-Gm-Gg: AYBFou2G6nxnL2yaWYLOizB5ejsC3+r08dzPMgOxf1ev8QlXxD88Gq1hnzLJKauDW5k
 lsE0Wus1Wcd5IqNAmrWyPNSEhgPWQ5nGAlPrr6FPRPQ+ZIr9T7EE3ML03FFzfd5Mw72V19xIG/0
 jcyEl6CYlz5ZqDaa2ETBLxEnwtsy2oew/jZB/M9MV7kPIy5qqpl9MPpcLTv+41PB0LPXxNmq4QA
 4YQv2C2hfCfIRGur/376kZO48qZOzkr+XEBlysgcEIFO/huQ59M+2Qy9H+gl2oabQMgvnd/9Lny
 1mjrFL0LaEz42WanaNfBTlsugiRQZgE5h+fNRVTse+EMlnhyeaTXAVyyy3i/tLBzcADwqHJonvK
 vy9u3blG3D4FfWPDEZefzb4vGAW9DyoGrVTpxk2gqXYMxDzj9/b6cv3WKzStrBpcf5e5ueJig+8
 PUISVo4dwOlnraAxC9tsV5NgWiuDY7HjScclgOiHd/Tu8vHHrw3bDkfs6SkFS4r01A0FPeZcVWs
 KcI9uIYZKCByfdwGRrz/FDvIpQj5PDeuGiJFfQ34/Zyp0qCfhTLcckGBawPU52LW28oTwm6wNFG
 lun3qh3bXchzoQ==
X-Received: by 2002:a05:600d:82c1:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a1fdd393c4mr50008985e9.18.1792592668718; 
 Wed, 21 Oct 2026 07:24:28 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0ad18esm41683585e9.0.2026.10.21.07.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:24:28 -0700 (PDT)
Message-ID: <c668c6e8a78145d5e77078aa355c1fd7999b0ecb.camel@gmail.com>
Subject: Re: [PATCH v10 11/12] virtio-serial-bus: add terminal resize messages
From: Filip Hejsek <filip.hejsek@gmail.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Amit Shah
 <amit@kernel.org>,  Markus Armbruster	 <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Eduardo Habkost	 <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Max Brandtner	
 <maximilian.immanuel.brandtner@protonmail.com>, Dominique Martinet	
 <asmadeus@codewreck.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@oss.qualcomm.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Wed, 21 Oct 2026 16:24:26 +0200
In-Reply-To: <179251177300.3780647.2268008186453794133.b4-review@b4>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
 <179251177300.3780647.2268008186453794133.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-10-20 at 19:56 +0400, marcandre.lureau@redhat.com wrote:
> > Implement the part of the virtio spec that allows to notify the virtio
> > driver about terminal resizes. Gate the new resize support behind the
> > console-size property, which defaults to off. To implement the property=
,
> > restore VirtIOSerial::host_features (previously removed by commit
> > d0660e5b7fc7e97926232d13d2500a16df32b310).
> >=20
> > The virtio spec contains two methods to inform the guest about console
> > size:
> >=20
> > For legacy drivers, we have only one port and we put the terminal size
> > in the config space and inject the config changed interrupt.
> >=20
> > For multiport devices, we use the control virtqueue to send a
> > packet containing the terminal size. Unfortunately, old versions
> > of the Linux kernel used an incorrect order for the fields (rows
> > then cols instead of cols then rows), until it was fixed by commit
> > 5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running an
> > old guest kernel, the number of rows and columns will be swapped.
> >=20
> > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com=
>,
> > but partially rewritten to fix various corner cases.
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > Message-ID: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
> > ---
> > =C2=A0hw/char/trace-events              |  1 +
> > =C2=A0hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++=
++++++++++++-
> > =C2=A0include/hw/virtio/virtio-serial.h |  7 ++++
> > =C2=A03 files changed, 87 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/char/trace-events b/hw/char/trace-events
> > index a3fcc772877a..e387c8853fcf 100644
> > --- a/hw/char/trace-events
> > +++ b/hw/char/trace-events
> > @@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char pari=
ty, int data_bits, int stop
> > =C2=A0
> >=20
> > =C2=A0# virtio-serial-bus.c
> > =C2=A0virtio_serial_send_control_event(unsigned int port, uint16_t even=
t, uint16_t value) "port %u, event %u, value %u"
> > +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, ui=
nt16_t rows) "port %u, cols %u, rows %u"
> > =C2=A0virtio_serial_throttle_port(unsigned int port, bool throttle) "po=
rt %u, throttle %d"
> > =C2=A0virtio_serial_handle_control_message(uint16_t event, uint16_t val=
ue) "event %u, value %u"
> > =C2=A0virtio_serial_handle_control_message_port(unsigned int port) "por=
t %u"
> > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > index c36e18a4cfb5..882765ac88ab 100644
> > --- a/hw/char/virtio-serial-bus.c
> > +++ b/hw/char/virtio-serial-bus.c
> > @@ -261,6 +261,68 @@ static size_t send_control_event(VirtIOSerial *vse=
r, uint32_t port_id,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return send_control_msg(vser, &cpkt, size=
of(cpkt));
> > =C2=A0}
> > =C2=A0
> >=20
> > +/*
> > + * This struct should be added to the Linux kernel uapi headers
> > + * and later imported to standard-headers/linux/virtio_console.h
> > + */
> > +struct virtio_console_resize {
> > +    __virtio16 cols;
> > +    __virtio16 rows;
> > +};
> > +
> > +static void send_console_resize(VirtIOSerialPort *port)
> > +{
> > +    VirtIOSerial *vser =3D port->vser;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(vser);
> > +
> > +    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE=
)) {
> > +        return;
> > +    }
> > +
> > +    trace_virtio_serial_send_console_resize(port->id, port->cols, port=
->rows);
> > +
> > +    if (use_multiport(vser)) {
>=20
> it should probably gate on negotiated virtio_vdev_has_feature(vdev, VIRTI=
O_CONSOLE_F_SIZE) as well

I think the patch is already merged [1]? I'm not familiar with all
details of the QEMU development process. Should I address this in a
follow-up commit?

[1]: https://lore.kernel.org/qemu-devel/20261013-ui-v1-0-92da3082ad96@redha=
t.com/

--
Filip

