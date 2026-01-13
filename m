Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52166D2D108
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vff9s-0003RG-9T; Tue, 13 Jan 2026 09:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vff9Q-0003LX-LU
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:13:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vff9O-0003dA-8g
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:13:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso35324415e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768313616; x=1768918416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d196f0IcivdjkJwnwX2Zz8fySTnr9Q0ln8VC4wBlmo=;
 b=RZvbGxKF9lxW0UUAkHxrFjqm+Ddmg9vw6p1g5Y8UVW4WQtyq2HxPGGBJWWMrpmHw3g
 XQRiLk12Q3WjJrgyy0KdQhlJuYytW+Ir6oUWv1NoO8nGBcFitUNedfNHFdnXWkz1QjOH
 PWPbkU8s4MPDt4v5/BH31CQviQln5BST1kxaxroKWvM/+6BcyuxZ6NA1mRpXIZVTwMjo
 MGY91kLjZkv+2Ys3Kq2xLsLLOIJKQORETUnA683d5X9FG5ae061LIXaelYka5PE+/Zts
 NxzCgeWCy1V1emKRlABtYgn07vNBNpRc/Kom8I17BvGaprIC3wjv0PLnEHBmQZ1z016N
 y2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768313616; x=1768918416;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9d196f0IcivdjkJwnwX2Zz8fySTnr9Q0ln8VC4wBlmo=;
 b=v0GrxlMlp5gSlVjNwGgs6KnqVc2HQ++9mVmxM38rSXk0nmnIzF9nZQozcqLkPr3VO6
 l7QXDxqly7pkVVr2DXX3mZa4aLbmD+/+cpnCh80XYSPSXxN0WiAGLGM3ZaIPN3TawJSa
 jM05YyZ3HPC/iTcDaJUMZNtv/LunaOfH3wWazac344l3Gp8rw0tUMt8V95AAzWA7kwr7
 px/EsXeP41FhwLxaCdUCi48vfuI3qMjD3+ZcS3FByNd/mLsMvXy4Y2eO8kh3WEgPqANj
 o58pHTElraauO1BL7/kiRmQaTIf9oCwI87jt6Z0LjFFdpnd668Sa2Ynk47Z5DdZURoG2
 sV9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbmc1wxz+4HJzlgqxv/2cPv8fQ5Ox+qC12tnhdqQiONr02B/SPIjEag8CnV0zJxEzo5w7cF2r+Tj6U@nongnu.org
X-Gm-Message-State: AOJu0YwoUjDQd65Z8Q3jKtpHQKJkk6EizlkpUb9HxJF1LM62ZNzfHTbs
 t83NluRDj4E6AaZLdoJTeCMlRWokrOEF18HA+0r4E805yTFRxv7BUZ+MyoKz9w==
X-Gm-Gg: AY/fxX7mrc3RTOTioW/ljpZYNr6oOUZcn/Q7sP5TS6z3biHC01C51qx7F00bLYTGSNo
 Fet98UscFVJHWoocw6EudPV34Qbg44qK+gwYuX+abY8kWNXrl38Fg+nIdTw9rpk1SMwLB3ZfuvC
 rR2ux0t+JvIFtheY5n1yaIsDbBXNBbP8scJS2sJloZ78tpe104PD8XPIaiv7qJWQB86w8RFoKCj
 pk9P8dE6TPDXWZi+V+iUfB2zqoAVnTo5SSVekehMsALoSRcNc6pFDgLcbhQFCgZ3uRQnTnMc5Nh
 QLJHmg9aQrzcMiRYpst2EpxAHo0wV24eAZegVx+rKywr7nzZd/QfEsmmXjeWvxjzYi/nhmA5gVY
 ixSw625WPQp9iYyrpez9vfVQVoi52fms6p8O8XGSSgl66sPnPEo99NF7KLL4gMcwc601gyOcfbL
 4X/FzhKppKzfKOJ7/73aizz2eO4tHrM8utPKhtcUMXqtRjLXrcHbHZLyU0eB3g73vroxaeb3an
X-Received: by 2002:a05:6000:2dc9:b0:431:f5:c36f with SMTP id
 ffacd0b85a97d-43423ee5857mr3983271f8f.31.1768313616152; 
 Tue, 13 Jan 2026 06:13:36 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-002-242-220-137.2.242.pool.telefonica.de. [2.242.220.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm45635017f8f.19.2026.01.13.06.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 06:13:35 -0800 (PST)
Date: Tue, 13 Jan 2026 14:13:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Ani Sinha <anisinha@redhat.com>
CC: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_27/32=5D_ppc/openpic=3A_create_a_new_op?=
 =?US-ASCII?Q?enpic_device_and_reattach_mem_region_on_coco_reset?=
In-Reply-To: <20260112132259.76855-28-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-28-anisinha@redhat.com>
Message-ID: <66789715-28AC-4C18-A86D-2A5CE40073E7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 12=2E Januar 2026 13:22:40 UTC schrieb Ani Sinha <anisinha@redhat=2Ecom=
>:
>For confidential guests during the reset process, the old KVM VM file
>descriptor is closed and a new one is created=2E When a new file descript=
or is
>created, a new openpic device needs to be created against this new KVM VM=
 file
>descriptor as well=2E Additionally, existing memory region needs to be re=
attached
>to this new openpic device and proper CPU attributes set associating new =
file
>descriptor=2E This change makes this happen with the help of a callback h=
andler
>that gets called when the KVM VM file descriptor changes as a part of the
>confidential guest reset process=2E
>
>Signed-off-by: Ani Sinha <anisinha@redhat=2Ecom>
>---
> hw/intc/openpic_kvm=2Ec | 108 ++++++++++++++++++++++++++++++++----------
> 1 file changed, 83 insertions(+), 25 deletions(-)
>
>diff --git a/hw/intc/openpic_kvm=2Ec b/hw/intc/openpic_kvm=2Ec
>index 9aafef5d9e=2E=2E4fd70d4b32 100644
>--- a/hw/intc/openpic_kvm=2Ec
>+++ b/hw/intc/openpic_kvm=2Ec
>@@ -49,6 +49,7 @@ struct KVMOpenPICState {
>     uint32_t fd;
>     uint32_t model;
>     hwaddr mapped;
>+    NotifierWithReturn open_pic_vmfd_change_notifier;

I'd drop the "open_pic_" prefix here since the attribute resides inside a =
struct where the context is clear=2E

> };
>=20
> static void kvm_openpic_set_irq(void *opaque, int n_IRQ, int level)
>@@ -114,6 +115,83 @@ static const MemoryRegionOps kvm_openpic_mem_ops =3D=
 {
>     },
> };
>=20
>+static int create_open_pic_device(KVMOpenPICState *opp, Error **errp)

Here in turn I'd stick to existing conventions and use an "kvm_openpic_" p=
refix=2E What about naming this function kvm_openpic_setup_vmfd() (or rever=
sed: kvm_openpic_vmfd_setup())?

>+{
>+    int kvm_openpic_model;
>+    struct kvm_create_device cd =3D {0};
>+    KVMState *s =3D kvm_state;
>+    int ret;
>+
>+    switch (opp->model) {
>+    case OPENPIC_MODEL_FSL_MPIC_20:
>+        kvm_openpic_model =3D KVM_DEV_TYPE_FSL_MPIC_20;
>+        break;
>+
>+    case OPENPIC_MODEL_FSL_MPIC_42:
>+        kvm_openpic_model =3D KVM_DEV_TYPE_FSL_MPIC_42;
>+        break;
>+
>+    default:
>+        error_setg(errp, "Unsupported OpenPIC model %" PRIu32, opp->mode=
l);
>+        return -1;
>+    }
>+
>+    cd=2Etype =3D kvm_openpic_model;
>+    ret =3D kvm_vm_ioctl(s, KVM_CREATE_DEVICE, &cd);
>+    if (ret < 0) {
>+        error_setg(errp, "Can't create device %d: %s",
>+                   cd=2Etype, strerror(errno));
>+        return -1;
>+    }
>+    opp->fd =3D cd=2Efd;
>+
>+    return 0;
>+}
>+
>+static int open_pic_vmfd_handle_vmfd_change(NotifierWithReturn *notifier=
,
>+                                            void *data, Error **errp)

kvm_openpic_handle_vmfd_change() or similar?

>+{
>+    KVMOpenPICState *opp =3D container_of(notifier, KVMOpenPICState,
>+                                        open_pic_vmfd_change_notifier);
>+    uint64_t reg_base;
>+    struct kvm_device_attr attr;
>+    CPUState *cs;
>+    int ret;
>+
>+    /* close the old descriptor */
>+    close(opp->fd);
>+
>+    if (create_open_pic_device(opp, errp) < 0) {
>+        return -1;
>+    }
>+
>+    if (!opp->mapped) {
>+        return 0;
>+    }
>+
>+    reg_base =3D opp->mapped;
>+    attr=2Egroup =3D KVM_DEV_MPIC_GRP_MISC;
>+    attr=2Eattr =3D KVM_DEV_MPIC_BASE_ADDR;
>+    attr=2Eaddr =3D (uint64_t)(unsigned long)&reg_base;
>+
>+    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
>+    if (ret < 0) {
>+        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
>+                strerror(errno), reg_base);

Why not use error_set*()?

Best regards,
Bernhard

>+        return -1;
>+    }
>+
>+    CPU_FOREACH(cs) {
>+        ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_MPIC, 0, opp->fd,
>+                                   kvm_arch_vcpu_id(cs));
>+        if (ret < 0) {
>+            return ret;
>+        }
>+    }
>+
>+    return 0;
>+}
>+
> static void kvm_openpic_region_add(MemoryListener *listener,
>                                    MemoryRegionSection *section)
> {
>@@ -197,37 +275,14 @@ static void kvm_openpic_realize(DeviceState *dev, E=
rror **errp)
>     SysBusDevice *d =3D SYS_BUS_DEVICE(dev);
>     KVMOpenPICState *opp =3D KVM_OPENPIC(dev);
>     KVMState *s =3D kvm_state;
>-    int kvm_openpic_model;
>-    struct kvm_create_device cd =3D {0};
>-    int ret, i;
>+    int i;
>=20
>     if (!kvm_check_extension(s, KVM_CAP_DEVICE_CTRL)) {
>         error_setg(errp, "Kernel is lacking Device Control API");
>         return;
>     }
>=20
>-    switch (opp->model) {
>-    case OPENPIC_MODEL_FSL_MPIC_20:
>-        kvm_openpic_model =3D KVM_DEV_TYPE_FSL_MPIC_20;
>-        break;
>-
>-    case OPENPIC_MODEL_FSL_MPIC_42:
>-        kvm_openpic_model =3D KVM_DEV_TYPE_FSL_MPIC_42;
>-        break;
>-
>-    default:
>-        error_setg(errp, "Unsupported OpenPIC model %" PRIu32, opp->mode=
l);
>-        return;
>-    }
>-
>-    cd=2Etype =3D kvm_openpic_model;
>-    ret =3D kvm_vm_ioctl(s, KVM_CREATE_DEVICE, &cd);
>-    if (ret < 0) {
>-        error_setg(errp, "Can't create device %d: %s",
>-                   cd=2Etype, strerror(errno));
>-        return;
>-    }
>-    opp->fd =3D cd=2Efd;
>+    create_open_pic_device(opp, errp);
>=20
>     sysbus_init_mmio(d, &opp->mem);
>     qdev_init_gpio_in(dev, kvm_openpic_set_irq, OPENPIC_MAX_IRQ);
>@@ -236,6 +291,9 @@ static void kvm_openpic_realize(DeviceState *dev, Err=
or **errp)
>     opp->mem_listener=2Eregion_del =3D kvm_openpic_region_del;
>     opp->mem_listener=2Ename =3D "openpic-kvm";
>     memory_listener_register(&opp->mem_listener, &address_space_memory);
>+    opp->open_pic_vmfd_change_notifier=2Enotify =3D
>+        open_pic_vmfd_handle_vmfd_change;
>+    kvm_vmfd_add_change_notifier(&opp->open_pic_vmfd_change_notifier);
>=20
>     /* indicate pic capabilities */
>     msi_nonbroken =3D true;

