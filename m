Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D63D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 22:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlads-00081N-Rw; Thu, 29 Jan 2026 17:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vladf-0007vl-7E
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 17:37:23 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vladc-0006uB-JC
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 17:37:23 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so823099f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769726238; x=1770331038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knX8WBky18FYrZOaxcj/QfAiOS28/HQkTdx1yFPFne0=;
 b=BTkOFYJlKE4KEa/QgMmiK9okUbXwWRnbmUaSB+3uHxJOu4nyEVbrp//tA6U2VgbhOl
 yVvnMf6jvY6bwW+7K/6i1oott1PSWDbbqhk22SxVf+78ydhtig30UcLqsJTEp7EaTlua
 rcGIxN5cG8aA7iURfxHqhI6nR8KAYNUkFaBN1b2Uhm4N1cKeTfGDj2hZ1iU9xnFId/hi
 G4KTyvqhIqIEhi9CHPvpm4hRfz1Y/t+Dj4V/RDgrIC9NFM/ckHY4BVNsG/76tYu0pXEr
 gR9s+PfS3BQNzF3JG6hsPl/BNzL0MSUNwubRz22JKyuMtQYTszFiCWtpg9qRC2SjCYeB
 ZUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769726238; x=1770331038;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=knX8WBky18FYrZOaxcj/QfAiOS28/HQkTdx1yFPFne0=;
 b=AJtcvFgRoh6nBJog4i/jikKVGZBubTJlqPN114/rs4WtbkZe4XCRcl/rg0osLUc80z
 z6tzfB9/4VoiIiDjOcSiJZiQ5pMTTLQuTTvxw6NYAiZqgJGlztL5U0otwtE+BItlifJK
 0BP43ZdF7+6jfgm8la1gsUo3duiBNJ4e01Gk3s8gxbfsW8mRrInbeGUBRlVyYhmKUuHS
 3JwjYIcQmWOofYhACvMqVA3neJD1GaC1glhndfhLvGXmGFsN2lnCq+rxnfDpajko4Etn
 Sluerp6yUVPnmo/JZNdfZM6vviOV02BCRTN+0POVgtt0PmBRJv3/SvnBaragaMU+Zetc
 3gIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrdds7dxyqoHW0ifrYwgNPHJbZN/sBYc0ys+EEOfH0PSjNgEiF2wg5/6Zug3NJBLRnL7JYYBESn3bF@nongnu.org
X-Gm-Message-State: AOJu0YywcKCjFUQ+KACc3+8QdRmGpV49Xx4ZPjsOJPnIKrT23eLKV3xG
 yDgRDEwhSzffvW0Vi7TmcKa2p0Yhdhoe5aCDqhkKDmlKjYFbKj4+4MB7
X-Gm-Gg: AZuq6aIo2Smp89jTY9KWfF0jU4k25seDgFiTZo6HkQX2CXX2so1V+MtO57c/3VXBhCB
 FZWZeJ+MMPu1ReQb4XFnkbuXm48Lvkq4tNHwhSoIBbLAh1G/Kcbd6lHgdpN+DWGDEegdIxE/Vi0
 IewcrOghjLlRY/0nEdIV71F/mMT1jOB/3RmdeLfHv9B+GAFaeaXqWtaKUJfWvmpkqIZDvK9cCe5
 3r+fuOYHj+8yC7kupoFXDPpr6fI4swELe3AEJvq97rRlAsqC3pIhwlp54iqobH2YVh5pMzWyTIi
 zww5XD223WrUVxtxu7drqWPnwmFiMw1eTMyuHrmB+TWiPeoVT6aKL2YMNzr9tHXtBezZMUvpQmI
 v/uXgc5Dl+I+dmLzV5gA/wlNb8jn0kEG2xXoLJvG2zjEDaTwaRagsCZJJy1f/b02z/LbrR499pO
 JupM0h7J5mt4/CsMV0A95Ro1EpiPw6eJAN47RMpOPqtDaMX6ZR9h2OAd/pI9gnANllPH7N1H3zY
 x7gx21c0TS2q/pBRjOp7APYMoqQ3zEAGzA=
X-Received: by 2002:a05:6000:2910:b0:432:ca6c:7b03 with SMTP id
 ffacd0b85a97d-435f3a88011mr1583745f8f.26.1769726238078; 
 Thu, 29 Jan 2026 14:37:18 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2fc2-2300-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:2fc2:2300:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm18634842f8f.42.2026.01.29.14.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 14:37:17 -0800 (PST)
Date: Thu, 29 Jan 2026 22:37:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Ani Sinha <anisinha@redhat.com>
CC: kraxel@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_28/33=5D_ppc/openpic=3A_create_a_new_op?=
 =?US-ASCII?Q?enpic_device_and_reattach_mem_region_on_coco_reset?=
In-Reply-To: <20260127051612.219475-29-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-29-anisinha@redhat.com>
Message-ID: <D5C8D3F1-713B-4C13-A90D-0EFC65DDB065@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
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



Am 27=2E Januar 2026 05:15:56 UTC schrieb Ani Sinha <anisinha@redhat=2Ecom=
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
> hw/intc/openpic_kvm=2Ec | 112 +++++++++++++++++++++++++++++++++---------
> 1 file changed, 88 insertions(+), 24 deletions(-)
>
>diff --git a/hw/intc/openpic_kvm=2Ec b/hw/intc/openpic_kvm=2Ec
>index fbf0bdbe07=2E=2Eb099da20eb 100644
>--- a/hw/intc/openpic_kvm=2Ec
>+++ b/hw/intc/openpic_kvm=2Ec
>@@ -49,6 +49,7 @@ struct KVMOpenPICState {
>     uint32_t fd;
>     uint32_t model;
>     hwaddr mapped;
>+    NotifierWithReturn vmfd_change_notifier;
> };
>=20
> static void kvm_openpic_set_irq(void *opaque, int n_IRQ, int level)
>@@ -114,6 +115,88 @@ static const MemoryRegionOps kvm_openpic_mem_ops =3D=
 {
>     },
> };
>=20
>+static int kvm_openpic_setup(KVMOpenPICState *opp, Error **errp)
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
>+static int kvm_openpic_handle_vmfd_change(NotifierWithReturn *notifier,
>+                                          void *data, Error **errp)
>+{
>+    KVMOpenPICState *opp =3D container_of(notifier, KVMOpenPICState,
>+                                        vmfd_change_notifier);
>+    uint64_t reg_base;
>+    struct kvm_device_attr attr;
>+    CPUState *cs;
>+    int ret;
>+
>+    /* we are not interested in pre vmfd change notification */
>+    if (((VmfdChangeNotifier *)data)->pre) {
>+        return 0;
>+    }
>+
>+    /* close the old descriptor */
>+    close(opp->fd);
>+
>+    if (kvm_openpic_setup(opp, errp) < 0) {
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
>+        error_setg(errp, "%s: %s %" PRIx64, __func__,
>+                   strerror(errno), reg_base);
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
>@@ -197,36 +280,14 @@ static void kvm_openpic_realize(DeviceState *dev, E=
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
>-        error_setg_errno(errp, errno, "Can't create device %d", cd=2Etyp=
e);
>-        return;
>-    }
>-    opp->fd =3D cd=2Efd;
>+    kvm_openpic_setup(opp, errp);
>=20
>     sysbus_init_mmio(d, &opp->mem);
>     qdev_init_gpio_in(dev, kvm_openpic_set_irq, OPENPIC_MAX_IRQ);
>@@ -235,6 +296,9 @@ static void kvm_openpic_realize(DeviceState *dev, Err=
or **errp)
>     opp->mem_listener=2Eregion_del =3D kvm_openpic_region_del;
>     opp->mem_listener=2Ename =3D "openpic-kvm";
>     memory_listener_register(&opp->mem_listener, &address_space_memory);
>+    opp->vmfd_change_notifier=2Enotify =3D
>+        kvm_openpic_handle_vmfd_change;
>+    kvm_vmfd_add_change_notifier(&opp->vmfd_change_notifier);
>=20
>     /* indicate pic capabilities */
>     msi_nonbroken =3D true;

Code seems structurally comprehensible to me, so:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


