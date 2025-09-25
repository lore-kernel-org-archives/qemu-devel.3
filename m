Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDACCAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aMv-0005Gd-SJ; Wed, 24 Sep 2025 21:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1v1aMs-0005Er-9u
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1v1aMo-0005cv-Jp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758762102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLY89DtrfCdXEe29H9/XCvktzJ7WyhLNzqKWDTN54Jw=;
 b=D9RE5UBl/Rk59eOtrZZUOiRKlCvCxtEapMiH7I3anEhdRNGHNbE+hCCc7cf8llm40I4nlg
 5W6gVXKS1EI2uFYYiEe1pXe6GKsi9XBswpfNWM69+Vmq0fDNIzuwVtViNDGrEwyvGCSVW2
 efuX3r3y2/Qar+vsT4kXBaZg4dr+d0c=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-iJ8aynbePb-INHBgipI1ZA-1; Wed, 24 Sep 2025 21:01:40 -0400
X-MC-Unique: iJ8aynbePb-INHBgipI1ZA-1
X-Mimecast-MFC-AGG-ID: iJ8aynbePb-INHBgipI1ZA_1758762100
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-59e1b6766c9so688563137.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758762100; x=1759366900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLY89DtrfCdXEe29H9/XCvktzJ7WyhLNzqKWDTN54Jw=;
 b=HHhoA45nrrnblL7XfpWLPxFCIdxztnFcrho8zlZhZ2CKygM1SQRKyPP4gT6ZS3bCK/
 pts2kK6LSL6envZrYEgyesGEObmHhlSwhB/AJbi1pUQth3E4jL/g3KAZbaov0blBFpvC
 NPx831skdula/EmmZVvFdkprUwLSM47XdcaIVCx6MtpT7LxOpZHZc7uj09mQVKYj2Cgl
 FhAjNYD8mm2ChKIstWUpbcWRuPF9ngtTHIzKSAkkHkwZZZw3kN2jmc3TwandBDrrNohL
 m1/5Jpb8OCd8sheBrQ010sTEl8VCFj4J9XBXrDRX5inZD9NfM1V0zD4T7E8ptbiFkuwg
 t8Lw==
X-Gm-Message-State: AOJu0Yx7CZRJrBj+GRIkrWQ3bDNHBc3SINGtxYp0EVqTse2z7fVDB966
 CGOwbnUfwOO67ELCwqUpUxrlaONfcu06dsoaQAsXe+4a5nzKWHLXbOIfQbr4OTZjyZBaktoDgtM
 o/2JA1nBncrtH+aLqIXzKfxgL7zrpzAgxqCyM47twJAltNUgM+jU4ZsfRVJTk3iyq94KsSZWptD
 iZXnnaLPdAeqMp4/HoCcA/CGkj4Ro02dM=
X-Gm-Gg: ASbGncuNviXv51zKKYp9jxqWTOUYtso4y7LfFFkPXR+7D8pAE4uZ0wc2SGWbdnzymwr
 tgKQYWiOMUG4dhMuhBxSxhjbeC/7dQS4PPZYtOwTAs4G5f7Qq0MWjCwlqBRLNLcF+VpW3TY9xe/
 GqUkgZ+/ifrM6AFRK4cSpFrA==
X-Received: by 2002:a05:6102:c4a:b0:522:1013:cace with SMTP id
 ada2fe7eead31-5accd2160c3mr971472137.10.1758762099778; 
 Wed, 24 Sep 2025 18:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYu9HHrZ/WMW7K06E/I24TIRS5dTAADEZBpxBNW6Q6cM0iqhQKNwnCnjVJ0Z5kt66tpgMAqmtkWrqf6fj9aiw=
X-Received: by 2002:a05:6102:c4a:b0:522:1013:cace with SMTP id
 ada2fe7eead31-5accd2160c3mr971468137.10.1758762099404; Wed, 24 Sep 2025
 18:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250924062831.1788305-1-hzuo@redhat.com>
 <20250924085056.1833233-1-hzuo@redhat.com>
In-Reply-To: <20250924085056.1833233-1-hzuo@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 25 Sep 2025 09:01:02 +0800
X-Gm-Features: AS18NWAulQs3PCix7peWumBwPvGM7acTWqh7opiHRz_4NHqiXc-B3xY45KxFMM0
Message-ID: <CACLfguWuO1yTgv-zC9UbiK8-h=8YzEfzDi5JXxVP3Zzr18U5Aw@mail.gmail.com>
Subject: Re: [PATCH v3] net/tap-linux.c: avoid abort when setting invalid fd
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Sep 24, 2025 at 4:51=E2=80=AFPM Houqi (Nick) Zuo <hzuo@redhat.com> =
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
> Fixes: 0caed25cd171c611781589b5402161d27d57229c virtio: Call set_features=
 during reset
>
i think the format of fix should be
 =E2=80=9CFixes: <at-least-12-digits-of-SHA-commit-id> (=E2=80=9CFixed comm=
it subject=E2=80=9D)=E2=80=9D

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


