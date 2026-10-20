Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D2606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DB4U+A2w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCDA-000434-FX; Tue, 20 Oct 2026 11:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCD8-00042c-Va
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCD7-0000qC-FR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEQoqBcXI5dzkmelAt0wlgEs4oLYjXZ8YwcKok5ap64=;
 b=DB4U+A2wEab8hDFe4I7nteR/0QTbwDFauzA6qK+AdBPGtgKyPY2gNJbs9Ym7qUwdqS6j79
 L4NAxD+ychnHWJpgeQP7xmOPtbPaRoaJ9mwGZb9S/vanVpIVHhwhXl7V1uuxFvodfnD9Mn
 /emrDaG4wikTBvlyj0kiJKRR5iCRFu4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-bBOccW8WMfeqIF5y5Jg1Pg-1; Tue,
 20 Oct 2026 15:57:04 +0000
X-MC-Unique: bBOccW8WMfeqIF5y5Jg1Pg-1
X-Mimecast-MFC-AGG-ID: bBOccW8WMfeqIF5y5Jg1Pg_1792511822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B51811953984; Tue, 20 Oct 2026 15:57:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F7CF18005B3; Tue, 20 Oct 2026 15:57:00 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 11/12] virtio-serial-bus: add terminal resize messages
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:13 +0400
Message-Id: <179251177300.3780647.2268008186453794133.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=puNXlPNVkCorN4zMgskOeA4PBNpYqo/sA4XBHe4cvs4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148hEHmixPEvq79B3COZNN9n+Wp0UdOqdgBY7
 IWrWZwsKVyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIQAKCRDa6OEJdZac
 5dPVD/49/t1ek9GD4EZLxq0KsLZCB4QsC3wiJXgLCla5f1vXjlg38bb+r8QRNAlBTEfcWHQafsi
 h2QgP4SpL4PWQS5a/muYbWUGE4jEbaRPgTI4iFt9i77JasUDwoxRUocdJlnPxqzO8VIA0A1KQxH
 D7f62QqPyFPm89Ys+igiLfAOVQipdhF2iLEvtyexcxrB2ufppf+WwCqDaKL88zGMPzKXFUojW8Z
 dMTw5F72zEjTdE162B/zNZrai+FBdsH2UWMYaUPgmUCLQ5qFc+FSL7leeJxKaDP87scYFYwvTgX
 ONqV3jnoUIRrkL1PlqKJh0zZMg1H2x6VCbHIRqX1adsQmYWPcc8xYD8+8FZRflFjELYJXSSatuN
 6LBQG2deyvfDK0X6fEL7AKWKH0B70U+Jt/4kVuFUhel/8qF4h2YzjoOTNsiNGobSxXzJ+CV+WlS
 UlpCJ8ilUr/ClXPiL32PQkM7GJg7YyMdAz1IOe7yBa4641TLNJ7J4xZGJDFSUfcT+IUzAaN7a4k
 mgVQsU44io9namza8VNjpuCaO+u9q4b+BkUA6bWqmKo60OTq1zW9tqLgIiJDuxPkyXCjmjnroaW
 eyXMFCcfrIU8PdY1NppvIsx5/45YbBZ5AyiRnvtChSQwbCZf+oQ6TwsAOlNEzdz5jfvhcUW7vAM
 JRX4rpQ3NIYA/2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. Gate the new resize support behind the
> console-size property, which defaults to off. To implement the property,
> restore VirtIOSerial::host_features (previously removed by commit
> d0660e5b7fc7e97926232d13d2500a16df32b310).
> 
> The virtio spec contains two methods to inform the guest about console
> size:
> 
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
> 
> For multiport devices, we use the control virtqueue to send a
> packet containing the terminal size. Unfortunately, old versions
> of the Linux kernel used an incorrect order for the fields (rows
> then cols instead of cols then rows), until it was fixed by commit
> 5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running an
> old guest kernel, the number of rows and columns will be swapped.
> 
> Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> but partially rewritten to fix various corner cases.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
> ---
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-serial.h |  7 ++++
>  3 files changed, 87 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index a3fcc772877a..e387c8853fcf 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop
>  
>  # virtio-serial-bus.c
>  virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
> +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
>  virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
>  virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
>  virtio_serial_handle_control_message_port(unsigned int port) "port %u"
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index c36e18a4cfb5..882765ac88ab 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -261,6 +261,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
>      return send_control_msg(vser, &cpkt, sizeof(cpkt));
>  }
>  
> +/*
> + * This struct should be added to the Linux kernel uapi headers
> + * and later imported to standard-headers/linux/virtio_console.h
> + */
> +struct virtio_console_resize {
> +    __virtio16 cols;
> +    __virtio16 rows;
> +};
> +
> +static void send_console_resize(VirtIOSerialPort *port)
> +{
> +    VirtIOSerial *vser = port->vser;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> +
> +    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE)) {
> +        return;
> +    }
> +
> +    trace_virtio_serial_send_console_resize(port->id, port->cols, port->rows);
> +
> +    if (use_multiport(vser)) {

it should probably gate on negotiated virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE) as well

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


