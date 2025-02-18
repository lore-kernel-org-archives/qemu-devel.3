Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C97C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPcs-0003L2-IT; Tue, 18 Feb 2025 10:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loyou85@gmail.com>) id 1tkPci-0003B7-5X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:35:03 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loyou85@gmail.com>) id 1tkPcf-0001WM-Nx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:34:59 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e050b1491eso4262849a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739892894; x=1740497694; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmkrNq5AplHw0xVY3u2oc/AEHxLEtLd2Oo9IUfvydDw=;
 b=fu5+wwru0GkgoFIMayawppGlUMc4Uwm9CqihdxFhfVr5NSHXbVSKJ8rWNUPOXJcM/U
 6wfkKzV8goiSLb7IvdDIfF6jvDLyd2KqRfTE6Zo/XNKv9GraQiFx0csf6HlRcQ2zU7N3
 hzDZBT9LxTi+87v3vbA65pexA8+niM9qBjPsN6ndHyAaaGU9aM1t8nGQzfbwVW7hErL0
 5ZdlZ051w8Mcix4wPjuryTnRiVQA544YbojbN/lzt5+Abs4ni9116RU5Y4HplTcwS5FW
 F6M4NJYEfsoQyozUI7f8D6mPF67pfSIYF1rQyRFCZ1oo9SZYUcQg9NY8UYgfPiu9t3pH
 t5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892894; x=1740497694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmkrNq5AplHw0xVY3u2oc/AEHxLEtLd2Oo9IUfvydDw=;
 b=jSMtXNFPQ1WYk31aQQL9VPxdm1iDHItwtqmqm4K61lwC3HLido4FD36etWxMqD+Tqw
 7TVXfRKbdoCjw7eYn06I9TlGH08t3Qbf49nfM2T1sGIiEJXEPaBmNMJrChft6NZGthNb
 eQkcXG2IUKHdtNLIXBXGH9XmpXDXDf3E6mCTqrhZCx8EJt5KhWifOR6txVURaNuTPRQA
 /V1Gw4opB3q3ZPxK0Cnp6OpgUQx+OM2Ib0NODGEmLsAOiWVA4cGs0RVeWYa429u/kMAs
 BdRUpH4BBgqM046fC3+idMtFSxF6L3wadOWFdVR/OZtB1uYMz8PiIQhGYe9lSxFWkX8l
 rfnw==
X-Gm-Message-State: AOJu0YwidFgnLj3R5SEZ1zhvfxj6ZJe2gONO7M9HwLGx0JjAiL7MFWjn
 FrkpXzuhwEztkMEHz5iiaWmAMwjN45KY9pfg1GAqeCcjjEB86KEw+lwZMN+n727bmkpFPbd24CF
 AIcotwsMr/vddLXO+43mSXMSYqJY=
X-Gm-Gg: ASbGncuOo/WOxznxWOA6uiAMt9r9SKam8lwLuSkAIroN5hqMZJI2sqWvadWCgwDPwWl
 mNY6AauSYFFQEt+i6T3NHkFcib+Uzpnaj030hpvAR19iuRQvxKCuVpnTSUv6xzWB7yqTpFnpgwA
 ==
X-Google-Smtp-Source: AGHT+IFk+aNlV5J8yHUklcMbEDK/VkmM81/GL/FAx6k6cB4DJls1vjzKQae9D82uOhtFLZvimVma8QeAjmHw+x6P+Vk=
X-Received: by 2002:a05:6402:3585:b0:5de:b7b9:445d with SMTP id
 4fb4d7f45d1cf-5e088db1cdbmr254980a12.7.1739892894273; Tue, 18 Feb 2025
 07:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20231010062216.16144-1-loyou85@gmail.com>
In-Reply-To: <20231010062216.16144-1-loyou85@gmail.com>
From: Feng Sun <loyou85@gmail.com>
Date: Tue, 18 Feb 2025 23:34:17 +0800
X-Gm-Features: AWEUYZmjgkhSiTY7NLSinjlLFGZWllDRNXxjVY6pxO8evSltKgpZcPjarhc1sNI
Message-ID: <CAAiCvkg01PSgSVpRE2TaW=xX6L1FExJHR0ScELK1qo4TiH3e-Q@mail.gmail.com>
Subject: Re: [Ping][PATCH] virtio-serial-bus: Discard throttled
 VirtQueueElement when virtio-serial closed
To: lvivier@redhat.com, amit@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=loyou85@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping again.

On Tue, 10 Oct 2023 at 14:23, Sun Feng <loyou85@gmail.com> wrote:
>
> With commit d4c19cde("virtio-serial: add missing virtio_detach_element() call"),
> when virtio serial is throttled and closed by host, port->elem should be discard with virtqueue_push,
> otherwise virtqueue will not rewind, guest will blocked finally and cannot write anymore data.
>
> It can be reproduced with following steps:
> Create a vm with virtio-serial device through libvirt:
>
>     <channel type='unix'>
>       <source mode='bind' path='/tmp/test'/>
>       <target type='virtio' name='com.test.channel.0'/>
>       <address type='virtio-serial' controller='0' bus='0' port='1'/>
>     </channel>
>
> Host run:
> watch -n0.5 'timeout 0.5 nc -U /tmp/test'
>
> Guest run:
> hexdump -C -v /dev/zero > /dev/vport1p1
>
> After sometime, guest can not write any data to serial.
> We can see vq->last_avail_idx - vq->used_idx = 128 with gdb.
>
> (gdb) p *(struct VirtQueue *) 0x565161c5c788
> $4 = {vring = {num = 128, num_default = 128, align = 4096, desc = 4316049408, avail = 4316051456, used = 4316051776,
>     caches = 0x7fc530067e60}, used_elems = 0x565161c88dc0, last_avail_idx = 7929, last_avail_wrap_counter = true,
>   shadow_avail_idx = 7929, shadow_avail_wrap_counter = true, used_idx = 7801, used_wrap_counter = true, signalled_used = 7801,
>   signalled_used_valid = true, notification = true, queue_index = 5, inuse = 0, vector = 1,
>   handle_output = 0x56515da8aea0 <handle_output>, handle_aio_output = 0x0, vdev = 0x565161c54e30, guest_notifier = {rfd = 0,
>     wfd = 0}, host_notifier = {rfd = 74, wfd = 74}, host_notifier_enabled = true, node = {le_next = 0x565161c5c6f0,
>     le_prev = 0x565161c5c8a8}}
>
> Fixes: d4c19cde("virtio-serial: add missing virtio_detach_element() call")
> Signed-off-by: Sun Feng <loyou85@gmail.com>
> ---
>  hw/char/virtio-serial-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index dd619f0..30b00a4 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -151,7 +151,7 @@ static void discard_vq_data(VirtQueue *vq, VirtIODevice *vdev)
>  static void discard_throttle_data(VirtIOSerialPort *port)
>  {
>      if (port->elem) {
> -        virtqueue_detach_element(port->ovq, port->elem, 0);
> +        virtqueue_push(port->ovq, port->elem, 0);
>          g_free(port->elem);
>          port->elem = NULL;
>      }
> --
> 2.7.4
>

