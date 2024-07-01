Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E9BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOBsx-0008Kl-Fs; Mon, 01 Jul 2024 03:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sOBsv-0008J1-2e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sOBst-0003Gw-A7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719820534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bL8h7n/jEEtTXLHGrh4TV/lQ8j+NWLmj3NWaLmLtB0=;
 b=M3/rdmex8uUYAyvmSu7Ixkgv45uzaSTsCDYSzMoAi8WV2ZmHOFrSx3mwI+A+JnNqIc9oZO
 r5eLSsdMRw5H3aYQTXKRqpMJwiz5KAlU8n/Elq3U/bVIfCAPsKMeGWNDTmXItnCYfEBFZV
 2q7AkYht/FSxNpLorM4gI3uyeRTRou8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-C9P7p_d6P82J5T-yp9nMqA-1; Mon, 01 Jul 2024 03:55:33 -0400
X-MC-Unique: C9P7p_d6P82J5T-yp9nMqA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b057a9690bso33185926d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 00:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719820532; x=1720425332;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7bL8h7n/jEEtTXLHGrh4TV/lQ8j+NWLmj3NWaLmLtB0=;
 b=G1lKcH4x3UOCyOtciV4rKFtT6nNYeezPTNG87MHdHmPfQAfQ+ChJIHTdRi60QPZNbX
 pLMSnQUo9/uDku4T0Gaj9peUBminhHZqr5VLbCxEV1jc7YlGq60+ylo2iF4cvl1uy1id
 bgfS8zzsT7ugp5LRjEDutCdN7S7JA2XTby+b2Zwf3LHA48KmSGeEY6Ets6vZeCYL+3qA
 aj+DF/0X/fYeo0W/vyqbES+Imt2DcxuWv62YusmqNbGF63HSWlOXfHaMYvBphXLsXb4R
 muMv+GUw3ftWwrSmthI7ZBxPKOCdFubaMiwPkI8bpFzj9ZBFtcpnEttO5fx3wA2pXxX3
 rcAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/vQrQqejyNxfHyYvx3Q/Xt2BXZoCfksp6SLqNP8V6WGCKT0uIQIv/Auqo/weKWEuRbeWONgG+mOpoSpsPsGYK2r8DR60=
X-Gm-Message-State: AOJu0YzjMY511rfDqhjrANkSA5W6chgvOi+SQzCtDz6k+bIPnG2kJqlz
 sV9A7QbwtohwD1ZIxnAqb3VAgtUrbN8KPS3gLsFBbqew90sb3wJ5RFp1a4+a+c1q6Z0NpgqQVpF
 Gtt11pkp/0yM/5kb0XAELH8goD2zZnQk0qghB0XyLcJloG1YfY++l
X-Received: by 2002:a05:6214:501d:b0:6b0:774b:38c2 with SMTP id
 6a1803df08f44-6b5b7059b3dmr50231966d6.6.1719820532702; 
 Mon, 01 Jul 2024 00:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWtNgkS3ta3wHeWWK1KuTSa0SD6ZZaB5a2wz5cYLhaKeI20PL0lgGHGY/37NpgfM5HGVo2cA==
X-Received: by 2002:a05:6214:501d:b0:6b0:774b:38c2 with SMTP id
 6a1803df08f44-6b5b7059b3dmr50231866d6.6.1719820532210; 
 Mon, 01 Jul 2024 00:55:32 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.222.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59e73897dsm30796256d6.139.2024.07.01.00.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 00:55:31 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:55:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Xoykie <xoykie@gmail.com>, qemu-devel@nongnu.org, 
 Eugenio Perez Martin <eperezma@redhat.com>, thuth@redhat.com, cohuck@redhat.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [Bug Report] Possible Missing Endianness Conversion
Message-ID: <3pwcpenkksded3iax6ygsbdw5owrfy6zc7kajhqzwxzh5tcl6p@abrv5oifpeio>
References: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
 <CAGxU2F4Q5ewt442zGvUhfMuXYcRENEingFQVuu5VK_wQBizE3Q@mail.gmail.com>
 <CAFEAcA9hdkZU0GF=v9Fj3GrYha=kgFr3GaKjd8kvsPHDdVCfRQ@mail.gmail.com>
 <2ktqnpqfb7lh3vip2rulobxrobyycjomaxfucdz3bhzbtfjkia@ibml6lv475un>
 <CAFEAcA-cvU5RudZdokD+tHMGEHtUcoxowNwS4HxLWz5nvXqC9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-cvU5RudZdokD+tHMGEHtUcoxowNwS4HxLWz5nvXqC9w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jun 28, 2024 at 03:53:09PM GMT, Peter Maydell wrote:
>On Tue, 25 Jun 2024 at 08:18, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Mon, Jun 24, 2024 at 04:19:52PM GMT, Peter Maydell wrote:
>> >On Mon, 24 Jun 2024 at 16:11, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> CCing Jason.
>> >>
>> >> On Mon, Jun 24, 2024 at 4:30 PM Xoykie <xoykie@gmail.com> wrote:
>> >> >
>> >> > The virtio packed virtqueue support patch[1] suggests converting
>> >> > endianness by lines:
>> >> >
>> >> > virtio_tswap16s(vdev, &e->off_wrap);
>> >> > virtio_tswap16s(vdev, &e->flags);
>> >> >
>> >> > Though both of these conversion statements aren't present in the
>> >> > latest qemu code here[2]
>> >> >
>> >> > Is this intentional?
>> >>
>> >> Good catch!
>> >>
>> >> It looks like it was removed (maybe by mistake) by commit
>> >> d152cdd6f6 ("virtio: use virtio accessor to access packed event")
>> >
>> >That commit changes from:
>> >
>> >-    address_space_read_cached(cache, off_off, &e->off_wrap,
>> >-                              sizeof(e->off_wrap));
>> >-    virtio_tswap16s(vdev, &e->off_wrap);
>> >
>> >which does a byte read of 2 bytes and then swaps the bytes
>> >depending on the host endianness and the value of
>> >virtio_access_is_big_endian()
>> >
>> >to this:
>> >
>> >+    e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
>> >
>> >virtio_lduw_phys_cached() is a small function which calls
>> >either lduw_be_phys_cached() or lduw_le_phys_cached()
>> >depending on the value of virtio_access_is_big_endian().
>> >(And lduw_be_phys_cached() and lduw_le_phys_cached() do
>> >the right thing for the host-endianness to do a "load
>> >a specifically big or little endian 16-bit value".)
>> >
>> >Which is to say that because we use a load/store function that's
>> >explicit about the size of the data type it is accessing, the
>> >function itself can handle doing the load as big or little
>> >endian, rather than the calling code having to do a manual swap after
>> >it has done a load-as-bag-of-bytes. This is generally preferable
>> >as it's less error-prone.
>>
>> Thanks for the details!
>>
>> So, should we also remove `virtio_tswap16s(vdev, &e->flags);` ?
>>
>> I mean:
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 893a072c9d..2e5e67bdb9 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
>>       /* Make sure flags is seen before off_wrap */
>>       smp_rmb();
>>       e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
>> -    virtio_tswap16s(vdev, &e->flags);
>>   }
>
>That definitely looks like it's probably not correct...

Yeah, I just sent that patch: 
https://lore.kernel.org/qemu-devel/20240701075208.19634-1-sgarzare@redhat.com

We can continue the discussion there.

Thanks,
Stefano


