Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9A3C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEtH-0002gD-Rp; Wed, 26 Feb 2025 05:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnEtE-0002fk-OH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnEt9-00059B-96
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740566616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vDx4NvcWGFtMT5kTGg++J9KxpFjLL4IzOQsarKPP7V4=;
 b=ge2Px+R3M+d4quAyrcfN/sddJqyKV7GtEik3zY8CB9COTeJUyUh5wVqbyXSCakGDm5D00v
 y3rdXPdLxcoi/8Gmdjw2k7Zrg0ZGNcyHA4W3e8r4xdAOX6Lb6nWRc/9ACu4ovaEuYc2WK5
 rGTsZVG9k62fu9vTuayv5kOnLpXalQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-3M76vkgIOpuH5Pgq2O52aA-1; Wed, 26 Feb 2025 05:43:34 -0500
X-MC-Unique: 3M76vkgIOpuH5Pgq2O52aA-1
X-Mimecast-MFC-AGG-ID: 3M76vkgIOpuH5Pgq2O52aA_1740566613
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394b8bd4e1so33590405e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 02:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740566613; x=1741171413;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDx4NvcWGFtMT5kTGg++J9KxpFjLL4IzOQsarKPP7V4=;
 b=bS/Vn84RxDEKG9Pk+sJpGfb3HdCs48xY5THihSa1impEb4VvSp+4EbM+p4oZbefCev
 023RmY4gwk4fOnyY8by4nsAHSevD+lzHK5+Vyyqvw7Xr1EkzdPfWfm9lbRTxx+73zM/e
 hfRPOJmKhLQqeNYOQN7cepFyQ5atrsWVlP2IyzzuFiEdPpypBAmozKcKbQl5jUuJ0kSu
 y4vRSPsPBxhOTDwTWgmi0EhbnM0h1vW1cogeXSmn5kx19r3tHV5H34w282ub3KGJjM7P
 yNvX5h/e4uYG/rePLwi8RUKa4dxC3pJr6yoqBaiNKYXgXvlq5Lb/QiaKZSIV/pEccZB+
 SZQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ND09dv51K6NGoxcLXa1NagJwQy319ncSbcuXJ9If/KtyCFTPb6keWabPwTBeb6cnTONqvolwWPLZ@nongnu.org
X-Gm-Message-State: AOJu0YxS+23g9bwTbclYp4X2wEZS28ebcV4vHuOjN3xlOdSdlrB1fzrM
 t8SF0LJ3CoEB4q+FRD1U33da8t49YX4S9nJlf/9xEp/DN0HD/4Ikt4BQFfcLyhaosgyZR9Y/4MB
 hmhNC4R1jsjriYPa54sKqOlBD1EXhIstC0pmTc2l/IH4XdXopqBa+
X-Gm-Gg: ASbGncvjqaJ8IviaVrBMLTDUi8q1wC/gKH2CE2jGJnkz5AJxz/YHjYZZ5ALC+DVW5RR
 JJvZ237fqvP3V3Jl8BjLqPZ0Ic82cdVs51LDFiceJv9G2sQGBKrA9JQJlaV+3w/lniXdCjsb8Yy
 y+wWabGw1RQ4So4jQrt622oZCOyhCKwODCq07viXQl2jGjhSz6hihTKKb/tFkhntldv+hgbMEGP
 C3ytWcfpTGoGzd44YXiGCC7E7c09ktdoEGIXcgsgBQxhwdorna4gKPPVrnr8jCNB0gg9BucJ+4l
 lyaEGedmYSBwE9GnVXq36jhJfriUQ/iTo2aGK7+JDu5cXQbdKOTQg4IG5ls=
X-Received: by 2002:a5d:47c3:0:b0:38f:4176:7c25 with SMTP id
 ffacd0b85a97d-38f70772b51mr15652829f8f.2.1740566612870; 
 Wed, 26 Feb 2025 02:43:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzgZK5IWR6rEM6ikOIaEA7wmZPJU3xdXYeE24tE4uQ7GMYQC1uk3/na1awZO0zp7t78RrGAw==
X-Received: by 2002:a5d:47c3:0:b0:38f:4176:7c25 with SMTP id
 ffacd0b85a97d-38f70772b51mr15652798f8f.2.1740566612382; 
 Wed, 26 Feb 2025 02:43:32 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390de3bcb14sm504983f8f.40.2025.02.26.02.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 02:43:31 -0800 (PST)
Message-ID: <6ad969cd-e522-4c8b-9d95-05b4df3be002@redhat.com>
Date: Wed, 26 Feb 2025 11:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/36] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <4de9762ebf7e7857103eb276d1a26a092aee325d.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4de9762ebf7e7857103eb276d1a26a092aee325d.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
> 
> Therefore, each VFIO device state packet carries a header indicating its
> position in the stream.
> The raw device state data is saved into a VFIOStateBuffer for later
> in-order loading into the device.
> 
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c | 103 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h |   3 ++
>   hw/vfio/migration.c         |   1 +
>   hw/vfio/trace-events        |   1 +
>   4 files changed, 108 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index c2defc0efef0..5d5ee1393674 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -42,6 +42,11 @@ typedef struct VFIOStateBuffer {
>   } VFIOStateBuffer;
>   
>   typedef struct VFIOMultifd {
> +    VFIOStateBuffers load_bufs;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
>   } VFIOMultifd;
>   
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -87,15 +92,113 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>   }
>   

this routine expects load_bufs_mutex to be locked ? May be say so.

> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,

could you pass VFIOMultifd* instead  ?

> +                                          VFIODeviceStatePacket *packet,
> +                                          size_t packet_total_size,
> +                                          Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +
> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
> +                   packet->idx);
> +        return false;
> +    }
> +
> +    assert(packet->idx >= multifd->load_buf_idx);
> +
> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
> +    lb->len = packet_total_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    return true;
> +}
> +
> +bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                            Error **errp)
  

AFAICS, the only users of the .load_state_buffer() handlers is
multifd_device_state_recv().

Please rename to vfio_multifd_load_state_buffer().

> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +
> +    /*
> +     * Holding BQL here would violate the lock order and can cause
> +     * a deadlock once we attempt to lock load_bufs_mutex below.
> +     */
> +    assert(!bql_locked());
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        error_setg(errp,
> +                   "got device state packet but not doing multifd transfer");
> +        return false;
> +    }
> +
> +    assert(multifd);
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "packet too short at %zu (min is %zu)",
> +                   data_size, sizeof(*packet));
> +        return false;
> +    }
> +
> +    if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
> +        error_setg(errp, "packet has unknown version %" PRIu32,
> +                   packet->version);
> +        return false;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "packet has too high idx");

or "packet index is invalid" ?

> +        return false;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> +
> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);

Using WITH_QEMU_LOCK_GUARD() would be cleaner I think.

> +
> +    /* config state packet should be the last one in the stream */
> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +        multifd->load_buf_idx_last = packet->idx;
> +    }
> +
> +    if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size, errp)) {
> +        return false;
> +    }
> +
> +    qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +
> +    return true;
> +}
> +
>   VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>   
> +    vfio_state_buffers_init(&multifd->load_bufs);
> +
> +    qemu_mutex_init(&multifd->load_bufs_mutex);
> +
> +    multifd->load_buf_idx = 0;
> +    multifd->load_buf_idx_last = UINT32_MAX;
> +    qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
> +
>       return multifd;
>   }
>   
>   void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
> +    qemu_mutex_destroy(&multifd->load_bufs_mutex);
> +
>       g_free(multifd);
>   }
>   
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 1eefba3b2eed..d5ab7d6f85f5 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -22,4 +22,7 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>   
>   bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>   
> +bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                            Error **errp);
> +
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4311de763885..abaf4d08d4a9 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -806,6 +806,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,>   };
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1bebe9877d88..042a3dc54a33 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -153,6 +153,7 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> 


Thanks,

C.




