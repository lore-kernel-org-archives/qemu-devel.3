Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14225606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLh62SFp;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C2U8eibx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXSa-0004G6-7h; Wed, 21 Oct 2026 10:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xJXRn-00045y-Qe
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xJXRl-0003XM-S8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792593460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJY/VQXabF9YQFPESGPwynluvIavq6kW7BPOub19CoE=;
 b=PLh62SFpjyS5x1d6hXpIclV3QS2XqJPPI3wL7JD0LQwxu5srZz2EintVfT2IWZ4GhKCFcH
 vIKi+gWqTZ2gcTFzj5g/gx0NrlF+rSEgktahcF0L6IljB95syerbtskh3air1HKbPrFnze
 xkT5WIlb4ShFcbYoKkjXDv2bDr5ygug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-j4tXaVjpPOqoiPzvl38ufA-1; Wed, 21 Oct 2026 14:37:32 +0000
X-MC-Unique: j4tXaVjpPOqoiPzvl38ufA-1
X-Mimecast-MFC-AGG-ID: j4tXaVjpPOqoiPzvl38ufA_1792593451
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso10341885e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792593451; x=1793198251; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJY/VQXabF9YQFPESGPwynluvIavq6kW7BPOub19CoE=;
 b=C2U8eibxR4G3FNPBvc/Gl9bVQgYKfe3/bPkCmkjdrw4g8L0m20fHg7NYWqrMjlHrlA
 NqTzMrB6CyYKg4m+mwUexYtgk+BHNeFdemQzESDxwhYPV1NjFHhtJNK+knmELNyxDyHc
 NtxoM1ORQ8TtWOzmJPBadgFeLUkCmmUFcutCBU0+OSeBytGseylZ7kx+8wskrHACI/wf
 JeHKduIws60XDdEXyCS8D5VVKk7GUMOkQUVmuzwfT0EC2liPTEZ3xVtvBCDdry7Z6INp
 Qyd8cE9BfTnmVKHlB8gJXa0xFPrubKyYnjf6v3kwgOdp0xJquEBXUcJxPW1idCaSCgsD
 U0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593451; x=1793198251;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VJY/VQXabF9YQFPESGPwynluvIavq6kW7BPOub19CoE=;
 b=CCb5TzwGH86F59Nah34rZgCIbJf9tW2g8knbKB/qVSk+pmQp2Xni6vJ058xq6edtXJ
 2VETapAT06tliEkK0YF0mwSzFfQ9ZlsOhWPuDsBMu77fZydvG6lctEiVSAMDREx6x8gq
 yB2Bodx7Dn312J8Zf8lrPi04MqZyCTXLU7SvEdsbFzXxkS1b07tbSQwT8wBl1JEFPYnj
 KhoVLpSOsyuDRZesBGXtLG1uTmsuzySpERzYyGNVB+fAL5SgKPEXfWV3GkJNEGKxmxqx
 R7tw11AsZOyfKmq3xvNsxfiw552R4zTp9tNDk+DOO71B/ABM/kuc3lF9bJz+GIfuucye
 E0vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOOO3fnx9QUI5XLc8aqA5EYNuqZb2jxhdV35RbzAVZz6YW5J8SjR7J6BbMhGjkRQYo3R4gX+mVKz2N@nongnu.org
X-Gm-Message-State: AFq9FYJwi3ed25DyuWWZRQ6TErPrjMFl0LY4j73KUxn7E9LzHbJv6Gbw
 7apUk2UWUv4FrJHVAtdm2j3Gb2KuI49M5tPlwm4w0l1jNeDv1DDs0GTaMsaaHWJCCpT/+Ulu12w
 EXLl4tu2B6dqaqdEWbxnBBmfHDrksjVJZvSDGtmp2o4zPefzebXRvHZaq
X-Gm-Gg: AYBFou1g8SJENu2ecflVwXu3UE1rhzQn12pr/0scSpsoH8H2vtlbPBqgqhjxs99VWj0
 si9m0M0dHftf8g4cFBFCNuZgkPo40jvkRX1Tv1hoUlKj5pSeMFaxB/0G6r7bD2QJoCRoFUHtn85
 RQRAuiF+HZx1wnE7VeEvNeOaSGaPivUPoZEMpNKENH3+1kp2jovQbAYZGFOFPfxtJSl/olb2eMb
 Bg7gO56tAJAN71zXT+NfQwz0a2rcnnWtQ+kTxVqksI8C2u5mUNznxmWjets8Y+rl9kT8cS15W6r
 6tOPYGUVD8rj+jkEhPeOWbXGJaTixsUz3CZsCfdKaOMvXjZlg33dW14uNJSYKd4rka8=
X-Received: by 2002:a05:600c:3548:b0:4a1:dfd4:9430 with SMTP id
 5b1f17b1804b1-4a1fdd159e9mr51590355e9.28.1792593451149; 
 Wed, 21 Oct 2026 07:37:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:4a1:dfd4:9430 with SMTP id
 5b1f17b1804b1-4a1fdd159e9mr51589755e9.28.1792593450579; 
 Wed, 21 Oct 2026 07:37:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd2eff9sm53389205e9.4.2026.10.21.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:37:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:37:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Max Brandtner <maximilian.immanuel.brandtner@protonmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v10 11/12] virtio-serial-bus: add terminal resize messages
Message-ID: <20261021103721-mutt-send-email-mst@kernel.org>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
 <179251177300.3780647.2268008186453794133.b4-review@b4>
 <c668c6e8a78145d5e77078aa355c1fd7999b0ecb.camel@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c668c6e8a78145d5e77078aa355c1fd7999b0ecb.camel@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 04:24:26PM +0200, Filip Hejsek wrote:
> On Tue, 2026-10-20 at 19:56 +0400, marcandre.lureau@redhat.com wrote:
> > > Implement the part of the virtio spec that allows to notify the virtio
> > > driver about terminal resizes. Gate the new resize support behind the
> > > console-size property, which defaults to off. To implement the property,
> > > restore VirtIOSerial::host_features (previously removed by commit
> > > d0660e5b7fc7e97926232d13d2500a16df32b310).
> > > 
> > > The virtio spec contains two methods to inform the guest about console
> > > size:
> > > 
> > > For legacy drivers, we have only one port and we put the terminal size
> > > in the config space and inject the config changed interrupt.
> > > 
> > > For multiport devices, we use the control virtqueue to send a
> > > packet containing the terminal size. Unfortunately, old versions
> > > of the Linux kernel used an incorrect order for the fields (rows
> > > then cols instead of cols then rows), until it was fixed by commit
> > > 5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running an
> > > old guest kernel, the number of rows and columns will be swapped.
> > > 
> > > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> > > but partially rewritten to fix various corner cases.
> > > 
> > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > Message-ID: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
> > > ---
> > >  hw/char/trace-events              |  1 +
> > >  hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
> > >  include/hw/virtio/virtio-serial.h |  7 ++++
> > >  3 files changed, 87 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/char/trace-events b/hw/char/trace-events
> > > index a3fcc772877a..e387c8853fcf 100644
> > > --- a/hw/char/trace-events
> > > +++ b/hw/char/trace-events
> > > @@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop
> > >  
> > > 
> > >  # virtio-serial-bus.c
> > >  virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
> > > +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
> > >  virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
> > >  virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
> > >  virtio_serial_handle_control_message_port(unsigned int port) "port %u"
> > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > > index c36e18a4cfb5..882765ac88ab 100644
> > > --- a/hw/char/virtio-serial-bus.c
> > > +++ b/hw/char/virtio-serial-bus.c
> > > @@ -261,6 +261,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
> > >      return send_control_msg(vser, &cpkt, sizeof(cpkt));
> > >  }
> > >  
> > > 
> > > +/*
> > > + * This struct should be added to the Linux kernel uapi headers
> > > + * and later imported to standard-headers/linux/virtio_console.h
> > > + */
> > > +struct virtio_console_resize {
> > > +    __virtio16 cols;
> > > +    __virtio16 rows;
> > > +};
> > > +
> > > +static void send_console_resize(VirtIOSerialPort *port)
> > > +{
> > > +    VirtIOSerial *vser = port->vser;
> > > +    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> > > +
> > > +    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE)) {
> > > +        return;
> > > +    }
> > > +
> > > +    trace_virtio_serial_send_console_resize(port->id, port->cols, port->rows);
> > > +
> > > +    if (use_multiport(vser)) {
> > 
> > it should probably gate on negotiated virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE) as well
> 
> I think the patch is already merged [1]? I'm not familiar with all
> details of the QEMU development process. Should I address this in a
> follow-up commit?
> 
> [1]: https://lore.kernel.org/qemu-devel/20261013-ui-v1-0-92da3082ad96@redhat.com/
> 
> --
> Filip

Pls do.


