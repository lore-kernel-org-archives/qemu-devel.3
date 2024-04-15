Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17527C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 05:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwFGj-0007MW-1a; Mon, 15 Apr 2024 01:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rwFGf-0007ML-9N
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 01:52:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rwFGc-00039H-Ck
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 01:52:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a526803fccso1471113a91.1
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713160231; x=1713765031;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfxUSihcXu32yKZ6s3bsbmoOeGjJGplv7TcBmvqacFU=;
 b=Uxne6qo4HLDzANs5KRCgohfpMCkDx6kAXHVPhHepjORMhLHdeKJ3CJoDmJ0Or7R+Rv
 y05Jmhh2HIMfe8V32RDM/4MooFouGbmnGZGxjE4z0d0eNygyGBaAnIBenTEIHe1wct5o
 n7JJUvvwXTkxJSNOfdWXljs+ZBQ5I3sd1B7hcoV2d3t1+YMRKTJJYwDqf8EHm7xkzwY2
 F6iuWodp8SyzmoZzleiyB6C1VfHUQQ56ciTmqnUlWKCZIPcWMAwCNYJCLy5Q5idQldQ6
 WCYdmy7tZyENgCfjORp7U90QaPHCnt0gOh8WOnxEOSI3lhSrGPHCTXOx4NZxbCH/j/pr
 YNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713160231; x=1713765031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfxUSihcXu32yKZ6s3bsbmoOeGjJGplv7TcBmvqacFU=;
 b=VcBy/MBPCO8Ge3CVFIdyr1KzGVnPr5LC63mrVSKVBd+FgV+LtyNgcn1lxbptmyLHqY
 iTibMG9umA3yZzmYTZ76G9WKUJSmdlSpr8PgieI6QPe4Qio8gYLxNiDoPasW1vyUuMV2
 cLUhs07A0LnSx/4eFUoayTAJ4gTlCtY29WL4s9pO1d+52uz/9Jj96GesR8+SJGUMrcYP
 x7b6sMXHzGgfMhkStxSRp5dX/c6C7UGwrFkRpLaX3JsjptBzY2MOY6rEuwJnED0p7D3y
 dxOmR+NajGq3ibqbfiJHyQL25nrJXq7ccC36O1WzVIPFbe8LPRTMYz4MFjWSSIVsZCYW
 j+IA==
X-Gm-Message-State: AOJu0YxOE6mpH5xEsuENjBst2bzBXODHWC1lhbCtBfwouN4w0i254uTv
 71pFN76dv85lihIhMPuyCPy1XSU9AuK/mxeoVRJCGmAT4MYFuHCB4JxFBQcd2VaWOV8YNAzgrbb
 aCfk07QZcaJy3ABVJcMk7uKilfV9YQpug6dgVtkgL58DMHM99o40sSmpC
X-Google-Smtp-Source: AGHT+IEjsQPgrQsT4KOT5amTnvneGXAxRaLWDbQnPnJrDRQeB/+aRQ9rawpx9FaY1Leams/YZRR3UkdkNCLIfw96UHY=
X-Received: by 2002:a17:90b:4b8e:b0:2a2:6a2d:994f with SMTP id
 lr14-20020a17090b4b8e00b002a26a2d994fmr7909419pjb.8.1713160230518; Sun, 14
 Apr 2024 22:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1712577715.git.yong.huang@smartx.com>
 <2abb4613ef6834de76f1167ffb11c732cc826d2b.1712577715.git.yong.huang@smartx.com>
In-Reply-To: <2abb4613ef6834de76f1167ffb11c732cc826d2b.1712577715.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 15 Apr 2024 13:50:14 +0800
Message-ID: <CAK9dgmbOBuFNVg0WiaHK_+y87aXgXPjQKvjGYgQ1PJ2=vgw0cg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] scsi-disk: Fix crash of VMs configured with
 the CDROM device
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000fbdfd506161c3267"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000fbdfd506161c3267
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Mon, Apr 8, 2024 at 8:08=E2=80=AFPM Hyman Huang <yong.huang@smartx.com> =
wrote:

> When configuring VMs with the CDROM device using the USB bus
> in Libvirt, do as follows:
>
> <disk type=3D'file' device=3D'cdrom'>
>   <driver name=3D'qemu' type=3D'raw'/>
>   <source file=3D'/path/to/share_fs/cdrom.iso'/>
>   <target dev=3D'sda' bus=3D'usb'/>
>   <readonly/>
>   <address type=3D'usb' bus=3D'0' port=3D'2'/>
> </disk>
> <controller type=3D'usb' index=3D'0' model=3D'piix3-uhci'/>
>
> The destination Qemu process crashed, causing the VM migration
> to fail; the backtrace reveals the following:
>
> Program terminated with signal SIGSEGV, Segmentation fault.
> 0  __memmove_sse2_unaligned_erms () at
> ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
> 312        movq    -8(%rsi,%rdx), %rcx
> [Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]
> (gdb) bt
> 0  __memmove_sse2_unaligned_erms () at
> ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
> 1  memcpy (__len=3D8, __src=3D<optimized out>, __dest=3D<optimized out>) =
at
> /usr/include/bits/string_fortified.h:34
> 2  iov_from_buf_full (iov=3D<optimized out>, iov_cnt=3D<optimized out>,
> offset=3D<optimized out>, buf=3D0x0, bytes=3Dbytes@entry=3D8) at ../util/=
iov.c:33
> 3  iov_from_buf (bytes=3D8, buf=3D<optimized out>, offset=3D<optimized ou=
t>,
> iov_cnt=3D<optimized out>, iov=3D<optimized out>)
>    at
> /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/io=
v.h:49
> 4  usb_packet_copy (p=3Dp@entry=3D0x56066b2fb5a0, ptr=3D<optimized out>,
> bytes=3Dbytes@entry=3D8) at ../hw/usb/core.c:636
> 5  usb_msd_copy_data (s=3Ds@entry=3D0x56066c62c770, p=3Dp@entry=3D0x56066=
b2fb5a0)
> at ../hw/usb/dev-storage.c:186
> 6  usb_msd_handle_data (dev=3D0x56066c62c770, p=3D0x56066b2fb5a0) at
> ../hw/usb/dev-storage.c:496
> 7  usb_handle_packet (dev=3D0x56066c62c770, p=3Dp@entry=3D0x56066b2fb5a0)=
 at
> ../hw/usb/core.c:455
> 8  uhci_handle_td (s=3Ds@entry=3D0x56066bd5f210, q=3D0x56066bb7fbd0, q@en=
try=3D0x0,
> qh_addr=3Dqh_addr@entry=3D902518530, td=3Dtd@entry=3D0x7fffe6e788f0,
> td_addr=3D<optimized out>,
>    int_mask=3Dint_mask@entry=3D0x7fffe6e788e4) at ../hw/usb/hcd-uhci.c:88=
5
> 9  uhci_process_frame (s=3Ds@entry=3D0x56066bd5f210) at
> ../hw/usb/hcd-uhci.c:1061
> 10 uhci_frame_timer (opaque=3Dopaque@entry=3D0x56066bd5f210) at
> ../hw/usb/hcd-uhci.c:1159
> 11 timerlist_run_timers (timer_list=3D0x56066af26bd0) at
> ../util/qemu-timer.c:642
> 12 qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL) at
> ../util/qemu-timer.c:656
> 13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738
> 14 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at
> ../util/main-loop.c:542
> 15 qemu_main_loop () at ../softmmu/runstate.c:739
> 16 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimize=
d out>)
> at ../softmmu/main.c:52
> (gdb) frame 5
> (gdb) p ((SCSIDiskReq *)s->req)->iov
> $1 =3D {iov_base =3D 0x0, iov_len =3D 0}
> (gdb) p/x s->req->tag
> $2 =3D 0x472
>
> The scsi commands that the CDROM issued are wrapped as the
> payload of the USB protocol in Qemu's implementation of a
> USB mass storage device, which is used to implement a
> CDROM device that uses a USB bus.
>
> In general, the USB controller processes SCSI commands in
> two phases. Sending the OUT USB package that encapsulates
> the SCSI command is the first stage; scsi-disk would handle
> this by emulating the SCSI operation. Receiving the IN USB
> package containing the SCSI operation's output is the second
> stage. Additionally, the SCSI request tag tracks the request
> during the procedure.
>
> Since QEMU did not migrate the flying SCSI request, the
> output of the SCSI may be lost if the live migration is
> initiated between the two previously mentioned steps.
>
> In our scenario, the SCSI command is GET_EVENT_STATUS_NOTIFICATION,
> the QEMU log information below demonstrates how the SCSI command
> is being handled (first step) on the source:
>
> usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state
> undef -> setup
> usb_msd_cmd_submit lun 0, tag 0x472, flags 0x00000080, len 10, data-len 8
>
> After migration, the VM crashed as soon as the destination's UHCI
> controller began processing the remaining portion of the SCSI
> request (second step)! Here is how the QEMU logged out:
>
> usb_packet_state_change bus 0, port 2, ep 1, packet 0x56066b2fb5a0, state
> undef -> setup
> usb_msd_data_in 8/8 (scsi 8)
> shutting down, reason=3Dcrashed
>
> To summarize, the missing scsi request during a live migration
> may cause a VM configured with a CDROM to crash.
>
> Migrating the SCSI request that the scsi-disk is handling is
> the simple approach, assuming that it actually exists.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 0985676f73..d6e9d9e8d4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -160,6 +160,16 @@ static void scsi_disk_save_request(QEMUFile *f,
> SCSIRequest *req)
>      }
>  }
>
> +static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req=
)
> +{
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    if (s->migrate_emulate_scsi_request) {
> +        scsi_disk_save_request(f, req);
> +    }
> +}
> +
>  static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
>  {
>      SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> @@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f,
> SCSIRequest *req)
>      qemu_iovec_init_external(&r->qiov, &r->iov, 1);
>  }
>
> +static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req=
)
> +{
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    if (s->migrate_emulate_scsi_request) {
> +        scsi_disk_load_request(f, req);
> +    }
> +}
> +
>  /*
>   * scsi_handle_rw_error has two return values.  False means that the err=
or
>   * must be ignored, true means that the error has been processed and the
> @@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops =
=3D {
>      .read_data    =3D scsi_disk_emulate_read_data,
>      .write_data   =3D scsi_disk_emulate_write_data,
>      .get_buf      =3D scsi_get_buf,
> +    .load_request =3D scsi_disk_emulate_load_request,
> +    .save_request =3D scsi_disk_emulate_save_request,
>  };
>

I would like to know why load_request and save_request hooks were not
initially
present in the scsi_disk_emulate_reqops. Are there any historical
considerations?


>  static const SCSIReqOps scsi_disk_dma_reqops =3D {
> @@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] =3D {
>  static int scsi_disk_pre_save(void *opaque)
>  {
>      SCSIDiskState *dev =3D opaque;
> -    dev->migrate_emulate_scsi_request =3D false;
> +    dev->migrate_emulate_scsi_request =3D true;
>
>      return 0;
>  }
> --
> 2.39.3
>
>
Thanks,
Yong

--=20
Best regards

--000000000000fbdfd506161c3267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Ping</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 8, 202=
4 at 8:08=E2=80=AFPM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m">yong.huang@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">When conf=
iguring VMs with the CDROM device using the USB bus<br>
in Libvirt, do as follows:<br>
<br>
&lt;disk type=3D&#39;file&#39; device=3D&#39;cdrom&#39;&gt;<br>
=C2=A0 &lt;driver name=3D&#39;qemu&#39; type=3D&#39;raw&#39;/&gt;<br>
=C2=A0 &lt;source file=3D&#39;/path/to/share_fs/cdrom.iso&#39;/&gt;<br>
=C2=A0 &lt;target dev=3D&#39;sda&#39; bus=3D&#39;usb&#39;/&gt;<br>
=C2=A0 &lt;readonly/&gt;<br>
=C2=A0 &lt;address type=3D&#39;usb&#39; bus=3D&#39;0&#39; port=3D&#39;2&#39=
;/&gt;<br>
&lt;/disk&gt;<br>
&lt;controller type=3D&#39;usb&#39; index=3D&#39;0&#39; model=3D&#39;piix3-=
uhci&#39;/&gt;<br>
<br>
The destination Qemu process crashed, causing the VM migration<br>
to fail; the backtrace reveals the following:<br>
<br>
Program terminated with signal SIGSEGV, Segmentation fault.<br>
0=C2=A0 __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/mem=
move-vec-unaligned-erms.S:312<br>
312=C2=A0 =C2=A0 =C2=A0 =C2=A0 movq=C2=A0 =C2=A0 -8(%rsi,%rdx), %rcx<br>
[Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]<br>
(gdb) bt<br>
0=C2=A0 __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/mem=
move-vec-unaligned-erms.S:312<br>
1=C2=A0 memcpy (__len=3D8, __src=3D&lt;optimized out&gt;, __dest=3D&lt;opti=
mized out&gt;) at /usr/include/bits/string_fortified.h:34<br>
2=C2=A0 iov_from_buf_full (iov=3D&lt;optimized out&gt;, iov_cnt=3D&lt;optim=
ized out&gt;, offset=3D&lt;optimized out&gt;, buf=3D0x0, bytes=3Dbytes@entr=
y=3D8) at ../util/iov.c:33<br>
3=C2=A0 iov_from_buf (bytes=3D8, buf=3D&lt;optimized out&gt;, offset=3D&lt;=
optimized out&gt;, iov_cnt=3D&lt;optimized out&gt;, iov=3D&lt;optimized out=
&gt;)<br>
=C2=A0 =C2=A0at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/i=
nclude/qemu/iov.h:49<br>
4=C2=A0 usb_packet_copy (p=3Dp@entry=3D0x56066b2fb5a0, ptr=3D&lt;optimized =
out&gt;, bytes=3Dbytes@entry=3D8) at ../hw/usb/core.c:636<br>
5=C2=A0 usb_msd_copy_data (s=3Ds@entry=3D0x56066c62c770, p=3Dp@entry=3D0x56=
066b2fb5a0) at ../hw/usb/dev-storage.c:186<br>
6=C2=A0 usb_msd_handle_data (dev=3D0x56066c62c770, p=3D0x56066b2fb5a0) at .=
./hw/usb/dev-storage.c:496<br>
7=C2=A0 usb_handle_packet (dev=3D0x56066c62c770, p=3Dp@entry=3D0x56066b2fb5=
a0) at ../hw/usb/core.c:455<br>
8=C2=A0 uhci_handle_td (s=3Ds@entry=3D0x56066bd5f210, q=3D0x56066bb7fbd0, q=
@entry=3D0x0, qh_addr=3Dqh_addr@entry=3D902518530, td=3Dtd@entry=3D0x7fffe6=
e788f0, td_addr=3D&lt;optimized out&gt;,<br>
=C2=A0 =C2=A0int_mask=3Dint_mask@entry=3D0x7fffe6e788e4) at ../hw/usb/hcd-u=
hci.c:885<br>
9=C2=A0 uhci_process_frame (s=3Ds@entry=3D0x56066bd5f210) at ../hw/usb/hcd-=
uhci.c:1061<br>
10 uhci_frame_timer (opaque=3Dopaque@entry=3D0x56066bd5f210) at ../hw/usb/h=
cd-uhci.c:1159<br>
11 timerlist_run_timers (timer_list=3D0x56066af26bd0) at ../util/qemu-timer=
.c:642<br>
12 qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL) at ../util/qemu-timer.=
c:656<br>
13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738<br>
14 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at ../util/main-loo=
p.c:542<br>
15 qemu_main_loop () at ../softmmu/runstate.c:739<br>
16 main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;, envp=
=3D&lt;optimized out&gt;) at ../softmmu/main.c:52<br>
(gdb) frame 5<br>
(gdb) p ((SCSIDiskReq *)s-&gt;req)-&gt;iov<br>
$1 =3D {iov_base =3D 0x0, iov_len =3D 0}<br>
(gdb) p/x s-&gt;req-&gt;tag<br>
$2 =3D 0x472<br>
<br>
The scsi commands that the CDROM issued are wrapped as the<br>
payload of the USB protocol in Qemu&#39;s implementation of a<br>
USB mass storage device, which is used to implement a<br>
CDROM device that uses a USB bus.<br>
<br>
In general, the USB controller processes SCSI commands in<br>
two phases. Sending the OUT USB package that encapsulates<br>
the SCSI command is the first stage; scsi-disk would handle<br>
this by emulating the SCSI operation. Receiving the IN USB<br>
package containing the SCSI operation&#39;s output is the second<br>
stage. Additionally, the SCSI request tag tracks the request<br>
during the procedure.<br>
<br>
Since QEMU did not migrate the flying SCSI request, the<br>
output of the SCSI may be lost if the live migration is<br>
initiated between the two previously mentioned steps.<br>
<br>
In our scenario, the SCSI command is GET_EVENT_STATUS_NOTIFICATION,<br>
the QEMU log information below demonstrates how the SCSI command<br>
is being handled (first step) on the source:<br>
<br>
usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state u=
ndef -&gt; setup<br>
usb_msd_cmd_submit lun 0, tag 0x472, flags 0x00000080, len 10, data-len 8<b=
r>
<br>
After migration, the VM crashed as soon as the destination&#39;s UHCI<br>
controller began processing the remaining portion of the SCSI<br>
request (second step)! Here is how the QEMU logged out:<br>
<br>
usb_packet_state_change bus 0, port 2, ep 1, packet 0x56066b2fb5a0, state u=
ndef -&gt; setup<br>
usb_msd_data_in 8/8 (scsi 8)<br>
shutting down, reason=3Dcrashed<br>
<br>
To summarize, the missing scsi request during a live migration<br>
may cause a VM configured with a CDROM to crash.<br>
<br>
Migrating the SCSI request that the scsi-disk is handling is<br>
the simple approach, assuming that it actually exists.<br>
<br>
Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
---<br>
=C2=A0hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-<br>
=C2=A01 file changed, 23 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c<br>
index 0985676f73..d6e9d9e8d4 100644<br>
--- a/hw/scsi/scsi-disk.c<br>
+++ b/hw/scsi/scsi-disk.c<br>
@@ -160,6 +160,16 @@ static void scsi_disk_save_request(QEMUFile *f, SCSIRe=
quest *req)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req)<=
br>
+{<br>
+=C2=A0 =C2=A0 SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);<br>
+=C2=A0 =C2=A0 SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r-&gt;<a=
 href=3D"http://req.dev" rel=3D"noreferrer" target=3D"_blank">req.dev</a>);=
<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;migrate_emulate_scsi_request) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_disk_save_request(f, req);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);<br=
>
@@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRe=
quest *req)<br>
=C2=A0 =C2=A0 =C2=A0qemu_iovec_init_external(&amp;r-&gt;qiov, &amp;r-&gt;io=
v, 1);<br>
=C2=A0}<br>
<br>
+static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req)<=
br>
+{<br>
+=C2=A0 =C2=A0 SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);<br>
+=C2=A0 =C2=A0 SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r-&gt;<a=
 href=3D"http://req.dev" rel=3D"noreferrer" target=3D"_blank">req.dev</a>);=
<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;migrate_emulate_scsi_request) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_disk_load_request(f, req);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * scsi_handle_rw_error has two return values.=C2=A0 False means that=
 the error<br>
=C2=A0 * must be ignored, true means that the error has been processed and =
the<br>
@@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0.read_data=C2=A0 =C2=A0 =3D scsi_disk_emulate_read_data=
,<br>
=C2=A0 =C2=A0 =C2=A0.write_data=C2=A0 =C2=A0=3D scsi_disk_emulate_write_dat=
a,<br>
=C2=A0 =C2=A0 =C2=A0.get_buf=C2=A0 =C2=A0 =C2=A0 =3D scsi_get_buf,<br>
+=C2=A0 =C2=A0 .load_request =3D scsi_disk_emulate_load_request,<br>
+=C2=A0 =C2=A0 .save_request =3D scsi_disk_emulate_save_request,<br>
=C2=A0};<br></blockquote><div><br></div><div><font face=3D"comic sans ms, s=
ans-serif">I would like to know why load_request and save_request hooks wer=
e not initially</font></div><div><font face=3D"comic sans ms, sans-serif">p=
resent in the=C2=A0scsi_disk_emulate_reqops.=C2=A0Are there any historical =
considerations?<span class=3D"gmail_default">=C2=A0</span></font></div><div=
><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><span cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif"><br></span></span></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-=
left-color:rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0static const SCSIReqOps scsi_disk_dma_reqops =3D {<br>
@@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] =3D {<br>
=C2=A0static int scsi_disk_pre_save(void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SCSIDiskState *dev =3D opaque;<br>
-=C2=A0 =C2=A0 dev-&gt;migrate_emulate_scsi_request =3D false;<br>
+=C2=A0 =C2=A0 dev-&gt;migrate_emulate_scsi_request =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yo=
ng</div><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"=
comic sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000fbdfd506161c3267--

