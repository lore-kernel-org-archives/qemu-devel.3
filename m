Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6C0C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 13:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnHnV-0004BO-C0; Wed, 26 Feb 2025 08:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnHnS-0004Ar-I9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnHnP-0003aS-Jj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740577792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kya2Jbxgn8Gn3P5jN6211txp198DE/zCEzvhVMdK+ho=;
 b=FF0sEiBQ5BzSqVMznYUJA+qlmXo+1Ds4tlIOQbIV6V/nLIGnwDL0JZ7BNoVRUqLFV836AG
 qzHaEK7qperajbifFkvwBKbFktdTUliHBWOfCkw1qoaJ41UpdlpjCmIkvDL7t6k7f7NIQj
 29v0d5jf+GgXySj1dXTvLsqLds7/Ksk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-THjvss_2NuepFb2ssaZylQ-1; Wed, 26 Feb 2025 08:49:50 -0500
X-MC-Unique: THjvss_2NuepFb2ssaZylQ-1
X-Mimecast-MFC-AGG-ID: THjvss_2NuepFb2ssaZylQ_1740577790
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so37346285e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 05:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577789; x=1741182589;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kya2Jbxgn8Gn3P5jN6211txp198DE/zCEzvhVMdK+ho=;
 b=Ui/KzZu8luDa30qFzkS0Kyq1jNQs0QcLxTolm4lfC8e0NvesoNyhjlOWau/0+xOXz5
 GyR8h//V1mNgd/QcUtWMrLCj5KDDEEsFETgByWVaNhwWQipnN3WcDCHrFiq91ipFftgw
 EFvdWXpJnyHW25F1L3COGeK9cNeL3wDYQRKEVE7/75BHVb490OQ4LT+SYtC3vgEesZ8Q
 /9dhNYHByyvBCf6O3N3oR67N4+CK1m1ZzkeqR2LB87IAxnAhkGlQctX9D9KAJmy4bXJH
 Pj2tIoIvBD7tKIPw7mbnP1TVhcy8RmrwD2EIth3+KLip7iciS9pU03LX4ppKGG6wH8Xb
 E/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF50ZnlLRRNaUE55HgWbY6fo0yg0baOAOnzh7aNjVmmithoL8uECUAPuBQdGbpR1ZsspaGKpJrufxr@nongnu.org
X-Gm-Message-State: AOJu0YxICKNNeNsYoivLWB5bTW/8sLOFc0tWWhJ3ihUzBXONeCkJfdEc
 NLTN2C8IEkIFwqQlkJu+mQbKW0m38zFLMPMePXbnmv9OEcOIw9UWnOn6pJ8TiOSku6u5UFbkpRJ
 fpfbBkULcwoKUHH/2qyPZGVnNpVCYojRBvT77/zDBxCbMJSdS3W+x
X-Gm-Gg: ASbGncsv5ZPdWSGBpMxrM6fuuxruKjiE7aMR8mb/WPvaVoyrNJopDbM4R9pLnhj8ssi
 benOnVUl8HHM80zwUaLU2jS8S4tnPakwmBedLrxghOjutBPJCi6V0A1H9IdhINPJYGWEQSQNWHR
 Xjoo5bpM1rDgKH9MKsXJylZU8ufHOe5VDpK7ZEncn7Tcx/3Zb+Ak2t2PC9IOFkL7qJymYF8HkrB
 Mqyx/2cp9SCZxGDgR72MP76xt28gYgO+eTYzm3HZAaYqOxCCb7wG3N0W6kr9lGisJE5NiufoLkV
 gn1FGmYup+HWpp74dPwq+/CjBvc5Z8q14YpRcTbDSW7XbG/pHco5yZ/kMPc=
X-Received: by 2002:a05:600c:4f45:b0:439:88bb:d007 with SMTP id
 5b1f17b1804b1-43ab0f28850mr65526855e9.3.1740577789416; 
 Wed, 26 Feb 2025 05:49:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7mhs0FHXYLZodsU2F9ll4FcWd3u43McDj3ltYbPG6dDnFqgpA4NVXyGF/xhV5D4U5blKPKg==
X-Received: by 2002:a05:600c:4f45:b0:439:88bb:d007 with SMTP id
 5b1f17b1804b1-43ab0f28850mr65526585e9.3.1740577788892; 
 Wed, 26 Feb 2025 05:49:48 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5327f0sm22616535e9.9.2025.02.26.05.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 05:49:48 -0800 (PST)
Message-ID: <573fab5e-4c0f-416c-bbd0-4786ad25e18f@redhat.com>
Date: Wed, 26 Feb 2025 14:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
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
In-Reply-To: <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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
> Since it's important to finish loading device state transferred via the
> main migration channel (via save_live_iterate SaveVMHandler) before
> starting loading the data asynchronously transferred via multifd the thread
> doing the actual loading of the multifd transferred data is only started
> from switchover_start SaveVMHandler.
> 
> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
> 
> This sub-command is only sent after all save_live_iterate data have already
> been posted so it is safe to commence loading of the multifd-transferred
> device state upon receiving it - loading of save_live_iterate data happens
> synchronously in the main migration thread (much like the processing of
> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
> processed all the proceeding data must have already been loaded.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c | 225 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h |   2 +
>   hw/vfio/migration.c         |  12 ++
>   hw/vfio/trace-events        |   5 +
>   4 files changed, 244 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 5d5ee1393674..b3a88c062769 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -42,8 +42,13 @@ typedef struct VFIOStateBuffer {
>   } VFIOStateBuffer;
>   
>   typedef struct VFIOMultifd {
> +    QemuThread load_bufs_thread;
> +    bool load_bufs_thread_running;
> +    bool load_bufs_thread_want_exit;
> +
>       VFIOStateBuffers load_bufs;
>       QemuCond load_bufs_buffer_ready_cond;
> +    QemuCond load_bufs_thread_finished_cond;
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> @@ -179,6 +184,175 @@ bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>       return true;
>   }
>   
> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
> +{
> +    return -EINVAL;
> +}


please move to next patch.

> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
> +{
> +    VFIOStateBuffer *lb;
> +    guint bufs_len;

guint:  I guess it's ok to use here. It is not common practice in VFIO.

> +
> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
> +    if (multifd->load_buf_idx >= bufs_len) {
> +        assert(multifd->load_buf_idx == bufs_len);
> +        return NULL;
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
> +                               multifd->load_buf_idx);

Could be one line. minor.

> +    if (!lb->is_present) {
> +        return NULL;
> +    }
> +
> +    return lb;
> +}
> +
> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
> +                                         VFIOStateBuffer *lb,
> +                                         Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    g_autofree char *buf = NULL;
> +    char *buf_cur;
> +    size_t buf_len;
> +
> +    if (!lb->len) {
> +        return true;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
> +                                                   multifd->load_buf_idx);

I thin we can move this trace event to vfio_load_bufs_thread()

> +    /* lb might become re-allocated when we drop the lock */
> +    buf = g_steal_pointer(&lb->data);
> +    buf_cur = buf;
> +    buf_len = lb->len;
> +    while (buf_len > 0) {
> +        ssize_t wr_ret;
> +        int errno_save;
> +
> +        /*
> +         * Loading data to the device takes a while,
> +         * drop the lock during this process.
> +         */
> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);> +        errno_save = errno;
> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
> +
> +        if (wr_ret < 0) {
> +            error_setg(errp,
> +                       "writing state buffer %" PRIu32 " failed: %d",
> +                       multifd->load_buf_idx, errno_save);
> +            return false;
> +        }
> +
> +        assert(wr_ret <= buf_len);
> +        buf_len -= wr_ret;
> +        buf_cur += wr_ret;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> +                                                 multifd->load_buf_idx);

and drop this trace event.

In which case, we can modify the parameters of vfio_load_state_buffer_write()
to use directly a 'VFIOMultifd *multifd'and an fd instead of "migration->data_fd".

> +
> +    return true;
> +}
> +
> +static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
> +                                            bool *should_quit)
> +{
> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
> +}
> +
> +/*
> + * This thread is spawned by vfio_multifd_switchover_start() which gets
> + * called upon encountering the switchover point marker in main migration
> + * stream.
> + *
> + * It exits after either:
> + * * completing loading the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by it setting should_quit
> + *   or by vfio_load_cleanup_load_bufs_thread() setting
> + *   multifd->load_bufs_thread_want_exit.
> + */
> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    bool ret = true;
> +    int config_ret;

No needed IMO. see below.

> +
> +    assert(multifd);
> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
> +
> +    assert(multifd->load_bufs_thread_running);

We could add a trace event for the start and the end of the thread.

> +    while (true) {
> +        VFIOStateBuffer *lb;
> +
> +        /*
> +         * Always check cancellation first after the buffer_ready wait below in
> +         * case that cond was signalled by vfio_load_cleanup_load_bufs_thread().
> +         */
> +        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
> +            error_setg(errp, "operation cancelled");
> +            ret = false;
> +            goto ret_signal;

goto thread_exit ?

> +        }
> +
> +        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
> +
> +        lb = vfio_load_state_buffer_get(multifd);
> +        if (!lb) {
> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
> +                                                        multifd->load_buf_idx);
> +            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
> +                           &multifd->load_bufs_mutex);
> +            continue;
> +        }
> +
> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
> +            break;
> +        }
> +
> +        if (multifd->load_buf_idx == 0) {
> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
> +        }
> +
> +        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
> +            ret = false;
> +            goto ret_signal;
> +        }
> +
> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
> +        }
> +
> +        multifd->load_buf_idx++;
> +    }

if ret is assigned to true here, the "ret = false" can dropped

> +    config_ret = vfio_load_bufs_thread_load_config(vbasedev);
> +    if (config_ret) {
> +        error_setg(errp, "load config state failed: %d", config_ret);
> +        ret = false;
> +    }

please move to next patch. This is adding nothing to this patch
since it's returning -EINVAL.


Thanks,

C.



> +ret_signal:
> +    /*
> +     * Notify possibly waiting vfio_load_cleanup_load_bufs_thread() that
> +     * this thread is exiting.
> +     */
> +    multifd->load_bufs_thread_running = false;
> +    qemu_cond_signal(&multifd->load_bufs_thread_finished_cond);
> +
> +    return ret;
> +}
> +
>   VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
> @@ -191,11 +365,42 @@ VFIOMultifd *vfio_multifd_new(void)
>       multifd->load_buf_idx_last = UINT32_MAX;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>   
> +    multifd->load_bufs_thread_running = false;
> +    multifd->load_bufs_thread_want_exit = false;
> +    qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
> +
>       return multifd;
>   }
>   
> +/*
> + * Terminates vfio_load_bufs_thread by setting
> + * multifd->load_bufs_thread_want_exit and signalling all the conditions
> + * the thread could be blocked on.
> + *
> + * Waits for the thread to signal that it had finished.
> + */
> +static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
> +{
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        while (multifd->load_bufs_thread_running) {
> +            multifd->load_bufs_thread_want_exit = true;
> +
> +            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +            qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
> +                           &multifd->load_bufs_mutex);
> +        }
> +    }
> +    bql_lock();
> +}
> +
>   void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    vfio_load_cleanup_load_bufs_thread(multifd);
> +
> +    qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
> +    vfio_state_buffers_destroy(&multifd->load_bufs);
>       qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
>       qemu_mutex_destroy(&multifd->load_bufs_mutex);
>   
> @@ -225,3 +430,23 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>   
>       return true;
>   }
> +
> +int vfio_multifd_switchover_start(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +
> +    assert(multifd);
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        assert(!multifd->load_bufs_thread_running);
> +        multifd->load_bufs_thread_running = true;
> +    }
> +    bql_lock();
> +
> +    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
> +
> +    return 0;
> +}
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index d5ab7d6f85f5..09cbb437d9d1 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -25,4 +25,6 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>   bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>                               Error **errp);
>   
> +int vfio_multifd_switchover_start(VFIODevice *vbasedev);
> +
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index abaf4d08d4a9..85f54cb22df2 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -793,6 +793,17 @@ static bool vfio_switchover_ack_needed(void *opaque)
>       return vfio_precopy_supported(vbasedev);
>   }
>   
> +static int vfio_switchover_start(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        return vfio_multifd_switchover_start(vbasedev);
> +    }
> +
> +    return 0;
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_prepare = vfio_save_prepare,
>       .save_setup = vfio_save_setup,
> @@ -808,6 +819,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_state = vfio_load_state,
>       .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
> +    .switchover_start = vfio_switchover_start,
>   };
>   
>   /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 042a3dc54a33..418b378ebd29 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -154,6 +154,11 @@ vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
>   vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> 


