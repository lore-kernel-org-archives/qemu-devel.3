Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DAAC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSI2W-0006rO-Oh; Fri, 12 Jul 2024 11:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sSI2Q-0006nN-JH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sSI2O-0004FY-FY
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720797497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDTo+7XnOi5POrNHv29ckpOlzi6zHfZvXjToRYHkBHM=;
 b=WGIaqIptzZ7f1ZyMhZUeikC34fYOtk4b64dEGSUCupOg2q1zI4HRLbOuzMLp8QU01hYoIx
 G/s0weAodWzEex3BYSFrvELjZz2f/X66YkzYlV800FnItP681St+9OPllp21OesVXjarRi
 6U3cGYaEZSMlousqy4EWz/urbUN51XQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-OM8RH8TlNbO6QHb3B5Qn9g-1; Fri, 12 Jul 2024 11:18:15 -0400
X-MC-Unique: OM8RH8TlNbO6QHb3B5Qn9g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee91e5be95so24739031fa.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720797494; x=1721402294;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LDTo+7XnOi5POrNHv29ckpOlzi6zHfZvXjToRYHkBHM=;
 b=YslMA41qDBVjt2rWek9Ys9kE+fLUPCcSAol13MC7lCxIhakYjjmOdPTfn+F9GEzfZq
 WC36iqW6DjO/6yQ3fkU9DyP2mJ8fgjx5H0VGdz/8vveK8WmDAVcztVE3/WhutSS/YoMG
 Ksyko7MKyiJUXAlXX18sr0MNb/xnyQmjP1DYSK8//JuvQR460t1MEVYwtzHbI22Ejus9
 Smks3Mt7z0EjCUyJgG4n+hEUY1cAF+7dY+PkW2NTnsKpQQMEDCZFm/iwLx+EAXhEg60m
 0lw47FIlU2oJnTNaTRY9U68YbNI1dXeDJy2nEu7nZZDsy4ubS5pzbjT6IEE0gMYvFXkQ
 O44Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhw7U93vwRnM5bpCy3QfHi0ajFtAJdtVwSBvDAbybajn0SPUyz8eor2cubGbIB2caJyz18Ldahf+APX1Yo7ssNkivPyzA=
X-Gm-Message-State: AOJu0Yy7nM2aqa/yxdueGLmn7otSaqNptBTZ5x0sw4rDE+yOhyY53AO8
 wf+iLMOdbkhYGH8OgjmmcEm6wmo8NzZDLMGjkWZtUKwLYeaiN98FztgrpQa3pY0Yz8Q26vlA647
 HWqrVR/KiXn14ZGi04hDYNIr8DxXZ/htHLpYBICkTbYmKTRljRFyo
X-Received: by 2002:a2e:99c8:0:b0:2ec:a022:880c with SMTP id
 38308e7fff4ca-2eeb30e4669mr101016821fa.22.1720797494039; 
 Fri, 12 Jul 2024 08:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcr0BP6AlUPMEKqAnOgRsYYQY0rIZ+f3qMpyCQ6bu0jlDNTIj20PApd6vs0lfUSZkQloOAog==
X-Received: by 2002:a2e:99c8:0:b0:2ec:a022:880c with SMTP id
 38308e7fff4ca-2eeb30e4669mr101016481fa.22.1720797493350; 
 Fri, 12 Jul 2024 08:18:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it.
 [82.57.51.153]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ffa13sm353374266b.129.2024.07.12.08.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 08:18:12 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:18:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL v3 52/85] contrib/vhost-user-*: use QEMU bswap helper
 functions
Message-ID: <7xvllk2k3n4egbor4u32e6hmtgna6iedjpb3oxxpfk4qzpdcux@dwgysmq3ghx3>
References: <cover.1720046570.git.mst@redhat.com>
 <5ab04420c3de11ae4a573b08b53584a2a0c5dd00.1720046570.git.mst@redhat.com>
 <CAFEAcA9Qvbz=S_-mEeeqgRdBXgxW+d3zrQxNZrcxg9S9G_UZQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9Qvbz=S_-mEeeqgRdBXgxW+d3zrQxNZrcxg9S9G_UZQA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

On Fri, Jul 12, 2024 at 03:24:47PM GMT, Peter Maydell wrote:
>On Wed, 3 Jul 2024 at 23:48, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
>> helpers to make the code more portable.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> Message-Id: <20240618100447.145697-1-sgarzare@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  contrib/vhost-user-blk/vhost-user-blk.c |  9 +++++----
>>  contrib/vhost-user-input/main.c         | 16 ++++++++--------
>>  2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
>> index a8ab9269a2..9492146855 100644
>> --- a/contrib/vhost-user-blk/vhost-user-blk.c
>> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
>> @@ -16,6 +16,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/bswap.h"
>>  #include "standard-headers/linux/virtio_blk.h"
>>  #include "libvhost-user-glib.h"
>>
>> @@ -194,8 +195,8 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
>>      #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
>>      VubDev *vdev_blk = req->vdev_blk;
>>      desc = buf;
>> -    uint64_t range[2] = { le64toh(desc->sector) << 9,
>> -                          le32toh(desc->num_sectors) << 9 };
>> +    uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
>> +                          le32_to_cpu(desc->num_sectors) << 9 };
>
>Hi; Coverity points out that this does a 32-bit shift, not a
>64-bit one, so it could unintentionally chop the high bits off
>if desc->num_sectors is big enough (CID 1549454).
>We could fix this by making it
>    (uint64_t)le32_to_cpu(desc->num_sectors) << 9
>I think.

Yep, I think so! I'll send a patch.

>
>(It looks like the issue was already there before, so

Yes, it is pre-existing to this patch, introduced from the beginning 
with commit caa1ee4313 ("vhost-user-blk: add discard/write zeroes 
features support")

>Coverity has just noticed it because of the code change here.)

Ah, I thought it ran on all the code, not just the changes.

Thanks,
Stefano


