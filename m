Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65769E6B25B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 21:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXnbW-0002oJ-LC; Mon, 22 Dec 2025 16:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.mtvfmtmo4aled96=cuhyz3fqj3o6=w8h3idnh6zfire@em483429.getutm.app>)
 id 1vXnbR-0002ny-GL
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 16:38:06 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.mtvfmtmo4aled96=cuhyz3fqj3o6=w8h3idnh6zfire@em483429.getutm.app>)
 id 1vXnbM-0002jB-Ja
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 16:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766440367; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=s715Sloxg5apxJMv/yMmu3jhN+jkQCYdiFvWRvLbr7k=; b=HZCEJCm7PF7bBT0JgJg6OIMFS7
 StUiHAD3EgqZq5XbMSGCcVNc6luTDaorBmxvJFpIdDkwF31KKBNjRhyV/niRAsgGZ1+XImV2qR8yS
 F6DnIpzzR0weobHW2ElQWDkQ4Q7NgA8BRuiuvbhPtaBwd7gx3mZLm7SL7QLvhTQ/judd4XfGCv6MU
 18r7HuD/dga56/ewUVT2GWZd43JA4Uy6TgGNJrowBUECznDjKc9L4bZa723Mo5jNh1JLbZMTPJ1ul
 bmTkr3XZrhCGzPxlMXcWYgHBEjdXfE+wrptNBn9Gfw4y6xZ29nYVDQuRimBZg9TpShb+o3ZWLaTLT
 lL4B0Tsg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766439467; h=from : subject :
 to : message-id : date;
 bh=s715Sloxg5apxJMv/yMmu3jhN+jkQCYdiFvWRvLbr7k=;
 b=Z/PGgjIeucpuiMY0orUJCjqUss+fdXucSCHUnaKhKub9ZEg3R1Z5idf/eM5QYWQJCbs1y
 JXpddJyT3uaKAhSBOFTJcwvU4ZzSNcdPso7YQRcoeYV3wrc2RdZ8zGr+4Aa9QuTo1IpnSLa
 liwhTprNc1XGQtA7ZomxQhpEtb5+p/sOFYi4A3ASuZ3805hwXdUmz8Aml5BNIbuLIdkkEfz
 Utpv1tRRS9gdtDHX7TZKlARVz8vpkdaIpyA89zGOLQcfYliUgrKlzmjhicqSuP4Lw8IauOl
 l+MOiCNXY34gh7cedMLSUGZ+uJDgp2ZcMXgq1dDXmhA9uRxNBJxvx0lJ3ztg==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vXnb7-pH9RoQ-HN
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 21:37:45 +0000
Received: from [10.159.238.187] (helo=mail-ej1-f42.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vXnb6-AIkwcC8q2LZ-52BJ for qemu-devel@nongnu.org;
 Mon, 22 Dec 2025 21:37:44 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso759172166b.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 13:37:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVuM4EfwzNNHlFOCSsuVQvYPu6+7qd60jAYeZpDWhymReWI6tEAeeZ1YJsCm3peFYFRp+uzN0bhqLge@nongnu.org
X-Gm-Message-State: AOJu0Yz/vPf4jzgAL/1Lys2kqJkTyrodEyAPzt6k1XyFrGu0ygwspBR5
 UFF1w0l6mQdvvRU48fv818CX8LKK1BmUmyvJYvE1y7vUFx9NtpFhqG84vnrO7VA9kCpPs15wf/A
 +kcDwEr67vyKNqBWlc84DjuZDY5U3ksY=
X-Google-Smtp-Source: AGHT+IEmsZiUfspOXAwGxVrv/6+3F7L6OE3kkpIeBlRKg7otXS6HryzrDgDgz3fPDYTfP0ZGY4Uz9KUqFTk9d+C0vyw=
X-Received: by 2002:a17:907:3d8c:b0:b73:7710:fe03 with SMTP id
 a640c23a62f3a-b803723a751mr1087740966b.58.1766439462028; Mon, 22 Dec 2025
 13:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20251222151259.3965-1-j@getutm.app>
 <CAJ+F1CJBjM+s0vgCj1T3tFib6SQOV-RJEcrEpCLv==K2UCRLpg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJBjM+s0vgCj1T3tFib6SQOV-RJEcrEpCLv==K2UCRLpg@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 22 Dec 2025 13:37:30 -0800
X-Gmail-Original-Message-ID: <CA+E+eSC_111XdFTETaxyBABrZgcyTw-coG2TcLYSR1jE=_0nMQ@mail.gmail.com>
X-Gm-Features: AQt7F2p9iftjgKxXvS1l93SW0QruW-QrcnDLYwFGFs7fqfWfJF7xr6iBz8b3pCs
Message-ID: <CA+E+eSC_111XdFTETaxyBABrZgcyTw-coG2TcLYSR1jE=_0nMQ@mail.gmail.com>
Subject: Re: [PATCH] virrtio-gpu-virgl: correct parent for blob memory region
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: hWast-k_BiyH.hDp1M3NRcl-x.7maAngZRTpt
Feedback-ID: 483429m:483429abrvJvs:483429sPp0UMDvUW
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.mtvfmtmo4aled96=cuhyz3fqj3o6=w8h3idnh6zfire@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 22, 2025 at 7:34=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Dec 22, 2025 at 7:15=E2=80=AFPM Joelle van Dyne <j@getutm.app> wr=
ote:
> >
> > When `owner` =3D=3D `mr`, `object_unparent` will crash:
> >
> > object_unparent(mr) ->
> > object_property_del_child(mr, mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > object_finalize(mr) ->
> > object_property_del_all(mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > fail on g_assert(obj->ref > 0)
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
>
> Fixes: commit 7c092f17 ("virtio-gpu: Handle resource blob commands")
>
> I'd suggest an assert for this case in memory_region_do_init(), as
> that seems undesired.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  hw/display/virtio-gpu-virgl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 18404be5892..4109ff7932a 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -123,7 +123,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> >      vmr->g =3D g;
> >
> >      mr =3D &vmr->mr;
> > -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> > +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
> >      memory_region_add_subregion(&b->hostmem, offset, mr);
> >      memory_region_set_enabled(mr, true);
> >
> > --
> > 2.50.1 (Apple Git-155)
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

So even though this fixed the crash I was seeing, I started getting a
new crash which I debugged with ASAN and found to be a use-after-free
of the virtio_gpu_virgl_hostmem_region. So there may be some bigger
underlying issue.

=3D=3D22482=3D=3DERROR: AddressSanitizer: heap-use-after-free on address
0x612000848eea at pc 0x000103072fbc bp 0x00016d5aad70 sp
0x00016d5aad68
READ of size 1 at 0x612000848eea thread T1
=3D=3D22482=3D=3DWARNING: Can't read from symbolizer at fd 211
=3D=3D22482=3D=3DWARNING: atos failed to symbolize address "0x103072fb8"
=3D=3D22482=3D=3DWARNING: Can't write to symbolizer at fd 211
=3D=3D22482=3D=3DWARNING: external symbolizer didn't start up correctly!
=3D=3D22482=3D=3DWARNING: Can't write to symbolizer at fd 212
=3D=3D22482=3D=3DWARNING: external symbolizer didn't start up correctly!
=3D=3D22482=3D=3DWARNING: Can't write to symbolizer at fd 213
=3D=3D22482=3D=3DWARNING: external symbolizer didn't start up correctly!
=3D=3D22482=3D=3DWARNING: Can't write to symbolizer at fd 215
=3D=3D22482=3D=3DWARNING: external symbolizer didn't start up correctly!
=3D=3D22482=3D=3DWARNING: Failed to use and restart external symbolizer!
    #0 0x000103072fb8 in address_space_dispatch_free+0x184
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x100796fb8)
    #1 0x00010304e45c in flatview_destroy+0x8c
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x10077245c)
    #2 0x000103e73adc in call_rcu_thread+0x218
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101597adc)
    #3 0x000103e5e608 in qemu_thread_start+0x168
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101582608)
    #4 0x000108bbe3f4 in asan_thread_start(void*)+0x4c
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x3a3f4)
    #5 0x000189f58c04 in _pthread_start+0x84
(/usr/lib/system/libsystem_pthread.dylib:arm64e+0x6c04)
    #6 0x000189f53ba4 in thread_start+0x4
(/usr/lib/system/libsystem_pthread.dylib:arm64e+0x1ba4)

0x612000848eea is located 42 bytes inside of 288-byte region
[0x612000848ec0,0x612000848fe0)
freed by thread T28 here:
    #0 0x000108bc1400 in free+0x7c
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x3d400)
    #1 0x00010325fefc in virtio_gpu_virgl_unmap_resource_blob+0x118
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x100983efc)
    #2 0x00010325b9c0 in virtio_gpu_virgl_process_cmd+0x21b0
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x10097f9c0)
    #3 0x0001032535ac in virtio_gpu_process_cmdq+0x184
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1009775ac)
    #4 0x000103e851c8 in aio_bh_poll+0x310
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1015a91c8)
    #5 0x000103e54cf0 in aio_dispatch+0xc8
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101578cf0)
    #6 0x000103e87410 in aio_ctx_dispatch+0xc
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1015ab410)
    #7 0x000107ef1574 in g_main_context_dispatch_unlocked+0xec
(/opt/homebrew/Cellar/glib/2.86.2/lib/libglib-2.0.0.dylib:arm64+0x31574)
    #8 0x000107ef1474 in g_main_context_dispatch+0x28
(/opt/homebrew/Cellar/glib/2.86.2/lib/libglib-2.0.0.dylib:arm64+0x31474)
    #9 0x000103e88198 in main_loop_wait+0x2b0
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1015ac198)
    #10 0x00010308d9c0 in qemu_main_loop+0xfc
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1007b19c0)
    #11 0x000103ce6254 in qemu_default_main+0x20
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x10140a254)
    #12 0x000103e5e608 in qemu_thread_start+0x168
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101582608)
    #13 0x000108bbe3f4 in asan_thread_start(void*)+0x4c
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x3a3f4)
    #14 0x000189f58c04 in _pthread_start+0x84
(/usr/lib/system/libsystem_pthread.dylib:arm64e+0x6c04)
    #15 0x000189f53ba4 in thread_start+0x4
(/usr/lib/system/libsystem_pthread.dylib:arm64e+0x1ba4)

previously allocated by thread T28 here:
    #0 0x000108bc15fc in calloc+0x80
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x3d5fc)
    #1 0x000107ef6cac in g_malloc0+0x20
(/opt/homebrew/Cellar/glib/2.86.2/lib/libglib-2.0.0.dylib:arm64+0x36cac)
    #2 0x00010325c1c0 in virtio_gpu_virgl_process_cmd+0x29b0
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1009801c0)
    #3 0x0001032535ac in virtio_gpu_process_cmdq+0x184
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1009775ac)
    #4 0x000103258e20 in virtio_gpu_gl_handle_ctrl+0x1f4
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x10097ce20)
    #5 0x000103e85120 in aio_bh_poll+0x268
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1015a9120)
    #6 0x000103e54cf0 in aio_dispatch+0xc8
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101578cf0)
    #7 0x000103e87410 in aio_ctx_dispatch+0xc
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1015ab410)
    #8 0x000107ef1574 in g_main_context_dispatch_unlocked+0xec
(/opt/homebrew/Cellar/glib/2.86.2/lib/libglib-2.0.0.dylib:arm64+0x31574)
    #9 0x000107ef1474 in g_main_context_dispatch+0x28
(/opt/homebrew/Cellar/glib/2.86.2/lib/libglib-2.0.0.dylib:arm64+0x31474)
    #10 0x000103e88198 in main_loop_wait+0x2b0
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1015ac198)
    #11 0x00010308d9c0 in qemu_main_loop+0xfc
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x1007b19c0)
    #12 0x000103ce6254 in qemu_default_main+0x20
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x10140a254)
    #13 0x000103e5e608 in qemu_thread_start+0x168
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101582608)
    #14 0x000108bbe3f4 in asan_thread_start(void*)+0x4c
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x3a3f4)
    #15 0x000189f58c04 in _pthread_start+0x84
(/usr/lib/system/libsystem_pthread.dylib:arm64e+0x6c04)
    #16 0x000189f53ba4 in thread_start+0x4
(/usr/lib/system/libsystem_pthread.dylib:arm64e+0x1ba4)

Thread T1 created by T0 here:
    #0 0x000108bb99d4 in pthread_create+0x5c
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x359d4)
    #1 0x000103e5e338 in qemu_thread_create+0x18c
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101582338)
    #2 0x000103e73550 in rcu_init+0x120
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101597550)
    #3 0x000189bb6cac in invocation function for block in
dyld4::Loader::findAndRunAllInitializers(dyld4::RuntimeState&)
const+0x1b8 (/usr/lib/dyld:arm64e+0x20cac)
    #4 0x000189bf472c in invocation function for block in
dyld3::MachOAnalyzer::forEachInitializer(Diagnostics&,
dyld3::MachOAnalyzer::VMAddrConverter const&, void (unsigned int)
block_pointer, void const*) const+0x140 (/usr/lib/dyld:arm64e+0x5e72c)
    #5 0x000189c1353c in invocation function for block in
mach_o::Header::forEachSection(void (mach_o::Header::SectionInfo
const&, bool&) block_pointer) const+0x134
(/usr/lib/dyld:arm64e+0x7d53c)
    #6 0x000189c10160 in mach_o::Header::forEachLoadCommand(void
(load_command const*, bool&) block_pointer) const+0xcc
(/usr/lib/dyld:arm64e+0x7a160)
    #7 0x000189c119f8 in mach_o::Header::forEachSection(void
(mach_o::Header::SectionInfo const&, bool&) block_pointer) const+0x78
(/usr/lib/dyld:arm64e+0x7b9f8)
    #8 0x000189bf421c in
dyld3::MachOAnalyzer::forEachInitializer(Diagnostics&,
dyld3::MachOAnalyzer::VMAddrConverter const&, void (unsigned int)
block_pointer, void const*) const+0x200 (/usr/lib/dyld:arm64e+0x5e21c)
    #9 0x000189bb6a64 in
dyld4::Loader::findAndRunAllInitializers(dyld4::RuntimeState&)
const+0xa8 (/usr/lib/dyld:arm64e+0x20a64)
    #10 0x000189bbe8ac in
dyld4::JustInTimeLoader::runInitializers(dyld4::RuntimeState&)
const+0x20 (/usr/lib/dyld:arm64e+0x288ac)
    #11 0x000189bb7210 in
dyld4::Loader::runInitializersBottomUp(dyld4::RuntimeState&,
dyld3::Array<dyld4::Loader const*>&, dyld3::Array<dyld4::Loader
const*>&) const+0x130 (/usr/lib/dyld:arm64e+0x21210)
    #12 0x000189bbbe4c in
dyld4::Loader::runInitializersBottomUpPlusUpwardLinks(dyld4::RuntimeState&)
const::$_0::operator()() const+0xb0 (/usr/lib/dyld:arm64e+0x25e4c)
    #13 0x000189bb752c in
dyld4::Loader::runInitializersBottomUpPlusUpwardLinks(dyld4::RuntimeState&)
const+0x2c8 (/usr/lib/dyld:arm64e+0x2152c)
    #14 0x000189bd9048 in
dyld4::APIs::runAllInitializersForMain()+0x18c
(/usr/lib/dyld:arm64e+0x43048)
    #15 0x000189b9b154 in dyld4::prepare(dyld4::APIs&, mach_o::Header
const*)+0xc24 (/usr/lib/dyld:arm64e+0x5154)
    #16 0x000189b99d00 in start+0x1bbc (/usr/lib/dyld:arm64e+0x3d00)

Thread T28 created by T0 here:
    #0 0x000108bb99d4 in pthread_create+0x5c
(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolc=
hain/usr/lib/clang/17/lib/darwin/libclang_rt.asan_osx_dynamic.dylib:arm64e+=
0x359d4)
    #1 0x000103e5e338 in qemu_thread_create+0x18c
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x101582338)
    #2 0x000103ce61a8 in main+0xf0
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x10140a1a8)
    #3 0x000189b99d50 in start+0x1c0c (/usr/lib/dyld:arm64e+0x3d50)

SUMMARY: AddressSanitizer: heap-use-after-free
(/Users/admin/Downloads/build/bin/qemu-system-aarch64:arm64+0x100796fb8)
in address_space_dispatch_free+0x184
Shadow bytes around the buggy address:
  0x612000848c00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x612000848c80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x612000848d00: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x612000848d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x612000848e00: 00 00 00 00 00 00 00 00 00 00 00 00 fa fa fa fa
=3D>0x612000848e80: fa fa fa fa fa fa fa fa fd fd fd fd fd[fd]fd fd
  0x612000848f00: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x612000848f80: fd fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa
  0x612000849000: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x612000849080: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x612000849100: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D22482=3D=3DABORTING

