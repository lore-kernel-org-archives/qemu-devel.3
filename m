Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50898606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4vZsOtk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Q6-00074h-RB; Wed, 28 Oct 2026 13:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xM7Q5-00074P-0l
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:26:37 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xM7Q2-0005M8-HX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:26:36 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-5412af497c2so45261cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208393; cv=none;
 d=google.com; s=arc-20260327;
 b=IZrr7NwQou/e+PFeN0ZQu1c90MQx4O8U+ziYPztsJeXU7A4PrcvGVdaGfOYlQUtm3h
 HfK8EpF8iNT5EdvqrJrsDCzZRlnvBc9cOeFouiZVi9uLBn0fH8W3fvMkAfbBoG2K2RyW
 3A+8BBkPOMpaXEPbymr083gnrbg3JKOcDEpNMQPYyi+zRyEcSYeUWY9voV2wJKVZgBEV
 tmO0uk7IkQo+SJpqbqzuRiUdgf2G7ZKBjun9/888oagfORbJhc7SnbhLKfPSpuQEKP9i
 XD0hsemcBEUTxPOiyeNwqAcObJwZ5Xe/wNOI90Nvq4Ai18JupsrAOwlfNvVVhvH2oq/S
 EmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AhwAT6bRmhp0EKumNfH2dznxuMCuij7gmGMOCmP8Ryg=;
 fh=S5hUlmj9BqKVfguZkvkkD0j/A7iWpZcdEsor6pQMcTU=;
 b=AQwlYpyWTkHMtm9O5KpJr908NvzIvNxKDKy1uJ4wQcnOapvHFaOkdfalBs+31PKVSf
 JGLCdWf36RzG97lP4sOq4Ad6n2A3+UIu5OhmycPk9QECu07PtrWF4rWz8igNg/6Zz9Hj
 p+EzkEbuoqLwD+fdYpgLzJDGKSR/SPJttpJyasaiaSqTtWk9HdOcsfyocCQ/+o8bl8bA
 6ZG5jZjAMWaUTZpBfbrAS6/o16EoBTCYfvmdfOIK8AgNKAY2Bf0XOXeBMlR/LgC8JMNk
 Eob88XjtantDtb4iylRB8bLGXoGibwSOopyZLzSsemRCGtVTTA6FcG9T5gdYa0P1z8lI
 gfjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793208393; x=1793813193; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AhwAT6bRmhp0EKumNfH2dznxuMCuij7gmGMOCmP8Ryg=;
 b=f4vZsOtkj+XLG5hhggR5M7tJS9ZxvlkhDjY+C1wlyA9tQislwy5zQgy5Ibxb5PNbFy
 XVF1IXuGxy/J43ILWcl4ibZPorsuxSiMKDBYYKQiIDml33PF25ri73BmuU52oR3SOdCX
 Ykr64wYSMOzlJnSxdGBbDtBLJ8Zoz+j4vA2Zb+bm07xtlu28bEldJZCPGmo5rdM/XvD2
 G+8tGdoLkGO5DhtQexkkenm2vdTvDOKAxQ8DaMDTNWv7oo0/2c9sWZeRFfXG5VYbU/9g
 yYp8nrRAyrQVUSXtSH/n2Hyfh7wmvz78woTkxHD2wnQjebJvr5cULD8xerA+bSRdkLrV
 j6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793208393; x=1793813193;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AhwAT6bRmhp0EKumNfH2dznxuMCuij7gmGMOCmP8Ryg=;
 b=Ll3U5n27RF03JQdBafvE4RNzfJx5baeoAfooH24ZmcF6NFeGtna3KMfVYuz1ANAAo/
 N21SR3o3tB3RYf762dA2H50X1snmcRGIz7L2/hrciB6kD5siqTRLBqzQs99OV7y74G+g
 jSFJEeZH9tFszJ8vN8Mh8EgF5oHK0NOUkmDp874y6nRqomh/XyC0GtsqOIH957k7fevT
 cIqVGTwaAAvBR420/0/HKItnN3sTFFIvMXF+DvqgEJvDMCLjTVRbYcluWkzWDB4KkY0j
 9qBMtBcJXuUBg8TZ6c3SkxuH0ShBouwuyABXI7mD/HzKNQWfobKgjR53nW+7wFO4pH7O
 /piA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdTpfEouCoeFS8sVhkO/oaKXHsr6XTZkj/LupluLLvP9ZmumRXUK/jS0TV+1gzdeTGLK9udsHuyQw6@nongnu.org
X-Gm-Message-State: AFq9FYJUl8rk4ez8awaAianBN5EymQJg0OxEX9tIrLXD2y718jl5+7yV
 KbPY/HwUGVtoTyYau7IwuwFLgdCkPwWkmA5WF+r5N8O7Joy0F4ReTUEWNamk1HWMRLDc4Zhorxg
 RKJ5IjvGtn60f1NmzSmDP/0pwQu7pi7GV2w==
X-Gm-Gg: AYBFou3D450raI6cie0Ui94mjeWP88+XItgtd25kRC/v3548eyomi3dTcbF3VZGNd3V
 UiIx9zqd+b6n/QPCS6lJ4mbkwcSyEavbiSnr0mO/3jiyujPtbELTIsJ6/hTRm1Hv9wmr71F0jlC
 x7u2Z1nYoW4tFjmKRWmdWWsoW0iQETP7f9kI4RPaWqjxSI71nTic4gms1nyK0InigTYyLsQ/BcF
 PStr7+0e8DIbnTKHLAwfb01WbDZerzbryo8149v88pKl/kYObSq6/zdM2pDaNo41O2cIsI5T408
 5ybJxoDFlwQzAo4nctsimnvoMXUTT1QmJg9hjltIWniIDLKJgF9fkBeaMKIHSziY/f2lWiKBcc+
 ETJshgxwvRd5D2jKKH9h8/xyYJ2chtPnSVJmjIyDV6wQ/eJS+W34ZdoTlV+0UfE1ZHeGyWI6G8s
 pa5M+zojA2ovxxiQXgTimD0aXKx/A=
X-Received: by 2002:a05:6214:411b:b0:91c:715d:dec4 with SMTP id
 6a1803df08f44-91c7cba287amr67524056d6.0.1793208393083; Wed, 28 Oct 2026
 10:26:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260905122924.53813-1-danielpaziyski@gmail.com>
 <20261028074508-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261028074508-mutt-send-email-mst@kernel.org>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Wed, 28 Oct 2026 18:26:20 +0100
X-Gm-Features: AclHuK_QJWmnNyLUle9g1JFmLDUNOzbeIOwWXMK1nmedSA2WpdWqOXuVeJzYy5E
Message-ID: <CANukVxvHLKxTr1KJ5ZWVfo_iOOQL-Adw_GVyaOzNRjeViZRGWA@mail.gmail.com>
Subject: Re: [PATCH] pcie_sriov: register user created virtual function before
 realizing it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-stable@nongnu.org, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qt1-x830.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 12:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Sep 05, 2026 at 02:29:24PM +0200, Daniel Paziyski wrote:
> > There are two ways of creating virtual functions: by using the sriov-pf device
> > parameter (this way, creating a user created VF and binding it to a PF), or
> > by using a device specific parameter, where the device manually creates a given
> > amount of VFs.
> >
> > When a PCI device is realized, the device specific realize function is called
> > first, and then the pcie_sriov_register_device function is called, which checks
> > whether the device that has been created is a user created VF, and if it is the
> > case and the device allows this kind of VFs, it inserts it into a hashmap, with
> > the key being the ID of the PF, and the items being arrays of VFs.
> >
> > User created VFs are instantiated independently, and later, when the PF calls
> > pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
> > mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
> > the pointer to the PF. This means that, during realization, VFs have no access
> > to the PF.
> >
> > Device created VFs are instantiated during or after PF realization using the
> > pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
> > before their realization, so when they're realized, they can access the PF
> > with no issues.
> >
> > The problem here is that pcie_sriov_register_device is called after the
> > realization, and not before. This means that when a user created VF is created
> > for a device which does not support user created VFs, but supports device
> > created VFs, the realize function will notice that a VF is being created, and
> > may try to access the PF, causing a null pointer dereference fault.
> >
> > Fix this by placing the user created VF check and registering before the
> > realization. This way, incorrectly created user created VFs will be noticed,
> > and device creation will be aborted.
> >
> > Additionally, remove from the pcie_sriov_register_device function the top
> > check. It seems that this check is done to error out if the PF failed for some
> > reason to initialize its list of user created VFs. However, in such situations,
> > the pcie_sriov_pf_init_from_user_created_vfs function will error during
> > realization, and it will be caught before the check is done at all. Moreover,
> > since now pcie_sriov_register_device is called before realization, the check
> > will always fail for PFs with user created VFs, because the list will be
> > populated during realization.
> >
> > The rest of the function though, correctly errors out if a user created VF
> > is created for an unsupported device type, if a VF is created for a non-PCIe
> > device, or if the PF is already instantiated, with now the advantage being
> > that the check is done before the VF instantiation.
> >
> > Moreover, move the unregistering of a device's acpi-index and the removal
> > of a VF from its PF list from pci_qdev_unrealize to do_pci_unregister_device.
> > We do the former so that the acpi-index is unclaimed on user created VF
> > creation error, and the latter to not have extra code on the device specific
> > realization error path.
> >
> > When instantiating a user created VF for a NVME controller:
> >
> > Command line:
> >
> >     qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
> >     -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
> >     -device nvme,id=ctrl0,subsys=subsys0,serial=s
> >
> > ASAN splat:
> >
> > ../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
> > AddressSanitizer:DEADLYSIGNAL
> > =================================================================
> > ==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
> > ==91050==The signal is caused by a READ memory access.
> >     #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >     #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
> >     #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
> >     #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
> >     #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
> >     #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
> >     #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
> >     #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
> >     #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
> >     #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
> >     #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
> >     #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
> >     #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
> >     #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
> >     #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
> >     #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
> >     #16 0x5644c801abf8 in main ../system/main.c:71
> >     #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >     #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >     #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)
> >
> > ==91050==Register values:
> > rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
> > rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
> >  r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
> > r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
> > AddressSanitizer can not provide additional info.
> > SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> > ==91050==ABORTING
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
> > Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
>
> /scm/qemu/build/qemu-system-x86_64 -nodefaults -machine q35 -device
> e1000e,addr=0.0 -device e1000e,addr=0.0
>
> crashes with this:
>
> - With the patch: SIGSEGV (exit 139), backtrace at hw/pci/pci.c:2334 in pci_qdev_realize.
> - Without the patch: exit 1: PCI: slot 0 function 0 not available for e1000e, in use by mch,id=(null).
>
>
>
> > ---
> >
> > This patch is the same as
> > https://lore.kernel.org/qemu-devel/20260901153721.10292-1-danielpaziyski@gmail.com/
> > , which improves the original patch by releasing the acpi-index on failure, as
> > pointed out by Michael S. Tsirkin <mst@redhat.com> on the replies of
> > https://lore.kernel.org/qemu-devel/20260805124519.30054-4-danielpaziyski@gmail.com/
> > ("[PATCH 3/3] pcie_sriov: register user created virtual function before realizing it")
> > posted on the series
> > https://lore.kernel.org/qemu-devel/20260805124519.30054-1-danielpaziyski@gmail.com/
> > ("[PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes").
> >
> > I am sending this as a patch separate from the series, since imo it was a mistake
> > for me to mix unrelated patches on the same series.
> >
> >  hw/pci/pci.c        | 42 ++++++++++++++++++++++++------------------
> >  hw/pci/pcie_sriov.c |  6 ------
> >  2 files changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index c15f2b9f08..06c432292f 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1223,6 +1223,19 @@ static void pci_config_free(PCIDevice *pci_dev)
> >      g_free(pci_dev->used);
> >  }
> >
> > +static void pci_unregister_acpi_index(PCIDevice *pci_dev)
> > +{
> > +    if (pci_dev->acpi_index) {
> > +        GSequence *used_indexes = pci_acpi_index_list();
> > +
> > +        g_sequence_remove(g_sequence_lookup(used_indexes,
> > +                          GINT_TO_POINTER(pci_dev->acpi_index),
> > +                          g_cmp_uint32, NULL));
> > +
> > +        pci_dev->acpi_index = 0;
> > +    }
> > +}
> > +
> >  static void do_pci_unregister_device(PCIDevice *pci_dev)
> >  {
> >      pci_get_bus(pci_dev)->devices[pci_dev->devfn] = NULL;
> > @@ -1236,6 +1249,9 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
> >                                      &pci_dev->bus_master_enable_region);
> >      }
> >      address_space_destroy(&pci_dev->bus_master_as);
> > +
> > +    pcie_sriov_unregister_device(pci_dev);
> > +    pci_unregister_acpi_index(pci_dev);
> >  }
> >
> >  /* Extract PCIReqIDCache into BDF format */
> > @@ -1487,7 +1503,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
> >
> >      pci_unregister_io_regions(pci_dev);
> >      pci_del_option_rom(pci_dev);
> > -    pcie_sriov_unregister_device(pci_dev);
> >
> >      if (pc->exit) {
> >          pc->exit(pci_dev);
> > @@ -1497,17 +1512,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
> >      do_pci_unregister_device(pci_dev);
> >
> >      pci_dev->msi_trigger = NULL;
> > -
> > -    /*
> > -     * clean up acpi-index so it could reused by another device
> > -     */
> > -    if (pci_dev->acpi_index) {
> > -        GSequence *used_indexes = pci_acpi_index_list();
> > -
> > -        g_sequence_remove(g_sequence_lookup(used_indexes,
> > -                          GINT_TO_POINTER(pci_dev->acpi_index),
> > -                          g_cmp_uint32, NULL));
> > -    }
> >  }
> >
> >  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> > @@ -2318,8 +2322,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >      pci_dev = do_pci_register_device(pci_dev,
> >                                       object_get_typename(OBJECT(qdev)),
> >                                       pci_dev->devfn, errp);
> > -    if (pci_dev == NULL)
> > +    if (pci_dev == NULL) {
> > +        pci_unregister_acpi_index(pci_dev);
>
> So this passes NULL to pci_unregister_acpi_index.
>

Ouch! This is embarrassing. Will send a V2 soon.

Daniel

>
>
> >          return;
> > +    }
> > +
> > +    if (!pcie_sriov_register_device(pci_dev, errp)) {
> > +        do_pci_unregister_device(pci_dev);
> > +        return;
> > +    }
> >
> >      if (pc->realize) {
> >          pc->realize(pci_dev, &local_err);
> > @@ -2330,11 +2341,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >          }
> >      }
> >
> > -    if (!pcie_sriov_register_device(pci_dev, errp)) {
> > -        pci_qdev_unrealize(DEVICE(pci_dev));
> > -        return;
> > -    }
> > -
> >      /*
> >       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> >       * associate only Device 0 with the device attached to the bus
> > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > index c41ac95bee..69930c7b8c 100644
> > --- a/hw/pci/pcie_sriov.c
> > +++ b/hw/pci/pcie_sriov.c
> > @@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
> >
> >  bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
> >  {
> > -    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
> > -        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
> > -        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
> > -        return false;
> > -    }
> > -
> >      if (dev->sriov_pf) {
> >          PCIDevice *pci_pf;
> >          GPtrArray *pf;
> > --
> > 2.55.0
>

