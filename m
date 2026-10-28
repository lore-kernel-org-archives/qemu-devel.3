Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE995606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ny8CjYoP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7YC-0008C8-VL; Wed, 28 Oct 2026 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xM7YB-0008Bs-Kq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:34:59 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xM7Y8-00066B-V4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:34:59 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-93e4d8e4e99so22380885a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208896; cv=none;
 d=google.com; s=arc-20260327;
 b=FAS5B8FVnEw8CD2l/oiz1azAc1TiUPCQ/MwTD2/fkKLbL8r8dGQmNBBl8VYbtnnjst
 1dQmpA1Ju+PtUN/WHGzmP9YCGalIqPbiu6GhHMxDvttAq1IRuj2dZJ5GrLeTG1s0z9dh
 njfSWSkE0h44vJ8MtDwfAQb3puKTxtZ95DK7iGFYjP/R1DyzfgPWMfHPp6M8FsHAOpjB
 dXND5akFhGP0TPiTx+HJ0ueNN7bo35jZFdfDXhUPqmP+YxbxJMd9tm73HwHOiSpgt237
 KNxWAA8hZEdQeSr5wBTFTbOkiOSe4RYc3nfRoe8b6KGmW8ggoXwtKUCD2yb3MNVsJ0BM
 iAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+/I6GAg42y/JCX0tFjBzfoL/IA+6dnFqZuBc4HA9eNs=;
 fh=RghdQJaqLmwyGzXyO20lcj7b4F1QxCdsFJhFoIBAFvE=;
 b=h/cC7Xkdnweig16Ese3whxla6LlQNisNqqK4WttpU5GKlg2YdkS9DpwZ8mcybemZ3h
 GFm9bXNADvwtatEgxd0rZCd/v4+nRFsHSOFjGGRQCg6v6VZjwBi0tHcJrvOnnpSuwSq7
 eh8ysNqZN7qpulJpWbSeAWiBja8EEoFh2aNSW7kSz3FIFpUmx99GARnTYhnF6zaB8vbw
 iMwezJaRMBxxWNCCYav7OUM+9t+oMX72/Hegd+5n7Alv0r4uEH+w/2IyCXBV3GuCUZGj
 bwvKWqb55DWc6hzruQ+YtARDFVWbYpaCeW0CN1Hd7ONjmO5Kw85MvfYO5DPQ+FM0IekB
 1GkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793208896; x=1793813696; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+/I6GAg42y/JCX0tFjBzfoL/IA+6dnFqZuBc4HA9eNs=;
 b=ny8CjYoPQGszslboeOWjwCP44lkQuhjQl3ST+xM6UGfp5ZCY2nikhCWBq61olx87WY
 jBIChV2lJ95Y9dB+6OuC6ApNofsHG+LBTUgPg5eI+Mr8JvZqDfj/J+OJGhN1bSh7qbWt
 yP5XJaVxFBK23DQzm3cucBA45I92zNt2TXkuVHAJrR9avcSh+LEgOz4sugKj0/VgNcYf
 TYYm9i93nia4QQaGlc/fSAAHEXP/aUy+yF/CtAhU+aN2aZtnEHPKq999hGUhCObuICdP
 aFLnPvL9G7QvPK6tfPF0746M4N5mBHWMkU2deCSsoZRA513gcXfY7MppsVZ52x3mRVpo
 u6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793208896; x=1793813696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+/I6GAg42y/JCX0tFjBzfoL/IA+6dnFqZuBc4HA9eNs=;
 b=DRgJKv9Zyu9DXVZ/B9fOzu6VL/h759nYSl0QIgIMUI5584HpRKarQXZ56yY23x/JMO
 tlzoyMKePejBotPCElUC7Mehf6htyOTsadHZ48TvkY47ZFJDQWQMnf9e9DbPjV9ECZ2y
 5sbWcI7wKXNoPw/jOOr5xpDDQuNDkYdMUOA5PAtPfzkmtElpZgg3YuWsnw7sEeXww20S
 76d9egkucfiAIxcgM8JfByXvQwx0m7qT8FRmfs3GAGi9m5CeUdIuE5SZs8bZFB8wa3R+
 om/uDp1NZcbAdEb8wAGqD3ELzrQf3X/jhffQfC89S8zB5d9ioWSZVrTi36mWbNyXBOqm
 9RjA==
X-Gm-Message-State: AFq9FYJy71sHS94unjMhdtkhMotHkBnUC0v7ry1gfHD7UcQPByI1GwUz
 oYIyO0XKMKPas6n9QPIvt0ArwoR3Sprzf1lIknTaL+hHqyCWyNKLXBXh3G9FoR+qeZP2s1xvM0e
 fGynhjwfpnweUNDze4HwTI48KZ19HwSA=
X-Gm-Gg: AYBFou3SU3PwEy0BlJz8u6xcmkdzKruBZB7+fKvMVB+bEE+qcAVrDfbuEAzTwajL6XI
 Dt6Kl7S3o5g7pxe6Vf+yRTVAhdkaLxkw5pFhU7U10V4b3I3ddniZDrxX5dhJFTSqE52A0fCvroQ
 rxXDxn+D2TWlh4IUiAPDlZUbkH3CBang75LPWG36pI1OOh7SMB/vZ/UEswwXdUaqWyWYr1BoInh
 P0r6yvXnCXDEnEU1XANdXHZYIiUUx9VE1z+GZcp/jF1sVCv0nfZx7SZGi5SyvTbFWTjYGDU+qw1
 mdo7LtUSM/3KphKn5HgN5R/UFJVH9GIWvvk4KlqvAc0GQnx7Yx54Xj+6yIcgcvhRHCzkCBT6SfJ
 QCCeMHowrkgnNfNeMOYLEElC/axOMJSckFZlkowZWZmbtcB2jWCb3UW0DoN7azvDrWfuZyv4ac3
 4Wz6s3C7dGn13mw1mjQJLMtvL7v4M=
X-Received: by 2002:a05:6214:29c2:b0:91c:7644:6b40 with SMTP id
 6a1803df08f44-91c7d1e0ef1mr64099706d6.3.1793208895449; Wed, 28 Oct 2026
 10:34:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793207602.git.mst@redhat.com>
 <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
In-Reply-To: <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Wed, 28 Oct 2026 18:34:44 +0100
X-Gm-Features: AclHuK-O8iCbUuw4CHbA3q2_ujTFN-XZL0YJeqAfW6M1PmXDlwomqnVhvinmd6Y
Message-ID: <CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com>
Subject: Re: [PULL 40/78] pcie_sriov: register user created virtual function
 before realizing it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qk1-x732.google.com
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

Hello Michael,

I think you have queued this patch for pulling on accident. There is a bug here,
which is yet to be solved, as you have pointed out in

https://lore.kernel.org/qemu-devel/20261028074508-mutt-send-email-mst@kernel.org/T/#mca344ac148a62107cdc298e97e6713b6657b5c55

Please, hold off this patch for a while, until I come up with a fix soon.

Thank you,
Daniel

On Wed, 28 Oct 2026 at 18:15, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Daniel Paziyski <danielpaziyski@gmail.com>
>
> There are two ways of creating virtual functions: by using the sriov-pf device
> parameter (this way, creating a user created VF and binding it to a PF), or
> by using a device specific parameter, where the device manually creates a given
> amount of VFs.
>
> When a PCI device is realized, the device specific realize function is called
> first, and then the pcie_sriov_register_device function is called, which checks
> whether the device that has been created is a user created VF, and if it is the
> case and the device allows this kind of VFs, it inserts it into a hashmap, with
> the key being the ID of the PF, and the items being arrays of VFs.
>
> User created VFs are instantiated independently, and later, when the PF calls
> pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
> mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
> the pointer to the PF. This means that, during realization, VFs have no access
> to the PF.
>
> Device created VFs are instantiated during or after PF realization using the
> pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
> before their realization, so when they're realized, they can access the PF
> with no issues.
>
> The problem here is that pcie_sriov_register_device is called after the
> realization, and not before. This means that when a user created VF is created
> for a device which does not support user created VFs, but supports device
> created VFs, the realize function will notice that a VF is being created, and
> may try to access the PF, causing a null pointer dereference fault.
>
> Fix this by placing the user created VF check and registering before the
> realization. This way, incorrectly created user created VFs will be noticed,
> and device creation will be aborted.
>
> Additionally, remove from the pcie_sriov_register_device function the top
> check. It seems that this check is done to error out if the PF failed for some
> reason to initialize its list of user created VFs. However, in such situations,
> the pcie_sriov_pf_init_from_user_created_vfs function will error during
> realization, and it will be caught before the check is done at all. Moreover,
> since now pcie_sriov_register_device is called before realization, the check
> will always fail for PFs with user created VFs, because the list will be
> populated during realization.
>
> The rest of the function though, correctly errors out if a user created VF
> is created for an unsupported device type, if a VF is created for a non-PCIe
> device, or if the PF is already instantiated, with now the advantage being
> that the check is done before the VF instantiation.
>
> Moreover, move the unregistering of a device's acpi-index and the removal
> of a VF from its PF list from pci_qdev_unrealize to do_pci_unregister_device.
> We do the former so that the acpi-index is unclaimed on user created VF
> creation error, and the latter to not have extra code on the device specific
> realization error path.
>
> When instantiating a user created VF for a NVME controller:
>
> Command line:
>
>     qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
>     -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
>     -device nvme,id=ctrl0,subsys=subsys0,serial=s
>
> ASAN splat:
>
> ../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
> ==91050==The signal is caused by a READ memory access.
>     #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>     #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
>     #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
>     #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
>     #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
>     #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
>     #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
>     #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
>     #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
>     #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
>     #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
>     #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
>     #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
>     #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
>     #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
>     #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
>     #16 0x5644c801abf8 in main ../system/main.c:71
>     #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>     #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>     #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)
>
> ==91050==Register values:
> rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
> rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
>  r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
> r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> ==91050==ABORTING
>
> Cc: qemu-stable@nongnu.org
> Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
> Message-ID: <20260905122924.53813-1-danielpaziyski@gmail.com>
> ---
>  hw/pci/pci.c        | 42 ++++++++++++++++++++++++------------------
>  hw/pci/pcie_sriov.c |  6 ------
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0efb4eb4bb..2d2fe02c68 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1227,6 +1227,19 @@ static void pci_config_free(PCIDevice *pci_dev)
>      g_free(pci_dev->used);
>  }
>
> +static void pci_unregister_acpi_index(PCIDevice *pci_dev)
> +{
> +    if (pci_dev->acpi_index) {
> +        GSequence *used_indexes = pci_acpi_index_list();
> +
> +        g_sequence_remove(g_sequence_lookup(used_indexes,
> +                          GINT_TO_POINTER(pci_dev->acpi_index),
> +                          g_cmp_uint32, NULL));
> +
> +        pci_dev->acpi_index = 0;
> +    }
> +}
> +
>  static void do_pci_unregister_device(PCIDevice *pci_dev)
>  {
>      pci_get_bus(pci_dev)->devices[pci_dev->devfn] = NULL;
> @@ -1240,6 +1253,9 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
>                                      &pci_dev->bus_master_enable_region);
>      }
>      address_space_destroy(&pci_dev->bus_master_as);
> +
> +    pcie_sriov_unregister_device(pci_dev);
> +    pci_unregister_acpi_index(pci_dev);
>  }
>
>  /* Extract PCIReqIDCache into BDF format */
> @@ -1491,7 +1507,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
>
>      pci_unregister_io_regions(pci_dev);
>      pci_del_option_rom(pci_dev);
> -    pcie_sriov_unregister_device(pci_dev);
>
>      if (pc->exit) {
>          pc->exit(pci_dev);
> @@ -1501,17 +1516,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
>      do_pci_unregister_device(pci_dev);
>
>      pci_dev->msi_trigger = NULL;
> -
> -    /*
> -     * clean up acpi-index so it could reused by another device
> -     */
> -    if (pci_dev->acpi_index) {
> -        GSequence *used_indexes = pci_acpi_index_list();
> -
> -        g_sequence_remove(g_sequence_lookup(used_indexes,
> -                          GINT_TO_POINTER(pci_dev->acpi_index),
> -                          g_cmp_uint32, NULL));
> -    }
>  }
>
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> @@ -2326,8 +2330,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>      pci_dev = do_pci_register_device(pci_dev,
>                                       object_get_typename(OBJECT(qdev)),
>                                       pci_dev->devfn, errp);
> -    if (pci_dev == NULL)
> +    if (pci_dev == NULL) {
> +        pci_unregister_acpi_index(pci_dev);
>          return;
> +    }
> +
> +    if (!pcie_sriov_register_device(pci_dev, errp)) {
> +        do_pci_unregister_device(pci_dev);
> +        return;
> +    }
>
>      if (pc->realize) {
>          pc->realize(pci_dev, &local_err);
> @@ -2338,11 +2349,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          }
>      }
>
> -    if (!pcie_sriov_register_device(pci_dev, errp)) {
> -        pci_qdev_unrealize(DEVICE(pci_dev));
> -        return;
> -    }
> -
>      /*
>       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>       * associate only Device 0 with the device attached to the bus
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index c41ac95bee..69930c7b8c 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
>
>  bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
>  {
> -    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
> -        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
> -        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
> -        return false;
> -    }
> -
>      if (dev->sriov_pf) {
>          PCIDevice *pci_pf;
>          GPtrArray *pf;
> --
> MST
>

