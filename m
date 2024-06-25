Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE33C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0S4-0006eY-HB; Tue, 25 Jun 2024 03:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sM0S2-0006eH-7j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sM0S0-0000nl-L8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719299928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWCWxadpkxAfQSZo1mC/R+/tdXXA2hfkEP8XKAokkSE=;
 b=TzSbqu8KLfTw6aotIsSARE8/HQO3bLA8eSU++PuWQjwZ5cNWGuQyF8P3bmaaQs+mwEP7Iy
 vSkF032fCqpqT78s2BEM4abbm3bdgdhnwWyZ2WkNnEPwFQIwWyjqciwyFfiRorWeYk9f/q
 moDNgVMEYX7CPVAE6nmUMJYXBZ6tjRg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-CFt1R4LEMU2imO-E_M8zKQ-1; Tue, 25 Jun 2024 03:18:41 -0400
X-MC-Unique: CFt1R4LEMU2imO-E_M8zKQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7244d1b086so158557966b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719299920; x=1719904720;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWCWxadpkxAfQSZo1mC/R+/tdXXA2hfkEP8XKAokkSE=;
 b=jogilaiKV70ObDDPiuB6HXdIFmpkby350PcLuexFEpMijfhUCA4mh59q5ttwTznu09
 H+Th+lFVU/T7HYchXC4OvAbbY5nzQ78bQ2K6kGHPHB9gpvYl+xevc82zwnEOWRqv2svw
 xUS/nc7Zi1oaCWKI7t+TSPA5eJ911UX7KO9kSbIJ23t2Lu+ChcA04NHoOrsl8n+iJvuP
 w3I+wU3s53N1cGHRrtj7eBX7sM6RBa/en+Bn0zzwk+2F4GH3+1MQUmlUT2rurhODi1X+
 6zFlZFUjVmGUF0T19qPlWaUkBVo2xudj8a0slWtX546sJVc5KhLaeEdO8MNsFeKpgz2O
 DsWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk09pOYkx5C8mUJr19FKp4wTWOXcGZiT6zNWV85YErVs/wiY3ssxIDSdA4dIOB0oM151tcPrn9IlQaQCaYQoa5clBLyuM=
X-Gm-Message-State: AOJu0YziD3Ea9ynvDpQk+yjvLoIrHUFCje344hhmwhmh75yoPb9XzO7u
 f+oNA3rkYEPRu/PsAYcEgNtGSKtgQ7WhkDKz9FhhJJhjWbQXYGVgwBNa9objgUqy6eqC6R8kgKK
 uGfvhSqnjoDsQCp9TXHFmAMSsCVR9Fq6wMGpVgtJy2H2nlqyzRhrS
X-Received: by 2002:a50:9312:0:b0:57c:563b:cc40 with SMTP id
 4fb4d7f45d1cf-57d4bd8d838mr4030304a12.25.1719299920431; 
 Tue, 25 Jun 2024 00:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEacu3ub/FVWvZlIP8FSlyqv8ya+G75z9R82k8WrHgahWYKjdIFXZXuzvoLSGd0TsX7T64qKA==
X-Received: by 2002:a50:9312:0:b0:57c:563b:cc40 with SMTP id
 4fb4d7f45d1cf-57d4bd8d838mr4030279a12.25.1719299919749; 
 Tue, 25 Jun 2024 00:18:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.252])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d10csm5626852a12.40.2024.06.25.00.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 00:18:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:18:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Xoykie <xoykie@gmail.com>, qemu-devel@nongnu.org, 
 Eugenio Perez Martin <eperezma@redhat.com>, thuth@redhat.com, cohuck@redhat.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [Bug Report] Possible Missing Endianness Conversion
Message-ID: <2ktqnpqfb7lh3vip2rulobxrobyycjomaxfucdz3bhzbtfjkia@ibml6lv475un>
References: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
 <CAGxU2F4Q5ewt442zGvUhfMuXYcRENEingFQVuu5VK_wQBizE3Q@mail.gmail.com>
 <CAFEAcA9hdkZU0GF=v9Fj3GrYha=kgFr3GaKjd8kvsPHDdVCfRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9hdkZU0GF=v9Fj3GrYha=kgFr3GaKjd8kvsPHDdVCfRQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 24, 2024 at 04:19:52PM GMT, Peter Maydell wrote:
>On Mon, 24 Jun 2024 at 16:11, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> CCing Jason.
>>
>> On Mon, Jun 24, 2024 at 4:30 PM Xoykie <xoykie@gmail.com> wrote:
>> >
>> > The virtio packed virtqueue support patch[1] suggests converting
>> > endianness by lines:
>> >
>> > virtio_tswap16s(vdev, &e->off_wrap);
>> > virtio_tswap16s(vdev, &e->flags);
>> >
>> > Though both of these conversion statements aren't present in the
>> > latest qemu code here[2]
>> >
>> > Is this intentional?
>>
>> Good catch!
>>
>> It looks like it was removed (maybe by mistake) by commit
>> d152cdd6f6 ("virtio: use virtio accessor to access packed event")
>
>That commit changes from:
>
>-    address_space_read_cached(cache, off_off, &e->off_wrap,
>-                              sizeof(e->off_wrap));
>-    virtio_tswap16s(vdev, &e->off_wrap);
>
>which does a byte read of 2 bytes and then swaps the bytes
>depending on the host endianness and the value of
>virtio_access_is_big_endian()
>
>to this:
>
>+    e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
>
>virtio_lduw_phys_cached() is a small function which calls
>either lduw_be_phys_cached() or lduw_le_phys_cached()
>depending on the value of virtio_access_is_big_endian().
>(And lduw_be_phys_cached() and lduw_le_phys_cached() do
>the right thing for the host-endianness to do a "load
>a specifically big or little endian 16-bit value".)
>
>Which is to say that because we use a load/store function that's
>explicit about the size of the data type it is accessing, the
>function itself can handle doing the load as big or little
>endian, rather than the calling code having to do a manual swap after
>it has done a load-as-bag-of-bytes. This is generally preferable
>as it's less error-prone.

Thanks for the details!

So, should we also remove `virtio_tswap16s(vdev, &e->flags);` ?

I mean:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..2e5e67bdb9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
      /* Make sure flags is seen before off_wrap */
      smp_rmb();
      e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
-    virtio_tswap16s(vdev, &e->flags);
  }

  static void vring_packed_off_wrap_write(VirtIODevice *vdev,

Thanks,
Stefano

>
>(Explicit swap-after-loading still has a place where the
>code is doing a load of a whole structure out of the
>guest and then swapping each struct field after the fact,
>because it means we can do a single load-from-guest-memory
>rather than a whole sequence of calls all the way down
>through the memory subsystem.)
>
>thanks
>-- PMM
>


