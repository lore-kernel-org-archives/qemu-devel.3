Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09E6CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rLb-0006a6-HN; Thu, 09 Oct 2025 10:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v6rLa-0006ZG-Gh
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v6rLR-0008MY-0R
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760019009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6BR09Yo65cMNs+PZOzcZ9j0c+B+ewk+HhDTaTeH4g8=;
 b=Ansmfu0kxmPclolAkmob7tLfCDhB7VsoIUCrRmFQFsM83+lnqYEttwb7yiYNnDqxr73t7Q
 SMRVkSbxZTwlqEOXxgd0gYqtyXZA9eGFHbEp0R7S+W8RoE88CzytQULzF1MMBrDIFHXogq
 BKN8t9VQIR/SYCRk4b5fPRpvEwdTw5E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Zqlkbrr6PAaA5_Pol_S_jw-1; Thu, 09 Oct 2025 10:10:06 -0400
X-MC-Unique: Zqlkbrr6PAaA5_Pol_S_jw-1
X-Mimecast-MFC-AGG-ID: Zqlkbrr6PAaA5_Pol_S_jw_1760019005
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b448c864d45so98401066b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019004; x=1760623804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6BR09Yo65cMNs+PZOzcZ9j0c+B+ewk+HhDTaTeH4g8=;
 b=gvflSszdDdb0mah2tYJiMi+uzEvgL7rst7x7TQr5oF0wdPVBqWsfs/P/jbY99Vw/0m
 ga0Nez79iTs2bYY6yW98OPeXaAT1I8vU7gT1EFIPb3IHkRDoNzOPA/gzXFsDjsA8T6Gs
 zwK3O/PSkp0gfowuBa7mGESt2Ho1j/0vD1bHhgCwlJoehgubELLQvvEAYDd0KlAjK2II
 r5i0/bB0/ydJGmT0ALSPtV329JcHTaGlCSHZkdM60jkGWZS+UPn7r4pFFkhCzciR3tSo
 qLK7uoc7L25w0YFfj4WRjngyWmuaycbXXMUpaguj57vwJzvBwMDIvG967mt9zwW8tbxq
 Fk9w==
X-Gm-Message-State: AOJu0YzJ7s58PhxIqokrlUvQV43/p138uc3LT2N9tgKwAHtdCiroxkbE
 08scb/naPPRZ8onO7HDEfJzr0pearHy5AxIyGjdJjgXSO/u0b/T7ffdH79qvlQEvkt1dJ5SF6tn
 Dcf7FM5nX8ZJf1Voxjw9Ska3Ct9TLbLhNFxjYp1CPkRpwLaQXUO86r9yojWD9ZKx53ooR9Bv83V
 ZEDy5lHc1btm5Y3MBeXWQgbulocEOBRiWH77U2hg0=
X-Gm-Gg: ASbGncslX+p2+EoSinlzMKPTpLQHbTW7d2f8DtCei2JYtjrSVDpcKNog2MdevFoikIF
 R2uHKMtyrKTxrbuN72GE9SLlzOEzKKTXxcz1kHjK/6za6/6/lf4jeMx1gnADOdmWshnfU+fAcTO
 MstvH3chtCKGwk99+o5u/qBcMV5d4=
X-Received: by 2002:a17:906:6a1f:b0:b41:660:13b8 with SMTP id
 a640c23a62f3a-b50aba9ebf7mr911870966b.31.1760019004488; 
 Thu, 09 Oct 2025 07:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjr4ePscFhYutahxTGsSG1imDV69Wi0QKDoBt0veW5oszI+xj0JC4DzudfiwqcNC9kE1OmGNLf8ULx8/qqY/g=
X-Received: by 2002:a17:906:6a1f:b0:b41:660:13b8 with SMTP id
 a640c23a62f3a-b50aba9ebf7mr911864266b.31.1760019003924; Thu, 09 Oct 2025
 07:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250925023235.1899458-1-hzuo@redhat.com>
In-Reply-To: <20250925023235.1899458-1-hzuo@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 9 Oct 2025 22:09:26 +0800
X-Gm-Features: AS18NWCzDznW5XosC471PZwn5RbXAeM5s85C48m-sN733MeK2gikvLEWYNbYisU
Message-ID: <CAPpAL=zmm+1qyy+MTs=7U+9NN5Q0juH2Je9idC+--z3MbrbvPA@mail.gmail.com>
Subject: Re: [PATCH v4] net/tap-linux.c: avoid abort when setting invalid fd
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tested this patch with virtio-net regression tests and also tested
reproducer for this problem, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Sep 25, 2025 at 10:35=E2=80=AFAM Houqi (Nick) Zuo <hzuo@redhat.com>=
 wrote:
>
> When QEMU creates a tap device automatically and the tap device is
> manually removed from the host while the guest is running, the tap
> device file descriptor becomes invalid. Later, when the guest executes
> shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
> abort QEMU with a core dump when attempting to use the invalid fd.
>
> This patch removes many abort() calls in this file. If the fd is found
> to be in a bad state (e.g., EBADFD or ENODEV), the related function
> will print an error message.
>
> The expected behavior for this negative test case is that QEMU should
> report an error but continue running rather than aborting.
>
> Testing:
> - Start QEMU with automatically created tap device
> - Manually remove the tap device on the host
> - Execute shutdown in the guest
> - Verify QEMU reports an error but does not abort
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
> Fixes: 0caed25cd171c611781589b5402161d27d57229c ("virtio: Call set_featur=
es during reset")
>
> Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
> ---
>  net/tap-linux.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index e832810665..24e63a0b54 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -206,15 +206,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
>      if (ioctl(fd, TUNSETVNETHDRSZ, &len) =3D=3D -1) {
>          fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n"=
,
>                  strerror(errno));
> -        abort();
>      }
>  }
>
>  int tap_fd_set_vnet_le(int fd, int is_le)
>  {
>      int arg =3D is_le ? 1 : 0;
> +    int ret;
>
> -    if (!ioctl(fd, TUNSETVNETLE, &arg)) {
> +    ret =3D ioctl(fd, TUNSETVNETLE, &arg);
> +    if (!ret) {
>          return 0;
>      }
>
> @@ -224,14 +225,16 @@ int tap_fd_set_vnet_le(int fd, int is_le)
>      }
>
>      error_report("TUNSETVNETLE ioctl() failed: %s.", strerror(errno));
> -    abort();
> +    return ret;
>  }
>
>  int tap_fd_set_vnet_be(int fd, int is_be)
>  {
>      int arg =3D is_be ? 1 : 0;
> +    int ret;
>
> -    if (!ioctl(fd, TUNSETVNETBE, &arg)) {
> +    ret =3D ioctl(fd, TUNSETVNETBE, &arg);
> +    if (!ret) {
>          return 0;
>      }
>
> @@ -241,7 +244,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>      }
>
>      error_report("TUNSETVNETBE ioctl() failed: %s.", strerror(errno));
> -    abort();
> +    return ret;
>  }
>
>  void tap_fd_set_offload(int fd, int csum, int tso4,
> --
> 2.47.3
>
>


