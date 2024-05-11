Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A43C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 06:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5gTE-0001NE-V3; Sat, 11 May 2024 02:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5gTD-0001Mp-4w
 for qemu-devel@nongnu.org; Sat, 11 May 2024 02:44:35 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5gTB-0006rk-7P
 for qemu-devel@nongnu.org; Sat, 11 May 2024 02:44:34 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-792b8d989e8so201818485a.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715409872; x=1716014672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKMoLau30N0DQHgeGzAmpB4K7y7/g2L8FU85qlP7XXk=;
 b=Ec39jbbm/lKFire829gv+tMizTlVx6Slgclc8WSskRSEKsxuC7YutJ4AQt2YmtpY/a
 +3wOwoIQSulsM0SERuuGq5N/Cotq/y9scPJOM4QQil2++NBx3KvFUZOI/oYWALuvlWRu
 76/OTKY4lnnMTrqzo9OtfCzAe9+JEmqiwKThLmD7XdPSawj0/AqdRKoUyVq1FVpd0oI+
 5oCwjI+F2Jw3n0OxDvx0fEJ0wr125G2e1w4gSNprlgUsVquvJPzGt7w1x7xYFy4ywGH6
 0NGOu290rqzScgZtrPLQc7t8Tl0xL2Xp+8Tj8345TQ8elA81RuIgJKq09nriNtZw/TZw
 +FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715409872; x=1716014672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKMoLau30N0DQHgeGzAmpB4K7y7/g2L8FU85qlP7XXk=;
 b=W+Z854qQMzmXlEuMivp15GkJF01K8FIz+0jlBl59JEo/OE6/qTPh4EWeAuCgGVtuwR
 eDkYvokGrU/KPE5Hg8kwHYphqChK+UcoMOkx9Oe9GS1O0EwvmIGtL98BzUZ7+U/0INIe
 jOZZpXlFbVNLiwStIBT6fgrw1VhkwGZagGgepa+fnpKEYaXDcsx5kj6it59TUz2X1HbF
 w1gCmhB1hSpaZR0l3qirGN9DJjjxz9mVrl1Nf4gUT1fR1nM+JqaC571TxSpIGona7XDp
 O2ibyjiXHnZ24w1b5a21zWYXOQqz0lc3L40jQW3GshwUNIC4dl8+ZGXkHVySWF6qBLhO
 eklQ==
X-Gm-Message-State: AOJu0Yxfeyupu7Yt05IIEub1H3ks+keFUUGLCgzIsWM+2DaiWcOaB7e+
 8d98dHtuNCIi4Te1p1Q1ZeXWm8Xw3QLHGyK9QL0tYPkR72WUgHwn5e94zXEhiDUAw6j6+AGHb8B
 f/4KS3aqR66Vr6kLXx7uJS+E2lXA=
X-Google-Smtp-Source: AGHT+IFp2IwCRHkM2cRa1yG3uJUT/6kOE6A7GMS9yY1SbiRpU1E8bzqNvaG1IN/jKKLQKaKlg596FGJbxeNJ/JYMvr4=
X-Received: by 2002:a05:620a:4405:b0:790:ef27:ef4a with SMTP id
 af79cd13be357-792bbdc52bbmr1328801885a.6.1715409871871; Fri, 10 May 2024
 23:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-4-marcandre.lureau@redhat.com> <ZjqILU7qxlTGN4OD@x1n>
 <CAJ+F1CJjNnHoX=LvSsh5M_fiZg-n5K=KEgPRh+2gAjRij4Oq-w@mail.gmail.com>
 <Zj5adUCIINuv42ua@x1n>
In-Reply-To: <Zj5adUCIINuv42ua@x1n>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 11 May 2024 10:44:20 +0400
Message-ID: <CAJ+F1CJNQDEJn2dcWgC_yVECnCe8ps0VajMND_AhBWfpu_tGgA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout
 field
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Peter

On Fri, May 10, 2024 at 9:33=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Marc-Andr=C3=A9,
>
> On Fri, May 10, 2024 at 12:39:34PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Since we don't have per VMSD version information on the wire, nested
> > struct versioning is quite limited and cumbersome. I am not sure it
> > can be changed without breaking the stream format, and whether it's
> > worthwhile.
>
> Right that's a major pain, and actually I just notice it..
>
> I think it'll be much, much simpler if we keep vmsd version on the wire f=
or
> each VMSD (including struct fields), then it makes more sense to me.
>
> Then when I went back and see again the VSTRUCT thing...  I can hardly
> understand what it is doing, and also how it works at all.
>
> Look at the current only IPMI user, who has:
>
>         VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
>                           IPMIKCS, 2),
>
> It is setting both vmsd version and struct_version to 2.  I can't tell wh=
y
> it matters then if anyway both of the fields are the same..
>
> When we do save(), there is:
>
>                 } else if (field->flags & VMS_STRUCT) {
>                     ret =3D vmstate_save_state(f, field->vmsd, curr_elem,
>                                              vmdesc_loop);
>                 } else if (field->flags & VMS_VSTRUCT) {
>                     ret =3D vmstate_save_state_v(f, field->vmsd, curr_ele=
m,
>                                                vmdesc_loop,
>                                                field->struct_version_id, =
errp);
>
> When we load():
>
>                 } else if (field->flags & VMS_STRUCT) {
>                     ret =3D vmstate_load_state(f, field->vmsd, curr_elem,
>                                              field->vmsd->version_id);
>                 } else if (field->flags & VMS_VSTRUCT) {
>                     ret =3D vmstate_load_state(f, field->vmsd, curr_elem,
>                                              field->struct_version_id);
>                 } else {
>
> In this case, passing in struct_version=3D=3Dversion should have zero eff=
ect
> afaict, because the default behavior is passing in vmsd->version_id anywa=
y.

IPMI KCS being a top-level section, the fields with an unsupported
version are filtered before reaching this code.

But since I can't see how a machine will have a specific version, it
only helps for backward migration, which is quite limited.

>
> Moreover, now I highly doubt whether the VMS_STRUCT whole thing makes sen=
se
> at all as you mentioned.  Especially on the load side, here we should rel=
y
> on vmstate_load_state() taking the last parameter as version_id on the
> wire.  Here we're passing in the struct's version_id or struct_version_id=
,
> and neither of them makes sense to me... if we miss that version_id
> information, afaiu we should simply fix it and put it on the wire..  It'l=
l
> break migration, we may need to work that out, but I don't see a better
> way.  Keeping it like this like a nightmare to me.. :-(

Ack.

Do you think we should add a version on the wire for each VMSD? that
will likely be a format change.

>
> Irrelevant of all these mess.. For this specific problem, what I meant is
> exactly what Michael was requesting too (hopefully), I'd want to avoid
> further extending the complexity in this area.  I have a patch attached a=
t
> last which I also tested 8.2<->9.0 bi-directional migrations and it worke=
d
> for me when I smoked it.  Please have a look to see whether that makes
> sense and at the meantime avoid most of the tricks.

Works for me! thanks for figuring out how to get back the VirtioGPU* !

I'll send v2 with your patch.

>
> I'd also like to mention one more thing just in case this can cause some
> more attention to virtio guys..
>
> Normally I ran vmstate-static-checker.py before softfreeze, and I did it
> for 9.0 too without seeing this problem.  It isn't raised because all
> virtio devices are using the "self managed" VMSTATE_VIRTIO_DEVICE to
> migrate.  In that case I am out of luck.  We can further extend what
> Fabiano mentioned in the other thread to cover migration stream validatio=
ns
> in the future, but just to mention IMHO that needs extra work, and may wo=
rk
> most likely the same as vmstate static checker but just waste many more c=
pu
> resources.  It'll be good if someone could still help move virtio towards
> like most of the rest devices, or at least get covered by the static
> checker, too.  But that definitely is a separate topic too.. so we can
> address the immediate breakage first.
>
> Thanks,
>
> =3D=3D8<=3D=3D
> From a24ef99670fa7102da461d795aed4a957bad86b1 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 10 May 2024 12:33:34 -0400
> Subject: [PATCH] fix gpu
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h |  2 +-
>  hw/core/machine.c              |  1 +
>  hw/display/virtio-gpu.c        | 21 +++++++++++++++------
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index ed44cdad6b..e128501bdc 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -176,7 +176,7 @@ typedef struct VGPUDMABuf {
>
>  struct VirtIOGPU {
>      VirtIOGPUBase parent_obj;
> -
> +    uint8_t vmstate_version;
>      uint64_t conf_max_hostmem;
>
>      VirtQueue *ctrl_vq;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4ff60911e7..8f6f0dda7c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -42,6 +42,7 @@ GlobalProperty hw_compat_8_2[] =3D {
>      { "migration", "zero-page-detection", "legacy"},
>      { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
> +    { "virtio-gpu-device", "x-vmstate-version", "1" },
>  };
>  const size_t hw_compat_8_2_len =3D G_N_ELEMENTS(hw_compat_8_2);
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ae831b6b3e..c53f55404c 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1166,6 +1166,14 @@ static void virtio_gpu_cursor_bh(void *opaque)
>      virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
>  }
>
> +static bool vmstate_after_v2(void *opaque, int version)
> +{
> +    struct VirtIOGPUBase *base =3D container_of(opaque, VirtIOGPUBase, s=
canout);
> +    struct VirtIOGPU *gpu =3D container_of(base, VirtIOGPU, parent_obj);
> +
> +    return gpu->vmstate_version >=3D 2;
> +}
> +
>  static const VMStateDescription vmstate_virtio_gpu_scanout =3D {
>      .name =3D "virtio-gpu-one-scanout",
>      .version_id =3D 2,
> @@ -1181,12 +1189,12 @@ static const VMStateDescription vmstate_virtio_gp=
u_scanout =3D {
>          VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
> -        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
> +        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,vmstate=
_after_v2),
> +        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,vmsta=
te_after_v2),
> +        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,vmstate_=
after_v2),
> +        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,vmstate=
_after_v2),
> +        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout,vmstate=
_after_v2),
> +        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout,vmstate=
_after_v2),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -1659,6 +1667,7 @@ static Property virtio_gpu_properties[] =3D {
>      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 2=
),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.44.0
>
>
> --
> Peter Xu
>


--=20
Marc-Andr=C3=A9 Lureau

