Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE9CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1J4K-0001MN-IU; Wed, 24 Sep 2025 02:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v1J4E-0001Jy-I0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v1J3F-0005py-Ej
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758695543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEDOgbZmY0NzAxxBt1XQSNhzuSfHiDjnE5F2iQW6/DM=;
 b=SSR8ZuPfQgzzIWbBEZd0KDnN5KPjhT3atmEoQGEYD79Xy1gE52FqLZaU+77+ZCI3zc9QfL
 0yK6PcY7bjQceU0/JL2/ynaPMKzUPsQT7/qqq4bC+7XqNag9OX49UDbYo3ErrzmqcLH203
 euzwC0ZBB2hjEPgEskc5Cbu+04myzTY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-wzlgmiD9PBGfMR67hHaLBA-1; Wed, 24 Sep 2025 02:32:15 -0400
X-MC-Unique: wzlgmiD9PBGfMR67hHaLBA-1
X-Mimecast-MFC-AGG-ID: wzlgmiD9PBGfMR67hHaLBA_1758695534
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32e09eaf85dso7751084a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 23:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758695534; x=1759300334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEDOgbZmY0NzAxxBt1XQSNhzuSfHiDjnE5F2iQW6/DM=;
 b=vWKzzyaHLVyDtspKLWugMCLYfcioMFwX8I7NP8itkqHqLKarWT/0sSAm/7FBxELlFp
 TbmAE0UHouHU4vZKt2e9lu+jk5JxkuGzgv1+GbsZ+q1KueR+p3KAstlqzK0f6D1phCXa
 iB1J/UQik4X5UlwMqyC3bJnWeJfGLM5lThUpptxW0f9IpVhv4aEUaXVOPvhckhmEj86s
 7xXj2bxphaAUMlqkIPkdG9ya7stwQohNnsWftwfMbJX+5di5r50lAIq7uuA5nmCBe5YZ
 bJ8N9LFXIENIc8NXXCxzzCP3Qex6qCAV2lyOJsHcykhrYA7aAYSj6WWIXkWepf8Rj5iV
 aKPg==
X-Gm-Message-State: AOJu0YwmcgRZkRTkjlg54EKczg0sH35DotJjXz3O67iiQCQcyiRHID9x
 hFL8YCeERgs8mLWjOOsUgtTyD0wYe6xsbc6r3i7xkUhFLQs4e1QuB+kXSLL7xlBNwEiqh+5zOcT
 z4XgALUAxagz3cBjUOoSyJ1ZDo75NUWqpKk8g/ngpNYtjqpQAz4FSfWELZvNwTXlHXWAJTlD9Sg
 8VT/DWnqdavgk1laEFtqdOljZ8pqd3rh0=
X-Gm-Gg: ASbGnctVD1juzttGjHdXvX8TpGyJVlPIkuKE1iwYfah2cxHoOsqYsxUXJPG03R6Ykyc
 IUdq6/zf6flZ9MVEFgn0DM6yn0jNGyVtgox95fX0sDzS5Gtrw+UlSeD/bnIkFjYPMqYUUB4ryzi
 ISP/FKlMolaaQwYoqumw==
X-Received: by 2002:a17:90b:1b47:b0:330:4d30:5009 with SMTP id
 98e67ed59e1d1-332a94da7b4mr5679583a91.2.1758695534262; 
 Tue, 23 Sep 2025 23:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjGRurbEUK/SpB3YuFpttfO+FqRS9fSb263blrIVlSewZfdANrzgElXj8nMsDMa4AXnWF/RhPkXv8Rt7SfycI=
X-Received: by 2002:a17:90b:1b47:b0:330:4d30:5009 with SMTP id
 98e67ed59e1d1-332a94da7b4mr5679555a91.2.1758695533776; Tue, 23 Sep 2025
 23:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250924062831.1788305-1-hzuo@redhat.com>
In-Reply-To: <20250924062831.1788305-1-hzuo@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 14:32:02 +0800
X-Gm-Features: AS18NWA8kk1bilSrPyfj02sFU-t0-mmoVTnxdSa7s-p6lCfPEOISGWdabsPVQfA
Message-ID: <CACGkMEt9f0d1E9=4cw8p6-mFiq3ASVoxmXrCygyhz5r+o1mVdw@mail.gmail.com>
Subject: Re: [PATCH] net/net.c: add tap device fd validity check to prevent
 abort on deleted device
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 2:29=E2=80=AFPM Houqi (Nick) Zuo <hzuo@redhat.com> =
wrote:
>
> This patch addresses a scenario where QEMU would abort with a core dump
> when a tap device created by QEMU is manually deleted from the host while
> the guest is running.
>
> The specific negative test case is:
> 1. Start QEMU with a tap device (created by QEMU)
> 2. Manually delete the tap device on the host
> 3. Execute shutdown in the guest
> 4. QEMU attempts to clean up the tap device but finds the file descriptor
>    in a bad state, leading to abort and core dump
>
> The patch introduces a tap device file descriptor validity check using
> the TUNGETIFF ioctl to detect when the underlying tap device has been
> removed. When detected, the operations are skipped gracefully instead
> of proceeding with invalid file descriptors that cause ioctl failures.
>
> The validity check is integrated into:
> - qemu_set_vnet_hdr_len() in net/net.c
> - qemu_set_offload() in net/net.c
>
> This ensures that when the tap device is no longer valid, these functions
> return early without attempting operations that would fail and trigger
> aborts,

Let's just remove the abort then?

> thus achieving the expected behavior of error reporting without
> crashing.
>
> (gdb) bt full
> #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
>         tid =3D <optimized out>
>         ret =3D 0
>         pd =3D <optimized out>
>         old_mask =3D {__val =3D {10}}
>         ret =3D <optimized out>
> #1  0x00007f1710b6bff3 in __pthread_kill_internal (threadid=3D<optimized =
out>, signo=3D6) at pthread_kill.c:78
> #2  0x00007f1710b15f56 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
>         ret =3D <optimized out>
> #3  0x00007f1710afd8fa in __GI_abort () at abort.c:79
>         save_stage =3D 1
>         act =3D {__sigaction_handler =3D {sa_handler =3D 0x20, sa_sigacti=
on =3D 0x20}, sa_mask =3D {__val =3D {16929458408262392576, 184467440737095=
50848, 139737042419943, 139737042419943, 0, 94049703655600, 139737042419943=
, 139737042670528, 18446744073709550328, 77, 139705603579344, 1844674407370=
9551615, 139737041472378, 139705595179568, 16929458408262392576, 9404967979=
4864}}, sa_flags =3D 281695456, sa_restorer =3D 0xa}
> #4  0x000055899a71de58 in tap_fd_set_vnet_hdr_len (fd=3D<optimized out>, =
len=3D10) at ../net/tap-linux.c:204
> #5  tap_set_vnet_hdr_len (nc=3D<optimized out>, len=3D10) at ../net/tap.c=
:269
>         s =3D <optimized out>
> #6  0x000055899a8be67f in qemu_set_vnet_hdr_len (nc=3D0x2956, len=3D10588=
) at ../net/net.c:573
> #7  virtio_net_set_mrg_rx_bufs (n=3D0x5589a72cfa10, mergeable_rx_bufs=3D<=
optimized out>, version_1=3D<error reading variable: Incompatible types on =
DWARF stack>, hash_report=3D<optimized out>) at ../hw/net/virtio-net.c:664
>         i =3D 0
>         nc =3D 0x5589a730ab28
> #8  virtio_net_set_features (vdev=3D0x5589a72cfa10, features=3D0) at ../h=
w/net/virtio-net.c:897
>         n =3D 0x5589a72cfa10
>         err =3D 0x0
>         i =3D 0
> #9  0x000055899a8e4eaa in virtio_set_features_nocheck (vdev=3D0x5589a72cf=
a10, val=3D0) at ../hw/virtio/virtio.c:3079
>         k =3D <optimized out>
>         bad =3D <optimized out>
> #10 virtio_reset (opaque=3D0x5589a72cfa10) at ../hw/virtio/virtio.c:3184
>         vdev =3D 0x5589a72cfa10
>         k =3D 0x5589a5c162b0
>         i =3D 0
> #11 0x000055899a630d2b in virtio_bus_reset (bus=3D0x5589a72cf990) at ../h=
w/virtio/virtio-bus.c:109
>         vdev =3D <optimized out>
> #12 virtio_pci_reset (qdev=3D0x5589a72c7470) at ../hw/virtio/virtio-pci.c=
:2311
>         proxy =3D 0x5589a72c7470
>         i =3D 0
>         bus =3D 0x5589a72cf990
> #13 0x000055899a686ded in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at ../syst=
em/memory.c:490
>         tmp =3D <optimized out>
> #14 0x000055899a686cbc in access_with_adjusted_size (addr=3D20, value=3D0=
x7f0fbedfde00, size=3D1, access_size_min=3D<optimized out>, access_size_max=
=3D<optimized out>, access_fn=3D0x55899a686d30 <memory_region_write_accesso=
r>, mr=3D0x5589a72c8040, attrs=3D...) at ../system/memory.c:566
>         print_once_ =3D false
>         access_mask =3D 255
>         access_size =3D 1
>         i =3D 0
>         r =3D 0
>         reentrancy_guard_applied =3D <optimized out>
> #15 0x000055899a686ac5 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D20, data=3D<optimized out>, op=3D<optimized out>, attrs=3D...) =
at ../system/memory.c:1545
>         size =3D <optimized out>
> #16 0x000055899a69f7da in flatview_write_continue_step (attrs=3D..., buf=
=3D0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>, =
len=3D<optimized out>, mr_addr=3D20, l=3D0x7f0fbedfde28, mr=3D0x5589a72c804=
0) at ../system/physmem.c:2972
>         val =3D 6
>         result =3D 0
>         release_lock =3D <optimized out>
> #17 0x000055899a697c15 in flatview_write_continue (fv=3D0x7f0f6c124d90, a=
ddr=3D61675730370580, attrs=3D..., ptr=3D0x7f1711da6028, len=3D1, mr_addr=
=3D6, l=3D1, mr=3D0x0) at ../system/physmem.c:3002
>         result =3D 0
>         buf =3D 0x7f1711da6028 <error: Cannot access memory at address 0x=
7f1711da6028>
> #18 flatview_write (fv=3D0x7f0f6c124d90, addr=3D61675730370580, attrs=3D.=
.., buf=3D0x7f1711da6028, len=3D1) at ../system/physmem.c:3033
> --Type <RET> for more, q to quit, c to continue without paging--
>         l =3D <optimized out>
>         mr_addr =3D 6
>         mr =3D 0x0
> #19 0x000055899a697a91 in address_space_write (as=3D0x55899bceeba0 <addre=
ss_space_memory>, addr=3D61675730370580, attrs=3D..., buf=3D0x7f1711da6028,=
 len=3D1) at ../system/physmem.c:3153
>         _rcu_read_auto =3D 0x1
>         result =3D 0
>         fv =3D 0x2956
> #20 0x000055899a91159b in address_space_rw (addr=3D10588, attrs=3D..., bu=
f=3D0x7f1711da6028, len=3D0, as=3D<optimized out>, is_write=3D<optimized ou=
t>) at ../system/physmem.c:3163
> #21 kvm_cpu_exec (cpu=3D0x5589a5d68b40) at ../accel/kvm/kvm-all.c:3255
>         attrs =3D {secure =3D 0, space =3D 0, user =3D 0, memory =3D 0, d=
ebug =3D 0, requester_id =3D 0, pid =3D 0, address_type =3D 0, unspecified =
=3D false, _reserved1 =3D 0 '\000', _reserved2 =3D 0}
>         run =3D 0x7f1711da6000
>         ret =3D <optimized out>
>         run_ret =3D <optimized out>
> #22 0x000055899a9189ca in kvm_vcpu_thread_fn (arg=3D0x5589a5d68b40) at ..=
/accel/kvm/kvm-accel-ops.c:51
>         r =3D <optimized out>
>         cpu =3D <optimized out>
> #23 0x000055899aba817a in qemu_thread_start (args=3D0x5589a5d72580) at ..=
/util/qemu-thread-posix.c:393
>         __clframe =3D {__cancel_routine =3D <optimized out>, __cancel_arg=
 =3D 0x0, __do_it =3D 1, __cancel_type =3D <optimized out>}
>         qemu_thread_args =3D 0x5589a5d72580
>         start_routine =3D 0x55899a918850 <kvm_vcpu_thread_fn>
>         arg =3D 0x5589a5d68b40
>         r =3D 0x0
> #24 0x00007f1710b6a128 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:448
>         ret =3D <optimized out>
>         pd =3D <optimized out>
>         out =3D <optimized out>
>         unwind_buf =3D {cancel_jmp_buf =3D {{jmp_buf =3D {32, 88945440577=
43421332, -1288, 0, 140726164742416, 140726164742679, -8831356496486092908,=
 -8844535456800460908}, mask_was_saved =3D 0}}, priv =3D {pad =3D {0x0, 0x0=
, 0x0, 0x0}, data =3D {prev =3D 0x0, cleanup =3D 0x0, canceltype =3D 0}}}
>         not_first_call =3D <optimized out>
> #25 0x00007f1710bda924 in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:100
>
> Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
> ---

Thanks


