Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3B1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JPf-0003Ch-R3; Wed, 24 Sep 2025 02:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1v1JPW-0003Ad-IN
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1v1JPQ-0000at-GK
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQxfX9BrQwq6umDTvzg5t26KO85MA8ykQkggca2TiOg=;
 b=GJLBCGfyRby/3IY3xaSdKEByTZ7pFpH0kowdJwWNfB/EZj5F31o5lg/GC9met4zwkrHltb
 44sQok4zbbHsASM15pJ0igYnhgBaJ9NymAHZVx0lkye2SL0/SLJ/515noghWkDNnO1a9MW
 BsWOusAMEn+IsQEe60mC1Sz28wJ0qTU=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-tWG_pdjPNhO2ZtIPOV6Wkg-1; Wed, 24 Sep 2025 02:55:17 -0400
X-MC-Unique: tWG_pdjPNhO2ZtIPOV6Wkg-1
X-Mimecast-MFC-AGG-ID: tWG_pdjPNhO2ZtIPOV6Wkg_1758696916
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-8921abd6c84so6459692241.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 23:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758696916; x=1759301716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQxfX9BrQwq6umDTvzg5t26KO85MA8ykQkggca2TiOg=;
 b=SmeGSKh3LcWwh6NcURRpPob7jtb+pMV90HJgn8XC1zVH6ZePx+CJ5j+BGreu1NndTT
 vWpUijUNo8E9qf8IMUZnGlv1g838kTx9JPBv3zdTlDW0TXSNAxxPVMYuKFwD5OkSF4Zu
 gh+egqvB/54z55Vmib1ijU43i+5wgV2FA1rnMWunEeTLf4Wl21+WxVAm0Cn0vdh2ew6X
 CNKAcVPIkJraMWn+svtEdHwfaFfuVlxG1LAAJ2DsU7F4nwQGd4DlU4Xo6m8U1nLzbeys
 0nnQQpEcPVbS+EmulgQiNCf3sktAr66jXDHRNRkSLDoVMMcI2ZOKVzHGRs+nH6Y5o1Wx
 MyHg==
X-Gm-Message-State: AOJu0Ywxls/YCcetQNnCooFpKBiMUlnurkJvzj93jmq3bZ8dJL5WayPw
 2VvTFZ1wmMg4uoRlBNTyfeIcj4eJ5F330X+nvuHt6/gzG2HxnT8tztEVSoVSjnJKKLOVtVxTIVe
 iXzTWNKs6W1R+8/Hl2SNNBN3Lifl3UL3PCxWIQdbFey2rrqBnNzQ1u2xw0Ayl8lrXK/jMNds1Hr
 5yO51lmFUaofI76FwXyfIeYh0lDzG1qws=
X-Gm-Gg: ASbGncv975XEELPujJC/5kyaapZycQKy0BlVQ8IVBPR8zFdEStL7EwB79d9Blhffb4D
 8Q4DeIOimF05Ud1+gC6mpHpCGQi6DBBEPG0a2Ay/BP0sR+3wbid/PzgJrTwNKs4cqqsNgyA8J4B
 4DUuAaxXHUcYppPL2KlYg5rA==
X-Received: by 2002:a05:6102:9d7:b0:4fb:de9e:6d87 with SMTP id
 ada2fe7eead31-5a5787a9dc6mr2029598137.11.1758696916526; 
 Tue, 23 Sep 2025 23:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUuNAXcnrftPkG0c7rhZXgiGJJaAKNVvqoI9xzxH1c9BrinkSoHbkrQUosVm3SQU/cz6oZBVBkU5c/Udq7VLc=
X-Received: by 2002:a05:6102:9d7:b0:4fb:de9e:6d87 with SMTP id
 ada2fe7eead31-5a5787a9dc6mr2029589137.11.1758696916064; Tue, 23 Sep 2025
 23:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250924062831.1788305-1-hzuo@redhat.com>
In-Reply-To: <20250924062831.1788305-1-hzuo@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Sep 2025 14:54:38 +0800
X-Gm-Features: AS18NWCgGUns__TTZZ8sK8RVLu3V3pUf5XE4Vsa-IGu8inhSCFkcuona3a9Weww
Message-ID: <CACLfguXSoHSzJU4fiL-HXSApA4MY3HGgQpFBc7CuGcJ9W9+1UA@mail.gmail.com>
Subject: Re: [PATCH] net/net.c: add tap device fd validity check to prevent
 abort on deleted device
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
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

On Wed, Sep 24, 2025 at 2:28=E2=80=AFPM Houqi (Nick) Zuo <hzuo@redhat.com> =
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
> aborts, thus achieving the expected behavior of error reporting without
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
Please also add  Fixes: ***commit id ***** in the commit log


> Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
> ---
>  include/net/net.h |  2 ++
>  net/net.c         |  7 +++++--
>  net/tap-linux.c   | 11 +++++++++++
>  net/tap.c         |  9 +++++++++
>  net/tap_int.h     |  1 +
>  5 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 84ee18e0f9..9e435f3275 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -69,6 +69,7 @@ typedef void (NetAnnounce)(NetClientState *);
>  typedef bool (SetSteeringEBPF)(NetClientState *, int);
>  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error *=
*);
>  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
> +typedef int (QueryValidity)(NetClientState *nc);
>
>  typedef struct NetClientInfo {
>      NetClientDriver type;
> @@ -96,6 +97,7 @@ typedef struct NetClientInfo {
>      SetSteeringEBPF *set_steering_ebpf;
>      NetCheckPeerType *check_peer_type;
>      GetVHostNet *get_vhost_net;
> +    QueryValidity *query_validity;
>  } NetClientInfo;
>
>  struct NetClientState {
> diff --git a/net/net.c b/net/net.c
> index da275db86e..c0750fd0b9 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -57,6 +57,7 @@
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "standard-headers/linux/virtio_net.h"
> +#include "qemu/log.h"
>
>  /* Net bridge is currently not supported for W32. */
>  #if !defined(_WIN32)
> @@ -543,7 +544,8 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int le=
n)
>  void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>                            int ecn, int ufo, int uso4, int uso6)
>  {
> -    if (!nc || !nc->info->set_offload) {
> +    if (!nc || !nc->info->set_offload ||
> +        (nc->info->query_validity && nc->info->query_validity(nc) !=3D 1=
)) {
>          return;
>      }
>
> @@ -561,7 +563,8 @@ int qemu_get_vnet_hdr_len(NetClientState *nc)
>
>  void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
>  {
> -    if (!nc || !nc->info->set_vnet_hdr_len) {
> +    if (!nc || !nc->info->set_vnet_hdr_len ||
> +        (nc->info->query_validity && nc->info->query_validity(nc) !=3D 1=
)) {
>          return;
>      }
>
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index e832810665..2911c66149 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -346,3 +346,14 @@ int tap_fd_set_steering_ebpf(int fd, int prog_fd)
>
>      return 0;
>  }
> +
> +int tap_fd_query_validity(int fd)
> +{
> +    struct ifreq ifr;
> +
> +    if (ioctl(fd, TUNGETIFF, &ifr) !=3D 0) {
> +        error_report("The tap device fd: %d is NOT valid.", fd);
> +        return -1;
> +    }
> +    return 1;
> +}
> diff --git a/net/tap.c b/net/tap.c
> index f37133e301..a9af3c7279 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -364,6 +364,14 @@ static VHostNetState *tap_get_vhost_net(NetClientSta=
te *nc)
>      return s->vhost_net;
>  }
>
> +static int tap_query_validity(NetClientState *nc)
> +{
> +    TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP);
> +
> +    return tap_fd_query_validity(s->fd);
> +}
> +
>  /* fd support */
>
>  static NetClientInfo net_tap_info =3D {
> @@ -383,6 +391,7 @@ static NetClientInfo net_tap_info =3D {
>      .set_vnet_be =3D tap_set_vnet_be,
>      .set_steering_ebpf =3D tap_set_steering_ebpf,
>      .get_vhost_net =3D tap_get_vhost_net,
> +    .query_validity =3D tap_query_validity,
>  };
>
>  static TAPState *net_tap_fd_init(NetClientState *peer,
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 8857ff299d..5deb380201 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -46,5 +46,6 @@ int tap_fd_enable(int fd);
>  int tap_fd_disable(int fd);
>  int tap_fd_get_ifname(int fd, char *ifname);
>  int tap_fd_set_steering_ebpf(int fd, int prog_fd);
> +int tap_fd_query_validity(int fd);
>
>  #endif /* NET_TAP_INT_H */
> --
> 2.47.3
>


